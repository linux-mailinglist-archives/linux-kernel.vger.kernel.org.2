Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD731518F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhBIO3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhBIO3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:29:42 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996EC061786;
        Tue,  9 Feb 2021 06:29:02 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u143so5784153pfc.7;
        Tue, 09 Feb 2021 06:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9IpMSy5FX8XquOJz85ykF72hqrwrUvMmr3WRilD7Tc=;
        b=EhtR1w+yykO3ubHRTJzEZ3vk5dRGskNDGJJO10TNjGtSkdWkPffUs0SpsE6jEYo5a9
         QwJY7tpe61K6xuT+dpqhxBAidMEcOBf1Awh5ljsUOi+qR2T+96JbO+1r7IrC13duRdDB
         bqp3BPacef9/SP5mhEY7duAjFpcZilFqsns058UjQG2XQLlp0MwssbrnS+p4LUlLUErk
         6SJ4UypGsuKVXHCvADZ48ZqIfsMYBM853IVKTtQc90cepYBESEuHwJKUc633KDMadbc5
         ko4OOr9ipDj4Kx+gqS0Zv2HNnPXwMitixTEzzaLTHQodeHJHx/dQN4QteFCpzGRrazL5
         IDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9IpMSy5FX8XquOJz85ykF72hqrwrUvMmr3WRilD7Tc=;
        b=UR97gUZIAQHwlrLIcfemT2vf7ctISF5se3jOzXnCqPlRsSyxngKuKOfICZJKnLKybX
         hASlw1kYOoD7TMZKLkCDb9Fno5oDHA3Y+LOsxv6RuTsN3BViz58H76f4DF2ZKXOiB04v
         rjg/jA78GCHRv7jionUbYrH2erFzu75QdZpF9Ih6KiXaA30NWsDVcD+3nD1KphAfyt0q
         bfLnW6HGLJ1k3bRceJFh1ygQryAUDAy3eDy3JUOdVV25fA/M1DssDsq5zIggCTimJs3K
         mdCA89JHtQoX+2mYsTdYd/4tXbA1f88d3JJzHRobefSEptKV+PrTN0gbddh0kBhnAeJW
         EftQ==
X-Gm-Message-State: AOAM532SFcTgO/V2Gw2SUwXSFaQQ827zaGXcUfopv4iH96f0K8hTl4BA
        vRJZV5b8UYM6iM8GFpKAlec=
X-Google-Smtp-Source: ABdhPJzKFttlNwAu85FOnIBa7bnY5Qz4f3SMtCWYZt2gS//zZQAF5g8C97LyKq6f8TwqoBqhlJIMAw==
X-Received: by 2002:a05:6a00:a8d:b029:1ba:71d1:fe3c with SMTP id b13-20020a056a000a8db02901ba71d1fe3cmr22903777pfl.51.1612880941242;
        Tue, 09 Feb 2021 06:29:01 -0800 (PST)
Received: from localhost.localdomain ([49.207.192.187])
        by smtp.gmail.com with ESMTPSA id v1sm22540396pga.63.2021.02.09.06.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:29:00 -0800 (PST)
From:   "Prasanth, KSR" <kosigiprasanth@gmail.com>
X-Google-Original-From: "Prasanth, KSR" <prasanth.ksr@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Prasanth KSR" <prasanth.ksr@dell.com>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] IOCTL support for dell-wmi-sysman driver
Date:   Tue,  9 Feb 2021 19:58:26 +0530
Message-Id: <20210209142826.42728-1-prasanth.ksr@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Prasanth KSR" <prasanth.ksr@dell.com>

Perform BIOS Management calls on supported Dell machines
through the Dell WMI System Management interface.

This interface provides IOCTL's to perform bundled
BIOS Setting transactions.

Cc: Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>
Co-developed-by: Divya Bharathi <divya.bharathi@dell.com>
Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>
Co-developed-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 Documentation/ABI/testing/dell-wmi-sysman     |  39 ++
 .../x86/dell-wmi-sysman/biosattr-interface.c  | 257 +++++++++--
 .../x86/dell-wmi-sysman/dell-wmi-sysman.h     |  20 +-
 .../x86/dell-wmi-sysman/enum-attributes.c     |  45 +-
 .../x86/dell-wmi-sysman/int-attributes.c      |  46 +-
 .../x86/dell-wmi-sysman/passobj-attributes.c  |  23 +
 .../x86/dell-wmi-sysman/string-attributes.c   |  50 +-
 drivers/platform/x86/dell-wmi-sysman/sysman.c |  48 +-
 include/uapi/linux/wmi.h                      |  56 +++
 tools/dell-wmi-sysman/Makefile                |  19 +
 .../dell-wmi-sysman/dell-wmi-sysman-example.c | 432 ++++++++++++++++++
 11 files changed, 946 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/ABI/testing/dell-wmi-sysman
 create mode 100644 tools/dell-wmi-sysman/Makefile
 create mode 100644 tools/dell-wmi-sysman/dell-wmi-sysman-example.c

diff --git a/Documentation/ABI/testing/dell-wmi-sysman b/Documentation/ABI/testing/dell-wmi-sysman
new file mode 100644
index 000000000000..4f3883529a06
--- /dev/null
+++ b/Documentation/ABI/testing/dell-wmi-sysman
@@ -0,0 +1,39 @@
+What:		/dev/wmi/dell-wmi-sysman
+Date:		November 2021
+KernelVersion:	5.15
+Contact:	"Divya Bharathi" <divya.bharathi@dell.com>
+		"Mario Limonciello" <mario.limonciello@dell.com>
+		"Prasanth K S R" <prasanth.ksr@dell.com>
+Description:
+		Perform BIOS Management calls on supported Dell machines
+		through the Dell WMI System Management interface.
+
+		This interface provides IOCTL's to perform bundled
+		BIOS Setting transactions.
+
+		IOCTL's and buffer formats are defined in:
+		<uapi/linux/wmi.h>
+
+		1) To perform a BIOS System Management call from userspace,
+		you'll need to first determine the minimum size of the
+		system management interface buffer for your machine.
+		Platforms that contain larger buffers can return larger
+		objects from the system firmware.
+		Commonly this size is either 4k or 32k.
+
+		To determine the size of the buffer read() a u64 dword from
+		the WMI character device /dev/wmi/dell-wmi-sysman.
+
+		2) After you've determined the minimum size of the system management
+		interface buffer, you can allocate a structure that represents
+		the structure documented above (struct dell_wmi_sysman_buffer).
+
+		3) In this buffer object, prepare as necessary for the BIOS System
+		Management call you're interested in. Typically System Management
+		buffers have "length", "command" , "count" and "admin_password"
+		defined to values that coincide with the "data" you are interested in.
+
+		4) Run the call by using ioctl() as described in the header.
+
+		5) The output will be returned in the buffer object and
+		make sure to free up the allocated buffer.
diff --git a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
index f95d8ddace5a..9a82e78fe59e 100644
--- a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
+++ b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
@@ -6,12 +6,14 @@
  *  Copyright (c) 2020 Dell Inc.
  */
 
