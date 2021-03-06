#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;
in vec2 vertex_texcoord;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform float material_shininess;
uniform vec2 texture_scale;
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;
out vec2 frag_texcoord;

void main() {
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);
    frag_texcoord = vertex_texcoord * texture_scale;
	
	//ambient
	ambient = light_ambient;
	
	//diffuse
	vec3 v_position = vec3(model_matrix * vec4(vertex_position, 1.0));
    vec3 v_normal = normalize(inverse(transpose(mat3(model_matrix))) * vertex_normal);
	vec3 light_direction = normalize(light_position - v_position);
	diffuse = clamp(light_color * dot(v_normal, light_direction), 0.0, 1.0);
	
	//specular
	vec3 view_direction = normalize(camera_position - v_position); 
	vec3 reflected_direction = normalize(reflect(-light_direction, v_normal));
	specular = light_color * pow(clamp(dot(reflected_direction, view_direction), 0.0, 1.0), material_shininess);

}