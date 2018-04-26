using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Dissolver : MonoBehaviour
{
    public Material dissolveMaterial;

    public float speed, max;

    private float currentY, startTime;

    private void Update()
    {
        // if this is during the animation
        if (currentY < max)
        {
            dissolveMaterial.SetFloat("_DissolveY", currentY);
            currentY += Time.deltaTime * speed;
        }

        if (Input.GetKeyDown(KeyCode.E)) 
        {
            Dissolve();
        }
    }

    void Dissolve()
    {
        startTime = Time.time;
        currentY = 0;
    }
}
