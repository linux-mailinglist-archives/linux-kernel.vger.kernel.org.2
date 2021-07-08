Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2567F3C1B92
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 00:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhGHWp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 18:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHWpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 18:45:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9FCC06175F;
        Thu,  8 Jul 2021 15:42:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso7827232wmh.4;
        Thu, 08 Jul 2021 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvUOlyzh89Y5KHQg8sXXVivyOcDl2hejbAKiOuf8MHw=;
        b=NRZda7jNRVfHNvTCws/m+ClujdGTTH1R5X3Vu5LRyCotwZixgYEGg/ye0+rYF2YYa3
         4PgxsxtudgtSyD/WcIpEPCvIDyzotRgoUYuZq1jEgEDxjG0B1jYcaW/k9ntSdD6oD0Mo
         Dbv2AW1H87hIWdDRrjsGJiTKxCsULKcqfOAo9FLmrDRcXlooKToYqoXuP8TOp+jZ0ewf
         z7V1NXeGcW7c0VJ+caWjzrfn+O/FBwdtd5NtWBLU4MDoK8ieDreZr2eO1oP9qAmXVPiy
         +QbS1A2fA5k9HMNfEcJmazqVRlpx81m47VhPaQ1GLaBbdYZHv0XneFzP9P9tv9EDQnF4
         D6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvUOlyzh89Y5KHQg8sXXVivyOcDl2hejbAKiOuf8MHw=;
        b=IQTOLHF/TXS4Y/7kOHxx16uCn+8o+9NoX2YVmcKp9dPsOBM/0HcsprxhHdVtLUnP3R
         lyAJSr4plFYO1urMO6K/rTkOUmWMRF6/uR0Nav0GMgtB6IXmz90Mq2ZhLcgCvC71qbF8
         0E/OiwKWwmv3bab3hUccvlsOsI19w5lyP4uY1IvH/RLzZ9hM9u6dJgUn4rOelzzIOvJ7
         HSLVMU69S2jst8SE58NToemn96cJyOk5YWM9znXpoUIoxn8ZwbvoPTCND/l7raA/AR2D
         wvPGNLYlenSAhON4MKs4tf21B3y1ZfDvcj/3CKSXwkFbLYZHhFzi8Qy2TNvUl+oC7jiE
         DKOA==
X-Gm-Message-State: AOAM532OJzXT0/FS/lJG8b+JXtBD5r+dd5IxcnQXQvvmYZT7uk9Q7sV6
        +/LbqckMK4orpt+OzHRrQPac4aekkrE=
X-Google-Smtp-Source: ABdhPJyinUwjVc2lEs/1l4CHbiYL3fOGyRCIwTmGUluaFFNm4gL8Of6uWjNbKz5+HNhVRxHK49ca7A==
X-Received: by 2002:a05:600c:1546:: with SMTP id f6mr35464808wmg.164.1625784155539;
        Thu, 08 Jul 2021 15:42:35 -0700 (PDT)
Received: from valhalla.home ([2.29.20.111])
        by smtp.gmail.com with ESMTPSA id l4sm3080655wme.26.2021.07.08.15.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 15:42:35 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        luzmaximilian@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        andy.shevchenko@gmail.com, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
Subject: [RFC PATCH 1/2] regulator: Add support for software node connections
Date:   Thu,  8 Jul 2021 23:42:25 +0100
Message-Id: <20210708224226.457224-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708224226.457224-1-djrscally@gmail.com>
References: <20210708224226.457224-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some x86 platforms, firmware provided by the OEM does not adequately
describe the constraints of regulator resources nor their connections to
consuming devices via ACPI. To compensate, extend the regulator framework
to allow discovery of constraints and supply-consumer relationships via
software node references and properties. This will allow us to define
those platform specific connections so that the resources can be used in
the usual way.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---

