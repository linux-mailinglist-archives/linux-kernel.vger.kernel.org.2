Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792F53EA56C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbhHLNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhHLNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:17:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B2DC0613D5;
        Thu, 12 Aug 2021 06:16:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso4553540wms.2;
        Thu, 12 Aug 2021 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+31ueKWHEK9Ld0HlUFK7VqSg4Er3ncbHktaznur2+5c=;
        b=FyoubiJin22pY6y9t1oNuyu5vUN6YLKc2wZ7lYpSaAt1artsZEkoftVP+Em9dMEFuU
         3msNrA0k9agTXHRd5rzromx6w3gCpj/0PK7lsXrF0589RumQvLAbQ6dYaEX5mSSMW6dj
         iVhGfBjw9H4t2sdQF10W5d13SR10P6kErEFrto+kOC7/H3l783LboZbg7+FN+kInQ5SY
         0nFMlh0gIgYj74EDQqAho11+3/B65Z58iRgojnFOSOioK32nacTtDw+xWgr8Qzcv/+/f
         qedn1HaS4YyQOhyd4TReo5NKrNjhtsFf2uoKBb/WK8iVg3hblgOZypbGFImGwq9lsAA9
         iNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+31ueKWHEK9Ld0HlUFK7VqSg4Er3ncbHktaznur2+5c=;
        b=QY2k7em/GVVzteEmRNRafH2f/mXCf8PK5g2cPXmY1rONsiLxACunS9GyZflRlGv1k2
         Tdt7BGEGTXHLofm6kBnCQUM+NDLp6tEW8xfHBLnTJBr3qahNMQZo/LG+JJblX1Bwl1z0
         xMlLqlWrcd0+vln2csi3+BAj2p7Ox2oIC15FUbHi2G5+pm6GuHcyvnzhXygz/RhNIBnv
         l0WH2rfP1wibjhPszdyyE4DeBys2rSdOIEjfccLE9ypnbdIVttyJH59wXusDv5C6Io+B
         wp1aC5AqwbS/Ez9/lAeIEfQsL292QSR/UigxQOptMlLCQNxrdX4CKGircxM5Y/LQrASj
         hmXw==
X-Gm-Message-State: AOAM532L5yn9Q3UwSEM7WuWm0htsoGm2z3vX1PtTn5nGsQaLQ7JRbH1J
        2VoMMFuvpb9uaLFZeEtKDlk=
X-Google-Smtp-Source: ABdhPJz24og6hk2s3mMcE4r6/Chwlj+eYbXKQsI/avnzLDZur2B4noxvos7sb+RzE2W5Lj5mli47tw==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr4086698wmh.134.1628774205636;
        Thu, 12 Aug 2021 06:16:45 -0700 (PDT)
Received: from Blackbeard.. (static.214.212.76.144.clients.your-server.de. [144.76.212.214])
        by smtp.gmail.com with ESMTPSA id o125sm2857070wme.15.2021.08.12.06.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 06:16:44 -0700 (PDT)
From:   JafarAkhondali <jafar.akhoondali@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>, jlee@suse.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mgross@linux.intel.com
Cc:     JafarAkhondali <jafar.akhoondali@gmail.com>
Subject: [PATCH v5] platform/x86: acer-wmi: Add Turbo Mode support for Acer PH315-53
Date:   Thu, 12 Aug 2021 17:23:07 +0430
Message-Id: <20210812125307.1749207-1-jafar.akhoondali@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Acer Predator Helios series (usually denoted by PHxxx-yy) features
a particular key above the keyboard named "TURBO".
The turbo key does 3 things:
1. Set all fan's speeds to TURBO mode
2. Overclocks the CPU and GPU in the safe range
3. Turn on an LED just below the turbo button

All the above actions are operating using WMI function calls,
and there is no custom OC level for turbo. It acts as a flag
for enabling turbo mode instead of telling processors to use
a specific multiply of power (e.g. 1.3x of power).

I've run some benchmark tests and it worked fine:

GpuTest 0.7.0
http://www.geeks3d.com

Module: FurMark
Normal mode Score: 7289 points (FPS: 121)
Turbo mode Score: 7675 points (FPS: 127)
Settings:
- 1920x1080 fullscreen
- antialiasing: Off
- duration: 60000 ms

Renderer:
- GeForce RTX 2060/PCIe/SSE2
- OpenGL: 4.6.0 NVIDIA 460.32.03

This feature is presented by Acer officially and should not harm
hardware in any case.

A challenging part of implementing this feature is that calling
overclock function requires knowing the exact count of fans
for CPU and GPU of each model, which to the best of my
knowledge is not available in the kernel.

So after checking the official PredatorSense application methods, it
turned out they have provided the software the list of fans in each model.
I have access to the mentioned list, and all similar PH-iii-jj can be
added easily by matching "DMI_PRODUCT_NAME".

Creating a specific file for the Acer gaming features is not possible
because the current in use WMI event GUID is required for the turbo button
and it's not possible to register multiple listeners on a single WMI event.


