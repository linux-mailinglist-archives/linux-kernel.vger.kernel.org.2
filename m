Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90B736BE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 06:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhD0EXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 00:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhD0EXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:23:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BFEC061574;
        Mon, 26 Apr 2021 21:23:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y62so7853315pfg.4;
        Mon, 26 Apr 2021 21:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3gBOlfSOy5UjiW66PDdEdzSMWaMXbtisr4HIm0r8dg=;
        b=o4ZfJBKGGhC8RyE0ioAU5vczUQDaZmNVIcZWoqZKsV9QwOmReGSTR9adUSVpvThGwH
         nObMC+Qaaq+NkFQDRvVbGDMjpTfIeaz/iE8NmI0DYr2yQRAGlX+UAeuvJQfEPHAr7dyz
         VCFHRvwwfKhIfTdANwTECe7X9iO/Wd8YVLFooc5eUeIqR0vOztw/F76lzpzMmgFnUZRq
         g10571DlozEti1bbE73IjxIxMyxSLgeSEAhbekRm5uxRE5o0uTu+W2fibg0UkUTs/qmq
         qZN3QmOiehNEjWMDN7Qi8JomMqxP7hbyx6vHuhqfSzJv9vlWXVkQ3dh53GWZYidrsXqz
         Ba0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3gBOlfSOy5UjiW66PDdEdzSMWaMXbtisr4HIm0r8dg=;
        b=rhcrE+JdTeq720ebRWet+7Qqwu4/9zYwpBOiiX4HrKlXV+fC/If+fNpfwaLoU3UhX2
         d7vuYEBy25NThIzm9q/fp3Y5GmGs4I5xlDHcoA8oYy53G/2SFocGEBgJTTTcbnIEp24Q
         pGoJHf79246opZsRmkEdewrUaG2UprvdkpYyIf0yeKY6VtfDHL4zJ/zVEskmEAA0DRlU
         cyZMQi+ntWJXRsm7Mp8kl/STzj21SpVDwf48GlIPyvVL1kTg2q27FnK71K/vSAFATAaB
         LHBYwSE4uGQPLBPti/uJzA9oXM1p87RIvL2diAwbWnp/WAUyqXUuWxrsig7Uj1YG6xjc
         r6CQ==
X-Gm-Message-State: AOAM532HOzHi3npgOM0M5UCbYqo5OOe3M79jp7RA33e62glTdCKp0aKM
        9oIKRhgPl0856kxE942PKV4=
X-Google-Smtp-Source: ABdhPJwqXCBVgRiqt6Cut5FbN9lUaqApO3QLg0Mg6SYjqBpJV/cnnKCj0D3CTFZaGQEPZUKhSTUFBQ==
X-Received: by 2002:a63:f258:: with SMTP id d24mr19912848pgk.174.1619497388155;
        Mon, 26 Apr 2021 21:23:08 -0700 (PDT)
Received: from localhost.localdomain ([49.207.201.224])
        by smtp.gmail.com with ESMTPSA id h9sm1050951pfv.14.2021.04.26.21.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 21:23:07 -0700 (PDT)
From:   Prasanth KSR <kosigiprasanth@gmail.com>
X-Google-Original-From: Prasanth KSR <prasanth.ksr@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Prasanth KSR <prasanth.ksr@dell.com>,
        Divya Bharathi <divya.bharathi@dell.com>
Subject: [PATCH] platform/x86: dell-wmi-sysman: Make populate_foo_data functions more robust
Date:   Tue, 27 Apr 2021 09:52:33 +0530
Message-Id: <20210427042233.5495-1-prasanth.ksr@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Check acpi type before assignment of each property value

2. Add boundary check for properties count

Co-developed-by: Divya Bharathi <divya.bharathi@dell.com>
Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>
Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>
---
 .../dell/dell-wmi-sysman/dell-wmi-sysman.h    |  5 ++-
 .../dell/dell-wmi-sysman/enum-attributes.c    | 36 ++++++++++++++++---
 .../x86/dell/dell-wmi-sysman/int-attributes.c | 16 +++++++++
 .../dell/dell-wmi-sysman/passobj-attributes.c |  6 ++++
 .../dell/dell-wmi-sysman/string-attributes.c  | 16 ++++++++-
 .../x86/dell/dell-wmi-sysman/sysman.c         | 17 ++++++---
 6 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
index b80f2a62ea3f..3ad33a094588 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
@@ -152,12 +152,15 @@ static ssize_t curr_val##_store(struct kobject *kobj,				\
 	return ret ? ret : count;						\
 }
 
+#define check_property_type(attr, prop, valuetype)				\
+	(attr##_obj[prop].type != valuetype)
+
 union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string);
 int get_instance_count(const char *guid_string);
 void strlcpy_attr(char *dest, char *src);
 
 int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
