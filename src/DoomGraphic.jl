"""
    struct Post

A `Post` defines a vertical sequence of colors according to the active `DOOMPALETTE`. 
"""
struct Post
    topdelta::UInt8
    length::UInt8
    data::Vector{UInt8}
    unused::NTuple{2, UInt8}
end

"""
    struct Column

A `Column` is a collection of `Post`s describing a vertical slice of a Doom Graphic. Any
    pixel not included in a `Post` is transparent.
"""
struct Column
    posts::Vector{Post}
    height::UInt16
    function Column(posts::AbstractVector{Post}, height)
        sposts = sort(posts; by = p -> p.topdelta)

        return new(sposts, height)
    end
end

"""
    struct DoomGraphic

A `DoomGraphic` represents a fundamental graphic determined by its size, offset, and 
    the data `Column`s comprising the graphic. We store the `Column`s explicitly because
    the `Column`s may contain transparencies. 

A `DoomGraphic` can be a `PATCH`, `SPRITE`, or ???
"""
struct DoomGraphic
    width::UInt16
    height::UInt16
    leftoffset::Int16
    topoffset::Int16
    cols::Vector{Column}
end

function Column_to_colors(
    c::Column, pal::Palette, transparency = DOOMCOLOR(UInt8(150), UInt8(0), UInt8(150))
    )
    height = c.height
    colors = fill(transparency, (height,))

    for p in c.posts
        idx0 = p.topdelta + 1
        idxf = idx0 + p.length - 1

        colors[idx0:idxf] .= color_from_palette.(Ref(pal), p.data)
    end

    return colors
end

function DoomGraphic_to_image(
    p::DoomGraphic, pal::Palette, transparency = DOOMCOLOR(UInt8(150), UInt8(0), UInt8(150))
    )
    graphic_image = mapreduce(hcat, p.cols) do col
        Column_to_colors(col, pal, transparency)
    end

    return graphic_image
end