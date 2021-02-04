Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C766130F69A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbhBDPl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbhBDPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:38:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5310C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:37:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c127so3352861wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eN02A+mG8vRtyTaqry/W6yxty0jAVyWECrsaMROhQjA=;
        b=WLGhbae0w2c1gffuyiZxDHGGs9NMDK+DkKuMdtLUvbyQyqBI0oC9yqsTKrYI7rDhwg
         y5TN579SxHguWbuVj/bIWqpMFAR8Kyaf3L3B/a68Ad6z9EYz2eMykQrs0IM1egNTHOg9
         Wexn6TKs2zxHtrpsBHg+C3Du5y2r6seqgCIJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eN02A+mG8vRtyTaqry/W6yxty0jAVyWECrsaMROhQjA=;
        b=UuUVvStO2FtP5EczIwe6LL80dODB92zuECB2bFBTeqNgIEs/cHUqTCNSDY34u60u/H
         ZKLliZMZmGR6KCh605mSO7h3wQDbhHoE122MHLF7CkSdRC3w366G/9UeeDWL+Hi+q2UZ
         icNvC+x8KAQWoYJYF/KHY0/LjBKPSp4C8jWeZmtYFwPVWUlA98jyWo/kcbk+SB1YnAgc
         5Bzx6zmQGxVMfr5qZUfHNThLsok+AbRyquchcF45mw/BXaXAniz8UNfzqIVYoOw87x4d
         a5tqKCVFRnIVP9G+QZN0yCzD7RHOhtxfrKz6t5qdxMvqnuxK6ZyIv86q/i1tdMO/FMoK
         cS5g==
X-Gm-Message-State: AOAM531SGIurHAwAr3RIRMwV7FC6luAY3Ee6plDmDkOyUDIa2dr9bFcr
        Xl+3yrxQ68apGcUm3Y+m7EiRBish69gRIx6Y
X-Google-Smtp-Source: ABdhPJwnjwd2xQHngs9YxDGGOODxKUYnMQHFj9D/mpb/OFzGauLrKa2ck+ng7ndkZlnH6Em4CS/s+Q==
X-Received: by 2002:a1c:7711:: with SMTP id t17mr124893wmi.64.1612453073189;
        Thu, 04 Feb 2021 07:37:53 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id k4sm9297051wrm.53.2021.02.04.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:37:52 -0800 (PST)
Date:   Thu, 4 Feb 2021 15:37:52 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com
Subject: [PATCH] printk: Userspace format enumeration support
Message-ID: <YBwU0G+P0vb9wTwm@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
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

As you'd expect, monitoring using printk is rather brittle for a number
of reasons -- most notably that the message might disappear entirely in
a new version of the kernel, or that the message may change in some way
that the regex or other classification methods start to silently fail.

One factor that makes this even harder is that, under normal operation,
many of these messages are never expected to be hit. For example, there
may be some rare hardware bug which you want to detect if it was to ever
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

This patch provides a solution to the issue of silently changed or
deleted printks: we record pointers to all printk format strings known
at compile time into a new .printk_fmts section, both in vmlinux and
modules. At runtime, this can then be iterated by looking at
/proc/printk_formats, which emits the same format as `printk` itself,
which we already export elsewhere (for example, in netconsole):

    # Format: <module>,<facility><level><format>\0
    $ perl -p -e 's/\n/\\n/g;s/\0/\n/g' /proc/printk_formats | shuf -n 5
    vmlinux,6Disabling APIC timer\n
    intel_rapl_common,3intel_rapl_common: Cannot find matching power limit for constraint %d\n
    dm_crypt,3device-mapper: crypt: %s: INTEGRITY AEAD ERROR, sector %llu\n
    mac80211,6%s: AP bug: HT capability missing from AssocResp\n
    vmlinux,3zpool: couldn't create zpool - out of memory\n

This mitigates the majority of cases where we have a highly-specific
printk which we want to match on, as we can now enumerate and check
whether the format changed or the printk callsite disappeared entirely
in userspace. This allows us to catch changes to printks we monitor
earlier and decide what to do about it before it becomes problematic.

