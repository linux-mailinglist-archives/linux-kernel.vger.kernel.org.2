Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB6379A63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhEJWwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhEJWwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:52:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 928E6613CF;
        Mon, 10 May 2021 22:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620687087;
        bh=G0//6r2JPgr7VNVl8EHMLxJEunTkY6dCSWn6barqz5Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gxHwlm9vMm2CTEWndoE86b6I8vqepq+ryK4hm6nfxBejf0TXaeLbsAdEnFgT7MUCE
         gSgrigCr3596BteEAhMgwedgZOewQELH+6LHsxiPVH2R8H3AaGIgQLiYliu6ljrI7r
         BaSP1EGl/YI4H9YOi73X2zkYnyp+8w6rYku9UnMWqvig706t4TR/1v/2VXaQxRyJ6y
         N3wCyi/M2bPgQ+ySI8I4M3CNMQv2KdNPhUJzeLuFrvOk8c3k/2x4YU8dWkykxrjZOf
         30pdh7jGNrupReVd6OCx+F/xrJ1It1iyJUwtKUEC5ddZ3AuhbCQz3+Ru+SsM0zqH8d
         i+cXX2Aut87Zw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5303F5C0333; Mon, 10 May 2021 15:51:27 -0700 (PDT)
Date:   Mon, 10 May 2021 15:51:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:tglx-pc.2021.05.10a 1/13]
 arch/um/include/shared/kern_util.h:54:12: error: conflicting types for
 '__cant_sleep'
Message-ID: <20210510225127.GI975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202105110647.8rU44xvP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105110647.8rU44xvP-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 06:25:03AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tglx-pc.2021.05.10a
> head:   650c7ee79df04a22835a23144ffb918a75ab04e6
> commit: 2ae8c0da23534e0cbf43aa185b3f261ce8340e45 [1/13] lib/debug: Remove pointless ARCH_NO_PREEMPT dependencies
> config: um-allmodconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=2ae8c0da23534e0cbf43aa185b3f261ce8340e45
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu tglx-pc.2021.05.10a
>         git checkout 2ae8c0da23534e0cbf43aa185b3f261ce8340e45
>         # save the attached .config to linux build tree
>         make W=1 W=1 ARCH=um 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

OK, I clearly need to work harder on this forward-port.  Apologies for
the noise.

							Thanx, Paul

