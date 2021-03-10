Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60CB333323
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhCJCbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCJCaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:30:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F86C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 18:30:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y124-20020a1c32820000b029010c93864955so9203284wmy.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 18:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VOvGpTGdNXjs69vue6GazQw4OYX2Z7sPNn8la0bSNZI=;
        b=buew+WoE2tExUB3ueMrMnWPRZXNeJrxh9doJWPGjrcODdoxM8/DgecRXRAcC/jOIbI
         JTvGjfbQfzCq3szu23bLCXqAfgmb66cPNrCIXKB/iwPeDeI+MQzq6cDM4Rea2o2Z19kJ
         oajM4bVvWQn3AXWcRRyOEQgycb07MwtZ0hHJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VOvGpTGdNXjs69vue6GazQw4OYX2Z7sPNn8la0bSNZI=;
        b=VakAGNxx1G4O1u4t8wVo/afPI6HftLlrESLHOgyA4EtWFpR9z6I86tPm3T1FSBx4mq
         wEEiod5iq52rqXvOqHKrXxsGSpcM90QhsUp/ZpnK5AwhOJDMYkJ2lNB4cjqlCfmbGzWL
         Sx2l96/0whKq8QaX/JA72dxD7aVpHYD8qQeBKk8+e+Ur/xS9qStHux8s3jeEIlWYyyaB
         kN/qj9jdBxJeH7snXYwYUAN/9O0aZyvCPBzsOP/QN5NA5oMdGytSAyiNzEywBmq1ZlsK
         tSOA4hSU6Q7Yhgt0fpfAvjDQPIOfMxr8u00FZw9zzz3pUvsrKTg7bggTMKJ0UUhjqenY
         KEDQ==
X-Gm-Message-State: AOAM530FPpXHB275Mkg52jeaCDKL9MVuoO3SVLjznp3yoip43dCGJuco
        MKFz5CkZ6ghpS/GEwCOnUYHTm1iTHBsTRaWQ
X-Google-Smtp-Source: ABdhPJxWCvadihu7sRMpvUNYDksOW0eV4n90SD/lf4cJ/pFICq4pMvVaLE4o2TnAfaXynZT/rZsYOA==
X-Received: by 2002:a1c:4143:: with SMTP id o64mr839342wma.50.1615343432329;
        Tue, 09 Mar 2021 18:30:32 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id h25sm1485548wml.32.2021.03.09.18.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:30:31 -0800 (PST)
Date:   Wed, 10 Mar 2021 02:30:31 +0000
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
Subject: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YEgvR6Wc1xt0qupy@chrisdown.name>
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

This patch provides a solution to the issue of silently changed or
deleted printks: we record pointers to all printk format strings known
at compile time into a new .printk_index section, both in vmlinux and
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

v4:

- Fix a missed `extern int printk` fixup in ia64 (thanks, lkp)

---

v5:

Thanks Petr for the extensive feedback.

- Move all module handling from module notifier to module.[ch] directly
- Change to readable output format
  - Handled by new string_escape(ESCAPE_PRINTF)
- Add file/line/function information
- Mass rename everything to printk_index/CONFIG_PRINTK_INDEX/pi_*
  - As a result, this version does away with the mutex/hashtable
