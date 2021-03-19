Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABE53413D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCSDt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:49:58 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:39583 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhCSDt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:49:27 -0400
Received: by mail-pj1-f52.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so3778476pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lug4qgUDClRW1WnIWEXzkckRal9usq46ZsryZ/P7XuQ=;
        b=OEjF3vMsYiIo55C8x2NoJOm92upWzcrqOJuS1UKJMk9HgepcqXCa+hcClvp3Edd1xJ
         ZTBeAc8tQD9uMwUtvs0JK+9aXe3z1mQDTea6S2j9OzmWmUwSyiduCsHeYNqWGVH/mEnQ
         hudWkTU01e4oJE0dsFBcX2mp7+cP0IgpB5+jLx4sqO1e+K7Bmf3Rain7XmGGTua3l67o
         4kzdgdSiQmCpiCHzAy6H0CS5nV0d6DJD2S+smykHTZ9DSUloA+oLp2cknd8sf3QkTBT7
         CFjdjbDw3ujyw3+xXIEFAIBhnxnusEEA3y045UUasq0s7Bxim3dpKQivmO7QaDU+NjAk
         MV8Q==
X-Gm-Message-State: AOAM533RGVlKCGUY427Ly+jAemLhf4uJQlzJ4utqOIW39hWG3qvRMWJ1
        SBMTi5agQaDXZP7epmpQe1QFabVSa/Mhe51W
X-Google-Smtp-Source: ABdhPJyxqq8aWX3ifAI0LU16Txp/JizqakqQVl5N5KUScK+xzNe/EUmsb0WFN86Dg3Dhp44K8usCvw==
X-Received: by 2002:a17:902:da8d:b029:e5:c7d9:81f2 with SMTP id j13-20020a170902da8db02900e5c7d981f2mr12516854plx.21.1616125766491;
        Thu, 18 Mar 2021 20:49:26 -0700 (PDT)
Received: from FWA-T011.advantech.corp (61-219-255-68.HINET-IP.hinet.net. [61.219.255.68])
        by smtp.gmail.com with ESMTPSA id l22sm4179575pfd.145.2021.03.18.20.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 20:49:26 -0700 (PDT)
From:   YingChieh Ho <andrea.cs97g@nctu.edu.tw>
To:     YingChieh Ho <andrea.cs97g@nctu.edu.tw>
Cc:     linux-kernel@vger.kernel.org,
        "Andrea.Ho" <Andrea.Ho@advantech.com.tw>
Subject: [PATCH v3] platform/x86: add support for Advantech software defined button
Date:   Fri, 19 Mar 2021 03:48:48 +0000
Message-Id: <20210319034848.23400-1-andrea.cs97g@nctu.edu.tw>
X-Mailer: git-send-email 2.17.1
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
v3:
        - refined struct and functions of the driver
        - drop acpi_device and use adv_swbutton as driver name
        - remove all unnecessary defines

v2:
        - change evdev key-code from BTN_TRIGGER_HAPPY to KEY_PROG1
        - to rewrite the driver to be a regular platform_driver
        - use specific names instead of generic names,
          "Software Button" to "Advantech Software Button",
          "button" to "adv_swbutton"
        - remove unused defines or use-once defines
	  ACPI_BUTTON_FILE_INFO, ACPI_BUTTON_FILE_STATE,
	  ACPI_BUTTON_TYPE_UNKNOWN, ACPI_SWBTN_NAME
---
 MAINTAINERS                         |   5 ++
 drivers/platform/x86/Kconfig        |  11 +++
 drivers/platform/x86/Makefile       |   3 +
 drivers/platform/x86/adv_swbutton.c | 127 ++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 drivers/platform/x86/adv_swbutton.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..e35c48e411b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -562,6 +562,11 @@ S:	Maintained
 F:	Documentation/scsi/advansys.rst
 F:	drivers/scsi/advansys.c
 
+ADVANTECH SWBTN DRIVER
+M:	Andrea Ho <Andrea.Ho@advantech.com.tw>
+S:	Maintained
+F:	drivers/platform/x86/adv_swbutton.c
+
 ADXL34X THREE-AXIS DIGITAL ACCELEROMETER DRIVER (ADXL345/ADXL346)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
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
@@ -22,6 +22,9 @@ obj-$(CONFIG_ACERHDF)		+= acerhdf.o
 obj-$(CONFIG_ACER_WIRELESS)	+= acer-wireless.o
 obj-$(CONFIG_ACER_WMI)		+= acer-wmi.o
 
