Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9D8380925
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhENMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhENMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:07:38 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7191C061574;
        Fri, 14 May 2021 05:06:26 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z3so27009577oib.5;
        Fri, 14 May 2021 05:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LdD50FKyHECB03ZwstOafT3yDwKBCoEIOH8JtfIHtdo=;
        b=FfI/0amTfSgAwDloftKEfe6Nx0lC6MSogLwgta8OVwvvfEaR4aHT3s+FzFZywDjGqZ
         RQ98Jyr83YfmdXIVfLSs10lMtx7zU3Iih0a5GBGJSiMu67illyYqgXB6mG4owHeapeKZ
         X6d3MIgQJnbpadpp/1hjuRDz7M+d6zcAetkzbTa0OUH5lFHmuGah3MKebxFgljddkFho
         386wwULv9/ZodoRkKipnH+Iy91ZxXIzzRaI8DUJhSjQDBQCiovNbSJofGLZxUDg2AHpr
         JgxCpKMoYgqFfCi4dgSgvtk5ZBLSEo/l1oq6m9CqpHUZ48XNYJprmeI8MNvP7v1BmKo/
         QN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LdD50FKyHECB03ZwstOafT3yDwKBCoEIOH8JtfIHtdo=;
        b=ncxrDytUUBkThFMZPsVmaFDalfOxDJaT2UDo2kXC/cHmwZskVnVbOq5QHAjK1lcC9V
         o+uuP8UlfDv/dWbPvEFmhZ5VYqrhP9jRnmAaDZYB0mqevb1dC8bLzqXxkwJEmkY+8ejz
         s++wDgDeNSGbr0ht0yuida4RMjpT9FR5C01tDSxaLRvQME2Elvz0VjAIzIoMJHse/RG5
         NduM91wst3JWXdE1odc2Fro148wfu23CoSmJHQQ/VQsq8ek6iKHIg2AwXEXVSy4kzyfe
         k0yFdM8UYE+a3Wgoyrpu481Xswbnp7gv+9Qf1F4g0OPGxa8u03JmUVUPru+qDh/K3yaG
         vU8A==
X-Gm-Message-State: AOAM532ToYEyCC/fux266cmZ54whl0abne6CVd9336oSvbOQRAa0t7Iy
        w8YpBKQmjog1uLFyHdEHr+HMeQSyAGwdc5kq0cw=
X-Google-Smtp-Source: ABdhPJzvAIkW7RVjfMcv5xTHBLSL4lbNj/+A/7hM8RUUE/qZMjf2Lb4tdwfjyP1B8vVEoo110657YU6MaQT+zHMHYPs=
X-Received: by 2002:a05:6808:68a:: with SMTP id k10mr33272531oig.120.1620993986237;
 Fri, 14 May 2021 05:06:26 -0700 (PDT)
MIME-Version: 1.0
From:   Jafar Akhondali <jafar.akhoondali@gmail.com>
Date:   Fri, 14 May 2021 16:36:15 +0430
Message-ID: <CAMW3L+24ZGowtpURUbjoCoA+eZMF0wDae1izxS+HM2uz1L9Rig@mail.gmail.com>
Subject: [PATCH] platform/x86: acer-wmi: Add support for Acer Helios 300 RGB
 keyboard backlight
To:     jlee@suse.com, hdegoede@redhat.com, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From e65b0ddbf559aa3ca8a7998404e7e67e64b705e9 Mon Sep 17 00:00:00 2001
From: JafarAkhondali <jafar.akhoondali@gmail.com>
Date: Fri, 14 May 2021 08:26:47 +0430
Subject: [PATCH] platform/x86: acer-wmi: Add support for Acer Helios
300 rgb keyboard backlight

The Acer helios 300 provides gaming functions WMI that is available in
Windows, however this was not implemented in Linux. The process of finding
the related method was done by decompiling PredatorSense(official Acer
gaming functions software for Predator series) and decompiling WQ
buffers. This patch provides a gaming interface which will then expose a
character device named "acer-gkbbl". This character device accepts 16
bytes long config, which is specific for the backlight method. The
meaning of each bytes ordered by bit position is as follows:

Bit 0 -> Backlight modes:
1: Breath
2: Neon
3: Wave
4: Shifting
5: Zoom
Bit 1 -> Animation Speed: from 1 to 9 ( 1 is slowest, 9 is fastest)
Bit 2 -> Brightness from 0 to 100 ( 0 is no backlight, 100 is brightest)
Bit 3 -> Unknown. Wave effect uses 8, other modes must use 0
Bit 4 -> Animation Direction:
1: Right-to-Left
2: Left-to-Right
Bit 5 -> Red Color Selection
Bit 6 -> Green Color Selection
Bit 7 -> Blue Color Selection
Bit 8 -> Currently unknown, or not used in known model
Bit 9 -> Currently unknown, or not used in known model
Bit 10 -> Currently unknown, or not used in known model
Bit 11 -> Currently unknown, or not used in known model
Bit 12 -> Currently unknown, or not used in known model
Bit 13 -> Currently unknown, or not used in known model
Bit 14 -> Currently unknown, or not used in known model
Bit 15 -> Currently unknown, or not used in known model

Filling this config is out of scope for the kernel module, and this module
only acts as an interface.

Currently, I'm not sure with the method for communicating with user-space,
but since leds.h subsystem wouldn't fit for complex actions such as this
complex config, I couldn't find any better method than char dev.

Signed-off-by: JafarAkhondali <jafar.akhoondali@gmail.com>
---
 drivers/platform/x86/acer-wmi.c | 228 ++++++++++++++++++++++++++++++--
 1 file changed, 216 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 85db9403cc14..a2cb0d4bbec8 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -27,13 +27,16 @@
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/input.h>
+#include <linux/cdev.h>
 #include <linux/input/sparse-keymap.h>
 #include <acpi/video.h>

+
 MODULE_AUTHOR("Carlos Corbacho");
 MODULE_DESCRIPTION("Acer Laptop WMI Extras Driver");
 MODULE_LICENSE("GPL");

+
 /*
  * Magic Number
  * Meaning is unknown - this number is required for writing to ACPI for AMW0
@@ -59,6 +62,8 @@ MODULE_LICENSE("GPL");
 #define ACER_WMID_SET_BRIGHTNESS_METHODID 6
 #define ACER_WMID_GET_THREEG_METHODID 10
 #define ACER_WMID_SET_THREEG_METHODID 11
+#define ACER_WMID_SET_GAMINGKBBL_METHODID 20
+#define ACER_WMID_GET_GAMINGKBBL_METHODID 21

 /*
  * Acer ACPI method GUIDs
@@ -68,6 +73,7 @@ MODULE_LICENSE("GPL");
 #define WMID_GUID1 "6AF4F258-B401-42FD-BE91-3D4AC2D7C0D3"
 #define WMID_GUID2 "95764E09-FB56-4E83-B31A-37761F60994A"
 #define WMID_GUID3 "61EF69EA-865C-4BC3-A502-A0DEBA0CB531"
+#define WMID_GUID4 "7A4DDFE7-5B5D-40B4-8595-4408E0CC7F56"

 /*
  * Acer ACPI event GUIDs
@@ -144,6 +150,14 @@ struct event_return_value {

 #define ACER_WMID3_GDS_TOUCHPAD (1<<1) /* Touchpad */

+/*
+ * Gaming functions user-space communication
+ * A character drive will be exposed in /dev/acer-gkbbl as char block
for keyboard backlight config
+ * Config length is 16 bytes
+ */
+#define GAMING_KBBL_CHR "acer-gkbbl"
+#define GAMING_KBBL_CONFIG_LEN 16
+
 /* Hotkey Customized Setting and Acer Application Status.
  * Set Device Default Value and Report Acer Application Status.
  * When Acer Application starts, it will run this method to inform
@@ -215,6 +229,7 @@ struct hotkey_function_type_aa {
 #define ACER_CAP_THREEG BIT(4)
 #define ACER_CAP_SET_FUNCTION_MODE BIT(5)
 #define ACER_CAP_KBD_DOCK BIT(6)
+#define ACER_CAP_GAMINGKB BIT(7)

 /*
  * Interface type flags
@@ -224,6 +239,7 @@ enum interface_flags {
  ACER_AMW0_V2,
  ACER_WMID,
  ACER_WMID_v2,
+ ACER_WMID_GAMING,
 };

 #define ACER_DEFAULT_WIRELESS  0
@@ -290,6 +306,20 @@ struct wmi_interface {
 /* The static interface pointer, points to the currently detected interface */
 static struct wmi_interface *interface;