- Use seq_file iteration API instead of simple_open
- Remove debugfs file first to avoid ENOENT
- Tear down backing datastructure if debugfs file creation fails
- Move code under ifdef guard to kernel/printk/index.c
- Add pi_sec (formerly printk_fmt_sec) documentation
- Handle coexisting LOG_CONT + level
- Add header to debugfs output
- ...and probably some other stuff I forgot. :-)
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
 fs/seq_file.c                        |  21 +++
 include/asm-generic/vmlinux.lds.h    |  13 ++
 include/linux/module.h               |   6 +
 include/linux/printk.h               |  72 ++++++++++-
 include/linux/seq_file.h             |   1 +
 include/linux/string_helpers.h       |   2 +
 init/Kconfig                         |  14 ++
 kernel/module.c                      |  14 +-
 kernel/printk/Makefile               |   1 +
 kernel/printk/index.c                | 183 +++++++++++++++++++++++++++
 kernel/printk/printk.c               |  20 ++-
 lib/string_helpers.c                 |  29 ++++-
 lib/test-string_helpers.c            |   6 +
 24 files changed, 386 insertions(+), 32 deletions(-)
 create mode 100644 kernel/printk/index.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3353de0c4bc8..328b3e822223 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14314,6 +14314,11 @@ S:	Maintained
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
index 5d90307fd6e0..d96438322d13 100644
--- a/arch/ia64/include/uapi/asm/cmpxchg.h
+++ b/arch/ia64/include/uapi/asm/cmpxchg.h
@@ -139,9 +139,9 @@ extern long ia64_cmpxchg_called_with_bad_pointer(void);
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
 
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 71a274e7f903..0fd3ae1051d9 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -376,6 +376,27 @@ void seq_escape(struct seq_file *m, const char *s, const char *esc)
 }
 EXPORT_SYMBOL(seq_escape);
 
