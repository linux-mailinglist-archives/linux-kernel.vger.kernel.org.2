Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BBF30D18D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhBCC3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBCC3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:29:08 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3D9C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 18:28:28 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q20so15669243pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 18:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=HnzPpOzgB6GpoPKygr8yIDPTQcszOo6lFCt60Q8mrDw=;
        b=rrLIZEY7ctIYh57bi/f2BbLRcKllUsJM9qOstCYgM+izVvC4mcVlQ7+kGDgrTHtqPV
         Y/z+rhwFLqJXYcPJHosYQmhM+TFYgGs1ds5FhF98GplhbAiiGClgL+5F8uMOBGbhNJTK
         JV4VR/S07O46PI7KE3doHRGmAPIPvWLIHJWGk33u8bXlQso+a03anMxjGzzECFvyUw8g
         wd38mJC4QjhtmGki6nkHqSF/YFsLqzGaHb4kFVmKVcxQEMNJlGjSqI8YLCPASR2e8TjH
         BwE5FExLJhwncE5ADpXbDcQvtXjzwX0gRLJ4pvCi9XvGqs3f9jpt281/WLINmsMQ2GvE
         SHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=HnzPpOzgB6GpoPKygr8yIDPTQcszOo6lFCt60Q8mrDw=;
        b=MMfDSkETXZ8wnQDdeo+vjmDOtMEyoS1hHZ9svAXOig/yysvxMsLWJQ5EvHzKNI1XSR
         kOWuE3DFebvJYIYHnVkPgdzlCrb8PozT64PLlRvX7zJcg75vZFLPuAeq688Y/FnZ6ME6
         eLHfcBidpGmn/HrY6diWXswtdJE9LKHDNDicVEAn/RDhmsq54uCQZOFwe3TERONPvtZF
         jz67sqe29TvHCIA/pqNhtgtSym4o6rcWLTnYIjWc5IDLDgwmqGLPTkc32eM8kFAi12GF
         zpX15JLg6oPgJ9bvxUplEucbx4paijD2m8yNt8o35sHBCCHolIJA3Ihy6W7WS0h3C1My
         pVqA==
X-Gm-Message-State: AOAM531qjVFUVnz8/Agi39QxUJcvYktgJxjF9SgE7DBG6ZNoXYYYqiP4
        qnXrq1ekvPzur4/A8fyKglR0F8hPZAuvIg==
X-Google-Smtp-Source: ABdhPJwgwhY9sJINzIUxS1EdkapgwboT89Kb6iYvWqaunSTbCtijUkcOGIfgoKmZ3tehNnF5AmrVPA==
X-Received: by 2002:a62:64c9:0:b029:1b9:6b48:7901 with SMTP id y192-20020a6264c90000b02901b96b487901mr1079161pfb.0.1612319307638;
        Tue, 02 Feb 2021 18:28:27 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a22sm286923pjh.5.2021.02.02.18.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 18:28:27 -0800 (PST)
