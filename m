Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF41327F59
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhCANWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:22:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:1946 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234334AbhCANWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:22:20 -0500
IronPort-SDR: 7hxp9OazjGGkAzC8H3P1bs5LUEoGXpIQ6aEixcXk02S08MsHjzu4mfp5cpNiEFaK4oj/wkq053
 PVWESfLKjbxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="271456164"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="271456164"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 05:20:50 -0800
IronPort-SDR: Kp0ANovFLJIjU3mLk3Zx4w4IhT1Og9kuUmmZSMArM8FhN2sM6q43r1BwwmH+PZQrCIXkS1x2oR
 bQrjPPxdgWgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="595415959"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 01 Mar 2021 05:20:49 -0800
Received: from [10.251.13.36] (kliang2-MOBL.ccr.corp.intel.com [10.251.13.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C01DE58033E;
        Mon,  1 Mar 2021 05:20:48 -0800 (PST)
Subject: Re: [perf] perf_fuzzer causes crash in intel_pmu_drain_pebs_nhm()
To:     Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu>
 <7170d3b-c17f-1ded-52aa-cc6d9ae999f4@maine.edu>
 <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <32888c33-c286-c600-66cb-8b1b03beeb8b@linux.intel.com>
Date:   Mon, 1 Mar 2021 08:20:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/2021 9:53 AM, Peter Zijlstra wrote:
> 
> Kan, do you have time to look at this?
> 
> On Thu, Jan 28, 2021 at 02:49:47PM -0500, Vince Weaver wrote:
>> On Thu, 28 Jan 2021, Vince Weaver wrote:
>>
>>> the perf_fuzzer has turned up a repeatable crash on my haswell system.
>>>
>>> addr2line is not being very helpful, it points to DECLARE_PER_CPU_FIRST.
>>> I'll investigate more when I have the chance.
>>
>> so I poked around some more.
>>
>> This seems to be caused in
>>
>>     __intel_pmu_pebs_event()
>> 	get_next_pebs_record_by_bit()		ds.c line 1639
>> 		get_pebs_status(at)		ds.c line 1317
>> 			return ((struct pebs_record_nhm *)n)->status;
>>
>> where "n" has the value of 0xc0 rather than a proper pointer.
>>

I think I find the suspicious patch.
The commt id 01330d7288e00 ("perf/x86: Allow zero PEBS status with only 
single active event")
https://lore.kernel.org/lkml/tip-01330d7288e0050c5aaabc558059ff91589e67cd@git.kernel.org/
The patch is an SW workaround for some old CPUs (HSW and earlier), which 
may set 0 to the PEBS status. It adds a check in the 
intel_pmu_drain_pebs_nhm(). It tries to minimize the impact of the 
defect by avoiding dropping the PEBS records which have PEBS status 0.
But, it doesn't correct the PEBS status, which may bring problems,
especially for the large PEBS.
It's possible that all the PEBS records in a large PEBS have the PEBS 
status 0. If so, the first get_next_pebs_record_by_bit() in the 
__intel_pmu_pebs_event() returns NULL. The at = NULL. Since it's a large 
PEBS, the 'count' parameter must > 1. The second 
get_next_pebs_record_by_bit() will crash.

Could you please revert the patch and check whether it fixes your issue?

Thanks,
Kan
