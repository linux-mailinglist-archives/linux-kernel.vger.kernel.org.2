Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938E1449F46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 01:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbhKIAEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKIAEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:04:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B08C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 16:02:03 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n29so18103105wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 16:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q/iyHwjY5Ht1skD+fuNtC8ubTgmzrQgyQ0rHNBtQDmE=;
        b=IFCNitXCn1VZXTvuu85vDJh54yYvyexGbHLFDdkUR7vAV+TwcBl90uJ7EdNkOtaqpG
         kYxvPcy6zp0dFFxcV/6wAPZFNGXdqYBY1X9O9O/CAf8HlMWdCDiZQmUcL0101mTYm5Dz
         fQW7krrABe2TeTGFIZ2cA0tEMsiBJOKKL8aaPmJqBacg18OSCElG5NwclORxgliyBwFP
         po1NOwXNqrgy6rBkfcR8sQK8TC/RAb1I/1IE7oJ3sHl5qObl/Zixy6f3pNRt26Q0Cz4E
         wDNPWtW9TGIMyeS4NtWvgsaJilWcXHHWHBtY2cIt70AtvGnjiCvBKnUgzN1i+1o5mj9k
         Uf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q/iyHwjY5Ht1skD+fuNtC8ubTgmzrQgyQ0rHNBtQDmE=;
        b=s3aVkC84x5szBljZxEYieO0VtKMKrvgQITw5/FKS5f1gCVjsL80/QJ/dnufh+Jq3p6
         PvmjUow1uKfN3zeavMS7UZ4nCqInCIGjJ7r0bpC3IdsLOYqxFivDOFc+Z2f68Krl0Yby
         TWhpfKd1HwRh3Tg52qMLn0MAEZPXjVgUw3lP9JqjNmJY1CsxuwESxtR/UPBh0zrpnbKm
         T4OzhGD/Sds5efv77pYixt8Svgo4xls5sKdQzlO8+3F8cJxuKJkNHoVlraiHpz+1FIdx
         5Hao2Z5xT9xOh+Vo5XBriSFlICem5nyNfJNr9IkQa9zJvoiTTPzOAJYScwgj5tSCRPy3
         jyiw==
X-Gm-Message-State: AOAM532sfyWLn44d0XljtsG2ZpiiAPN3BCLs/fquwni7kqglh01XYBDV
        n8yjyTcAF86p7hl6sLWNvGHq0g==
X-Google-Smtp-Source: ABdhPJx/XxDRch+x/lhwii2Xk4evWefpBdJO53hVMd1DE8jJOLlZemZzoGPxFTyqZgKADryxBI9XJg==
X-Received: by 2002:a5d:6147:: with SMTP id y7mr3878130wrt.217.1636416122531;
        Mon, 08 Nov 2021 16:02:02 -0800 (PST)
