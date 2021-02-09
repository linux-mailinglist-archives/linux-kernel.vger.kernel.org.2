Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5A315180
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhBIOYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhBIOYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:24:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D5EC061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:24:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z22so23824135edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AzZclBH5FLuk/isM2UysjI+okfFrcAwFDiGcFX48dMw=;
        b=nTz8F2xdgN9WkI0bPW167x73arc32Xw/VQ19IfCcfsTzJEn+kMvL/s2vpNmk+wBAi5
         pcMbqGQ7lCvu9179oGZPmefI1Emiyb7IKRtWAWgLzXju0zixekR1Qhyq2n7Z8JtJetvt
         4ajTdwtB5PegHWouL87VuYNPyW0UYoyjrP1LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AzZclBH5FLuk/isM2UysjI+okfFrcAwFDiGcFX48dMw=;
        b=aY7NvEC4m7YkqPS0i7U31htNRIASnzsBMmEhpKBC5/id1v5nymBDeRCSDxyGycWcsD
         snw4tw/F/aIlORZeXAakP/9cmTp6NT9b0fF1x57D2dkZIqRp5m77LoBINLYmCv7yo5fD
         NthjHjVYjwoFg9n0ZXrGK76dgBwrQf6/WiaFf4akVJa6TdOI94wBEB6Zx/1rijE2aVMG
         kx2Y7xqyNUoIxr9dVxxtN05pd2VnNCOv+8mTCfftG3LaQXf0XzsH6oOLBzaiRUPzFGrK
         /DZdelDWL51s8PeWJ0+9RtnoMBF1yk0AmTplHdPM+epFswjStco0eCtofx9LaU6gTmXQ
         nwRQ==
X-Gm-Message-State: AOAM531WfcUcHT930RxgLVBqnVtsaSTUHdVb+S/dleAEXtUn+KMcE6BY
        jT4z2Dxkfu8gl1gTErzDrK2CfPkJ/IaKgrXU
X-Google-Smtp-Source: ABdhPJwdrBO/92qOS/8JrYGOuF7p5V3IfYeJD9tSJlj0NWT7Xk/XuVv3MEB4c+wonBV6+h9ru2/AJg==
X-Received: by 2002:aa7:d310:: with SMTP id p16mr8479601edq.140.1612880641987;
        Tue, 09 Feb 2021 06:24:01 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id p16sm10782893eja.109.2021.02.09.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:24:01 -0800 (PST)
Date:   Tue, 9 Feb 2021 14:24:01 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: [PATCH v3] printk: Userspace format enumeration support
Message-ID: <YCKbAfE+gA6ftKne@chrisdown.name>
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
<debugfs>/printk/formats/<module>, which emits the same format as
`printk` itself, which we already export elsewhere (for example, in
netconsole).

As an example of how simple a parser for this format can be:

    $ cat pf.py
    #!/usr/bin/env python
    with open("/sys/kernel/debug/printk/formats/vmlinux") as f:
        raw_fmts = f.read().split("\x00")[:-1]
        for raw_fmt in raw_fmts:
            level, fmt = raw_fmt[1], raw_fmt[2:]
            print(f"Level {level}: {fmt!r}")

    $ ./pf.py | shuf -n 5
    Level 4: 'Build ID is too large to include in vmcoreinfo: %u > %u\n'
    Level 3: 'BIOS bug, no explicit IRQ entries, using default mptable. (tell your hw vendor)\n'
    Level 3: 'Failed to execute %s (error %d)\n'
    Level 3: 'CHRDEV "%s" minor range requested (%u-%u) is out of range of maximum range (%u-%u) for a single major\n'
    Level 3: "slub_debug option '%c' unknown. skipped\n"

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
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

---

v2:

- Use seq_printf instead of step by step accumulation
- Scope fptr closer to its use
- Prevent seq_file from needing to alloc a new buffer
- Always provide KERN_SOH + level, even if caller omitted it
- Provide one file per module
- Update changelog to show ease of parsing
- Provide printk -> _printk for ARCH=um (thanks, LKP robot)
- Move to debugfs (thanks, Steven)

---

v3:

