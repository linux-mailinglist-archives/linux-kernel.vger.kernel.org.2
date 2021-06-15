Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146DD3A86E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhFOQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhFOQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:55:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2326C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v9so2801937wrx.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/xYUM0FBqbe08oYRTlk8DX8WLjFbhUZ/gDArMo/feA=;
        b=SOAYzUSrHtFgjrtbS1AyMjoLAPzzQERh4jgaWHQIuUR58Je3cog/OwWHSo7bSJGRxq
         0Utzb4NcbSyCcq+b9B2Pf+gHd/WO8rdTeoEn0hliwZ2VlUSQmRNiK6bzj7nd4ts2c4Tf
         vhiqbNPikM6lt0OuJb5Cok3/qy6TdsBtHVa9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/xYUM0FBqbe08oYRTlk8DX8WLjFbhUZ/gDArMo/feA=;
        b=rbBf2vcOaF8RA2HoCTbOaHEorR4uT+mqXyn5pylk6InOksl6LW3eXqY9IeFtljqxEn
         4q/xooNsSW9clilnr+bZX5trW3qFQYAbHAegieAbGHxBn2zd/NKzuTkaxdlfBaER0sZ9
         1rlbEXqCjtnpyxW5in6af36AGrIYyS+ebFC0S2VmN4LLcmKWb/Vf6wJFZNHOgoWbUAEm
         B67CoUaRLBqXjjrkQdTlx+pEA9j47q+VDlvRgSOJoonnTuDt1Z5jxmGR3LA+SxX3Fki+
         LL9aHsT5gk90UwRHeM6CxyMSHDbf8m3gi3ZnoIruVbXKdGs2ZvjnFmBnm2TfQAOdF9Z1
         zCFQ==
X-Gm-Message-State: AOAM5339q3ILGd+vSlmdW8gWHHB7CGmFBBAOgggWXWVesWxp+qg2soVR
        uUBx/TFVpkrDt06t/AH+MQyOn1aDfP99O1uYmCw=
X-Google-Smtp-Source: ABdhPJx/z7bU7Rei7fEZQ+O5Mn9mPmRjshSAIUM/6tQmRu/qd1YEBEmLDAIrXXsvBAqq+iKeaQoS6Q==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr70275wrn.156.1623775975108;
        Tue, 15 Jun 2021 09:52:55 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id q20sm24574934wrf.45.2021.06.15.09.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:52:54 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:52:53 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: [PATCH v7 4/5] printk: Userspace format indexing support
Message-ID: <e42070983637ac5e384f17fbdbe86d19c7b212a5.1623775748.git.chris@chrisdown.name>
References: <cover.1623775748.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623775748.git.chris@chrisdown.name>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a number of systems industry-wide that have a subset of their
functionality that works as follows:

1. Receive a message from local kmsg, serial console, or netconsole;
2. Apply a set of rules to classify the message;
3. Do something based on this classification (like scheduling a
   remediation for the machine), rinse, and repeat.

As a couple of examples of places we have this implemented just inside
Facebook, although this isn't a Facebook-specific problem, we have this
inside our netconsole processing (for alarm classification), and as part
of our machine health checking. We use these messages to determine
fairly important metrics around production health, and it's important
that we get them right.

While for some kinds of issues we have counters, tracepoints, or metrics
with a stable interface which can reliably indicate the issue, in order
to react to production issues quickly we need to work with the interface
which most kernel developers naturally use when developing: printk.

Most production issues come from unexpected phenomena, and as such
usually the code in question doesn't have easily usable tracepoints or
other counters available for the specific problem being mitigated. We
have a number of lines of monitoring defence against problems in
production (host metrics, process metrics, service metrics, etc), and
where it's not feasible to reliably monitor at another level, this kind
of pragmatic netconsole monitoring is essential.

As one would expect, monitoring using printk is rather brittle for a
number of reasons -- most notably that the message might disappear
entirely in a new version of the kernel, or that the message may change
in some way that the regex or other classification methods start to
silently fail.

