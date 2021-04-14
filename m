Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8FD35F564
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349144AbhDNNrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:47:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:2756 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351655AbhDNNrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:47:33 -0400
IronPort-SDR: wEAMZhWrElRHwwoYAFSIetQHUvMOQlXXzQ+NJEWAPMCrl5rX6zhHUEQUDWJKCA+KITDSHYVBL1
 vY+q/zclwjNg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="258606108"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="258606108"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 06:47:08 -0700
IronPort-SDR: 0n4T3frXNxMxljFE/Wzw42wvVHemPO4TIrK/q0E4uua7r85/X/CIMBUnzp0YDtIFIqeOOpGgV2
 pvXFChZtVAWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="383684192"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2021 06:47:08 -0700
Received: from [10.209.105.172] (kliang2-MOBL.ccr.corp.intel.com [10.209.105.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7A981580021;
        Wed, 14 Apr 2021 06:47:07 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
To:     kernel test robot <lkp@intel.com>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, acme@kernel.org, ak@linux.intel.com,
        mark.rutland@arm.com, luto@amacapital.net, eranian@google.com,
        namhyung@kernel.org
References: <1618340250-29027-2-git-send-email-kan.liang@linux.intel.com>
 <202104140454.EDz6DV9M-lkp@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <ff3622c3-3fdd-9e94-17ca-f0bf8dd98544@linux.intel.com>
Date:   Wed, 14 Apr 2021 09:47:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <202104140454.EDz6DV9M-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2021 4:33 PM, kernel test robot wrote:
> Hi,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/perf/core]
> [also build test WARNING on tip/master linux/master linus/master v5.12-rc7 next-20210413]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/kan-liang-linux-intel-com/perf-x86-Move-cpuc-running-into-P4-specific-code/20210414-030649
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git cface0326a6c2ae5c8f47bd466f07624b3e348a7
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>          # https://github.com/0day-ci/linux/commit/83f02393e1b5a2723294d8697f4fd5473d70602c
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review kan-liang-linux-intel-com/perf-x86-Move-cpuc-running-into-P4-specific-code/20210414-030649
>          git checkout 83f02393e1b5a2723294d8697f4fd5473d70602c
>          # save the attached .config to linux build tree
>          make W=1 ARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> arch/x86/events/core.c:2309:6: warning: no previous prototype for 'x86_pmu_clear_dirty_counters' [-Wmissing-prototypes]
>      2309 | void x86_pmu_clear_dirty_counters(void)
>           |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/x86_pmu_clear_dirty_counters +2309 arch/x86/events/core.c
> 
>    2308	
>> 2309	void x86_pmu_clear_dirty_counters(void)


Should be "static void x86_pmu_clear_dirty_counters(void)".

I will send V4 shortly to fix it.

Thanks,
Kan

>    2310	{
>    2311		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>    2312		int i;
>    2313	
>    2314		if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
>    2315			return;
>    2316	
>    2317		 /* Don't need to clear the assigned counter. */
>    2318		for (i = 0; i < cpuc->n_events; i++)
>    2319			__clear_bit(cpuc->assign[i], cpuc->dirty);
>    2320	
>    2321		for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
>    2322			/* Metrics and fake events don't have corresponding HW counters. */
>    2323			if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
>    2324				continue;
>    2325			else if (i >= INTEL_PMC_IDX_FIXED)
>    2326				wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
>    2327			else
>    2328				wrmsrl(x86_pmu_event_addr(i), 0);
>    2329		}
>    2330	
>    2331		bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
>    2332	}
>    2333	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
