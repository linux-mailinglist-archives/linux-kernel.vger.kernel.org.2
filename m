Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8B1337F17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 21:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhCKUdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 15:33:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:21004 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhCKUct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 15:32:49 -0500
IronPort-SDR: 124eicIJoxFmPQUvdFfICzJcxeSJJLlU9q3hmugJ1H0iyR2hPIBw2o5SnIb8eRxTDQZ48mVwwO
 uDH1UJiQv8mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="252754139"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="252754139"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 12:32:48 -0800
IronPort-SDR: n2Ti6faOeM/TTrhiaKAr6ll/6qNmfd4EZnmxp+IhAJucZ461U586Xe3A0yVjQyUbsbayLMzXOa
 eHpWvga9oKIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="603677465"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2021 12:32:47 -0800
Received: from [10.251.15.67] (kliang2-MOBL.ccr.corp.intel.com [10.251.15.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C57F4580514;
        Thu, 11 Mar 2021 12:32:45 -0800 (PST)
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
To:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Mark Rutland <mark.rutland@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
 <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
 <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
 <20210311195832.GK4746@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <400dbd6e-389c-899d-6d11-14b5a8f8f90e@linux.intel.com>
Date:   Thu, 11 Mar 2021 15:32:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210311195832.GK4746@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/2021 2:58 PM, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 11:53:35AM -0500, Liang, Kan wrote:
> 
>>>> The "cpu_core" PMU is similar to the Sapphire Rapids PMU, but without
>>>> PMEM.
>>>> The "cpu_atom" PMU is similar to Tremont, but with different
>>>> event_constraints, extra_regs and number of counters.
> 
>>> So do these things use the same event lists as SPR and TNT?
>>
>> No, there will be two new event lists on ADL. One is for Atom core, and the
>> other is for big core. They are different to SPR and TNT.
> 
> *sigh* how different?

The core PMU event list should be similar between SPR and the big core 
of ADL, because they both utilize the Golden Cove core. But the uncore 
PMU event list is totally different for client and server.

The Atom core of ADL utilizes the Gracemont core, which is a successor 
to Tremont. It introduces many new events. We cannot use the Tremont 
event list instead.


> 
>>> My desktop has: cpu/caps/pmu_name and that gives "skylake", do we want
>>> the above to have cpu_core/caps/pmu_name give "sapphire_rapids" etc.. ?
>>>
>>
>> I think current implementation should be good enough.
>>
>> $ cat /sys/devices/cpu_atom/caps/pmu_name
>> alderlake_hybrid
>>
>> "alderlake_hybrid" tells the perf tool that it's Alder Lake Hybrid system.
>> "cpu_atom" tells the perf tool that it's for Atom core.
> 
> Yeah, but then I have to ask Google wth those atoms and cores actually
> are. Why not tell me upfront?
> 
> Since we're now working on it, we all know, but in 6 months time nobody
> will remember and then we'll constantly have to look it up and curse
> ourselves for not doing better.

I think the "sapphire_rapids" is the code name for the server platform.
Maybe we should use the code name of core?

$ cat /sys/devices/cpu_atom/caps/pmu_name
gracemont
$ cat /sys/devices/cpu_core/caps/pmu_name
golden_cove


Thanks,
Kan
