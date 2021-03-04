Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97D232DA13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbhCDTHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:07:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237838AbhCDTHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:07:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8E0264F7B;
        Thu,  4 Mar 2021 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614884776;
        bh=NVtpsd7hAnZRNM/yEFr2E7BeAFnMe96ztRP75qp4TFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jj0Ch+a7UoZfXPjktbo9sKI/+znhtZ4FWF2DQSupwlmYnbXDh6Nce4aLHurSp/bdZ
         45KmQjmmtadjYDPh7mT4FHd9MFxFgA1ZoGvfF1LrklCsGFsaScNOJn3hh+dlaAmjIK
         05aQPb6SNdXK/34OhJmUGYyIwBgCecI0e9bQ9VSDlibbcUOxkRPt+VM4oCgncYHzPD
         tXLUYeZq0IBhaz5bg1DPBSXpSFol6cQaG2MWO7XueQb/ncEX3YZNhzfwh7Q7yRi5Zs
         hT0vY20cRyNdBLJ5rk4eCpwpvs/g5dd1Hcbl4659KEaWbPEa+o1sa/ms+9nWsuwUcf
         B1lqSwDFkH1XQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 11/11] kentry: Verify kentry state in instrumentation_begin/end()
Date:   Thu,  4 Mar 2021 11:06:04 -0800
Message-Id: <0749a0732066316c2d048c70bf379b17d067f4d2.1614884673.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614884673.git.luto@kernel.org>
References: <cover.1614884673.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling instrumentation_begin() and instrumentation_end() when kentry
thinks the CPU is in user mode is an error.  Verify the kentry state when
instrumentation_begin/end() are called.

Add _nocheck() variants to skip verification to avoid WARN() generating
extra kentry warnings.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/traps.c         |  4 ++--
 include/asm-generic/bug.h       |  8 ++++----
 include/linux/instrumentation.h | 25 ++++++++++++++++++++-----
 kernel/entry/common.c           |  7 +++++++
 4 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index be924180005a..983e4be5fdcb 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -229,7 +229,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	/*
 	 * All lies, just get the WARN/BUG out.
 	 */
-	instrumentation_begin();
+	instrumentation_begin_nocheck();
 	/*
 	 * Since we're emulating a CALL with exceptions, restore the interrupt
 	 * state to what it was at the exception site.
@@ -242,7 +242,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	}
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
-	instrumentation_end();
+	instrumentation_end_nocheck();
 
 	return handled;
 }
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 76a10e0dca9f..fc360c463a99 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -85,18 +85,18 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...) do {				\
-		instrumentation_begin();				\
+		instrumentation_begin_nocheck();			\
 		warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);	\
-		instrumentation_end();					\
+		instrumentation_end_nocheck();				\
 	} while (0)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
 #define __WARN_printf(taint, arg...) do {				\
-		instrumentation_begin();				\
+		instrumentation_begin_nocheck();			\
 		__warn_printk(arg);					\
 		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
-		instrumentation_end();					\
+		instrumentation_end_nocheck();				\
 	} while (0)
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index 93e2ad67fc10..cdf80454f92a 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -4,14 +4,21 @@
 
 #if defined(CONFIG_DEBUG_ENTRY) && defined(CONFIG_STACK_VALIDATION)
 
+extern void kentry_assert_may_instrument(void);
+
 /* Begin/end of an instrumentation safe region */
-#define instrumentation_begin() ({					\
-	asm volatile("%c0: nop\n\t"						\
+#define instrumentation_begin_nocheck() ({				\
+	asm volatile("%c0: nop\n\t"					\
 		     ".pushsection .discard.instr_begin\n\t"		\
 		     ".long %c0b - .\n\t"				\
 		     ".popsection\n\t" : : "i" (__COUNTER__));		\
 })
 
+#define instrumentation_begin() ({					\
+	instrumentation_begin_nocheck();				\
+	kentry_assert_may_instrument();					\
+})
+
 /*
  * Because instrumentation_{begin,end}() can nest, objtool validation considers
  * _begin() a +1 and _end() a -1 and computes a sum over the instructions.
@@ -43,15 +50,23 @@
  * To avoid this, have _end() be a NOP instruction, this ensures it will be
  * part of the condition block and does not escape.
  */
-#define instrumentation_end() ({					\
+#define instrumentation_end_nocheck() ({				\
 	asm volatile("%c0: nop\n\t"					\
 		     ".pushsection .discard.instr_end\n\t"		\
 		     ".long %c0b - .\n\t"				\
 		     ".popsection\n\t" : : "i" (__COUNTER__));		\
 })
+
+#define instrumentation_end() ({					\
+	kentry_assert_may_instrument();					\
+	instrumentation_end_nocheck();					\
+})
+
 #else
-# define instrumentation_begin()	do { } while(0)
-# define instrumentation_end()		do { } while(0)
+# define instrumentation_begin_nocheck()	do { } while(0)
+# define instrumentation_begin()		do { } while(0)
+# define instrumentation_end_nocheck()		do { } while(0)
+# define instrumentation_end()			do { } while(0)
 #endif
 
 #endif /* __LINUX_INSTRUMENTATION_H */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 9dea411de3b0..870595bdd405 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -56,6 +56,13 @@ static __always_inline void kentry_cpu_depth_sub(unsigned int n)
 {
 	this_cpu_sub(kentry_cpu_depth, n);
 }
+
+void kentry_assert_may_instrument(void)
+{
+	DEBUG_ENTRY_WARN_ONCE(this_cpu_read(kentry_cpu_depth) == 0, "instrumentable code is running in the wrong kentry state");
+}
+EXPORT_SYMBOL_GPL(kentry_assert_may_instrument);
+
 #else
 
 #define DEBUG_ENTRY_WARN_ONCE(condition, format...) do {} while (0)
-- 
2.29.2