+#include <uapi/linux/wmi.h>
 #include <linux/wmi.h>
 #include "dell-wmi-sysman.h"
 
 #define SETDEFAULTVALUES_METHOD_ID					0x02
 #define SETBIOSDEFAULTS_METHOD_ID					0x03
 #define SETATTRIBUTE_METHOD_ID						0x04
+#define SETATTRIBUTES_METHOD_ID						0x05
 
 static int call_biosattributes_interface(struct wmi_device *wdev, char *in_args, size_t size,
 					int method_id)
@@ -41,17 +43,17 @@ static int call_biosattributes_interface(struct wmi_device *wdev, char *in_args,
 }
 
 /**
- * set_attribute() - Update an attribute value
- * @a_name: The attribute name
- * @a_value: The attribute value
+ * set_bios_defaults() - Resets BIOS defaults
+ * @deftype: the type of BIOS value reset to issue.
  *
- * Sets an attribute to new value
+ * Resets BIOS defaults
  */
-int set_attribute(const char *a_name, const char *a_value)
+int set_bios_defaults(u8 deftype)
 {
 	size_t security_area_size, buffer_size;
-	size_t a_name_size, a_value_size;
-	char *buffer = NULL, *start;
+	size_t integer_area_size = sizeof(u8);
+	char *buffer = NULL;
+	u8 *defaultType;
 	int ret;
 
 	mutex_lock(&wmi_priv.mutex);
@@ -60,11 +62,8 @@ int set_attribute(const char *a_name, const char *a_value)
 		goto out;
 	}
 
-	/* build/calculate buffer */
 	security_area_size = calculate_security_buffer(wmi_priv.current_admin_password);
