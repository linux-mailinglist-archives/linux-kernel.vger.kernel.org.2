Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF01C3424A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhCSS2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhCSS2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:28:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EB2C06174A;
        Fri, 19 Mar 2021 11:28:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so11234787ejc.10;
        Fri, 19 Mar 2021 11:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZBBDJ1FYBuLzTfmz7EUovF4qIbRheJGENzZ7NQocvg=;
        b=ukK++JiWXUeKWcS2kFG9nVTaLPu7x6pZ3UMq0svLLaS+3FTyrzKqCnndHIFRZxuadi
         VNpUN4CkKHOAm+bBgDjr455s8OcA3LQuDCoYcoWo4m959nfn2za9EibFgNf5bCWUFgNs
         mP6X3Ft3KI8UdhrKi6wZFJW/WIpqezbx6PUyZVqLIpOlawoos9y/p3b40KMvZ0vV5kJd
         7raxRDa7mndvET+r18p+wv2GKO+g0ko6qZfR8gTrtGa6CJEhTm5InASv4i4xHM/87ZkV
         W779FZo7pHH/lDGZBe3ONgxvyKD9DbcxG26BJdoWrxqqdMj+UVoQMI9MNhMzXZ/8IjaM
         uZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZBBDJ1FYBuLzTfmz7EUovF4qIbRheJGENzZ7NQocvg=;
        b=EqRdtvJFp07gorK77NQv0X69xe54ZfyD5NkavLsORaYunYbb2BTlebt9nNWz3VPgPp
         jIesMRyvrnjUw5LCJyMHnAC6LfOlBkiQGEzI0Lofkf8b5aCL3EpY+sHGvExtVo2bK1E2
         UTi5kT4dggzYn+prh1sxRbh1nGAQEnPrYCBhhproc2Y35jDK/qvPPURL43Zg9FhegPXJ
         14IRUmLfA/EdfYvvgopQ1jTfqjiizQ4g5vG4j2K+aerQAwPzVURpA4NmLkbF8yZnJeIp
         oBPs9tKfAdUBJMNAYalFwcbt4S5wtSZzIBJ433jzlV/Cly7jfvDx2qZiTXfWCtE+GGsu
         fMTA==
X-Gm-Message-State: AOAM533ZILDjJ7khus06xdlf/CUm6Y2eHNGBzB32EDLDYqwV28NHGtlz
        H5GCbDcGR+3iTDwlUoKy1vaOxlqzhb8=
X-Google-Smtp-Source: ABdhPJxZ+DjF+mjHOyt66qKD6psO9+8MEQ9Ru6wJZz8I1fGYNb2USAhzAjmAHky8vbU7LvVpzoVluQ==
X-Received: by 2002:a17:907:76ed:: with SMTP id kg13mr5581385ejc.99.1616178486624;
        Fri, 19 Mar 2021 11:28:06 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id gb22sm3951070ejc.78.2021.03.19.11.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:28:06 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] soc: actions: Add Actions Semi Owl socinfo driver
Date:   Fri, 19 Mar 2021 20:28:00 +0200
Message-Id: <76e07f19e60c037a6ff24a34f5704809cdbfd368.1616178258.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1616178258.git.cristian.ciocaltea@gmail.com>
References: <cover.1616178258.git.cristian.ciocaltea@gmail.com>
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
 drivers/soc/actions/Kconfig       |   8 ++
 drivers/soc/actions/Makefile      |   1 +
 drivers/soc/actions/owl-socinfo.c | 133 ++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 drivers/soc/actions/owl-socinfo.c

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
index 000000000000..2786c4fd261c
--- /dev/null
+++ b/drivers/soc/actions/owl-socinfo.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Actions Semi Owl SoC information driver
+ *
+ * Copyright (c) 2021 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#include <linux/highmem.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/random.h>
+#include <linux/sys_soc.h>
+
+#include <asm/system_info.h>
+
+struct owl_soc_info {
+	char *name;
+	int (*get_system_serial)(struct device *dev);
+};
+
+static int __init owl_read_sn_from_mem(struct device *dev)
+{
+	int paddrs[2] = {0};
+	char *vaddr;
+	int ret;
+
+	ret = device_property_read_u32_array(dev,
+					     "actions,serial-number-addrs",
+					     paddrs, 2);
+	if (ret) {
+		dev_err(dev, "failed to read SoC S/N addresses: %d\n", ret);
+		return ret;
+	}
+
+	if (PHYS_PFN(paddrs[0]) != PHYS_PFN(paddrs[1])) {
+		dev_err(dev, "invalid SoC S/N addresses\n");
+		return -EINVAL;
+	}
+
+	vaddr = kmap_local_pfn(PHYS_PFN(paddrs[0]));
+
+	memcpy(&system_serial_low, vaddr + (paddrs[0] & (PAGE_SIZE - 1)),
+	       sizeof(system_serial_low));
+	memcpy(&system_serial_high, vaddr + (paddrs[1] & (PAGE_SIZE - 1)),
+	       sizeof(system_serial_high));
+
+	kunmap_local(vaddr);
+
+	return 0;
+}
+
+static int owl_socinfo_probe(struct platform_device *pdev)
+{
+	const struct owl_soc_info *soc_info;
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
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
+	if (soc_info->get_system_serial) {
+		ret = soc_info->get_system_serial(&pdev->dev);
+		if (!ret) {
+			soc_dev_attr->serial_number = devm_kasprintf(&pdev->dev,
+						GFP_KERNEL, "%08x%08x",
+						system_serial_high,
+						system_serial_low);
+			/* Feed the SoC unique data into entropy pool. */
+			add_device_randomness(soc_dev_attr->serial_number, 16);
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
+	.get_system_serial = owl_read_sn_from_mem,
+};
+
+static const struct owl_soc_info s700_soc_info = {
+	.name = "S700",
+	/* FIXME: provide get_system_serial */
+};
+
+static const struct owl_soc_info s900_soc_info = {
+	.name = "S900",
+	/* FIXME: provide get_system_serial */
+};
+
+static const struct of_device_id owl_soc_of_match[] = {
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
+		.of_match_table = owl_soc_of_match,
+	},
+};
+
+static int __init owl_socinfo_init(void)
+{
+	return platform_driver_register(&owl_socinfo_platform_driver);
+}
+subsys_initcall(owl_socinfo_init);
-- 
2.31.0