- Reduce locking during open by moving size lifetime to the inode
- Don't explicitly check for debugfs errors (thanks, gregkh)
---
 arch/arm/kernel/entry-v7m.S          |   2 +-
 arch/arm/lib/backtrace-clang.S       |   2 +-
 arch/arm/lib/backtrace.S             |   2 +-
 arch/arm/mach-rpc/io-acorn.S         |   2 +-
 arch/arm/vfp/vfphw.S                 |   6 +-
 arch/openrisc/kernel/entry.S         |   6 +-
 arch/powerpc/kernel/head_fsl_booke.S |   2 +-
 arch/um/include/shared/user.h        |   3 +-
 arch/x86/kernel/head_32.S            |   2 +-
 include/asm-generic/vmlinux.lds.h    |  13 ++
 include/linux/module.h               |   5 +
 include/linux/printk.h               |  43 ++++-
 init/Kconfig                         |  14 ++
 kernel/module.c                      |   5 +
 kernel/printk/printk.c               | 231 ++++++++++++++++++++++++++-
 15 files changed, 316 insertions(+), 22 deletions(-)

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
index d3c08095a9a3..4aebb96c3694 100644
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
+			 * The compiler may not be able to eliminate this, so
+			 * we need to make sure that it doesn't see any
+			 * hypothetical assignment for non-constants even
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
index ab2e916f7e8b..f1f37a060235 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -764,6 +764,20 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
 		     13 =>   8 KB for each CPU
 		     12 =>   4 KB for each CPU
 
+config PRINTK_ENUMERATION
+	bool "Printk enumeration debugfs interface"
+	depends on PRINTK && DEBUG_FS
+	help
+	  Add support for enumeration of all printk formats known at compile
+	  time at <debugfs>/printk/formats/<module>.
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
index 1e5aad812310..7b0f2a2f428e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3429,6 +3429,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
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
index 5a95c688621f..adf545ba9eb9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -47,6 +47,8 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/debugfs.h>
+#include <linux/hashtable.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -617,6 +619,222 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return len;
 }
 
