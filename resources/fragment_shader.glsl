#version 430

out vec4 fragColor;

uniform vec2 resolution;
uniform float time;

vec2 rotate2D(vec2 uv, float a){
    float s = sin(a);
    float c = cos(a);
    
    return mat2(c, -s, s, c) *uv;

    }

void main() {
    vec2 uv = (gl_FragCoord.xy - 0.4* resolution.xy) / resolution.y;
    vec3 col = vec3(0.0, 0.0, 0.0);
    //col += 0.01 / length(uv);
    //col += 0.01 / length(uv - vec2(0.25));

    uv = rotate2D(uv, 3.14/2.0);
    //uv = rotate2D(uv, sin(time)*sin(time));

    float r = 0.12;

    for (float i=0.0; i< 30.0; i++)
    {
        float factor = (sin(0.1*time) * 0.5+0.5) + 0.3;
        i += factor;

        float r_factor = sin(0.4*time)*sin(time) + 0.5;

        float a = i/3;
        float dx = 2* r*r_factor * cos(a) - r * cos(2*a);
        float dy = 2 * r*r_factor * sin(a) + r * sin(2*a);

        col += 0.005 *factor/ length(uv - vec2(dx + 0.1, dy));
    }

    col *= sin(vec3(0.2, 0.5, 0.9) * 2*time) * 0.50 + 0.010;
    fragColor = vec4(col, 0.5);
}