Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630B0367F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhDVLRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbhDVLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:17:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7699C06174A;
        Thu, 22 Apr 2021 04:17:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id p2so17131706pgh.4;
        Thu, 22 Apr 2021 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JyIYucsYUsMQyLU2OnbgKW0D74FQ5mSrU00MST1DtXM=;
        b=vLx8sKaZwDMlw6ll6EEK43SlL9SCLRIHfzytN/+po65+mVVMY8oy/83ywmhX5d2pHr
         P9iCVQDvVtLELOEgTth1Po9I7W1v0/OGSSpWIcGUNHiItCa4Y3yqp7I/uJRw4TUShRn0
         vZ/KPGesvFwPHbXhArinVzzl+G3yKmWXLIUzr3gj7Cpz4ZkkDh3IIxoH7HnuRQdvs3xP
         C5/a4j22E+DQWG2EHdUyrvHAXk3fGsuxHKOXTpgCQgKEkcbSDRHV56TThN9K3xSpjsuO
         9x/1H2+dcI9bRb2xitr/iNkdDSmrpYvHiqHhl1D46uzYibw96oGBS4V2dYOHDyMsNu2c
         WLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JyIYucsYUsMQyLU2OnbgKW0D74FQ5mSrU00MST1DtXM=;
        b=ULpYVs97rgTEmY0eWOewG9AtOR6us0hr2bS77L0/otaUt/p5dnPpoJ9R1cFal3Xjl8
         9R1RmKuZaItmoyDPvf0ConzyOgRiKzueO0PcbiF/mSLFl0iNRKRBkOsoC4LsCgDzE0ZZ
         Dl5UZVd36sNwagElYyFJsejB+Yu5nTysv0T/qyFUUYGuLVqbn7w1Nsi/gZ8jX5iz3/bh
         cqkucMGYs7SpSNqdWYxHHu1+Qd8MTl279pZGaT4MVDsJiFx3mHDmx0CytDVjgh0U/a20
         75G199Ylv2DEp8H/mFGDf4+CX5BszxzmfBNwbCvxStvlPQaPYiyRhbIZtCiohvY7ColM
         Ug1A==
X-Gm-Message-State: AOAM531zDPatga5jNa699/WWby++P3291Ru8iOIg4Z09gBSG6WVzKSVF
        PN2LtKW08mXGWBdBp98Y1Aw=
X-Google-Smtp-Source: ABdhPJwnDvvby84esBt2i8B/rmIv68nXMey/XCMKivjS4ldV9QhWkwyTUeTbHs5YfIsDQaQQt8/xoQ==
X-Received: by 2002:a62:8485:0:b029:1fc:d912:67d6 with SMTP id k127-20020a6284850000b02901fcd91267d6mr2947301pfd.80.1619090231244;
        Thu, 22 Apr 2021 04:17:11 -0700 (PDT)
Received: from localhost.localdomain ([49.207.213.230])
        by smtp.gmail.com with ESMTPSA id n23sm2088489pgl.49.2021.04.22.04.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 04:17:10 -0700 (PDT)
From:   Prasanth KSR <kosigiprasanth@gmail.com>
X-Google-Original-From: Prasanth KSR <prasanth.ksr@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Prasanth KSR" <prasanth.ksr@dell.com>,
        Divya Bharathi <divya.bharathi@dell.com>
Subject: [PATCH] Making populate_foo_data functions more robust
Date:   Thu, 22 Apr 2021 16:46:45 +0530
Message-Id: <20210422111645.24726-1-prasanth.ksr@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Prasanth KSR" <prasanth.ksr@dell.com>

 1. Check acpi type before assignment of each property value
 2. Add boundary check for properties count

Co-developed-by: Divya Bharathi <divya.bharathi@dell.com>
Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>
Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>
---
 .../dell/dell-wmi-sysman/dell-wmi-sysman.h    |  9 ++++-
 .../dell/dell-wmi-sysman/enum-attributes.c    | 26 ++++++++++---
 .../x86/dell/dell-wmi-sysman/int-attributes.c |  8 ++++
 .../dell/dell-wmi-sysman/passobj-attributes.c |  3 ++
 .../dell/dell-wmi-sysman/string-attributes.c  |  9 ++++-
 .../x86/dell/dell-wmi-sysman/sysman.c         | 39 +++++++++++++++++--
 6 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
index b80f2a62ea3f..5fd5fcd1976a 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
@@ -152,12 +152,19 @@ static ssize_t curr_val##_store(struct kobject *kobj,				\
 	return ret ? ret : count;						\
 }
 
+#define check_property_type(attr, prop, valuetype)				\
+do {										\
+	if (attr##_obj[prop].type != valuetype) {				\
+		return -EINVAL;							\
+	}									\
+} while (0)
+
 union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string);
 int get_instance_count(const char *guid_string);
 void strlcpy_attr(char *dest, char *src);
 
 int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
