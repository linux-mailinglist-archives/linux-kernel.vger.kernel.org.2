Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E4732C2C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhCDAAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:00:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:31342 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387472AbhCCUCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:02:34 -0500
IronPort-SDR: 1aG+AAgDutIGHyurmkUe7SBqRPuUhJx5oDF3/sDgKSMZKcDcmcmR0D9AnW8c44Bdpyxju+vKGX
 96eREw/jfAOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="166525697"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="166525697"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 12:00:22 -0800
IronPort-SDR: eyi2QKfV5cccd1vRVDJpFe18j+zEp4aWlR7m6heg+4sBlsWT8ZNDkYuzbcAcZ7qtmW4BpE5f+E
 eCX0dDQCoBxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="428394063"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 03 Mar 2021 12:00:21 -0800
Received: from [10.252.139.65] (kliang2-MOBL.ccr.corp.intel.com [10.252.139.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 50A5B580224;
        Wed,  3 Mar 2021 12:00:20 -0800 (PST)
Subject: Re: [perf] perf_fuzzer causes unchecked MSR access error
To:     Stephane Eranian <eranian@google.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu>
 <7170d3b-c17f-1ded-52aa-cc6d9ae999f4@maine.edu>
 <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net>
 <32888c33-c286-c600-66cb-8b1b03beeb8b@linux.intel.com>
 <6c1f8e-f81-a781-e594-368e7adef0c0@maine.edu>
 <CABPqkBRp17EMqgoO3LTC-hTkpbv2njFO-Kkf-RifrSksdGfEaA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9df5f72d-a959-fe46-400a-7dca6c596478@linux.intel.com>
Date:   Wed, 3 Mar 2021 15:00:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABPqkBRp17EMqgoO3LTC-hTkpbv2njFO-Kkf-RifrSksdGfEaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/2021 2:28 PM, Stephane Eranian wrote:
> On Wed, Mar 3, 2021 at 10:16 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
>>
>> Hello
>>
>> on my Haswell machine the perf_fuzzer managed to trigger this message:
>>
>> [117248.075892] unchecked MSR access error: WRMSR to 0x3f1 (tried to write 0x0400000000000000) at rIP: 0xffffffff8106e4f4 (native_write_msr+0x4/0x20)
>> [117248.089957] Call Trace:
>> [117248.092685]  intel_pmu_pebs_enable_all+0x31/0x40
>> [117248.097737]  intel_pmu_enable_all+0xa/0x10
>> [117248.102210]  __perf_event_task_sched_in+0x2df/0x2f0
>> [117248.107511]  finish_task_switch.isra.0+0x15f/0x280
>> [117248.112765]  schedule_tail+0xc/0x40
>> [117248.116562]  ret_from_fork+0x8/0x30
>>
>> that shouldn't be possible, should it?  MSR 0x3f1 is MSR_IA32_PEBS_ENABLE
>>
> Not possible, bit 58 is not defined in PEBS_ENABLE, AFAIK.
> 
>>
>> this is on recent-git with the patch causing the pebs-related crash
>> reverted.
>>

We never use bit 58. It should be a new issue.
Is it repeatable?

Thanks,
Kan
