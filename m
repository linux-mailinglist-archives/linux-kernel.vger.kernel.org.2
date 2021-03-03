Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41632BA85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357855AbhCCLYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhCCCvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 21:51:32 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989D0C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 18:50:44 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id j188so4906551vke.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 18:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nctu.edu.tw; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2z3DP2mZYy6O9kWu2lZTASdLX36+jjI/S076QUgaa6E=;
        b=eyxJDubnQ3yERaXeIvU1m8DfSAn2sJyB+O2UaUbwV7arm/m/532XbMCxQCWSkMuVgi
         GKMoSt62fNRgaOTq1pH6SPExVG2Td6GzRJCrhU42ypntACf3M9VOj/Oa1DWI/htx0UUb
         s9f2FcSw6SucGxME6KIVbhWmVP66WVzRxir/Gs294e8y2NL7SuT+7OdegJJ/6SOdYdef
         NETEPyInXJag3i5M+kJ8iJWBo0/6gGJ77CcIAyJ3YDu8ZFmfj52yoiLOS6APKCfqdHUO
         2uoIrqdXdzpA/8TPJeYAh04sq4UA9gnYR49CjdOo61hCvNl3ce27dcbGmFjGa2iqopM2
         wJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2z3DP2mZYy6O9kWu2lZTASdLX36+jjI/S076QUgaa6E=;
        b=HEAhRZuLfhdR3rStsQvqGRSoHC/ay0WwLtaeBWRrCVwWWPHQ+9bFLkWa3i4W1gS2rN
         sH2PwbrZ8jHKOCvYcX84bs9sZIv1LHnPmKxh7tiYRIgd6o6JM9tkXWFd9S+6fhAnaXym
         SIfedIeKDUaGHzI/DpAU4HXxtKhntiOoxxmmgo2iOV+FZO6JDwdiBJZaHj0/HLemft23
         ML7aSU5D9U2wVeq5xeNWmwP0PmIkC7AP4923IRsSgfOK/TD30TxMuD7v3Dni1qD//FQI
         7Gmg1K5ePf8WG2aJ49yWGeTWOrkhliufnU0Yt0j0KDuorG/0r3nMZXvCzhZljitZrlya
         TMhA==
X-Gm-Message-State: AOAM531V5obZgnf/YVuazEIWc9ZIHDTn63WQEYuvPWxttWt61QVxwDt9
        1Bv53r0GNYUQIxpF5ylU/WF3HmcmI8iy1hoj6zO+J16A83BajveV
X-Google-Smtp-Source: ABdhPJyfoJdBtY9ua6K/O7nHaDRg0wwNQ30XyQ33VBmpm8PqUSAyZM2wxQ8EoweyRM89RtlyjY/ni1Afy7qMsoHs6i0=
X-Received: by 2002:a1f:2ecb:: with SMTP id u194mr5069146vku.13.1614739843657;
 Tue, 02 Mar 2021 18:50:43 -0800 (PST)
MIME-Version: 1.0
From:   "YingChieh, Ho" <andrea.cs97g@nctu.edu.tw>
Date:   Wed, 3 Mar 2021 10:50:38 +0800
Message-ID: <CAFysUkSztjJpSjKA92a=3j3Nj7vfQy5TCsiJtNmfjegxLBvFSA@mail.gmail.com>
Subject: [V1,1/1] platform/x86: add support for Advantech software defined button
To:     platform-driver-x86@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org, andrea.ho@advantech.com.tw,
        Andrea Ho <voyandrea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrea.Ho" <Andrea.Ho@advantech.com.tw>

Advantech sw_button is a ACPI event trigger button.

With this driver, we can report KEY_EVENT on the
Advantech Tabletop Network Appliances products and it has been
tested in FWA1112VC.

Add the software define button support to report EV_REP key_event
(BTN_TRIGGER_HAPPY) by pressing button that cloud be get on user
interface and trigger the customized actions.