One factor that makes this even harder is that, under normal operation,
many of these messages are never expected to be hit. For example, there
may be a rare hardware bug which one wants to detect if it was to ever
happen again, but its recurrence is not likely or anticipated. This
precludes using something like checking whether the printk in question
was printed somewhere fleetwide recently to determine whether the
message in question is still present or not, since we don't anticipate
that it should be printed anywhere, but still need to monitor for its
future presence in the long-term.

This class of issue has happened on a number of occasions, causing
unhealthy machines with hardware issues to remain in production for
longer than ideal. As a recent example, some monitoring around
blk_update_request fell out of date and caused semi-broken machines to
remain in production for longer than would be desirable.

Searching through the codebase to find the message is also extremely
fragile, because many of the messages are further constructed beyond
their callsite (eg. btrfs_printk and other module-specific wrappers,
each with their own functionality). Even if they aren't, guessing the
format and formulation of the underlying message based on the aesthetics
of the message emitted is not a recipe for success at scale, and our
previous issues with fleetwide machine health checking demonstrate as
much.

This provides a solution to the issue of silently changed or deleted
printks: we record pointers to all printk format strings known at
compile time into a new .printk_index section, both in vmlinux and
modules. At runtime, this can then be iterated by looking at
<debugfs>/printk/index/<module>, which emits the following format, both
readable by humans and able to be parsed by machines:

    $ head -1 vmlinux; shuf -n 5 vmlinux
    # <level[,flags]> filename:line function "format"
    <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
    <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
    <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
    <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
    <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"

This mitigates the majority of cases where we have a highly-specific
printk which we want to match on, as we can now enumerate and check
whether the format changed or the printk callsite disappeared entirely
in userspace. This allows us to catch changes to printks we monitor
earlier and decide what to do about it before it becomes problematic.

There is no additional runtime cost for printk callers or printk itself,
and the assembly generated is exactly the same.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS                          |   5 +
 arch/arm/kernel/entry-v7m.S          |   2 +-
 arch/arm/lib/backtrace-clang.S       |   2 +-
 arch/arm/lib/backtrace.S             |   2 +-
 arch/arm/mach-rpc/io-acorn.S         |   2 +-
 arch/arm/vfp/vfphw.S                 |   6 +-
 arch/ia64/include/uapi/asm/cmpxchg.h |   4 +-
 arch/openrisc/kernel/entry.S         |   6 +-
 arch/powerpc/kernel/head_fsl_booke.S |   2 +-
 arch/um/include/shared/user.h        |   3 +-
 arch/x86/kernel/head_32.S            |   2 +-
 include/asm-generic/vmlinux.lds.h    |  13 ++
 include/linux/module.h               |   5 +
 include/linux/printk.h               |  95 ++++++++++++-
 init/Kconfig                         |  14 ++
 kernel/module.c                      |   5 +
 kernel/printk/Makefile               |   1 +
 kernel/printk/index.c                | 195 +++++++++++++++++++++++++++
 kernel/printk/printk.c               |  13 +-
 19 files changed, 353 insertions(+), 24 deletions(-)
 create mode 100644 kernel/printk/index.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bcb7f4c9d74..557bf2588f5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14878,6 +14878,11 @@ S:	Maintained
 F:	include/linux/printk.h
 F:	kernel/printk/
 
+PRINTK INDEXING
+R:	Chris Down <chris@chrisdown.name>
+S:	Maintained
+F:	kernel/printk/index.c
+
 PRISM54 WIRELESS DRIVER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-wireless@vger.kernel.org
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index d0e898608d30..7bde93c10962 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -23,7 +23,7 @@ __invalid_entry:
 	adr	r0, strerr
 	mrs	r1, ipsr
 	mov	r2, lr
-	bl	printk
+	bl	_printk
 #endif
 	mov	r0, sp
 	bl	show_regs
diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
index 6174c45f53a5..5b2cdb1003e3 100644
--- a/arch/arm/lib/backtrace-clang.S
+++ b/arch/arm/lib/backtrace-clang.S
@@ -202,7 +202,7 @@ finished_setup:
 1006:		adr	r0, .Lbad
 		mov	r1, loglvl
 		mov	r2, frame
-		bl	printk
+		bl	_printk
 no_frame:	ldmfd	sp!, {r4 - r9, fp, pc}
 ENDPROC(c_backtrace)
 		.pushsection __ex_table,"a"
diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index 872f658638d9..e8408f22d4dc 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -103,7 +103,7 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 1006:		adr	r0, .Lbad
 		mov	r1, loglvl
 		mov	r2, frame
-		bl	printk
+		bl	_printk
 no_frame:	ldmfd	sp!, {r4 - r9, pc}
 ENDPROC(c_backtrace)
 		
diff --git a/arch/arm/mach-rpc/io-acorn.S b/arch/arm/mach-rpc/io-acorn.S
index b9082a2a2a01..aa9bf0d771c0 100644
--- a/arch/arm/mach-rpc/io-acorn.S
+++ b/arch/arm/mach-rpc/io-acorn.S
@@ -25,4 +25,4 @@ ENTRY(insl)
 ENTRY(outsl)
 		adr	r0, .Liosl_warning
 		mov	r1, lr
-		b	printk
+		b	_printk
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index d5837bf05a9a..6f7926c9c179 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -23,7 +23,7 @@
 #ifdef DEBUG
 	stmfd	sp!, {r0-r3, ip, lr}
 	ldr	r0, =1f
-	bl	printk
+	bl	_printk
 	ldmfd	sp!, {r0-r3, ip, lr}
 
 	.pushsection .rodata, "a"
@@ -38,7 +38,7 @@
 	stmfd	sp!, {r0-r3, ip, lr}
 	mov	r1, \arg
 	ldr	r0, =1f
-	bl	printk
+	bl	_printk
 	ldmfd	sp!, {r0-r3, ip, lr}
 
 	.pushsection .rodata, "a"
@@ -55,7 +55,7 @@
 	mov	r2, \arg2
 	mov	r1, \arg1
 	ldr	r0, =1f
-	bl	printk
+	bl	_printk
 	ldmfd	sp!, {r0-r3, ip, lr}
 
 	.pushsection .rodata, "a"
diff --git a/arch/ia64/include/uapi/asm/cmpxchg.h b/arch/ia64/include/uapi/asm/cmpxchg.h
index 926c6cb1e029..2c2f3cfeaa77 100644
--- a/arch/ia64/include/uapi/asm/cmpxchg.h
+++ b/arch/ia64/include/uapi/asm/cmpxchg.h
@@ -143,9 +143,9 @@ extern long ia64_cmpxchg_called_with_bad_pointer(void);
 do {									\
 	if (_cmpxchg_bugcheck_count-- <= 0) {				\
 		void *ip;						\
-		extern int printk(const char *fmt, ...);		\
+		extern int _printk(const char *fmt, ...);		\
 		ip = (void *) ia64_getreg(_IA64_REG_IP);		\
-		printk("CMPXCHG_BUGCHECK: stuck at %p on word %p\n", ip, (v));\
+		_printk("CMPXCHG_BUGCHECK: stuck at %p on word %p\n", ip, (v));\
 		break;							\
 	}								\
 } while (0)
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index bc657e55c15f..947613f61d4a 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -551,7 +551,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
 	l.movhi r3,hi(42f)
 	l.ori	r3,r3,lo(42f)
 	l.sw    0x0(r1),r3
-	l.jal   printk
+	l.jal   _printk
 	l.sw    0x4(r1),r4
 	l.addi  r1,r1,0x8
 
@@ -681,8 +681,8 @@ _syscall_debug:
 	l.sw    -4(r1),r27
 	l.sw    -8(r1),r11
 	l.addi  r1,r1,-8