Received: from ludmilla.9e.network (b2b-78-94-0-51.unitymedia.biz. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id a22sm704264wme.19.2021.11.08.16.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 16:02:02 -0800 (PST)
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        philipp.deppenwiese@immu.ne, mauro.lima@eclypsium.com,
        hughsient@gmail.com, platform-driver-x86@vger.kernel.org,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Subject: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
Date:   Tue,  9 Nov 2021 01:01:30 +0100
Message-Id: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the 16MiB long memory-mapped BIOS region of the platform SPI flash
on X86_64 system available via /sys/kernel/firmware/flash_mmap/bios_region
for pen-testing, security analysis and malware detection on kernels
which restrict module loading and/or access to /dev/mem.

It will be used by the open source Converged Security Suite.
https://github.com/9elements/converged-security-suite

Signed-off-by: Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
---
 drivers/firmware/Kconfig             |  9 +++
 drivers/firmware/Makefile            |  1 +
 drivers/firmware/x86_64_flash_mmap.c | 86 ++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 drivers/firmware/x86_64_flash_mmap.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 75cb91055c17..27c2d0b074e0 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -293,6 +293,15 @@ config TURRIS_MOX_RWTM
 	  other manufacturing data and also utilize the Entropy Bit Generator
 	  for hardware random number generation.
 
+config X86_64_FLASH_MMAP
+	tristate "Export platform flash memory-mapped BIOS region"
+	depends on X86_64
+	help
+	  Export the memory-mapped BIOS region of the platform SPI flash as
+	  a read-only sysfs binary attribute on X86_64 systems. The first 16MiB
+	  will be accessible via /sys/devices/platform/flash_mmap/bios_region
+	  for security and malware analysis for example.
+
 source "drivers/firmware/arm_ffa/Kconfig"
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/cirrus/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4e58cb474a68..60dc4ea08705 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
 obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
+obj-$(CONFIG_X86_64_FLASH_MMAP)	+= x86_64_flash_mmap.o
 
 obj-y				+= arm_ffa/
 obj-y				+= arm_scmi/
diff --git a/drivers/firmware/x86_64_flash_mmap.c b/drivers/firmware/x86_64_flash_mmap.c
new file mode 100644
index 000000000000..23d8655d17bb
--- /dev/null
+++ b/drivers/firmware/x86_64_flash_mmap.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Export the memory-mapped BIOS region of the platform SPI flash as
+ * a read-only sysfs binary attribute on X86_64 systems.
+ *
+ * Copyright © 2021 immune GmbH
+ */
+
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/sysfs.h>
+#include <linux/platform_device.h>
+
+#define FLASH_REGION_START 0xFF000000ULL
+#define FLASH_REGION_SIZE 0x1000000ULL
+#define FLASH_REGION_MASK (FLASH_REGION_SIZE - 1)
+
+struct platform_device *pdev;
+
+static ssize_t bios_region_read(struct file *file, struct kobject *kobj,
+				struct bin_attribute *bin_attr, char *buffer,
+				loff_t offset, size_t count)
+{
+	resource_size_t pa;
+	size_t copysize, remapsize;
+	void __iomem *va;
+
+	offset = offset & FLASH_REGION_MASK;
+	pa = (FLASH_REGION_START + offset) & PAGE_MASK;
+
+	if ((offset + count) > FLASH_REGION_SIZE)
+		copysize = FLASH_REGION_SIZE - offset;
+	else
+		copysize = min(count, PAGE_SIZE);
+
+	if (((offset & ~PAGE_MASK) + copysize) > PAGE_SIZE)
+		remapsize = 2 * PAGE_SIZE;
+	else
+		remapsize = PAGE_SIZE;
+
+	va = ioremap(pa, remapsize);
+	memcpy_fromio(buffer, va, copysize);
+	iounmap(va);
+
+	return copysize;
+}
+
+static BIN_ATTR_RO(bios_region, FLASH_REGION_SIZE);
+
+static struct bin_attribute *flash_mmap_attrs[] = { &bin_attr_bios_region,
+						    NULL };
+
+static const struct attribute_group flash_mmap_group = {
+	.bin_attrs = flash_mmap_attrs,
+};
+
+static int __init flash_mmap_init(void)
+{
+	int ret;
+
+	pdev = platform_device_register_simple("flash_mmap", -1, NULL, 0);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &flash_mmap_group);
+	if (ret) {
+		dev_err(&pdev->dev, "sysfs creation failed\n");
+		platform_device_unregister(pdev);
+	}
+
+	return ret;
+}
+
+static void __exit flash_mmap_exit(void)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &flash_mmap_group);
+	platform_device_unregister(pdev);
+}
+
+module_init(flash_mmap_init);
+module_exit(flash_mmap_exit);
+MODULE_DESCRIPTION("Export SPI platform flash memory mapped region via sysfs");
+MODULE_AUTHOR("Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>");
+MODULE_LICENSE("GPL");
-- 
2.32.0

