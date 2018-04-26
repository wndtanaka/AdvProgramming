using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpotlightProperty : MonoBehaviour
{
    public Material mat;
    public string propertyName;
    public Transform player;
    private void Update()
    {
        if (player!= null)
        {
            mat.SetVector(propertyName, player.position);
        }
    }
}
