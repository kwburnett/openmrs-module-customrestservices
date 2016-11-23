<script type="text/javascript">
	var breadcrumbs = [
		{icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm'},
		{
			label: "${ ui.message("coreapps.app.systemAdministration.label")}",
			link: '${ui.pageLink("coreapps", "systemadministration/systemAdministration")}'
		},
		{
			label: "${ ui.message("patientlist.page")}",
			link: '/' + OPENMRS_CONTEXT_PATH + '/patientlist/managePatientList/entities.page#/'
		},
		{label: "${ ui.message("patientlist.define.label")}"}
	];
	
	jQuery('#breadcrumbs').html(emr.generateBreadcrumbHtml(breadcrumbs));
</script>

<div ng-show="loading" class="loading-msg">
	<span>${ui.message("openhmis.commons.general.processingPage")}</span>
	<br/>
	<span class="loading-img">
		<img src="${ui.resourceLink("uicommons", "images/spinner.gif")}"/>
	</span>
</div>

<form ng-hide="loading" name="entityForm" class="entity-form" ng-class="{'submitted': submitted}" style="font-size:inherit">
	${ui.includeFragment("openhmis.commons", "editEntityHeaderFragment")}
	
	<div class="row">
		<ul class="table-layout">
			<li class="required">
				<span>${ui.message("general.name")}</span>
			</li>
			<li>
				<input name="entityName" type="text" ng-model="entity.name" class="maximized form-control"
				       placeholder="${ui.message("general.name")}" required/>
			</li>
		</ul>
		<ul class="table-layout">
			<li style="vertical-align: top" class="not-required">
				<span>${ui.message("general.description")}</span>
			</li>
			<li>
				<textarea ng-model="entity.description" placeholder="${ui.message("general.description")}" rows="3"
				          cols="40">
				</textarea>
			</li>
		</ul>
	</div>
	<br/>
	<fieldset class="nested legendHeader">
		<legend>${ui.message("patientlist.condition.list.header")}</legend>
		<div class="col-md-12">
			<table style="margin-bottom:5px;" class="manage-entities-table">
				<thead>
				<tr>
					<th style="width:12% "></th>
					<th style="width:60% ">${ui.message("patientlist.condition.field.label")}</th>
					<th>${ui.message("patientlist.condition.operator.label")}</th>
					<th>${ui.message("patientlist.condition.value.label")}</th>
				</tr>
				</thead>
				<tbody>
				<tr ng-show="entity.patientListConditions.length > 0" ng-repeat="listCondition in listConditions">
					<td style="width:12% ">
						<input type="image" src="/openmrs/images/trash.gif" tabindex="-1" ng-show="listCondition.selected"
						       title="${ui.message('openhmis.cashier.item.removeTitle')}"
						       class="remove" ng-click="removeListCondition(listCondition)"></td>
					<td style="width:90% ">
						<select class="form-control" ng-change="inputsValueChange(listCondition)" ng-model="listCondition.field">
							<option value="">--Select Field--</option>
							<option value="p.given_name">Patient Given Name</option>
							<option value="p.family_name" >Patient Family Name</option>
							<option value="p.gender" >Patient Gender</option>
							<option value="p.birth_date" >Patient Birth Date</option>
							<option value="p.attr.birthplace" >Patient Birth Place</option>
							<option value="p.attr.civil_status" >Patient Civil Status</option>
							<option value="v.start_date" >Visit Start Date</option>
							<option value="v.end_date" >Visit End Date</option>
							<option value="v.note.primary_diagnosis" >Visit Note Primary Diagnosis</option>
							<option value="v.vitals.weight" >Visit Vital Weight</option>
							<option value="v.attr.new_patient" >New Patient</option>
							<option value="v.attr.ward" >Patient Ward</option>
							<option value="p.hasActiveVisit" >Patient Active Visit</option>
							<option value="v.hasDiagnosis" >Visit Diagnosis</option>
						</select>
					</td>
					<td>
						<select class="form-control" ng-model="listCondition.operator">
							<option value="">--Select Operator--</option>
							<option value="EQUALS">Equals</option>
							<option value="NOT_EQUALS">Not Equals</option>
							<option value="GT">Greater than</option>
							<option value="LT">Less than</option>
							<option value="GTE">Greater than or Equals</option>
							<option value="LTE">Less than or Equals</option>
							<option value="LIKE">Like</option>
							<option value="BETWEEN">Between</option>
							<option value="NULL">Empty</option>
							<option value="NOT NULL">Not Empty</option>
						</select>
					</td>
					<td ng-show="textInput">
						<input name="conditionValue" placeholder="${ui.message("patientlist.condition.value.label")}"
						       class="form-control input-md" type="text" ng-model="listCondition.value"
						       ng-blur="patientListCondition(listCondition)"/>
					</td>
					<td ng-show="dropdownInput">
						<select class="form-control" ng-model="listCondition.value" ng-change="patientListCondition(listCondition)">
							<option value="">-- Select Value --</option>
							<option ng-repeat="answer in conceptAnswers" value="{{answer.uuid}}">{{answer.display}}</option>
						</select>
					</td>
					<td ng-show="dateInput">
						${ui.includeFragment("uicommons", "field/datetimepicker",
								[id           : 'patientConditionDate',
								 label        : '',
								 required     : 'required',
								 formFieldName: 'patientConditionDatePicker',
								 useTime      : false,
								 name         : 'patientConditionDate'
								])}
					</td>
					<td ng-show="numberInput">
						<input name="conditionValue" placeholder="${ui.message("patientlist.condition.value.label")}"
						       class="form-control input-md" type="text" ng-model="listCondition.value"
						       ng-blur="patientListCondition(listCondition)"/>
					</td>
					<td ng-show="radioButtonInput">
						<label class="radio-inline">
							<input ng-click="patientListCondition(listCondition)"
							       class="form-control" ng-model="listCondition.value" type="radio"
							       name="conditionValue" value="true">True
						</label>
						<label class="radio-inline">
							<input ng-enter="addListCondition()" ng-click="patientListCondition(listCondition)"
							       class="form-control" ng-model="listCondition.value" type="radio"
							       name="conditionValue" value="false">False
						</label>
					</td>
				</tr>
				
				</tbody>
			</table>
		</div>
	</fieldset>
	<br/>
	<br/>
	<fieldset class="nested">
		<legend>${ui.message("patientlist.sort.order.header")}</legend>
		<div class="col-md-12">
			<table style="margin-bottom:5px;" class="manage-entities-table">
				<thead>
				<tr>
					<th style="width:10% "></th>
					<th>${ui.message("patientlist.sort.order.field.label")}</th>
					<th>${ui.message("patientlist.sort.order.sortOrder.label")}</th>
				</tr>
				</thead>
				<tbody>
				<tr ng-show="entity.ordering.length > 0" ng-repeat="listOrdering in entity.ordering">
					<td class="item-actions" style="width:10% ">
						<input type="image" src="/openmrs/images/trash.gif" tabindex="-1"
						       title="Remove patient list ordering" class="remove" ng-click=""></td>
					<td>
						<select class="form-control" ng-model="listOrdering.field">
							<option value="">--Select Field--</option>
							<option value="p.given_name">Patient Given Name</option>
							<option value="p.family_name">Patient Family Name</option>
							<option value="p.gender">Patient Gender</option>
							<option value="p.birth_date">Patient Birth Date</option>
							<option value="p.attr.birthplace">Patient Birth Place</option>
							<option value="p.attr.civil_status">Patient Civil Status</option>
							<option value="v.start_date">Visit Start Date</option>
							<option value="v.end_date">Visit End Date</option>
							<option value="v.note.primary_diagnosis">Visit Note Primary Diagnosis</option>
							<option value="v.vitals.weight">Visit Vital Weight</option>
							<option value="v.attr.new_patient">New Patient</option>
							<option value="v.attr.ward">Patient Ward</option>
							<option value="p.hasActiveVisit">Patient Active Visit</option>
							<option value="v.hasDiagnosis">Visit Diagnosis</option>
						</select>
					</td>
					<td>
						<select class="form-control" ng-model="listOrdering.sortOrder"
						        ng-change="patientListSortOrder(listOrdering)">
							<option value="">--Select Sort Order--</option>
							<option value="asc">Ascending</option>
							<option value="desc">Descending</option>
						</select>
					</td>
				</tr>
				<tr ng-show="entity.ordering.length <= 0">
					<td class="item-actions" style="width:10% ">
						<input type="image" src="/openmrs/images/trash.gif" tabindex="-1"
						       title="Remove patient list ordering" class="remove" ng-click=""></td>
					<td>
						<select class="form-control" ng-model="listOrdering.field">
							<option value="">--Select Field--</option>
							<option value="p.given_name">Patient Given Name</option>
							<option value="p.family_name">Patient Family Name</option>
							<option value="p.gender">Patient Gender</option>
							<option value="p.birth_date">Patient Birth Date</option>
							<option value="p.attr.birthplace">Patient Birth Place</option>
							<option value="p.attr.civil_status">Patient Civil Status</option>
							<option value="v.start_date">Visit Start Date</option>
							<option value="v.end_date">Visit End Date</option>
							<option value="v.note.primary_diagnosis">Visit Note Primary Diagnosis</option>
							<option value="v.vitals.weight">Visit Vital Weight</option>
							<option value="v.attr.new_patient">New Patient</option>
							<option value="v.attr.ward">Patient Ward</option>
							<option value="p.hasActiveVisit">Patient Active Visit</option>
							<option value="v.hasDiagnosis">Visit Diagnosis</option>
						</select>
					</td>
					<td>
						<select class="form-control" ng-model="listOrdering.sortOrder"
						        ng-change="patientListSortOrder(listOrdering)">
							<option value="">--Select Sort Order--</option>
							<option value="asc">Ascending</option>
							<option value="desc">Descending</option>
						</select>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
	</fieldset>
	<br/>
	<br/>
	<fieldset class="nested">
		<legend class="legendHeader">${ui.message("patientlist.display.template.header")}</legend>
		<div class="col-md-12">
			<br/>
			<div class="row">
				<div class="col-md-12">
					<div class="col-md-4">
						<span>${ui.message("patientlist.display.template.header.label")}</span>
					</div>
					<div class="col-md-7">
						<input name="entityDisplayTemplateHeader" type="text" ng-model="entity.displayTemplateHeader" class="form-control"
						       placeholder="${ui.message("patientlist.display.template.header.label")}" required/>
					</div>
				</div>
			</div>
			<br/>
			<div class="row">
				<div class="col-md-12">
					<div class="col-md-4">
						<span>${ui.message("patientlist.display.template.body.label")}</span>
					</div>
					<div class="col-md-7">
						<textarea ng-model="entity.displayTemplateBody" placeholder="${ui.message("patientlist.display.template.body.label")}" rows="10"
						          cols="40" class="form-control">
						</textarea>
					</div>
				</div>
			</div>
		</div>
	</fieldset>
	<br/>
	<div >
		<br/>
		<div class="col-md-6">
			<input type="button" class="cancel" value="${ui.message("general.cancel")}" ng-click="cancel()"/>
		</div>
		<div class="col-md-6">
			<input type="button" class="confirm right" value="${ui.message("general.save")}" ng-click="saveOrUpdate()"/>
		</div>
	</div>
</form>
${ui.includeFragment("openhmis.commons", "retireUnretireDeleteFragment")}