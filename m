Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9B34EC82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhC3Pbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232419AbhC3Pbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:31:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6C6A619A7;
        Tue, 30 Mar 2021 15:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617118293;
        bh=yj0NqfKTS8xUdXO9ZweCNBVdzJcJ4cpcj+ORFSo1ilI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVtqN0yqbVq6gTVnJmIspc8s02WYIS6F6dsskUtHJyowkKNsi0glsMi7i5D82RVq7
         bORYM9cJXDfwCNJGA9SDbG6/qCx3mTbOjGrfBmBJjc6QfQ0Q7KD5w58e/x2c7Df/wo
         Ngf1A9Ij7wNw9D1mX/D6KwSQBBiAklifGLom+hvDIYr0+K3IECITiNgNiuqN8s2iea
         8elXSuD4+2eOxxVxXQ3M66mrqoXGQ4DoWeJzVd6kp9hgsAJUBEpxn/sdjO/DGjbhDu
         t1MdO4zEJ4S+rH1W6FzGkjXetyvnqQAQ3VEErOENv3kmLxaoCBmC3el75PvmRSJ0g2
         6pdPB7q9RAs0g==
Date:   Tue, 30 Mar 2021 16:31:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/10] arm64: perf: Enable PMU counter direct access
 for perf event
Message-ID: <20210330153125.GC6567@willie-the-truck>
References: <20210311000837.3630499-1-robh@kernel.org>
 <20210311000837.3630499-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311000837.3630499-3-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:08:29PM -0700, Rob Herring wrote:
> From: Raphael Gault <raphael.gault@arm.com>
> 
> Keep track of event opened with direct access to the hardware counters
> and modify permissions while they are open.
> 
> The strategy used here is the same which x86 uses: every time an event
> is mapped, the permissions are set if required. The atomic field added
> in the mm_context helps keep track of the different event opened and
> de-activate the permissions when all are unmapped.
> We also need to update the permissions in the context switch code so
> that tasks keep the right permissions.
> 
> In order to enable 64-bit counters for userspace when available, a new
> config1 bit is added for userspace to indicate it wants userspace counter
> access. This bit allows the kernel to decide if chaining should be
> disabled and chaining and userspace access are incompatible.
> The modes for config1 are as follows:
> 
> config1 = 0 or 2 : user access enabled and always 32-bit
> config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
> config1 = 3 : user access enabled and counter size matches underlying counter.

In this last case, how does userspace know whether it got a 32-bit or a
64-bit counter?

> User access is enabled with config1 == 0 so that we match x86 behavior
> and don't need Arm specific code (outside the counter read).
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I'm not completely sure if using current->active_mm in an IPI is okay?
> It seems to work in my testing.
> 
> Peter Z says (event->oncpu == smp_processor_id()) in the user page
> update is always true, but my testing says otherwise[1].

Peter? Sounds like there's either a misunderstanding here or we have some
fundamental issue elsewhere.

