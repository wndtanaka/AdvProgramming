using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BlendingTest : MonoBehaviour
{
    public Material mat;

    private void Update()
    {
        mat.SetFloat("_LerpValue", 1 + Mathf.Sin(Time.time));
    }
}
