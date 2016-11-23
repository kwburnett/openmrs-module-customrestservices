package org.openmrs.module.webservices.rest.web.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.module.patientlist.api.model.PatientInformationField;
import org.openmrs.module.patientlist.api.util.PatientInformation;
import org.openmrs.module.patientlist.web.ModuleRestConstants;
import org.openmrs.module.webservices.rest.SimpleObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * REST controller for Patient List Fields
 */
@Controller
@RequestMapping("/rest/" + ModuleRestConstants.PATIENT_LIST_FIELDS_RESOURCE)
public class PatientListFieldsResourceController {

	private final Log LOG = LogFactory.getLog(this.getClass());

	@ResponseBody
	@RequestMapping(method = RequestMethod.GET)
	public SimpleObject get() {
		SimpleObject results = new SimpleObject();
		List<SimpleObject> fields = new ArrayList<SimpleObject>();

		Map<String, PatientInformationField<?>> patientInformationFields =
		        PatientInformation.getInstance().getFields();
		for (Map.Entry<String, PatientInformationField<?>> set : patientInformationFields.entrySet()) {
			SimpleObject field = new SimpleObject();
			field.put("field", set.getKey());
			field.put("desc", set.getValue());
			fields.add(field);
		}

		results.put("results", fields);
		return results;
	}

}