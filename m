Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3187831FFC3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 21:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBSUTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 15:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhBSUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 15:19:36 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3396C061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 12:18:56 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id u66so4327984qkd.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 12:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=7T2c0bl5OkkQ79Gbe1n87t+HukBdE3TTJ/DXUdpKX6g=;
        b=jI/PzXCkzv+CnZNka4GAons5+7izWtdVJUd+7qRf/m+dBDEUQdqf+vMddpUjj4dwHs
         N9dic8hCJtSz+MZJC6XOC1kkah28rIKnZmCGgRyUnG9oA9ih/2fwsir8aSSQfcvEPO0x
         zwynFaX2a8v52FYb3xnXRSXcWOIPbdhYl0TGczuGrbp1GIpgPGLGQSIEz6644YnnFpAU
         UMUXHBEBQYpnD34bcFGV1LhJCFIRRQt5HXzRXmS6ljiS9ECQcUH2jFDrzKv+21/GdYyO
         MI2GSCSVjZ081U9R2E5xpMW/4XFbpy6sTk46xgHEw5Zv2x2kUoiwsgK2a6r3GbylJCWu
         IhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=7T2c0bl5OkkQ79Gbe1n87t+HukBdE3TTJ/DXUdpKX6g=;
        b=ILt2I1EAZ8+RCeBUlIoRh9rOG9btILAosDnoHe+3G7zMOtAj7qBp/xvFdcwp91B+Bf
         IK86hRPkbZYYUGAtHMG4GN98LsUuCuKRHG/1ojNA6V0azHzG2GW5Z9pZ9Mg1NvX3vc4O
         9cUbasI6fMpzOWDNDDmwdlQRkJz35CC26g8rlqCKCpqCFg9UPm7nyNaJWexEup/IvciG
         fsYc0w97P3jGJ0qUsRBqZPE7D3i0FbU1Jd8EvLbUMlAqBKWobwnsGceI9xeWRmAkpcKG
         CHuHb618wtZlaIqxhCBeRBw8ZBTb76vFDcU05ucEmhOrKj7Ch78fwM+EB1l9/gBfsUME
         2ZAw==
X-Gm-Message-State: AOAM530y6z0ibXBRds2AejyiM71w1XeY4ypFwoiCfPmUjPTEz8Nv7OqP
        PMgRhT4GaMxlRPNqlVSUYEB8+fqXULQb
X-Google-Smtp-Source: ABdhPJwMSp/rAEOX2pa/XWlA4huWXhXIwFC1NziSv58q8T8Af4FW8ptK4uG0CBbmUC48wraFdMIWN6oOpPNq
Sender: "jiancai via sendgmr" <jiancai@jiancai.svl.corp.google.com>
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:6578:8d7f:50d0:55c8])
 (user=jiancai job=sendgmr) by 2002:a0c:c488:: with SMTP id
 u8mr3180406qvi.9.1613765935591; Fri, 19 Feb 2021 12:18:55 -0800 (PST)
Date:   Fri, 19 Feb 2021 12:18:40 -0800
In-Reply-To: <20210212195255.1321544-1-jiancai@google.com>
Message-Id: <20210219201852.3213914-1-jiancai@google.com>
Mime-Version: 1.0
References: <20210212195255.1321544-1-jiancai@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v3] ARM: Implement SLS mitigation
From:   Jian Cai <jiancai@google.com>
Cc:     ndesaulniers@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com, Jian Cai <jiancai@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Olof Johansson <olof@lixom.net>, Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds CONFIG_HARDEN_SLS_ALL that can be used to turn on
-mharden-sls=all, which mitigates the straight-line speculation
vulnerability, speculative execution of the instruction following some
unconditional jumps. Notice -mharden-sls= has other options as below,
and this config turns on the strongest option.

all: enable all mitigations against Straight Line Speculation that are implemented.
none: disable all mitigations against Straight Line Speculation.
retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
blr: enable the mitigation against Straight Line Speculation for BLR instructions.