+#ifdef CONFIG_PRINTK_ENUMERATION
+
+/*
+ * debugfs/printk/formats/ - userspace enumeration of printk formats
+ *
+ * The format is the same as typically used by printk, <KERN_SOH><level>fmt,
+ * with each distinct format separated by \0.
+ */
+
+struct printk_fmt_sec {
+	struct hlist_node hnode;
+	struct module *module;
+	struct dentry *file;
+	const char **start;
+	const char **end;
+};
+
+/* The base dir for module formats, typically debugfs/printk/formats/ */
+struct dentry *dfs_formats;
+
+/*
+ * Stores .printk_fmt section boundaries for vmlinux and all loaded modules.
+ * Add entries with store_printk_fmt_sec, remove entries with
+ * remove_printk_fmt_sec.
+ */
+static DEFINE_HASHTABLE(printk_fmts_mod_sections, 8);
+
+/* Protects printk_fmts_mod_sections */
+static DEFINE_MUTEX(printk_fmts_mutex);
+
+static const char *ps_get_module_name(const struct printk_fmt_sec *ps);
+static int debugfs_pf_open(struct inode *inode, struct file *file);
+
+static const struct file_operations dfs_formats_fops = {
+	.open    = debugfs_pf_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+
+static size_t printk_fmt_size(const char *fmt)
+{
+	size_t sz = strlen(fmt) + 1;
+
+	/*
+	 * Some printk formats don't start with KERN_SOH + level. We will add
+	 * it later when rendering the output.
+	 */
+	if (unlikely(fmt[0] != KERN_SOH_ASCII))
+		sz += 2;
+
+	return sz;
+}
+
+static struct printk_fmt_sec *find_printk_fmt_sec(struct module *mod)
+{
+	struct printk_fmt_sec *ps = NULL;
+
+	hash_for_each_possible(printk_fmts_mod_sections, ps, hnode,
+			       (unsigned long)mod)
+		if (ps->module == mod)
+			return ps;
+
+	return NULL;
+}
+
+static void store_printk_fmt_sec(struct module *mod, const char **start,
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
+		size += printk_fmt_size(*fptr);
+
+	mutex_lock(&printk_fmts_mutex);
+	hash_add(printk_fmts_mod_sections, &ps->hnode, (unsigned long)mod);
+	mutex_unlock(&printk_fmts_mutex);
+
+	ps->file = debugfs_create_file(ps_get_module_name(ps), 0444,
+				       dfs_formats, mod, &dfs_formats_fops);
+
+	if (!IS_ERR(ps->file))
+		d_inode(ps->file)->i_size = size;
+}
+
+#ifdef CONFIG_MODULES
+static void remove_printk_fmt_sec(struct module *mod)
+{
+	struct printk_fmt_sec *ps = NULL;
+
+	if (WARN_ON_ONCE(!mod))
+		return;
+
+	mutex_lock(&printk_fmts_mutex);
+
+	ps = find_printk_fmt_sec(mod);
+	if (!ps) {
+		mutex_unlock(&printk_fmts_mutex);
+		return;
+	}
+
+	hash_del(&ps->hnode);
+
+	mutex_unlock(&printk_fmts_mutex);
+
+	debugfs_remove(ps->file);
+	kfree(ps);
+}
+
+static int module_printk_fmts_notify(struct notifier_block *self,
+				     unsigned long val, void *data)
+{
+	struct module *mod = data;
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
+static int debugfs_pf_show(struct seq_file *s, void *v)
+{
+	struct module *mod = s->file->f_inode->i_private;
+	struct printk_fmt_sec *ps = NULL;
+	const char **fptr = NULL;
+	int ret = 0;
+
+	mutex_lock(&printk_fmts_mutex);
+
+	/*
+	 * The entry might have been invalidated in the hlist between _open and
+	 * _show, so we need to eyeball the entries under printk_fmts_mutex
+	 * again.
+	 */
+	ps = find_printk_fmt_sec(mod);
+	if (unlikely(!ps)) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	for (fptr = ps->start; fptr < ps->end; fptr++) {
+		/* For callsites without KERN_SOH + level preamble. */
+		if (unlikely(*fptr[0] != KERN_SOH_ASCII))
+			seq_printf(s, "%c%d", KERN_SOH_ASCII,
+				   MESSAGE_LOGLEVEL_DEFAULT);
+		seq_printf(s, "%s%c", *fptr, '\0');
+	}
+
+out_unlock:
+	mutex_unlock(&printk_fmts_mutex);
+	return ret;
+}
+
+static int debugfs_pf_open(struct inode *inode, struct file *file)
+{
+	return single_open_size(file, debugfs_pf_show, NULL, inode->i_size);
+}
+
+static int __init init_printk_fmts(void)
+{
+	struct dentry *dfs_root = debugfs_create_dir("printk", NULL);
+
+	dfs_formats = debugfs_create_dir("formats", dfs_root);
+	store_printk_fmt_sec(NULL, __start_printk_fmts, __stop_printk_fmts);
+
+	return 0;
+}
+
+core_initcall(init_printk_fmts);
+
+#endif /* CONFIG_PRINTK_ENUMERATION */
+
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	u64 seq;
@@ -2111,10 +2329,13 @@ int vprintk_default(const char *fmt, va_list args)
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
@@ -2131,7 +2352,7 @@ EXPORT_SYMBOL_GPL(vprintk_default);
  *
  * See the vsnprintf() documentation for format string extensions over C99.
  */
-asmlinkage __visible int printk(const char *fmt, ...)
+asmlinkage __visible int _printk(const char *fmt, ...)
 {
 	va_list args;
 	int r;
@@ -2142,7 +2363,7 @@ asmlinkage __visible int printk(const char *fmt, ...)
 
 	return r;
 }
-EXPORT_SYMBOL(printk);
+EXPORT_SYMBOL(_printk);
 
 #else /* CONFIG_PRINTK */
 
@@ -3133,7 +3354,7 @@ int vprintk_deferred(const char *fmt, va_list args)
 	return r;
 }
 
-int printk_deferred(const char *fmt, ...)
+int _printk_deferred(const char *fmt, ...)
 {
 	va_list args;
 	int r;
-- 
2.30.0

