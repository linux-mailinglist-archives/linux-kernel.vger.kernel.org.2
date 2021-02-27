Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C42C326CCE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 11:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhB0Kva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 05:51:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13022 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhB0KvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 05:51:23 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dnjsz3vy0zMfLt;
        Sat, 27 Feb 2021 18:48:07 +0800 (CST)
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.103.82) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Feb 2021 18:50:04 +0800
From:   Shaobo Huang <huangshaobo6@huawei.com>
To:     <huangshaobo6@huawei.com>
CC:     <chenzefeng2@huawei.com>, <gregkh@linuxfoundation.org>,
        <kepler.chenxin@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@arm.linux.org.uk>,
        <liucheng32@huawei.com>, <mhiramat@kernel.org>,
        <nixiaoming@huawei.com>, <tixy@linaro.org>, <xiaoqian9@huawei.com>,
        <young.liuyang@huawei.com>, <zengweilin@huawei.com>
Subject: Re: [PATCH 4.4.y] arm: kprobes: Allow to handle reentered kprobe on single-stepping
Date:   Sat, 27 Feb 2021 18:50:04 +0800
Message-ID: <20210227105004.14876-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210227091701.23944-1-huangshaobo6@huawei.com>
References: <20210227091701.23944-1-huangshaobo6@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.103.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> commit f3fbd7ec62dec1528fb8044034e2885f2b257941 upstream
> 
> This is arm port of commit 6a5022a56ac3 ("kprobes/x86: Allow to
> handle reentered kprobe on single-stepping")
> 
> Since the FIQ handlers can interrupt in the single stepping
> (or preparing the single stepping, do_debug etc.), we should
> consider a kprobe is hit in the NMI handler. Even in that
> case, the kprobe is allowed to be reentered as same as the
> kprobes hit in kprobe handlers
> (KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE).
> 
> The real issue will happen when a kprobe hit while another
> reentered kprobe is processing (KPROBE_REENTER), because
> we already consumed a saved-area for the previous kprobe.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Fixes: 24ba613c9d6c ("ARM kprobes: core code")
> Cc: stable@vger.kernel.org #v2.6.25~v4.11
> Signed-off-by: huangshaobo <huangshaobo6@huawei.com>

arm32 jprobe does not handle interrupt reentry correctly. When jprobe is
running in singlestep, jprobe is triggered again in system interrupt, it
will run to the BUG function to cause panic.

jprobe needs to enter the kprobe_handler function twice, the first time to
enter kprobe_handler to save the context environment; the second time to
enter kprobe_handler to simulate the replaced instruction and restore the
context environment of the probed function.But the system interrupt is not
closed when the kprobe_handler is entered for the second time in jprobe_return. 
the code of jprobe_return is as follows:
void __kprobes jprobe_return(void)
{
	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
	__asm__ __volatile__ (
		/*
		 * Setup an empty pt_regs. Fill SP and PC fields as
		 * they're needed by longjmp_break_handler.
		 *
		 * We allocate some slack between the original SP and start of
		 * our fabricated regs. To be precise we want to have worst case
		 * covered which is STMFD with all 16 regs so we allocate 2 *
		 * sizeof(struct_pt_regs)).
		 *
		 * This is to prevent any simulated instruction from writing
		 * over the regs when they are accessing the stack.
		 */
#ifdef CONFIG_THUMB2_KERNEL
		...
#else
		"sub    sp, %0, %1		\n\t"
#endif
		"ldr    r0, ="__stringify(JPROBE_MAGIC_ADDR)"\n\t"
		"str    %0, [sp, %2]		\n\t"
		"str    r0, [sp, %3]		\n\t"
		"mov    r0, sp			\n\t"
		"bl     kprobe_handler		\n\t"
 
		/*
		 * Return to the context saved by setjmp_pre_handler
		 * and restored by longjmp_break_handler.
		 */
#ifdef CONFIG_THUMB2_KERNEL
		...
#else
		"ldr	r0, [sp, %4]		\n\t"
		"msr	cpsr_cxsf, r0		\n\t"
		"ldmia	sp, {r0 - pc}		\n\t"
#endif
		:
		: "r" (kcb->jprobe_saved_regs.ARM_sp),
		  "I" (sizeof(struct pt_regs) * 2),
		  "J" (offsetof(struct pt_regs, ARM_sp)),
		  "J" (offsetof(struct pt_regs, ARM_pc)),
		  "J" (offsetof(struct pt_regs, ARM_cpsr)),
		  "J" (offsetof(struct pt_regs, ARM_lr))
		: "memory", "cc");
}
If the execution reaches the singlestep, the jprobe status is KPROBE_HIT_SS. 
If an interrupt is generated at this time, and jprobe is triggered again in
the interrupt, jprobe reentry will be generated, at this time 
kcb->kprobe_status==KPROBE_HIT_SS, Enter the default branch to execute the
BUG function, causing the system to panic. The partial code of kprobe_handler
is as follows:
void __kprobes kprobe_handler(struct pt_regs *regs)
{
        struct kprobe *p, *cur;
        struct kprobe_ctlblk *kcb;

        kcb = get_kprobe_ctlblk();
        cur = kprobe_running();

#ifdef CONFIG_THUMB2_KERNEL
        /*
         * First look for a probe which was registered using an address with
         * bit 0 set, this is the usual situation for pointers to Thumb code.
         * If not found, fallback to looking for one with bit 0 clear.
         */
        p = get_kprobe((kprobe_opcode_t *)(regs->ARM_pc | 1));
        if (!p)
                p = get_kprobe((kprobe_opcode_t *)regs->ARM_pc);

#else /* ! CONFIG_THUMB2_KERNEL */
        p = get_kprobe((kprobe_opcode_t *)regs->ARM_pc);
#endif

        if (p) {
                if (cur) {
                        /* Kprobe is pending, so we're recursing. */
                        switch (kcb->kprobe_status) {
                        case KPROBE_HIT_ACTIVE:
                        case KPROBE_HIT_SSDONE:
                                /* A pre- or post-handler probe got us here. */
                                kprobes_inc_nmissed_count(p);
                                save_previous_kprobe(kcb);
                                set_current_kprobe(p);
                                kcb->kprobe_status = KPROBE_REENTER;
                                singlestep(p, regs, kcb);
                                restore_previous_kprobe(kcb);
                                break;
                        default:
                                /* impossible cases */
				BUG();
……
}
At this time, it is necessary to increase the processing of the KPROBE_HIT_SS state,
that is, jprobe only executes the simulation instruction, and does not execute the
user callback function.

For example, use jprobe to register arm_dma_map_page, arm_dma_map_page will be called
by gmac_recv in the interrupt, the system will panic, and the log is as follows:
kernel BUG at arch/arm/probes/kprobes/core.c:296!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in:……
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O    4.4.236 #15
Hardware name: Hisilicon A15
task: c0a25220 task.stack: c0a00000
PC is at kprobe_handler+0x120/0x288
LR is at kprobe_handler+0x120/0x288
pc : [<c0597d24>]    lr : [<c0597d24>]    psr: 600f0193
sp : c0a01b08  ip : 00000007  fp : c0602088
r10: eeb1a26c  r9 : 2e2b1000  r8 : c0a32530
r7 : c0a01be8  r6 : c086926c  r5 : bf4c3000  r4 : c0869268
r3 : c0a2244c  r2 : 00000000  r1 : 00000104  r0 : 00000032
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 30c5387d  Table: 2c1dfd00  DAC: 55555555
Process swapper/0 (pid: 0, stack limit = 0xc0a00210)
Stack: (0xc0a01b08 to 0xc0a02000)
……
[<c0597d24>] (kprobe_handler) from [<c0597eb0>] (kprobe_trap_handler+0x24/0x48)
[<c0597eb0>] (kprobe_trap_handler) from [<c02011ac>] (do_undefinstr+0x1a8/0x234)
[<c02011ac>] (do_undefinstr) from [<c0596b30>] (__und_svc_finish+0x0/0x30)
Exception stack(0xc0a01be8 to 0xc0a01c30)
1be0:                   ed8523f8 ef1cdc20 00000540 00000080 eaac8540 00000080
1c00: c02159ec c0a265e0 00000002 00000000 bf3f9000 c0602088 0002b4c8 c0a01c78
1c20: bf3e4b38 c02159ec a00f0113 ffffffff
[<c0596b30>] (__und_svc_finish) from [<c02159ec>] (arm_dma_map_page+0x0/0xe4)
[<c02159ec>] (arm_dma_map_page) from [<c0597e54>] (kprobe_handler+0x250/0x288)
[<c0597e54>] (kprobe_handler) from [<bf3e56cc>] (gmac_recv+0xc0/0x858 [Drv_Gmac_K])
[<bf3e56cc>] (gmac_recv [Drv_Gmac_K]) from [<c04f96e4>] (net_rx_action+0x130/0x3d4)
[<c04f96e4>] (net_rx_action) from [<c02245bc>] (__do_softirq+0x1b0/0x418)
[<c02245bc>] (__do_softirq) from [<c0224b4c>] (irq_exit+0xc0/0x188)
[<c0224b4c>] (irq_exit) from [<c0247604>] (msa_irq_exit+0x130/0x220)
[<c0247604>] (msa_irq_exit) from [<c027283c>] (__handle_domain_irq+0xec/0x1b4)
[<c027283c>] (__handle_domain_irq) from [<c0201580>] (gic_handle_irq+0xcc/0x104)
[<c0201580>] (gic_handle_irq) from [<c0596a40>] (__irq_svc+0x40/0x58)
Exception stack(0xc0a01e78 to 0xc0a01ec0)
1e60:                                                       00000000 c0a32530
1e80: 2e2b1000 c0869268 c0a72500 00000000 e9a7f4a8 c0a25220 c0591b08 00000040
1ea0: c0a22a34 c0a01f34 00000000 c0a01ec8 c02c08e0 c044a498 200f0013 ffffffff
[<c0596a40>] (__irq_svc) from [<c044a498>] (debug_smp_processor_id+0x0/0x14)
[<c044a498>] (debug_smp_processor_id) from [<c02c08e0>] (kprobe_busy_begin+0x38/0x6c)
[<c02c08e0>] (kprobe_busy_begin) from [<c02c09bc>] (kprobe_flush_task+0x38/0x120)
[<c02c09bc>] (kprobe_flush_task) from [<c024be9c>] (finish_task_switch+0x19c/0x2a4)
[<c024be9c>] (finish_task_switch) from [<c0591b08>] (__schedule+0x5a4/0x6b4)
[<c0591b08>] (__schedule) from [<c0591e00>] (schedule+0x98/0xc4)
[<c0591e00>] (schedule) from [<c05920b0>] (schedule_preempt_disabled+0x14/0x20)
[<c05920b0>] (schedule_preempt_disabled) from [<c026692c>] (cpu_startup_entry+0x3c/0x33c)
[<c026692c>] (cpu_startup_entry) from [<c058f030>] (rest_init+0xac/0xf0)
[<c058f030>] (rest_init) from [<c0800cb8>] (start_kernel+0x484/0x534)
Code: e59f016c ebf57071 e1a00005 ebf49e8a (e7f001f2) 
