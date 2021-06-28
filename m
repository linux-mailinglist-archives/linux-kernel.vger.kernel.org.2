Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6ED13B5A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhF1INw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhF1INb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:13:31 -0400
X-Greylist: delayed 384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Jun 2021 01:10:55 PDT
Received: from forward104o.mail.yandex.net (forward104o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAC8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 01:10:55 -0700 (PDT)
Received: from myt6-8c14f8311175.qloud-c.yandex.net (myt6-8c14f8311175.qloud-c.yandex.net [IPv6:2a02:6b8:c12:4892:0:640:8c14:f831])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 95F4C9420C3;
        Mon, 28 Jun 2021 11:04:27 +0300 (MSK)
Received: from myt6-016ca1315a73.qloud-c.yandex.net (myt6-016ca1315a73.qloud-c.yandex.net [2a02:6b8:c12:4e0e:0:640:16c:a131])
        by myt6-8c14f8311175.qloud-c.yandex.net (mxback/Yandex) with ESMTP id m0B1l2fNCu-4RIuX2Eq;
        Mon, 28 Jun 2021 11:04:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orca.pet; s=mail; t=1624867467;
        bh=HCxrtuNqyWdFqXYaAD96KyRFXMVRrslugnWgNCECwiY=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=Q51lG8p0aVUGpZ8AEfXXYvlEEzVcgRQS6CUIfaLNKjgZDKDhhmo/heS+siP0ctHYg
         fyUPDu3bThdJVLfn3v61xvdiB3vmhgDkDeO8CyuTwMfPNo9QVNGjr60gElsH/K43ZW
         NY4lEEH149PRpE9INJcU50RqAqGtrIyfeBDxA/LE=
Authentication-Results: myt6-8c14f8311175.qloud-c.yandex.net; dkim=pass header.i=@orca.pet
Received: by myt6-016ca1315a73.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id p9KrQaLiUp-4Q3qYbWr;
        Mon, 28 Jun 2021 11:04:26 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Marcos Del Sol Vives <marcos@orca.pet>
To:     x86@kernel.org
Cc:     Marcos Del Sol Vives <marcos@orca.pet>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: add support DM&P devices
Date:   Mon, 28 Jun 2021 10:03:11 +0200
Message-Id: <20210628080310.1627112-1-marcos@orca.pet>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DM&P devices were not being properly identified, which resulted in
unneeded Spectre/Meltdown mitigations being applied.

The manufacturer states that these devices execute always in-order and
don't support either speculative execution or branch prediction, so
they are not vulnerable to this class of attack. [1]

This is something I've personally tested by a simple timing analysis
on my Vortex86MX CPU, and can confirm it is true.

Identification for some devices that lack the CPUID product name call
has also been added, so they appear properly on /proc/cpuinfo.

1: https://www.ssv-embedded.de/doks/infos/DMP_Ann_180108_Meltdown.pdf

Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/Kconfig.cpu             | 14 ++++++++++++
 arch/x86/include/asm/processor.h |  3 ++-
 arch/x86/kernel/cpu/Makefile     |  1 +
 arch/x86/kernel/cpu/common.c     |  2 ++
 arch/x86/kernel/cpu/dmp.c        | 39 ++++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/dmp.c

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 814fe0d349b0..8a110f4a1ec3 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -508,3 +508,17 @@ config CPU_SUP_ZHAOXIN
 	  CPU might render the kernel unbootable.
 
 	  If unsure, say N.
+
+config CPU_SUP_DMP_32
+	default y
+	bool "Support DM&P processors" if PROCESSOR_SELECT
+	depends on !64BIT
+	help
+	  This enables detection, tunings and quirks for DM&P processors
+
+	  You need this enabled if you want your kernel to run on a
+	  DM&P CPU. Disabling this option on other types of CPUs
+	  makes the kernel a tiny bit smaller. Disabling it on a DM&P
+	  CPU might render the kernel unbootable.
+
+	  If unsure, say N.
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 556b2b17c3e2..f763c2c6228a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -162,7 +162,8 @@ enum cpuid_regs_idx {
 #define X86_VENDOR_NSC		8
 #define X86_VENDOR_HYGON	9
 #define X86_VENDOR_ZHAOXIN	10
-#define X86_VENDOR_NUM		11
+#define X86_VENDOR_DMP		11
+#define X86_VENDOR_NUM		12
 
 #define X86_VENDOR_UNKNOWN	0xff
 
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 637b499450d1..37322107b773 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 obj-$(CONFIG_CPU_SUP_ZHAOXIN)		+= zhaoxin.o
+obj-$(CONFIG_CPU_SUP_DMP_32)		+= dmp.o
 
 obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a1b756c49a93..fb55b86313f7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1042,6 +1042,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL(CENTAUR,	5, X86_MODEL_ANY,	NO_SPECULATION),
 	VULNWL(INTEL,	5, X86_MODEL_ANY,	NO_SPECULATION),
 	VULNWL(NSC,	5, X86_MODEL_ANY,	NO_SPECULATION),
+	VULNWL(DMP,	5, X86_MODEL_ANY,	NO_SPECULATION),
+	VULNWL(DMP,	6, X86_MODEL_ANY,	NO_SPECULATION),
 
 	/* Intel Family 6 */
 	VULNWL_INTEL(ATOM_SALTWELL,		NO_SPECULATION | NO_ITLB_MULTIHIT),
diff --git a/arch/x86/kernel/cpu/dmp.c b/arch/x86/kernel/cpu/dmp.c
new file mode 100644
index 000000000000..035f6dd99065
--- /dev/null
+++ b/arch/x86/kernel/cpu/dmp.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <asm/processor.h>
+#include "cpu.h"
+
+/*
+ * No special init required for DM&P processors.
+ */
+
+static const struct cpu_dev dmp_cpu_dev = {
+	.c_vendor	= "DM&P",
+	.c_ident	= { "Vortex86 SoC" },
+	.legacy_models	= {
+		{
+			.family = 5,
+			.model_names = {
+				[2] = "Vortex86DX",
+				[8] = "Vortex86MX",
+			},
+		},
+		{
+			.family = 6,
+			.model_names = {
+				/*
+				 * Both the Vortex86EX and the Vortex86EX2
+				 * have the same family and model id.
+				 *
+				 * However, the -EX2 supports the product name
+				 * CPUID call, so this name will only be used
+				 * for the -EX, which does not.
+				 */
+				[0] = "Vortex86EX",
+			},
+		},
+	},
+	.c_x86_vendor	= X86_VENDOR_DMP,
+};
+
+cpu_dev_register(dmp_cpu_dev);
-- 
2.25.1