+/* The static gaming interface pointer, points to the currently
detected gaming interface */
+static struct wmi_interface *gaming_interface;
+
+/*
+ * Character device registration
+ * GAMING_KBBL_MINOR -> used to configure gaming rgb keyboard
backlights from user-space
+ */
+
+#define GAMING_KBBL_MINOR 0
+
+
+static int dev_major; // Global variable to store major number of driver
+
+
 /*
  * Embedded Controller quirks
  * Some laptops require us to directly access the EC to either enable or query
@@ -903,7 +933,7 @@ static acpi_status __init AMW0_set_capabilities(void)
  */
  if (wmi_has_guid(AMW0_GUID2)) {
  if ((quirks != &quirk_unknown) ||
-     !AMW0_set_cap_acpi_check_device())
+ !AMW0_set_cap_acpi_check_device())
  interface->capability |= ACER_CAP_WIRELESS;
  return AE_OK;
  }
@@ -1344,6 +1374,64 @@ static struct wmi_interface wmid_v2_interface = {
  .type = ACER_WMID_v2,
 };

+
+/*
+ * WMID Gaming interface
+ */
+
+static struct wmi_interface wmid_gaming_interface = {
+ .type = ACER_WMID_GAMING
+};
+
+static acpi_status
+WMI_gaming_execute_u8_array(u32 method_id, u8 array[], size_t
array_size, u32 *out)
+{
+ struct acpi_buffer input = { (acpi_size) array_size, (void *)(array) };
+ struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
+ union acpi_object *obj;
+ u32 tmp = 0;
+ acpi_status status;
+
+ status = wmi_evaluate_method(WMID_GUID4, 0, method_id, &input, &result);
+
+ if (ACPI_FAILURE(status))
+ return status;
+
+ obj = (union acpi_object *) result.pointer;
+ if (obj) {
+ if (obj->type == ACPI_TYPE_BUFFER &&
+ (obj->buffer.length == sizeof(u32) ||
+ obj->buffer.length == sizeof(u64))) {
+ tmp = *((u32 *) obj->buffer.pointer);
+ } else if (obj->type == ACPI_TYPE_INTEGER) {
+ tmp = (u32) obj->integer.value;
+ }
+ }
+
+ if (out)
+ *out = tmp;
+
+ kfree(result.pointer);
+
+ return status;
+}
+
+static acpi_status WMID_gaming_set_u8_array(u8 array[], size_t
array_size, u32 cap)
+{
+ u32 method_id = 0;
+
+ switch (cap) {
+ case ACER_CAP_GAMINGKB:
+ if (array_size != GAMING_KBBL_CONFIG_LEN)
+ return AE_BAD_PARAMETER;
+ method_id = ACER_WMID_SET_GAMINGKBBL_METHODID;
+ break;
+ default:
+ return AE_ERROR;
+ }
+ return WMI_gaming_execute_u8_array(method_id, array, array_size, NULL);
+}
+
 /*
  * Generic Device (interface-independent)
  */
@@ -1422,6 +1510,29 @@ static acpi_status set_u32(u32 value, u32 cap)
  return AE_BAD_PARAMETER;
 }

