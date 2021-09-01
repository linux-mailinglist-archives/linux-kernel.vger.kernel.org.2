Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E468E3FDD0D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245713AbhIANI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343663AbhIANIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:08:46 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF834C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 06:07:46 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso3339674ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:in-reply-to;
        bh=xXguGIE5AaTxBVbTWh6PFFsB74W41wGij5ft9pMuIBM=;
        b=ywzhlO/7xhpRsbb4RxW6/avX4DS9+RMjvM+07gz7+V9m24lN0riznTqv5u4gjL0Pls
         TH+sQTStwTAKLmUiR4bme38/Vs/ZoOmEdYIbCfxPMloPKoEjSWEsxUiZBf27CFYoSLAh
         ig54vGha7zxq4Z2Latgj5LiucFIy/N2pj+N/s4FmRg9MHwS1lYk+AOkJrVqAleaBnhI5
         hglIoZW/T6eYekzDZMuXknsnupmS8gnmIZ1+mJHRR/hhtCmNtrpuePRFrUkNFgveBElH
         CmFGqfbj8RmRGwPvi52VO+fIoALmZCQI30zOQFWYp1oSgVoRv0jPbJLJJfBjMxQ2eYd2
         2u5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:in-reply-to;
        bh=xXguGIE5AaTxBVbTWh6PFFsB74W41wGij5ft9pMuIBM=;
        b=EpyDOfoC/iiw2P6jhDge8bl1KUwbDNCZiHRT51ZPvY/F6hTkPd1BwyHT8ZrKGk09A4
         OAf6yUMcxtfc9SF5Js6DUUPmecIjEr4Af6/AtzB/UK4jEUqffXiJvgD+D94JgpF1ntNG
         DNAv0OZUVecEtCQ+WWOoPHIg0S9o10s9taKNZ8JOqNuSRat3vscP29T3XsafWe5prsxn
         DqjYNH6G9y6DTEvbChBbn7EXBTAhk5gAelGlj/AkA5jL6OUFelSSkL9p/eEc+KNZ4IS0
         zDPvN3J0YNhlOqcO3zNp4hvhbGpkIgyPPccQtI+BXXe8NpFq87WJ8NAuAtPeCuvC6yi8
         Dz7w==
X-Gm-Message-State: AOAM533z8HIps33teASUuvs9MD+vfSwuZ5v3jcKBSZsg/7hPcCGOVV6v
        8L6y9SbZmb+MvRVG1NGkGpdV/TJDX73SQQ==
X-Google-Smtp-Source: ABdhPJxCUkaJnawWP27xgQoB5lKc6zWp2IRIUzLRw6OcnYO0KvxpZCmr3ssXc/IfMDoyofR2eV3CDw==
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr28969272oth.135.1630501666024;
        Wed, 01 Sep 2021 06:07:46 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:75f3:24d3:3d19:7b05])
        by smtp.gmail.com with ESMTPSA id k23sm4377911ood.12.2021.09.01.06.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 06:07:45 -0700 (PDT)
Date:   Wed, 1 Sep 2021 08:07:44 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: x86/apic: Add extra serialization for non-serializing MSRs
Message-ID: <20210901130744.GF19171@minyard.net>
Reply-To: cminyard@mvista.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305174708.F77040DD@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kiszka reported that the x2apic_wrmsr_fence() function uses a
> plain "mfence" while the Intel SDM (10.12.3 MSR Access in x2APIC
> Mode) calls for "mfence;lfence".
> 
> Short summary: we have special MSRs that have weaker ordering
> than all the rest.  Add fencing consistent with current SDM
> recommendatrions.
> 
> This is not known to cause any issues in practice, only in
> theory.

This appears to not just be theoretical.  I was working a problem for a
customer running 52 and 104 core Intel-based Dell machine.  After
looking at the coredumps a while, I realized the only common thread was
it seemed IPIs were very occasionally not working.  This was on a 3.10
based kernel.

I stumbled upon this patch, we tried it and the problems appear to have
gone away.

It appears to only happen on machines with a specific microcode version,
though we haven't tested enough to be 100% sure about that.  We had two
labs with different microcode versions.  One lab never experienced the
problem, the other had the issue occurring regularly.

Anyway, I thought I would add a report and thank you for the patch,
since it saved me a world of trouble.

-corey

