Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE4544E4A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhKLKf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbhKLKfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:35:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EC0C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:33:01 -0800 (PST)
Received: from zn.tnic (p200300ec2f10ce005b16e04e289251c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:ce00:5b16:e04e:2892:51c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD30C1EC0577;
        Fri, 12 Nov 2021 11:32:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636713179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrXs5cQiTFJfJcAcOzW6yPRv8Fkuy4MjuRg2Z2Y2Xiw=;
        b=TmMG3BizFFFhs7M8caT31ocJzhPwM1wK0O6mQBJRkO48g5d0l8eojP1pXap/6kY2wbhB5R
        wxUFoyTz6ya8jhUUpsdBfoz+qwoRH1WPhjyOnYJHBSaHS0dSW2we/+i0Fo3d7PWVpNnUk8
        xrWrdkxp2S9AZJ+SOM/Pk2MP6W2KXyw=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"
Date:   Fri, 12 Nov 2021 11:32:43 +0100
Message-Id: <20211112103246.7555-4-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112103246.7555-1-bp@alien8.de>
References: <20211112103246.7555-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Those were added as part of the SMAP enablement but SMAP is currently
an integral part of kernel proper and there's no need to disable it
anymore.

Rip out that functionality.

If still needed - clearcpuid=smap.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 .../admin-guide/kernel-parameters.txt         |  4 ----
 Documentation/x86/cpuinfo.rst                 |  5 ++--
 arch/x86/Kconfig                              | 11 ---------
 arch/x86/include/asm/disabled-features.h      |  8 +------
 arch/x86/include/asm/smap.h                   | 24 -------------------
 arch/x86/kernel/cpu/common.c                  | 15 +-----------
 scripts/Makefile.lib                          |  4 ++--
 scripts/link-vmlinux.sh                       |  6 ++---
 .../arch/x86/include/asm/disabled-features.h  |  8 +------
 9 files changed, 10 insertions(+), 75 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 13e6f0100970..54ae0378add4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3365,10 +3365,6 @@
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable non-executable mappings
 
-	nosmap		[X86,PPC]
-			Disable SMAP (Supervisor Mode Access Prevention)
-			even if it is supported by processor.
-
 	nosmep		[X86,PPC]
 			Disable SMEP (Supervisor Mode Execution Prevention)
 			even if it is supported by processor.
diff --git a/Documentation/x86/cpuinfo.rst b/Documentation/x86/cpuinfo.rst
index 5d54c39a063f..12fbe2b1e98a 100644
--- a/Documentation/x86/cpuinfo.rst
+++ b/Documentation/x86/cpuinfo.rst
@@ -140,9 +140,8 @@ from #define X86_FEATURE_UMIP (16*32 + 2).
 
 In addition, there exists a variety of custom command-line parameters that
 disable specific features. The list of parameters includes, but is not limited
-to, nofsgsbase, nosmap, and nosmep. 5-level paging can also be disabled using
-"no5lvl". SMAP and SMEP are disabled with the aforementioned parameters,
-respectively.
+to, nofsgsbase, and nosmep. 5-level paging can also be disabled using
+"no5lvl". SMEP is disabled with the aforementioned parameter.
 
 e: The feature was known to be non-functional.
 ----------------------------------------------
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95dd1ee01546..8959c7c55991 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1822,17 +1822,6 @@ config ARCH_RANDOM
 	  If supported, this is a high bandwidth, cryptographically
 	  secure hardware random number generator.
 
-config X86_SMAP
-	def_bool y
-	prompt "Supervisor Mode Access Prevention" if EXPERT
-	help
-	  Supervisor Mode Access Prevention (SMAP) is a security
-	  feature in newer Intel processors.  There is a small
-	  performance cost if this enabled and turned on; there is
-	  also a small increase in the kernel size if this is enabled.
-
-	  If unsure, say Y.
-
 config X86_UMIP
 	def_bool y
 	prompt "User Mode Instruction Prevention" if EXPERT
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 8f28fafa98b3..c2808f4d61f0 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -10,12 +10,6 @@
  * cpu_feature_enabled().
  */
 
-#ifdef CONFIG_X86_SMAP
-# define DISABLE_SMAP	0
-#else
-# define DISABLE_SMAP	(1<<(X86_FEATURE_SMAP & 31))
-#endif
-
 #ifdef CONFIG_X86_UMIP
 # define DISABLE_UMIP	0
 #else
@@ -77,7 +71,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_SMAP|DISABLE_SGX)
+#define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index d17b39893b79..bab490379c65 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -19,25 +19,14 @@
 
 #ifdef __ASSEMBLY__
 