There is no additional runtime cost for printk callers or printk itself,
and the assembly generated is exactly the same.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arm/kernel/entry-v7m.S          |   2 +-
 arch/arm/lib/backtrace-clang.S       |   2 +-
 arch/arm/lib/backtrace.S             |   2 +-
 arch/arm/mach-rpc/io-acorn.S         |   2 +-
 arch/arm/vfp/vfphw.S                 |   6 +-
 arch/openrisc/kernel/entry.S         |   6 +-
 arch/powerpc/kernel/head_fsl_booke.S |   2 +-
 arch/x86/kernel/head_32.S            |   2 +-
 include/asm-generic/vmlinux.lds.h    |  13 ++
 include/linux/module.h               |   5 +
 include/linux/printk.h               |  43 +++++-
 init/Kconfig                         |  15 ++
 kernel/module.c                      |   5 +
 kernel/printk/printk.c               | 196 ++++++++++++++++++++++++++-
 14 files changed, 280 insertions(+), 21 deletions(-)

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
index fdd4d274c245..f2c7ecef9b14 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -852,7 +852,7 @@ KernelSPE:
 	ori	r3,r3,87f@l
 	mr	r4,r2		/* current */
 	lwz	r5,_NIP(r1)
-	bl	printk
+	bl	_printk
 #endif
 	b	ret_from_except
 #ifdef CONFIG_PRINTK
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 7ed84c282233..c207b789dd22 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -446,7 +446,7 @@ SYM_FUNC_START(early_ignore_irq)
 	pushl 32(%esp)
 	pushl 40(%esp)
 	pushl $int_msg
-	call printk
+	call _printk
 
 	call dump_stack
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 34b7e0d2346c..0ca6e28e05d6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -309,6 +309,17 @@
 #define ACPI_PROBE_TABLE(name)
 #endif
 
+#ifdef CONFIG_PRINTK_ENUMERATION
+#define PRINTK_FMTS							\
+	.printk_fmts : AT(ADDR(.printk_fmts) - LOAD_OFFSET) {		\
+		__start_printk_fmts = .;				\
+		*(.printk_fmts)						\
+		__stop_printk_fmts = .;					\
+	}
+#else
+#define PRINTK_FMTS
+#endif
+
 #ifdef CONFIG_THERMAL
 #define THERMAL_TABLE(name)						\
 	. = ALIGN(8);							\
@@ -480,6 +491,8 @@
 									\
 	TRACEDATA							\
 									\