-	a_name_size = calculate_string_buffer(a_name);
-	a_value_size = calculate_string_buffer(a_value);
-	buffer_size = security_area_size + a_name_size + a_value_size;
+	buffer_size = security_area_size + integer_area_size;
 	buffer = kzalloc(buffer_size, GFP_KERNEL);
 	if (!buffer) {
 		ret = -ENOMEM;
@@ -74,44 +73,51 @@ int set_attribute(const char *a_name, const char *a_value)
 	/* build security area */
 	populate_security_buffer(buffer, wmi_priv.current_admin_password);
 
-	/* build variables to set */
-	start = buffer + security_area_size;
-	ret = populate_string_buffer(start, a_name_size, a_name);
-	if (ret < 0)
-		goto out;
-	start += ret;
-	ret = populate_string_buffer(start, a_value_size, a_value);
-	if (ret < 0)
-		goto out;
+	defaultType = buffer + security_area_size;
+	*defaultType = deftype;
 
-	print_hex_dump_bytes("set attribute data: ", DUMP_PREFIX_NONE, buffer, buffer_size);
-	ret = call_biosattributes_interface(wmi_priv.bios_attr_wdev,
-					    buffer, buffer_size,
-					    SETATTRIBUTE_METHOD_ID);
-	if (ret == -EOPNOTSUPP)
-		dev_err(&wmi_priv.bios_attr_wdev->dev, "admin password must be configured\n");
-	else if (ret == -EACCES)
-		dev_err(&wmi_priv.bios_attr_wdev->dev, "invalid password\n");
+	ret = call_biosattributes_interface(wmi_priv.bios_attr_wdev, buffer, buffer_size,
+					    SETBIOSDEFAULTS_METHOD_ID);
+	if (ret)
+		dev_err(&wmi_priv.bios_attr_wdev->dev, "reset BIOS defaults failed: %d\n", ret);
 
-out:
 	kfree(buffer);
+out:
 	mutex_unlock(&wmi_priv.mutex);
 	return ret;
 }
 
 /**
- * set_bios_defaults() - Resets BIOS defaults
- * @deftype: the type of BIOS value reset to issue.
+ * calculate_array_length() - calculate total size of string array
+ * @str_arr: array of strings
+ * @str_count: string count
  *
- * Resets BIOS defaults
- */
-int set_bios_defaults(u8 deftype)
+ * Method to calculate the total size of array of string
+ **/
+static int calculate_array_length(char **str_arr, int str_count)
 {
-	size_t security_area_size, buffer_size;
-	size_t integer_area_size = sizeof(u8);
-	char *buffer = NULL;
-	u8 *defaultType;
-	int ret;
+	int ret = 0, i;
+
+	for (i = 0; i < str_count; ++i)
+		ret += calculate_string_buffer(str_arr[i]);
+	return ret;
+}
+
+/**
+ * set_attributes() - Update multiple attribute values
+ * @in_data: input set data
+ * @a_count: Number of atributes to be set
+ * @command: command to decide set user input value or default
+ *
+ * Sets attributes to user input value of defaut value
+ **/
+int set_attributes(struct dell_set_data *in_data, int a_count, unsigned short command)
+{
+	size_t security_area_size, string_area_size, buffer_size, attr_count_area;
+	char **a_names, **a_values;
+	char *buffer = NULL, *start;
+	int ret, method_id, i;
+	u32 *attr_count;
 
 	mutex_lock(&wmi_priv.mutex);
 	if (!wmi_priv.bios_attr_wdev) {
@@ -119,8 +125,34 @@ int set_bios_defaults(u8 deftype)
 		goto out;
 	}
 
+	//allocate memory to hold set inputs
+	a_names = kmalloc(a_count * (sizeof(char *)), GFP_KERNEL);
+	if (!a_names) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	if (command == SET_ATTRIBUTES) {
+		a_values = kmalloc(a_count * (sizeof(char *)), GFP_KERNEL);
+		if (!a_values) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	//assign inputs to single array and send to set functions
+	for (i = 0; i < a_count; i++) {
+		a_names[i] = in_data[i].attribute_name;
+		if (command == SET_ATTRIBUTES)
+			a_values[i] = in_data[i].attribute_value;
+	}
+
 	security_area_size = calculate_security_buffer(wmi_priv.current_admin_password);
-	buffer_size = security_area_size + integer_area_size;
+	attr_count_area = sizeof(u32);
+	string_area_size = (calculate_array_length(a_names, a_count));
+	if (command == SET_ATTRIBUTES)
+		string_area_size += (calculate_array_length(a_values, a_count));
+	buffer_size = security_area_size + attr_count_area + string_area_size
+					+ (sizeof(u16) * a_count);
 	buffer = kzalloc(buffer_size, GFP_KERNEL);
 	if (!buffer) {
 		ret = -ENOMEM;
@@ -130,26 +162,153 @@ int set_bios_defaults(u8 deftype)
 	/* build security area */
 	populate_security_buffer(buffer, wmi_priv.current_admin_password);
 
-	defaultType = buffer + security_area_size;
-	*defaultType = deftype;
+	/* build variables to set */
+	attr_count = (u32 *)(buffer + security_area_size);
+	*attr_count = (u32)a_count;
+	start =  (u8 *)(attr_count) + attr_count_area;
 
-	ret = call_biosattributes_interface(wmi_priv.bios_attr_wdev, buffer, buffer_size,
-					    SETBIOSDEFAULTS_METHOD_ID);
-	if (ret)
-		dev_err(&wmi_priv.bios_attr_wdev->dev, "reset BIOS defaults failed: %d\n", ret);
+	for (i = 0; i < a_count; i++) {
+		ret = populate_string_buffer(start, calculate_string_buffer(a_names[i]),
+						a_names[i]);
+		if (ret < 0)
+			goto out;
+		start += ret;
+	}
+
+	if (command == SET_ATTRIBUTES) {
+		for (i = 0; i < a_count; i++) {
+			ret = populate_string_buffer(start, calculate_string_buffer(a_values[i]),
+							a_values[i]);
+			if (ret < 0)
+				goto out;
+			start += ret;
+		}
+		method_id = SETATTRIBUTES_METHOD_ID;
+	} else {
+		method_id = SETDEFAULTVALUES_METHOD_ID;
+	}
+
+	print_hex_dump_bytes("set multiple attribute: ", DUMP_PREFIX_NONE, buffer, buffer_size);
+	ret = call_biosattributes_interface(wmi_priv.bios_attr_wdev,
+					    buffer, buffer_size, method_id);
+
+	if (ret == -EOPNOTSUPP)
+		dev_err(&wmi_priv.password_attr_wdev->dev, "admin password must be configured\n");
+	else if (ret == -EACCES)
+		dev_err(&wmi_priv.password_attr_wdev->dev, "invalid password\n");
 
-	kfree(buffer);
 out:
+	kfree(buffer);
+	kfree(a_names);
+	if (command == SET_ATTRIBUTES)
+		kfree(a_values);
 	mutex_unlock(&wmi_priv.mutex);
 	return ret;
 }
 
+__u64 get_attrs_size(void)
+{
+	__u64 size = sizeof(struct dell_attributes_data) *
+				(get_instance_count(DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID) +
+				get_instance_count(DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID) +
+				get_instance_count(DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID));
+	return size;
+}
+
+int run_sysman_call(struct dell_wmi_sysman_buffer *buf)
+{
+	struct dell_set_password *pass_set_data;
+	struct dell_set_data *in_data;
+	int ret = -ENOIOCTLCMD;
+	char *tmp_system = NULL;
+	char *tmp_admin = NULL;
+
+	switch (buf->command) {
+	case ENUMERATE_ALL:
+		buf->count = get_attrs_size() / sizeof(struct dell_attributes_data);
+		get_enumeration_data(buf);
+		get_integer_data(buf);
+		get_string_data(buf);
+		ret = 0;
+		break;
+	case SET_ATTRIBUTES:
+	case SET_DEFAULTS:
+		if (!buf->count)
+			goto out;
+		in_data = (struct dell_set_data *)buf->data;
+		tmp_admin = kstrdup(wmi_priv.current_admin_password, GFP_KERNEL);
+		strlcpy_attr(wmi_priv.current_admin_password, buf->admin_password);
+		ret = set_attributes(in_data, buf->count, buf->command);
+		strlcpy_attr(wmi_priv.current_admin_password, tmp_admin);
+		kfree(tmp_admin);
+		break;
+	case GET_PASS:
+		get_po_data(buf);
+		ret = 0;
+		break;
+	case SET_PASS:
+		pass_set_data = (struct dell_set_password *)buf->data;
+		tmp_admin = kstrdup(wmi_priv.current_admin_password, GFP_KERNEL);
+		strlcpy_attr(wmi_priv.current_admin_password, buf->admin_password);
+
+		if (strcmp(pass_set_data->attribute_name, "System") == 0) {
+			tmp_system = kstrdup(wmi_priv.current_system_password, GFP_KERNEL);
+			strlcpy_attr(wmi_priv.current_system_password,
+					pass_set_data->system_password);
+		}
+
+		ret = set_new_password(pass_set_data->attribute_name, pass_set_data->new_password);
+		strlcpy_attr(wmi_priv.current_admin_password, tmp_admin);
+		kfree(tmp_admin);
+
+		if (tmp_system != NULL) {
+			strlcpy_attr(wmi_priv.current_system_password, tmp_system);
+			kfree(tmp_system);
+		}
+		break;
+	}
+out:
+	return ret;
+}
+
+
+static long bios_attr_set_interface_filter(struct wmi_device *wdev, unsigned int cmd,
+				   struct wmi_ioctl_buffer *arg)
+{
+	struct dell_wmi_sysman_buffer *buf;
+	struct dell_resetBIOS *reset_buf;
+	char *tmp_admin = NULL;
+	int ret = -ENOIOCTLCMD;
+
+	switch (cmd) {
+	case DELL_WMI_SYSMAN_CMD:
+		buf = (struct dell_wmi_sysman_buffer *) arg;
+		ret = run_sysman_call(buf);
+		break;
+	case DELL_WMI_SYSMAN_RESET_BIOS:
+		reset_buf = (struct dell_resetBIOS *) arg;
+		if (reset_buf->option > 0) {
+			tmp_admin = kstrdup(wmi_priv.current_admin_password, GFP_KERNEL);
+			strlcpy_attr(wmi_priv.current_admin_password, reset_buf->admin_password);
+			ret = set_bios_defaults(reset_buf->option);
+			strlcpy_attr(wmi_priv.current_admin_password, tmp_admin);
+			kfree(tmp_admin);
+		}
+		break;
+	}
+	return ret;
+}
+
 static int bios_attr_set_interface_probe(struct wmi_device *wdev, const void *context)
 {
+	__u32 req_buf_size;
 	mutex_lock(&wmi_priv.mutex);
 	wmi_priv.bios_attr_wdev = wdev;
 	mutex_unlock(&wmi_priv.mutex);
-	return 0;
+	req_buf_size = get_attrs_size();
+	/* add in size of struct dell_wmi_sysman_buffer which is used internally with ioctl */
+	req_buf_size += sizeof(struct dell_wmi_sysman_buffer);
+	return set_required_buffer_size(wdev, req_buf_size);
 }
 
 static int bios_attr_set_interface_remove(struct wmi_device *wdev)
@@ -171,6 +330,7 @@ static struct wmi_driver bios_attr_set_interface_driver = {
 	.probe = bios_attr_set_interface_probe,
 	.remove = bios_attr_set_interface_remove,
 	.id_table = bios_attr_set_interface_id_table,
+	.filter_callback = bios_attr_set_interface_filter
 };
 
 int init_bios_attr_set_interface(void)
@@ -184,3 +344,4 @@ void exit_bios_attr_set_interface(void)
 }
 
 MODULE_DEVICE_TABLE(wmi, bios_attr_set_interface_id_table);
+
diff --git a/drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h b/drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h
index b80f2a62ea3f..13c216e6ddec 100644
--- a/drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h
+++ b/drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h
@@ -8,6 +8,7 @@
 #define _DELL_WMI_BIOS_ATTR_H_
 
 #include <linux/wmi.h>
+#include <uapi/linux/wmi.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -87,8 +88,6 @@ struct wmi_sysman_priv {
 /* global structure used by multiple WMI interfaces */
 extern struct wmi_sysman_priv wmi_priv;
 
-enum { ENUM, INT, STR, PO };
-
 enum {
 	ATTR_NAME,
 	DISPL_NAME_LANG_CODE,
@@ -134,6 +133,7 @@ static ssize_t curr_val##_store(struct kobject *kobj,				\
 				struct kobj_attribute *attr,			\
 				const char *buf, size_t count)			\
 {										\
+	struct dell_set_data *set_data;						\
 	char *p, *buf_cp;							\
 	int i, ret = -EIO;							\
 	buf_cp = kstrdup(buf, GFP_KERNEL);					\
@@ -146,15 +146,19 @@ static ssize_t curr_val##_store(struct kobject *kobj,				\
 	i = get_##type##_instance_id(kobj);					\
 	if (i >= 0)								\
 		ret = validate_##type##_input(i, buf_cp);			\
+	set_data = kzalloc(sizeof(*set_data), GFP_KERNEL);			\
+	strlcpy_attr(set_data[0].attribute_value, buf_cp);			\
+	strlcpy_attr(set_data[0].attribute_name, kobj->name);			\
 	if (!ret)								\
-		ret = set_attribute(kobj->name, buf_cp);			\
+		ret = set_attributes(set_data, 1, SET_ATTRIBUTES);		\
 	kfree(buf_cp);								\
 	return ret ? ret : count;						\
 }
 
 union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string);
 int get_instance_count(const char *guid_string);
