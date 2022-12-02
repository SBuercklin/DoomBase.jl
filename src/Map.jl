struct Vertex
    x::Int16
    y::Int16
end

struct LineDef
    start::Int16        # Refers to the index of the vertex in that map's vertexes lump
    terminate::Int16
    flags::Int16
    type::Int16
    tag::Int16
    front_side::Int16   # Refers to index of the sidedef in thaht map's sidedef lump
    back_side::Int16
end

struct Seg
    start::Int16
    terminate::Int16
    angle::Int16
    linedef::Int16
    direction::Int16
    offset::Int16
end

struct Subsector
    seg_count::Int16
    first_seg::Int16
end