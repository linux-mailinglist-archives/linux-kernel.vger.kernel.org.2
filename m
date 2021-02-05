Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78090310238
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhBEB2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhBEB16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:27:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29780C0613D6;
        Thu,  4 Feb 2021 17:27:18 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id w2so8938274ejk.13;
        Thu, 04 Feb 2021 17:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ENdcJKdIE6MnZ+QmdXpe5oIB1IicpeG9orGAEXd6Czk=;
        b=GSaJrftP5/la81DOvovkh6hsx+dUyNnSCJmGrT9yhP1/1zyHKrpB8/Bjx+UruN199L
         kjaxbDro141Vfdxqb0F4ILt/vNCNxylFcF1JjKDD04wT9V4ADmacU//uDuuDgqgppssz
         XtEdr+GORo4MxefJcO4yfPWIF6coPupVvFML7z7Jz3s8Wtkhbvd8hW1dApLdztZUgoCB
         xtLPS5OF0SSqk8FtuM2d9FaSmpix0wUCnozjgWeJwBmfXEzAwDKsTN9FaEUbq2LdBbb/
         n27KhI5VcN6a5Yf+fMEryWfZqUK3iaqd06nsoohYuunRY51i9I0PhXd8eLCQdh2gP6Mf
         sEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ENdcJKdIE6MnZ+QmdXpe5oIB1IicpeG9orGAEXd6Czk=;
        b=SlV+PiavS3uQE+vovJ+Ad6r1U+lM+hF1H6Zg4dRNwynSh4wofmQD1PqgN5LPEL2H+t
         agqkFUlL7HsJJi8Dq5VyuCE/BpMs/8v2CI5iDw+1T9hp3D9TvVqFqD5IZ8+DJIigFZIX
         p/1FJR70JleFhL40NA6u9GE9N9eF38ebAoKmYtyt6KR4+SngYYyCRDKca0H5cbVAVB6V
         c6TmaWKuAJuQADn8V5IMX4/sw0Q5J2WN06sArwTKtYXRB6r6W5oZXhdqM4edVqd+uscF
         hK6JNyT2vw8dFWD0zXsyK70X6kN93bKLD44+4PNYkagP4NGq2xcVwOV6F5IXwW9WzUHh
         akmA==
X-Gm-Message-State: AOAM532JcSpQCenxjbCCejphl+ooD+Mp4yw0HTKkJwOLdGBdJxW2ChBC
        a9LjqLXYHeqiHeVRk7GB5QM=
X-Google-Smtp-Source: ABdhPJyUk4tWHpf3ok2xwFamcB58FmR1ArwObK8Rlx7IR2eYpYwHWfj1F2MR5BvQBtGgOtfpPMWYMw==
X-Received: by 2002:a17:906:d0cd:: with SMTP id bq13mr1715860ejb.75.1612488436760;
        Thu, 04 Feb 2021 17:27:16 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id j23sm3263676edv.45.2021.02.04.17.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 17:27:15 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/surface: Add Surface Hot-Plug driver
Date:   Fri,  5 Feb 2021 02:26:57 +0100
Message-Id: <20210205012657.1951753-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Surface Book 2 and 3 models have a discrete GPU (dGPU) that is
hot-pluggable. On those devices, the dGPU is contained in the base,
which can be separated from the tablet part (containing CPU and
touchscreen) while the device is running.

It (in general) is presented as/behaves like a standard PCIe hot-plug
capable device, however, this device can also be put into D3cold. In
D3cold, the device itself is turned off and can thus not submit any
standard PCIe hot-plug events. To properly detect hot-(un)plugging while
the dGPU is in D3cold, out-of-band signaling is required. Without this,
the device state will only get updated during the next bus-check, eg.
via a manually issued lspci call.

This commit adds a driver to handle out-of-band PCIe hot-(un)plug events
on Microsoft Surface devices. On those devices, said events can be
detected via GPIO interrupts, which are then forwarded to the
corresponding ACPI DSM calls by this driver. The DSM then takes care of
issuing the appropriate bus-/device-check, causing the PCI core to
properly pick up the device change.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 MAINTAINERS                                |   6 +
 drivers/platform/surface/Kconfig           |  19 ++
 drivers/platform/surface/Makefile          |   1 +
 drivers/platform/surface/surface_hotplug.c | 282 +++++++++++++++++++++
 4 files changed, 308 insertions(+)
 create mode 100644 drivers/platform/surface/surface_hotplug.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 34bfa5c1aec5..4fcf3df517a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11805,6 +11805,12 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
 F:	drivers/platform/surface/
 
