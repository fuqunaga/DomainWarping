using UnityEngine;

[ExecuteAlways]
public class ImageEffect : MonoBehaviour
{
    public Material material;

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if ( material != null)
        {
            Graphics.Blit(source, destination, material);
        }
    }
}