+static acpi_status set_u8_array(u8 array[], size_t array_size, u32 cap)
+{
+ acpi_status status;
+
+ if (interface->capability & cap) {
+ switch (interface->type) {
+ default:
+ return AE_BAD_PARAMETER;
+ }
+ } else if (gaming_interface->capability & cap) {
+ switch (gaming_interface->type) {
+ case ACER_WMID_GAMING:
+ status = WMID_gaming_set_u8_array(array, array_size, cap);
+ if (ACPI_FAILURE(status))
+ return status;
+ fallthrough;
+ default:
+ return AE_BAD_PARAMETER;
+ }
+ }
+ return AE_BAD_PARAMETER;
+}
+
 static void __init acer_commandline_init(void)
 {
  /*
@@ -1461,6 +1572,88 @@ static void acer_led_exit(void)
  led_classdev_unregister(&mail_led);
 }

+/*
+ * Keyboard RGB backlight character device handler.
+ * On systems supporting Acer gaming functions, a char device
+ * will be exposed to communicate with user space
+ * for keyboard RGB backlight configurations.
+ */
+
+static ssize_t gkbbl_drv_write(struct file *file,
+ const char __user *buf, size_t count, loff_t *offset)
+{
+ u8 config_buf[GAMING_KBBL_CONFIG_LEN];
+ unsigned long err;
+
+ if (count != GAMING_KBBL_CONFIG_LEN) {
+ pr_err("Invalid data given to gaming keyboard backlight");
+ return 0;
+ }
+ err = copy_from_user(config_buf, buf, GAMING_KBBL_CONFIG_LEN);
+ if (err < 0)
+ pr_err("Copying data from userspace failed with code: %lu\n", err);
+
+ set_u8_array(config_buf, GAMING_KBBL_CONFIG_LEN, ACER_CAP_GAMINGKB);
+ return count;
+}
+
+
+static const struct file_operations gkbbl_dev_fops = {
+ .owner      = THIS_MODULE,
+ .write       = gkbbl_drv_write
+};
+
+struct gkbbl_device_data {
+ struct cdev cdev;
+};
+
+static struct class *gkbbl_dev_class;
+static struct gkbbl_device_data gkbbl_dev_data;
+
+static int gkbbl_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+ add_uevent_var(env, "DEVMODE=%#o", 0666);
+ return 0;
+}
+
+static int __init gaming_kbbl_cdev_init(void)
+{
+ dev_t dev;
+ int err;
+
+ err = alloc_chrdev_region(&dev, 0, 1, GAMING_KBBL_CHR);
+ if (err < 0) {
+ pr_err("Char drive registering for gaming keyboard backlight failed:
%d\n", err);
+ return err;
+ }
+
+ dev_major = MAJOR(dev);
+
+ gkbbl_dev_class = class_create(THIS_MODULE, GAMING_KBBL_CHR);
+ gkbbl_dev_class->dev_uevent = gkbbl_dev_uevent;
+
+ cdev_init(&gkbbl_dev_data.cdev, &gkbbl_dev_fops);
+ gkbbl_dev_data.cdev.owner = THIS_MODULE;
+
+ cdev_add(&gkbbl_dev_data.cdev, MKDEV(dev_major, GAMING_KBBL_MINOR), 1);
+
+ device_create(gkbbl_dev_class, NULL, MKDEV(dev_major,
GAMING_KBBL_MINOR), NULL, "%s-%d",
+    GAMING_KBBL_CHR,
+    GAMING_KBBL_MINOR);
+
+ return 0;
+}
+
+static void __exit gaming_kbbl_cdev_exit(void)
+{
+ device_destroy(gkbbl_dev_class, MKDEV(dev_major, GAMING_KBBL_MINOR));
+
+ class_unregister(gkbbl_dev_class);
+ class_destroy(gkbbl_dev_class);
+
+ unregister_chrdev_region(MKDEV(dev_major, GAMING_KBBL_MINOR), MINORMASK);
+}
+
 /*
  * Backlight device
  */
@@ -1501,7 +1694,7 @@ static int acer_backlight_init(struct device *dev)
  props.type = BACKLIGHT_PLATFORM;
  props.max_brightness = max_brightness;
  bd = backlight_device_register("acer-wmi", dev, NULL, &acer_bl_ops,
-        &props);
+    &props);
  if (IS_ERR(bd)) {
  pr_err("Could not register Acer backlight device\n");
  acer_backlight_device = NULL;
@@ -1605,7 +1798,7 @@ static void acer_kbd_dock_get_initial_state(void)
  status = wmi_evaluate_method(WMID_GUID3, 0, 0x2, &input_buf, &output_buf);
  if (ACPI_FAILURE(status)) {
  pr_err("Error getting keyboard-dock initial status: %s\n",
-        acpi_format_exception(status));
+    acpi_format_exception(status));
  return;
  }