swnode_get_regulator_constraints() here is not as extensive as the equivalent
function in of_regulator...I could include all that now, but it didn't seem
worth it so we don't know what any of those values should be.

 drivers/regulator/Kconfig                  |   6 ++
 drivers/regulator/Makefile                 |   1 +
 drivers/regulator/core.c                   |  23 +++++
 drivers/regulator/swnode_regulator.c       | 111 +++++++++++++++++++++
 include/linux/regulator/swnode_regulator.h |  33 ++++++
 5 files changed, 174 insertions(+)
 create mode 100644 drivers/regulator/swnode_regulator.c
 create mode 100644 include/linux/regulator/swnode_regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 9d84d9245490..7e0351f8fe38 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1171,6 +1171,12 @@ config REGULATOR_SY8827N
 	help
 	  This driver supports SY8827N single output regulator.
 
+config REGULATOR_SWNODE
+	bool "Software Node Regulator Support"
+	help
+	  This option configures support for providing regulator constraints and
+	  mappings to consumers through the use of software nodes.
+
 config REGULATOR_TPS51632
 	tristate "TI TPS51632 Power Regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 580b015296ea..25cb7bbad652 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_OF) += of_regulator.o
 obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
 obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
 obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
+obj-$(CONFIG_REGULATOR_SWNODE) += swnode_regulator.o
 
 obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
 obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f192bf19492e..6e10f511db80 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -20,11 +20,13 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
+#include <linux/property.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/coupler.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/swnode_regulator.h>
 #include <linux/module.h>
 
 #define CREATE_TRACE_POINTS
@@ -1763,6 +1765,7 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 						  const char *supply)
 {
 	struct regulator_dev *r = NULL;
+	struct fwnode_handle *swnode;
 	struct device_node *node;
 	struct regulator_map *map;
 	const char *devname = NULL;
@@ -1785,6 +1788,22 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 		}
 	}
 
+	/* next, try software nodes */
+	if (dev && dev->fwnode && is_software_node(dev->fwnode->secondary)) {
+		swnode = swnode_get_regulator_node(dev, supply);
+		if (!IS_ERR(swnode)) {
+			r = swnode_find_regulator_by_node(swnode);
+			if (r)
+				return r;
+
+			/*
+			 * We have a node, but there is no device.
+			 * assume it has not registered yet.
+			 */
+			return ERR_PTR(-EPROBE_DEFER);
+		}
+	}
+
 	/* if not found, try doing it non-dt way */
 	if (dev)
 		devname = dev_name(dev);
@@ -5242,6 +5261,10 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
 					       &rdev->dev.of_node);
 