+MICROSOFT SURFACE HOT-PLUG DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/surface/surface_hotplug.c
+
 MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 83b0a4c7b352..0847b2dc97bf 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -86,6 +86,25 @@ config SURFACE_GPE
 	  accordingly. It is required on those devices to allow wake-ups from
 	  suspend by opening the lid.
 
+config SURFACE_HOTPLUG
+	tristate "Surface Hot-Plug Driver"
+	depends on GPIOLIB
+	help
+	  Driver for out-of-band hot-plug event signaling on Microsoft Surface
+	  devices with hot-pluggable PCIe cards.
+
+	  This driver is used on Surface Book (2 and 3) devices with a
+	  hot-pluggable discrete GPU (dGPU). When not in use, the dGPU on those
+	  devices can enter D3cold, which prevents in-band (standard) PCIe
+	  hot-plug signaling. Thus, without this driver, detaching the base
+	  containing the dGPU will not correctly update the state of the
+	  corresponding PCIe device if it is in D3cold. This driver adds support
+	  for out-of-band hot-plug notifications, ensuring that the device state
+	  is properly updated even when the device in question is in D3cold.
+
+	  Select M or Y here, if you want to (fully) support hot-plugging of
+	  dGPU devices on the Surface Book 2 and/or 3 during D3cold.
+
 config SURFACE_PRO3_BUTTON
 	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
 	depends on INPUT
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 3eb971006877..990424c5f0c9 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -11,4 +11,5 @@ obj-$(CONFIG_SURFACE_ACPI_NOTIFY)	+= surface_acpi_notify.o
 obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
 obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
 obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
+obj-$(CONFIG_SURFACE_HOTPLUG)		+= surface_hotplug.o
 obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
