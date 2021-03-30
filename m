Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B3134E998
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhC3NtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhC3Ns3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:48:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A2EC061574;
        Tue, 30 Mar 2021 06:48:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u5so24946406ejn.8;
        Tue, 30 Mar 2021 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQNp9e99+CznjYBoYW2Ihp1ygelCyBUZZbzQRo6GGr8=;
        b=G1o9Rkz9FtzPcp+l4sSBsJQj/3Mwf7NzOceH9vbHufY1TauuRP/2My0JfItP0cty4m
         1HqmaRuL1OSxbuxr/6rvm0XQWufXmX+sQ6DVVI1Jm1Rk+rseS6/eJr1MFm4fdhPmCC6J
         fb15RunDfnaKJmziuu6t+hOQ+Pq4zqK2dmcuLTk++CzJm4dXi6dC0iovSU2QIcWbcabt
         VJu/NEz/mNylp6TsoopTIPD+ziqb2QO5Ukf4FYKS0WdEqHnkjTjCqKx/cArExs/bvG+w
         LF5E37VK1VLt/jyoEMQKvbUIOVR1ep2D1pIiV273FgDBIkdtm1GAaULuCwamL9f6kGMJ
         OrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQNp9e99+CznjYBoYW2Ihp1ygelCyBUZZbzQRo6GGr8=;
        b=iK8r83qnbmW/d4XTb8LCX1xNWQh81Sj2el7ABJ6vu684TMBWFpFpLofLWKI7Z8YeSs
         VJU7kNZ6hkOR/GkykDWuyry2kYZAjafMMV+g6Du8HvrnqbnWC/e6fE5z6hfVwJHMPWeu
         S4ynzylUeOB3ZhkRNuP22YyMRJOAkE/RG9z3q6rRRDYLfv70L4koais2yIOwp1XQYGTo
         KGUPS7DMMdk0oXEFlQZOozSf0ONIU5EAizzlF7LStKIGfoMeEqF+a/AdzOjAWDP5dBM+
         VdiH9fFwX3xbFOQa+40Fs6t2UuQ/VlpJOb4KNJYqlF2f8u3yfBBjwOA7POnoF4+zFOms
         N8rQ==
X-Gm-Message-State: AOAM531GWnkLBDmGP1KFOStxTgWEWze5gu6D2Urb1/NX8EY/hzAB2fZw
        hPA0z6gkD6Av4DCPzab0i4W4WZCMpBc=
X-Google-Smtp-Source: ABdhPJwmpTmSEhHKPFX+Gag8UZV17t9O4rdo2b3PZeI0aAglbRUocNpMnqK/oy1fxn97+JHlauWEyA==
X-Received: by 2002:a17:906:4410:: with SMTP id x16mr33463963ejo.446.1617112107934;
        Tue, 30 Mar 2021 06:48:27 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id l12sm11114681edb.39.2021.03.30.06.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:48:27 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] soc: actions: Add Actions Semi Owl socinfo driver
Date:   Tue, 30 Mar 2021 16:48:18 +0300
Message-Id: <75ec4eff3e6113f4e72daa1b428c355b28005297.1617110420.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver provides information about the Action Semi Owl family of
SoCs (S500, S700 and S900) to user space via sysfs: machine, family,
soc_id, serial_number.

Note the serial number is currently provided only for the S500 SoC
variant.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/soc/actions/Kconfig                   |   8 +
 drivers/soc/actions/Makefile                  |   1 +
 drivers/soc/actions/owl-socinfo.c             | 152 ++++++++++++++++++
 include/linux/soc/actions/owl-serial-number.h |  20 +++
 4 files changed, 181 insertions(+)
 create mode 100644 drivers/soc/actions/owl-socinfo.c
 create mode 100644 include/linux/soc/actions/owl-serial-number.h

diff --git a/drivers/soc/actions/Kconfig b/drivers/soc/actions/Kconfig
index 1aca2058a40c..15faade9282d 100644
--- a/drivers/soc/actions/Kconfig
+++ b/drivers/soc/actions/Kconfig
@@ -14,4 +14,12 @@ config OWL_PM_DOMAINS
 	  power-gating on Actions Semiconductor S500, S700 and S900 SoCs.
 	  If unsure, say 'n'.
 
+config OWL_SOCINFO
+	bool "Actions Semi Owl SoC info driver"
+	default ARCH_ACTIONS
+	select SOC_BUS
+	help
+	  Say 'y' here to support the Action Semiconductor Owl socinfo
+	  driver, providing information about the SoC to user space.
+
 endif
diff --git a/drivers/soc/actions/Makefile b/drivers/soc/actions/Makefile
index 4db9e7b050e5..4b2591d3089f 100644
--- a/drivers/soc/actions/Makefile
+++ b/drivers/soc/actions/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_OWL_PM_DOMAINS_HELPER) += owl-sps-helper.o
 obj-$(CONFIG_OWL_PM_DOMAINS) += owl-sps.o
