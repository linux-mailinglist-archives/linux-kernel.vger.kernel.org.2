Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0091036634A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 03:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhDUBIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 21:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233836AbhDUBIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 21:08:17 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6C56140D;
        Wed, 21 Apr 2021 01:07:42 +0000 (UTC)
Date:   Tue, 20 Apr 2021 21:07:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [tracing]  9c0dee54eb:
 WARNING:at_kernel/tracepoint.c:#tracepoint_probe_register_prio
Message-ID: <20210420210739.605ed08a@oasis.local.home>
In-Reply-To: <20210419145912.GC24761@xsang-OptiPlex-9020>
References: <20210419145912.GC24761@xsang-OptiPlex-9020>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Added the Perf folks as this is a perf event probe. From the call trace:

[   59.695946] ------------[ cut here ]------------
[   59.696788] WARNING: CPU: 0 PID: 1199 at kernel/tracepoint.c:143 tracepoint_probe_register_prio+0x2f0/0x360
[   59.698385] Modules linked in: rapl input_leds qemu_fw_cfg processor tiny_power_button button
[   59.699838] CPU: 0 PID: 1199 Comm: trinity-main Not tainted 5.11.0-11078-g9c0dee54eb91 #1
[   59.701200] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   59.702602] EIP: tracepoint_probe_register_prio+0x2f0/0x360
[   59.703513] Code: ff e9 84 fe ff ff 8d 74 26 00 b8 20 00 00 00 e9 d4 fd ff ff 8d b6 00 00 00 00 83 c0 0c 89 d1 8d 14 06 e9 00 ff ff ff 8d 76 00 <0f> 0b be ea ff ff ff e9 52 fe ff ff 8d 74
 26 00 c7 04 24 74 70 ef
[   59.706455] EAX: 00000001 EBX: de493f00 ECX: ffffffff EDX: c253911c
[   59.707517] ESI: 00000000 EDI: de4967c8 EBP: ddc49e14 ESP: ddc49dec
[   59.708516] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
[   59.709649] CR0: 80050033 CR2: 08b58040 CR3: 1dc4d000 CR4: 000006d0
[   59.710654] Call Trace:
[   59.711098]  tracepoint_probe_register+0x17/0x20
[   59.711818]  trace_event_reg+0xb0/0x140
[   59.712461]  perf_trace_event_init+0x3ac/0x640
[   59.713203]  ? trace_event_buffer_reserve+0x140/0x140
[   59.714028]  perf_trace_init+0xda/0x180
[   59.714680]  perf_tp_event_init+0x1d/0x50
[   59.715381]  perf_try_init_event+0x41/0x120
[   59.716111]  perf_event_alloc+0x389/0xe10
[   59.716836]  ? perf_event_alloc+0x3a2/0xe10
[   59.717506]  __do_sys_perf_event_open+0x138/0xee0
[   59.718323]  ? sched_clock+0x11/0x20
[   59.718950]  ? sched_clock_cpu+0x1e/0xf0
[   59.719614]  __ia32_sys_perf_event_open+0x21/0x30
[   59.720347]  do_int80_syscall_32+0x27/0x40
[   59.721087]  entry_INT80_32+0x128/0x128

The warning is here:

func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
	 int prio)
{
	struct tracepoint_func *old, *new;
	int iter_probes;	/* Iterate over old probe array. */
	int nr_probes = 0;	/* Counter for probes */
	int pos = -1;		/* Insertion position into new array */

	if (WARN_ON(!tp_func->func))
		return ERR_PTR(-EINVAL);

Where that func is passed in by:

trace_event_reg() {
[..]
#ifdef CONFIG_PERF_EVENTS
	case TRACE_REG_PERF_REGISTER:
		return tracepoint_probe_register(call->tp,
						 call->class->perf_probe,
						 call);

The function is that class->perf_probe, which looks to be created at
boot up in include/trace/trace_events.h:

#define _TRACE_PERF_INIT(call)						\
	.perf_probe		= perf_trace_##call,

So, I have no idea how that became NULL.

Perhaps there was some event that was created that wasn't initialized?

-- Steve



On Mon, 19 Apr 2021 22:59:12 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 9c0dee54eb91d48cca048bd7bd2c1f4a166e0252 ("tracing: add error_report_end trace point")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: trinity
> version: trinity-i386
> with following parameters:
> 
> 	number: 99999
> 	group: group-02
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +----------------------------------------------------------------+------------+------------+
> |                                                                | 35beccf092 | 9c0dee54eb |
> +----------------------------------------------------------------+------------+------------+
> | boot_failures                                                  | 0          | 11         |
> | WARNING:at_kernel/tracepoint.c:#tracepoint_probe_register_prio | 0          | 11         |
> | EIP:tracepoint_probe_register_prio                             | 0          | 11         |
> +----------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   59.696788] WARNING: CPU: 0 PID: 1199 at kernel/tracepoint.c:143 tracepoint_probe_register_prio (kbuild/src/consumer/kernel/tracepoint.c:143 kbuild/src/consumer/kernel/tracepoint.c:289 kbuild/src/consumer/kernel/tracepoint.c:369) 
> [   59.698385] Modules linked in: rapl input_leds qemu_fw_cfg processor tiny_power_button button
> [   59.699838] CPU: 0 PID: 1199 Comm: trinity-main Not tainted 5.11.0-11078-g9c0dee54eb91 #1
> [   59.701200] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   59.702602] EIP: tracepoint_probe_register_prio (kbuild/src/consumer/kernel/tracepoint.c:143 kbuild/src/consumer/kernel/tracepoint.c:289 kbuild/src/consumer/kernel/tracepoint.c:369) 
> [ 59.703513] Code: ff e9 84 fe ff ff 8d 74 26 00 b8 20 00 00 00 e9 d4 fd ff ff 8d b6 00 00 00 00 83 c0 0c 89 d1 8d 14 06 e9 00 ff ff ff 8d 76 00 <0f> 0b be ea ff ff ff e9 52 fe ff ff 8d 74 26 00 c7 04 24 74 70 ef
> All code
> ========
>    0:	ff                   	(bad)  
>    1:	e9 84 fe ff ff       	jmpq   0xfffffffffffffe8a
>    6:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>    a:	b8 20 00 00 00       	mov    $0x20,%eax
>    f:	e9 d4 fd ff ff       	jmpq   0xfffffffffffffde8
>   14:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
>   1a:	83 c0 0c             	add    $0xc,%eax
>   1d:	89 d1                	mov    %edx,%ecx
>   1f:	8d 14 06             	lea    (%rsi,%rax,1),%edx
>   22:	e9 00 ff ff ff       	jmpq   0xffffffffffffff27
>   27:	8d 76 00             	lea    0x0(%rsi),%esi
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	be ea ff ff ff       	mov    $0xffffffea,%esi
>   31:	e9 52 fe ff ff       	jmpq   0xfffffffffffffe88
>   36:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>   3a:	c7                   	.byte 0xc7
>   3b:	04 24                	add    $0x24,%al
>   3d:	74 70                	je     0xaf
>   3f:	ef                   	out    %eax,(%dx)
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	be ea ff ff ff       	mov    $0xffffffea,%esi
>    7:	e9 52 fe ff ff       	jmpq   0xfffffffffffffe5e
>    c:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>   10:	c7                   	.byte 0xc7
>   11:	04 24                	add    $0x24,%al
>   13:	74 70                	je     0x85
>   15:	ef                   	out    %eax,(%dx)
> [   59.706455] EAX: 00000001 EBX: de493f00 ECX: ffffffff EDX: c253911c
> [   59.707517] ESI: 00000000 EDI: de4967c8 EBP: ddc49e14 ESP: ddc49dec
> [   59.708516] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [   59.709649] CR0: 80050033 CR2: 08b58040 CR3: 1dc4d000 CR4: 000006d0
> [   59.710654] Call Trace:
> [   59.711098] tracepoint_probe_register (kbuild/src/consumer/kernel/tracepoint.c:390) 
> [   59.711818] trace_event_reg (kbuild/src/consumer/kernel/trace/trace_events.c:302) 
> [   59.712461] perf_trace_event_init (kbuild/src/consumer/kernel/trace/trace_event_perf.c:130 kbuild/src/consumer/kernel/trace/trace_event_perf.c:204) 
> [   59.713203] ? trace_event_buffer_reserve (kbuild/src/consumer/kernel/trace/trace_events.c:285) 
> [   59.714028] perf_trace_init (kbuild/src/consumer/kernel/trace/trace_event_perf.c:228) 
> [   59.714680] perf_tp_event_init (kbuild/src/consumer/kernel/events/core.c:9571) 
> [   59.715381] perf_try_init_event (kbuild/src/consumer/kernel/events/core.c:11038) 
> [   59.716111] perf_event_alloc (kbuild/src/consumer/kernel/events/core.c:11091 kbuild/src/consumer/kernel/events/core.c:11370) 
> [   59.716836] ? perf_event_alloc (kbuild/src/consumer/arch/x86/include/asm/preempt.h:80 kbuild/src/consumer/include/linux/rcupdate.h:68 kbuild/src/consumer/include/linux/rcupdate.h:654 kbuild/src/consumer/kernel/events/core.c:11086 kbuild/src/consumer/kernel/events/core.c:11370) 
> [   59.717506] __do_sys_perf_event_open (kbuild/src/consumer/kernel/events/core.c:11852) 
> [   59.718323] ? sched_clock (kbuild/src/consumer/arch/x86/include/asm/paravirt.h:22 kbuild/src/consumer/arch/x86/kernel/tsc.c:252) 
> [   59.718950] ? sched_clock_cpu (kbuild/src/consumer/kernel/sched/clock.c:371) 
> [   59.719614] __ia32_sys_perf_event_open (kbuild/src/consumer/kernel/events/core.c:11742) 
> [   59.720347] do_int80_syscall_32 (kbuild/src/consumer/arch/x86/entry/common.c:77 kbuild/src/consumer/arch/x86/entry/common.c:94) 
> [   59.721087] entry_INT80_32 (kbuild/src/consumer/arch/x86/entry/entry_32.S:1064) 
> [   59.721741] EIP: 0x809b132
> [ 59.722195] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 6c 94 a8 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 94 94 a8 08 85
> All code
> ========
>    0:	89 c8                	mov    %ecx,%eax
>    2:	c3                   	retq   
>    3:	90                   	nop
>    4:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>    8:	85 c0                	test   %eax,%eax
>    a:	c7 01 01 00 00 00    	movl   $0x1,(%rcx)
>   10:	75 d8                	jne    0xffffffffffffffea
>   12:	a1 6c 94 a8 08 eb d1 	movabs 0x9066d1eb08a8946c,%eax
>   19:	66 90 
>   1b:	66 90                	xchg   %ax,%ax
>   1d:	66 90                	xchg   %ax,%ax
>   1f:	66 90                	xchg   %ax,%ax
>   21:	66 90                	xchg   %ax,%ax
>   23:	66 90                	xchg   %ax,%ax
>   25:	66 90                	xchg   %ax,%ax
>   27:	90                   	nop
>   28:	cd 80                	int    $0x80
>   2a:*	c3                   	retq   		<-- trapping instruction
>   2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
>   31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
>   38:	8b 10                	mov    (%rax),%edx
>   3a:	a3                   	.byte 0xa3
>   3b:	94                   	xchg   %eax,%esp
>   3c:	94                   	xchg   %eax,%esp
>   3d:	a8 08                	test   $0x8,%al
>   3f:	85                   	.byte 0x85
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	c3                   	retq   
>    1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
>    7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
>    e:	8b 10                	mov    (%rax),%edx
>   10:	a3                   	.byte 0xa3
>   11:	94                   	xchg   %eax,%esp
>   12:	94                   	xchg   %eax,%esp
>   13:	a8 08                	test   $0x8,%al
>   15:	85                   	.byte 0x85
> [   59.725256] EAX: ffffffda EBX: 08b58a18 ECX: 00000000 EDX: ffffffff
> [   59.726331] ESI: ffffffff EDI: 00000008 EBP: 6d656d35 ESP: bf90b438
> [   59.727427] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000282
> [   59.728590] irq event stamp: 1120537
> [   59.729228] hardirqs last enabled at (1120547): console_unlock (kbuild/src/consumer/kernel/printk/printk.c:2605 (discriminator 1)) 
> [   59.730545] hardirqs last disabled at (1120554): console_unlock (kbuild/src/consumer/kernel/printk/printk.c:2520 (discriminator 1)) 
> [   59.731839] softirqs last enabled at (1117094): __do_softirq (kbuild/src/consumer/arch/x86/include/asm/preempt.h:27 kbuild/src/consumer/kernel/softirq.c:373) 
> [   59.733227] softirqs last disabled at (1116961): do_softirq_own_stack (kbuild/src/consumer/arch/x86/kernel/irq_32.c:60 kbuild/src/consumer/arch/x86/kernel/irq_32.c:149) 
> [   59.734602] ---[ end trace f47a1114b4ceb835 ]---
> [   59.735399] ------------[ cut here ]------------
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.11.0-11078-g9c0dee54eb91 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 

