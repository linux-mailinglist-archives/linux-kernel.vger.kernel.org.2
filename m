Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D63A37BA50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhELK1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 06:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhELK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 06:27:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14EFC061574;
        Wed, 12 May 2021 03:26:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n3so139191plf.7;
        Wed, 12 May 2021 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YI/Fq5khq9VFEJZ0kliGhwv5FAKXrppTUpUM593GEkw=;
        b=gkUntUdhXJiIrdNbczgvL0YOOzlLGHgsvwxdaCQ7nNZLbHUNbAzEFw5VotGYdUYW0a
         5twq85ow9uwlQUNzrTh//d7nuiFGGMlCeqwI8/OfWGmFX7SSWiBUoBfu9fIyTR4mhybM
         NAbVM7m9D03s7H8bQHhy8SbPvqmeWb9+6jgvRxBcq8ixXOHnv76Ros3bKBHgOMWzED7t
         VradjtRnpG9w8IBGeL3BGQNsHGipQDnD/AWaf7MXoMSALhEhwT0C6H7ZU1/8VwOsXX2g
         glK9i55hkj+SpR9QnzndZlm7ccThdjboWSnw7VhS40NL+Cm2A9wVEw5E3C15cPVhONRX
         wYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YI/Fq5khq9VFEJZ0kliGhwv5FAKXrppTUpUM593GEkw=;
        b=KD8+KvnwUa/YEL5kKtuX8V07bTNaShBm+OSPXUr8v95dvF6FOTvROXVwjXcgqEaDFg
         gb7GIdXtAgQVP0oiTBwnvd7gD+BRoez1wT2QXwfkppZ4A5cHPP3cJJlJUY5yAJeT/ndL
         tCwzxKQ7Ort/W59fA+pPCVE8g4CFG35unydMLFqGnYDCqLBO8CagTOYFmEh2rr0j1gBs
         Wb6PWT6I9uRC+XlLGeVIs68mhE8QKSQQw027aXD1t2zLsorKuhY9I0u3UYkfRucNd5ir
         HAIIwuZ4bfD2bnZZx/WgPwVJOlUdYmibkr2CMMUEA9sgwrusf26MBt/NcAtddUkcuj4r
         ZSMA==
X-Gm-Message-State: AOAM531IuzF49orW1ww0VG4h8oKfIF1jFgV2GTad88NQuKqV6Bc3NSqv
        N52+JI9XAM9bJ1E8fuWVNGE=
X-Google-Smtp-Source: ABdhPJycTDWS0oytllDhMXgqUbpbqjONbgEFQpIYqhkBMn7T9dAA/fp5e/GEc5Da8CU+3YI8KROuCw==
X-Received: by 2002:a17:902:e986:b029:ee:d430:6bf9 with SMTP id f6-20020a170902e986b02900eed4306bf9mr35016403plb.0.1620815172204;
        Wed, 12 May 2021 03:26:12 -0700 (PDT)
Received: from localhost.localdomain ([49.207.224.217])
        by smtp.gmail.com with ESMTPSA id j26sm15621715pfn.47.2021.05.12.03.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 03:26:11 -0700 (PDT)
From:   Prasanth KSR <kosigiprasanth@gmail.com>
X-Google-Original-From: Prasanth KSR <prasanth.ksr@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Prasanth KSR <prasanth.ksr@dell.com>,
        Divya Bharathi <divya.bharathi@dell.com>
Subject: [PATCH v2] platform/x86: dell-wmi-sysman: Make populate_foo_data functions more robust
Date:   Wed, 12 May 2021 15:55:30 +0530
Message-Id: <20210512102530.9704-1-prasanth.ksr@dell.com>
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

Changes from v1 to v2:
 - added a missed boundary check for enum next object
 - removed the fix for errors reported by checkpatch as it is unrelated to this patch
---
 .../dell/dell-wmi-sysman/dell-wmi-sysman.h    |  5 ++-
 .../dell/dell-wmi-sysman/enum-attributes.c    | 39 ++++++++++++++++---
 .../x86/dell/dell-wmi-sysman/int-attributes.c | 16 ++++++++
 .../dell/dell-wmi-sysman/passobj-attributes.c |  6 +++
 .../dell/dell-wmi-sysman/string-attributes.c  | 16 +++++++-
 .../x86/dell/dell-wmi-sysman/sysman.c         |  3 +-
 6 files changed, 77 insertions(+), 8 deletions(-)

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
index 091e48c217ed..8cc212c85266 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
@@ -132,39 +132,68 @@ int alloc_enum_data(void)
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
+	if (next_obj >= enum_property_count)
+		return -EINVAL;
+
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
index c8d276d78e92..d21e84c7a694 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -481,7 +481,8 @@ static int init_bios_attributes(int attr_type, const char *guid)
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

