Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B52426F03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhJHQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhJHQcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:32:22 -0400
X-Greylist: delayed 437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Oct 2021 09:30:13 PDT
Received: from forward105o.mail.yandex.net (forward105o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037DC061768
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 09:30:13 -0700 (PDT)
Received: from iva6-28d2389f22c1.qloud-c.yandex.net (iva6-28d2389f22c1.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7594:0:640:28d2:389f])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 809134C32F1;
        Fri,  8 Oct 2021 19:22:54 +0300 (MSK)
Received: from iva4-b3ebd202b141.qloud-c.yandex.net (2a02:6b8:c0c:4e8e:0:640:b3eb:d202 [2a02:6b8:c0c:4e8e:0:640:b3eb:d202])
        by iva6-28d2389f22c1.qloud-c.yandex.net (mxback/Yandex) with ESMTP id XlY4HA1ow6-MrD4xPfv;
        Fri, 08 Oct 2021 19:22:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orca.pet; s=mail; t=1633710174;
        bh=2ejj2s33PrrFoUceVWZoC+LWOF3ymFBThsjBlhGcCnw=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=lH23ygBJxudRGpNAsrMwAcNRSI/zbs33YHG5BUhQwiM8b3GTyO6b05zS/saxeRBBN
         acmgpeZqSbD5hDPo6QvjtegGQbu2kTxUaghs5Vw5CHZJ4mKUvu4W4IJRtGUJnpqiG1
         EMigLK/Vqzn26Sd//C9KmxMjBpKFFd7M9kbSRnSg=
Authentication-Results: iva6-28d2389f22c1.qloud-c.yandex.net; dkim=pass header.i=@orca.pet
Received: by iva4-b3ebd202b141.qloud-c.yandex.net (smtp/Yandex) with ESMTPS id La3xKMb6ex-MqxiqSGo;
        Fri, 08 Oct 2021 19:22:52 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Marcos Del Sol Vives <marcos@orca.pet>
To:     x86@kernel.org
Cc:     Marcos Del Sol Vives <marcos@orca.pet>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: add support DM&P devices
Date:   Fri,  8 Oct 2021 18:22:46 +0200
Message-Id: <20211008162246.1638801-1-marcos@orca.pet>
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
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
index 9ad2acaaae9b..ac2700806b6e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -164,7 +164,8 @@ enum cpuid_regs_idx {
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
index 0f8885949e8c..ef2f7da8fb65 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1044,6 +1044,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
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