>    In file included from arch/um/kernel/irq.c:19:
> >> arch/um/include/shared/kern_util.h:54:12: error: conflicting types for '__cant_sleep'
>       54 | extern int __cant_sleep(void);
>          |            ^~~~~~~~~~~~
>    In file included from include/linux/cpumask.h:10,
>                     from arch/um/kernel/irq.c:10:
>    include/linux/kernel.h:103:13: note: previous declaration of '__cant_sleep' was here
>      103 | extern void __cant_sleep(const char *file, int line, int preempt_offset);
>          |             ^~~~~~~~~~~~
>    arch/um/kernel/irq.c:620:13: warning: no previous prototype for 'init_IRQ' [-Wmissing-prototypes]
>      620 | void __init init_IRQ(void)
>          |             ^~~~~~~~
> --
>    In file included from arch/um/kernel/mem.c:18:
> >> arch/um/include/shared/kern_util.h:54:12: error: conflicting types for '__cant_sleep'
>       54 | extern int __cant_sleep(void);
>          |            ^~~~~~~~~~~~
>    In file included from include/linux/list.h:9,
>                     from include/linux/module.h:12,
>                     from arch/um/kernel/mem.c:7:
>    include/linux/kernel.h:103:13: note: previous declaration of '__cant_sleep' was here
>      103 | extern void __cant_sleep(const char *file, int line, int preempt_offset);
>          |             ^~~~~~~~~~~~
>    arch/um/kernel/mem.c:184:8: warning: no previous prototype for 'pgd_alloc' [-Wmissing-prototypes]
>      184 | pgd_t *pgd_alloc(struct mm_struct *mm)
>          |        ^~~~~~~~~
>    arch/um/kernel/mem.c:197:7: warning: no previous prototype for 'uml_kmalloc' [-Wmissing-prototypes]
>      197 | void *uml_kmalloc(int size, int flags)
>          |       ^~~~~~~~~~~
> --
>    In file included from arch/um/kernel/process.c:31:
> >> arch/um/include/shared/kern_util.h:54:12: error: conflicting types for '__cant_sleep'
>       54 | extern int __cant_sleep(void);
>          |            ^~~~~~~~~~~~
>    In file included from include/asm-generic/bug.h:20,
>                     from ./arch/um/include/generated/asm/bug.h:1,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/percpu.h:5,
>                     from include/linux/context_tracking_state.h:5,
>                     from include/linux/hardirq.h:5,
>                     from arch/um/kernel/process.c:11:
>    include/linux/kernel.h:103:13: note: previous declaration of '__cant_sleep' was here
>      103 | extern void __cant_sleep(const char *file, int line, int preempt_offset);
>          |             ^~~~~~~~~~~~
>    arch/um/kernel/process.c:49:5: warning: no previous prototype for 'pid_to_processor_id' [-Wmissing-prototypes]
>       49 | int pid_to_processor_id(int pid)
>          |     ^~~~~~~~~~~~~~~~~~~
>    arch/um/kernel/process.c:85:7: warning: no previous prototype for '__switch_to' [-Wmissing-prototypes]
>       85 | void *__switch_to(struct task_struct *from, struct task_struct *to)
>          |       ^~~~~~~~~~~
>    arch/um/kernel/process.c: In function 'new_thread_handler':
>    arch/um/kernel/process.c:120:21: warning: variable 'n' set but not used [-Wunused-but-set-variable]
>      120 |  int (*fn)(void *), n;
>          |                     ^
>    arch/um/kernel/process.c: At top level:
>    arch/um/kernel/process.c:138:6: warning: no previous prototype for 'fork_handler' [-Wmissing-prototypes]
>      138 | void fork_handler(void)
>          |      ^~~~~~~~~~~~
>    arch/um/kernel/process.c:214:6: warning: no previous prototype for 'arch_cpu_idle' [-Wmissing-prototypes]
>      214 | void arch_cpu_idle(void)
>          |      ^~~~~~~~~~~~~
> >> arch/um/kernel/process.c:221:5: error: conflicting types for '__cant_sleep'
>      221 | int __cant_sleep(void) {
>          |     ^~~~~~~~~~~~
>    In file included from include/asm-generic/bug.h:20,
>                     from ./arch/um/include/generated/asm/bug.h:1,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/percpu.h:5,
>                     from include/linux/context_tracking_state.h:5,
>                     from include/linux/hardirq.h:5,
>                     from arch/um/kernel/process.c:11:
>    include/linux/kernel.h:103:13: note: previous declaration of '__cant_sleep' was here
>      103 | extern void __cant_sleep(const char *file, int line, int preempt_offset);
>          |             ^~~~~~~~~~~~
>    arch/um/kernel/process.c:251:5: warning: no previous prototype for 'copy_to_user_proc' [-Wmissing-prototypes]
>      251 | int copy_to_user_proc(void __user *to, void *from, int size)
>          |     ^~~~~~~~~~~~~~~~~
>    arch/um/kernel/process.c:261:5: warning: no previous prototype for 'clear_user_proc' [-Wmissing-prototypes]
>      261 | int clear_user_proc(void __user *buf, int size)
>          |     ^~~~~~~~~~~~~~~
>    arch/um/kernel/process.c:274:6: warning: no previous prototype for 'set_using_sysemu' [-Wmissing-prototypes]
>      274 | void set_using_sysemu(int value)
>          |      ^~~~~~~~~~~~~~~~
>    arch/um/kernel/process.c:281:5: warning: no previous prototype for 'get_using_sysemu' [-Wmissing-prototypes]
>      281 | int get_using_sysemu(void)
>          |     ^~~~~~~~~~~~~~~~
>    arch/um/kernel/process.c:319:12: warning: no previous prototype for 'make_proc_sysemu' [-Wmissing-prototypes]
>      319 | int __init make_proc_sysemu(void)
>          |            ^~~~~~~~~~~~~~~~
>    arch/um/kernel/process.c:359:15: warning: no previous prototype for 'arch_align_stack' [-Wmissing-prototypes]
>      359 | unsigned long arch_align_stack(unsigned long sp)
>          |               ^~~~~~~~~~~~~~~~
> --
>    In file included from arch/um/kernel/reboot.c:12:
> >> arch/um/include/shared/kern_util.h:54:12: error: conflicting types for '__cant_sleep'
>       54 | extern int __cant_sleep(void);
>          |            ^~~~~~~~~~~~
>    In file included from include/linux/list.h:9,
>                     from include/linux/rculist.h:10,
>                     from include/linux/sched/signal.h:5,
>                     from arch/um/kernel/reboot.c:6:
>    include/linux/kernel.h:103:13: note: previous declaration of '__cant_sleep' was here
>      103 | extern void __cant_sleep(const char *file, int line, int preempt_offset);
>          |             ^~~~~~~~~~~~
>    arch/um/kernel/reboot.c:45:6: warning: no previous prototype for 'machine_restart' [-Wmissing-prototypes]
>       45 | void machine_restart(char * __unused)
>          |      ^~~~~~~~~~~~~~~
>    arch/um/kernel/reboot.c:51:6: warning: no previous prototype for 'machine_power_off' [-Wmissing-prototypes]
>       51 | void machine_power_off(void)
>          |      ^~~~~~~~~~~~~~~~~
>    arch/um/kernel/reboot.c:57:6: warning: no previous prototype for 'machine_halt' [-Wmissing-prototypes]
>       57 | void machine_halt(void)
>          |      ^~~~~~~~~~~~
> --
>    In file included from arch/um/kernel/signal.c:14:
> >> arch/um/include/shared/kern_util.h:54:12: error: conflicting types for '__cant_sleep'
>       54 | extern int __cant_sleep(void);
>          |            ^~~~~~~~~~~~
>    In file included from include/linux/list.h:9,
>                     from include/linux/module.h:12,
>                     from arch/um/kernel/signal.c:6:
>    include/linux/kernel.h:103:13: note: previous declaration of '__cant_sleep' was here
>      103 | extern void __cant_sleep(const char *file, int line, int preempt_offset);
>          |             ^~~~~~~~~~~~
> --
>    In file included from arch/um/kernel/time.c:20:
> >> arch/um/include/shared/kern_util.h:54:12: error: conflicting types for '__cant_sleep'
>       54 | extern int __cant_sleep(void);
>          |            ^~~~~~~~~~~~
>    In file included from include/linux/list.h:9,
>                     from include/linux/clocksource.h:15,
>                     from include/linux/clockchips.h:14,
>                     from arch/um/kernel/time.c:10:
>    include/linux/kernel.h:103:13: note: previous declaration of '__cant_sleep' was here
>      103 | extern void __cant_sleep(const char *file, int line, int preempt_offset);
>          |             ^~~~~~~~~~~~
>    arch/um/kernel/time.c:789:13: warning: no previous prototype for 'time_init' [-Wmissing-prototypes]
>      789 | void __init time_init(void)
>          |             ^~~~~~~~~
> --
>    In file included from arch/um/kernel/tlb.c:15:
> >> arch/um/include/shared/kern_util.h:54:12: error: conflicting types for '__cant_sleep'
>       54 | extern int __cant_sleep(void);
>          |            ^~~~~~~~~~~~
>    In file included from include/asm-generic/bug.h:20,
>                     from ./arch/um/include/generated/asm/bug.h:1,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/mm.h:9,
>                     from arch/um/kernel/tlb.c:6:
>    include/linux/kernel.h:103:13: note: previous declaration of '__cant_sleep' was here
>      103 | extern void __cant_sleep(const char *file, int line, int preempt_offset);
>          |             ^~~~~~~~~~~~
>    arch/um/kernel/tlb.c:317:6: warning: no previous prototype for 'fix_range_common' [-Wmissing-prototypes]
>      317 | void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
>          |      ^~~~~~~~~~~~~~~~
>    arch/um/kernel/tlb.c:579:6: warning: no previous prototype for 'flush_tlb_mm_range' [-Wmissing-prototypes]
>      579 | void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>          |      ^~~~~~~~~~~~~~~~~~
>    arch/um/kernel/tlb.c:595:6: warning: no previous prototype for 'force_flush_all' [-Wmissing-prototypes]
>      595 | void force_flush_all(void)
>          |      ^~~~~~~~~~~~~~~
> --
>    In file included from arch/um/kernel/trap.c:16:
> >> arch/um/include/shared/kern_util.h:54:12: error: conflicting types for '__cant_sleep'
>       54 | extern int __cant_sleep(void);
>          |            ^~~~~~~~~~~~
>    In file included from include/asm-generic/bug.h:20,
>                     from ./arch/um/include/generated/asm/bug.h:1,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/mm.h:9,
>                     from arch/um/kernel/trap.c:6:
>    include/linux/kernel.h:103:13: note: previous declaration of '__cant_sleep' was here
>      103 | extern void __cant_sleep(const char *file, int line, int preempt_offset);
>          |             ^~~~~~~~~~~~
>    arch/um/kernel/trap.c:315:6: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
>      315 | void trap_init(void)
>          |      ^~~~~~~~~
> --
>    In file included from arch/um/kernel/um_arch.c:25:
> >> arch/um/include/shared/kern_util.h:54:12: error: conflicting types for '__cant_sleep'
>       54 | extern int __cant_sleep(void);
>          |            ^~~~~~~~~~~~
>    In file included from include/linux/delay.h:22,
>                     from arch/um/kernel/um_arch.c:6:
>    include/linux/kernel.h:103:13: note: previous declaration of '__cant_sleep' was here
>      103 | extern void __cant_sleep(const char *file, int line, int preempt_offset);
>          |             ^~~~~~~~~~~~
>    arch/um/kernel/um_arch.c:359:19: warning: no previous prototype for 'read_initrd' [-Wmissing-prototypes]
>      359 | int __init __weak read_initrd(void)
>          |                   ^~~~~~~~~~~
>    arch/um/kernel/um_arch.c:377:13: warning: no previous prototype for 'check_bugs' [-Wmissing-prototypes]
>      377 | void __init check_bugs(void)
>          |             ^~~~~~~~~~
>    arch/um/kernel/um_arch.c:387:7: warning: no previous prototype for 'text_poke' [-Wmissing-prototypes]
>      387 | void *text_poke(void *addr, const void *opcode, size_t len)
>          |       ^~~~~~~~~
>    arch/um/kernel/um_arch.c:399:6: warning: no previous prototype for 'text_poke_sync' [-Wmissing-prototypes]
>      399 | void text_poke_sync(void)
>          |      ^~~~~~~~~~~~~~
> --
>    In file included from arch/um/kernel/skas/syscall.c:9:
> >> arch/um/include/shared/kern_util.h:54:12: error: conflicting types for '__cant_sleep'
>       54 | extern int __cant_sleep(void);
>          |            ^~~~~~~~~~~~
>    In file included from arch/um/kernel/skas/syscall.c:6:
>    include/linux/kernel.h:103:13: note: previous declaration of '__cant_sleep' was here
>      103 | extern void __cant_sleep(const char *file, int line, int preempt_offset);
>          |             ^~~~~~~~~~~~
>    In file included from arch/um/include/asm/processor-generic.h:13,
>                     from arch/x86/um/asm/processor.h:41,
>                     from include/linux/rcupdate.h:30,
>                     from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from include/linux/ptrace.h:6,
>                     from arch/um/kernel/skas/syscall.c:7:
>    arch/um/kernel/skas/syscall.c: In function 'handle_syscall':
>    arch/x86/um/shared/sysdep/syscalls_64.h:18:4: warning: cast between incompatible function types from 'long int (*)(void)' to 'long int (*)(long int,  long int,  long int,  long int,  long int,  long int)' [-Wcast-function-type]
>       18 |  (((long (*)(long, long, long, long, long, long)) \
>          |    ^
>    arch/x86/um/asm/ptrace.h:36:62: note: in definition of macro 'PT_REGS_SET_SYSCALL_RETURN'
>       36 | #define PT_REGS_SET_SYSCALL_RETURN(r, res) (PT_REGS_AX(r) = (res))
>          |                                                              ^~~
>    arch/um/kernel/skas/syscall.c:46:5: note: in expansion of macro 'EXECUTE_SYSCALL'
>       46 |     EXECUTE_SYSCALL(syscall, regs));
>          |     ^~~~~~~~~~~~~~~
> 
> 
> vim +/__cant_sleep +54 arch/um/include/shared/kern_util.h
> 
> 5cb38bc47bf3705 arch/um/include/kern_util.h        Jeff Dike                      2006-06-04  49  
> edea138584d7586 arch/um/include/kern_util.h        Jeff Dike                      2008-02-04  50  /*
> edea138584d7586 arch/um/include/kern_util.h        Jeff Dike                      2008-02-04  51   * Are we disallowed to sleep? Used to choose between GFP_KERNEL and
> edea138584d7586 arch/um/include/kern_util.h        Jeff Dike                      2008-02-04  52   * GFP_ATOMIC.
> edea138584d7586 arch/um/include/kern_util.h        Jeff Dike                      2008-02-04  53   */
> b63162939cd797c arch/um/include/kern_util.h        Paolo 'Blaisorblade' Giarrusso 2006-01-18 @54  extern int __cant_sleep(void);
> c2220b2a124d2fe arch/um/include/shared/kern_util.h Al Viro                        2012-01-30  55  extern int get_current_pid(void);
> edea138584d7586 arch/um/include/kern_util.h        Jeff Dike                      2008-02-04  56  extern int copy_from_user_proc(void *to, void *from, int size);
> edea138584d7586 arch/um/include/kern_util.h        Jeff Dike                      2008-02-04  57  extern int cpu(void);
> edea138584d7586 arch/um/include/kern_util.h        Jeff Dike                      2008-02-04  58  extern char *uml_strdup(const char *string);
> edea138584d7586 arch/um/include/kern_util.h        Jeff Dike                      2008-02-04  59  
> 
> :::::: The code at line 54 was first introduced by commit
> :::::: b63162939cd797c8269964ce856ed1f2fec5f70e [PATCH] uml: avoid malloc to sleep in atomic sections
> 
> :::::: TO: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> :::::: CC: Linus Torvalds <torvalds@g5.osdl.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