+# Advantech
+obj-$(CONFIG_ADV_SWBUTTON)  += adv_swbutton.o
+
 # Apple
 obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
 
diff --git a/drivers/platform/x86/adv_swbutton.c b/drivers/platform/x86/adv_swbutton.c
new file mode 100644
index 000000000000..8618dcbbd811
--- /dev/null
+++ b/drivers/platform/x86/adv_swbutton.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  adv_swbutton.c - Software Button Interface Driver.
+ *
+ *  (C) Copyright 2020 Advantech Corporation, Inc
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+
+#define ACPI_BUTTON_HID_SWBTN               "AHC0310"
+
+#define ACPI_BUTTON_NOTIFY_SWBTN_RELEASE    0x86
+#define ACPI_BUTTON_NOTIFY_SWBTN_PRESSED    0x85
+
+#define _COMPONENT                          ACPI_BUTTON_COMPONENT
+
+struct adv_swbutton {
+	struct input_dev *input;
+	char phys[32];
+};
+
+/*-------------------------------------------------------------------------
+ *                               Driver Interface
+ *--------------------------------------------------------------------------
+ */
+static void adv_swbutton_notify(acpi_handle handle, u32 event, void *context)
+{
+	struct platform_device *device = context;
+	struct adv_swbutton *button = dev_get_drvdata(&device->dev);
+
+	switch (event) {
+	case ACPI_BUTTON_NOTIFY_SWBTN_RELEASE:
+		input_report_key(button->input, KEY_PROG1, 0);
+		input_sync(button->input);
+	break;
+	case ACPI_BUTTON_NOTIFY_SWBTN_PRESSED:
+		input_report_key(button->input, KEY_PROG1, 1);
+		input_sync(button->input);
+	break;
+	default:
+		dev_dbg(&device->dev, "Unsupported event [0x%x]\n", event);
+	}
+}
+
+static int adv_swbutton_probe(struct platform_device *device)
+{
+	struct adv_swbutton *button;
+	struct input_dev *input;
+	acpi_handle handle = ACPI_HANDLE(&device->dev);
+	acpi_status status;
+
+	int error;
+
+	button = devm_kzalloc(&device->dev, sizeof(*button), GFP_KERNEL);
+	if (!button)
+		return -ENOMEM;
+
+	dev_set_drvdata(&device->dev, button);
+
+	input = devm_input_allocate_device(&device->dev);
+	if (!input)
+		return -ENOMEM;
+
+	button->input = input;
+
+	input->name = "Advantech Software Button";
+	input->phys = button->phys;
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = &device->dev;
+
+	set_bit(EV_KEY, input->evbit);
+	set_bit(EV_REP, input->evbit);
+
+	input_set_capability(input, EV_KEY, KEY_PROG1);
+	error = input_register_device(input);
+	if (error)
+		return error;
+
+	device_init_wakeup(&device->dev, true);
+
+	status = acpi_install_notify_handler(handle,
+					     ACPI_DEVICE_NOTIFY,
+					     adv_swbutton_notify,
+					     device);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&device->dev, "Error installing notify handler\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int adv_swbutton_remove(struct platform_device *device)
+{
+	acpi_handle handle = ACPI_HANDLE(&device->dev);
+
+	acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY,
+				   adv_swbutton_notify);
+
+	return 0;
+}
+
+static const struct acpi_device_id button_device_ids[] = {
+	{ACPI_BUTTON_HID_SWBTN, 0},
+	{"", 0},
+};
+
+MODULE_DEVICE_TABLE(acpi, button_device_ids);
+
+static struct platform_driver adv_swbutton_driver = {
+	.driver = {
+		.name = "adv_swbutton",
+		.acpi_match_table = button_device_ids,
+	},
+	.probe = adv_swbutton_probe,
+	.remove = adv_swbutton_remove,
+};
+
+module_platform_driver(adv_swbutton_driver);
+
+MODULE_AUTHOR("Andrea Ho");
+MODULE_DESCRIPTION("Advantech ACPI SW Button Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

