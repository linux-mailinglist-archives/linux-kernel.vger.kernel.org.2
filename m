Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84DC3E7C53
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243282AbhHJPbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbhHJPbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:31:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D1BC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:30:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so2816656wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2RgfCS/T1AfMd/utQPxwEaaexda8fppVMKniFtwxI9Y=;
        b=hcHVP6MJi7KLgd9e0QyM24+UgkBhJsk8wviW1q5P1pzPMZWiVK5dm0uLwA0HH8Lq9B
         75aMfhnxsWM4Huca6tsN/+1uBOzdDV5dkDyKooqL9rGbKyjLp0YvATdDoeYi7Aylv7Di
         aoOQ7INdSTsYU3t5R8ZUcnNH0nv+E1KmNylFM8751jJ18gL8rUQX1lvNHgnGFRnzseKe
         9CJVIvpmhzePBGd5L6NP3gfp/desEID1cTfuA1w5rgp0ZXK4SG3G+fYHdrLCHbUL1k0i
         Gaj1J2ZJTNrz5ouCfdQwCpduFWovqvHr93JCyI4D5wTN+uB4zQ/MByvctJJnDwE31Uov
         qXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RgfCS/T1AfMd/utQPxwEaaexda8fppVMKniFtwxI9Y=;
        b=WpTJdl4qKlDL0IHDJ9iHCSx2VjjSbpgZRgpTjjdYLXcyMTt+CmKFfAlannGzad8HHZ
         cqn6F+l35uOqsadI8t1dOzxPYmhtzWq0CXERUR0qzc2dDfhEy+SLPN+rExoy34LM9Sh7
         6eRutn/8J9dM0bPfK157thxSuYxe2P4Y6oct8kRLpgIcNGFM8MOfqxPLmcAjzc3kRwjk
         gVPi8XYnavfn5whU5Uu9p4KzfeKy2dYMXss8TBGVnjgXWhSwV8N2guhybeuueBQn6fET
         NSKaTz/uRzKtiAzFSaSxLAu4FBjdPaFIJ2dNsC8dWYufG+8l4L2ZUe3/LtUHRZr95wiz
         EH4g==
X-Gm-Message-State: AOAM5325qsTlfJoOyC5jTATQJkt/OIB7M2yIZVFCzaNX0QvfI4c5kMkg
        40J9xln5JDFXT0UpOspQieGobA==
X-Google-Smtp-Source: ABdhPJwhmXdvN5QSzuUq1EyVhqCmohu7JL7v20+Ka5KVsXa51vhSiQ1Iv66hdgbA1zI9Va9doKODGg==
X-Received: by 2002:a1c:791a:: with SMTP id l26mr5368550wme.179.1628609457168;
        Tue, 10 Aug 2021 08:30:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id j1sm3002354wmo.4.2021.08.10.08.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:30:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] nvmem: nintendo-otp: Add new driver for the Wii and Wii U OTP
Date:   Tue, 10 Aug 2021 16:30:36 +0100
Message-Id: <20210810153036.1494-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210810153036.1494-1-srinivas.kandagatla@linaro.org>
References: <20210810153036.1494-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

This OTP is read-only and contains various keys used by the console to
decrypt, encrypt or verify various pieces of storage.

Its size depends on the console, it is 128 bytes on the Wii and
1024 bytes on the Wii U (split into eight 128 bytes banks).

It can be used directly by writing into one register and reading from
the other one, without any additional synchronisation.

This driver was written based on reversed documentation, see:
https://wiiubrew.org/wiki/Hardware/OTP

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Tested-by: Jonathan Neuschäfer <j.ne@posteo.net>  # on Wii
Tested-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>  # on Wii U
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig        |  11 ++++
 drivers/nvmem/Makefile       |   2 +
 drivers/nvmem/nintendo-otp.c | 124 +++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 drivers/nvmem/nintendo-otp.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index dd2019006838..39854d43758b 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -107,6 +107,17 @@ config MTK_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called efuse-mtk.
 