-	l.movhi r27,hi(printk)
-	l.ori   r27,r27,lo(printk)
+	l.movhi r27,hi(_printk)
+	l.ori   r27,r27,lo(_printk)
 	l.jalr  r27
 	 l.nop
 	l.addi  r1,r1,8
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index a1a5c3f10dc4..08d7153ed04b 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -858,7 +858,7 @@ KernelSPE:
 	ori	r3,r3,87f@l
 	mr	r4,r2		/* current */
 	lwz	r5,_NIP(r1)
-	bl	printk
+	bl	_printk
 #endif
 	b	interrupt_return
 #ifdef CONFIG_PRINTK
diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index e793e4212f0a..dd4badffdeb3 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -38,7 +38,8 @@ extern void panic(const char *fmt, ...)
 #define UM_KERN_CONT	KERN_CONT
 
 #ifdef UML_CONFIG_PRINTK
-extern int printk(const char *fmt, ...)
+#define printk(...) _printk(__VA_ARGS__)
+extern int _printk(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 #else
 static inline int printk(const char *fmt, ...)
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 67f590425d90..d8c64dab0efe 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -432,7 +432,7 @@ SYM_FUNC_START(early_ignore_irq)
 	pushl 32(%esp)
 	pushl 40(%esp)
 	pushl $int_msg
-	call printk
+	call _printk
 
 	call dump_stack
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 17325416e2de..ddb2ff158321 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -483,6 +483,8 @@
 									\
 	TRACEDATA							\
 									\
+	PRINTK_INDEX							\
+									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
@@ -893,6 +895,17 @@
 #define TRACEDATA
 #endif
 
+#ifdef CONFIG_PRINTK_INDEX
+#define PRINTK_INDEX							\
+	.printk_index : AT(ADDR(.printk_index) - LOAD_OFFSET) {		\
+		__start_printk_index = .;				\
+		*(.printk_index)					\
+		__stop_printk_index = .;				\
+	}
+#else
+#define PRINTK_INDEX
+#endif
+
 #define NOTES								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
 		__start_notes = .;					\
diff --git a/include/linux/module.h b/include/linux/module.h
index 8a298d820dbc..c9f1200b2312 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -511,6 +511,11 @@ struct module {
 	struct klp_modinfo *klp_info;
 #endif
 
+#ifdef CONFIG_PRINTK_INDEX
+	unsigned int printk_index_size;
+	struct pi_entry **printk_index_start;
+#endif
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* What modules depend on me? */
 	struct list_head source_list;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index f589b8b60806..f116b6f6f994 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -173,12 +173,12 @@ asmlinkage __printf(1, 0)
 int vprintk(const char *fmt, va_list args);
 
 asmlinkage __printf(1, 2) __cold
-int printk(const char *fmt, ...);
+int _printk(const char *fmt, ...);
 
 /*
  * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
  */
-__printf(1, 2) __cold int printk_deferred(const char *fmt, ...);
+__printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
 
 /*
  * Please don't use printk_ratelimit(), because it shares ratelimiting state
@@ -217,12 +217,12 @@ int vprintk(const char *s, va_list args)
 	return 0;
 }
 static inline __printf(1, 2) __cold
-int printk(const char *s, ...)
+int _printk(const char *s, ...)
 {
 	return 0;
 }
 static inline __printf(1, 2) __cold
-int printk_deferred(const char *s, ...)
+int _printk_deferred(const char *s, ...)
 {
 	return 0;
 }
@@ -306,6 +306,93 @@ extern int kptr_restrict;
 #define pr_fmt(fmt) fmt
 #endif
 
+struct module;
+
+#ifdef CONFIG_PRINTK_INDEX
+struct pi_entry {
+	const char *fmt;
+	const char *func;
+	const char *file;
+	unsigned int line;
+
+	/*
+	 * While printk and pr_* have the level stored in the string at compile
+	 * time, some subsystems dynamically add it at runtime through the
+	 * format string. For these dynamic cases, we allow the subsystem to
+	 * tell us the level at compile time.
+	 *
+	 * NULL indicates that the level, if any, is stored in fmt.
+	 */
+	const char *level;
+
+	/*
+	 * The format string used by various subsystem specific printk()
+	 * wrappers to prefix the message.
+	 *
+	 * Note that the static prefix defined by the pr_fmt() macro is stored
+	 * directly in the message format (@fmt), not here.
+	 */
+	const char *subsys_fmt_prefix;
+} __packed;
+
+#define __printk_index_emit(_fmt, _level, _subsys_fmt_prefix)		\
+	do {								\
+		if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
+			/*
+			 * We check __builtin_constant_p multiple times here
+			 * for the same input because GCC will produce an error
+			 * if we try to assign a static variable to fmt if it
+			 * is not a constant, even with the outer if statement.
+			 */						\
+			static const struct pi_entry _entry		\
+			__used = {					\
+				.fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
+				.func = __func__,			\
+				.file = __FILE__,			\
+				.line = __LINE__,			\
+				.level = __builtin_constant_p(_level) ? (_level) : NULL, \
+				.subsys_fmt_prefix = _subsys_fmt_prefix,\
+			};						\
+			static const struct pi_entry *_entry_ptr	\
+			__used __section(".printk_index") = &_entry;	\
+		}							\
+	} while (0)
+
+#else /* !CONFIG_PRINTK_INDEX */
+#define __printk_index_emit(...) do {} while (0)
+#endif /* CONFIG_PRINTK_INDEX */
+
+/*
+ * Some subsystems have their own custom printk that applies a va_format to a
+ * generic format, for example, to include a device number or other metadata
+ * alongside the format supplied by the caller.
+ *
+ * In order to store these in the way they would be emitted by the printk
+ * infrastructure, the subsystem provides us with the start, fixed string, and
+ * any subsequent text in the format string.
+ *
+ * We take a variable argument list as pr_fmt/dev_fmt/etc are sometimes passed
+ * as multiple arguments (eg: `"%s: ", "blah"`), and we must only take the
+ * first one.
+ *
+ * subsys_fmt_prefix must be known at compile time, or compilation will fail
+ * (since this is a mistake). If fmt or level is not known at compile time, no
+ * index entry will be made (since this can legitimately happen).
+ */
+#define printk_index_subsys_emit(subsys_fmt_prefix, level, fmt, ...) \
+	__printk_index_emit(fmt, level, subsys_fmt_prefix)
+
+#define printk_index_wrap(_p_func, _fmt, ...)				\
+	({								\
+		__printk_index_emit(_fmt, NULL, NULL);			\
+		_p_func(_fmt, ##__VA_ARGS__);				\
+	})
+
+
+#define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
+#define printk_deferred(fmt, ...)					\
+	printk_index_wrap(_printk_deferred, fmt, ##__VA_ARGS__)
+
 /**
  * pr_emerg - Print an emergency-level message
  * @fmt: format string
diff --git a/init/Kconfig b/init/Kconfig
index 173a474012d7..f98283a851e4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -781,6 +781,20 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
 		     13 =>   8 KB for each CPU
 		     12 =>   4 KB for each CPU
 
+config PRINTK_INDEX
+	bool "Printk indexing debugfs interface"
+	depends on PRINTK && DEBUG_FS
+	help
+	  Add support for indexing of all printk formats known at compile time
+	  at <debugfs>/printk/index/<module>.
+
+	  This can be used as part of maintaining daemons which monitor
+	  /dev/kmsg, as it permits auditing the printk formats present in a
+	  kernel, allowing detection of cases where monitored printks are
+	  changed or no longer present.
+
+	  There is no additional runtime cost to printk with this enabled.
+
 #
 # Architectures with an unreliable sched_clock() should select this:
 #
diff --git a/kernel/module.c b/kernel/module.c
index 25dbdaf1f337..3ad43711941a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3351,6 +3351,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 						sizeof(unsigned long),
 						&mod->num_kprobe_blacklist);
 #endif
+#ifdef CONFIG_PRINTK_INDEX
+	mod->printk_index_start = section_objs(info, ".printk_index",
+					       sizeof(*mod->printk_index_start),
+					       &mod->printk_index_size);
+#endif
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 	mod->static_call_sites = section_objs(info, ".static_call_sites",
 					      sizeof(*mod->static_call_sites),
diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index eee3dc9b60a9..d118739874c0 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -3,3 +3,4 @@ obj-y	= printk.o
 obj-$(CONFIG_PRINTK)	+= printk_safe.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
 obj-$(CONFIG_PRINTK)	+= printk_ringbuffer.o
+obj-$(CONFIG_PRINTK_INDEX)	+= index.o
diff --git a/kernel/printk/index.c b/kernel/printk/index.c
new file mode 100644
index 000000000000..ca062f5e1779
--- /dev/null
+++ b/kernel/printk/index.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Userspace indexing of printk formats
+ */
+
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/string_helpers.h>
+
+#include "internal.h"
+
+extern struct pi_entry *__start_printk_index[];
+extern struct pi_entry *__stop_printk_index[];
+
+/* The base dir for module formats, typically debugfs/printk/index/ */
+static struct dentry *dfs_index;
+
+static struct pi_entry *pi_get_entry(const struct module *mod, loff_t pos)
+{
+	struct pi_entry **entries;
+	unsigned int nr_entries;
+
+#ifdef CONFIG_MODULES
+	if (mod) {
+		entries = mod->printk_index_start;
+		nr_entries = mod->printk_index_size;
+	}
+#endif
+
+	if (!mod) {
+		/* vmlinux, comes from linker symbols */
+		entries = __start_printk_index;
+		nr_entries = __stop_printk_index - __start_printk_index;
+	}
+
+	if (pos >= nr_entries)
+		return NULL;
+
+	return entries[pos];
+}
+
+static void *pi_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	const struct module *mod = s->file->f_inode->i_private;
+	struct pi_entry *entry = pi_get_entry(mod, *pos);
+
+	(*pos)++;
+
+	return entry;
+}
+
+static void *pi_start(struct seq_file *s, loff_t *pos)
+{
+	/*
+	 * Make show() print the header line. Do not update *pos because
+	 * pi_next() still has to return the entry at index 0 later.
+	 */
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+
+	return pi_next(s, NULL, pos);
+}
+
+/*
+ * We need both ESCAPE_ANY and explicit characters from ESCAPE_SPECIAL in @only
+ * because otherwise ESCAPE_NAP will cause double quotes and backslashes to be
+ * ignored for quoting.
+ */
+#define seq_escape_printf_format(s, src) \
+	seq_escape_str(s, src, ESCAPE_ANY | ESCAPE_NAP | ESCAPE_APPEND, "\"\\")
+
+static int pi_show(struct seq_file *s, void *v)
+{
+	const struct pi_entry *entry = v;
+	int level = LOGLEVEL_DEFAULT;
+	enum printk_info_flags flags = 0;
+	u16 prefix_len = 0;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(s, "# <level/flags> filename:line function \"format\"\n");
+		return 0;
+	}
+
+	if (!entry->fmt)
+		return 0;
+
+	if (entry->level)
+		printk_parse_prefix(entry->level, &level, &flags);
+	else
+		prefix_len = printk_parse_prefix(entry->fmt, &level, &flags);
+
+
+	if (flags & LOG_CONT) {
+		/*
+		 * LOGLEVEL_DEFAULT here means "use the same level as the
+		 * message we're continuing from", not the default message
+		 * loglevel, so don't display it as such.
+		 */
+		if (level == LOGLEVEL_DEFAULT)
+			seq_puts(s, "<c>");
+		else
+			seq_printf(s, "<%d,c>", level);
+	} else
+		seq_printf(s, "<%d>", level);
+
+	seq_printf(s, " %s:%d %s \"", entry->file, entry->line, entry->func);
+	if (entry->subsys_fmt_prefix)
+		seq_escape_printf_format(s, entry->subsys_fmt_prefix);
+	seq_escape_printf_format(s, entry->fmt + prefix_len);
+	seq_puts(s, "\"\n");
+
+	return 0;
+}
+
+static void pi_stop(struct seq_file *p, void *v) { }
+
+static const struct seq_operations dfs_index_sops = {
+	.start = pi_start,
+	.next  = pi_next,
+	.show  = pi_show,
+	.stop  = pi_stop,
+};
+
+DEFINE_SEQ_ATTRIBUTE(dfs_index);
+
+#ifdef CONFIG_MODULES
+static const char *pi_get_module_name(struct module *mod)
+{
+	return mod ? mod->name : "vmlinux";
+}
+#else
+static const char *pi_get_module_name(struct module *mod)
+{
+	return "vmlinux";
+}
+#endif
+
+void pi_create_file(struct module *mod)
+{
+	debugfs_create_file(pi_get_module_name(mod), 0444, dfs_index,
+				       mod, &dfs_index_fops);
+}
+
+void pi_remove_file(struct module *mod)
+{
+	debugfs_remove(debugfs_lookup(pi_get_module_name(mod), dfs_index));
+}
+
+#ifdef CONFIG_MODULES
+static int pi_module_notify(struct notifier_block *nb, unsigned long op,
+			    void *data)
+{
+	struct module *mod = data;
+
+	switch (op) {
+	case MODULE_STATE_COMING:
+		pi_create_file(mod);
+		break;
+	case MODULE_STATE_GOING:
+		pi_remove_file(mod);
+		break;
+	default: /* we don't care about other module states */
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block module_printk_fmts_nb = {
+	.notifier_call = pi_module_notify,
+};
+
+static void __init pi_setup_module_notifier(void)
+{
+	register_module_notifier(&module_printk_fmts_nb);
+}
+#else
+static inline void __init pi_setup_module_notifier(void) { }
+#endif
+
+static int __init pi_init(void)
+{
+	struct dentry *dfs_root = debugfs_create_dir("printk", NULL);
+
+	dfs_index = debugfs_create_dir("index", dfs_root);
+	pi_setup_module_notifier();
+	pi_create_file(NULL);
+
+	return 0;
+}
+
+/* debugfs comes up on core and must be initialised first */
+postcore_initcall(pi_init);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 26d52aea9969..085fb05c957a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2185,10 +2185,13 @@ int vprintk_default(const char *fmt, va_list args)
 EXPORT_SYMBOL_GPL(vprintk_default);
 
 /**
- * printk - print a kernel message
+ * _printk - print a kernel message
  * @fmt: format string
  *
- * This is printk(). It can be called from any context. We want it to work.
+ * This is _printk(). It can be called from any context. We want it to work.
+ *
+ * If printk indexing is enabled, _printk() is called from printk_index_wrap.
+ * Otherwise, printk is simply #defined to _printk.
  *
  * We try to grab the console_lock. If we succeed, it's easy - we log the
  * output and call the console drivers.  If we fail to get the semaphore, we
@@ -2205,7 +2208,7 @@ EXPORT_SYMBOL_GPL(vprintk_default);
  *
  * See the vsnprintf() documentation for format string extensions over C99.
  */
-asmlinkage __visible int printk(const char *fmt, ...)
+asmlinkage __visible int _printk(const char *fmt, ...)
 {
 	va_list args;
 	int r;
@@ -2216,7 +2219,7 @@ asmlinkage __visible int printk(const char *fmt, ...)
 
 	return r;
 }
-EXPORT_SYMBOL(printk);
+EXPORT_SYMBOL(_printk);
 
 #else /* CONFIG_PRINTK */
 
@@ -3201,7 +3204,7 @@ int vprintk_deferred(const char *fmt, va_list args)
 	return r;
 }
 
-int printk_deferred(const char *fmt, ...)
+int _printk_deferred(const char *fmt, ...)
 {
 	va_list args;
 	int r;
-- 
2.31.1

