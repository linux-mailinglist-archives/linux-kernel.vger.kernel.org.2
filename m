Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28CD32018E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBSXKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhBSXKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:10:39 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD31C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 15:09:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u17so8550322ybi.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 15:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=vrPuPHAH+xMVowYwEx41742LbyJOqhVnyw71QmqUBj8=;
        b=PeNarQe7ZiwXQ4wW6LB9scuGCymurZMZzTDqG32azcLU8SZlTKOB58xAz3Bi0U3M3N
         lxpthe0e1LFpHrOSv7/Nl6N5XhR1WeqL8PxwOy1aRU8BbVM+sWMz9T71y2Mg9r+5+saR
         SuyG+gdIBZXAP0Pysat8Ranavjv0i+1oc9RKf/oPuOyuOXpYgEsUDno+AZOZYj2fcB0+
         YS0ZyG5qkMjduyZiy4j29Q69qZh+YsHZ/pSzFYRsMa0JQgAuXGx0D+S1is5lXmZgRw7G
         339rGK8zUdErRTmdi9VIwBh/QmrsiHFB2Ce/9dip6FHYmMdR6X5tU7NHqjOfCkMc1n0l
         pWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=vrPuPHAH+xMVowYwEx41742LbyJOqhVnyw71QmqUBj8=;
        b=tbbGsICmHVj2Lr82cI3JPpRerLTRn322Wg0aorRqG/plAe8QQjTLS4lQGijGNqlaDR
         ++7qSwImWYHvbWw4JLXfDsL3tr8CfdqgdIxX6EAhiVrEmhXYz8OjgpPnPDT6FPdfO4mY
         AuFmvaL6BcqqtyBB1quh0R6TR6XUC/HcBO7Eh2gYbDCsKtn7FGiRv3fNmYr9jM/Hyuuj
         bdHwswkg++BFERfS/0kwdyuUusHMFoXjcB3XhkCaQGI4aaA5KdRKTN5ubF/go1Aepxn0
         RKAzZwHjpMOLFn3ckrUdP+yZ3ySGW0JcbjIVzpH8kbZFa9SrcDDz4HtqSO6Y0YqxhpIS
         JU2Q==
X-Gm-Message-State: AOAM530muvMPeGSxbAefrGnAWbu4vLgluiP3Y9WW4iOn8oE+manWHikz
        8xUHIyMcjffGBhARbLNM05H1ctSHbciL
X-Google-Smtp-Source: ABdhPJyM0ua3ElvZJE192OqKUKdrFKz/zW6QcCT6p3cm8Hvv6hJ31BKpdoPIt2iWnjsgulPHIlSdq8OoH5Fd
Sender: "jiancai via sendgmr" <jiancai@jiancai.svl.corp.google.com>
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:6578:8d7f:50d0:55c8])
 (user=jiancai job=sendgmr) by 2002:a25:1fc5:: with SMTP id
 f188mr17059740ybf.389.1613776198078; Fri, 19 Feb 2021 15:09:58 -0800 (PST)
Date:   Fri, 19 Feb 2021 15:08:13 -0800
In-Reply-To: <20210219201852.3213914-1-jiancai@google.com>
Message-Id: <20210219230841.875875-1-jiancai@google.com>
Mime-Version: 1.0
References: <20210219201852.3213914-1-jiancai@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v4] ARM: Implement SLS mitigation
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
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
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

Changes v3 -> v4:
  Address Nathan's comment and replace def_bool with depends on in
  HARDEN_SLS_ALL.

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
index 269967c4fc1b..146b75a79d9e 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -121,6 +121,16 @@ choice
 
 endchoice
 
+config HARDEN_SLS_ALL
+	bool "enable SLS vulnerability hardening"
+	default n
+	depends on $(cc-option,-mharden-sls=all)
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