@@ -1618,7 +1811,7 @@ static void acer_kbd_dock_get_initial_state(void)
  output = obj->buffer.pointer;
  if (output[0] != 0x00 || (output[3] != 0x05 && output[3] != 0x45)) {
  pr_err("Unexpected output [0]=0x%02x [3]=0x%02x getting
keyboard-dock initial status\n",
-        output[0], output[3]);
+    output[0], output[3]);
  goto out_free_obj;
  }

@@ -1759,7 +1952,7 @@ static int acer_rfkill_init(struct device *dev)
  rfkill_inited = true;

  if ((ec_raw_mode || !wmi_has_guid(ACERWMID_EVENT_GUID)) &&
-     has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
+ has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
  schedule_delayed_work(&acer_rfkill_work,
  round_jiffies_relative(HZ));

@@ -1782,7 +1975,7 @@ static int acer_rfkill_init(struct device *dev)
 static void acer_rfkill_exit(void)
 {
  if ((ec_raw_mode || !wmi_has_guid(ACERWMID_EVENT_GUID)) &&
-     has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
+ has_cap(ACER_CAP_WIRELESS | ACER_CAP_BLUETOOTH | ACER_CAP_THREEG))
  cancel_delayed_work_sync(&acer_rfkill_work);

  if (has_cap(ACER_CAP_WIRELESS)) {
@@ -2251,8 +2444,8 @@ static int __init acer_wmi_init(void)
  * in the past quirk list.
  */
  if (wmi_has_guid(AMW0_GUID1) &&
-     !dmi_check_system(amw0_whitelist) &&
-     quirks == &quirk_unknown) {
+ !dmi_check_system(amw0_whitelist) &&
+ quirks == &quirk_unknown) {
  pr_debug("Unsupported machine has AMW0_GUID1, unable to load\n");
  return -ENODEV;
  }
@@ -2266,9 +2459,12 @@ static int __init acer_wmi_init(void)
  if (!wmi_has_guid(AMW0_GUID1) && wmi_has_guid(WMID_GUID1))
  interface = &wmid_interface;

- if (wmi_has_guid(WMID_GUID3))
+ if (wmi_has_guid(WMID_GUID3)) {
  interface = &wmid_v2_interface;
-
+ if (wmi_has_guid(WMID_GUID4))
+ gaming_interface = &wmid_gaming_interface;
+ }
+
  if (interface)
  dmi_walk(type_aa_dmi_decode, NULL);

@@ -2309,14 +2505,19 @@ static int __init acer_wmi_init(void)
  if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
  interface->capability &= ~ACER_CAP_BRIGHTNESS;

- if (wmi_has_guid(WMID_GUID3))
+ if (wmi_has_guid(WMID_GUID3)) {
  interface->capability |= ACER_CAP_SET_FUNCTION_MODE;
+ if (wmi_has_guid(WMID_GUID4)) {
+ gaming_interface->capability |= ACER_CAP_GAMINGKB;
+ gaming_kbbl_cdev_init();
+ }
+ }

  if (force_caps != -1)
  interface->capability = force_caps;

  if (wmi_has_guid(WMID_GUID3) &&
-     (interface->capability & ACER_CAP_SET_FUNCTION_MODE)) {
+ (interface->capability & ACER_CAP_SET_FUNCTION_MODE)) {
  if (ACPI_FAILURE(acer_wmi_enable_rf_button()))
  pr_warn("Cannot enable RF Button Driver\n");

@@ -2389,6 +2590,9 @@ static void __exit acer_wmi_exit(void)
  if (acer_wmi_accel_dev)
  input_unregister_device(acer_wmi_accel_dev);

+ if (wmi_has_guid(WMID_GUID4))
+ gaming_kbbl_cdev_exit();
+
  remove_debugfs();
  platform_device_unregister(acer_platform_device);
  platform_driver_unregister(&acer_platform_driver);
-- 
2.27.0
