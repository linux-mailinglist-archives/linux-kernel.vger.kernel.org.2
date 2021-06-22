Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054873B0757
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhFVO0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFVO0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:26:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF06C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:23:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e22so20346947wrc.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HhWeotyIlUAd02HmYmqGEB1lGzziABZiEINB4LXzIIU=;
        b=lRR3Klaj94/K98mVEfg5gt7evbPzLkgkiLTFcZAkHRezsgW6Qc4nO8I2zFy3F+X+KU
         EqSmLPVH5kHphIpb1Nt8kxxmPHhMG0bwjncupp1WPUPPVYgeipYp1zE9txfUi5CK7+6p
         DBmxrtNdySiSCYUqAlCR+mX635gwK77m0JaLRql+c0wfsxsRCxJxvBZv73uzgtclJEoc
         cxip5B8+fajuWZwTjBUnhHtMcakSr2/wVYZiS6r7GgxvduWE9eHfcEwn3z3BVAmL2xLO
         LH1GltDKi83NZY7UuFYSnV9pRcaBElR+40Z/1bMz2MASShLKROBjjPodH7MQC4G6b+5d
         xUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HhWeotyIlUAd02HmYmqGEB1lGzziABZiEINB4LXzIIU=;
        b=LrO4ZwhdbeH6ECiq/x7Y42/ZJJfGEuBRvCj8tRjUosoR0SlAvNXS+lSIFEmlfH/6nE
         AO1Tyzy09w8C+k1ZoiRBu60DNORro2ZJj2HxzLp60rnwp7hXpHoDc/Ifbw8iKbBPUANI
         MgE7FRHRqTNQhf6mjL8SlXgW1y+M3T/jUh4CHIzLrGY05oa0Xxlr7DEKO5ht11jmEs8E
         D/X1jYNHZ25uWKSWYx2fEMN55Lrmyy14a3jjUFSlkV+p4SaoIBD4FkiBD6GYmboO2uL5
         3azH6rvUEsru0FVxCrlKqsyvqA7uKeDhzLsIs2ElwjllgmJ4Hc6Wnh8u6HSla4vdRRb/
         eEdQ==
X-Gm-Message-State: AOAM531CZlc07WnM1RNiJcS4XZAkG6Ta542kvztqVTvlKV8VoUaZlRlV
        6H2/HoXn4ARMaCzlS2TiZHdddMQIu2vYHgbN
X-Google-Smtp-Source: ABdhPJx/fIIDIOnWfQFg91CXuD3395cYIEwA1nDCbbhvchd7lRV8yA0gdt94e1P/8KWCiCYVO04a5g==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr5038889wrr.11.1624371821538;
        Tue, 22 Jun 2021 07:23:41 -0700 (PDT)
Received: from ludmilla.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id c12sm24114721wrr.90.2021.06.22.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:23:41 -0700 (PDT)
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, philipp.deppenwiese@immu.ne,
        gregkh@linuxfoundation.org,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Subject: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
Date:   Tue, 22 Jun 2021 16:23:34 +0200
Message-Id: <20210622142334.14883-1-hans-gert.dahmen@immu.ne>
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

