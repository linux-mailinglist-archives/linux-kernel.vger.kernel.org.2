Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36333439B67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhJYQYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:24:00 -0400
Received: from smtp2.axis.com ([195.60.68.18]:4631 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232362AbhJYQX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1635178897;
  x=1666714897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aX2fK5PJ5chQlm9aTDAWMmbeUkrMH8hpUlQBdO8wrNA=;
  b=MoF6cIfJiGJgmou3JcVdQKWPsua0W8eN7ljcQHM64+UwByoEkxIT63Rk
   z6FxW9oGykxniOMVqhQvxUq4zSdYYXON7ZlB5wsht5Oo0PTlrGenNNA0c
   UNugGBd/UcNJoDW7m+H3Owz0iFQf5qE1wOap34IkDdRYvYswQvcvDgSqC
   u13IazsBl6VJcTNeyTI+1Kzrm87Juw1uZ6Hy3nUalsowTPCM8TqM0vUMx
   uJ2s3R/qt0sKpEnrmr77Kuq7ZzgUmWg3sLRThx0YIg8AwhfYmg8m54mYb
   K/7/qz7V3VS1TdgOVdXNj4iiLRstKwrg7q6mr70WP+TR6Hkty+tCgk+Iq
   Q==;
From:   =?UTF-8?q?Ludvig=20P=C3=A4rsson?= <ludvig.parsson@axis.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     <kernel@axis.com>,
        =?UTF-8?q?Ludvig=20P=C3=A4rsson?= <ludvig.parsson@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvmem: Add mockup nvmem driver
Date:   Mon, 25 Oct 2021 18:21:22 +0200
Message-ID: <20211025162123.5086-1-ludvig.parsson@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver provides an easy way to test other drivers that use nvmem.

E.g. Testing that an nvmem-driver that reads from OTP memory works as
intended for all possible values without having to actually write all
the values to OTP. Swapping the nvmem-driver reading the OTP memory for
this dummy driver makes it easy to manipulate the values to test.

Signed-off-by: Ludvig Pärsson <ludvig.parsson@axis.com>
---
 drivers/nvmem/Kconfig  |  5 +++
 drivers/nvmem/Makefile |  2 ++
 drivers/nvmem/mockup.c | 80 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 drivers/nvmem/mockup.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index da414617a54d..b0caad053823 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -300,4 +300,9 @@ config NVMEM_BRCM_NVRAM
 	  This driver provides support for Broadcom's NVRAM that can be accessed
 	  using I/O mapping.
 
+config NVMEM_MOCKUP
+	tristate "Mockup nvmem support"
+	help
+	  This driver can be used to test other drivers that use nvmem.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index dcbbde35b6a8..1b8353f54ca2 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -61,3 +61,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
 nvmem-rmem-y			:= rmem.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
 nvmem_brcm_nvram-y		:= brcm_nvram.o
+obj-$(CONFIG_NVMEM_MOCKUP)	+= nvmem-mockup.o
+nvmem-mockup-y			:= mockup.o
diff --git a/drivers/nvmem/mockup.c b/drivers/nvmem/mockup.c
new file mode 100644
index 000000000000..194113197c43
--- /dev/null
+++ b/drivers/nvmem/mockup.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Axis Communications AB
+ */
+
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+
+#define SIZE_OF_MEM (64)
+
+struct nvmem_mockup {
+	struct device *dev;
+	u8 mem[SIZE_OF_MEM];
+};
+
+static int nvmem_mockup_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	struct nvmem_mockup *priv = context;
+
+	if (bytes + offset > SIZE_OF_MEM || bytes + offset < offset)
+		return -EINVAL;
+
+	memcpy(val, &priv->mem[offset], bytes);
+
+	return 0;
+}
+
+static int nvmem_mockup_write(void *context, unsigned int offset,
+			      void *val, size_t bytes)
+{
+	struct nvmem_mockup *priv = context;
+
+	if (bytes + offset > SIZE_OF_MEM || bytes + offset < offset)
+		return -EINVAL;
+
+	memcpy(&priv->mem[offset], val, bytes);
+
+	return 0;
+}
+
+static int nvmem_mockup_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = { };
+	struct device *dev = &pdev->dev;
+	struct nvmem_mockup *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
+
+	config.dev = dev;
+	config.priv = priv;
+	config.name = "nvmem-mockup";
+	config.size = SIZE_OF_MEM;
+	config.reg_read = nvmem_mockup_read;
+	config.reg_write = nvmem_mockup_write;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static const struct of_device_id nvmem_mockup_match[] = {
+	{ .compatible = "nvmem-mockup", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, nvmem_mockup_match);
+
+static struct platform_driver nvmem_mockup_driver = {
+	.probe = nvmem_mockup_probe,
+	.driver = {
+		.name = "nvmem-mockup",
+		.of_match_table = nvmem_mockup_match,
+	},
+};
+module_platform_driver(nvmem_mockup_driver);
+
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

