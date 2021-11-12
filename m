Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64FC44E4A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhKLKf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbhKLKfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:35:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3687C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:33:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f10ce005b16e04e289251c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:ce00:5b16:e04e:2892:51c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D2931EC05BF;
        Fri, 12 Nov 2021 11:33:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636713181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ST8ihvqM6g0q45em6XRUXgmW78oXC2QUCPbso5U81tQ=;
        b=DAdADqTXGQShKhJjwh84rKPZ806wZ5dcC++Js88bIT/hbetOYYq8TzNbASxC/MQ9rsFStt
        SFiFHy8g7BvnapttmGyPKjMritbAdxWOJ5qEL+LVcfxWp4f4eQ4EeRa0n3Yfc0sb8jUheU
        r8ONu1NTDBy0yDpkS+mZSQ3f5oMBErc=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] x86/cpu: Remove "noexec"
Date:   Fri, 12 Nov 2021 11:32:45 +0100
Message-Id: <20211112103246.7555-6-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112103246.7555-1-bp@alien8.de>
References: <20211112103246.7555-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It doesn't make any sense to disable non-executable mappings -
security-wise or else.

So rip out that switch and move the remaining code into setup.c and
delete setup_nx.c

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 .../admin-guide/kernel-parameters.txt         |  5 --
 Documentation/x86/x86_64/boot-options.rst     |  9 ---
 arch/x86/include/asm/proto.h                  |  1 -
 arch/x86/kernel/setup.c                       | 28 ++++++++-
 arch/x86/mm/Makefile                          |  3 +-
 arch/x86/mm/init_64.c                         |  1 -
 arch/x86/mm/setup_nx.c                        | 62 -------------------
 7 files changed, 26 insertions(+), 83 deletions(-)
 delete mode 100644 arch/x86/mm/setup_nx.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b3fbb0930997..3a4c3fc88bf1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3360,11 +3360,6 @@
 
 	noexec		[IA-64]
 
-	noexec		[X86]
-			On X86-32 available only on PAE configured kernels.
-			noexec=on: enable non-executable mappings (default)
-			noexec=off: disable non-executable mappings
-
 	noexec32	[X86-64]
 			This affects only 32-bit executables.
 			noexec32=on: enable non-executable mappings (default)
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index ccb7e86bf8d9..e72c60210285 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -164,15 +164,6 @@ Rebooting
      newer BIOS, or newer board) using this option will ignore the built-in
      quirk table, and use the generic default reboot actions.
 
-Non Executable Mappings
-=======================
-
-  noexec=on|off
-    on
-      Enable(default)
-    off
-      Disable
-
 NUMA
 ====
 
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index feed36d44d04..0f899c8d7a4e 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -35,7 +35,6 @@ void xen_entry_INT80_compat(void);
 #endif
 
 void x86_configure_nx(void);
-void x86_report_nx(void);
 
 extern int reboot_force;
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 49b596db5631..2f49fef15745 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -742,6 +742,30 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 	return 0;
 }
 
+void x86_configure_nx(void)
+{
+	if (boot_cpu_has(X86_FEATURE_NX))
+		__supported_pte_mask |= _PAGE_NX;
+	else
+		__supported_pte_mask &= ~_PAGE_NX;
+}
+
+static void __init x86_report_nx(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_NX)) {
+		printk(KERN_NOTICE "Notice: NX (Execute Disable) protection "
+		       "missing in CPU!\n");
+	} else {
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
+		printk(KERN_INFO "NX (Execute Disable) protection: active\n");
+#else
+		/* 32bit non-PAE kernel, NX cannot be used */
+		printk(KERN_NOTICE "Notice: NX (Execute Disable) protection "
+		       "cannot be enabled: non-PAE kernel!\n");
+#endif
+	}
+}
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -882,9 +906,7 @@ void __init setup_arch(char **cmdline_p)
 	/*
 	 * x86_configure_nx() is called before parse_early_param() to detect
 	 * whether hardware doesn't support NX (so that the early EHCI debug
-	 * console setup can safely call set_fixmap()). It may then be called
-	 * again from within noexec_setup() during parsing early parameters
-	 * to honor the respective command line option.
+	 * console setup can safely call set_fixmap()).
 	 */
 	x86_configure_nx();
 
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5864219221ca..5bdf0e881897 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -17,13 +17,12 @@ CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 endif
 
 obj-y				:=  init.o init_$(BITS).o fault.o ioremap.o extable.o mmap.o \
-				    pgtable.o physaddr.o setup_nx.o tlb.o cpu_entry_area.o maccess.o
+				    pgtable.o physaddr.o tlb.o cpu_entry_area.o maccess.o
 
 obj-y				+= pat/
 
 # Make sure __phys_addr has no stackprotector
 CFLAGS_physaddr.o		:= -fno-stack-protector
-CFLAGS_setup_nx.o		:= -fno-stack-protector
 CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
 
 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 36098226a957..757d57c40d33 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -110,7 +110,6 @@ int force_personality32;
 /*
  * noexec32=on|off
  * Control non executable heap for 32bit processes.
- * To control the stack too use noexec=off
  *
  * on	PROT_READ does not imply PROT_EXEC for 32-bit processes (default)
  * off	PROT_READ implies PROT_EXEC
diff --git a/arch/x86/mm/setup_nx.c b/arch/x86/mm/setup_nx.c
deleted file mode 100644
index ed5667f5169f..000000000000
--- a/arch/x86/mm/setup_nx.c
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/spinlock.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/pgtable.h>
-
-#include <asm/proto.h>
-#include <asm/cpufeature.h>
-
-static int disable_nx;
-
-/*
- * noexec = on|off
- *
- * Control non-executable mappings for processes.
- *
- * on      Enable
- * off     Disable
- */
-static int __init noexec_setup(char *str)
-{
-	if (!str)
-		return -EINVAL;
-	if (!strncmp(str, "on", 2)) {
-		disable_nx = 0;
-	} else if (!strncmp(str, "off", 3)) {
-		disable_nx = 1;
-	}
-	x86_configure_nx();
-	return 0;
-}
-early_param("noexec", noexec_setup);
-
-void x86_configure_nx(void)
-{
-	if (boot_cpu_has(X86_FEATURE_NX) && !disable_nx)
-		__supported_pte_mask |= _PAGE_NX;
-	else
-		__supported_pte_mask &= ~_PAGE_NX;
-}
-
-void __init x86_report_nx(void)
-{
-	if (!boot_cpu_has(X86_FEATURE_NX)) {
-		printk(KERN_NOTICE "Notice: NX (Execute Disable) protection "
-		       "missing in CPU!\n");
-	} else {
-#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
-		if (disable_nx) {
-			printk(KERN_INFO "NX (Execute Disable) protection: "
-			       "disabled by kernel command line option\n");
-		} else {
-			printk(KERN_INFO "NX (Execute Disable) protection: "
-			       "active\n");
-		}
-#else
-		/* 32bit non-PAE kernel, NX cannot be used */
-		printk(KERN_NOTICE "Notice: NX (Execute Disable) protection "
-		       "cannot be enabled: non-PAE kernel!\n");
-#endif
-	}
-}
-- 
2.29.2

