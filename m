Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6D53F3753
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbhHTXf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 19:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231506AbhHTXfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629502486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aB9Sjx+ciHbt/1GetSDaXix1ueOvySdWS/UU1XJ3dIs=;
        b=W7aLi5RPJLewnuEfqE07T/m5S4njfoM32U8VIi/M6nnyDObJCARsJyxIXiV7GkUzLXYlMV
        r66yjDMxvzBdDqQFXVNYGAS1dw/uVG0qFMZdWLXB4KVrCqlOIURviOXraTqeMniXqFNtA5
        un907LzEmUJYkLuFo8yX3q2OAyK7QJU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-7cfBn1T6NbSwaxuVDY8nJA-1; Fri, 20 Aug 2021 19:34:45 -0400
X-MC-Unique: 7cfBn1T6NbSwaxuVDY8nJA-1
Received: by mail-oo1-f69.google.com with SMTP id q11-20020a4aa88b000000b0028e498bb328so1284730oom.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 16:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aB9Sjx+ciHbt/1GetSDaXix1ueOvySdWS/UU1XJ3dIs=;
        b=Fy3bAxkPXOFQBPN9/qElvSNww6jTi+YcaJ4ENcK6GJDnWxNl5UImpxJk0UOgphR6hP
         D3CS4S7+7UJ7IMucgKCB240qDeI8+9mWoAIauVk4bazp7sj6axXNrfnXEu24wpc/dYwB
         V1ftkk5VggcCz0yKrTwsDotPI4O6aZsp0HOi71BRzoFqV9CWPhuUDJYRU3MTRskslpWs
         DnSRrHTj7JXU1P4HwMn+pOTfVKmG89hwcqii7siFILnTbz8iACbBoPw36xXe1wakHNEO
         t/gzGf88qgClw7mTvekc/GmrddP+N1bUyNCt2BTl+hYw6vTcAJ+zjAReh2QWmCMwtmUk
         rhhw==
X-Gm-Message-State: AOAM531R4K/nUVhZSPYq+uiV+no03G61gG2pdisYvVOOH7mle/s3Qzb5
        WF7G4XEItgr98RuQNUL6EgAiJHUtz8QISItGu72gT6X3ZN7hvX65mDpF2Zf7bYpfTCS7nFX+MLB
        H+x4iFpaii0/DvQE+n4DGBHei
X-Received: by 2002:a05:6808:35a:: with SMTP id j26mr4921455oie.140.1629502484040;
        Fri, 20 Aug 2021 16:34:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEdEqsXCK76Vk+0pJ3zq7hI07iGn4j7FsP2q9hKq3by2qjQV/Vh2CGRZE33xrBdQKc48Z13g==
X-Received: by 2002:a05:6808:35a:: with SMTP id j26mr4921449oie.140.1629502483856;
        Fri, 20 Aug 2021 16:34:43 -0700 (PDT)
Received: from treble ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id b3sm410751oie.1.2021.08.20.16.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 16:34:43 -0700 (PDT)
Date:   Fri, 20 Aug 2021 16:34:40 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com
Subject: Re: [PATCH v2 06/24] x86: Always inline
 context_tracking_guest_enter()
Message-ID: <20210820233440.jjzdw6qjnytonlmv@treble>
References: <20210624094059.886075998@infradead.org>
 <20210624095148.003928226@infradead.org>
 <20210820232203.nmuc3gelzsazyewk@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820232203.nmuc3gelzsazyewk@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 04:22:07PM -0700, Josh Poimboeuf wrote:
> On Thu, Jun 24, 2021 at 11:41:05AM +0200, Peter Zijlstra wrote:
> > Yes, it really did out-of-line this....
> > 
> > vmlinux.o: warning: objtool: vmx_vcpu_enter_exit()+0x31: call to context_tracking_guest_enter() leaves .noinstr.text section
> > 
> > 000000000019f660 <context_tracking_guest_enter>:
> >   19f660:	e8 00 00 00 00       	callq  19f665 <context_tracking_guest_enter+0x5>	19f661: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
> >   19f665:	31 c0                	xor    %eax,%eax
> >   19f667:	c3                   	retq   
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Ha.  I'm guessing this was from CONFIG_DEBUG_SECTION_MISMATCH, which is
> only good for triggering a lot of these useless __always_inline patches.
> 
> I have a patch somewhere to get rid of it.

Found it.

WARNING: This patch may shrink your patch set and improve your sanity.

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH

Modpost's section mismatch detection warns when a non-init function
references an __init function.  The warning is needed because __init
memory is freed during boot, so the non-init function might end up
calling into some random memory.

CONFIG_DEBUG_SECTION_MISMATCH is intended to root out more of these
issues by adding the -fno-inline-functions-called-once compiler flag,
which forces once-called static functions to not be inlined.  As
described in the option's help description:

  - Add the option -fno-inline-functions-called-once to gcc commands.
    When inlining a function annotated with __init in a non-init
    function, we would lose the section information and thus
    the analysis would not catch the illegal reference.
    This option tells gcc to inline less (but it does result in
    a larger kernel).