-			struct kobject *attr_name_kobj);
+			struct kobject *attr_name_kobj, __u32 enum_property_count);
 int alloc_enum_data(void);
 void exit_enum_attributes(void);
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
index 091e48c217ed..a5b0e2689e5f 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
@@ -134,37 +134,53 @@ int alloc_enum_data(void)
  * @attr_name_kobj: The parent kernel object
  */
 int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
-			struct kobject *attr_name_kobj)
+			struct kobject *attr_name_kobj, __u32 enum_property_count)
 {
 	int i, next_obj, value_modifier_count, possible_values_count;
 
 	wmi_priv.enumeration_data[instance_id].attr_name_kobj = attr_name_kobj;
+	check_property_type(enumeration, ATTR_NAME, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.enumeration_data[instance_id].attribute_name,
 		enumeration_obj[ATTR_NAME].string.pointer);
+	check_property_type(enumeration, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.enumeration_data[instance_id].display_name_language_code,
 		enumeration_obj[DISPL_NAME_LANG_CODE].string.pointer);
+	check_property_type(enumeration, DISPLAY_NAME, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.enumeration_data[instance_id].display_name,
 		enumeration_obj[DISPLAY_NAME].string.pointer);
+	check_property_type(enumeration, DEFAULT_VAL, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.enumeration_data[instance_id].default_value,
 		enumeration_obj[DEFAULT_VAL].string.pointer);
+	check_property_type(enumeration, MODIFIER, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.enumeration_data[instance_id].dell_modifier,
 		enumeration_obj[MODIFIER].string.pointer);
 
 	next_obj = MODIFIER + 1;
 
-	value_modifier_count = (uintptr_t)enumeration_obj[next_obj].string.pointer;
+	if (next_obj >= enum_property_count)
+		return -EINVAL;
+
+	check_property_type(enumeration, next_obj, ACPI_TYPE_INTEGER);
+	value_modifier_count = (uintptr_t)enumeration_obj[next_obj++].string.pointer;
 
 	for (i = 0; i < value_modifier_count; i++) {
+		if (next_obj >= enum_property_count)
+			return -EINVAL;
+		check_property_type(enumeration, next_obj, ACPI_TYPE_STRING);
 		strcat(wmi_priv.enumeration_data[instance_id].dell_value_modifier,
-			enumeration_obj[++next_obj].string.pointer);
+			enumeration_obj[next_obj++].string.pointer);
 		strcat(wmi_priv.enumeration_data[instance_id].dell_value_modifier, ";");
 	}
 
