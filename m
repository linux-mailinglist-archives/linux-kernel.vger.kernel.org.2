Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C027F34E632
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhC3LOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhC3LNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:13:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B19C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jy13so24256030ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erptaSPprH0WaslKZ9n3jNaVa5inopev0AJhMUk6UQE=;
        b=u7Zyv2Zj/1FJV8UQb+1VBYWjYCL0MGuur6LUJdXIHcHPEL7deGCDdZxPe/GS1KXd4J
         MgK3Br0f0N/mPbNSB/jvGs70GON4hEO4mstPVSAEErwfSh4Yu4Ge0H2CCQ2korr/2dyo
         FD38/OqunlCSjS/rdFteUudcan7gRxZBPjhKkfTYg7hNQt5UctxozV1EY+OMqWif1nFX
         DLTxYAL0now9rChDLnooi7/C3JXTGJqV7IZ4grUWtYRCWaqWWJpHPnHZHQykfM05oIE6
         IQ9xlsURMLGNcqMQm3TofRIZ/DWLrr1KG9VDhk2g7oKEV4uvaAWHymNhqJhOj4fUBEK9
         OQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erptaSPprH0WaslKZ9n3jNaVa5inopev0AJhMUk6UQE=;
        b=UD7QaBDwISASAEtPyrTEgj9xNLX0feB17qPjMz4Q3LwiEDK63VcILNZ8dezMkFpOzB
         ldYj987+INO83asd1I3JVk8dytHZTCsRLfgw76FUGFuR1EXLjmWX3PeiAl5cJu8ythOG
         P+NnIBU3bOppFph1ZF/Ui4bfcPQACM5j97UzRSpLGOpEMnlkGuSm9LcAFM/eM9fAb7qX
         OfT6cIzVG9JsdcljOZN3JTsCT3rVxkSoItIqisbXGcOtZlGFpJKh3MHqhhpmQyNwaF5F
         DYBMgzxapHqyyjHBBdF+ExgcxxrLSTWzIqGPCJ5/k9xTRuSxO4TyR091c+vCdHr4S1xh
         1fAA==
X-Gm-Message-State: AOAM530/XUnbLyQdYKt2ySmSW8W8tZZAIlmWD46GrpVcPGYvceQyf/yO
        Yod723ZthkPzdhDdKGlxJaKdow==
X-Google-Smtp-Source: ABdhPJw0NSZabO8OKar9sFoBEcMCq9hU4SZp4k3CGokAlOIWFS72Vf2GpD9jJ3g1d3juHq7Sxkho2Q==
X-Received: by 2002:a17:906:3b99:: with SMTP id u25mr32943269ejf.277.1617102822482;
        Tue, 30 Mar 2021 04:13:42 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r19sm10961308edp.52.2021.03.30.04.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:13:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/10] nvmem: brcm_nvram: new driver exposing Broadcom's NVRAM
Date:   Tue, 30 Mar 2021 12:12:36 +0100
Message-Id: <20210330111241.19401-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
References: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This driver provides access to Broadcom's NVRAM.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig      |  9 +++++
 drivers/nvmem/Makefile     |  2 +
 drivers/nvmem/brcm_nvram.c | 78 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 drivers/nvmem/brcm_nvram.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 75d2594c16e1..642ddc699fd1 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -278,4 +278,13 @@ config NVMEM_RMEM
 
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-rmem.
+
+config NVMEM_BRCM_NVRAM
+	tristate "Broadcom's NVRAM support"
+	depends on ARCH_BCM_5301X || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver provides support for Broadcom's NVRAM that can be accessed
+	  using I/O mapping.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 5376b8e0dae5..bbea1410240a 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -57,3 +57,5 @@ obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
 nvmem_sprd_efuse-y		:= sprd-efuse.o
 obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
 nvmem-rmem-y			:= rmem.o
+obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
+nvmem_brcm_nvram-y		:= brcm_nvram.o
diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
new file mode 100644
index 000000000000..bd2ecaaf4585
--- /dev/null
+++ b/drivers/nvmem/brcm_nvram.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+
+struct brcm_nvram {
+	struct device *dev;
+	void __iomem *base;
+};
+
+static int brcm_nvram_read(void *context, unsigned int offset, void *val,
+			   size_t bytes)
+{
+	struct brcm_nvram *priv = context;
+	u8 *dst = val;
+
+	while (bytes--)
+		*dst++ = readb(priv->base + offset++);
+
+	return 0;
+}
+
+static int brcm_nvram_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = {
+		.name = "brcm-nvram",
+		.reg_read = brcm_nvram_read,
+	};
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct brcm_nvram *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	config.dev = dev;
+	config.priv = priv;
+	config.size = resource_size(res);
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static const struct of_device_id brcm_nvram_of_match_table[] = {
+	{ .compatible = "brcm,nvram", },
+	{},
+};
+
+static struct platform_driver brcm_nvram_driver = {
+	.probe = brcm_nvram_probe,
+	.driver = {
+		.name = "brcm_nvram",
+		.of_match_table = brcm_nvram_of_match_table,
+	},
+};
+
+static int __init brcm_nvram_init(void)
+{
+	return platform_driver_register(&brcm_nvram_driver);
+}
+
+subsys_initcall_sync(brcm_nvram_init);
+
+MODULE_AUTHOR("Rafał Miłecki");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, brcm_nvram_of_match_table);
-- 
2.21.0

