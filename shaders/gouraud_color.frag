#version 300 es

precision mediump float;

in vec3 ambient;
in vec3 diffuse;
in vec3 specular;

uniform vec3 material_color;    // Ka and Kd
uniform vec3 material_specular; // Ks

out vec4 FragColor;

void main() {
	vec3 ambientIntensity = material_color * ambient;
	vec3 diffuseIntensity = vec3(0.0, 0.0, 0.0);
	vec3 specularIntensity = vec3(0.0, 0.0, 0.0);

    FragColor = vec4(ambientIntensity + diffuseIntensity + specularIntensity, 1.0);

}
