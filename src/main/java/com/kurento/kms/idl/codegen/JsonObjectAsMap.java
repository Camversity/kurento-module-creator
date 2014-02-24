package com.kurento.kms.idl.codegen;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;

public class JsonObjectAsMap {

	public Map<String, Object> getAsObject(JsonObject jsonObject) {
		Map<String, Object> map = new HashMap<String, Object>();
		for (Map.Entry<String, JsonElement> entry : jsonObject.entrySet()) {
			map.put(entry.getKey(), getAsObject(entry.getValue()));
		}
		return map;
	}

	public Object getAsObject(JsonElement value) {

		if (value == null) {
			return null;
		}

		if (value instanceof JsonPrimitive) {
			JsonPrimitive primitive = (JsonPrimitive) value;

			if (primitive.isBoolean()) {
				return primitive.getAsBoolean();
			}

			if (primitive.isNumber()) {
				return primitive.getAsNumber();
			}

			if (primitive.isString()) {
				return primitive.getAsString();
			}
		}

		if (value instanceof JsonArray) {

			JsonArray array = (JsonArray) value;

			List<Object> values = new ArrayList<Object>();
			for (JsonElement element : array) {
				values.add(getAsObject(element));
			}

			return values;
		}

		if (value instanceof JsonObject) {
			return getAsObject(value);
		}

		throw new RuntimeException("Unrecognized json element: " + value);
	}

}
