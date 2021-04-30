Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7A336FA50
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 14:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhD3MfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 08:35:07 -0400
Received: from foss.arm.com ([217.140.110.172]:46966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhD3MfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:35:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8AA61063;
        Fri, 30 Apr 2021 05:34:14 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.5.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02A183F70D;
        Fri, 30 Apr 2021 05:34:10 -0700 (PDT)
Date:   Fri, 30 Apr 2021 13:34:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yang Jihong <yangjihong1@huawei.com>, will@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux@armlinux.org.uk, suzuki.poulose@arm.com,
        julien.thierry.kdev@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: Fix write counter incorrect in ARMv7 big-endian
 mode
Message-ID: <20210430123408.GD53304@C02TD0UTHF1T.local>
References: <20210430012659.232110-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430012659.232110-1-yangjihong1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 09:26:59AM +0800, Yang Jihong wrote:
> Commit 3a95200d3f89a ("arm_pmu: Change API to support 64bit counter values")
> changes the input "value" type from 32-bit to 64-bit,
> which introduces the following problem:
> ARMv7 PMU counters is 32-bit width, in big-endian mode, write counter uses
> high 32-bit, which writes an incorrect value.

It might be worth noting that the reason for this is that when a 64-bit
value is split across two 32-bit registers, the high/low halves are
split to match how LDRD would load a 64-bit quantity (and so differs
across big/little endian), but the "r" constraint consistently uses the
first of the two regiseters.

Given that, this patch makes sense to me (and I didn't spot any related
issues), so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Will, I assume you'll pick this up.

Mark.

> 
> Before:
> 
>  Performance counter stats for 'ls':
> 
>               2.22 msec task-clock                #    0.675 CPUs utilized
>                  0      context-switches          #    0.000 K/sec
>                  0      cpu-migrations            #    0.000 K/sec
>                 49      page-faults               #    0.022 M/sec
>         2150476593      cycles                    #  966.663 GHz
>         2148588788      instructions              #    1.00  insn per cycle
>         2147745484      branches                  # 965435.074 M/sec
>         2147508540      branch-misses             #   99.99% of all branches
> 
> None of the above hw event counters are correct.
> 
> Solution:
> 
> "value" forcibly converted to 32-bit type before being written to PMU register.
> 
> After:
> 
>  Performance counter stats for 'ls':
> 
>               2.09 msec task-clock                #    0.681 CPUs utilized
>                  0      context-switches          #    0.000 K/sec
>                  0      cpu-migrations            #    0.000 K/sec
>                 46      page-faults               #    0.022 M/sec
>            2807301      cycles                    #    1.344 GHz
>            1060159      instructions              #    0.38  insn per cycle
>             250496      branches                  #  119.914 M/sec
>              23192      branch-misses             #    9.26% of all branches
> 
> Fixes: 3a95200d3f89a ("arm_pmu: Change API to support 64bit counter values")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  arch/arm/kernel/perf_event_v7.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index 2924d7910b10..eb2190477da1 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -773,10 +773,10 @@ static inline void armv7pmu_write_counter(struct perf_event *event, u64 value)
>  		pr_err("CPU%u writing wrong counter %d\n",
>  			smp_processor_id(), idx);
>  	} else if (idx == ARMV7_IDX_CYCLE_COUNTER) {
> -		asm volatile("mcr p15, 0, %0, c9, c13, 0" : : "r" (value));
> +		asm volatile("mcr p15, 0, %0, c9, c13, 0" : : "r" ((u32)value));
>  	} else {
>  		armv7_pmnc_select_counter(idx);
> -		asm volatile("mcr p15, 0, %0, c9, c13, 2" : : "r" (value));
> +		asm volatile("mcr p15, 0, %0, c9, c13, 2" : : "r" ((u32)value));
>  	}
>  }
>  
> -- 
> 2.30.GIT
> 
