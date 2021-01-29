Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F57308B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhA2RSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhA2RP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:15:29 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A94C061786
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 7so9624142wrz.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VU+JnvB5eDsZQkS0mp8LEdmPulIGYVqLfjclCfI2Ib0=;
        b=rxk97WnGAJpMtobtHoF5egZLddYUQOBLXHDRFueaw/C3LTTJLjVrYWKKBJZhf8+bdD
         S8RqGn8KQVpqS1flNQB6xeAyD1doJ5pZNZytk6RnVkPNg05kXWGg4OSVbW65DGITslmQ
         jHHPW+N0AyRn3SYuLM3beKGOVtTIjx4Dc85UvoundS9jNE7EnEACY1QyhFo63ortul/C
         InqxZEOtRyLk3D2uO50IDrQx6p/HDctyipiLU/CnjvhMyZX71c2467nam239qBy8l69Y
         e2Th2eN+iq9FLWNgFwJxpLmq3DScR3nZrRMmOFPPGob9c5ThI8yaVB7eEOCzDpg3qfcS
         P82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VU+JnvB5eDsZQkS0mp8LEdmPulIGYVqLfjclCfI2Ib0=;
        b=CMiYK+JrKfSAw0e5CkVE/gejxb3lrVcQVzVHTvvSRLv3mm61FNKUO95ckOI1q8hBYa
         c9WtFeQk8H8omXYXjjG8tBHrIloMcUCY4laINRgSe7/KxcoAd0SDGvmsHt1+eqidTnSF
         W2m7OOaOmn2PYzU5O0MuHp2mJo4GNns1W2FPQY5u049We+/qlsV3XLqBiS4veXyeTF7V
         vIzZ5wLoRqL3WBFtPolw4rnmKa7CH1Qt3Kp4SCi1MOPo5YMP3v0AEv1g5wvz8c11+gvH
         i+zboyQSEZYoI4nlzqhgzy7+KjpTNrofQ1AJLMIsYIEbMvnpAVbhLszhTm7bgAl8vPPw
         ucfw==
X-Gm-Message-State: AOAM532tYGtm1pO9BG0mcxN93VzRJlR5zgmOCTxlS6U8rD8M4ITh2ws9
        j2/LvOQvoWB1+yxRK+Bbh/QC4Q==
X-Google-Smtp-Source: ABdhPJwht49iBaFdnARzx+Z7+2h24xsSDQiHAaL+ua29b8gEwNGa8ROPUEyLtgSFVovAjDD9pmRMjA==
X-Received: by 2002:a5d:6a45:: with SMTP id t5mr5424437wrw.252.1611940487964;
        Fri, 29 Jan 2021 09:14:47 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n15sm12952487wrx.2.2021.01.29.09.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:14:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/5] nvmem: Add driver to expose reserved memory as nvmem
Date:   Fri, 29 Jan 2021 17:14:29 +0000
Message-Id: <20210129171430.11328-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
References: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Firmware/co-processors might use reserved memory areas in order to pass
data stemming from an nvmem device otherwise non accessible to Linux.
For example an EEPROM memory only physically accessible to firmware, or
data only accessible early at boot time.

In order to expose this data to other drivers and user-space, the driver
models the reserved memory area as an nvmem device.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Tim Gover <tim.gover@raspberrypi.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig  |  8 ++++
 drivers/nvmem/Makefile |  2 +
 drivers/nvmem/rmem.c   | 97 ++++++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c  |  1 +
 4 files changed, 108 insertions(+)
 create mode 100644 drivers/nvmem/rmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 954d3b4a52ab..fecc19b884bf 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -270,4 +270,12 @@ config SPRD_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-sprd-efuse.
 
+config NVMEM_RMEM
+	tristate "Reserved Memory Based Driver Support"
+	help
+	  This drivers maps reserved memory into an nvmem device. It might be
+	  useful to expose information left by firmware in memory.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-rmem.
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index a7c377218341..5376b8e0dae5 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -55,3 +55,5 @@ obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
 obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
 nvmem_sprd_efuse-y		:= sprd-efuse.o
+obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
+nvmem-rmem-y			:= rmem.o
diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
new file mode 100644
index 000000000000..b11c3c974b3d
--- /dev/null
+++ b/drivers/nvmem/rmem.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+
+struct rmem {
+	struct device *dev;
+	struct nvmem_device *nvmem;
+	struct reserved_mem *mem;
+
+	phys_addr_t size;
+};
+
+static int rmem_read(void *context, unsigned int offset,
+		     void *val, size_t bytes)
+{
+	struct rmem *priv = context;
+	size_t available = priv->mem->size;
+	loff_t off = offset;
+	void *addr;
+	int count;
+
+	/*
+	 * Only map the reserved memory at this point to avoid potential rogue
+	 * kernel threads inadvertently modifying it. Based on the current
+	 * uses-cases for this driver, the performance hit isn't a concern.
+	 * Nor is likely to be, given the nature of the subsystem. Most nvmem
+	 * devices operate over slow buses to begin with.
+	 *
+	 * An alternative would be setting the memory as RO, set_memory_ro(),
+	 * but as of Dec 2020 this isn't possible on arm64.
+	 */
+	addr = memremap(priv->mem->base, available, MEMREMAP_WB);
+	if (IS_ERR(addr)) {
+		dev_err(priv->dev, "Failed to remap memory region\n");
+		return PTR_ERR(addr);
+	}
+
+	count = memory_read_from_buffer(val, bytes, &off, addr, available);
+
+	memunmap(addr);
+
+	return count;
+}
+
+static int rmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = { };
+	struct device *dev = &pdev->dev;
+	struct reserved_mem *mem;
+	struct rmem *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
+
+	mem = of_reserved_mem_lookup(dev->of_node);
+	if (!mem) {
+		dev_err(dev, "Failed to lookup reserved memory\n");
+		return -EINVAL;
+	}
+	priv->mem = mem;
+
+	config.dev = dev;
+	config.priv = priv;
+	config.name = "rmem";
+	config.size = mem->size;
+	config.reg_read = rmem_read;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static const struct of_device_id rmem_match[] = {
+	{ .compatible = "nvmem-rmem", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rmem_match);
+
+static struct platform_driver rmem_driver = {
+	.probe = rmem_probe,
+	.driver = {
+		.name = "rmem",
+		.of_match_table = rmem_match,
+	},
+};
+module_platform_driver(rmem_driver);
+
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
+MODULE_DESCRIPTION("Reserved Memory Based nvmem Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 79bd5f5a1bf1..6699cdbe58b6 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -511,6 +511,7 @@ static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "qcom,rmtfs-mem" },
 	{ .compatible = "qcom,cmd-db" },
 	{ .compatible = "ramoops" },
+	{ .compatible = "nvmem-rmem" },
 	{}
 };
 
-- 
2.21.0

