using UnityEngine;
using System.Collections;

public class Main : MonoBehaviour {

	private Texture2D packedTexture;
	private string[] textNames = {"gold","heal","shield","skill","sword"};

	void Awake() {

		Material newMaterial = new Material(Shader.Find("Sprites/ClipArea"));

		Texture2D[] textures = new Texture2D[textNames.Length];
		int width = 0;
		int height = 0;
		float deep = 0.01f;
		for(int i = 0; i < textNames.Length; ++i)
		{
			textures[i] = Resources.Load<Texture2D>(textNames[i]);
			width += textures[i].width;
			height += textures[i].height;
		}
		packedTexture = new Texture2D(1024,1024);
		Rect[] uvs = packedTexture.PackTextures(textures,0,1024);

		for(int i = 0; i < uvs.Length; ++i) 
		{
			GameObject gameObject = new GameObject();
			gameObject.name = "item_" + i;
			gameObject.transform.position = new Vector3(-300 + 150 * i ,0);
			Mesh mesh = CreateMesh(45, 45);
			MeshRenderer renderer = gameObject.AddComponent<MeshRenderer>();
			MeshFilter meshFilter = gameObject.AddComponent<MeshFilter>();
			mesh.uv = RectToUV(uvs[i]);
			meshFilter.mesh = mesh;
			newMaterial.mainTexture = packedTexture;
			renderer.material = newMaterial;
		}

		//renderer.material = newMaterial;

		/*
		packedTexture = new Texture2D(1024,1024);
		Rect[] uvs = packedTexture.PackTextures(textures,0,1024);
		
		newMaterial.mainTexture = packedTexture;
		
		Vector2[] uva,uvb;
		for (int j=0;j < filters.Length;j++) {
			filters[j].gameObject.renderer.material=newMaterial;
			uva = (Vector2[])(((MeshFilter)filters[j]).mesh.uv);
			uvb = new Vector2[uva.Length];
			for (int k=0;k < uva.Length;k++){
				uvb[k]=new Vector2((uva[k].x*uvs[j].width)+uvs[j].x, (uva[k].y*uvs[j].height)+uvs[j].y);
			}
			((MeshFilter)filters[j]).mesh.uv=uvb;
		} 
		*/
//		Test();
	}

	private void Test() {
		int size = 200;
		Mesh m  = new Mesh();
		m.name = "Scripted_Plane_New_Mesh";
		m.vertices = new Vector3[] {new Vector3(-size, -size, 0.01f), new Vector3(size, -size, 0.01f), new Vector3(size, size, 0.01f), new Vector3(-size, size, 0.01f) };
		m.uv = new Vector2[]{new Vector2 (0, 0),new  Vector2 (0, 1), new Vector2(1, 1),new Vector2 (1, 0)};
		m.triangles = new int[]{0, 1, 2, 0, 2, 3};
		m.RecalculateNormals();
		GameObject obj   = new GameObject("New_Plane_Fom_Script", typeof(MeshRenderer), typeof(MeshFilter));
		obj.GetComponent<MeshFilter>().mesh = m;
	}

	private Vector2[] RectToUV(Rect rect)
	{
		Vector2[] ret = new Vector2[4];
		ret[0] = new Vector2(rect.x,rect.y);
		ret[3] = new Vector2(rect.x,rect.y + rect.height);
		ret[2] = new Vector2(rect.x + rect.width, rect.y + rect.height);
		ret[1] = new Vector2(rect.x + rect.width ,rect.y);
		return ret;
	}

	Mesh CreateMesh(float width, float height)
	{
		Mesh m = new Mesh();
		m.name = "ScriptedMesh";
		m.vertices = new Vector3[] {
			new Vector3(-width, -height, 0.01f),
			new Vector3(width, -height, 0.01f),
			new Vector3(width, height, 0.01f),
			new Vector3(-width, height, 0.01f)
		};

		m.uv = new Vector2[] {
			new Vector2 (0, 0),
			new Vector2 (0, 1),
			new Vector2(1, 1),
			new Vector2 (1, 0)
		};

		m.triangles = new int[] { 0, 1, 2, 0, 3, 2};
		m.RecalculateNormals();
		
		return m;
	}

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