Signed-off-by: JafarAkhondali <jafar.akhoondali@gmail.com>
---
 Changes in v5:
 - Use helper for Turbo fan mode
 - Initialize OC GPU config variables

 Changes in v4:
 - Fix Indents
 - Make functions return early

 Changes in v3:
 - Remove usages of gaming_interface
 - Add ACPI output for u32 buffer length
 - Remove set_u64 and get_u64 functions
 - Remove unrelated whitespace changes for to this patch

 Changes in v2:
 - Fix formatting problems


 drivers/platform/x86/acer-wmi.c | 179 ++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 85db9403cc14..c8f118fe04ac 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -60,6 +60,11 @@ MODULE_LICENSE("GPL");
 #define ACER_WMID_GET_THREEG_METHODID		10
 #define ACER_WMID_SET_THREEG_METHODID		11
 
+#define ACER_WMID_SET_GAMING_LED_METHODID 2
+#define ACER_WMID_GET_GAMING_LED_METHODID 4
+#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
+#define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
+
 /*
  * Acer ACPI method GUIDs
  */
@@ -68,6 +73,7 @@ MODULE_LICENSE("GPL");
 #define WMID_GUID1		"6AF4F258-B401-42FD-BE91-3D4AC2D7C0D3"
 #define WMID_GUID2		"95764E09-FB56-4E83-B31A-37761F60994A"
 #define WMID_GUID3		"61EF69EA-865C-4BC3-A502-A0DEBA0CB531"
+#define WMID_GUID4		"7A4DDFE7-5B5D-40B4-8595-4408E0CC7F56"
 
 /*
  * Acer ACPI event GUIDs
@@ -81,6 +87,7 @@ MODULE_ALIAS("wmi:676AA15E-6A47-4D9F-A2CC-1E6D18D14026");
 enum acer_wmi_event_ids {
 	WMID_HOTKEY_EVENT = 0x1,
 	WMID_ACCEL_OR_KBD_DOCK_EVENT = 0x5,
+	WMID_GAMING_TURBO_KEY_EVENT = 0x7,
 };
 
 static const struct key_entry acer_wmi_keymap[] __initconst = {
@@ -215,6 +222,9 @@ struct hotkey_function_type_aa {
 #define ACER_CAP_THREEG			BIT(4)
 #define ACER_CAP_SET_FUNCTION_MODE	BIT(5)
 #define ACER_CAP_KBD_DOCK		BIT(6)
+#define ACER_CAP_TURBO_OC     BIT(7)
+#define ACER_CAP_TURBO_LED     BIT(8)
+#define ACER_CAP_TURBO_FAN     BIT(9)
 
 /*
  * Interface type flags
@@ -301,6 +311,9 @@ struct quirk_entry {
 	u8 mailled;
 	s8 brightness;
 	u8 bluetooth;
+	u8 turbo;
+	u8 cpu_fans;
+	u8 gpu_fans;
 };
 
 static struct quirk_entry *quirks;
@@ -312,6 +325,10 @@ static void __init set_quirks(void)
 
 	if (quirks->brightness)
 		interface->capability |= ACER_CAP_BRIGHTNESS;
+
+	if (quirks->turbo)
+		interface->capability |= ACER_CAP_TURBO_OC | ACER_CAP_TURBO_LED
+					 | ACER_CAP_TURBO_FAN;
 }
 
 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -340,6 +357,12 @@ static struct quirk_entry quirk_acer_travelmate_2490 = {
 	.mailled = 1,
 };
 
+static struct quirk_entry quirk_acer_predator_ph315_53 = {
+	.turbo = 1,
+	.cpu_fans = 1,
+	.gpu_fans = 1,
+};
+
 /* This AMW0 laptop has no bluetooth */
 static struct quirk_entry quirk_medion_md_98300 = {
 	.wireless = 1,
@@ -507,6 +530,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_acer_travelmate_2490,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Predator PH315-53",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PH315-53"),
+		},
+		.driver_data = &quirk_acer_predator_ph315_53,
+	},
 	{
 		.callback = set_force_caps,
 		.ident = "Acer Aspire Switch 10E SW3-016",
@@ -1344,6 +1376,114 @@ static struct wmi_interface wmid_v2_interface = {
 	.type = ACER_WMID_v2,
 };
 
+/*
+ * WMID Gaming interface
+ */
+
+static acpi_status
+WMI_gaming_execute_u64(u32 method_id, u64 in, u64 *out)
+{
+	struct acpi_buffer input = { (acpi_size) sizeof(u64), (void *)(&in) };
+	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	u32 tmp = 0;
+	acpi_status status;
+
+	status = wmi_evaluate_method(WMID_GUID4, 0, method_id, &input, &result);
+
+	if (ACPI_FAILURE(status))
+		return status;
+	obj = (union acpi_object *) result.pointer;
+
+	if (obj) {
+		if (obj->type == ACPI_TYPE_BUFFER) {
+			if (obj->buffer.length == sizeof(u32))
+				tmp = *((u32 *) obj->buffer.pointer);
+			else if (obj->buffer.length == sizeof(u64))
+				tmp = *((u64 *) obj->buffer.pointer);
+		} else if (obj->type == ACPI_TYPE_INTEGER) {
+			tmp = (u64) obj->integer.value;
+		}
+	}
+
+	if (out)
+		*out = tmp;
+
+	kfree(result.pointer);
+
+	return status;
+}
+
+static acpi_status WMID_gaming_set_u64(u64 value, u32 cap)
+{
+	u32 method_id = 0;
+
+	if (!(interface->capability & cap))
+		return AE_BAD_PARAMETER;
+
+	switch (cap) {
+	case ACER_CAP_TURBO_LED:
+		method_id = ACER_WMID_SET_GAMING_LED_METHODID;
+		break;
+	case ACER_CAP_TURBO_FAN:
+		method_id = ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
+		break;
+	case ACER_CAP_TURBO_OC:
+		method_id = ACER_WMID_SET_GAMING_MISC_SETTING_METHODID;
+		break;
+	default:
+		return AE_BAD_PARAMETER;
+	}
+
+	return WMI_gaming_execute_u64(method_id, value, NULL);
+}
+
+static acpi_status WMID_gaming_get_u64(u64 *value, u32 cap)
+{
+	acpi_status status;
+	u64 result;
+	u64 input;
+	u32 method_id;
+
+	if (!(interface->capability & cap))
+		return AE_BAD_PARAMETER;
+
+	switch (cap) {
+	case ACER_CAP_TURBO_LED:
+		method_id = ACER_WMID_GET_GAMING_LED_METHODID;
+		input = 0x1;
+		break;
+	default:
+		return AE_BAD_PARAMETER;
+	}
+	status = WMI_gaming_execute_u64(method_id, input, &result);
+	if (ACPI_SUCCESS(status))
+		*value = (u64) result;
+
+	return status;
+}
+
+void WMID_gaming_set_fan_mode(u8 fan_mode)
+{
+	/* fan_mode = 1 is used for auto, fan_mode = 2 used for turbo*/
+	u64 gpu_fan_config1 = 0, gpu_fan_config2 = 0;
+	int i;
+
+	if (quirks->cpu_fans > 0)
+		gpu_fan_config2 |= 1;
+	for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
+		gpu_fan_config2 |= 1 << (i + 1);
+	for (i = 0; i < quirks->gpu_fans; ++i)
+		gpu_fan_config2 |= 1 << (i + 3);
+	if (quirks->cpu_fans > 0)
+		gpu_fan_config1 |= fan_mode;
+	for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
+		gpu_fan_config1 |= fan_mode << (2 * i + 2);
+	for (i = 0; i < quirks->gpu_fans; ++i)
+		gpu_fan_config1 |= fan_mode << (2 * i + 6);
+	WMID_gaming_set_u64(gpu_fan_config2 | gpu_fan_config1 << 16, ACER_CAP_TURBO_FAN);
+}
+
 /*
  * Generic Device (interface-independent)
  */
@@ -1575,6 +1715,41 @@ static int acer_gsensor_event(void)
 	return 0;
 }
 