+	if (!init_data)
+		init_data = regulator_swnode_get_init_data(dev, regulator_desc,
+							   config, &rdev->dev.fwnode);
+
 	/*
 	 * Sometimes not all resources are probed already so we need to take
 	 * that into account. This happens most the time if the ena_gpiod comes
diff --git a/drivers/regulator/swnode_regulator.c b/drivers/regulator/swnode_regulator.c
new file mode 100644
index 000000000000..75718de74366
--- /dev/null
+++ b/drivers/regulator/swnode_regulator.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dan Scally <djrscally@gmail.com> */
+
+#include <linux/property.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+#include "internal.h"
+
+static struct fwnode_handle *
+regulator_swnode_get_init_node(struct fwnode_handle *fwnode,
+			       const struct regulator_desc *desc)
+{
+	const struct software_node *parent, *child;
+
+	parent = to_software_node(fwnode->secondary);
+
+	if (desc->regulators_node)
+		child = software_node_find_by_name(parent,
+						   desc->regulators_node);
+	else
+		child = software_node_find_by_name(parent, desc->name);
+
+	return software_node_fwnode(child);
+}
+
+static int swnode_get_regulator_constraints(struct fwnode_handle *swnode,
+					    struct regulator_init_data *init_data)
+{
+	struct regulation_constraints *constraints = &init_data->constraints;
+	u32 pval;
+	int ret;
+
+	ret = fwnode_property_read_string(swnode, "regulator-name", &constraints->name);
+	if (ret)
+		return ret;
+
+	if (!fwnode_property_read_u32(swnode, "regulator-min-microvolt", &pval))
+		constraints->min_uV = pval;
+
+	if (!fwnode_property_read_u32(swnode, "regulator-max-microvolt", &pval))
+		constraints->max_uV = pval;
+
+	/* Voltage change possible? */
+	if (constraints->min_uV != constraints->max_uV)
+		constraints->valid_ops_mask |= REGULATOR_CHANGE_VOLTAGE;
+
+	/* Do we have a voltage range, if so try to apply it? */
+	if (constraints->min_uV && constraints->max_uV)
+		constraints->apply_uV = true;
+
+	constraints->boot_on = fwnode_property_read_bool(swnode, "regulator-boot-on");
+	constraints->always_on = fwnode_property_read_bool(swnode, "regulator-always-on");
+	if (!constraints->always_on) /* status change should be possible. */
+		constraints->valid_ops_mask |= REGULATOR_CHANGE_STATUS;
+
+	return 0;
+}
+
+struct regulator_init_data *
+regulator_swnode_get_init_data(struct device *dev,
+			       const struct regulator_desc *desc,
+			       struct regulator_config *config,
+			       struct fwnode_handle **regnode)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct regulator_init_data *init_data;
+	struct fwnode_handle *regulator;
+	int ret;
+
+	if (!fwnode || !is_software_node(fwnode->secondary))
+		return NULL;
+
+	regulator = regulator_swnode_get_init_node(fwnode, desc);
+	if (!regulator)
+		return NULL;
+
+	init_data = devm_kzalloc(dev, sizeof(*init_data), GFP_KERNEL);
+	if (!init_data)
+		return ERR_PTR(-ENOMEM);
+
+	ret = swnode_get_regulator_constraints(regulator, init_data);
+	if (ret)
+		return ERR_PTR(ret);
+
+	*regnode = regulator;
+
+	return init_data;
+}
+
+struct regulator_dev *
+swnode_find_regulator_by_node(struct fwnode_handle *swnode)
+{
+	struct device *dev;
+
+	dev = class_find_device_by_fwnode(&regulator_class, swnode);
+
+	return dev ? dev_to_rdev(dev) : NULL;
+}
+
+struct fwnode_handle *swnode_get_regulator_node(struct device *dev, const char *supply)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	char *prop_name;
+
+	prop_name = devm_kasprintf(dev, GFP_KERNEL, "%s-supply", supply);
+	if (!prop_name)
+		return ERR_PTR(-ENOMEM);
+
+	return fwnode_find_reference(fwnode->secondary, prop_name, 0);
+}
diff --git a/include/linux/regulator/swnode_regulator.h b/include/linux/regulator/swnode_regulator.h
new file mode 100644
index 000000000000..97527f7dbe80
--- /dev/null
+++ b/include/linux/regulator/swnode_regulator.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Author: Dan Scally <djrscally@gmail.com> */
+#ifndef __LINUX_SWNODE_REG_H
+#define __LINUX_SWNODE_REG_H
+
+#if defined(CONFIG_REGULATOR_SWNODE)
+struct regulator_init_data *regulator_swnode_get_init_data(struct device *dev,
+							   const struct regulator_desc *desc,
+							   struct regulator_config *config,
+							   struct fwnode_handle **regnode);
+struct regulator_dev *swnode_find_regulator_by_node(struct fwnode_handle *swnode);
+struct fwnode_handle *swnode_get_regulator_node(struct device *dev, const char *supply);
+#else
+struct regulator_init_data *regulator_swnode_get_init_data(struct device *dev,
+							   const struct regulator_desc *desc,
+							   struct regulator_config *config)
+{
+	return NULL;
+}
+
+struct regulator_dev *swnode_find_regulator_by_node(struct fwnode_handle *swnode)
+{
+	return NULL;
+}
+
+struct fwnode_handle *swnode_get_regulator_node(struct device *dev, const char *supply)
+{
+	return NULL;
+}
+
+#endif
+
+#endif
-- 
2.25.1

