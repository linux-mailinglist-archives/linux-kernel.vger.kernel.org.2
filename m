Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753C63DA3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbhG2NVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:21:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:49902 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237381AbhG2NVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="298462306"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="298462306"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 06:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="476389400"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jul 2021 06:21:03 -0700
Received: from [10.209.86.210] (kliang2-MOBL.ccr.corp.intel.com [10.209.86.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4739A580871;
        Thu, 29 Jul 2021 06:21:02 -0700 (PDT)
Subject: Re: [perf] fuzzer triggers unchecked MSR access error: WRMSR to 0x318
To:     Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>
References: <37881148-a43e-5fd4-817c-a875adc7a15f@maine.edu>
 <YQJxka3dxgdIdebG@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <45bee582-0f89-5125-82e7-92caf8b741ea@linux.intel.com>
Date:   Thu, 29 Jul 2021 09:21:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQJxka3dxgdIdebG@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/2021 5:14 AM, Peter Zijlstra wrote:
> On Wed, Jul 28, 2021 at 12:49:43PM -0400, Vince Weaver wrote:
>> [32694.087403] unchecked MSR access error: WRMSR to 0x318 (tried to write 0x0000000000000000) at rIP: 0xffffffff8106f854 (native_write_msr+0x4/0x20)
>> [32694.101374] Call Trace:
>> [32694.103974]  perf_clear_dirty_counters+0x86/0x100
> 
> Hmm.. if I read this right that's MSR_ARCH_PERFMON_FIXED_CTR0 + i, given
> that FIXED_CTR0 is 0x309 that gives i == 15, which is FIXED_BTS.
> 
> I'm thinking something like this ought to cure things.
> 
> ---
>   arch/x86/events/core.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 1eb45139fcc6..04edf8017961 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2489,13 +2489,15 @@ void perf_clear_dirty_counters(void)
>   		return;
>   
>   	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
> -		/* Metrics and fake events don't have corresponding HW counters. */
> -		if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
> -			continue;
> -		else if (i >= INTEL_PMC_IDX_FIXED)
> +		if (i >= INTEL_PMC_IDX_FIXED) {
> +			/* Metrics and fake events don't have corresponding HW counters. */
> +			if ((i - INTEL_PMC_IDX_FIXED) >= x86_pmu.num_counters_fixed)

Yes, the fix is better. My previous implementation tries to pick up all 
the special cases. It's very likely to miss some special cases like 
FIXED_BTS and probably any new fake events added later if there are.
Thanks for the fix.

The x86_pmu.num_counters_fixed should work well on HSW. But we have 
hybrid machines now. I think we can use
hybrid(cpuc->pmu, num_counters_fixed) instead, which should be more 
accurate.


Thanks,
Kan

> +				continue;
> +
>   			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
> -		else
> +		} else {
>   			wrmsrl(x86_pmu_event_addr(i), 0);
> +		}
>   	}
>   
>   	bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
> 