+/**
+ *	seq_escape_printf_format - print string into buffer, escaping
+ *		characters that are escaped in printf format (including '"')
+ *	@m:	target buffer
+ *	@s:	string
+ *
+ *	Puts string into buffer and escape characters that are
+ *	escaped in printf format.
+ *	Use seq_has_overflowed() to check for errors.
+ */
+void seq_escape_printf_format(struct seq_file *m, const char *s)
+{
+	char *buf;
+	size_t size = seq_get_buf(m, &buf);
+	int ret;
+
+	ret = string_escape_str(s, buf, size, ESCAPE_PRINTF, NULL);
+	seq_commit(m, ret < size ? ret : -1);
+}
+EXPORT_SYMBOL(seq_escape_printf_format);
+
 void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz)
 {
 	char *buf;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 34b7e0d2346c..d4e45714405f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -309,6 +309,17 @@
 #define ACPI_PROBE_TABLE(name)
 #endif
 
+#ifdef CONFIG_PRINTK_INDEX
+#define PRINTK_INDEX							\
+	.printk_index : AT(ADDR(.printk_index) - LOAD_OFFSET) {		\
+		__start_printk_index = .;				\
+		*(.printk_index)						\
+		__stop_printk_index = .;					\
+	}
+#else
+#define PRINTK_INDEX
+#endif
+
 #ifdef CONFIG_THERMAL
 #define THERMAL_TABLE(name)						\
 	. = ALIGN(8);							\
@@ -480,6 +491,8 @@
 									\
 	TRACEDATA							\
 									\
+	PRINTK_INDEX							\
+									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
diff --git a/include/linux/module.h b/include/linux/module.h
index 7a0bcb5b1ffc..5d466b4a23b9 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -516,6 +516,12 @@ struct module {
 	struct klp_modinfo *klp_info;
 #endif
 
+#ifdef CONFIG_PRINTK_INDEX
+	unsigned int printk_index_size;
+	struct pi_object *printk_index_start;
+	struct pi_sec *pi_sec;
+#endif
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* What modules depend on me? */
 	struct list_head source_list;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index d3c08095a9a3..cd2977df820e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -164,6 +164,11 @@ static inline void printk_nmi_direct_exit(void) { }
 struct dev_printk_info;
 
 #ifdef CONFIG_PRINTK
+enum log_flags {
+	LOG_NEWLINE	= 2,	/* text ended with a newline */
+	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
+};
+
 asmlinkage __printf(4, 0)
 int vprintk_emit(int facility, int level,
 		 const struct dev_printk_info *dev_info,
@@ -173,12 +178,12 @@ asmlinkage __printf(1, 0)
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
@@ -206,6 +211,7 @@ void __init setup_log_buf(int early);
 __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
 void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
+u16 parse_prefix(const char *text, int *level, enum log_flags *lflags);
 extern asmlinkage void dump_stack(void) __cold;
 extern void printk_safe_flush(void);
 extern void printk_safe_flush_on_panic(void);
@@ -216,12 +222,12 @@ int vprintk(const char *s, va_list args)
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
@@ -301,6 +307,64 @@ extern int kptr_restrict;
 #define pr_fmt(fmt) fmt
 #endif
 
+struct module;
+
+#ifdef CONFIG_PRINTK_INDEX
+extern void pi_sec_store(struct module *mod);
+extern void pi_sec_remove(struct module *mod);
+
+struct pi_object {
+	const char *fmt;
+	const char *func;
+	const char *file;
+	unsigned int line;
+};
+
+extern struct pi_object __start_printk_index[];
+extern struct pi_object __stop_printk_index[];
+
+#define pi_sec_elf_embed(_p_func, _fmt, ...)				       \
+	({								       \
+		int _p_ret;						       \
+									       \
+		if (__builtin_constant_p(_fmt)) {			       \
+			/*
+			 * The compiler may not be able to eliminate this, so
+			 * we need to make sure that it doesn't see any
+			 * hypothetical assignment for non-constants even
+			 * though this is already inside the
+			 * __builtin_constant_p guard.
+			 */						       \
+			static struct pi_object _pi			       \
+			__section(".printk_index") = {			       \
+				.fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
+				.func = __func__,			       \
+				.file = __FILE__,			       \
+				.line = __LINE__,			       \
+			};						       \
+			_p_ret = _p_func(_pi.fmt, ##__VA_ARGS__);	       \
+		} else							       \
+			_p_ret = _p_func(_fmt, ##__VA_ARGS__);		       \
+									       \
+		_p_ret;							       \
+	})
+
+#define printk(fmt, ...) pi_sec_elf_embed(_printk, fmt, ##__VA_ARGS__)
+#define printk_deferred(fmt, ...)					       \
+	pi_sec_elf_embed(_printk_deferred, fmt, ##__VA_ARGS__)
+#else /* !CONFIG_PRINTK_INDEX */
+static inline void pi_sec_store(struct module *mod)
+{
+}
+
+static inline void pi_sec_remove(struct module *mod)
+{
+}
+
+#define printk(...) _printk(__VA_ARGS__)
+#define printk_deferred(...) _printk_deferred(__VA_ARGS__)
+#endif /* CONFIG_PRINTK_INDEX */
+
 /**
  * pr_emerg - Print an emergency-level message
  * @fmt: format string
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index b83b3ae3c877..cfc504a30429 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -127,6 +127,7 @@ void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
 		    unsigned long long v, unsigned int width);
 
 void seq_escape(struct seq_file *m, const char *s, const char *esc);
+void seq_escape_printf_format(struct seq_file *m, const char *s);
 void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz);
 
 void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index fa06dcdc481e..95fd63ee4458 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -51,6 +51,8 @@ static inline int string_unescape_any_inplace(char *buf)
 #define ESCAPE_NP		0x10
 #define ESCAPE_ANY_NP		(ESCAPE_ANY | ESCAPE_NP)
 #define ESCAPE_HEX		0x20
+#define ESCAPE_QUOTE		0x40
+#define ESCAPE_PRINTF		(ESCAPE_ANY_NP | ESCAPE_QUOTE)
 
 int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		unsigned int flags, const char *only);
diff --git a/init/Kconfig b/init/Kconfig
index ab2e916f7e8b..085190760b49 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -764,6 +764,20 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
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
+	  kernel, allowing monitoring of cases where monitored printks are
+	  changed or no longer present.
+
+	  There is no additional runtime cost to printk with this enabled.
+
 #
 # Architectures with an unreliable sched_clock() should select this:
 #
diff --git a/kernel/module.c b/kernel/module.c
index 1e5aad812310..44df2913a046 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1064,6 +1064,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
+	pi_sec_remove(mod);
 	ftrace_release_mod(mod);
 
 	async_synchronize_full();
@@ -3429,6 +3430,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 						sizeof(unsigned long),
 						&mod->num_kprobe_blacklist);
 #endif
+#ifdef CONFIG_PRINTK_INDEX
+	mod->printk_index_start = section_objs(info, ".printk_index",
+					      sizeof(*mod->printk_index_start),
+					      &mod->printk_index_size);
+#endif
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 	mod->static_call_sites = section_objs(info, ".static_call_sites",
 					      sizeof(*mod->static_call_sites),
@@ -3860,6 +3866,7 @@ static noinline int do_init_module(struct module *mod)
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
+	pi_sec_remove(mod);
 	ftrace_release_mod(mod);
 	free_module(mod);
 	wake_up_all(&module_wq);
@@ -3954,11 +3961,15 @@ static int prepare_coming_module(struct module *mod)
 	if (err)
 		return err;
 
+	pi_sec_store(mod);
+
 	err = blocking_notifier_call_chain_robust(&module_notify_list,
 			MODULE_STATE_COMING, MODULE_STATE_GOING, mod);
 	err = notifier_to_errno(err);
-	if (err)
+	if (err) {
 		klp_module_going(mod);
+		pi_sec_remove(mod);
+	}
 
 	return err;
 }
@@ -4172,6 +4183,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
+	pi_sec_remove(mod);
  bug_cleanup:
 	mod->state = MODULE_STATE_GOING;
 	/* module_bug_cleanup needs module_mutex protection */
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
index 000000000000..8765d982c8d9
--- /dev/null
+++ b/kernel/printk/index.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * printk/index.c - Userspace indexing of printk formats
+ */
+
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+
+/**
+ * struct pi_sec - printk index section metadata
+ *
+ * @file:  The debugfs file where userspace can index these printk formats
+ * @start: Section start boundary
+ * @end:   Section end boundary
+ *
+ * Allocated and populated by pi_sec_store.
+ *
+ * @mod is NULL if the printk formats in question are built in to vmlinux
+ * itself.
+ *
+ * @file may be an ERR_PTR value if the file or one of its ancestors was not
+ * successfully created.
+ */
+struct pi_sec {
+	struct dentry *file;
+	struct pi_object *start;
+	struct pi_object *end;
+};
+
+/* The base dir for module formats, typically debugfs/printk/index/ */
+struct dentry *dfs_index;
+
+#ifdef CONFIG_MODULES
+static const char *pi_get_module_name(struct module *mod)
+{
+	return mod ? mod->name : "vmlinux";
+}
+
+void pi_sec_remove(struct module *mod)
+{
+	if (!mod || !mod->pi_sec)
+		return;
+
+	debugfs_remove(mod->pi_sec->file);
+	kfree(mod->pi_sec);
+	mod->pi_sec = NULL;
+}
+#else
+static const char *pi_get_module_name(struct module *mod)
+{
+	return "vmlinux";
+}
+
+void pi_sec_remove(struct module *mod)
+{
+}
+#endif
+
+static void *pi_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	const struct pi_sec *ps = s->file->f_inode->i_private;
+	struct pi_object *pi = NULL;
+	loff_t idx = *pos - 1;
+
+	++*pos;
+
+	if (idx == -1)
+		return SEQ_START_TOKEN;
+
+	pi = ps->start + idx;
+
+	return pi < ps->end ? pi : NULL;
+}
+
+static void *pi_start(struct seq_file *s, loff_t *pos)
+{
+	return pi_next(s, NULL, pos);
+}
+
+static int pi_show(struct seq_file *s, void *v)
+{
+	const struct pi_object *pi = v;
+	int level = LOGLEVEL_DEFAULT;
+	enum log_flags lflags = 0;
+	u16 prefix_len;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(s,
+			 "# <level[,flags]> filename:line function \"format\"\n");
+		return 0;
+	}
+
+	prefix_len = parse_prefix(pi->fmt, &level, &lflags);
+	seq_printf(s, "<%d%s> %s:%d %s \"",
+			level, lflags & LOG_CONT ? ",c" : "", pi->file,
+			pi->line, pi->func);
+	seq_escape_printf_format(s, pi->fmt + prefix_len);
+	seq_puts(s, "\"\n");
+
+	return 0;
+}
+
+static void pi_stop(struct seq_file *p, void *v)
+{
+}
+
+static const struct seq_operations dfs_index_seq_ops = {
+	.start = pi_start,
+	.next  = pi_next,
+	.show  = pi_show,
+	.stop  = pi_stop,
+};
+
+
+static int pi_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &dfs_index_seq_ops);
+}
+
+static const struct file_operations dfs_index_fops = {
+	.open    = pi_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release
+};
+
+
+void pi_sec_store(struct module *mod)
+{
+	struct pi_sec *ps = NULL;
+	struct pi_object *start = NULL, *end = NULL;
+
+	ps = kmalloc(sizeof(struct pi_sec), GFP_KERNEL);
+	if (!ps)
+		return;
+
+#ifdef CONFIG_MODULES
+	if (mod) {
+		start = mod->printk_index_start;
+		end = start + mod->printk_index_size;
+	}
+#endif
+
+	if (!mod) {
+		/* vmlinux */
+		start = __start_printk_index;
+		end = __stop_printk_index;
+	}
+
+	ps->start = start;
+	ps->end = end;
+	ps->file = debugfs_create_file(pi_get_module_name(mod), 0444, dfs_index,
+				       ps, &dfs_index_fops);
+
+	if (IS_ERR(ps->file)) {
+		pi_sec_remove(mod);
+		return;
+	}
+
+#ifdef CONFIG_MODULES
+	if (mod)
+		mod->pi_sec = ps;
+#endif
+
+	/*
+	 * vmlinux's pi_sec is only accessible as private data on the inode,
+	 * since we never have to free it.
+	 */
+}
+
+static int __init pi_init(void)
+{
+	struct dentry *dfs_root = debugfs_create_dir("printk", NULL);
+
+	dfs_index = debugfs_create_dir("index", dfs_root);
+	pi_sec_store(NULL);
+
+	return 0;
+}
+
+core_initcall(pi_init);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5a95c688621f..7a6eaa912b3a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -350,11 +350,6 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
  * non-prinatable characters are escaped in the "\xff" notation.
  */
 
-enum log_flags {
-	LOG_NEWLINE	= 2,	/* text ended with a newline */
-	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
-};
-
 /*
  * The logbuf_lock protects kmsg buffer, indices, counters.  This can be taken
  * within the scheduler's rq lock. It must be released before calling
@@ -1895,7 +1890,7 @@ static inline u32 printk_caller_id(void)
  *
  * Return: The length of the parsed level and control flags.
  */
-static u16 parse_prefix(char *text, int *level, enum log_flags *lflags)
+u16 parse_prefix(const char *text, int *level, enum log_flags *lflags)
 {
 	u16 prefix_len = 0;
 	int kern_level;
@@ -2111,10 +2106,13 @@ int vprintk_default(const char *fmt, va_list args)
 EXPORT_SYMBOL_GPL(vprintk_default);
 
 /**
- * printk - print a kernel message
+ * _printk - print a kernel message
  * @fmt: format string
  *
- * This is printk(). It can be called from any context. We want it to work.
+ * This is _printk(). It can be called from any context. We want it to work.
+ *
+ * If printk indexing is enabled, _printk() is called from pi_sec_elf_embed.
+ * Otherwise, printk is simply #defined to _printk.
  *
  * We try to grab the console_lock. If we succeed, it's easy - we log the
  * output and call the console drivers.  If we fail to get the semaphore, we
@@ -2131,7 +2129,7 @@ EXPORT_SYMBOL_GPL(vprintk_default);
  *
  * See the vsnprintf() documentation for format string extensions over C99.
  */
-asmlinkage __visible int printk(const char *fmt, ...)
+asmlinkage __visible int _printk(const char *fmt, ...)
 {
 	va_list args;
 	int r;
@@ -2142,7 +2140,7 @@ asmlinkage __visible int printk(const char *fmt, ...)
 
 	return r;
 }
-EXPORT_SYMBOL(printk);
+EXPORT_SYMBOL(_printk);
 
 #else /* CONFIG_PRINTK */
 
@@ -3133,7 +3131,7 @@ int vprintk_deferred(const char *fmt, va_list args)
 	return r;
 }
 
-int printk_deferred(const char *fmt, ...)
+int _printk_deferred(const char *fmt, ...)
 {
 	va_list args;
 	int r;
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 7f2d5fbaf243..86bee1b4d392 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -436,6 +436,24 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
 	return true;
 }
 
+static bool escape_quote(unsigned char c, char **dst, char *end)
+{
+	char *out = *dst;
+
+	if (c != '"')
+		return false;
+
+	if (out < end)
+		*out = '\\';
+	++out;
+	if (out < end)
+		*out = '"';
+	++out;
+
+	*dst = out;
+	return true;
+}
+
 /**
  * string_escape_mem - quote characters in the given memory buffer
  * @src:	source buffer (unescaped)
@@ -487,6 +505,11 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  *		all previous together
  *	%ESCAPE_HEX:
  *		'\xHH' - byte with hexadecimal value HH (2 digits)
+ *	%ESCAPE_QUOTE:
+ *		'"' - ASCII quotation mark
+ *	%ESCAPE_PRINTF:
+ *		anything one would usually have to quote inside "" to printf,
+ *		ie. ESCAPE_SPACE + ESCAPE_SPECIAL + ESCAPE_NP + ESCAPE_QUOTE
  *
  * Return:
  * The total size of the escaped output that would be generated for
@@ -515,7 +538,8 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		 * In these cases we just pass through a character to the
 		 * output buffer.
 		 */
-		if ((flags & ESCAPE_NP && isprint(c)) ||
+		if ((flags & ESCAPE_NP && isprint(c) &&
+		    (!(flags & ESCAPE_QUOTE) || c != '\"')) ||
 		    (is_dict && !strchr(only, c))) {
 			/* do nothing */
 		} else {
@@ -525,6 +549,9 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 			if (flags & ESCAPE_SPECIAL && escape_special(c, &p, end))
 				continue;
 
+			if (flags & ESCAPE_QUOTE && escape_quote(c, &p, end))
+				continue;
+
 			if (flags & ESCAPE_NULL && escape_null(c, &p, end))
 				continue;
 
diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
index 10360d4ea273..619ddcffdd01 100644
--- a/lib/test-string_helpers.c
+++ b/lib/test-string_helpers.c
@@ -142,6 +142,9 @@ static const struct test_string_2 escape0[] __initconst = {{
 	.s1 = {{
 		.out = "\\\\h\\\\\"\\a\\e\\\\",
 		.flags = ESCAPE_SPECIAL,
+	},{
+		.out = "\\\\h\\\\\\\"\\a\\e\\\\",
+		.flags = ESCAPE_SPECIAL | ESCAPE_QUOTE,
 	},{
 		.out = "\\\\\\150\\\\\\042\\a\\e\\\\",
 		.flags = ESCAPE_SPECIAL | ESCAPE_OCTAL,
@@ -199,6 +202,9 @@ static const struct test_string_2 escape0[] __initconst = {{
 	},{
 		.out = "\\x1bb \\C\\x07\"\\x90\\x0d]",
 		.flags = ESCAPE_NP | ESCAPE_HEX,
+	},{
+		.out = "\\eb \\C\\a\\\"\\220\\r]",
+		.flags = ESCAPE_PRINTF,
 	},{
 		/* terminator */
 	}},
-- 
2.30.2