Signed-off-by: Andrea.Ho <Andrea.Ho@advantech.com.tw>
---
 MAINTAINERS                         |   5 +
 drivers/platform/x86/Kconfig        |  11 ++
 drivers/platform/x86/Makefile       |   3 +
 drivers/platform/x86/adv_swbutton.c | 190 ++++++++++++++++++++++++++++
 4 files changed, 209 insertions(+)
 create mode 100644 drivers/platform/x86/adv_swbutton.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c71664ca8bfd..d8951050d273 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -571,6 +571,11 @@ S: Maintained
 F:     Documentation/scsi/advansys.rst
 F:     drivers/scsi/advansys.c

+ADVANTECH SWBTN DRIVER
+M:     Andrea Ho <Andrea.Ho@advantech.com.tw>
+S:     Maintained
+F:     drivers/platform/x86/adv_swbutton.c
+
 ADXL34X THREE-AXIS DIGITAL ACCELEROMETER DRIVER (ADXL345/ADXL346)
 M:     Michael Hennerich <michael.hennerich@analog.com>
 S:     Supported
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ad4e630e73e2..b553f3ebb9a7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -179,6 +179,17 @@ config ACER_WMI
          If you have an ACPI-WMI compatible Acer/ Wistron laptop, say Y or M
          here.

+config ADV_SWBUTTON
+    tristate "Advantech ACPI Software button Driver"
+    depends on ACPI
+    help
+      Say Y here to enable support for Advantech software defined
+      button feature. More information can be fount at
+      <http://www.advantech.com.tw/products/>
+
+      To compile this driver as a module, choose M here. The module will
+      be called adv_swbutton.
+
 config AMD_PMC
        tristate "AMD SoC PMC driver"
        depends on ACPI && PCI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 60d554073749..2faadc614cd2 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -21,6 +21,9 @@ obj-$(CONFIG_ACERHDF)         += acerhdf.o
 obj-$(CONFIG_ACER_WIRELESS)    += acer-wireless.o
 obj-$(CONFIG_ACER_WMI)         += acer-wmi.o

+# Advantech
+obj-$(CONFIG_ADV_SWBUTTON)  += adv_swbutton.o
+
 # AMD
 obj-$(CONFIG_AMD_PMC)          += amd-pmc.o

