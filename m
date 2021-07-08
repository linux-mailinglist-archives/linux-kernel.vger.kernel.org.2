Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BF83C1B93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 00:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhGHWp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 18:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhGHWpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 18:45:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D7C061574;
        Thu,  8 Jul 2021 15:42:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n33so5098340wms.1;
        Thu, 08 Jul 2021 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUg0OzAAYGqZcpEHpJpOK9a0znuiIQ3W0JwwGxaqD0o=;
        b=lhiYDZxDdw4bNnOCZ3Y6pShqZ/RC9q1TPMxVm+5O/1EYjyZ78Dq+lkSt8FubGYcFEE
         po+UB7U4QKHpifAKTNHYHqmPh+s12fMu1G4BsCd4kwAMwkz2oz8MqmREbrvPBTkxr5YJ
         BssnHR6Udm0UP75Oz7SQh0BRYVXnqKl0809ZGICxzrj0kwu77ufajA0Gw0LPBXhu6unw
         GtDuFRyn/C106L5aiZ0hs/pNlC/Aa4ZeNw9y2DrAqP0WT/27AbFwCNKwpF7hHz5LCA8j
         mNkwURAsu3HaSu1tsQHhCJJtFu5IaNWrUFYuzGwd6NUmMbK0tNzwUf47Ih7jnSHggJRv
         aF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUg0OzAAYGqZcpEHpJpOK9a0znuiIQ3W0JwwGxaqD0o=;
        b=Vk/N3uYgK6xX6rk8JDZ1EoG+mGCZ8Rbxp+rdOiuy8Rwacd4sz1iJYlArmm0F31tWKZ
         lKI9tTeED/9ytnAQjahCAExfCvvymzF8ZpcuukfgwSrKWS0AnXMiWgQYQnj4lfjke9mH
         z/S/e5VsuX47r8Uis8PExf79fE1JAj2I6oqIsm3emPkrX1ujuYZT0UUTEMl/URYdifxr
         eGnvIYjKzJHCsHa26QCGDnQVvMehUCumvasSgDxpAtOVjtDir6zVXQ1CXyFoVhwBNz9x
         lq2DcsZuD8UhPe38fqrjclfd0Q0zBTr2sA9S1oAWc87z4dLnjOZQwgbxpILgdE1WatyC
         Jm5A==
X-Gm-Message-State: AOAM532oIgWrBgKvy1rQVImWJxCK95d0WwOE7hKv5NXB+hdbD+b03DBU
        8BrYNHFPAy6VSCsIpC4f7/EDf+RRe0A=
X-Google-Smtp-Source: ABdhPJzPZgd0mTkEsn2Ag64pVyhYmpJbazexrNwYfc9oGXRs5wUpBHL53fnkbrmyO1fc67UW/3Rtag==
X-Received: by 2002:a1c:f717:: with SMTP id v23mr7673943wmh.32.1625784156381;
        Thu, 08 Jul 2021 15:42:36 -0700 (PDT)
Received: from valhalla.home ([2.29.20.111])
        by smtp.gmail.com with ESMTPSA id l4sm3080655wme.26.2021.07.08.15.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 15:42:36 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        andy.shevchenko@gmail.com, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
Subject: [RFC PATCH 2/2] platform/surface: Add Surface Go 2 board file
Date:   Thu,  8 Jul 2021 23:42:26 +0100
Message-Id: <20210708224226.457224-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708224226.457224-1-djrscally@gmail.com>
References: <20210708224226.457224-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSDT tables on the Surface Go 2 contain no power control methods for
the world facing camera, so the regulator, gpio and clk frameworks have no
way to discover the appropriate connections and settings.

To compensate for the shortcomings, define the connections and other
parameters in a board file for this device.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 MAINTAINERS                             |   6 ++
 drivers/platform/surface/Kconfig        |  10 ++
 drivers/platform/surface/Makefile       |   1 +
 drivers/platform/surface/surface_go_2.c | 135 ++++++++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 drivers/platform/surface/surface_go_2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 52e61092c63b..f11e68daf939 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12143,6 +12143,12 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
 F:	drivers/platform/surface/surface_dtx.c
 F:	include/uapi/linux/surface_aggregator/dtx.h
 
+MICROSOFT SURFACE GO 2 SUPPORT
+M:	Daniel Scally <djrscally@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/surface/surface_go_2.c
+
 MICROSOFT SURFACE GPE LID SUPPORT DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 3105f651614f..0c55bd531592 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -124,6 +124,16 @@ config SURFACE_DTX
 	  Aggregator Bus (i.e. CONFIG_SURFACE_AGGREGATOR_BUS=n). In that case,
 	  some devices, specifically the Surface Book 3, will not be supported.
 
+config SURFACE_GO_2
+	bool "Surface Go 2 Specific Driver"
+	help
+	  This board file performs some platform specific configuration to help
+	  the regulator, gpio and clk frameworks link those resources to the
+	  consuming devices - specifically the world facing camera.
+
+	  Select Y here if your device is a Microsoft Surface Go 2, otherwise
+	  select N.
+
 config SURFACE_GPE
 	tristate "Surface GPE/Lid Support Driver"
 	depends on DMI
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 32889482de55..9f858d2a3d77 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
 obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
 obj-$(CONFIG_SURFACE_AGGREGATOR_REGISTRY) += surface_aggregator_registry.o
 obj-$(CONFIG_SURFACE_DTX)		+= surface_dtx.o