> 
> Longer story below:
> 
> The reason the kernel uses a different semantic is that the SDM
> changed (roughly in late 2017).  The SDM changed because folks at
> Intel were auditing all of the recommended fences in the SDM and
> realized that the x2apic fences were insufficient.
> 
> Why was the pain "mfence" judged insufficient?
> 
> WRMSR itself is normally a serializing instruction.  No fences
> are needed because because the instruction itself serializes
> everything.
> 
> But, there are explicit exceptions for this serializing behavior
> written into the WRMSR instruction documentation for two classes
> of MSRs: IA32_TSC_DEADLINE and the X2APIC MSRs.
> 
> Back to x2apic: WRMSR is *not* serializing in this specific case.
> But why is MFENCE insufficient?  MFENCE makes writes visible, but
> only affects load/store instructions.  WRMSR is unfortunately not
> a load/store instruction and is unaffected by MEFNCE.  This means
> that a non-serializing WRMSR could be reordered by the CPU to
> execute before the writes made visible by the MFENCE have even
> occurred in the first place.
> 
> This mean that an x2apic IPI could theoretically be triggered
> before there is any (visible) data to process.
> 
> Does this affect anything in practice?  I honestly don't know.
> It seems quite possible that by the time an interrupt gets to
> consume the (not yet) MFENCE'd data, it has become visible,
> mostly by accident.
> 
> To be safe, add the SDM-recommended fences for all x2apic WRMSRs.
> 
> This also leaves open the question of the _other_ weakly-ordered
> WRMSR: MSR_IA32_TSC_DEADLINE.  While it has the same ordering
> architecture as the x2APIC MSRs, it seems substantially less
> likely to be a problem in practice.  While writes to the
> in-memory Local Vector Table (LVT) might theoretically be
> reordered with respect to a weakly-ordered WRMSR like
> TSC_DEADLINE, the SDM has this to say:
> 
> 	In x2APIC mode, the WRMSR instruction is used to write to
> 	the LVT entry. The processor ensures the ordering of this
> 	write and any subsequent WRMSR to the deadline; no
> 	fencing is required.
> 
> But, that might still leave xAPIC exposed.  The safest thing to
> do for now is to add the extra, recommended LFENCE.
> 
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: x86@kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> ---
> 
>  b/arch/x86/include/asm/apic.h           |   10 ----------
>  b/arch/x86/include/asm/barrier.h        |   18 ++++++++++++++++++
>  b/arch/x86/kernel/apic/apic.c           |    4 ++++
>  b/arch/x86/kernel/apic/x2apic_cluster.c |    6 ++++--
>  b/arch/x86/kernel/apic/x2apic_phys.c    |    9 ++++++---
>  b/tools/arch/x86/include/asm/barrier.h  |    1 +
>  6 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff -puN arch/x86/include/asm/apic.h~x2apic-wrmsr-serialization \
>                 arch/x86/include/asm/apic.h
> --- a/arch/x86/include/asm/apic.h~x2apic-wrmsr-serialization	2020-03-05 \
>                 09:42:38.876901038 -0800
> +++ b/arch/x86/include/asm/apic.h	2020-03-05 09:42:38.891901038 -0800
> @@ -195,16 +195,6 @@ static inline bool apic_needs_pit(void)
>  #endif /* !CONFIG_X86_LOCAL_APIC */
> 
>  #ifdef CONFIG_X86_X2APIC
> -/*
> - * Make previous memory operations globally visible before
> - * sending the IPI through x2apic wrmsr. We need a serializing instruction or
> - * mfence for this.
> - */
> -static inline void x2apic_wrmsr_fence(void)
> -{
> -	asm volatile("mfence" : : : "memory");
> -}
> -
>  static inline void native_apic_msr_write(u32 reg, u32 v)
>  {
>  	if (reg == APIC_DFR || reg == APIC_ID || reg == APIC_LDR ||
> diff -puN arch/x86/include/asm/barrier.h~x2apic-wrmsr-serialization \
>                 arch/x86/include/asm/barrier.h
> --- a/arch/x86/include/asm/barrier.h~x2apic-wrmsr-serialization	2020-03-05 \
>                 09:42:38.878901038 -0800
> +++ b/arch/x86/include/asm/barrier.h	2020-03-05 09:42:38.893901038 -0800
> @@ -84,4 +84,22 @@ do {									\
> 
>  #include <asm-generic/barrier.h>
> 
> +/*
> + * Make previous memory operations globally visible before
> + * a WRMSR.
> + *
> + * MFENCE makes writes visible, but only affects load/store
> + * instructions.  WRMSR is unfortunately not a load/store
> + * instruction and is unaffected by MEFNCE.  The LFENCE ensures
> + * that the WRMSR is not reordered.
> + *
> + * Most WRMSRs are full serializing instructions themselves and
> + * do not require this barrier.  This is only required for the
> + * IA32_TSC_DEADLINE and X2APIC MSRs.
> + */
> +static inline void weak_wrmsr_fence(void)
> +{
> +	asm volatile("mfence; lfence" : : : "memory");
> +}
> +
>  #endif /* _ASM_X86_BARRIER_H */
> diff -puN arch/x86/kernel/apic/apic.c~x2apic-wrmsr-serialization \
>                 arch/x86/kernel/apic/apic.c
> --- a/arch/x86/kernel/apic/apic.c~x2apic-wrmsr-serialization	2020-03-05 \
>                 09:42:38.880901038 -0800
> +++ b/arch/x86/kernel/apic/apic.c	2020-03-05 09:42:38.892901038 -0800
> @@ -42,6 +42,7 @@
>  #include <asm/x86_init.h>
>  #include <asm/pgalloc.h>
>  #include <linux/atomic.h>
> +#include <asm/barrier.h>
>  #include <asm/mpspec.h>
>  #include <asm/i8259.h>
>  #include <asm/proto.h>
> @@ -474,6 +475,9 @@ static int lapic_next_deadline(unsigned
>  {
>  	u64 tsc;
> 
> +	/* This MSR is special and need a special fence: */
> +	weak_wrmsr_fence();
> +
>  	tsc = rdtsc();
>  	wrmsrl(MSR_IA32_TSC_DEADLINE, tsc + (((u64) delta) * TSC_DIVISOR));
>  	return 0;
> diff -puN arch/x86/kernel/apic/x2apic_cluster.c~x2apic-wrmsr-serialization \
>                 arch/x86/kernel/apic/x2apic_cluster.c
> --- a/arch/x86/kernel/apic/x2apic_cluster.c~x2apic-wrmsr-serialization	2020-03-05 \
>                 09:42:38.882901038 -0800
> +++ b/arch/x86/kernel/apic/x2apic_cluster.c	2020-03-05 09:42:38.892901038 -0800
> @@ -29,7 +29,8 @@ static void x2apic_send_IPI(int cpu, int
>  {
>  	u32 dest = per_cpu(x86_cpu_to_logical_apicid, cpu);
> 
> -	x2apic_wrmsr_fence();
> +	/* x2apic MSRs are special and need a special fence: */
> +	weak_wrmsr_fence();
>  	__x2apic_send_IPI_dest(dest, vector, APIC_DEST_LOGICAL);
>  }
> 
> @@ -41,7 +42,8 @@ __x2apic_send_IPI_mask(const struct cpum
>  	unsigned long flags;
>  	u32 dest;
> 
> -	x2apic_wrmsr_fence();
> +	/* x2apic MSRs are special and need a special fence: */
> +	weak_wrmsr_fence();
>  	local_irq_save(flags);
> 
>  	tmpmsk = this_cpu_cpumask_var_ptr(ipi_mask);
> diff -puN arch/x86/kernel/apic/x2apic_phys.c~x2apic-wrmsr-serialization \
>                 arch/x86/kernel/apic/x2apic_phys.c
> --- a/arch/x86/kernel/apic/x2apic_phys.c~x2apic-wrmsr-serialization	2020-03-05 \
>                 09:42:38.885901038 -0800
> +++ b/arch/x86/kernel/apic/x2apic_phys.c	2020-03-05 09:42:38.892901038 -0800
> @@ -37,7 +37,8 @@ static void x2apic_send_IPI(int cpu, int
>  {
>  	u32 dest = per_cpu(x86_cpu_to_apicid, cpu);
> 
> -	x2apic_wrmsr_fence();
> +	/* x2apic MSRs are special and need a special fence: */
> +	weak_wrmsr_fence();
>  	__x2apic_send_IPI_dest(dest, vector, APIC_DEST_PHYSICAL);
>  }
> 
> @@ -48,7 +49,8 @@ __x2apic_send_IPI_mask(const struct cpum
>  	unsigned long this_cpu;
>  	unsigned long flags;
> 
> -	x2apic_wrmsr_fence();
> +	/* x2apic MSRs are special and need a special fence: */
> +	weak_wrmsr_fence();
> 
>  	local_irq_save(flags);
> 
> @@ -116,7 +118,8 @@ void __x2apic_send_IPI_shorthand(int vec
>  {
>  	unsigned long cfg = __prepare_ICR(which, vector, 0);
> 
> -	x2apic_wrmsr_fence();
> +	/* x2apic MSRs are special and need a special fence: */
> +	weak_wrmsr_fence();
>  	native_x2apic_icr_write(cfg, 0);
>  }
> 
> diff -puN tools/arch/x86/include/asm/barrier.h~x2apic-wrmsr-serialization \
>                 tools/arch/x86/include/asm/barrier.h
> --- a/tools/arch/x86/include/asm/barrier.h~x2apic-wrmsr-serialization	2020-03-05 \
>                 09:42:38.887901038 -0800
> +++ b/tools/arch/x86/include/asm/barrier.h	2020-03-05 09:42:38.892901038 -0800
> @@ -43,4 +43,5 @@ do {						\
>  	___p1;					\
>  })
>  #endif /* defined(__x86_64__) */
> +
>  #endif /* _TOOLS_LINUX_ASM_X86_BARRIER_H */
