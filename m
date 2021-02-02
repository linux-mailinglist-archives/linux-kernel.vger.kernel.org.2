Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57630C73E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbhBBROg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhBBQzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:55:44 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562CAC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:55:04 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t29so14716887pfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIYBJckgoH5d3pfOoSKjBFBuNT0uFQyqaSnjtumC/qo=;
        b=JvVOF5GW4au6s7PJFCXBPgGUrU8DVHRy/K8fxKC4mhJ8vIJFY0+a+u8d8WD1xRjqpq
         RVjAToyh6+qCzXNu/GqZEAD1iN2mrIBTgNy8TUB3SBy5VB44WxlA+YBfoD2+oNknGDQh
         bd4lv38xxBM+ZhBV2cktlW5lOnke90eZjRWsMF3EOMcEuc/+RJmbpQCvpTrDeEE5YvtY
         52SIIfzS1lOl2bAkmR70aCKWmuF53s1aWO+oJ3wvmEUydy/u5ufDMKj42V369BrKZprr
         HAmb7jlBlInEuBzKgsk/HD7YsRI8vwUJxT7IBR2X9Wb8d8NfSs8sa9IWUiv4ufh1TcOI
         8oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIYBJckgoH5d3pfOoSKjBFBuNT0uFQyqaSnjtumC/qo=;
        b=sKa7EYhPMhRk8Q+nB7SwUCq9hem7bcS8QoPiNn3d84nxeTtBZAB0/no43R+w/ZAxTs
         /c4y5w/zCEFilWo/l3IOHuFzRvX0IFvm2C1qi/lQej8hqHX4JYNRYNy3FPzgG7kszn+E
         1J1N+ktxDsm32FEzPZp0zVw8MoqZV3tZVY2Gqyog3DKfY1lLgOOL5hZEuOHAZdTdJO9f
         xCwlA8q9dnRcL4dJRUkUGfWTMebqVhj4S56W4L4FX9ex+gi/jllemtyHz7uN9begy/5U
         kFka5RkZ4uSJQ04uxBwervvzMKn38BhAr1jwzjVO7jwKaTwldMjNk5WcP3NO2vk7Q5BN
         haHQ==
X-Gm-Message-State: AOAM532ljmabA4ObaG51c+CJTO7bfdszgybdi+Ua339Y+LlwkYFsIcJ8
        pgzQer8wdhW+f00Xhw3lOtI=
X-Google-Smtp-Source: ABdhPJzIVDBhWHw16Ef1NoGJEVO/842/EROvQe8/dAeAq+nn0oMJgxjovEpCHrS3KFJjbDy2i0apZA==
X-Received: by 2002:aa7:960f:0:b029:1bf:121d:7f23 with SMTP id q15-20020aa7960f0000b02901bf121d7f23mr2993131pfg.5.1612284903409;
        Tue, 02 Feb 2021 08:55:03 -0800 (PST)
Received: from localhost.localdomain (76-242-91-105.lightspeed.sntcca.sbcglobal.net. [76.242.91.105])
        by smtp.gmail.com with ESMTPSA id u3sm24010281pfm.144.2021.02.02.08.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:55:02 -0800 (PST)
From:   sonicadvance1@gmail.com
X-Google-Original-From: Sonicadvance1@gmail.com
Cc:     Ryan Houdek <Sonicadvance1@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kevin Hao <haokexin@gmail.com>,
        Jason Yan <yanaijie@huawei.com>,
        Julien Grall <julien.grall@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Peter Collingbourne <pcc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Matteo Croce <mcroce@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] arm64: Exposes support for 32bit syscalls
Date:   Tue,  2 Feb 2021 08:54:23 -0800
Message-Id: <20210202165437.334515-1-Sonicadvance1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Houdek <Sonicadvance1@gmail.com>

This is a continuation of https://lkml.org/lkml/2021/1/6/47
This patch is currently based against a 5.10 kernel but rebasing against
latest HEAD is trivial

Specifically Amanieu pointed out a couple of problem spaces that would
show up around memory management and various other bits.

This convinced me that the previous path of only having an ioctl32
syscall is only a bandage on a much larger problem.

This takes a patch from the Tango support tree and modifies it a bit to
not rely on a Tango specific quirk.