+	PRINTK_FMTS							\
+									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
diff --git a/include/linux/module.h b/include/linux/module.h
index 7a0bcb5b1ffc..4235b14a22ef 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -516,6 +516,11 @@ struct module {
 	struct klp_modinfo *klp_info;
 #endif
 
+#ifdef CONFIG_PRINTK_ENUMERATION
+	unsigned int printk_fmts_sec_size;
+	const char **printk_fmts_start;
+#endif
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* What modules depend on me? */
 	struct list_head source_list;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index d3c08095a9a3..745a9915ec72 100644
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
@@ -216,12 +216,12 @@ int vprintk(const char *s, va_list args)
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
@@ -284,6 +284,11 @@ static inline void printk_safe_flush_on_panic(void)
 
 extern int kptr_restrict;
 
+#ifdef CONFIG_PRINTK_ENUMERATION
+extern const char *__start_printk_fmts[];
+extern const char *__stop_printk_fmts[];
+#endif
+
 /**
  * pr_fmt - used by the pr_*() macros to generate the printk format string
  * @fmt: format string passed from a pr_*() macro
@@ -301,6 +306,36 @@ extern int kptr_restrict;
 #define pr_fmt(fmt) fmt
 #endif
 
+#ifdef CONFIG_PRINTK_ENUMERATION
+#define printk_store_fmt(func, fmt, ...)				       \
+	({								       \
+		int _printk_ret;					       \
+									       \
+		if (__builtin_constant_p(fmt)) {			       \
+			/*
+			 * The compiler may not be able to eliminate this
+			 * branch, so we need to make sure that it doesn't see
+			 * any hypothetical assignment for non-constants even
+			 * though this is already inside the
+			 * __builtin_constant_p guard.
+			 */						       \
+			static const char *_fmt __section(".printk_fmts") =    \
+				__builtin_constant_p(fmt) ? fmt : NULL;	       \
+			_printk_ret = func(_fmt, ##__VA_ARGS__);	       \
+		} else							       \
+			_printk_ret = func(fmt, ##__VA_ARGS__);		       \
+									       \
+		_printk_ret;						       \
+	})
+
+#define printk(fmt, ...) printk_store_fmt(_printk, fmt, ##__VA_ARGS__)
+#define printk_deferred(fmt, ...)					       \
+	printk_store_fmt(_printk_deferred, fmt, ##__VA_ARGS__)
+#else /* !CONFIG_PRINTK_ENUMERATION */
+#define printk(...) _printk(__VA_ARGS__)
+#define printk_deferred(...) _printk_deferred(__VA_ARGS__)
+#endif /* CONFIG_PRINTK_ENUMERATION */
+
 /**
  * pr_emerg - Print an emergency-level message
  * @fmt: format string
diff --git a/init/Kconfig b/init/Kconfig
index e4e2932da237..d0839e901267 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -764,6 +764,21 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
 		     13 =>   8 KB for each CPU
 		     12 =>   4 KB for each CPU
 
+config PRINTK_ENUMERATION
+	bool "/proc/printk_formats support"
+	depends on PRINTK
+	help
+	  Add support for enumeration of all printk formats known at compile
+	  time at /proc/printk_formats. This includes printk formats built into
+	  the kernel, and those in loaded modules.
+
+	  This can be used as part of maintaining daemons which monitor
+	  /dev/kmsg, as it permits auditing the printk formats present in a
+	  kernel, allowing monitoring of cases where monitored printks are
+	  changed or no longer present.
+
+	  There is no additional runtime cost to printk with this enabled.
+
 #
 # Architectures with an unreliable sched_clock() should select this:
 #
diff --git a/kernel/module.c b/kernel/module.c
index 6ad424f07a4a..143f00545202 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3430,6 +3430,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 						sizeof(unsigned long),
 						&mod->num_kprobe_blacklist);
 #endif
+#ifdef CONFIG_PRINTK_ENUMERATION
+	mod->printk_fmts_start = section_objs(info, ".printk_fmts",
+					      sizeof(*mod->printk_fmts_start),
+					      &mod->printk_fmts_sec_size);
+#endif
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 	mod->static_call_sites = section_objs(info, ".static_call_sites",
 					      sizeof(*mod->static_call_sites),
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6639a0cfe0ac..57142f126a1b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -47,6 +47,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/proc_fs.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -617,6 +618,188 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return len;
 }
 
+#ifdef CONFIG_PRINTK_ENUMERATION
+
+/* /proc/printk_formats - userspace enumeration of printk formats  */
+
+struct printk_fmt_sec {
+	struct list_head list;
+	const struct module *module;
+	const char **start;
+	const char **end;
+};
+
+/*
+ * Stores .printk_fmt section boundaries for vmlinux and all loaded modules.
+ * Add entries with store_printk_fmt_sec, remove entries with
+ * remove_printk_fmt_sec.
+ */
+static LIST_HEAD(printk_fmts_list);
+
+/*
+ * To prevent mutation, hold printk_fmts_mutex. If mutation is acceptable, this
+ * can be read at any time without the mutex as long as it is read with
+ * protection against data tearing.
+ */
+static size_t printk_fmts_total_size;
+
+/* For printk_fmts_list and printk_fmts_total_size. */
+static DEFINE_MUTEX(printk_fmts_mutex);
+
+static void store_printk_fmt_sec(const struct module *mod, const char **start,
+				 const char **end)
+{
+	struct printk_fmt_sec *ps = NULL;
+	const char **fptr = NULL;
+	size_t size = 0;
+
+	ps = kmalloc(sizeof(struct printk_fmt_sec), GFP_KERNEL);
+	if (!ps)
+		return;
+
+	ps->module = mod;
+	ps->start = start;
+	ps->end = end;
+
+	for (fptr = ps->start; fptr < ps->end; fptr++)
+		size += strlen(*fptr) + 1;
+
+	mutex_lock(&printk_fmts_mutex);
+	WRITE_ONCE(printk_fmts_total_size, printk_fmts_total_size + size);
+	list_add_tail(&ps->list, &printk_fmts_list);
+	mutex_unlock(&printk_fmts_mutex);
+}
+
+#ifdef CONFIG_MODULES
+
+static void remove_printk_fmt_sec(const struct module *mod)
+{
+	struct printk_fmt_sec *tmp = NULL, *ps = NULL;
+	const char **fptr = NULL;
+
+	if (WARN_ON_ONCE(!mod))
+		return;
+
+	mutex_lock(&printk_fmts_mutex);
+
+	list_for_each_entry_safe(ps, tmp, &printk_fmts_list, list) {
+		if (ps->module == mod) {
+			size_t new_size = printk_fmts_total_size;
+
+			for (fptr = ps->start; fptr < ps->end; fptr++)
+				new_size -= strlen(*fptr) + 1;
+
+			WRITE_ONCE(printk_fmts_total_size, new_size);
+			list_del(&ps->list);
+			kfree(ps);
+			break;
+		}
+	}
+
+	mutex_unlock(&printk_fmts_mutex);
+}
+
+static int module_printk_fmts_notify(struct notifier_block *self,
+				     unsigned long val, void *data)
+{
+	const struct module *mod = data;
+
+	if (mod->printk_fmts_sec_size) {
+		switch (val) {
+		case MODULE_STATE_COMING:
+			store_printk_fmt_sec(mod, mod->printk_fmts_start,
+					     mod->printk_fmts_start +
+						     mod->printk_fmts_sec_size);
+			break;
+
+		case MODULE_STATE_GOING:
+			remove_printk_fmt_sec(mod);
+			break;
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static const char *ps_get_module_name(const struct printk_fmt_sec *ps)
+{
+	return ps->module ? ps->module->name : "vmlinux";
+}
+
+static struct notifier_block module_printk_fmts_nb = {
+	.notifier_call = module_printk_fmts_notify,
+};
+
+static int __init module_printk_fmts_init(void)
+{
+	return register_module_notifier(&module_printk_fmts_nb);
+}
+
+core_initcall(module_printk_fmts_init);
+
+#else /* !CONFIG_MODULES */
+static const char *ps_get_module_name(const struct printk_fmt_sec *ps)
+{
+	return "vmlinux";
+}
+#endif /* CONFIG_MODULES */
+
+static int proc_pf_show(struct seq_file *s, void *v)
+{
+	const struct printk_fmt_sec *ps = NULL;
+	const char **fptr = NULL;
+
+	mutex_lock(&printk_fmts_mutex);
+
+	list_for_each_entry(ps, &printk_fmts_list, list) {
+		const char *mod_name = ps_get_module_name(ps);
+
+		for (fptr = ps->start; fptr < ps->end; fptr++) {
+			seq_puts(s, mod_name);
+			seq_putc(s, ',');
+			seq_puts(s, *fptr);
+			seq_putc(s, '\0');
+		}
+	}
+
+	mutex_unlock(&printk_fmts_mutex);
+
+	return 0;
+}
+
+static int proc_pf_open(struct inode *inode, struct file *file)
+{
+	/*
+	 * We don't need to hold the mutex here to ensure that
+	 * printk_fmts_total_size doesn't change prior to iteration -- worst
+	 * case, seq_read_iter() will reallocate.
+	 */
+	return single_open_size(file, proc_pf_show, NULL,
+		READ_ONCE(printk_fmts_total_size));
+}
+
+static const struct proc_ops printk_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
+	.proc_open	= proc_pf_open,
+	.proc_read_iter	= seq_read_iter,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+};
+
+static int __init init_printk_fmts(void)
+{
+	const struct proc_dir_entry *pd = NULL;
+
+	store_printk_fmt_sec(NULL, __start_printk_fmts, __stop_printk_fmts);
+	pd = proc_create("printk_formats", 0, NULL, &printk_proc_ops);
+
+	return pd ? 0 : -ENOMEM;
+}
+
+core_initcall(init_printk_fmts);
+
+#endif /* CONFIG_PRINTK_ENUMERATION */
+
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	u64 seq;
@@ -2111,10 +2294,13 @@ int vprintk_default(const char *fmt, va_list args)
 EXPORT_SYMBOL_GPL(vprintk_default);
 
 /**
- * printk - print a kernel message
+ * _printk - print a kernel message
  * @fmt: format string
  *
- * This is printk(). It can be called from any context. We want it to work.
+ * This is _printk(). It can be called from any context. We want it to work.
+ *
+ * If printk enumeration is enabled, _printk() is called from printk_store_fmt.
+ * Otherwise, printk is simply #defined to _printk.
  *
  * We try to grab the console_lock. If we succeed, it's easy - we log the
  * output and call the console drivers.  If we fail to get the semaphore, we
@@ -2131,7 +2317,7 @@ EXPORT_SYMBOL_GPL(vprintk_default);
  *
  * See the vsnprintf() documentation for format string extensions over C99.
  */
-asmlinkage __visible int printk(const char *fmt, ...)
+asmlinkage __visible int _printk(const char *fmt, ...)
 {
 	va_list args;
 	int r;
@@ -2142,7 +2328,7 @@ asmlinkage __visible int printk(const char *fmt, ...)
 
 	return r;
 }
-EXPORT_SYMBOL(printk);
+EXPORT_SYMBOL(_printk);
 
 #else /* CONFIG_PRINTK */
 
@@ -3133,7 +3319,7 @@ int vprintk_deferred(const char *fmt, va_list args)
 	return r;
 }
 
-int printk_deferred(const char *fmt, ...)
+int _printk_deferred(const char *fmt, ...)
 {
 	va_list args;
 	int r;
-- 
2.30.0