diff --git a/drivers/platform/surface/surface_hotplug.c b/drivers/platform/surface/surface_hotplug.c
new file mode 100644
index 000000000000..cfcc15cfbacb
--- /dev/null
+++ b/drivers/platform/surface/surface_hotplug.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Surface Book (2 and later) hot-plug driver.
+ *
+ * Surface Book devices (can) have a hot-pluggable discrete GPU (dGPU). This
+ * driver is responsible for out-of-band hot-plug event signaling on these
+ * devices. It is specifically required when the hot-plug device is in D3cold
+ * and can thus not generate PCIe hot-plug events itself.
+ *
+ * Event signaling is handled via ACPI, which will generate the appropriate
+ * device-check notifications to be picked up by the PCIe hot-plug driver.
+ *
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+
+static const struct acpi_gpio_params shps_base_presence_int   = { 0, 0, false };
+static const struct acpi_gpio_params shps_base_presence       = { 1, 0, false };
+static const struct acpi_gpio_params shps_device_power_int    = { 2, 0, false };
+static const struct acpi_gpio_params shps_device_power        = { 3, 0, false };
+static const struct acpi_gpio_params shps_device_presence_int = { 4, 0, false };
+static const struct acpi_gpio_params shps_device_presence     = { 5, 0, false };
+
+static const struct acpi_gpio_mapping shps_acpi_gpios[] = {
+	{ "base_presence-int-gpio",   &shps_base_presence_int,   1 },
+	{ "base_presence-gpio",       &shps_base_presence,       1 },
+	{ "device_power-int-gpio",    &shps_device_power_int,    1 },
+	{ "device_power-gpio",        &shps_device_power,        1 },
+	{ "device_presence-int-gpio", &shps_device_presence_int, 1 },
+	{ "device_presence-gpio",     &shps_device_presence,     1 },
+	{ },
+};
+
+/* 5515a847-ed55-4b27-8352-cd320e10360a */
+static const guid_t shps_dsm_guid =
+	GUID_INIT(0x5515a847, 0xed55, 0x4b27, 0x83, 0x52, 0xcd, 0x32, 0x0e, 0x10, 0x36, 0x0a);
+
+#define SHPS_DSM_REVISION		1
+
+enum shps_dsm_fn {
+	SHPS_DSM_FN_PCI_NUM_ENTRIES	= 0x01,
+	SHPS_DSM_FN_PCI_GET_ENTRIES	= 0x02,
+	SHPS_DSM_FN_IRQ_BASE_PRESENCE	= 0x03,
+	SHPS_DSM_FN_IRQ_DEVICE_POWER	= 0x04,
+	SHPS_DSM_FN_IRQ_DEVICE_PRESENCE	= 0x05,
+};
+
+enum shps_irq_type {
+	/* NOTE: Must be in order of enum shps_dsm_fn above. */
+	SHPS_IRQ_TYPE_BASE_PRESENCE	= 0,
+	SHPS_IRQ_TYPE_DEVICE_POWER	= 1,
+	SHPS_IRQ_TYPE_DEVICE_PRESENCE	= 2,
+	SHPS_NUM_IRQS,
+};
+
+static const char *const shps_gpio_names[] = {
+	[SHPS_IRQ_TYPE_BASE_PRESENCE]	= "base_presence",
+	[SHPS_IRQ_TYPE_DEVICE_POWER]	= "device_power",
+	[SHPS_IRQ_TYPE_DEVICE_PRESENCE]	= "device_presence",
+};
+
+struct shps_device {
+	struct mutex lock[SHPS_NUM_IRQS];  /* Protects update in shps_dsm_notify_irq() */
+	struct gpio_desc *gpio[SHPS_NUM_IRQS];
+	unsigned int irq[SHPS_NUM_IRQS];
+};
+
+#define SHPS_IRQ_NOT_PRESENT		((unsigned int)-1)
+
+static enum shps_dsm_fn shps_dsm_fn_for_irq(enum shps_irq_type type)
+{
+	return SHPS_DSM_FN_IRQ_BASE_PRESENCE + type;
+}
+
+static void shps_dsm_notify_irq(struct platform_device *pdev, enum shps_irq_type type)
+{
+	struct shps_device *sdev = platform_get_drvdata(pdev);
+	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
+	union acpi_object *result;
+	union acpi_object param;
+	int value;
+
+	mutex_lock(&sdev->lock[type]);
+
+	value = gpiod_get_value_cansleep(sdev->gpio[type]);
+	if (value < 0) {
+		mutex_unlock(&sdev->lock[type]);
+		dev_err(&pdev->dev, "failed to get gpio: %d (irq=%d)\n", type, value);
+		return;
+	}
+
+	dev_dbg(&pdev->dev, "IRQ notification via DSM (irq=%d, value=%d)\n", type, value);
+
+	param.type = ACPI_TYPE_INTEGER;
+	param.integer.value = value;
+
+	result = acpi_evaluate_dsm(handle, &shps_dsm_guid, SHPS_DSM_REVISION,
+				   shps_dsm_fn_for_irq(type), &param);
+
+	if (!result) {
+		dev_err(&pdev->dev, "IRQ notification via DSM failed (irq=%d, gpio=%d)\n",
+			type, value);
+
+	} else if (result->type != ACPI_TYPE_BUFFER) {
+		dev_err(&pdev->dev,
+			"IRQ notification via DSM failed: unexpected result type (irq=%d, gpio=%d)\n",
+			type, value);
+
+	} else if (result->buffer.length != 1 || result->buffer.pointer[0] != 0) {
+		dev_err(&pdev->dev,
+			"IRQ notification via DSM failed: unexpected result value (irq=%d, gpio=%d)\n",
+			type, value);
+	}
+
+	mutex_unlock(&sdev->lock[type]);
+
+	if (result)
+		ACPI_FREE(result);
+}
+
+static irqreturn_t shps_handle_irq(int irq, void *data)
+{
+	struct platform_device *pdev = data;
+	struct shps_device *sdev = platform_get_drvdata(pdev);
+	int type;
+
+	/* Figure out which IRQ we're handling. */
+	for (type = 0; type < SHPS_NUM_IRQS; type++)
+		if (irq == sdev->irq[type])
+			break;
+
+	/* We should have found our interrupt, if not: this is a bug. */
+	if (WARN(type >= SHPS_NUM_IRQS, "invalid IRQ number: %d\n", irq))
+		return IRQ_HANDLED;
+
+	/* Forward interrupt to ACPI via DSM. */
+	shps_dsm_notify_irq(pdev, type);
+	return IRQ_HANDLED;
+}
+
+static int shps_setup_irq(struct platform_device *pdev, enum shps_irq_type type)
+{
+	unsigned long flags = IRQF_ONESHOT | IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING;
+	struct shps_device *sdev = platform_get_drvdata(pdev);
+	struct gpio_desc *gpiod;
+	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
+	const char *irq_name;
+	const int dsm = shps_dsm_fn_for_irq(type);
+	int status, irq;
+
+	/*
+	 * Only set up interrupts that we actually need: The Surface Book 3
+	 * does not have a DSM for base presence, so don't set up an interrupt
+	 * for that.
+	 */
+	if (!acpi_check_dsm(handle, &shps_dsm_guid, SHPS_DSM_REVISION, BIT(dsm))) {
+		dev_dbg(&pdev->dev, "IRQ notification via DSM not present (irq=%d)\n", type);
+		return 0;
+	}
+
+	gpiod = devm_gpiod_get(&pdev->dev, shps_gpio_names[type], GPIOD_ASIS);
+	if (IS_ERR(gpiod))
+		return PTR_ERR(gpiod);
+
+	irq = gpiod_to_irq(gpiod);
+	if (irq < 0)
+		return irq;
+
+	irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "shps-irq-%d", type);
+	if (!irq_name)
+		return -ENOMEM;
+
+	status = devm_request_threaded_irq(&pdev->dev, irq, NULL, shps_handle_irq,
+					   flags, irq_name, pdev);
+	if (status)
+		return status;
+
+	dev_dbg(&pdev->dev, "set up irq %d as type %d\n", irq, type);
+
+	sdev->gpio[type] = gpiod;
+	sdev->irq[type] = irq;
+
+	return 0;
+}
+
+static int surface_hotplug_remove(struct platform_device *pdev)
+{
+	struct shps_device *sdev = platform_get_drvdata(pdev);
+	int i;
+
+	/* Ensure that IRQs have been fully handled and won't trigger any more. */
+	for (i = 0; i < SHPS_NUM_IRQS; i++) {
+		if (sdev->irq[i] != SHPS_IRQ_NOT_PRESENT)
+			disable_irq(sdev->irq[i]);
+
+		mutex_destroy(&sdev->lock[i]);
+	}
+
+	return 0;
+}
+
+static int surface_hotplug_probe(struct platform_device *pdev)
+{
+	struct shps_device *sdev;
+	int status, i;
+
+	/*
+	 * The MSHW0153 device is also present on the Surface Laptop 3,
+	 * however that doesn't have a hot-pluggable PCIe device. It also
+	 * doesn't have any GPIO interrupts/pins under the MSHW0153, so filter
+	 * it out here.
+	 */
+	if (gpiod_count(&pdev->dev, NULL) < 0)
+		return -ENODEV;
+
+	status = devm_acpi_dev_add_driver_gpios(&pdev->dev, shps_acpi_gpios);
+	if (status)
+		return status;
+
+	sdev = devm_kzalloc(&pdev->dev, sizeof(*sdev), GFP_KERNEL);
+	if (!sdev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, sdev);
+
+	/*
+	 * Initialize IRQs so that we can safely call surface_hotplug_remove()
+	 * on errors.
+	 */
+	for (i = 0; i < SHPS_NUM_IRQS; i++)
+		sdev->irq[i] = SHPS_IRQ_NOT_PRESENT;
+
+	/* Set up IRQs. */
+	for (i = 0; i < SHPS_NUM_IRQS; i++) {
+		mutex_init(&sdev->lock[i]);
+
+		status = shps_setup_irq(pdev, i);
+		if (status) {
+			dev_err(&pdev->dev, "failed to set up IRQ %d: %d\n", i, status);
+			goto err;
+		}
+	}
+
+	/* Ensure everything is up-to-date. */
+	for (i = 0; i < SHPS_NUM_IRQS; i++)
+		if (sdev->irq[i] != SHPS_IRQ_NOT_PRESENT)
+			shps_dsm_notify_irq(pdev, i);
+
+	return 0;
+
+err:
+	surface_hotplug_remove(pdev);
+	return status;
+}
+
+static const struct acpi_device_id surface_hotplug_acpi_match[] = {
+	{ "MSHW0153", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, surface_hotplug_acpi_match);
+
+static struct platform_driver surface_hotplug_driver = {
+	.probe = surface_hotplug_probe,
+	.remove = surface_hotplug_remove,
+	.driver = {
+		.name = "surface_hotplug",
+		.acpi_match_table = surface_hotplug_acpi_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_platform_driver(surface_hotplug_driver);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Surface Hot-Plug Signaling Driver for Surface Book Devices");
+MODULE_LICENSE("GPL");
-- 
2.30.0