Original patch:
https://github.com/Amanieu/linux/commit/b4783002afb027ae702da8f56e43e45c7332d226

This patch changes the KSTK_EIP and KSTK_ESP helpers to only fall to
Tango specific behaviour once a "Tango" syscall has been invoked.
I'm working on a backwards compatibility project that is unrelated to
Tango, but it would be nice to have a solution that works for both of
us. Since we are both working on projects that run 32bit applications
inside of a 64bit process for compatibility purposes.

Some notes for what I'm looking for here.
- Is the way of invoking the compat syscall table amenable to upstream?
Currently I'm using `svc #1` for a compat syscall and `svc 2` for a
Tango syscall
Everything else falls down to regular syscall table
There is zero documentation for userspace around if the kernel is only
allowed to handle syscalls in `svc #0` or any svc ISS will suffice.

- Alternatively we could reserve a high bit in the syscall number like
x32 to get to this compat table?
This is how the original Tango patch worked. If the high bit of the
32bit syscall number was set then it goes down the compat table path.

Talking with Amanieu, both paths will work for our projects, just need
to standardize on one of them.
Considering I'm not a regular contributor to the Linux kernel, I won't
be able to bikeshed to choose a particular path. Both are equally easy
to support in userspace.

- If going down the SVC ISS path for the table, how to detect if the
kernel is compiled with the option?
Currently this is unimplemented in my patch because it wasn't a blocker
for the RFC.
If it is compiled out I can see it being fine to just return -ENOSYS
for {1,2} SVC ISS numbers.
Alternatively we could call some syscalls that do pointer validation for
compat and check for -EINVAL or something similar.
Obviously the -ENOSYS path is cleaner and maps to someone trying to use
0x8000'0000 from a syscall number impelementation.

- Should the 32bit compat and Tango paths be separated?
Even with garbage data in x15 and x13 for EIP/ESP then using the single
Tango path isn't a killer for my project FEX.
This seemingly will only break things like seccomp and stat?
Alternatively before my 32bit syscall I can do a rsp and PC calculation
before the svc instruction for it to be correct.
All the options are easy to support here, just seemed nicer to keep them
separated because the behaviour is slightly different here.

- Which syscalls are we leaning on to require this patch?
This is required for a couple of syscalls
- ioctl - Physically impossible to support emulating in all situations
  - Even full ioctl emulation in userspace has broken use cases

- mmap, mremap, shmat - Emulating this is userspace changes behaviour
Specifically since userspace doesn't have a full VMA view we must
generate a pessimistic memory allocator that uses FIXED_NOREPLACE to see
if we can fit an allocation.
This changes behaviour and can actually break code. A good example is
ARM's kbase kernel driver actually doesn't support FIXED placement so
would never work without this OR changing their downstream code.
If even ARM breaks then I don't want to know about random other things
that will end up breaking in this case. Not to mention that with a bad
userspace allocator, it ends up having worst performance because it
needs to be pessimistic about allocations

- recvmsg,sendmsg,recvmmsg,sendmmsg
This isn't necessarily 100% required but these are complex and very easy
to break. Evident that implementing this I already found bugs in my
userspace implementation. The flex array members for the various message
types are a bit of a pain point.

Now some more background from the original patch

Problem presented: "FEX" project point of view
A backwards compatibility layer that allows running x86-64 and x86
Processes inside of an AArch64 process.
  - CPU is emulated
  - syscall interface is mostly passthrough
  - Some syscalls require patching or emulation depending on
  mismatched structures between architectures
  - Not viable from the emulator design to use an AArch64 host process

x86-64 and x86 userspace emulator source:
https://github.com/FEX-Emu/FEX

Cross documentation:
https://github.com/FEX-Emu/FEX/wiki/32Bit-x86-Woes

ioctl interface problems presented

ioctls are opaque from the emulator perspective and the data wants to be
passed through a syscall as unimpeded as possible.
Sadly due to ioctl struct differences between x86 and x86-64, we need a
syscall that exposes the compatibility ioctl handler to userspace in a
64bit process.

This is necessary behaves of the behaviour differences that occur
between an x86 process doing an ioctl and an x86-64 process doing an
ioctl.

This ioctl gets captured in the emulation and then passed through the
compatibility syscall interface