-	possible_values_count = (uintptr_t) enumeration_obj[++next_obj].string.pointer;
+	check_property_type(enumeration, next_obj, ACPI_TYPE_INTEGER);
+	possible_values_count = (uintptr_t) enumeration_obj[next_obj++].string.pointer;
 
 	for (i = 0; i < possible_values_count; i++) {
+		if (next_obj >= enum_property_count)
+			return -EINVAL;
+		check_property_type(enumeration, next_obj, ACPI_TYPE_STRING);
 		strcat(wmi_priv.enumeration_data[instance_id].possible_values,
-			enumeration_obj[++next_obj].string.pointer);
+			enumeration_obj[next_obj++].string.pointer);
 		strcat(wmi_priv.enumeration_data[instance_id].possible_values, ";");
 	}
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
index 8a49ba6e44f9..12d6b99da43d 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
@@ -141,20 +141,28 @@ int populate_int_data(union acpi_object *integer_obj, int instance_id,
 			struct kobject *attr_name_kobj)
 {
 	wmi_priv.integer_data[instance_id].attr_name_kobj = attr_name_kobj;
+	check_property_type(integer, ATTR_NAME, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.integer_data[instance_id].attribute_name,
 		integer_obj[ATTR_NAME].string.pointer);
+	check_property_type(integer, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.integer_data[instance_id].display_name_language_code,
 		integer_obj[DISPL_NAME_LANG_CODE].string.pointer);
+	check_property_type(integer, DISPLAY_NAME, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.integer_data[instance_id].display_name,
 		integer_obj[DISPLAY_NAME].string.pointer);
+	check_property_type(integer, DEFAULT_VAL, ACPI_TYPE_INTEGER);
 	wmi_priv.integer_data[instance_id].default_value =
 		(uintptr_t)integer_obj[DEFAULT_VAL].string.pointer;
+	check_property_type(integer, MODIFIER, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.integer_data[instance_id].dell_modifier,
 		integer_obj[MODIFIER].string.pointer);
+	check_property_type(integer, MIN_VALUE, ACPI_TYPE_INTEGER);
 	wmi_priv.integer_data[instance_id].min_value =
 		(uintptr_t)integer_obj[MIN_VALUE].string.pointer;
+	check_property_type(integer, MAX_VALUE, ACPI_TYPE_INTEGER);
 	wmi_priv.integer_data[instance_id].max_value =
 		(uintptr_t)integer_obj[MAX_VALUE].string.pointer;
+	check_property_type(integer, SCALAR_INCR, ACPI_TYPE_INTEGER);
 	wmi_priv.integer_data[instance_id].scalar_increment =
 		(uintptr_t)integer_obj[SCALAR_INCR].string.pointer;
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
index 834b3e82ad9f..866cf732cee2 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
@@ -159,10 +159,13 @@ int alloc_po_data(void)
 int populate_po_data(union acpi_object *po_obj, int instance_id, struct kobject *attr_name_kobj)
 {
 	wmi_priv.po_data[instance_id].attr_name_kobj = attr_name_kobj;
+	check_property_type(po, ATTR_NAME, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.po_data[instance_id].attribute_name,
 		     po_obj[ATTR_NAME].string.pointer);
+	check_property_type(po, MIN_PASS_LEN, ACPI_TYPE_INTEGER);
 	wmi_priv.po_data[instance_id].min_password_length =
 		(uintptr_t)po_obj[MIN_PASS_LEN].string.pointer;
+	check_property_type(po, MAX_PASS_LEN, ACPI_TYPE_INTEGER);
 	wmi_priv.po_data[instance_id].max_password_length =
 		(uintptr_t) po_obj[MAX_PASS_LEN].string.pointer;
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
index 552537852459..557b9d4511af 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
@@ -118,24 +118,31 @@ int alloc_str_data(void)
 
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
+	check_property_type(str, ATTR_NAME, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.str_data[instance_id].attribute_name,
 		     str_obj[ATTR_NAME].string.pointer);
+	check_property_type(str, DISPL_NAME_LANG_CODE, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.str_data[instance_id].display_name_language_code,
 		     str_obj[DISPL_NAME_LANG_CODE].string.pointer);
+	check_property_type(str, DISPLAY_NAME, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.str_data[instance_id].display_name,
 		     str_obj[DISPLAY_NAME].string.pointer);
+	check_property_type(str, DEFAULT_VAL, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.str_data[instance_id].default_value,
 		     str_obj[DEFAULT_VAL].string.pointer);
+	check_property_type(str, MODIFIER, ACPI_TYPE_STRING);
 	strlcpy_attr(wmi_priv.str_data[instance_id].dell_modifier,
 		     str_obj[MODIFIER].string.pointer);
+	check_property_type(str, MIN_LEN, ACPI_TYPE_INTEGER);
 	wmi_priv.str_data[instance_id].min_length = (uintptr_t)str_obj[MIN_LEN].string.pointer;
+	check_property_type(str, MAX_LEN, ACPI_TYPE_INTEGER);
 	wmi_priv.str_data[instance_id].max_length = (uintptr_t) str_obj[MAX_LEN].string.pointer;
 
 	return sysfs_create_group(attr_name_kobj, &str_attr_group);
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 7410ccae650c..fc45cdb5a5e8 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -399,6 +399,7 @@ static int init_bios_attributes(int attr_type, const char *guid)
 	union acpi_object *obj = NULL;
 	union acpi_object *elements;
 	struct kset *tmp_set;
+	int min_elements;
 
 	/* instance_id needs to be reset for each type GUID
 	 * also, instance IDs are unique within GUID but not across
@@ -409,14 +410,43 @@ static int init_bios_attributes(int attr_type, const char *guid)
 	retval = alloc_attributes_data(attr_type);
 	if (retval)
 		return retval;
+
+	switch (attr_type) {
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
+	default:
+		pr_err("Error: Unknown attr_type: %d\n", attr_type);
+		return -EINVAL;
+	}
+
 	/* need to use specific instance_id and guid combination to get right data */
 	obj = get_wmiobj_pointer(instance_id, guid);
-	if (!obj || obj->type != ACPI_TYPE_PACKAGE)
+	if (!obj)
 		return -ENODEV;
-	elements = obj->package.elements;
 
 	mutex_lock(&wmi_priv.mutex);
-	while (elements) {
+	while (obj) {
+		if (obj->type != ACPI_TYPE_PACKAGE) {
+			pr_err("Error: Expected ACPI-package type, got: %d\n", obj->type);
+			retval = -EIO;
+			goto err_attr_init;
+		}
+
+		if (obj->package.count < min_elements) {
+			pr_err("Error: ACPI-package does not have enough elements: %d < %d\n",
+			       obj->package.count, min_elements);
+			goto nextobj;
+		}
+
+		elements = obj->package.elements;
 		/* sanity checking */
 		if (elements[ATTR_NAME].type != ACPI_TYPE_STRING) {
 			pr_debug("incorrect element type\n");
@@ -456,7 +486,8 @@ static int init_bios_attributes(int attr_type, const char *guid)
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