+obj-$(CONFIG_SURFACE_GO_2)		+= surface_go_2.o
 obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
 obj-$(CONFIG_SURFACE_HOTPLUG)		+= surface_hotplug.o
 obj-$(CONFIG_SURFACE_PLATFORM_PROFILE)	+= surface_platform_profile.o
diff --git a/drivers/platform/surface/surface_go_2.c b/drivers/platform/surface/surface_go_2.c
new file mode 100644
index 000000000000..4a335f0d5fd5
--- /dev/null
+++ b/drivers/platform/surface/surface_go_2.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dan Scally <djrscally@gmail.com> */
+
+#include <linux/acpi.h>
+#include <linux/gpio/machine.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/property.h>
+
+static const struct software_node tps68470_node = {
+	"INT3472",
+};
+
+static const struct property_entry ana_properties[] = {
+	PROPERTY_ENTRY_STRING("regulator-name", "ANA"),
+	PROPERTY_ENTRY_U32("regulator-min-microvolt", 2815200),
+	PROPERTY_ENTRY_U32("regulator-max-microvolt", 2815200),
+	{ }
+};
+
+static const struct property_entry vsio_properties[] = {
+	PROPERTY_ENTRY_STRING("regulator-name", "VSIO"),
+	PROPERTY_ENTRY_U32("regulator-min-microvolt", 1800600),
+	PROPERTY_ENTRY_U32("regulator-max-microvolt", 1800600),
+	{ }
+};
+
+static const struct property_entry core_properties[] = {
+	PROPERTY_ENTRY_STRING("regulator-name", "CORE"),
+	PROPERTY_ENTRY_U32("regulator-min-microvolt", 1200000),
+	PROPERTY_ENTRY_U32("regulator-max-microvolt", 1200000),
+	{ }
+};
+
+static const struct software_node regulator_nodes[] = {
+	{"ANA", &tps68470_node, ana_properties},
+	{"VSIO", &tps68470_node, vsio_properties},
+	{"CORE", &tps68470_node, core_properties},
+};
+
+static const struct property_entry sensor_properties[] = {
+	PROPERTY_ENTRY_REF("avdd-supply", &regulator_nodes[0]),
+	PROPERTY_ENTRY_REF("dovdd-supply", &regulator_nodes[1]),
+	PROPERTY_ENTRY_REF("dvdd-supply", &regulator_nodes[2]),
+	{ }
+};
+
+static struct software_node sensor_node = {
+	.name		= "INT347A",
+	.properties	= sensor_properties,
+};
+
+static struct gpiod_lookup_table surface_go_2_gpios = {
+	.dev_id = "i2c-INT347A:00",
+	.table = {
+		GPIO_LOOKUP("tps68470-gpio", 9, "reset", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tps68470-gpio", 7, "powerdown", GPIO_ACTIVE_LOW)
+	}
+};
+
+static int __init surface_go_2_init(void)
+{
+	struct fwnode_handle *fwnode, *sensor_fwnode;
+	struct acpi_device *adev, *sensor;
+	int ret;
+
+	adev = acpi_dev_get_first_match_dev("INT3472", "0", -1);
+	if (!adev) {
+		pr_err("%s(): Failed to find INT3472 ACPI device\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = software_node_register(&tps68470_node);
+	if (ret) {
+		dev_err(&adev->dev, "Failed to add tps68470 software node\n");
+		goto err_put_adev;
+	}
+
+	fwnode = software_node_fwnode(&tps68470_node);
+	if (!fwnode) {
+		dev_err(&adev->dev, "Failed to find tps68470 fwnode\n");
+		ret = -ENODEV;
+		goto err_put_adev;
+	}
+
+	adev->fwnode.secondary = fwnode;
+
+	ret = software_node_register_nodes(regulator_nodes);
+	if (ret) {
+		dev_err(&adev->dev,
+			"failed to register software nodes for regulator\n");
+		goto err_unregister_node;
+	}
+
+	gpiod_add_lookup_table(&surface_go_2_gpios);
+
+	sensor = acpi_dev_get_first_match_dev("INT347A", "0", -1);
+	if (!sensor) {
+		pr_err("%s(): Failed to find sensor\n", __func__);
+		ret = -ENODEV;
+		goto err_remove_gpio_lookup;
+	}
+
+	ret = software_node_register(&sensor_node);
+	if (ret) {
+		dev_err(&sensor->dev, "Failed to add sensor node\n");
+		goto err_put_sensor;
+	}
+
+	sensor_fwnode = software_node_fwnode(&sensor_node);
+	if (!sensor_fwnode) {
+		dev_err(&sensor->dev, "Failed to find sensor fwnode\n");
+		ret = -ENODEV;
+		goto err_unregister_sensor_node;
+	}
+
+	sensor->fwnode.secondary = sensor_fwnode;
+
+	return ret;
+
+err_unregister_sensor_node:
+	software_node_unregister(&sensor_node);
+err_put_sensor:
+	acpi_dev_put(sensor);
+err_remove_gpio_lookup:
+	gpiod_remove_lookup_table(&surface_go_2_gpios);
+err_unregister_node:
+	adev->fwnode.secondary = -ENODEV;
+	software_node_unregister(&tps68470_node);
+err_put_adev:
+	acpi_dev_put(adev);
+
+	return ret;
+}
+device_initcall(surface_go_2_init);
-- 
2.25.1