-#ifdef CONFIG_X86_SMAP
-
 #define ASM_CLAC \
 	ALTERNATIVE "", __ASM_CLAC, X86_FEATURE_SMAP
 
 #define ASM_STAC \
 	ALTERNATIVE "", __ASM_STAC, X86_FEATURE_SMAP
 
-#else /* CONFIG_X86_SMAP */
-
-#define ASM_CLAC
-#define ASM_STAC
-
-#endif /* CONFIG_X86_SMAP */
-
 #else /* __ASSEMBLY__ */
 
-#ifdef CONFIG_X86_SMAP
-
 static __always_inline void clac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
@@ -76,19 +65,6 @@ static __always_inline void smap_restore(unsigned long flags)
 #define ASM_STAC \
 	ALTERNATIVE("", __ASM_STAC, X86_FEATURE_SMAP)
 
-#else /* CONFIG_X86_SMAP */
-
-static inline void clac(void) { }
-static inline void stac(void) { }
-
-static inline unsigned long smap_save(void) { return 0; }
-static inline void smap_restore(unsigned long flags) { }
-
-#define ASM_CLAC
-#define ASM_STAC
-
-#endif /* CONFIG_X86_SMAP */
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_SMAP_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b4598659d4a8..796aa31fd3c8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -304,13 +304,6 @@ static __always_inline void setup_smep(struct cpuinfo_x86 *c)
 		cr4_set_bits(X86_CR4_SMEP);
 }
 
-static __init int setup_disable_smap(char *arg)
-{
-	setup_clear_cpu_cap(X86_FEATURE_SMAP);
-	return 1;
-}
-__setup("nosmap", setup_disable_smap);
-
 static __always_inline void setup_smap(struct cpuinfo_x86 *c)
 {
 	unsigned long eflags = native_save_fl();
@@ -318,14 +311,8 @@ static __always_inline void setup_smap(struct cpuinfo_x86 *c)
 	/* This should have been cleared long ago */
 	BUG_ON(eflags & X86_EFLAGS_AC);
 
-	if (cpu_has(c, X86_FEATURE_SMAP)) {
-#ifdef CONFIG_X86_SMAP
+	if (cpu_has(c, X86_FEATURE_SMAP))
 		cr4_set_bits(X86_CR4_SMAP);
-#else
-		clear_cpu_cap(c, X86_FEATURE_SMAP);
-		cr4_clear_bits(X86_CR4_SMAP);
-#endif
-	}
 }
 
 static __always_inline void setup_umip(struct cpuinfo_x86 *c)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 56d50eb0cd80..3e4e8d97ff40 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -240,8 +240,8 @@ objtool_args =								\
 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
 	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
-	$(if $(CONFIG_X86_SMAP), --uaccess)				\
-	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)
+	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
+	--uaccess
 
 # Useful for describing the dependency of composite objects
 # Usage:
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 3ea7cece7c97..6180860e9e1d 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -136,9 +136,9 @@ objtool_link()
 		if [ -n "${CONFIG_RETPOLINE}" ]; then
 			objtoolopt="${objtoolopt} --retpoline"
 		fi
-		if [ -n "${CONFIG_X86_SMAP}" ]; then
-			objtoolopt="${objtoolopt} --uaccess"
-		fi
+
+		objtoolopt="${objtoolopt} --uaccess"
+
 		info OBJTOOL ${1}
 		tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
 	fi
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 8f28fafa98b3..c2808f4d61f0 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -10,12 +10,6 @@
  * cpu_feature_enabled().
  */
 
-#ifdef CONFIG_X86_SMAP
-# define DISABLE_SMAP	0
-#else
-# define DISABLE_SMAP	(1<<(X86_FEATURE_SMAP & 31))
-#endif
-
 #ifdef CONFIG_X86_UMIP
 # define DISABLE_UMIP	0
 #else
@@ -77,7 +71,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_SMAP|DISABLE_SGX)
+#define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
-- 
2.29.2