The only supported hosts where we care about this currently is AArch64
and x86-64 (For testing purposes).
PPC64LE, MIPS64LE, and RISC-V64 might be interesting to support in the
future; But I don't have any platforms that get anywhere near Cortex-A77
performance in those architectures. Nor do I have the time to bring up
the emulator on them.

This does not solve the following problems:
1) compat_alloc_user_space inside ioctl (Apparently this is nearly gone)
2) struct packing problems between architectures

Workarounds for the problems presented:
1a) Do a stack pivot to the lower 32bits from userspace
  - Forces host 64bit process to have its thread stacks to live in 32bit
  space. Not ideal.
  - Only do a stack pivot on ioctl to save previous 32bit VA space
1b) Teach kernel that compat_alloc_userspace can return a 64bit pointer
  - x86-64 truncates stack from this function
  - AArch64 returns the full stack pointer
  - Only around 29 users. Validating all of them support a 64bit stack is
  trivial?

2a) Blocklist any application using ioctls that have different struct
packing across the boundary
  - Can happen when struct packing of 32bit x86 application goes down
  the aarch64 compat_ioctl path
  - Userspace is a AArch64 process passing 32bit x86 ioctl structures
  through the compat_ioctl path which is typically for AArch32 processes
  - None currently identified
2b) Work with upstream kernel and userspace projects to evaluate and fix
  - Identify the problem ioctls
  - Implement a new ioctl with more sane struct packing that matches
  cross-arch
  - Implement new ioctl while maintaining backwards compatibility with
  previous ioctl handler
  - Change upstream project to use the new compatibility ioctl
  - ioctl deprecation will be case by case per device and project
2b) Userspace implements a full ioctl emulation layer
  - Parses the full ioctl tree
  - Either passes through ioctls that it doesn't understand or
  transforms ioctls that it knows are trouble
  - Has the downside that it can still run in to edge cases that will
  fail
  - Performance of additional tracking is a concern
  - Prone to failure keeping the kernel ioctl and userspace ioctl
  handling in sync
  - Really want to have it in the kernel space as much as possible
  - Haven't encountered this yet, but it is sure to happen eventually
  - Some amount of userspace parsing is expected to be done at some
  point

Signed-off-by: Ryan Houdek <Sonicadvance1@gmail.com>
---
 arch/arm64/Kconfig                   |  19 ++
 arch/arm64/include/asm/compat.h      |  31 ++++
 arch/arm64/include/asm/exception.h   |   2 +-
 arch/arm64/include/asm/mmu.h         |   7 +
 arch/arm64/include/asm/pgtable.h     |  10 ++
 arch/arm64/include/asm/processor.h   |  28 ++-
 arch/arm64/include/asm/thread_info.h |   9 +
 arch/arm64/kernel/asm-offsets.c      |   3 +
 arch/arm64/kernel/entry-common.c     |   9 +-
 arch/arm64/kernel/fpsimd.c           |   2 +-
 arch/arm64/kernel/hw_breakpoint.c    |   2 +-
 arch/arm64/kernel/perf_regs.c        |   2 +-
 arch/arm64/kernel/process.c          |  13 +-
 arch/arm64/kernel/ptrace.c           |   6 +-
 arch/arm64/kernel/signal.c           |   2 +-
 arch/arm64/kernel/syscall.c          |  29 +++-
 arch/arm64/mm/mmap.c                 | 249 +++++++++++++++++++++++++++
 17 files changed, 402 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..eb9c622c1e95 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1147,6 +1147,25 @@ config XEN
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM64.
 
