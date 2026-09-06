SubViewportDecal is a Decal node that captures a SubViewport's rendered output and projects it's contents onto 3D surfaces as a Texture. 
A few good use-case examples of this are:

-Real-time 3D model Drop-Shadows

<img width="762" height="647" alt="downcastShadow" src="https://github.com/user-attachments/assets/2a574ce3-5997-459f-a82a-90d8328847bd" />

-2D nodes projected onto 3D geometry/ World-space UI

<img width="832" height="694" alt="2dUIworldspace" src="https://github.com/user-attachments/assets/037466b8-eabb-4604-9f57-2133bbddedf1" />

-AND live 3D projections (my favorite)

<img width="902" height="693" alt="live3Dprojection" src="https://github.com/user-attachments/assets/6b723802-fe37-4fe3-8578-6cd3a77d659f" />

You can increase the Frame Break variable to lower the capture framerate (maximum framerate is 60 FPS)
Allows in-editor updating!*

<img width="663" height="712" alt="inspectorExample" src="https://github.com/user-attachments/assets/a7ab3bf2-96bc-47c9-b1ba-16778bc3e5c1" />


*Real-time updating of the Decal's recieved SubViewport textures won't be shown without toggling "Update In Editor", to save memory.
SubViewport sizes larger than 512x512 may cause performance drops on weaker hardware
