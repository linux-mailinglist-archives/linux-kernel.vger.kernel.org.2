Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCC4325773
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhBYURh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:17:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:38233 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234141AbhBYURP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:17:15 -0500
IronPort-SDR: J/G7zmWtYflgRYjgqnZSyEiwBnDfMN/x95pe+eDjEOmydL5qrQbzAX/68Xr4jbIzBCTfXeZeSV
 LNsucaWGHGvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="184965109"
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="184965109"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 12:15:29 -0800
IronPort-SDR: Lp0kxLVj3i3LsaWdmuhDqNRxSPh5IJ7dkLQYetfa1ZtANFwJdVgAqWZBAoXdjBk2jOqS4G7Hf1
 1FxUcWP/KMxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="365580912"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 25 Feb 2021 12:15:28 -0800
Received: from [10.254.88.247] (kliang2-MOBL.ccr.corp.intel.com [10.254.88.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B79835804A9;
        Thu, 25 Feb 2021 12:15:27 -0800 (PST)
Subject: Re: [perf] perf_fuzzer causes crash in intel_pmu_drain_pebs_nhm()
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu>
 <7170d3b-c17f-1ded-52aa-cc6d9ae999f4@maine.edu>
 <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net>
 <d2005608-4214-ec01-d6b1-a7d19fab7bf9@linux.intel.com>
 <2a655469-de9d-c80-dd7f-26436d6f03a@maine.edu>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9b3f84e0-e1cc-cebe-43b6-fa062484ad28@linux.intel.com>
Date:   Thu, 25 Feb 2021 15:15:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2a655469-de9d-c80-dd7f-26436d6f03a@maine.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/2021 5:14 PM, Vince Weaver wrote:
> On Thu, 11 Feb 2021, Liang, Kan wrote:
> 
>>> On Thu, Jan 28, 2021 at 02:49:47PM -0500, Vince Weaver wrote:
>> I'd like to reproduce it on my machine.
>> Is this issue only found in a Haswell client machine?
>>
>> To reproduce the issue, can I use ./perf_fuzzer under perf_event_tests/fuzzer?
>> Do I need to apply any parameters with ./perf_fuzzer?
>>
>> Usually how long does it take to reproduce the issue?
> 
> On my machine if I run the commands
> 		echo 1 > /proc/sys/kernel/nmi_watchdog
>                  echo 0 > /proc/sys/kernel/perf_event_paranoid
>                  echo 1000 > /proc/sys/kernel/perf_event_max_sample_rate
>                  ./perf_fuzzer -s 30000 -r 1611784483
> 
> it is repeatable within a minute, but because of the nature of the fuzzer
> it probably won't work for you because the random events will diverge
> based on the different configs of the system.
> 
> I can try to generate a simple reproducer, I've just been extremely busy
> here at work and haven't had the chance.
> 
> If you want to try to reproduce it the hard way, run the
> 	./fast_repro99.sh
> script in the perf_fuzzer directory.  It will start fuzzing.  My machine
> turned up the issue within a day or so.
>
Sorry for the late response. Just want to let you know I'm still trying 
to reproduce the issue.

I only have a Haswell server on hand. I run the ./fast_repro99.sh on the 
machine for 3 days, but I didn't observe any crash.
Now, I'm looking for a HSW client in my lab. I will check if I can 
reproduce it on a client machine.

If you have a simple reproducer, please let me know.

Thanks,
Kan
