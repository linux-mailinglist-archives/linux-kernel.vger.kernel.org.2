Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DE3386EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345296AbhERBAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:00:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:6129 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238525AbhERBAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:00:16 -0400
IronPort-SDR: EnjuMe4tLGbFnAp4e/XNxzXSo4ANM7AlB5+JV8RRTSg666fuiUcGconmJF1lv7kg8fy6iIu/pA
 ox3aDxeNfsFQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="286129103"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="286129103"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 17:58:59 -0700
IronPort-SDR: /160PXf7zYW2EmMv7JqaRY5vm+F2WPyp5HuUh8ONLJc1I2zAQFLWWVUiUBN3brpeg78d2y4pSi
 ul/E+2B7OKHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="460529180"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga004.fm.intel.com with ESMTP; 17 May 2021 17:58:56 -0700
Subject: Re: [PATCH v2 6/8] sched/idle: Move busy_cpu accounting to idle
 callback
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
 <47d29f1d-cea6-492a-5125-85db6bce0fa7@linux.intel.com>
 <20210513073112.GV2633526@linux.vnet.ibm.com>
 <5823f298-6fae-5a73-3ab8-f708d90a7e52@linux.intel.com>
 <20210517104058.GW2633526@linux.vnet.ibm.com>
 <9d493353-7a27-16aa-3e99-c6a07e69de25@linux.intel.com>
 <20210517125727.GX2633526@linux.vnet.ibm.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <27ab234c-b36b-bf7f-52f4-92c1804f8245@linux.intel.com>
Date:   Tue, 18 May 2021 08:59:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210517125727.GX2633526@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 8:57 PM, Srikar Dronamraju wrote:
> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-17 20:48:46]:
> 
>> On 5/17/21 6:40 PM, Srikar Dronamraju wrote:
>>> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-14 12:11:50]:
>>>
>>>> On 5/13/21 3:31 PM, Srikar Dronamraju wrote:
>>>>> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-12 16:08:24]:
>>>>>> On 5/7/21 12:45 AM, Srikar Dronamraju wrote:
>>>
>>> <snip>
>>>
>>>>>> Also, for those frequent context-switching tasks with very short idle,
>>>>>> it's expensive for scheduler to mark idle/busy every time, that's why
>>>>>> my patch only marks idle every time and marks busy ratelimited in
>>>>>> scheduler tick.
>>>>>>
>>>>>
>>>>> I have tried few tasks with very short idle times and updating nr_busy
>>>>> everytime, doesnt seem to be impacting. Infact, it seems to help in picking
>>>>> the idler-llc more often.
>>>>>
>>>>
>>>> How many CPUs in your LLC?
>>>
>>> I have tried with X86, 48 CPUs, 2 nodes, each having 24 CPUs in LLC
>>> +
>>> POWER10, Multiple CPUs with 4 CPUs in LLC
>>> +
>>> POWER9, Multiple CPUs with 8 CPUs in LLC
>>>
>>>>
>>>> This is a system with 192 CPUs, 4 nodes and each node has 48 CPUs in LLC
>>>> domain.
>>>>
>>>
>>> Okay,
>>>
>>>> It looks like for netperf both TCP and UDP cases have the notable change
>>>> under 2 x overcommit, it may be not interesting though.
>>>>
>>>>
>>>
>>> I believe the extra load on this 24 core LLC could be because we may end up
>>> trying to set the idle-core, even when there is no idle core available.
>>>
>>> If possible, can you please give a try with v3 with the call to
>>> set_next_idle_core commented out?
>>>
>>>
>>
>> v3 seems not be applicable on tip/sched/core 915a2bc3c6b7?
> 
> I had applied on top of 2ea46c6fc9452ac100ad907b051d797225847e33
> which was tag: sched-core-2021-04-28
> 
> The only conflict you get on today's tip is Gautham's one line patch.
> Gautham's patch replaced 'this' with 'target'.
> 
> The 2nd patch does away with that line
> 

This is v3. It looks like hackbench gets better. And netperf still has
some notable changes under 2 x overcommit cases.


hackbench (48 tasks per group)
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	group-1 	 1.00 (  4.51)	 +1.36 (  4.26)
process-pipe    	group-2 	 1.00 ( 18.73)	 -9.66 ( 31.15)
process-pipe    	group-3 	 1.00 ( 23.67)	 +8.52 ( 21.13)
process-pipe    	group-4 	 1.00 ( 14.65)	+17.12 ( 25.23)
process-pipe    	group-8 	 1.00 (  3.11)	+16.41 (  5.94)
process-sockets 	group-1 	 1.00 (  8.83)	 +1.53 ( 11.93)
process-sockets 	group-2 	 1.00 (  5.32)	-15.43 (  7.17)
process-sockets 	group-3 	 1.00 (  4.79)	 -4.14 (  1.90)
process-sockets 	group-4 	 1.00 (  2.39)	 +4.37 (  1.31)
process-sockets 	group-8 	 1.00 (  0.38)	 +4.41 (  0.05)
threads-pipe    	group-1 	 1.00 (  3.06)	 -1.57 (  3.71)
threads-pipe    	group-2 	 1.00 ( 17.41)	 -2.16 ( 15.29)
threads-pipe    	group-3 	 1.00 ( 17.94)	+19.86 ( 13.24)
threads-pipe    	group-4 	 1.00 ( 15.38)	 +3.71 ( 11.97)
threads-pipe    	group-8 	 1.00 (  2.72)	+13.40 (  8.43)
threads-sockets 	group-1 	 1.00 (  8.51)	 -2.73 ( 17.48)
threads-sockets 	group-2 	 1.00 (  5.44)	-12.04 (  5.91)
threads-sockets 	group-3 	 1.00 (  4.38)	 -5.00 (  1.48)
threads-sockets 	group-4 	 1.00 (  1.08)	 +4.46 (  1.15)
threads-sockets 	group-8 	 1.00 (  0.61)	 +5.12 (  0.20)

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	thread-48	 1.00 (  3.79)	 +4.69 (  4.03)
TCP_RR          	thread-96	 1.00 (  4.98)	 -6.74 (  3.59)
TCP_RR          	thread-144	 1.00 (  6.04)	 -2.36 (  3.57)
TCP_RR          	thread-192	 1.00 (  4.97)	 -0.44 (  4.89)
TCP_RR          	thread-384	 1.00 ( 19.87)	-19.12 ( 28.99)
UDP_RR          	thread-48	 1.00 ( 12.54)	 -2.73 (  1.59)
UDP_RR          	thread-96	 1.00 (  6.51)	 -6.66 ( 10.42)
UDP_RR          	thread-144	 1.00 ( 45.41)	 -3.81 ( 31.37)
UDP_RR          	thread-192	 1.00 ( 32.06)	 +3.07 ( 71.89)
UDP_RR          	thread-384	 1.00 ( 29.57)	-21.52 ( 35.50)