Date:   Tue, 02 Feb 2021 18:28:27 -0800 (PST)
X-Google-Original-Date: Tue, 02 Feb 2021 18:20:03 PST (-0800)
Subject:     Re: [PATCH v4] RISC-V: Implement ASID allocator
In-Reply-To: <20210121135016.34718-1-anup.patel@wdc.com>
Message-ID: <mhng-c559982c-2b4c-4270-8b42-5ad5fdb3d1dd@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 05:50:16 PST (-0800), Anup Patel wrote:
> Currently, we do local TLB flush on every MM switch. This is very harsh on
> performance because we are forcing page table walks after every MM switch.
>
> This patch implements ASID allocator for assigning an ASID to a MM context.
> The number of ASIDs are limited in HW so we create a logical entity named
> CONTEXTID for assigning to MM context. The lower bits of CONTEXTID are ASID
> and upper bits are VERSION number. The number of usable ASID bits supported
> by HW are detected at boot-time by writing 1s to ASID bits in SATP CSR.
>
> We allocate new CONTEXTID on first MM switch for a MM context where the
> ASID is allocated from an ASID bitmap and VERSION is provide by an atomic
> counter. At time of allocating new CONTEXTID, if we run out of available
> ASIDs then:
> 1. We flush the ASID bitmap
> 2. Increment current VERSION atomic counter
> 3. Re-allocate ASID from ASID bitmap
> 4. Flush TLB on all CPUs
> 5. Try CONTEXTID re-assignment on all CPUs
>
> Please note that we don't use ASID #0 because it is used at boot-time by
> all CPUs for initial MM context. Also, newly created context is always
> assigned CONTEXTID #0 (i.e. VERSION #0 and ASID #0) which is an invalid
> context in our implementation.
>
> Using above approach, we have virtually infinite CONTEXTIDs on-top-of
> limited number of HW ASIDs. This approach is inspired from ASID allocator
> used for Linux ARM/ARM64 but we have adapted it for RISC-V. Overall, this
> ASID allocator helps us reduce rate of local TLB flushes on every CPU
> thereby increasing performance.
>
> This patch is tested on QEMU virt machine, Spike and SiFive Unleashed
> board. On QEMU virt machine, we see some (3-5% approx) performance
> improvement with SW emulated TLBs provided by QEMU. Unfortunately,
> the ASID bits of the SATP CSR are not implemented on Spike and SiFive
> Unleashed board so we don't see any change in performance. On real
> HW having all ASID bits implemented, the performance gains will be
> much more due improved sharing of TLB among different processes.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
> Changes since v3:
> - Rebased on Linux-5.11-rc4. The previous v3 patch (almost 2 years back)
>   was basd on Linux-5.1-rc2
> - Updated implementation to consider NoMMU kernel
> - Converted use_asid_allocator boolean flag into static key
> - Improved boot-time print in asids_init() to show number of ASID bits
> - Access SATP CSR by number instead of old CSR name "sptbr"
>
> Changes since v2:
> - Move to lazy TLB flushing because we get slow path warnings if we
>   use flush_tlb_all()
> - Don't set ASID bits to all 1s in head.s. Instead just do it on
>   boot CPU calling asids_init() for determining number of HW ASID bits
> - Make CONTEXT version comparison more readable in set_mm_asid()
> - Fix typo in __flush_context()
>
> Changes since v1:
> - We adapt good aspects from Gary Guo's ASID allocator implementation
>   and provide due credit to him by adding his SoB.
> - Track ASIDs active during context flush and mark them as reserved
> - Set ASID bits to all 1s to simplify number of ASID bit detection
> - Use atomic_long_t instead of atomic64_t for being 32bit friendly
> - Use unsigned long instead of u64 for being 32bit friendly
> - Use flush_tlb_all() instead of lazy local_tlb_flush_all() at time
>   of context flush
>
> This patch is based on Linux-5.11-rc4 and can be found in the
> riscv_asid_allocator_v4 branch of https://github.com/avpatel/linux.git
> ---
>  arch/riscv/include/asm/csr.h         |   6 +
>  arch/riscv/include/asm/mmu.h         |   2 +
>  arch/riscv/include/asm/mmu_context.h |  10 +
>  arch/riscv/mm/context.c              | 261 ++++++++++++++++++++++++++-
>  4 files changed, 275 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index cec462e198ce..caadfc1d7487 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -41,10 +41,16 @@
>  #define SATP_PPN	_AC(0x003FFFFF, UL)
>  #define SATP_MODE_32	_AC(0x80000000, UL)
>  #define SATP_MODE	SATP_MODE_32
> +#define SATP_ASID_BITS	9
> +#define SATP_ASID_SHIFT	22
> +#define SATP_ASID_MASK	_AC(0x1FF, UL)
>  #else
>  #define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UL)
>  #define SATP_MODE_39	_AC(0x8000000000000000, UL)
>  #define SATP_MODE	SATP_MODE_39
> +#define SATP_ASID_BITS	16
> +#define SATP_ASID_SHIFT	44
> +#define SATP_ASID_MASK	_AC(0xFFFF, UL)
>  #endif
>
>  /* Exception cause high bit - is an interrupt if set */
> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index dabcf2cfb3dc..0099dc116168 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -12,6 +12,8 @@
>  typedef struct {
>  #ifndef CONFIG_MMU
>  	unsigned long	end_brk;
> +#else
> +	atomic_long_t id;
>  #endif
>  	void *vdso;
>  #ifdef CONFIG_SMP
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index 250defa06f3a..b0659413a080 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -23,6 +23,16 @@ static inline void activate_mm(struct mm_struct *prev,
>  	switch_mm(prev, next, NULL);
>  }
>
> +#define init_new_context init_new_context
> +static inline int init_new_context(struct task_struct *tsk,
> +			struct mm_struct *mm)
> +{
> +#ifdef CONFIG_MMU
> +	atomic_long_set(&mm->context.id, 0);
> +#endif
> +	return 0;
> +}
> +
>  #include <asm-generic/mmu_context.h>
>
>  #endif /* _ASM_RISCV_MMU_CONTEXT_H */
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 613ec81a8979..6216fed8f9cc 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -2,13 +2,269 @@
>  /*
>   * Copyright (C) 2012 Regents of the University of California
>   * Copyright (C) 2017 SiFive
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
>   */
>
> +#include <linux/bitops.h>
> +#include <linux/cpumask.h>
>  #include <linux/mm.h>
> +#include <linux/percpu.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/static_key.h>
>  #include <asm/tlbflush.h>
>  #include <asm/cacheflush.h>
>  #include <asm/mmu_context.h>
>
> +#ifdef CONFIG_MMU
> +
> +static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
> +
> +static unsigned long asid_bits;
> +static unsigned long num_asids;
> +static unsigned long asid_mask;
> +
> +static atomic_long_t current_version;
> +
> +static DEFINE_RAW_SPINLOCK(context_lock);
> +static cpumask_t context_tlb_flush_pending;
> +static unsigned long *context_asid_map;
> +
> +static DEFINE_PER_CPU(atomic_long_t, active_context);
> +static DEFINE_PER_CPU(unsigned long, reserved_context);
> +
> +static bool check_update_reserved_context(unsigned long cntx,
> +					  unsigned long newcntx)
> +{
> +	int cpu;
> +	bool hit = false;
> +
> +	/*
> +	 * Iterate over the set of reserved CONTEXT looking for a match.
> +	 * If we find one, then we can update our mm to use new CONTEXT
> +	 * (i.e. the same CONTEXT in the current_version) but we can't
> +	 * exit the loop early, since we need to ensure that all copies
> +	 * of the old CONTEXT are updated to reflect the mm. Failure to do
> +	 * so could result in us missing the reserved CONTEXT in a future
> +	 * version.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		if (per_cpu(reserved_context, cpu) == cntx) {
> +			hit = true;
> +			per_cpu(reserved_context, cpu) = newcntx;
> +		}
> +	}
> +
> +	return hit;
> +}
> +
> +/* Note: must be called with context_lock held */

These are usually better expressed as lockdep assertions.  I don't see any 
reason why they wouldn't work here.

> +static void __flush_context(void)
> +{
> +	int i;
> +	unsigned long cntx;
> +
> +	/* Update the list of reserved ASIDs and the ASID bitmap. */
> +	bitmap_clear(context_asid_map, 0, num_asids);
> +
> +	/* Mark already active ASIDs as used */
> +	for_each_possible_cpu(i) {
> +		cntx = atomic_long_xchg_relaxed(&per_cpu(active_context, i), 0);
> +		/*
> +		 * If this CPU has already been through a rollover, but
> +		 * hasn't run another task in the meantime, we must preserve
> +		 * its reserved CONTEXT, as this is the only trace we have of
> +		 * the process it is still running.
> +		 */
> +		if (cntx == 0)
> +			cntx = per_cpu(reserved_context, i);
> +
> +		__set_bit(cntx & asid_mask, context_asid_map);
> +		per_cpu(reserved_context, i) = cntx;
> +	}
> +
> +	/* Mark ASID #0 as used because it is used at boot-time */
> +	__set_bit(0, context_asid_map);
> +
> +	/* Queue a TLB invalidation for each CPU on next context-switch */
> +	cpumask_setall(&context_tlb_flush_pending);
> +}
> +
> +/* Note: must be called with context_lock held */
> +static unsigned long __new_context(struct mm_struct *mm)
> +{
> +	static u32 cur_idx = 1;
> +	unsigned long cntx = atomic_long_read(&mm->context.id);
> +	unsigned long asid, ver = atomic_long_read(&current_version);
> +
> +	if (cntx != 0) {
> +		unsigned long newcntx = ver | (cntx & asid_mask);
> +
> +		/*
> +		 * If our current CONTEXT was active during a rollover, we
> +		 * can continue to use it and this was just a false alarm.
> +		 */
> +		if (check_update_reserved_context(cntx, newcntx))
> +			return newcntx;
> +
> +		/*
> +		 * We had a valid CONTEXT in a previous life, so try to
> +		 * re-use it if possible.
> +		 */
> +		if (!__test_and_set_bit(cntx & asid_mask, context_asid_map))
> +			return newcntx;
> +	}
> +
> +	/*
> +	 * Allocate a free ASID. If we can't find one then increment
> +	 * current_version and flush all ASIDs.
> +	 */
> +	asid = find_next_zero_bit(context_asid_map, num_asids, cur_idx);
> +	if (asid != num_asids)
> +		goto set_asid;
> +
> +	/* We're out of ASIDs, so increment current_version */
> +	ver = atomic_long_add_return_relaxed(num_asids, &current_version);
> +
> +	/* Flush everything  */
> +	__flush_context();
> +
> +	/* We have more ASIDs than CPUs, so this will always succeed */
> +	asid = find_next_zero_bit(context_asid_map, num_asids, 1);
> +
> +set_asid:
> +	__set_bit(asid, context_asid_map);
> +	cur_idx = asid;
> +	return asid | ver;
> +}
> +
> +static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
> +{
> +	unsigned long flags;
> +	bool need_flush_tlb = false;
> +	unsigned long cntx, old_active_cntx;
> +
> +	cntx = atomic_long_read(&mm->context.id);
> +
> +	/*
> +	 * If our active_context is non-zero and the context matches the
> +	 * current_version, then we update the active_context entry with a
> +	 * relaxed cmpxchg.
> +	 *
> +	 * Following is how we handle racing with a concurrent rollover:
> +	 *
> +	 * - We get a zero back from the cmpxchg and end up waiting on the
> +	 *   lock. Taking the lock synchronises with the rollover and so
> +	 *   we are forced to see the updated verion.
> +	 *
> +	 * - We get a valid context back from the cmpxchg then we continue
> +	 *   using old ASID because __flush_context() would have marked ASID
> +	 *   of active_context as used and next context switch we will
> +	 *   allocate new context.
> +	 */
> +	old_active_cntx = atomic_long_read(&per_cpu(active_context, cpu));
> +	if (old_active_cntx &&
> +	    ((cntx & ~asid_mask) == atomic_long_read(&current_version)) &&
> +	    atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu),
> +					old_active_cntx, cntx))
> +		goto switch_mm_fast;
> +
> +	raw_spin_lock_irqsave(&context_lock, flags);
> +
> +	/* Check that our ASID belongs to the current_version. */
> +	cntx = atomic_long_read(&mm->context.id);
> +	if ((cntx & ~asid_mask) != atomic_long_read(&current_version)) {
> +		cntx = __new_context(mm);
> +		atomic_long_set(&mm->context.id, cntx);
> +	}
> +
> +	if (cpumask_test_and_clear_cpu(cpu, &context_tlb_flush_pending))
> +		need_flush_tlb = true;
> +
> +	atomic_long_set(&per_cpu(active_context, cpu), cntx);
> +
> +	raw_spin_unlock_irqrestore(&context_lock, flags);
> +
> +switch_mm_fast:
> +	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
> +		  ((cntx & asid_mask) << SATP_ASID_SHIFT) |
> +		  SATP_MODE);
> +
> +	if (need_flush_tlb)
> +		local_flush_tlb_all();
> +}
> +
> +static void set_mm_noasid(struct mm_struct *mm)
> +{
> +	/* Switch the page table and blindly nuke entire local TLB */
> +	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) | SATP_MODE);
> +	local_flush_tlb_all();
> +}
> +
> +static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> +{
> +	if (static_branch_unlikely(&use_asid_allocator))
> +		set_mm_asid(mm, cpu);
> +	else
> +		set_mm_noasid(mm);
> +}
> +
> +static int asids_init(void)
> +{
> +	unsigned long old;
> +
> +	/* Figure-out number of ASID bits in HW */
> +	old = csr_read(CSR_SATP);
> +	asid_bits = old | (SATP_ASID_MASK << SATP_ASID_SHIFT);
> +	csr_write(CSR_SATP, asid_bits);
> +	asid_bits = (csr_read(CSR_SATP) >> SATP_ASID_SHIFT)  & SATP_ASID_MASK;
> +	asid_bits = fls_long(asid_bits);
> +	csr_write(CSR_SATP, old);
> +
> +	/*
> +	 * In the process of determining number of ASID bits (above)
> +	 * we polluted the TLB of current HART so let's do TLB flushed
> +	 * to remove unwanted TLB enteries.
> +	 */
> +	local_flush_tlb_all();
> +
> +	/* Pre-compute ASID details */
> +	num_asids = 1 << asid_bits;
> +	asid_mask = num_asids - 1;
> +
> +	/*
> +	 * Use ASID allocator only if number of HW ASIDs are
> +	 * at-least twice more than CPUs
> +	 */
> +	if (num_asids > (2 * num_possible_cpus())) {
> +		atomic_long_set(&current_version, num_asids);
> +
> +		context_asid_map = kcalloc(BITS_TO_LONGS(num_asids),
> +				   sizeof(*context_asid_map), GFP_KERNEL);
> +		if (!context_asid_map)
> +			panic("Failed to allocate bitmap for %lu ASIDs\n",
> +			      num_asids);
> +
> +		__set_bit(0, context_asid_map);
> +
> +		static_branch_enable(&use_asid_allocator);
> +
> +		pr_info("ASID allocator using %lu bits (%lu entries)\n",
> +			asid_bits, num_asids);
> +	} else {
> +		pr_info("ASID allocator disabled\n");
> +	}
> +
> +	return 0;
> +}
> +early_initcall(asids_init);
> +#else
> +static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> +{
> +	/* Nothing to do here when there is no MMU */
> +}
> +#endif
> +
>  /*
>   * When necessary, performs a deferred icache flush for the given MM context,
>   * on the local CPU.  RISC-V has no direct mechanism for instruction cache
> @@ -58,10 +314,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	cpumask_clear_cpu(cpu, mm_cpumask(prev));
>  	cpumask_set_cpu(cpu, mm_cpumask(next));
>
> -#ifdef CONFIG_MMU
> -	csr_write(CSR_SATP, virt_to_pfn(next->pgd) | SATP_MODE);
> -	local_flush_tlb_all();
> -#endif
> +	set_mm(next, cpu);
>
>  	flush_icache_deferred(next);
>  }

So I know we'd said before that we weren't going to take this until there's 
hardware, but I think the QEMU support is good enough -- I don't really care if 
the ISA says this might change, it's been in there for long enough.

Aside from the assertions

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

LMK if you're going to send a v5 or you want me to just fix it up.

Thanks!
