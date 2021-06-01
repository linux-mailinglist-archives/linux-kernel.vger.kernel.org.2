Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A445F3974B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhFAN5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:57:24 -0400
Received: from foss.arm.com ([217.140.110.172]:50822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234017AbhFAN5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:57:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 567F96D;
        Tue,  1 Jun 2021 06:55:41 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.0.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ABEF3F719;
        Tue,  1 Jun 2021 06:55:37 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:55:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/5] arm64: perf: Enable PMU counter userspace access
 for perf event
Message-ID: <20210601135526.GA3326@C02TD0UTHF1T.local>
References: <20210517195405.3079458-1-robh@kernel.org>
 <20210517195405.3079458-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517195405.3079458-4-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 02:54:03PM -0500, Rob Herring wrote:
> Arm PMUs can support direct userspace access of counters which allows for
> low overhead (i.e. no syscall) self-monitoring of tasks. The same feature
> exists on x86 called 'rdpmc'. Unlike x86, userspace access will only be
> enabled for thread bound events. This could be extended if needed, but
> simplifies the implementation and reduces the chances for any
> information leaks (which the x86 implementation suffers from).
> 
> When an event is capable of userspace access and has been mmapped, userspace
> access is enabled when the event is scheduled on a CPU's PMU. There's some
> additional overhead clearing counters when disabled in order to prevent
> leaking disabled counter data from other tasks.
> 
> Unlike x86, enabling of userspace access must be requested with a new
> attr bit: config1:1. If the user requests userspace access and 64-bit
> counters, then chaining will be disabled and the user will get the
> maximum size counter the underlying h/w can support. The modes for
> config1 are as follows:
> 
> config1 = 0 : user access disabled and always 32-bit
> config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
> config1 = 2 : user access enabled and always 32-bit
> config1 = 3 : user access enabled and counter size matches underlying counter.
> 
> Based on work by Raphael Gault <raphael.gault@arm.com>, but has been
> completely re-written.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

[...]

> +static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
> +{
> +	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
> +
> +	if (!bitmap_empty(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS)) {
> +		int i;
> +		/* Don't need to clear assigned counters. */
> +		bitmap_xor(cpuc->dirty_mask, cpuc->dirty_mask, cpuc->used_mask, ARMPMU_MAX_HWEVENTS);
> +
> +		for_each_set_bit(i, cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS) {
> +			if (i == ARMV8_IDX_CYCLE_COUNTER)
> +				write_sysreg(0, pmccntr_el0);
> +			else
> +				armv8pmu_write_evcntr(i, 0);
> +		}
> +		bitmap_zero(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS);
> +	}
> +
> +	write_sysreg(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR, pmuserenr_el0);
> +}

This still leaks the values of CPU-bound events, or task-bound events
owned by others, right?

[...]

> +static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR) || (atomic_read(&event->mmap_count) != 1))
> +		return;
> +
> +	if (atomic_inc_return(&event->ctx->nr_user) == 1) {
> +		unsigned long flags;
> +		atomic_inc(&event->pmu->sched_cb_usage);
> +		local_irq_save(flags);
> +		armv8pmu_enable_user_access(to_arm_pmu(event->pmu));
> +		local_irq_restore(flags);
> +	}
> +}
> +
> +static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR) || (atomic_read(&event->mmap_count) != 1))
> +		return;
> +
> +	if (atomic_dec_and_test(&event->ctx->nr_user)) {
> +		atomic_dec(&event->pmu->sched_cb_usage);
> +		armv8pmu_disable_user_access();
> +	}
>  }

We can open an event for task A, but call mmap()/munmap() for that event
from task B, which will do the enable/disable on task B rather than task
A. The core doesn't enforce that the mmap is performed on the same core,
so I don't think this is quite right, unfortunately.

I reckon we need to do something with task_function_call() to make this
happen in the context of the expected task.

Thanks,
Mark.
