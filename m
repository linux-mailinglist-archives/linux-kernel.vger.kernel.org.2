Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04D143079D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 11:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245209AbhJQJy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 05:54:56 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:50204 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245202AbhJQJye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 05:54:34 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Oct 2021 05:54:33 EDT
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id D41464BE721A;
        Sun, 17 Oct 2021 12:45:47 +0300 (MSK)
Received: from vla1-eeea27dff809.qloud-c.yandex.net (vla1-eeea27dff809.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:5184:0:640:eeea:27df])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id CF13413E80002;
        Sun, 17 Oct 2021 12:45:47 +0300 (MSK)
Received: from vla1-ef285479e348.qloud-c.yandex.net (2a02:6b8:c0d:35a1:0:640:ef28:5479 [2a02:6b8:c0d:35a1:0:640:ef28:5479])
        by vla1-eeea27dff809.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 0LWAXeFyjU-jlEKHPY5;
        Sun, 17 Oct 2021 12:45:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orca.pet; s=mail; t=1634463947;
        bh=cHwe/DnfGE/JqGgxZvLKYQfLaCg+lBs1hY9ceISCLc0=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=pPiH3tiyy54TTjMj/X5S1arPHdj68fuiHt6ZbUfqu8mzqC8q4e6p2EPzs9Sez5slK
         W/J7sTYooG8k4SV1Woajwu1Yeqom+GF6N0mejg7E+dfHR3PBURf80tTiU6/Cc65Ye3
         Ak5qX0tE8pUblfguo2juA1kdic0V4ZBrjzr4ELWY=
Authentication-Results: vla1-eeea27dff809.qloud-c.yandex.net; dkim=pass header.i=@orca.pet
Received: by vla1-ef285479e348.qloud-c.yandex.net (smtp/Yandex) with ESMTPS id WPTpRJKjtX-jjZ8N1Mo;
        Sun, 17 Oct 2021 12:45:46 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Marcos Del Sol Vives <marcos@orca.pet>
To:     x86@kernel.org
Cc:     Marcos Del Sol Vives <marcos@orca.pet>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86: add support DM&P devices
Date:   Sun, 17 Oct 2021 11:44:10 +0200
Message-Id: <20211017094408.1512158-1-marcos@orca.pet>
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
 arch/x86/Kconfig.cpu             | 13 +++++++++++
 arch/x86/include/asm/processor.h |  3 ++-
 arch/x86/kernel/cpu/Makefile     |  1 +
 arch/x86/kernel/cpu/common.c     |  2 ++
 arch/x86/kernel/cpu/vortex.c     | 39 ++++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/vortex.c

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 814fe0d349b0..eefc434351db 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -508,3 +508,16 @@ config CPU_SUP_ZHAOXIN
 	  CPU might render the kernel unbootable.
 
 	  If unsure, say N.
+
+config CPU_SUP_VORTEX_32
+	default y
+	bool "Support Vortex processors" if PROCESSOR_SELECT
+	depends on X86_32
+	help
+	  This enables detection, tunings and quirks for Vortex processors
+
+	  You need this enabled if you want your kernel to run on a
+	  Vortex CPU. Disabling this option on other types of CPUs
+	  makes the kernel a tiny bit smaller.
+
+	  If unsure, say N.
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 9ad2acaaae9b..64e5290b29d0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -164,7 +164,8 @@ enum cpuid_regs_idx {
 #define X86_VENDOR_NSC		8
 #define X86_VENDOR_HYGON	9
 #define X86_VENDOR_ZHAOXIN	10
-#define X86_VENDOR_NUM		11
+#define X86_VENDOR_VORTEX	11
+#define X86_VENDOR_NUM		12
 
 #define X86_VENDOR_UNKNOWN	0xff
 
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 637b499450d1..9661e3e802be 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 obj-$(CONFIG_CPU_SUP_ZHAOXIN)		+= zhaoxin.o
+obj-$(CONFIG_CPU_SUP_VORTEX_32)		+= vortex.o
 
 obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f8885949e8c..325d6022599b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1044,6 +1044,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL(CENTAUR,	5, X86_MODEL_ANY,	NO_SPECULATION),
 	VULNWL(INTEL,	5, X86_MODEL_ANY,	NO_SPECULATION),
 	VULNWL(NSC,	5, X86_MODEL_ANY,	NO_SPECULATION),
+	VULNWL(VORTEX,	5, X86_MODEL_ANY,	NO_SPECULATION),
+	VULNWL(VORTEX,	6, X86_MODEL_ANY,	NO_SPECULATION),
 
 	/* Intel Family 6 */
 	VULNWL_INTEL(ATOM_SALTWELL,		NO_SPECULATION | NO_ITLB_MULTIHIT),
diff --git a/arch/x86/kernel/cpu/vortex.c b/arch/x86/kernel/cpu/vortex.c
new file mode 100644
index 000000000000..e2685470ba94
--- /dev/null
+++ b/arch/x86/kernel/cpu/vortex.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <asm/processor.h>
+#include "cpu.h"
+
+/*
+ * No special init required for Vortex processors.
+ */
+
+static const struct cpu_dev vortex_cpu_dev = {
+	.c_vendor	= "Vortex",
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
+	.c_x86_vendor	= X86_VENDOR_VORTEX,
+};
+
+cpu_dev_register(vortex_cpu_dev);
-- 
2.25.1