+config ARM_COMPAT_DISPATCH
+	bool "32bit syscall dispatch table"
+	depends on COMPAT && ARM64
+	default y
+	help
+	  Kernel support for exposing the 32-bit syscall dispatch table to
+	  userspace.
+	  For dynamically translating 32-bit applications to a 64-bit process.
+
+config TANGO_BT
+	bool "Tango binary translator support"
+	depends on ARM_COMPAT_DISPATCH
+	select CHECKPOINT_RESTORE
+	select BINFMT_MISC
+	default y
+	help
+	  Kernel support for the Tango binary translator which dynamically
+	  translates 32-bit ARM binaries into 64-bit code.
+
 config FORCE_MAX_ZONEORDER
 	int
 	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 23a9fb73c04f..d7c44b3604bf 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -180,14 +180,45 @@ struct compat_shmid64_ds {
 
 static inline int is_compat_task(void)
 {
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	/* It is compatible if Tango, 32bit compat, or 32bit thread */
+	return current_thread_info()->compat_syscall_flags != 0 || test_thread_flag(TIF_32BIT);
+#else
 	return test_thread_flag(TIF_32BIT);
+#endif
 }
 
 static inline int is_compat_thread(struct thread_info *thread)
+{
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	/* It is compatible if Tango, 32bit compat, or 32bit thread */
+	return thread->compat_syscall_flags != 0 || test_ti_thread_flag(thread, TIF_32BIT);
+#else
+	return test_ti_thread_flag(thread, TIF_32BIT);
+#endif
+}
+
+static inline int is_aarch32_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT);
+}
+
+static inline int is_aarch32_compat_thread(struct thread_info *thread)
 {
 	return test_ti_thread_flag(thread, TIF_32BIT);
 }
 
+#ifdef CONFIG_TANGO_BT
+static inline int is_tango_compat_task(void)
+{
+	return current_thread_info()->compat_syscall_flags & _TIF_COMPAT_TANGOSYSCALL;
+}
+static inline int is_tango_compat_thread(struct thread_info *thread)
+{
+	return thread->compat_syscall_flags & _TIF_COMPAT_TANGOSYSCALL;
+}
+#endif
+
 #else /* !CONFIG_COMPAT */
 
 static inline int is_compat_thread(struct thread_info *thread)
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 99b9383cd036..f2c94b44b51c 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -45,7 +45,7 @@ void do_sysinstr(unsigned int esr, struct pt_regs *regs);
 void do_sp_pc_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
 void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr);
 void do_cp15instr(unsigned int esr, struct pt_regs *regs);
