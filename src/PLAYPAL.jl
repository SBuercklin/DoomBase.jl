const DOOMCOLOR = RGB{N0f8}

function DOOMCOLOR(r::T, g::T, b::T) where {T <: UInt8}
    _r = reinterpret(N0f8, r)
    _g = reinterpret(N0f8, g)
    _b = reinterpret(N0f8, b)
    DOOMCOLOR(_r, _g, _b)
end

struct Palette
    colors::SizedVector{256, DOOMCOLOR, Vector{DOOMCOLOR}}
end
function Palette(colors::Vector{UInt8})
    ncolors = 256
    color_vec = DOOMCOLOR[]
    for n in 1:ncolors
        r, g, b = colors[(1:3) .+ (n-1) * 3]
        push!(color_vec, DOOMCOLOR(r, g, b))
    end

    return Palette(SizedVector{ncolors}(color_vec))
end

function color_from_palette(p::Palette, idx)
    return p.colors[idx + 1] # idx starts from 0, Julia indexes from 0
end

struct PLAYPAL
    palettes::NTuple{14, Palette}
end