-void strlcpy_attr(char *dest, char *src);
+int get_current_value(char *buf, int instance_id, const char *guid_string);
+void strlcpy_attr(char *dest, const char *src);
 
 int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
 			struct kobject *attr_name_kobj);
@@ -174,7 +178,7 @@ int populate_po_data(union acpi_object *po_obj, int instance_id, struct kobject
 int alloc_po_data(void);
 void exit_po_attributes(void);
 
-int set_attribute(const char *a_name, const char *a_value);
+int set_attributes(struct dell_set_data *in_data, int a_count, unsigned short command);
 int set_bios_defaults(u8 defType);
 
 void exit_bios_attr_set_interface(void);
@@ -188,4 +192,10 @@ int set_new_password(const char *password_type, const char *new);
 int init_bios_attr_pass_interface(void);
 void exit_bios_attr_pass_interface(void);
 
+__u64 get_attrs_size(void);
+void get_enumeration_data(struct dell_wmi_sysman_buffer *buf);
+void get_integer_data(struct dell_wmi_sysman_buffer *buf);
+void get_string_data(struct dell_wmi_sysman_buffer *buf);
+void get_po_data(struct dell_wmi_sysman_buffer *attr_data);
+
 #endif
diff --git a/drivers/platform/x86/dell-wmi-sysman/enum-attributes.c b/drivers/platform/x86/dell-wmi-sysman/enum-attributes.c
index 80f4b7785c6c..b23e10ac00da 100644
--- a/drivers/platform/x86/dell-wmi-sysman/enum-attributes.c
+++ b/drivers/platform/x86/dell-wmi-sysman/enum-attributes.c
@@ -13,22 +13,17 @@ get_instance_id(enumeration);
 static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	int instance_id = get_enumeration_instance_id(kobj);
-	union acpi_object *obj;
-	ssize_t ret;
+	int ret;
 
 	if (instance_id < 0)
 		return instance_id;
 
-	/* need to use specific instance_id and guid combination to get right data */
-	obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
-	if (!obj)
-		return -EIO;
-	if (obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_STRING) {
-		kfree(obj);
-		return -EINVAL;
+	ret = get_current_value(buf, instance_id, DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
+	if (ret > 0) {
+		strcat(buf, "\n");
+		return strlen(buf);
 	}
-	ret = snprintf(buf, PAGE_SIZE, "%s\n", obj->package.elements[CURRENT_VAL].string.pointer);
-	kfree(obj);
+	/* read error */
 	return ret;
 }
 
@@ -171,6 +166,34 @@ int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
 	return sysfs_create_group(attr_name_kobj, &enumeration_attr_group);
 }
 
+void get_enumeration_data(struct dell_wmi_sysman_buffer *buf)
+{
+	struct dell_attributes_data *attr_data;
+	int i;
+
+	attr_data = (struct dell_attributes_data *)buf->data;
+	for (i = 0; i < wmi_priv.enumeration_instances_count; i++) {
+		attr_data[i].type = ENUM;
+		strlcpy_attr(attr_data[i].attribute_name,
+					wmi_priv.enumeration_data[i].attribute_name);
+		strlcpy_attr(attr_data[i].display_name,
+					wmi_priv.enumeration_data[i].display_name);
+		strlcpy_attr(attr_data[i].display_name_language_code,
+					wmi_priv.enumeration_data[i].display_name_language_code);
+		strlcpy_attr(attr_data[i].possible_values,
+					wmi_priv.enumeration_data[i].possible_values);
+		strlcpy_attr(attr_data[i].dell_modifier,
+					wmi_priv.enumeration_data[i].dell_modifier);
+		strlcpy_attr(attr_data[i].dell_value_modifier,
+					wmi_priv.enumeration_data[i].dell_value_modifier);
+		strlcpy_attr(attr_data[i].default_value,
+					wmi_priv.enumeration_data[i].default_value);
+		get_current_value(attr_data[i].current_value, i,
+					DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
+
+	}
+}
+
 /**
  * exit_enum_attributes() - Clear all attribute data
  *
diff --git a/drivers/platform/x86/dell-wmi-sysman/int-attributes.c b/drivers/platform/x86/dell-wmi-sysman/int-attributes.c
index 75aedbb733be..0155f6189576 100644
--- a/drivers/platform/x86/dell-wmi-sysman/int-attributes.c
+++ b/drivers/platform/x86/dell-wmi-sysman/int-attributes.c
@@ -15,22 +15,17 @@ get_instance_id(integer);
 static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	int instance_id = get_integer_instance_id(kobj);
-	union acpi_object *obj;
-	ssize_t ret;
+	int ret;
 
 	if (instance_id < 0)
 		return instance_id;
 
-	/* need to use specific instance_id and guid combination to get right data */
-	obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
-	if (!obj)
-		return -EIO;
-	if (obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_INTEGER) {
-		kfree(obj);
-		return -EINVAL;
+	ret = get_current_value(buf, instance_id, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
+	if (ret > 0) {
+		strcat(buf, "\n");
+		return strlen(buf);
 	}
-	ret = snprintf(buf, PAGE_SIZE, "%lld\n", obj->package.elements[CURRENT_VAL].integer.value);
-	kfree(obj);
+	/* read error */
 	return ret;
 }
 
@@ -161,6 +156,35 @@ int populate_int_data(union acpi_object *integer_obj, int instance_id,
 	return sysfs_create_group(attr_name_kobj, &integer_attr_group);
 }
 
+void get_integer_data(struct dell_wmi_sysman_buffer *buf)
+{
+	struct dell_attributes_data *attr_data;
+	int i;
+	//To populate in same dell_attributes_data, increment after enum data
+	int a_count = wmi_priv.enumeration_instances_count;
+
+	attr_data = (struct dell_attributes_data *)buf->data;
+	for (i = 0; i < wmi_priv.integer_instances_count; i++) {
+		attr_data[a_count].type = INT;
+		strlcpy_attr(attr_data[a_count].attribute_name,
+					wmi_priv.integer_data[i].attribute_name);
+		strlcpy_attr(attr_data[a_count].display_name,
+					wmi_priv.integer_data[i].display_name);
+		strlcpy_attr(attr_data[a_count].display_name_language_code,
+					wmi_priv.integer_data[i].display_name_language_code);
+		strlcpy_attr(attr_data[a_count].dell_modifier,
+					wmi_priv.integer_data[i].dell_modifier);
+		attr_data[a_count].min = wmi_priv.integer_data[i].min_value;
+		attr_data[a_count].max = wmi_priv.integer_data[i].max_value;
+		attr_data[a_count].scalar_increment = wmi_priv.integer_data[i].scalar_increment;
+		snprintf(attr_data[a_count].default_value, PAGE_SIZE, "%d",
+				wmi_priv.integer_data[i].default_value);
+		get_current_value(attr_data[a_count].current_value, i,
+				DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
+		a_count++;
+	}
+}
+
 /**
  * exit_int_attributes() - Clear all attribute data
  *
diff --git a/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
index 3abcd95477c0..9f50989a9f44 100644
--- a/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
+++ b/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
@@ -169,6 +169,29 @@ int populate_po_data(union acpi_object *po_obj, int instance_id, struct kobject
 	return sysfs_create_group(attr_name_kobj, &po_attr_group);
 }
 
+void get_po_data(struct dell_wmi_sysman_buffer *in_data)
+{
+	int i;
+	struct dell_password_data *attr_data;
+
+	in_data->count = wmi_priv.po_instances_count;
+	attr_data = (struct dell_password_data *)in_data->data;
+	for (i = 0; i < wmi_priv.po_instances_count; i++) {
+		union acpi_object *obj;
+
+		strlcpy_attr(attr_data[i].attribute_name,
+						wmi_priv.po_data[i].attribute_name);
+		attr_data[i].min_length = wmi_priv.po_data[i].min_password_length;
+		attr_data[i].max_length = wmi_priv.po_data[i].max_password_length;
+
+		obj = get_wmiobj_pointer(i, DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID);
+		if (!obj)
+			continue;
+		attr_data[i].is_set = obj->package.elements[IS_PASS_SET].integer.value;
+		kfree(obj);
+	}
+}
+
 /**
  * exit_po_attributes() - Clear all attribute data
  *
diff --git a/drivers/platform/x86/dell-wmi-sysman/string-attributes.c b/drivers/platform/x86/dell-wmi-sysman/string-attributes.c
index ac75dce88a4c..a3847e4a6bf8 100644
--- a/drivers/platform/x86/dell-wmi-sysman/string-attributes.c
+++ b/drivers/platform/x86/dell-wmi-sysman/string-attributes.c
@@ -15,22 +15,17 @@ get_instance_id(str);
 static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	int instance_id = get_str_instance_id(kobj);
-	union acpi_object *obj;
-	ssize_t ret;
+	int ret;
 
 	if (instance_id < 0)
-		return -EIO;
-
-	/* need to use specific instance_id and guid combination to get right data */
-	obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
-	if (!obj)
-		return -EIO;
-	if (obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_STRING) {
-		kfree(obj);
-		return -EINVAL;
+		return instance_id;
+
+	ret = get_current_value(buf, instance_id, DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
+	if (ret > 0) {
+		strcat(buf, "\n");
+		return strlen(buf);
 	}
-	ret = snprintf(buf, PAGE_SIZE, "%s\n", obj->package.elements[CURRENT_VAL].string.pointer);
-	kfree(obj);
+	/* read error */
 	return ret;
 }
 
@@ -141,6 +136,35 @@ int populate_str_data(union acpi_object *str_obj, int instance_id, struct kobjec
 	return sysfs_create_group(attr_name_kobj, &str_attr_group);
 }
 
+void get_string_data(struct dell_wmi_sysman_buffer *buf)
+{
+	struct dell_attributes_data *attr_data;
+	int i;
+	//To populate in same dell_attributes_data, increment after enum+int data
+	int a_count = wmi_priv.enumeration_instances_count +
+					wmi_priv.integer_instances_count;
+	attr_data = (struct dell_attributes_data *)buf->data;
+
+	for (i = 0; i < wmi_priv.str_instances_count; i++) {
+		attr_data[a_count].type = STR;
+		strlcpy_attr(attr_data[a_count].attribute_name,
+						wmi_priv.str_data[i].attribute_name);
+		strlcpy_attr(attr_data[a_count].display_name,
+						wmi_priv.str_data[i].display_name);
+		strlcpy_attr(attr_data[a_count].display_name_language_code,
+						wmi_priv.str_data[i].display_name_language_code);
+		strlcpy_attr(attr_data[a_count].dell_modifier,
+						wmi_priv.str_data[i].dell_modifier);
+		attr_data[a_count].min = wmi_priv.str_data[i].min_length;
+		attr_data[a_count].max = wmi_priv.str_data[i].max_length;
+		strlcpy_attr(attr_data[a_count].default_value,
+						wmi_priv.str_data[i].default_value);
+		get_current_value(attr_data[a_count].current_value, i,
+				DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
+		a_count++;
+	}
+}
+
 /**
  * exit_str_attributes() - Clear all attribute data
  *
diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell-wmi-sysman/sysman.c
index cb81010ba1a2..0b77a6a0b8a8 100644
--- a/drivers/platform/x86/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
@@ -275,7 +275,7 @@ static struct kobj_type attr_name_ktype = {
  * @dest: Where to copy the string to
  * @src: Where to copy the string from
  */
-void strlcpy_attr(char *dest, char *src)
+void strlcpy_attr(char *dest, const char *src)
 {
 	size_t len = strlen(src) + 1;
 
@@ -307,6 +307,52 @@ union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string)
 	return ACPI_SUCCESS(status) ? (union acpi_object *)out.pointer : NULL;
 }
 
+int validate_acpi_type(union acpi_object *obj, const char *guid_string)
+{
+	u32 acpi_type;
+
+	if (strcmp(guid_string, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID) == 0)
+		acpi_type = ACPI_TYPE_INTEGER;
+	else
+		acpi_type = ACPI_TYPE_STRING;
+
+	if (obj->package.elements[CURRENT_VAL].type != acpi_type)
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * get_curret_value() - Get current_value of an attribute
+ * @instance_id: WMI instance ID
+ * @guid_string: WMI GUID (in string form)
+ */
+int get_current_value(char *buf, int instance_id, const char *guid_string)
+{
+	union acpi_object *obj;
+	int ret;
+
+	/* need to use specific instance_id and guid combination to get right data */
+	obj = get_wmiobj_pointer(instance_id, guid_string);
+	if (!obj)
+		return -EIO;
+
+	ret = validate_acpi_type(obj, guid_string);
+	if (ret)
+		goto out;
+
+	if (strcmp(guid_string, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID) == 0)
+		ret = snprintf(buf, PAGE_SIZE, "%lld",
+				obj->package.elements[CURRENT_VAL].integer.value);
+	else
+		ret = snprintf(buf, PAGE_SIZE, "%s",
+				obj->package.elements[CURRENT_VAL].string.pointer);
+
+out:
+	kfree(obj);
+	return ret;
+}
+
 /**
  * get_instance_count() - Compute total number of instances under guid_string
  * @guid_string: WMI GUID (in string form)
diff --git a/include/uapi/linux/wmi.h b/include/uapi/linux/wmi.h
index 7085c5dca9fa..f160d1eef7cb 100644
--- a/include/uapi/linux/wmi.h
+++ b/include/uapi/linux/wmi.h
@@ -13,6 +13,11 @@
 /* WMI bus will filter all WMI vendor driver requests through this IOC */
 #define WMI_IOC 'W'
 
+enum BIOS_ATTRIBUTE_TYPE { ENUM, INT, STR, PO };
+enum IOCTL_COMMAND { ENUMERATE_ALL = 1, SET_ATTRIBUTES, SET_DEFAULTS, GET_PASS, SET_PASS };
+
+#define MAX_BUFF  512
+
 /* All ioctl requests through WMI should declare their size followed by
  * relevant data objects
  */
@@ -43,6 +48,53 @@ struct dell_wmi_smbios_buffer {
 	struct dell_wmi_extensions	ext;
 } __packed;
 
+struct dell_wmi_sysman_buffer {
+	__u64 length;
+	__u32 count;
+	__u16 command;
+	char admin_password[MAX_BUFF];
+	__u8 data[];
+} __packed;
+
+struct dell_attributes_data {
+	char display_name_language_code[MAX_BUFF];
+	char dell_value_modifier[MAX_BUFF];
+	char possible_values[MAX_BUFF];
+	char attribute_name[MAX_BUFF];
+	char current_value[MAX_BUFF];
+	char default_value[MAX_BUFF];
+	char dell_modifier[MAX_BUFF];
+	char display_name[MAX_BUFF];
+	int scalar_increment;
+	int type;
+	int min;
+	int max;
+} __packed;
+
+struct dell_set_data {
+	char attribute_name[MAX_BUFF];
+	char attribute_value[MAX_BUFF];
+} __packed;
+
+struct dell_set_password {
+	char attribute_name[MAX_BUFF];
+	char system_password[MAX_BUFF];
+	char new_password[MAX_BUFF];
+} __packed;
+
+struct dell_password_data {
+	char attribute_name[MAX_BUFF];
+	__u8 is_set;
+	int min_length;
+	int max_length;
+} __packed;
+
+struct dell_resetBIOS {
+	__u64 length;
+	__u8 option;
+	char admin_password[MAX_BUFF];
+} __packed;
+
 /* Whitelisted smbios class/select commands */
 #define CLASS_TOKEN_READ	0
 #define CLASS_TOKEN_WRITE	1
@@ -67,4 +119,8 @@ struct dell_wmi_smbios_buffer {
 /* Dell SMBIOS calling IOCTL command used by dell-smbios-wmi */
 #define DELL_WMI_SMBIOS_CMD	_IOWR(WMI_IOC, 0, struct dell_wmi_smbios_buffer)
 
+/* Dell WMI System Management calling IOCTL commands used by dell-wmi-sysman */
+#define DELL_WMI_SYSMAN_CMD _IOWR(WMI_IOC, 0, struct dell_wmi_sysman_buffer)
+#define DELL_WMI_SYSMAN_RESET_BIOS _IOW(WMI_IOC, 0, struct dell_resetBIOS)
+
 #endif
diff --git a/tools/dell-wmi-sysman/Makefile b/tools/dell-wmi-sysman/Makefile
new file mode 100644
index 000000000000..0a01a82a0745
--- /dev/null
+++ b/tools/dell-wmi-sysman/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+PREFIX ?= /usr
+SBINDIR ?= sbin
+INSTALL ?= install
+CFLAGS += -D__EXPORTED_HEADERS__ -I../../include/uapi -I../../include -I./
+
+TARGET = dell-wmi-sysman-example
+
+all: $(TARGET)
+
+%: %.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -g -o $@ $<
+
+clean:
+	$(RM) $(TARGET)
+
+install: dell-wmi-sysman-example
+	$(INSTALL) -D -m 755 $(TARGET) $(DESTDIR)$(PREFIX)/$(SBINDIR)/$(TARGET)
+
diff --git a/tools/dell-wmi-sysman/dell-wmi-sysman-example.c b/tools/dell-wmi-sysman/dell-wmi-sysman-example.c
new file mode 100644
index 000000000000..50db8835cea6
--- /dev/null
+++ b/tools/dell-wmi-sysman/dell-wmi-sysman-example.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Sample application for system management over WMI interface
+ *  Performs the following:
+ *  - Enemeration of all BIOS attributes present in system
+ *  - Set BIOS atributes to user input or default
+ *	- Reset BIOS
+ *
+ *  Copyright (C) 2021 Dell, Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+#include <string.h>
+#include <ctype.h>
+
+/* if uapi header isn't installed, this might not yet exist */
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+#include <linux/wmi.h>
+
+enum USER_OPTS {GET_ATTRS = 1, SET_ATTRS, SET_DEFS, PASS_MAN, RESET, EXIT };
+enum PASS_OPTS {GET_PASSINFO = 1, SET_OR_CHANGE_PASS, CLEAR_PASS, BACK };
+
+static const char *ioctl_devfs = "/dev/wmi/dell-wmi-sysman";
+__u64 buff_size;
+
+static int query_buffer_size(__u64 *buffer_size)
+{
+	FILE *f = fopen(ioctl_devfs, "rb");
+
+	if (!f)
+		return -EINVAL;
+	fread(buffer_size, sizeof(__u64), 1, f);
+	fclose(f);
+	return EXIT_SUCCESS;
+}
+
+int read_integer_input(void)
+{
+	int val, in, c;
+	char follow;
+
+	while (1) {
+		in = scanf("%d%c", &val, &follow);
+		if (in == 2) {
+			if (isspace(follow))
+				return val;
+			printf("Invalid input! Try again...\nEnter - ");
+		} else if (in == 1) {
+			return val;
+		printf("Invalid input! Try again...\nEnter - ");
+		}
+
+		while ((c = getchar()) != '\n' && c != EOF)
+			;
+	}
+}
+
+static int call_ioctl(struct dell_wmi_sysman_buffer *buffer)
+{
+	int fd;
+	int ret;
+
+	fd = open(ioctl_devfs, O_NONBLOCK);
+	ret = ioctl(fd, DELL_WMI_SYSMAN_CMD, buffer);
+	close(fd);
+	return ret;
+}
+
+int is_password_set(unsigned char *password_type)
+{
+	int ret, i;
+	int is_set = 0;
+	struct dell_wmi_sysman_buffer *buff_pwd;
+	struct dell_password_data *indata;
+
+	buff_pwd = malloc(buff_size); //buff_size large enough to get password data
+	if (buff_pwd == NULL) {
+		printf("failed to alloc memory for ioctl\n");
+		return -ENOMEM;
+	}
+
+	buff_pwd->length = buff_size;
+	buff_pwd->command = GET_PASS;
+	call_ioctl(buff_pwd);
+
+	indata = (struct dell_password_data *)buff_pwd->data;
+
+	for (i = 0; i < buff_pwd->count; i++) {
+		if (strcmp(indata[i].attribute_name, password_type) == 0) {
+			is_set = indata[i].is_set;
+			break;
+		}
+	}
+
+	free(buff_pwd);
+	return is_set;
+}
+
+/* Enumerate functions start*/
+void display_attributes(struct dell_wmi_sysman_buffer *buff_all)
+{
+	struct dell_attributes_data *testdata;
+	int i;
+
+	testdata = (struct dell_attributes_data *)buff_all->data;
+	for (i = 0; i < buff_all->count; i++) {
+		printf("\n%d\n", (i + 1));
+		printf("AttributeName = %s\n", testdata[i].attribute_name);
+		printf("Display LangCode = %s\n", testdata[i].display_name_language_code);
+		printf("Display Name = %s\n", testdata[i].display_name);
+		printf("Modifier = %s\n", testdata[i].dell_modifier);
+		printf("Current Value = %s\n", testdata[i].current_value);
+		printf("Default Value = %s\n", testdata[i].default_value);
+		if (testdata[i].type == ENUM) {
+			printf("Value Modifier = %s\n", testdata[i].dell_value_modifier);
+			printf("PossibleValues = %s\n", testdata[i].possible_values);
+		}
+		if (testdata[i].type == INT) {
+			printf("Lower Bound = %d\n", testdata[i].min);
+			printf("Upper Bound = %d\n", testdata[i].max);
+			printf("Scalar incr = %d\n", testdata[i].scalar_increment);
+		}
+		if (testdata[i].type == STR) {
+			printf("Minimum Length = %d\n", testdata[i].min);
+			printf("Maximum Length = %d\n", testdata[i].max);
+		}
+	}
+	printf("---------------------------------------------------------\n");
+}
+
+void enumerate_all_attributes(void)
+{
+	struct dell_wmi_sysman_buffer *buff_all;
+	int ret;
+
+	buff_all = malloc(buff_size);
+	if (buff_all == NULL) {
+		printf("failed to alloc memory for ioctl\n");
+		return;
+	}
+	buff_all->length = buff_size;
+	buff_all->command = ENUMERATE_ALL;
+	ret = call_ioctl(buff_all);
+	if (ret) {
+		printf("smbios ioctl failed: %d\n", ret);
+		goto out;
+	}
+	display_attributes(buff_all);
+out:
+	if (buff_all != NULL)
+		free(buff_all);
+}
+/* Enumerate functions end*/
+
+/* SET functions start */
+int read_set_data(struct dell_wmi_sysman_buffer *buff_set, int option)
+{
+	int i, admin_pwd_set;
+	struct dell_set_data *indata;
+
+	admin_pwd_set = is_password_set("Admin");
+	if (admin_pwd_set < 0) {
+		printf("check password call failed!!!\n");
+		return EXIT_FAILURE;
+	}
+
+	printf("How many attributes to set: ");
+	scanf("%d", &buff_set->count);
+
+	indata = (struct dell_set_data *)buff_set->data;
+
+	if (admin_pwd_set) {
+		printf("Admin password is set, please enter password - ");
+		scanf("%s", buff_set->admin_password);
+	}
+
+	for (i = 0; i < buff_set->count; i++) {
+		printf("Enter Attribute Name: ");
+		scanf("%s", indata[i].attribute_name);
+
+		if (option == SET_ATTRIBUTES) {
+			printf("Enter Attribute Value: ");
+			scanf("%s", indata[i].attribute_value);
+		}
+	}
+	return 0;
+}
+
+void call_set_cmd(int cmd_opt)
+{
+	int i, ret;
+	struct dell_wmi_sysman_buffer *buff_set;
+
+	buff_set = malloc(buff_size);
+	if (buff_set == NULL) {
+		printf("failed to alloc memory for ioctl\n");
+		return;
+	}
+	buff_set->length = buff_size;
+	buff_set->command = cmd_opt;
+	if (read_set_data(buff_set, cmd_opt))
+		goto out;
+
+	ret = call_ioctl(buff_set);
+	if (!ret) {
+		printf("Set Successful...\n");
+		goto out;
+	}
+	printf("Set failed: %d\n", ret);
+out:
+	free(buff_set);
+}
+/* SET functions end */
+
+/* Password related functions start */
+void get_password_info(void)
+{
+	int i;
+	struct dell_wmi_sysman_buffer *buff_pwd;
+	struct dell_password_data *testdata;
+
+	buff_pwd = malloc(buff_size); //buff_size large enough to get password data
+	if (buff_pwd == NULL) {
+		printf("failed to alloc memory for ioctl\n");
+		return;
+	}
+	buff_pwd->length = buff_size;
+	buff_pwd->command = GET_PASS;
+	if (call_ioctl(buff_pwd)) {
+		free(buff_pwd);
+		printf("smbios ioctl failed!!!\n");
+		return;
+	}
+
+	testdata = (struct dell_password_data *)buff_pwd->data;
+	for (i = 0; i < buff_pwd->count; i++) {
+		printf("\n%d\n", (i + 1));
+		printf("AttributeName = %s\n", testdata[i].attribute_name);
+		printf("Minimum Length = %d\n", testdata[i].min_length);
+		printf("Maximum Length = %d\n", testdata[i].max_length);
+		printf("Is Password Set = %d\n", testdata[i].is_set);
+	}
+	if (buff_pwd != NULL)
+		free(buff_pwd);
+}
+
+void call_set_pasword_cmd(int clear_opt)
+{
+	int ret, is_admin_pwd_set, is_system_pwd_set;
+	struct dell_wmi_sysman_buffer *buff_pwd;
+	struct dell_set_password *indata;
+
+	buff_pwd = malloc(buff_size); //buff_size large enough to get password data
+	if (buff_pwd == NULL) {
+		printf("failed to alloc memory for ioctl\n");
+		return;
+	}
+	buff_pwd->length = buff_size;
+	buff_pwd->command = SET_PASS;
+	is_admin_pwd_set = is_password_set("Admin");
+	is_system_pwd_set = is_password_set("System");
+	if ((is_admin_pwd_set < 0) || (is_system_pwd_set < 0)) {
+		printf("check password call failed!!!\n");
+		goto out;
+	}
+
+	indata = (struct dell_set_password *)buff_pwd->data;
+
+	if (is_admin_pwd_set) {
+		printf("Admin password is set, please enter current admin password - ");
+		scanf("%s", buff_pwd->admin_password);
+	}
+
+	printf("Enter which password to set Admin/System - ");
+	scanf("%s", indata->attribute_name);
+
+	if (strcmp(indata->attribute_name, "System") == 0 && (is_system_pwd_set)) {
+		printf("System password is set, please enter current system password - ");
+		scanf("%s", indata->system_password);
+	}
+
+	if (clear_opt == 3) {
+		strcpy(indata->new_password, "");
+	} else {
+		printf("Enter new password - ");
+		scanf("%s", indata->new_password);
+	}
+	ret = call_ioctl(buff_pwd);
+	if (!ret) {
+		printf("Set Successful...\n");
+		ret = EXIT_SUCCESS;
+		goto out;
+	}
+	printf("Set failed: %d\n", ret);
+out:
+	free(buff_pwd);
+}
+
+void call_password_management(void)
+{
+	int opt, ret;
+
+	while (1) {
+		printf("\n##############################\n");
+		printf(" Password Management Menu\t\n");
+		printf("##############################\n");
+		printf("\n1 - Get Password Information\n"
+				"2 - Set/Change Password\n"
+				"3 - Clear Password\n"
+				"4 - Go to back to Main Menu\n\n"
+				"Enter - ");
+		opt = read_integer_input();
+
+		switch (opt) {
+		case GET_PASSINFO:
+			get_password_info();
+			break;
+		case SET_OR_CHANGE_PASS:
+		case CLEAR_PASS:
+			call_set_pasword_cmd(opt);
+			break;
+		case BACK:
+			return;
+		default:
+			printf("Invalid option!\n");
+			break;
+		}
+	}
+}
+/* Password related functions end */
+
+void call_reset_bios(void)
+{
+	struct dell_resetBIOS *buff_reset;
+	unsigned char reset_option;
+	int fd, ret, is_admin_pwd_set;
+
+	printf("\nReset Options:\n"
+			"0 - Built-in Safe Defaults\n"
+			"1 - Last Known Good\n"
+			"2 - Factory\n"
+			"3 - Custom\n\n"
+			"Enter - ");
+	scanf("%hhu", &reset_option);
+	buff_reset = malloc(buff_size);
+	if (buff_reset == NULL) {
+		printf("failed to alloc memory for ioctl\n");
+		return;
+	}
+	is_admin_pwd_set = is_password_set("Admin");
+	if ((is_admin_pwd_set < 0)) {
+		printf("check password call failed!!!\n");
+		goto out;
+	}
+
+	buff_reset->length = buff_size;
+	if (is_admin_pwd_set) {
+		printf("Admin password is set, please enter current admin password - ");
+		scanf("%s", buff_reset->admin_password);
+	}
+	fd = open(ioctl_devfs, O_NONBLOCK);
+	ret = ioctl(fd, DELL_WMI_SYSMAN_RESET_BIOS, buff_reset);
+	close(fd);
+	if (!ret) {
+		printf("Reset Successful. Reboot the system\n");
+		ret = EXIT_SUCCESS;
+		goto out;
+	}
+	printf("Reset Failed: %d\n", ret);
+out:
+	if (buff_reset != NULL)
+		free(buff_reset);
+}
+
+int main(void)
+{
+	int ret, opt;
+	__u64 value = 0;
+
+	ret = query_buffer_size(&value);
+	if (ret == EXIT_FAILURE || !value) {
+		printf("Unable to read buffer size\n");
+		return ret;
+	}
+	buff_size = value;
+	while (1) {
+		printf("\n\n\n##############################\n");
+		printf("Dell BIOS System Management Utility\n");
+		printf("##############################\n");
+		printf("\n1 - Enumerate All Attributes\n"
+				"2 - Set Attributes\n"
+				"3 - Set To Defaults\n"
+				"4 - Password Management\n"
+				"5 - Reset BIOS\n"
+				"6 - Exit\n"
+				"\n\nEnter - ");
+		opt = read_integer_input();
+
+		switch (opt) {
+		case GET_ATTRS:
+			enumerate_all_attributes();
+			break;
+		case SET_ATTRS:
+		case SET_DEFS:
+			call_set_cmd(opt);
+			break;
+		case PASS_MAN:
+			call_password_management();
+			break;
+		case RESET:
+			call_reset_bios();
+			break;
+		case EXIT:
+			exit(0);
+			break;
+		default:
+			break;
+		}
+	}
+	return 0;
+}
-- 
2.25.1