Links:
https://reviews.llvm.org/D93221
https://reviews.llvm.org/D81404
https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/downloads/straight-line-speculation
https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/frequently-asked-questions#SLS2

Suggested-by: Manoj Gupta <manojgupta@google.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Nathan Chancellor  <nathan@kernel.org>
Suggested-by: David Laight <David.Laight@aculab.com>
Suggested-by: Will Deacon <will@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jian Cai <jiancai@google.com>
---

Changes v2 -> v3:
  Modify linker scripts as Nick suggested to address boot failure
  (verified with qemu). Added more details in Kconfig.hardening
  description. Disable the config by default.

 arch/arm/Makefile                  |  4 ++++
 arch/arm/include/asm/vmlinux.lds.h |  4 ++++
 arch/arm/kernel/vmlinux.lds.S      |  1 +
 arch/arm64/Makefile                |  4 ++++
 arch/arm64/kernel/vmlinux.lds.S    |  5 +++++
 security/Kconfig.hardening         | 10 ++++++++++
 6 files changed, 28 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4aaec9599e8a..11d89ef32da9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -48,6 +48,10 @@ CHECKFLAGS	+= -D__ARMEL__
 KBUILD_LDFLAGS	+= -EL
 endif
 
+ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
+KBUILD_CFLAGS  += -mharden-sls=all
+endif
+
 #
 # The Scalar Replacement of Aggregates (SRA) optimization pass in GCC 4.9 and
 # later may result in code being generated that handles signed short and signed
diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index 4a91428c324d..c7f9717511ca 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -145,3 +145,7 @@
 		__edtcm_data = .;					\
 	}								\
 	. = __dtcm_start + SIZEOF(.data_dtcm);
+
+#define SLS_TEXT							\
+		ALIGN_FUNCTION();					\
+		*(.text.__llvm_slsblr_thunk_*)
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index f7f4620d59c3..e71f2bc97bae 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -63,6 +63,7 @@ SECTIONS
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 		ARM_TEXT
+		SLS_TEXT
 	}
 
 #ifdef CONFIG_DEBUG_ALIGN_RODATA
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 90309208bb28..ca7299b356a9 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -34,6 +34,10 @@ $(warning LSE atomics not supported by binutils)
   endif
 endif
 
+ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
+KBUILD_CFLAGS  += -mharden-sls=all
+endif
+
 cc_has_k_constraint := $(call try-run,echo				\
 	'int main(void) {						\
 		asm volatile("and w0, w0, %w0" :: "K" (4294967295));	\
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4c0b0c89ad59..f8912e42ffcd 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -93,6 +93,10 @@ jiffies = jiffies_64;
 #define TRAMP_TEXT
 #endif
 
+#define SLS_TEXT					\
+	ALIGN_FUNCTION();				\
+	*(.text.__llvm_slsblr_thunk_*)
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from _stext to _edata, must be a round multiple of the PE/COFF
@@ -144,6 +148,7 @@ SECTIONS
 			HIBERNATE_TEXT
 			TRAMP_TEXT
 			*(.fixup)
+			SLS_TEXT
 			*(.gnu.warning)
 		. = ALIGN(16);
 		*(.got)			/* Global offset table		*/
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 269967c4fc1b..e70f227019e1 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -121,6 +121,16 @@ choice
 
 endchoice
 
+config HARDEN_SLS_ALL
+	bool "enable SLS vulnerability hardening"
+	default n
+	def_bool $(cc-option,-mharden-sls=all)
+	help
+	  Enables straight-line speculation vulnerability hardening on ARM and ARM64
+	  architectures. It inserts speculation barrier sequences (SB or DSB+ISB
+	  depending on the target architecture) after RET and BR, and replacing
+	  BLR with BL+BR sequence.
+
 config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	bool "Report forcefully initialized variables"
 	depends on GCC_PLUGIN_STRUCTLEAK
-- 
2.30.0.617.g56c4b15f3c-goog

