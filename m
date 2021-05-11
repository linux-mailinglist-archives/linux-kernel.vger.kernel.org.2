Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C580937A390
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhEKJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:26:46 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58506 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231409AbhEKJ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:26:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UYXcT31_1620725135;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UYXcT31_1620725135)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 May 2021 17:25:36 +0800
Subject: Re: [patch 1/2 v2] x86/cpu: Init AP exception handling from
 cpu_init_secondary()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>
References: <20210507110210.147106915@linutronix.de>
 <20210507114000.429303187@linutronix.de>
 <ccbd2f11-bb74-19bd-cf5c-d524625f9a0d@linux.alibaba.com>
 <87wns8ko48.ffs@nanos.tec.linutronix.de>
 <87k0o6gtvu.ffs@nanos.tec.linutronix.de>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <d5a7434c-9205-b6c6-c7ad-423e7050bc62@linux.alibaba.com>
Date:   Tue, 11 May 2021 17:25:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87k0o6gtvu.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/11 05:29, Thomas Gleixner wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> SEV-ES guests require properly setup task register with which the TSS
> descriptor in the GDT can be located so that the IST-type #VC exception
> handler which they need to function properly, can be executed.
> 
> This setup needs to happen before attempting to load microcode in
> ucode_cpu_init() on secondary CPUs which can cause such #VC exceptions.
> 
> Simplify the machinery by running that exception setup from a new function
> cpu_init_secondary() and explicitly call cpu_init_exception_handling() for
> the boot CPU before cpu_init(). The latter prepares for fixing and
> simplifying the exception/IST setup on the boot CPU.
> 
> There should be no functional changes resulting from this patch.
> 
> [ tglx: Reworked it so cpu_init_exception_handling() stays seperate ]
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


For both patches:

Reviewed-by: Lai Jiangshan <laijs@linux.alibaba.com>

> ---
> V2: Utilize cpu_init_secondary() - Lai
> ---
>   arch/x86/include/asm/processor.h |    1 +
>   arch/x86/kernel/cpu/common.c     |   24 +++++++++++-------------
>   arch/x86/kernel/smpboot.c        |    3 +--
>   arch/x86/kernel/traps.c          |    4 +---
>   4 files changed, 14 insertions(+), 18 deletions(-)
> 
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -663,6 +663,7 @@ extern void load_direct_gdt(int);
>   extern void load_fixmap_gdt(int);
>   extern void load_percpu_segment(int);
>   extern void cpu_init(void);
> +extern void cpu_init_secondary(void);
>   extern void cpu_init_exception_handling(void);
>   extern void cr4_init(void);
>   
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1938,13 +1938,12 @@ void cpu_init_exception_handling(void)
>   
>   /*
>    * cpu_init() initializes state that is per-CPU. Some data is already
> - * initialized (naturally) in the bootstrap process, such as the GDT
> - * and IDT. We reload them nevertheless, this function acts as a
> - * 'CPU state barrier', nothing should get across.
> + * initialized (naturally) in the bootstrap process, such as the GDT.  We
> + * reload it nevertheless, this function acts as a 'CPU state barrier',
> + * nothing should get across.
>    */
>   void cpu_init(void)
>   {
> -	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
>   	struct task_struct *cur = current;
>   	int cpu = raw_smp_processor_id();
>   
> @@ -1957,8 +1956,6 @@ void cpu_init(void)
>   	    early_cpu_to_node(cpu) != NUMA_NO_NODE)
>   		set_numa_node(early_cpu_to_node(cpu));
>   #endif
> -	setup_getcpu(cpu);
> -
>   	pr_debug("Initializing CPU#%d\n", cpu);
>   
>   	if (IS_ENABLED(CONFIG_X86_64) || cpu_feature_enabled(X86_FEATURE_VME) ||
> @@ -1970,7 +1967,6 @@ void cpu_init(void)
>   	 * and set up the GDT descriptor:
>   	 */
>   	switch_to_new_gdt(cpu);
> -	load_current_idt();
>   
>   	if (IS_ENABLED(CONFIG_X86_64)) {
>   		loadsegment(fs, 0);
> @@ -1990,12 +1986,6 @@ void cpu_init(void)
>   	initialize_tlbstate_and_flush();
>   	enter_lazy_tlb(&init_mm, cur);
>   
> -	/* Initialize the TSS. */
> -	tss_setup_ist(tss);
> -	tss_setup_io_bitmap(tss);
> -	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
> -
> -	load_TR_desc();
>   	/*
>   	 * sp0 points to the entry trampoline stack regardless of what task
>   	 * is running.
> @@ -2017,6 +2007,14 @@ void cpu_init(void)
>   	load_fixmap_gdt(cpu);
>   }
>   
> +#ifdef CONFIG_SMP
> +void cpu_init_secondary(void)
> +{
> +	cpu_init_exception_handling();
> +	cpu_init();
> +}
> +#endif
> +
>   /*
>    * The microcode loader calls this upon late microcode load to recheck features,
>    * only when microcode has been updated. Caller holds microcode_mutex and CPU
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -232,8 +232,7 @@ static void notrace start_secondary(void
>   	load_cr3(swapper_pg_dir);
>   	__flush_tlb_all();
>   #endif
> -	cpu_init_exception_handling();
> -	cpu_init();
> +	cpu_init_secondary();
>   	rcu_cpu_starting(raw_smp_processor_id());
>   	x86_cpuinit.early_percpu_clock_init();
>   	preempt_disable();
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -1162,9 +1162,7 @@ void __init trap_init(void)
>   
>   	idt_setup_traps();
>   
> -	/*
> -	 * Should be a barrier for any external CPU state:
> -	 */
> +	cpu_init_exception_handling();
>   	cpu_init();
>   
>   	idt_setup_ist_traps();
> 