> v6:
>  - Add new attr.config1 rdpmc bit for userspace to hint it wants
>    userspace access when also requesting 64-bit counters.
> 
> v5:
>  - Only set cap_user_rdpmc if event is on current cpu
>  - Limit enabling/disabling access to CPUs associated with the PMU
>    (supported_cpus) and with the mm_struct matching current->active_mm.
> 
> v2:
>  - Move mapped/unmapped into arm64 code. Fixes arm32.
>  - Rebase on cap_user_time_short changes
> 
> Changes from Raphael's v4:
>   - Drop homogeneous check
>   - Disable access for chained counters
>   - Set pmc_width in user page
> 
> [1] https://lore.kernel.org/lkml/CAL_JsqK+eKef5NaVnBfARCjRE3MYhfBfe54F9YHKbsTnWqLmLw@mail.gmail.com/
> 
> user fix
> ---
>  arch/arm64/include/asm/mmu.h         |  5 ++
>  arch/arm64/include/asm/mmu_context.h |  2 +
>  arch/arm64/include/asm/perf_event.h  | 14 +++++
>  arch/arm64/kernel/perf_event.c       | 86 +++++++++++++++++++++++++++-
>  4 files changed, 104 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 75beffe2ee8a..ee08447455da 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -18,6 +18,11 @@
>  
>  typedef struct {
>  	atomic64_t	id;
> +	/*
> +	 * non-zero if userspace have access to hardware
> +	 * counters directly.
> +	 */
> +	atomic_t	pmu_direct_access;
>  #ifdef CONFIG_COMPAT
>  	void		*sigpage;
>  #endif
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 70ce8c1d2b07..ccb5ff417b42 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -21,6 +21,7 @@
>  #include <asm/proc-fns.h>
>  #include <asm-generic/mm_hooks.h>
>  #include <asm/cputype.h>
> +#include <asm/perf_event.h>
>  #include <asm/sysreg.h>
>  #include <asm/tlbflush.h>
>  
> @@ -230,6 +231,7 @@ static inline void __switch_mm(struct mm_struct *next)
>  	}
>  
>  	check_and_switch_context(next);
> +	perf_switch_user_access(next);
>  }
>  
>  static inline void
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> index 60731f602d3e..112f3f63b79e 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -8,6 +8,7 @@
>  
>  #include <asm/stack_pointer.h>
>  #include <asm/ptrace.h>
> +#include <linux/mm_types.h>
>  
>  #define	ARMV8_PMU_MAX_COUNTERS	32
>  #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
> @@ -254,4 +255,17 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
>  	(regs)->pstate = PSR_MODE_EL1h;	\
>  }
>  
> +static inline void perf_switch_user_access(struct mm_struct *mm)
> +{
> +	if (!IS_ENABLED(CONFIG_PERF_EVENTS))
> +		return;

CONFIG_HW_PERF_EVENTS might be a better fit here.

> +
> +	if (atomic_read(&mm->context.pmu_direct_access)) {
> +		write_sysreg(ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR,
> +			     pmuserenr_el0);
> +	} else {
> +		write_sysreg(0, pmuserenr_el0);
> +	}
> +}
> +
>  #endif
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 387838496955..9ad3cc523ef4 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -288,15 +288,22 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
>  
>  PMU_FORMAT_ATTR(event, "config:0-15");
>  PMU_FORMAT_ATTR(long, "config1:0");
> +PMU_FORMAT_ATTR(rdpmc, "config1:1");
>  
>  static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
>  {
>  	return event->attr.config1 & 0x1;
>  }
>  
> +static inline bool armv8pmu_event_want_user_access(struct perf_event *event)
> +{
> +	return event->attr.config1 & 0x2;
> +}
> +
>  static struct attribute *armv8_pmuv3_format_attrs[] = {
>  	&format_attr_event.attr,
>  	&format_attr_long.attr,
> +	&format_attr_rdpmc.attr,
>  	NULL,
>  };
>  
> @@ -356,6 +363,7 @@ static inline bool armv8pmu_event_is_chained(struct perf_event *event)
>  	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
>  
>  	return !WARN_ON(idx < 0) &&
> +	       !armv8pmu_event_want_user_access(event) &&
>  	       armv8pmu_event_is_64bit(event) &&
>  	       !armv8pmu_has_long_event(cpu_pmu) &&
>  	       (idx != ARMV8_IDX_CYCLE_COUNTER);
> @@ -849,13 +857,17 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
>  	if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
>  		if (!test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
>  			return ARMV8_IDX_CYCLE_COUNTER;
> +		else if (armv8pmu_event_is_64bit(event) &&
> +			   armv8pmu_event_want_user_access(event) &&
> +			   !armv8pmu_has_long_event(cpu_pmu))
> +				return -EAGAIN;
>  	}
>  
>  	/*
>  	 * Otherwise use events counters
>  	 */
> -	if (armv8pmu_event_is_64bit(event) &&
> -	    !armv8pmu_has_long_event(cpu_pmu))
> +	if (armv8pmu_event_is_64bit(event) && !armv8pmu_has_long_event(cpu_pmu) &&
> +	    !armv8pmu_event_want_user_access(event))

This logic is duplicated in armv8pmu_event_is_chained(); can you split it
into a helper, please?

