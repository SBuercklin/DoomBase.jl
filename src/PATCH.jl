"""
    struct PATCH

A `PATCH` represents a fundamental texture which can be combined with other `PATCH`es
    to form a texture. A `PATCH` is determined by its size, offset, and the data
    comprising indices of the colors in the active `Palette`.
"""
struct PATCH
    width::UInt16
    height::UInt16
    leftoffset::Int16
    topoffset::Int16
    data::Matrix{UInt8}
end