+config NVMEM_NINTENDO_OTP
+	tristate "Nintendo Wii and Wii U OTP Support"
+	help
+	  This is a driver exposing the OTP of a Nintendo Wii or Wii U console.
+
+	  This memory contains common and per-console keys, signatures and
+	  related data required to access peripherals.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-nintendo-otp.
+
 config QCOM_QFPROM
 	tristate "QCOM QFPROM Support"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index bbea1410240a..dcbbde35b6a8 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -23,6 +23,8 @@ obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
 nvmem_lpc18xx_otp-y		:= lpc18xx_otp.o
 obj-$(CONFIG_NVMEM_MXS_OCOTP)	+= nvmem-mxs-ocotp.o
 nvmem-mxs-ocotp-y		:= mxs-ocotp.o
+obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
+nvmem-nintendo-otp-y		:= nintendo-otp.o
 obj-$(CONFIG_MTK_EFUSE)		+= nvmem_mtk-efuse.o
 nvmem_mtk-efuse-y		:= mtk-efuse.o
 obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
diff --git a/drivers/nvmem/nintendo-otp.c b/drivers/nvmem/nintendo-otp.c
new file mode 100644
index 000000000000..33961b17f9f1
--- /dev/null
+++ b/drivers/nvmem/nintendo-otp.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Nintendo Wii and Wii U OTP driver
+ *
+ * This is a driver exposing the OTP of a Nintendo Wii or Wii U console.
+ *
+ * This memory contains common and per-console keys, signatures and
+ * related data required to access peripherals.
+ *
+ * Based on reversed documentation from https://wiiubrew.org/wiki/Hardware/OTP
+ *
+ * Copyright (C) 2021 Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define HW_OTPCMD  0
+#define HW_OTPDATA 4
+#define OTP_READ   0x80000000
+#define BANK_SIZE  128
+#define WORD_SIZE  4
+
+struct nintendo_otp_priv {
+	void __iomem *regs;
+};
+
+struct nintendo_otp_devtype_data {
+	const char *name;
+	unsigned int num_banks;
+};
+
+static const struct nintendo_otp_devtype_data hollywood_otp_data = {
+	.name = "wii-otp",
+	.num_banks = 1,
+};
+
+static const struct nintendo_otp_devtype_data latte_otp_data = {
+	.name = "wiiu-otp",
+	.num_banks = 8,
+};
+
+static int nintendo_otp_reg_read(void *context,
+				 unsigned int reg, void *_val, size_t bytes)
+{
+	struct nintendo_otp_priv *priv = context;
+	u32 *val = _val;
+	int words = bytes / WORD_SIZE;
+	u32 bank, addr;
+
+	while (words--) {
+		bank = (reg / BANK_SIZE) << 8;
+		addr = (reg / WORD_SIZE) % (BANK_SIZE / WORD_SIZE);
+		iowrite32be(OTP_READ | bank | addr, priv->regs + HW_OTPCMD);
+		*val++ = ioread32be(priv->regs + HW_OTPDATA);
+		reg += WORD_SIZE;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id nintendo_otp_of_table[] = {
+	{ .compatible = "nintendo,hollywood-otp", .data = &hollywood_otp_data },
+	{ .compatible = "nintendo,latte-otp", .data = &latte_otp_data },
+	{/* sentinel */},
+};
+MODULE_DEVICE_TABLE(of, nintendo_otp_of_table);
+
+static int nintendo_otp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id =
+		of_match_device(nintendo_otp_of_table, dev);
+	struct resource *res;
+	struct nvmem_device *nvmem;
+	struct nintendo_otp_priv *priv;
+
+	struct nvmem_config config = {
+		.stride = WORD_SIZE,
+		.word_size = WORD_SIZE,
+		.reg_read = nintendo_otp_reg_read,
+		.read_only = true,
+		.root_only = true,
+	};
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->regs))
+		return PTR_ERR(priv->regs);
+
+	if (of_id->data) {
+		const struct nintendo_otp_devtype_data *data = of_id->data;
+		config.name = data->name;
+		config.size = data->num_banks * BANK_SIZE;
+	}
+
+	config.dev = dev;
+	config.priv = priv;
+
+	nvmem = devm_nvmem_register(dev, &config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static struct platform_driver nintendo_otp_driver = {
+	.probe = nintendo_otp_probe,
+	.driver = {
+		.name = "nintendo-otp",
+		.of_match_table = nintendo_otp_of_table,
+	},
+};
+module_platform_driver(nintendo_otp_driver);
+MODULE_AUTHOR("Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>");
+MODULE_DESCRIPTION("Nintendo Wii and Wii U OTP driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

