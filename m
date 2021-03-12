Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88E133886E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhCLJRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:17:03 -0500
Received: from d2-forwarder.nctu.edu.tw ([140.113.2.79]:11373 "EHLO
        d2-forwarder.nctu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhCLJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:16:48 -0500
X-Greylist: delayed 3895 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Mar 2021 04:16:47 EST
Received: from d2-forwarder.nctu.edu.tw (localhost [127.0.0.1])
        by d2-forwarder.nctu.edu.tw (Postfix) with ESMTP id B61BD443A1;
        Fri, 12 Mar 2021 16:11:48 +0800 (CST)
X-Virus-Scanned: amavisd-new at d2-forwarder.nctu.edu.tw
Received: from d2-forwarder.nctu.edu.tw ([127.0.0.1])
        by d2-forwarder.nctu.edu.tw (amavisd.cc.nctu.edu.tw [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OO5u3A3wJlnN; Fri, 12 Mar 2021 16:11:44 +0800 (CST)
Received: from smtp.nctu.edu.tw (mailreg [140.113.2.23])
        by d2-forwarder.nctu.edu.tw (Postfix) with ESMTP id 6DFA84437F;
        Fri, 12 Mar 2021 16:11:44 +0800 (CST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: andrea.cs97g)
        by smtp.nctu.edu.tw (Postfix) with ESMTPSA id 0493A7090E;
        Fri, 12 Mar 2021 16:11:44 +0800 (CST)
Received: by mail-ot1-f49.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so977305oto.2;
        Fri, 12 Mar 2021 00:11:43 -0800 (PST)
X-Gm-Message-State: AOAM5337vQSnLL8QoB2b2zwxVSNvuDrwgUZ4mOXbAfjs04WTs53t8iPS
        MyGbEnbLb3EG8lLXXGRqKT8XI2iRquwEfKelgsA=
X-Google-Smtp-Source: ABdhPJzFo+rI8dc7DsySSVfWFvfETnv5jpgSMCKsULnonmC/z52cmmxbm9a4mqaG/Z6YLE76RiRsoAIwVogJd6RjTk8=
X-Received: by 2002:a9d:24c7:: with SMTP id z65mr2474316ota.243.1615536701294;
 Fri, 12 Mar 2021 00:11:41 -0800 (PST)
MIME-Version: 1.0
From:   YingChieh Ho <andrea.cs97g@nctu.edu.tw>
Date:   Fri, 12 Mar 2021 16:11:21 +0800
X-Gmail-Original-Message-ID: <CAGBRx8NKMqYxz=PWHnHQoxP4f9J4faooMt82DwUAKT8oWYH34w@mail.gmail.com>
Message-ID: <CAGBRx8NKMqYxz=PWHnHQoxP4f9J4faooMt82DwUAKT8oWYH34w@mail.gmail.com>
Subject: [V2,1/1] platform/x86: add support for Advantech software defined button
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mark Gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org,
        Andrea Ho <andrea.ho@advantech.com.tw>
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
(KEY_PROG1) by pressing button that cloud be get on user
interface and trigger the customized actions.

Signed-off-by: Andrea.Ho <Andrea.Ho@advantech.com.tw>

v2:
        - change evdev key-code from BTN_TRIGGER_HAPPY to KEY_PROG1
        - to rewrite the driver to be a regular platform_driver
        - use specific names instead of generic names,
          "Software Button" to "Advantech Software Button",
          "button" to "adv_swbutton"
        - remove unused defines or use-once defines, ACPI_BUTTON_FILE_INFO,
          ACPI_BUTTON_FILE_STATE, ACPI_BUTTON_TYPE_UNKNOWN, ACPI_SWBTN_NAME
---
 MAINTAINERS                         |   5 +
 drivers/platform/x86/Kconfig        |  11 ++
 drivers/platform/x86/Makefile       |   3 +
 drivers/platform/x86/adv_swbutton.c | 192 ++++++++++++++++++++++++++++
 4 files changed, 211 insertions(+)
 create mode 100644 drivers/platform/x86/adv_swbutton.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..e35c48e411b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -562,6 +562,11 @@ S: Maintained
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
index 0581a54cf562..b1340135c5e9 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -180,6 +180,17 @@ config ACER_WMI
          If you have an ACPI-WMI compatible Acer/ Wistron laptop, say Y or M
          here.

+config ADV_SWBUTTON
+    tristate "Advantech ACPI Software Button Driver"
+    depends on ACPI
+    help
+      Say Y here to enable support for Advantech software defined
+      button feature. More information can be fount at
+      <http://www.advantech.com.tw/products/>
+
+      To compile this driver as a module, choose M here. The module will
+      be called adv_swbutton.
+
 config APPLE_GMUX
        tristate "Apple Gmux Driver"
        depends on ACPI && PCI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 2b85852a1a87..76a321fc58ba 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -22,6 +22,9 @@ obj-$(CONFIG_ACERHDF)         += acerhdf.o
 obj-$(CONFIG_ACER_WIRELESS)    += acer-wireless.o
 obj-$(CONFIG_ACER_WMI)         += acer-wmi.o

+# Advantech
+obj-$(CONFIG_ADV_SWBUTTON)  += adv_swbutton.o
+
 # Apple
 obj-$(CONFIG_APPLE_GMUX)       += apple-gmux.o

diff --git a/drivers/platform/x86/adv_swbutton.c
b/drivers/platform/x86/adv_swbutton.c
new file mode 100644
index 000000000000..f4387220e8a0
--- /dev/null
+++ b/drivers/platform/x86/adv_swbutton.c
@@ -0,0 +1,192 @@
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
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <acpi/button.h>
+#include <acpi/acpi_drivers.h>
+
+#define MODULE_NAME                         "adv_swbutton"
+
+#define ACPI_BUTTON_HID_SWBTN               "AHC0310"
+#define ACPI_BUTTON_TYPE_SOFTWARE           0x07
+
+#define ACPI_BUTTON_NOTIFY_SWBTN_RELEASE    0x86
+#define ACPI_BUTTON_NOTIFY_SWBTN_PRESSED    0x85
+
+#define SOFTWARE_BUTTON                     KEY_PROG1
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
+static void acpi_button_notify(acpi_handle handle, u32 event, void *context)
+{
+       struct acpi_device *device = context;
+
+       struct acpi_button *button = dev_get_drvdata(&device->dev);
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
+static int acpi_button_probe(struct platform_device *device)
+{
+       struct acpi_device *acpi_device;
+       struct acpi_button *button;
+       struct input_dev *input;
+       acpi_status status;
+
+       int error;
+
+       acpi_device = ACPI_COMPANION(&device->dev);
+       if (!acpi_device) {
+               dev_err(&device->dev, "ACPI companion is missing\n");
+               return -ENOMEM;
+       }
+
+       status = acpi_install_notify_handler(acpi_device->handle,
+                                            ACPI_DEVICE_NOTIFY,
+                                            acpi_button_notify,
+                                            acpi_device);
+       if (ACPI_FAILURE(status)) {
+               dev_err(&device->dev, "Error installing notify handler\n");
+               error = -ENODEV;
+       }
+
+       button = devm_kzalloc(&acpi_device->dev, sizeof(*button), GFP_KERNEL);
+       if (!button)
+               return -ENOMEM;
+
+       dev_set_drvdata(&acpi_device->dev, button);
+
+       input = devm_input_allocate_device(&acpi_device->dev);
+       if (!input) {
+               error =  -ENOMEM;
+               goto err_free_mem;
+       }
+
+       button->input = input;
+       button->type = ACPI_BUTTON_TYPE_SOFTWARE;
+       button->pressed = false;
+
+       snprintf(button->phys, sizeof(button->phys),
"%s/button/input0", ACPI_BUTTON_HID_SWBTN);
+
+       input->name = "Advantech Software Button";
+       input->phys = button->phys;
+       input->id.bustype = BUS_HOST;
+       input->id.product = button->type;
+       input->dev.parent = &acpi_device->dev;
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
+       input_set_drvdata(input, acpi_device);
+       error = input_register_device(input);
+       if (error)
+               return error;
+
+       device_init_wakeup(&acpi_device->dev, true);
+
+       return 0;
+
+err_free_mem:
+       devm_kfree(&device->dev, button);
+       return error;
+}
+
+static int acpi_button_remove(struct platform_device *device)
+{
+       struct acpi_device *acpi_device = ACPI_COMPANION(&device->dev);
+       struct acpi_button *button = dev_get_drvdata(&acpi_device->dev);
+
+       acpi_remove_notify_handler(acpi_device->handle, ACPI_DEVICE_NOTIFY,
+                                  acpi_button_notify);
+
+       input_unregister_device(button->input);
+       devm_kfree(&acpi_device->dev, button);
+
+       return 0;
+}
+
+static const struct acpi_device_id button_device_ids[] = {
+       {ACPI_BUTTON_HID_SWBTN, 0},
+       {"", 0},
+};
+
+MODULE_DEVICE_TABLE(acpi, button_device_ids);
+
+static struct platform_driver acpi_button_driver = {
+       .driver = {
+               .name = MODULE_NAME,
+               .acpi_match_table = button_device_ids,
+       },
+       .probe = acpi_button_probe,
+       .remove = acpi_button_remove,
+};
+
+module_platform_driver(acpi_button_driver);
+
+ACPI_MODULE_NAME(MODULE_NAME);
+
+MODULE_AUTHOR("Andrea Ho");
+MODULE_DESCRIPTION("Advantech ACPI SW Button Driver");
+MODULE_LICENSE("GPL v2");
--
2.17.1