>  		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
>  	else
>  		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
> @@ -887,6 +899,46 @@ static int armv8pmu_access_event_idx(struct perf_event *event)
>  	return event->hw.idx;
>  }
>  
> +static void refresh_pmuserenr(void *mm)
> +{
> +	if (mm == current->active_mm)
> +		perf_switch_user_access(mm);
> +}
> +
> +static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> +
> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> +		return;
> +
> +	/*
> +	 * This function relies on not being called concurrently in two
> +	 * tasks in the same mm.  Otherwise one task could observe
> +	 * pmu_direct_access > 1 and return all the way back to
> +	 * userspace with user access disabled while another task is still
> +	 * doing on_each_cpu_mask() to enable user access.
> +	 *
> +	 * For now, this can't happen because all callers hold mmap_lock
> +	 * for write.  If this changes, we'll need a different solution.
> +	 */
> +	lockdep_assert_held_write(&mm->mmap_lock);
> +
> +	if (atomic_inc_return(&mm->context.pmu_direct_access) == 1)
> +		on_each_cpu_mask(&armpmu->supported_cpus, refresh_pmuserenr, mm, 1);
> +}

Why do we need to cross-call here? Seems like it would be a tonne simpler to
handle the trap. Is there a reason not to do that?

> +
> +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> +
> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> +		return;
> +
> +	if (atomic_dec_and_test(&mm->context.pmu_direct_access))
> +		on_each_cpu_mask(&armpmu->supported_cpus, refresh_pmuserenr, mm, 1);

Given that the pmu_direct_access field is global per-mm, won't this go
wrong if multiple PMUs are opened by the same process but only a subset
are exposed to EL0? Perhaps pmu_direct_access should be treated as a mask
rather than a counter, so that we can 'and' it with the supported_cpus for
the PMU we're dealing with.

> +}
> +
>  /*
>   * Add an event filter to a given event.
>   */
> @@ -980,9 +1032,23 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
>  				       &armv8_pmuv3_perf_cache_map,
>  				       ARMV8_PMU_EVTYPE_EVENT);
>  
> -	if (armv8pmu_event_is_64bit(event))
> +	if (armv8pmu_event_want_user_access(event) || !armv8pmu_event_is_64bit(event)) {
> +		event->hw.flags |= ARMPMU_EL0_RD_CNTR;

Why do you set this for all 32-bit events? The logic here feels like it
could with a bit of untangling.

> +		/*
> +		 * At this point, the counter is not assigned. If a 64-bit
> +		 * counter is requested, we must make sure the h/w has 64-bit
> +		 * counters if we set the event size to 64-bit because chaining
> +		 * is not supported with userspace access. This may still fail
> +		 * later on if the CPU cycle counter is in use.
> +		 */
> +		if (armv8pmu_event_is_64bit(event) &&
> +		    (armv8pmu_has_long_event(armpmu) ||
> +		     hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES))
> +			event->hw.flags |= ARMPMU_EVT_64BIT;
> +	} else if (armv8pmu_event_is_64bit(event))
>  		event->hw.flags |= ARMPMU_EVT_64BIT;
>  
> +
>  	/* Only expose micro/arch events supported by this PMU */
>  	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
>  	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
> @@ -1115,6 +1181,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>  	cpu_pmu->filter_match		= armv8pmu_filter_match;
>  
>  	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
> +	cpu_pmu->pmu.event_mapped	= armv8pmu_event_mapped;
> +	cpu_pmu->pmu.event_unmapped	= armv8pmu_event_unmapped;
>  
>  	cpu_pmu->name			= name;
>  	cpu_pmu->map_event		= map_event;
> @@ -1290,6 +1358,18 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	userpg->cap_user_time = 0;
>  	userpg->cap_user_time_zero = 0;
>  	userpg->cap_user_time_short = 0;
> +	userpg->cap_user_rdpmc = !!(event->hw.flags & ARMPMU_EL0_RD_CNTR) &&
> +		(event->oncpu == smp_processor_id());
> +
> +	if (userpg->cap_user_rdpmc) {
> +		struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +
> +		if (armv8pmu_event_is_64bit(event) &&
> +		    (armv8pmu_has_long_event(cpu_pmu) || (userpg->index == 32)))

The '32' here is the fake index for the cycle counter, right? I think that
was introduced in the previous patch, so let's add a #define for it.

Will
