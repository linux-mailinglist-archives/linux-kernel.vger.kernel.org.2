Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3413AD0B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhFRQtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhFRQtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:49:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 09:47:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r9so11443421wrz.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HhWeotyIlUAd02HmYmqGEB1lGzziABZiEINB4LXzIIU=;
        b=iuBCWrGCKLVuyQE0GWOh1GeGL8P7gmW0ES0mYJ2myVJTkMmYgjJ1Uo4X/gwrYFreuy
         p/WZAd2YYN+UaRtKct03d4VdRaslxHtaNFcOqb7kf+CMOvjIkz8XGym8ckDGJdRczwOB
         HSIYPLLJySFtv3d+/eA1rwqqmaSTHfXE3Ed1ODZF+B+CnbK3UuHUiPWpaQ3NIJdDrEZP
         JyAeZxXnNKkeS380rjgmcXvjJeCTF2odH4huEGqQBaLha5cyjL5+7mEUGdYYhQVo6mjZ
         kUgrSItKjWG++CmM0mnrCRj5/HiOpbpYqFYzwNUxzEmpnXUV4etEu7S9xRAlFImUywKM
         RhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HhWeotyIlUAd02HmYmqGEB1lGzziABZiEINB4LXzIIU=;
        b=mo5CkCg2BhIRrG+AoDX9rj8YM7nmWAT/JFDoTKBmMkmFwC15LETX8a0Llx4l4kIOuR
         NcYLGYUNqG2Vye7rkTQ2go9hLezlBqfFnOqp2+mjl6QC3IEbPVWOTNPW7X9oL75Ay4+E
         6DedME+/QhYHR890yB197wKbQBVO4QpWi+HeVNFOhXbX6zZUTfNfm2og2TW+otG0vipK
         Qz32sIx2VDi6mz7zsneIIsGj5BeMxY06Io1K/m49hEcInRFKpArqxTu+NUN7+uPTSUTt
         aZW6AJCQup2VQf1pbiaveABoHSNRERpYzVxN6El2ODlBQHuGqPJ5LLITFjMHRv36ws8f
         9T2A==
X-Gm-Message-State: AOAM532veCDwf+7fp/4izlJVSFqmWFsl2wnlS3NxE5nlerTDTzaqHo9I
        GNOeaNFDL1kukD6rzi6Of2bKZg==
X-Google-Smtp-Source: ABdhPJwZm+k6AWRWTqRtcidaBkGB+ZxHdk9M5VKSOtyNNNsshaIxSmt0HKT0LiU0fHr3vO/QrghXVg==
X-Received: by 2002:adf:e110:: with SMTP id t16mr13720254wrz.359.1624034840248;
        Fri, 18 Jun 2021 09:47:20 -0700 (PDT)
Received: from ludmilla.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id k16sm9407992wrn.96.2021.06.18.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 09:47:20 -0700 (PDT)
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, philipp.deppenwiese@immu.ne,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Subject: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
Date:   Fri, 18 Jun 2021 18:47:18 +0200
Message-Id: <20210618164718.37866-1-hans-gert.dahmen@immu.ne>
X-Mailer: git-send-email 2.30.2
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
 drivers/firmware/Kconfig             |  9 ++++
 drivers/firmware/Makefile            |  1 +
 drivers/firmware/x86_64_flash_mmap.c | 65 ++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 drivers/firmware/x86_64_flash_mmap.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index db0ea2d2d75a..bd77ca2b4fa6 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -296,6 +296,15 @@ config TURRIS_MOX_RWTM
 	  other manufacturing data and also utilize the Entropy Bit Generator
 	  for hardware random number generation.
 
+config X86_64_FLASH_MMAP
+	tristate "Export platform flash memory-mapped BIOS region"
+	depends on X86_64
+	help
+	  Export the memory-mapped BIOS region of the platform SPI flash as
+	  a read-only sysfs binary attribute on X86_64 systems. The first 16MiB
+	  will be accessible via /sys/kernel/firmware/flash_mmap/bios_region
+	  for security and malware analysis for example.
+
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 5e013b6a3692..eb7483c5a2ac 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
 obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
+obj-$(CONFIG_X86_64_FLASH_MMAP)	+= x86_64_flash_mmap.o
 
 obj-y				+= arm_scmi/
 obj-y				+= broadcom/
diff --git a/drivers/firmware/x86_64_flash_mmap.c b/drivers/firmware/x86_64_flash_mmap.c
new file mode 100644
index 000000000000..f9d871a8b516
--- /dev/null
+++ b/drivers/firmware/x86_64_flash_mmap.c
@@ -0,0 +1,65 @@
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
+#include <linux/kobject.h>
+
+#define FLASH_REGION_START 0xFF000000ULL
+#define FLASH_REGION_SIZE 0x1000000ULL
+#define FLASH_REGION_MASK (FLASH_REGION_SIZE - 1)
+
+struct kobject *kobj_ref;
+
+static ssize_t bios_region_read(struct file *file, struct kobject *kobj,
+				struct bin_attribute *bin_attr, char *buffer,
+				loff_t offset, size_t count)
+{
+	resource_size_t pa = FLASH_REGION_START + (offset & FLASH_REGION_MASK);
+	void __iomem *va = ioremap(pa, PAGE_SIZE);
+
+	memcpy_fromio(buffer, va, PAGE_SIZE);
+	iounmap(va);
+
+	return min(count, PAGE_SIZE);
+}
+
+BIN_ATTR_RO(bios_region, FLASH_REGION_SIZE);
+
+static int __init flash_mmap_init(void)
+{
+	int ret = 0;
+
+	kobj_ref = kobject_create_and_add("flash_mmap", firmware_kobj);
+	ret = sysfs_create_bin_file(kobj_ref, &bin_attr_bios_region);
+	if (ret) {
+		pr_err("sysfs_create_bin_file failed\n");
+		goto error;
+	}
+
+	return ret;
+
+error:
+	kobject_put(kobj_ref);
+	return ret;
+}
+
+static void __exit flash_mmap_exit(void)
+{
+	sysfs_remove_bin_file(kernel_kobj, &bin_attr_bios_region);
+	kobject_put(kobj_ref);
+}
+
+module_init(flash_mmap_init);
+module_exit(flash_mmap_exit);
+MODULE_DESCRIPTION("Export SPI platform flash memory mapped region via sysfs");
+MODULE_AUTHOR("Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>");
+MODULE_LICENSE("GPL");
-- 
2.30.2