diff --git a/drivers/platform/x86/adv_swbutton.c
b/drivers/platform/x86/adv_swbutton.c
new file mode 100644
index 000000000000..09e5a83c61a9
--- /dev/null
+++ b/drivers/platform/x86/adv_swbutton.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  adv_swbutton.c - Software Button Interface Driver.
+ *
+ *  (C) Copyright 2020 Advantech Corporation, Inc
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/acpi.h>
+#include <linux/ktime.h>
+#include <linux/moduleparam.h>
+#include <acpi/button.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+
+#define ACPI_SWBTN_NAME                     "Software Button"
+#define ACPI_BUTTON_CLASS                   "button"
+
+#define ACPI_BUTTON_SUBCLASS_SOFTWARE       "software"
+#define ACPI_BUTTON_HID_SWBTN               "AHC0310"
+#define ACPI_BUTTON_TYPE_SOFTWARE           0x07
+
+#define ACPI_BUTTON_FILE_INFO               "info"
+#define ACPI_BUTTON_FILE_STATE              "state"
+#define ACPI_BUTTON_TYPE_UNKNOWN            0x00
+
+#define ACPI_BUTTON_NOTIFY_SWBTN_RELEASE    0x86
+#define ACPI_BUTTON_NOTIFY_SWBTN_PRESSED    0x85
+
+#define SOFTWARE_BUTTON                     BTN_TRIGGER_HAPPY
+
+#define _COMPONENT                          ACPI_BUTTON_COMPONENT
+
+struct acpi_button {
+       unsigned int type;
+       struct input_dev *input;
+       char phys[32];
+       bool pressed;
+};
+
+/*-------------------------------------------------------------------------
+ *                               Driver Interface
+ *--------------------------------------------------------------------------
+ */
+static void acpi_button_notify(struct acpi_device *device, u32 event)
+{
+       struct acpi_button *button = acpi_driver_data(device);
+       struct input_dev *input;
+
+       int keycode, BTN_KEYCODE = SOFTWARE_BUTTON;
+
+       switch (event) {
+       case ACPI_BUTTON_NOTIFY_SWBTN_RELEASE:
+               input = button->input;
+
+               if (!button->pressed)
+                       return;
+
+               keycode = test_bit(BTN_KEYCODE, input->keybit) ?
+                               BTN_KEYCODE : KEY_UNKNOWN;
+
+               button->pressed = false;
+
+               input_report_key(input, keycode, 0);
+               input_sync(input);
+       break;
+       case ACPI_BUTTON_NOTIFY_SWBTN_PRESSED:
+               input = button->input;
+               button->pressed = true;
+
+               keycode = test_bit(BTN_KEYCODE, input->keybit) ?
+                           BTN_KEYCODE : KEY_UNKNOWN;
+
+               input_report_key(input, keycode, 1);
+               input_sync(input);
+       break;
+       default:
+               ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+                                 "Unsupported event [0x%x]\n", event));
+       break;
+       }
+}
+
+static int acpi_button_add(struct acpi_device *device)
+{
+       struct acpi_button *button;
+       struct input_dev *input;
+       const char *hid = acpi_device_hid(device);
+       char *name, *class;
+       int error;
+
+       button = devm_kzalloc(&device->dev, sizeof(*button), GFP_KERNEL);
+       if (!button)
+               return -ENOMEM;
+
+       device->driver_data = button;
+       input = devm_input_allocate_device(&device->dev);
+       if (!input) {
+               error =  -ENOMEM;
+               goto err_free_mem;
+       }
+
+       button->input = input;
+
+       name = acpi_device_name(device);
+       class = acpi_device_class(device);
+
+       if (!strcmp(hid, ACPI_BUTTON_HID_SWBTN)) {
+               button->type = ACPI_BUTTON_TYPE_SOFTWARE;
+               button->pressed = false;
+               strcpy(name, ACPI_SWBTN_NAME);
+               sprintf(class, "%s/%s", ACPI_BUTTON_CLASS,
+                       ACPI_BUTTON_SUBCLASS_SOFTWARE);
+       } else {
+               return -ENODEV;
+       }
+
+       snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
+
+       input->name = name;
+       input->phys = button->phys;
+       input->id.bustype = BUS_HOST;
+       input->id.product = button->type;
+       input->dev.parent = &device->dev;
+
+       switch (button->type) {
+       case ACPI_BUTTON_TYPE_SOFTWARE:
+               set_bit(EV_KEY, input->evbit);
+               set_bit(EV_REP, input->evbit);
+
+               input_set_capability(input, EV_KEY, SOFTWARE_BUTTON);
+       break;
+       }
+
+       input_set_drvdata(input, device);
+       error = input_register_device(input);
+       if (error)
+               return error;
+
+       device_init_wakeup(&device->dev, true);
+
+       return 0;
+
+err_free_mem:
+       devm_kfree(&device->dev, button);
+       return error;
+}
+
+static int acpi_button_remove(struct acpi_device *device)
+{
+       struct acpi_button *button = acpi_driver_data(device);
+
+       input_unregister_device(button->input);
+       devm_kfree(&device->dev, button);
+       return 0;
+}
+
+static const struct acpi_device_id button_device_ids[] = {
+       {ACPI_BUTTON_HID_SWBTN, 0},
+       {"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, button_device_ids);
+
+static struct acpi_driver acpi_button_driver = {
+       .name = ACPI_SWBTN_NAME,
+       .class = ACPI_BUTTON_CLASS,
+       .owner = THIS_MODULE,
+       .ids = button_device_ids,
+       .ops = {
+               .add = acpi_button_add,
+               .remove = acpi_button_remove,
+               .notify = acpi_button_notify,
+       },
+};
+
+module_acpi_driver(acpi_button_driver);
+
+ACPI_MODULE_NAME("swbutton");
+
+MODULE_AUTHOR("Andrea Ho");
+MODULE_DESCRIPTION("Advantech ACPI SW Button Driver");
+MODULE_LICENSE("GPL v2");
--
2.17.1