+/*
+ *  Predator series turbo button
+ */
+static int acer_toggle_turbo(void)
+{
+	u64 turbo_led_state;
+
+	/* Get current state from turbo button */
+	if (ACPI_FAILURE(WMID_gaming_get_u64(&turbo_led_state, ACER_CAP_TURBO_LED)))
+		return -1;
+
+	if (turbo_led_state) {
+		/* Turn off turbo led */
+		WMID_gaming_set_u64(0x1, ACER_CAP_TURBO_LED);
+
+		/* Set FAN mode to auto */
+		WMID_gaming_set_fan_mode(0x1);
+
+		/* Set OC to normal */
+		WMID_gaming_set_u64(0x5, ACER_CAP_TURBO_OC);
+		WMID_gaming_set_u64(0x7, ACER_CAP_TURBO_OC);
+	} else {
+		/* Turn on turbo led */
+		WMID_gaming_set_u64(0x10001, ACER_CAP_TURBO_LED);
+
+		/* Set FAN mode to turbo */
+		WMID_gaming_set_fan_mode(0x2);
+
+		/* Set OC to turbo mode */
+		WMID_gaming_set_u64(0x205, ACER_CAP_TURBO_OC);
+		WMID_gaming_set_u64(0x207, ACER_CAP_TURBO_OC);
+	}
+	return turbo_led_state;
+}
+
 /*
  * Switch series keyboard dock status
  */
@@ -1872,6 +2047,10 @@ static void acer_wmi_notify(u32 value, void *context)
 		acer_gsensor_event();
 		acer_kbd_dock_event(&return_value);
 		break;
+	case WMID_GAMING_TURBO_KEY_EVENT:
+		if (return_value.key_num == 0x4)
+			acer_toggle_turbo();
+		break;
 	default:
 		pr_warn("Unknown function number - %d - %d\n",
 			return_value.function, return_value.key_num);
-- 
2.30.2