-void do_el0_svc(struct pt_regs *regs);
+void do_el0_svc(struct pt_regs *regs, unsigned int iss);
 void do_el0_svc_compat(struct pt_regs *regs);
 void do_ptrauth_fault(struct pt_regs *regs, unsigned int esr);
 #endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index b2e91c187e2a..0744db65c0a9 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -27,6 +27,9 @@ typedef struct {
 	refcount_t	pinned;
 	void		*vdso;
 	unsigned long	flags;
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	unsigned long	compat_mmap_base;
+#endif
 } mm_context_t;
 
 /*
@@ -79,6 +82,10 @@ extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
 extern bool kaslr_requires_kpti(void);
 
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+extern void process_init_compat_mmap(void);
+#endif
+
 #define INIT_MM_CONTEXT(name)	\
 	.pgd = init_pg_dir,
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4ff12a7adcfd..5e7662c2675c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -974,6 +974,16 @@ static inline bool arch_faults_on_old_pte(void)
 }
 #define arch_faults_on_old_pte arch_faults_on_old_pte
 
+/*
+ * We provide our own arch_get_unmapped_area to handle 32-bit mmap calls from
+ * tango.
+ */
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+#define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fce8cbecd6bc..f56689d4d185 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -175,7 +175,7 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 #define task_user_tls(t)						\
 ({									\
 	unsigned long *__tls;						\
-	if (is_compat_thread(task_thread_info(t)))			\
+	if (is_aarch32_compat_thread(task_thread_info(t)))			\
 		__tls = &(t)->thread.uw.tp2_value;			\
 	else								\
 		__tls = &(t)->thread.uw.tp_value;			\
@@ -256,8 +256,30 @@ extern struct task_struct *cpu_switch_to(struct task_struct *prev,
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
 
-#define KSTK_EIP(tsk)	((unsigned long)task_pt_regs(tsk)->pc)
-#define KSTK_ESP(tsk)	user_stack_pointer(task_pt_regs(tsk))
+#ifdef CONFIG_TANGO_BT
+#define KSTK_EIP(tsk)                                           \
+({                                                              \
+	unsigned long __out;                                      \
+	if (is_tango_compat_thread(task_thread_info(tsk)))        \
+		__out = (unsigned long)task_pt_regs(tsk)->regs[15]; \
+	else                                                      \
+		__out = (unsigned long)task_pt_regs(tsk)->pc;       \
+	__out;                                                    \
+})
+#define KSTK_ESP(tsk)                                           \
+({                                                              \
+	unsigned long __out;                                      \
+	if (is_tango_compat_thread(task_thread_info(tsk)))        \
+		__out = (unsigned long)task_pt_regs(tsk)->regs[13]; \
+	else                                                      \
+		__out = user_stack_pointer(task_pt_regs(tsk));      \
+	__out;                                                    \
+})
+
+#else
+#define KSTK_EIP(tsk)  ((unsigned long)task_pt_regs(tsk)->pc)
+#define KSTK_ESP(tsk)  user_stack_pointer(task_pt_regs(tsk))
+#endif
 
 /*
  * Prefetching support
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 1fbab854a51b..b9af80474f3b 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -41,6 +41,9 @@ struct thread_info {
 #endif
 		} preempt;
 	};
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	int			compat_syscall_flags;	/* 32-bit compat syscall */
+#endif
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
 	void			*scs_sp;
@@ -107,6 +110,12 @@ void arch_release_task_struct(struct task_struct *tsk);
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
 				 _TIF_SYSCALL_EMU)
 
+#define TIF_COMPAT_32BITSYSCALL 0 /* Trivial 32bit compatible syscall */
+#define TIF_COMPAT_TANGOSYSCALL 1 /* Tango 32bit compatible syscall */
+
+#define _TIF_COMPAT_32BITSYSCALL (1 << TIF_COMPAT_32BITSYSCALL)
+#define _TIF_COMPAT_TANGOSYSCALL (1 << TIF_COMPAT_TANGOSYSCALL)
+
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
 	.scs_base	= init_shadow_call_stack,			\
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 7d32fc959b1a..742203cff128 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -34,6 +34,9 @@ int main(void)
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
   DEFINE(TSK_TI_TTBR0,		offsetof(struct task_struct, thread_info.ttbr0));
 #endif
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+  DEFINE(TI_COMPAT_SYSCALL,	offsetof(struct task_struct, thread_info.compat_syscall_flags));
+#endif
 #ifdef CONFIG_SHADOW_CALL_STACK
   DEFINE(TSK_TI_SCS_BASE,	offsetof(struct task_struct, thread_info.scs_base));
   DEFINE(TSK_TI_SCS_SP,		offsetof(struct task_struct, thread_info.scs_sp));
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 43d4c329775f..6d98a9c6fafd 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -228,12 +228,12 @@ static void notrace el0_dbg(struct pt_regs *regs, unsigned long esr)
 }
 NOKPROBE_SYMBOL(el0_dbg);
 
-static void notrace el0_svc(struct pt_regs *regs)
+static void notrace el0_svc(struct pt_regs *regs, unsigned int iss)
 {
 	if (system_uses_irq_prio_masking())
 		gic_write_pmr(GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET);
 
-	do_el0_svc(regs);
+	do_el0_svc(regs, iss);
 }
 NOKPROBE_SYMBOL(el0_svc);
 
@@ -251,7 +251,10 @@ asmlinkage void notrace el0_sync_handler(struct pt_regs *regs)
 
 	switch (ESR_ELx_EC(esr)) {
 	case ESR_ELx_EC_SVC64:
-		el0_svc(regs);
+		/* Redundant masking here to show we are getting ISS mask
+		 * Then we are pulling the imm16 out of it for SVC64
+		 */
+		el0_svc(regs, (esr & ESR_ELx_ISS_MASK) & 0xffff);
 		break;
 	case ESR_ELx_EC_DABT_LOW:
 		el0_da(regs, esr);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 062b21f30f94..a35ab449a466 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -937,7 +937,7 @@ void fpsimd_release_task(struct task_struct *dead_task)
 void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 {
 	/* Even if we chose not to use SVE, the hardware could still trap: */
-	if (unlikely(!system_supports_sve()) || WARN_ON(is_compat_task())) {
+	if (unlikely(!system_supports_sve()) || WARN_ON(is_aarch32_compat_task())) {
 		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 		return;
 	}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 712e97c03e54..37c9349c4999 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -168,7 +168,7 @@ static int is_compat_bp(struct perf_event *bp)
 	 * deprecated behaviour if we use unaligned watchpoints in
 	 * AArch64 state.
 	 */
-	return tsk && is_compat_thread(task_thread_info(tsk));
+	return tsk && is_aarch32_compat_thread(task_thread_info(tsk));
 }
 
 /**
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index f6f58e6265df..c4b061f0d182 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -66,7 +66,7 @@ int perf_reg_validate(u64 mask)
 
 u64 perf_reg_abi(struct task_struct *task)
 {
-	if (is_compat_thread(task_thread_info(task)))
+	if (is_aarch32_compat_thread(task_thread_info(task)))
 		return PERF_SAMPLE_REGS_ABI_32;
 	else
 		return PERF_SAMPLE_REGS_ABI_64;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a47a40ec6ad9..9c0775babbd0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -314,7 +314,7 @@ static void tls_thread_flush(void)
 {
 	write_sysreg(0, tpidr_el0);
 
-	if (is_compat_task()) {
+	if (is_aarch32_compat_task()) {
 		current->thread.uw.tp_value = 0;
 
 		/*
@@ -409,7 +409,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		*task_user_tls(p) = read_sysreg(tpidr_el0);
 
 		if (stack_start) {
-			if (is_compat_thread(task_thread_info(p)))
+			if (is_aarch32_compat_thread(task_thread_info(p)))
 				childregs->compat_sp = stack_start;
 			else
 				childregs->sp = stack_start;
@@ -453,7 +453,7 @@ static void tls_thread_switch(struct task_struct *next)
 {
 	tls_preserve_current_state();
 
-	if (is_compat_thread(task_thread_info(next)))
+	if (is_aarch32_compat_thread(task_thread_info(next)))
 		write_sysreg(next->thread.uw.tp_value, tpidrro_el0);
 	else if (!arm64_kernel_unmapped_at_el0())
 		write_sysreg(0, tpidrro_el0);
@@ -619,7 +619,12 @@ unsigned long arch_align_stack(unsigned long sp)
  */
 void arch_setup_new_exec(void)
 {
-	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	process_init_compat_mmap();
+	current_thread_info()->compat_syscall_flags = 0;
+#endif
+
+	current->mm->context.flags = is_aarch32_compat_task() ? MMCF_AARCH32 : 0;
 
 	ptrauth_thread_init_user(current);
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index f49b349e16a3..2e3c242941d1 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -175,7 +175,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 	const char *desc = "Hardware breakpoint trap (ptrace)";
 
 #ifdef CONFIG_COMPAT
-	if (is_compat_task()) {
+	if (is_aarch32_compat_task()) {
 		int si_errno = 0;
 		int i;
 
@@ -1725,7 +1725,7 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	 */
 	if (is_compat_task())
 		return &user_aarch32_view;
-	else if (is_compat_thread(task_thread_info(task)))
+	else if (is_aarch32_compat_thread(task_thread_info(task)))
 		return &user_aarch32_ptrace_view;
 #endif
 	return &user_aarch64_view;
@@ -1906,7 +1906,7 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
 	/* https://lore.kernel.org/lkml/20191118131525.GA4180@willie-the-truck */
 	user_regs_reset_single_step(regs, task);
 
-	if (is_compat_thread(task_thread_info(task)))
+	if (is_aarch32_compat_thread(task_thread_info(task)))
 		return valid_compat_regs(regs);
 	else
 		return valid_native_regs(regs);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index a8184cad8890..e6462b32effa 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -813,7 +813,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	/*
 	 * Set up the stack frame
 	 */
-	if (is_compat_task()) {
+	if (is_aarch32_compat_task()) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
 			ret = compat_setup_rt_frame(usig, ksig, oldset, regs);
 		else
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index e4c0dadf0d92..a47f96b17279 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -21,7 +21,7 @@ static long do_ni_syscall(struct pt_regs *regs, int scno)
 {
 #ifdef CONFIG_COMPAT
 	long ret;
-	if (is_compat_task()) {
+	if (is_aarch32_compat_task()) {
 		ret = compat_arm_syscall(regs, scno);
 		if (ret != -ENOSYS)
 			return ret;
@@ -167,6 +167,9 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		local_daif_mask();
 		flags = current_thread_info()->flags;
 		if (!has_syscall_work(flags) && !(flags & _TIF_SINGLESTEP)) {
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+			current_thread_info()->compat_syscall_flags = 0;
+#endif
 			/*
 			 * We're off to userspace, where interrupts are
 			 * always enabled after we restore the flags from
@@ -180,6 +183,9 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 
 trace_exit:
 	syscall_trace_exit(regs);
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	current_thread_info()->compat_syscall_flags = 0;
+#endif
 }
 
 static inline void sve_user_discard(void)
@@ -199,10 +205,27 @@ static inline void sve_user_discard(void)
 	sve_user_disable();
 }
 
-void do_el0_svc(struct pt_regs *regs)
+void do_el0_svc(struct pt_regs *regs, unsigned int iss)
 {
 	sve_user_discard();
-	el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
+	switch (iss) {
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+	case 1:
+		current_thread_info()->compat_syscall_flags = _TIF_COMPAT_32BITSYSCALL;
+		el0_svc_common(regs, regs->regs[7], __NR_compat_syscalls,
+			       compat_sys_call_table);
+		break;
+#endif
+#ifdef CONFIG_TANGO_BT
+	case 2:
+		current_thread_info()->compat_syscall_flags = _TIF_COMPAT_TANGOSYSCALL;
+		el0_svc_common(regs, regs->regs[7], __NR_compat_syscalls,
+			       compat_sys_call_table);
+		break;
+#endif
+	default:
+		el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
+	}
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 3028bacbc4e9..857aa03a3ac2 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -17,6 +17,8 @@
 #include <linux/io.h>
 #include <linux/personality.h>
 #include <linux/random.h>
+#include <linux/security.h>
+#include <linux/hugetlb.h>
 
 #include <asm/cputype.h>
 
@@ -68,3 +70,250 @@ int devmem_is_allowed(unsigned long pfn)
 }
 
 #endif
+
+#ifdef CONFIG_ARM_COMPAT_DISPATCH
+
+/* Definitions for compat syscall guest mmap area */
+#define COMPAT_MIN_GAP			(SZ_128M)
+#define COMPAT_STACK_TOP		0xffff0000
+#define COMPAT_MAX_GAP			(COMPAT_STACK_TOP/6*5)
+#define COMPAT_TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE_32 / 4)
+#define COMPAT_STACK_RND_MASK		(0x7ff >> (PAGE_SHIFT - 12))
+
+#ifndef arch_get_mmap_end
+#define arch_get_mmap_end(addr)	(TASK_SIZE)
+#endif
+
+#ifndef arch_get_mmap_base
+#define arch_get_mmap_base(addr, base) (base)
+#endif
+
+static int mmap_is_legacy(unsigned long rlim_stack)
+{
+	if (current->personality & ADDR_COMPAT_LAYOUT)
+		return 1;
+
+	if (rlim_stack == RLIM_INFINITY)
+		return 1;
+
+	return sysctl_legacy_va_layout;
+}
+
+static unsigned long compat_mmap_base(unsigned long rnd, unsigned long gap)
+{
+	unsigned long pad = stack_guard_gap;
+
+	/* Account for stack randomization if necessary */
+	if (current->flags & PF_RANDOMIZE)
+		pad += (COMPAT_STACK_RND_MASK << PAGE_SHIFT);
+
+	/* Values close to RLIM_INFINITY can overflow. */
+	if (gap + pad > gap)
+		gap += pad;
+
+	if (gap < COMPAT_MIN_GAP)
+		gap = COMPAT_MIN_GAP;
+	else if (gap > COMPAT_MAX_GAP)
+		gap = COMPAT_MAX_GAP;
+
+	return PAGE_ALIGN(COMPAT_STACK_TOP - gap - rnd);
+}
+
+void process_init_compat_mmap(void)
+{
+	unsigned long random_factor = 0UL;
+	unsigned long rlim_stack = rlimit(RLIMIT_STACK);
+
+	if (current->flags & PF_RANDOMIZE) {
+		random_factor = (get_random_long() &
+			((1UL << mmap_rnd_compat_bits) - 1)) << PAGE_SHIFT;
+	}
+
+	if (mmap_is_legacy(rlim_stack)) {
+		current->mm->context.compat_mmap_base =
+			COMPAT_TASK_UNMAPPED_BASE + random_factor;
+	} else {
+		current->mm->context.compat_mmap_base =
+			compat_mmap_base(random_factor, rlim_stack);
+	}
+}
+
+/* Get an address range which is currently unmapped.
+ * For shmat() with addr=0.
+ *
+ * Ugly calling convention alert:
+ * Return value with the low bits set means error value,
+ * ie
+ *	if (ret & ~PAGE_MASK)
+ *		error = ret;
+ *
+ * This function "knows" that -ENOMEM has the bits set.
+ */
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+	struct vm_unmapped_area_info info;
+	const unsigned long mmap_end = arch_get_mmap_end(addr);
+	bool bad_addr = false;
+
+	if (len > mmap_end - mmap_min_addr)
+		return -ENOMEM;
+
+	/*
+	 * Ensure that translated processes do not allocate the last
+	 * page of the 32-bit address space, or anything above it.
+	 */
+	if (is_compat_task())
+		bad_addr = addr + len > TASK_SIZE_32;
+
+	if (flags & MAP_FIXED)
+		return bad_addr ? -ENOMEM : addr;
+
+	if (addr && !bad_addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma_prev(mm, addr, &prev);
+		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
+		    (!vma || addr + len <= vm_start_gap(vma)) &&
+		    (!prev || addr >= vm_end_gap(prev)))
+			return addr;
+	}
+
+	info.flags = 0;
+	info.length = len;
+	if (is_compat_task()) {
+		info.low_limit = mm->context.compat_mmap_base;
+		info.high_limit = TASK_SIZE_32;
+	} else {
+		info.low_limit = mm->mmap_base;
+		info.high_limit = mmap_end;
+	}
+	info.align_mask = 0;
+	return vm_unmapped_area(&info);
+}
+
+/*
+ * This mmap-allocator allocates new areas top-down from below the
+ * stack's low limit (the base):
+ */
+unsigned long
+arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags)
+{
+
+	struct vm_area_struct *vma, *prev;
+	struct mm_struct *mm = current->mm;
+	struct vm_unmapped_area_info info;
+	const unsigned long mmap_end = arch_get_mmap_end(addr);
+	bool bad_addr = false;
+
+	/* requested length too big for entire address space */
+	if (len > mmap_end - mmap_min_addr)
+		return -ENOMEM;
+
+	/*
+	 * Ensure that translated processes do not allocate the last
+	 * page of the 32-bit address space, or anything above it.
+	 */
+	if (is_compat_task())
+		bad_addr = addr + len > TASK_SIZE_32;
+
+	if (flags & MAP_FIXED)
+		return bad_addr ? -ENOMEM : addr;
+
+	/* requesting a specific address */
+	if (addr && !bad_addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma_prev(mm, addr, &prev);
+		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
+				(!vma || addr + len <= vm_start_gap(vma)) &&
+				(!prev || addr >= vm_end_gap(prev)))
+			return addr;
+	}
+
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	if (is_compat_task())
+		info.high_limit = mm->context.compat_mmap_base;
+	else
+		info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
+	info.align_mask = 0;
+	addr = vm_unmapped_area(&info);
+
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	if (offset_in_page(addr)) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = 0;
+		if (is_compat_task()) {
+			info.low_limit = COMPAT_TASK_UNMAPPED_BASE;
+			info.high_limit = TASK_SIZE_32;
+		} else {
+			info.low_limit = TASK_UNMAPPED_BASE;
+			info.high_limit = mmap_end;
+		}
+		addr = vm_unmapped_area(&info);
+	}
+
+	return addr;
+}
+
+unsigned long
+hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
+	bool bad_addr = false;
+
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	/*
+	 * Ensure that translated processes do not allocate the last
+	 * page of the 32-bit address space, or anything above it.
+	 */
+	if (is_compat_task())
+		bad_addr = addr + len > TASK_SIZE_32;
+
+	if (flags & MAP_FIXED) {
+		if (prepare_hugepage_range(file, addr, len))
+			return -EINVAL;
+		return bad_addr ? -ENOMEM : addr;
+	}
+
+	if (addr && !bad_addr) {
+		addr = ALIGN(addr, huge_page_size(h));
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vm_start_gap(vma)))
+			return addr;
+	}
+
+	info.flags = 0;
+	info.length = len;
+	if (is_compat_task()) {
+		info.low_limit = COMPAT_TASK_UNMAPPED_BASE;
+		info.high_limit = TASK_SIZE_32;
+	} else {
+		info.low_limit = TASK_UNMAPPED_BASE;
+		info.high_limit = TASK_SIZE;
+	}
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
+}
+
+#endif
-- 
2.27.0