It's true that if an __init function is inlined in a non-init function,
it's no longer __init.  But that's not actually a problem.

If an inlined __init function doesn't access any other __init functions
or data, the inlining is harmless.

If the inlined __init function does access other __init functions/data,
__init relocations will be generated for a non-init section, and
modpost's section mismatch detection will discover it.

So the option isn't actually useful.  It's not even useful for finding
issues on other configs, which might have different inlining decisions,
because with -O2, once-called static functions are always inlined.  And
anyway, nowadays we have build bots everywhere, which are great at
finding such edge cases.

I get the feeling this option has been responsible for dozens of
"convert inline to __always_inline" patches over the years.  Such
patches usually complain about the compiler's inlining decisions being
unpredictable.  Turns out the culprit is this
CONFIG_DEBUG_SECTION_MISMATCH option, at least for once-called
functions.

This option really has no benefits, and only drawbacks, causing needless
churn.  Remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Makefile                                      |  5 -----
 arch/arc/configs/tb10x_defconfig              |  1 -
 arch/nds32/configs/defconfig                  |  1 -
 arch/s390/configs/debug_defconfig             |  1 -
 arch/s390/configs/defconfig                   |  1 -
 lib/Kconfig.debug                             | 21 -------------------
 .../selftests/wireguard/qemu/debug.config     |  1 -
 7 files changed, 31 deletions(-)

diff --git a/Makefile b/Makefile
index c19d1638da25..195d4f4914e3 100644
--- a/Makefile
+++ b/Makefile
@@ -913,11 +913,6 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
 KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 endif
 
-# We trigger additional mismatches with less inlining
-ifdef CONFIG_DEBUG_SECTION_MISMATCH
-KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
-endif
-
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
 LDFLAGS_vmlinux += --gc-sections
diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index a12656ec0072..5acf8cc3e7b0 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -96,7 +96,6 @@ CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_HEADERS_INSTALL=y
 CONFIG_HEADERS_CHECK=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_STACKOVERFLOW=y
diff --git a/arch/nds32/configs/defconfig b/arch/nds32/configs/defconfig
index f9a89cf00aa6..61b5b83bd20e 100644
--- a/arch/nds32/configs/defconfig
+++ b/arch/nds32/configs/defconfig
@@ -93,7 +93,6 @@ CONFIG_GDB_SCRIPTS=y
 CONFIG_READABLE_ASM=y
 CONFIG_HEADERS_INSTALL=y
 CONFIG_HEADERS_CHECK=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_PANIC_ON_OOPS=y
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index b88184019af9..68104f82cc9d 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -782,7 +782,6 @@ CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_HEADERS_INSTALL=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_PAGE_OWNER=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 1667a3cdcf0a..a5e7eb0276c6 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -767,7 +767,6 @@ CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_GDB_SCRIPTS=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_WX=y
 CONFIG_PTDUMP_DEBUGFS=y
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e5cdf98f50c2..93f9c00783b2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -381,27 +381,6 @@ config HEADERS_INSTALL
 	  user-space program samples. It is also needed by some features such
 	  as uapi header sanity checks.
 
-config DEBUG_SECTION_MISMATCH
-	bool "Enable full Section mismatch analysis"
-	help
-	  The section mismatch analysis checks if there are illegal
-	  references from one section to another section.
-	  During linktime or runtime, some sections are dropped;
-	  any use of code/data previously in these sections would
-	  most likely result in an oops.
-	  In the code, functions and variables are annotated with
-	  __init,, etc. (see the full list in include/linux/init.h),
-	  which results in the code/data being placed in specific sections.
-	  The section mismatch analysis is always performed after a full
-	  kernel build, and enabling this option causes the following
-	  additional step to occur:
-	  - Add the option -fno-inline-functions-called-once to gcc commands.
-	    When inlining a function annotated with __init in a non-init
-	    function, we would lose the section information and thus
-	    the analysis would not catch the illegal reference.
-	    This option tells gcc to inline less (but it does result in
-	    a larger kernel).
-
 config SECTION_MISMATCH_WARN_ONLY
 	bool "Make section mismatch errors non-fatal"
 	default y
diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/testing/selftests/wireguard/qemu/debug.config
index fe07d97df9fa..83588bb08fde 100644
--- a/tools/testing/selftests/wireguard/qemu/debug.config
+++ b/tools/testing/selftests/wireguard/qemu/debug.config
@@ -57,7 +57,6 @@ CONFIG_USER_STACKTRACE_SUPPORT=y
 CONFIG_DEBUG_SG=y
 CONFIG_DEBUG_NOTIFIERS=y
 CONFIG_X86_DEBUG_FPU=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
 CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
-- 
2.31.1