+obj-$(CONFIG_OWL_SOCINFO) += owl-socinfo.o
diff --git a/drivers/soc/actions/owl-socinfo.c b/drivers/soc/actions/owl-socinfo.c
new file mode 100644
index 000000000000..f28eafac3792
--- /dev/null
+++ b/drivers/soc/actions/owl-socinfo.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Actions Semi Owl SoC information driver
+ *
+ * Copyright (c) 2021 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/random.h>
+#include <linux/soc/actions/owl-serial-number.h>
+#include <linux/sys_soc.h>
+
+struct owl_soc_serial_rmem {
+	u32 low;
+	u32 high;
+};
+
+static struct owl_soc_serial_rmem *owl_socinfo_serial;
+
+u32 owl_get_soc_serial_low(void)
+{
+	return owl_socinfo_serial ? owl_socinfo_serial->low : 0;
+}
+EXPORT_SYMBOL_GPL(owl_get_soc_serial_low);
+
+u32 owl_get_soc_serial_high(void)
+{
+	return owl_socinfo_serial ? owl_socinfo_serial->high : 0;
+}
+EXPORT_SYMBOL_GPL(owl_get_soc_serial_high);
+
+struct owl_soc_info {
+	char *name;
+	int (*read_soc_serial)(struct device *dev);
+};
+
+/*
+ * Access SoC's serial number stored by the bootloader in DDR memory.
+ */
+static int owl_socinfo_read_serial_rmem(struct device *dev)
+{
+	struct reserved_mem *rmem;
+	struct device_node *np;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, NULL, "actions,owl-soc-serial");
+	if (!np)
+		return -ENXIO;
+
+	rmem = of_reserved_mem_lookup(np);
+	if (!rmem) {
+		dev_err(dev, "failed to acquire reserved memory region\n");
+		ret = -EINVAL;
+		goto out_put;
+	}
+
+	owl_socinfo_serial = memremap(rmem->base, rmem->size, MEMREMAP_WB);
+	if (!owl_socinfo_serial)
+		ret = -ENOMEM;
+
+out_put:
+	of_node_put(np);
+	return ret;
+}
+
+static int owl_socinfo_probe(struct platform_device *pdev)
+{
+	const struct owl_soc_info *soc_info;
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	const char *sn;
+	int ret;
+
+	soc_info = of_device_get_match_data(&pdev->dev);
+	if (!soc_info)
+		return -ENODEV;
+
+	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
+				    GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);
+	if (ret)
+		return ret;
+
+	soc_dev_attr->family = "Actions Semi Owl";
+	soc_dev_attr->soc_id = soc_info->name;
+
+	if (soc_info->read_soc_serial) {
+		ret = soc_info->read_soc_serial(&pdev->dev);
+
+		if (!ret) {
+			sn = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%08x%08x",
+					    owl_get_soc_serial_high(),
+					    owl_get_soc_serial_low());
+			soc_dev_attr->serial_number = sn;
+			/* Feed the SoC unique data into entropy pool. */
+			add_device_randomness(sn, 16);
+		}
+	}
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(soc_dev),
+				     "failed to register soc device");
+
+	dev_info(soc_device_to_device(soc_dev),
+		 "SoC: %s %s\n",
+		 soc_dev_attr->family, soc_dev_attr->soc_id);
+
+	return 0;
+}
+
+static const struct owl_soc_info s500_soc_info = {
+	.name = "S500",
+	.read_soc_serial = owl_socinfo_read_serial_rmem,
+};
+
+static const struct owl_soc_info s700_soc_info = {
+	.name = "S700",
+	/* FIXME: provide read_soc_serial */
+};
+
+static const struct owl_soc_info s900_soc_info = {
+	.name = "S900",
+	/* FIXME: provide read_soc_serial */
+};
+
+static const struct of_device_id owl_socinfo_of_match[] = {
+	{ .compatible = "actions,s500-soc", .data = &s500_soc_info, },
+	{ .compatible = "actions,s700-soc", .data = &s700_soc_info, },
+	{ .compatible = "actions,s900-soc", .data = &s900_soc_info, },
+	{ }
+};
+
+static struct platform_driver owl_socinfo_platform_driver = {
+	.probe = owl_socinfo_probe,
+	.driver = {
+		.name = "owl-socinfo",
+		.of_match_table = owl_socinfo_of_match,
+	},
+};
+
+static int __init owl_socinfo_init(void)
+{
+	return platform_driver_register(&owl_socinfo_platform_driver);
+}
+subsys_initcall(owl_socinfo_init);
diff --git a/include/linux/soc/actions/owl-serial-number.h b/include/linux/soc/actions/owl-serial-number.h
new file mode 100644
index 000000000000..f8595417668f
--- /dev/null
+++ b/include/linux/soc/actions/owl-serial-number.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2021 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#ifndef __SOC_ACTIONS_OWL_SERIAL_NUMBER_H__
+#define __SOC_ACTIONS_OWL_SERIAL_NUMBER_H__
+
+#if IS_ENABLED(CONFIG_OWL_SOCINFO)
+u32 owl_get_soc_serial_low(void);
+u32 owl_get_soc_serial_high(void);
+#else
+static inline u32 owl_get_soc_serial_low(void)
+{ return 0; }
+
+static inline u32 owl_get_soc_serial_high(void)
+{ return 0; }
+#endif /* CONFIG_OWL_SOCINFO */
+
+#endif /* __SOC_ACTIONS_OWL_SERIAL_NUMBER_H__ */
-- 
2.31.1