-			struct kobject *attr_name_kobj);
+			struct kobject *attr_name_kobj, u32 enum_property_count);
 int alloc_enum_data(void);
 void exit_enum_attributes(void);
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
index 091e48c217ed..70f4ace56ec3 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
@@ -132,39 +132,65 @@ int alloc_enum_data(void)
  * @enumeration_obj: ACPI object with enumeration data
  * @instance_id: The instance to enumerate
  * @attr_name_kobj: The parent kernel object
+ * @enum_property_count: Total properties count under enumeration type
  */
 int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
-			struct kobject *attr_name_kobj)
+			struct kobject *attr_name_kobj, u32 enum_property_count)
 {
 	int i, next_obj, value_modifier_count, possible_values_count;
 
 	wmi_priv.enumeration_data[instance_id].attr_name_kobj = attr_name_kobj;
+	if (check_property_type(enumeration, ATTR_NAME, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.enumeration_data[instance_id].attribute_name,
 		enumeration_obj[ATTR_NAME].string.pointer);
+	if (check_property_type(enumeration, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.enumeration_data[instance_id].display_name_language_code,
 		enumeration_obj[DISPL_NAME_LANG_CODE].string.pointer);
+	if (check_property_type(enumeration, DISPLAY_NAME, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.enumeration_data[instance_id].display_name,
 		enumeration_obj[DISPLAY_NAME].string.pointer);
+	if (check_property_type(enumeration, DEFAULT_VAL, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.enumeration_data[instance_id].default_value,
 		enumeration_obj[DEFAULT_VAL].string.pointer);
+	if (check_property_type(enumeration, MODIFIER, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.enumeration_data[instance_id].dell_modifier,
 		enumeration_obj[MODIFIER].string.pointer);
 
 	next_obj = MODIFIER + 1;
 
-	value_modifier_count = (uintptr_t)enumeration_obj[next_obj].string.pointer;
+	if (next_obj >= enum_property_count)
+		return -EINVAL;
+
+	if (check_property_type(enumeration, next_obj, ACPI_TYPE_INTEGER))
+		return -EINVAL;
+	value_modifier_count = (uintptr_t)enumeration_obj[next_obj++].string.pointer;
 
 	for (i = 0; i < value_modifier_count; i++) {
+		if (next_obj >= enum_property_count)
+			return -EINVAL;
+		if (check_property_type(enumeration, next_obj, ACPI_TYPE_STRING))
+			return -EINVAL;
 		strcat(wmi_priv.enumeration_data[instance_id].dell_value_modifier,
-			enumeration_obj[++next_obj].string.pointer);
+			enumeration_obj[next_obj++].string.pointer);
 		strcat(wmi_priv.enumeration_data[instance_id].dell_value_modifier, ";");
 	}
 
-	possible_values_count = (uintptr_t) enumeration_obj[++next_obj].string.pointer;
+	if (check_property_type(enumeration, next_obj, ACPI_TYPE_INTEGER))
+		return -EINVAL;
+	possible_values_count = (uintptr_t) enumeration_obj[next_obj++].string.pointer;
 
 	for (i = 0; i < possible_values_count; i++) {
+		if (next_obj >= enum_property_count)
+			return -EINVAL;
+		if (check_property_type(enumeration, next_obj, ACPI_TYPE_STRING))
+			return -EINVAL;
 		strcat(wmi_priv.enumeration_data[instance_id].possible_values,
-			enumeration_obj[++next_obj].string.pointer);
+			enumeration_obj[next_obj++].string.pointer);
 		strcat(wmi_priv.enumeration_data[instance_id].possible_values, ";");
 	}
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
index 8a49ba6e44f9..951e75b538fa 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
@@ -141,20 +141,36 @@ int populate_int_data(union acpi_object *integer_obj, int instance_id,
 			struct kobject *attr_name_kobj)
 {
 	wmi_priv.integer_data[instance_id].attr_name_kobj = attr_name_kobj;
+	if (check_property_type(integer, ATTR_NAME, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.integer_data[instance_id].attribute_name,
 		integer_obj[ATTR_NAME].string.pointer);
+	if (check_property_type(integer, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.integer_data[instance_id].display_name_language_code,
 		integer_obj[DISPL_NAME_LANG_CODE].string.pointer);
+	if (check_property_type(integer, DISPLAY_NAME, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.integer_data[instance_id].display_name,
 		integer_obj[DISPLAY_NAME].string.pointer);
+	if (check_property_type(integer, DEFAULT_VAL, ACPI_TYPE_INTEGER))
+		return -EINVAL;
 	wmi_priv.integer_data[instance_id].default_value =
 		(uintptr_t)integer_obj[DEFAULT_VAL].string.pointer;
+	if (check_property_type(integer, MODIFIER, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.integer_data[instance_id].dell_modifier,
 		integer_obj[MODIFIER].string.pointer);
+	if (check_property_type(integer, MIN_VALUE, ACPI_TYPE_INTEGER))
+		return -EINVAL;
 	wmi_priv.integer_data[instance_id].min_value =
 		(uintptr_t)integer_obj[MIN_VALUE].string.pointer;
+	if (check_property_type(integer, MAX_VALUE, ACPI_TYPE_INTEGER))
+		return -EINVAL;
 	wmi_priv.integer_data[instance_id].max_value =
 		(uintptr_t)integer_obj[MAX_VALUE].string.pointer;
+	if (check_property_type(integer, SCALAR_INCR, ACPI_TYPE_INTEGER))
+		return -EINVAL;
 	wmi_priv.integer_data[instance_id].scalar_increment =
 		(uintptr_t)integer_obj[SCALAR_INCR].string.pointer;
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
index 834b3e82ad9f..230e6ee96636 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
@@ -159,10 +159,16 @@ int alloc_po_data(void)
 int populate_po_data(union acpi_object *po_obj, int instance_id, struct kobject *attr_name_kobj)
 {
 	wmi_priv.po_data[instance_id].attr_name_kobj = attr_name_kobj;
+	if (check_property_type(po, ATTR_NAME, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.po_data[instance_id].attribute_name,
 		     po_obj[ATTR_NAME].string.pointer);
+	if (check_property_type(po, MIN_PASS_LEN, ACPI_TYPE_INTEGER))
+		return -EINVAL;
 	wmi_priv.po_data[instance_id].min_password_length =
 		(uintptr_t)po_obj[MIN_PASS_LEN].string.pointer;
+	if (check_property_type(po, MAX_PASS_LEN, ACPI_TYPE_INTEGER))
+		return -EINVAL;
 	wmi_priv.po_data[instance_id].max_password_length =
 		(uintptr_t) po_obj[MAX_PASS_LEN].string.pointer;
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
index 552537852459..c392f0ecf8b5 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
@@ -118,24 +118,38 @@ int alloc_str_data(void)
 
 /**
  * populate_str_data() - Populate all properties of an instance under string attribute
- * @str_obj: ACPI object with integer data
+ * @str_obj: ACPI object with string data
  * @instance_id: The instance to enumerate
  * @attr_name_kobj: The parent kernel object
  */
 int populate_str_data(union acpi_object *str_obj, int instance_id, struct kobject *attr_name_kobj)
 {
 	wmi_priv.str_data[instance_id].attr_name_kobj = attr_name_kobj;
+	if (check_property_type(str, ATTR_NAME, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.str_data[instance_id].attribute_name,
 		     str_obj[ATTR_NAME].string.pointer);
+	if (check_property_type(str, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.str_data[instance_id].display_name_language_code,
 		     str_obj[DISPL_NAME_LANG_CODE].string.pointer);
+	if (check_property_type(str, DISPLAY_NAME, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.str_data[instance_id].display_name,
 		     str_obj[DISPLAY_NAME].string.pointer);
+	if (check_property_type(str, DEFAULT_VAL, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.str_data[instance_id].default_value,
 		     str_obj[DEFAULT_VAL].string.pointer);
+	if (check_property_type(str, MODIFIER, ACPI_TYPE_STRING))
+		return -EINVAL;
 	strlcpy_attr(wmi_priv.str_data[instance_id].dell_modifier,
 		     str_obj[MODIFIER].string.pointer);
+	if (check_property_type(str, MIN_LEN, ACPI_TYPE_INTEGER))
+		return -EINVAL;
 	wmi_priv.str_data[instance_id].min_length = (uintptr_t)str_obj[MIN_LEN].string.pointer;
+	if (check_property_type(str, MAX_LEN, ACPI_TYPE_INTEGER))
+		return -EINVAL;
 	wmi_priv.str_data[instance_id].max_length = (uintptr_t) str_obj[MAX_LEN].string.pointer;
 
 	return sysfs_create_group(attr_name_kobj, &str_attr_group);
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index c8d276d78e92..5276e8c5aad5 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -412,10 +412,16 @@ static int init_bios_attributes(int attr_type, const char *guid)
 		return retval;
 
 	switch (attr_type) {
-	case ENUM:	min_elements = 8;	break;
-	case INT:	min_elements = 9;	break;
-	case STR:	min_elements = 8;	break;
-	case PO:	min_elements = 4;	break;
+	case ENUM:
+	case STR:
+		min_elements = 8;
+		break;
+	case INT:
+		min_elements = 9;
+		break;
+	case PO:
+		min_elements = 4;
+		break;
 	default:
 		pr_err("Error: Unknown attr_type: %d\n", attr_type);
 		return -EINVAL;
@@ -481,7 +487,8 @@ static int init_bios_attributes(int attr_type, const char *guid)
 		/* enumerate all of this attribute */
 		switch (attr_type) {
 		case ENUM:
-			retval = populate_enum_data(elements, instance_id, attr_name_kobj);
+			retval = populate_enum_data(elements, instance_id, attr_name_kobj,
+					obj->package.count);
 			break;
 		case INT:
 			retval = populate_int_data(elements, instance_id, attr_name_kobj);
-- 
2.25.1

