Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B79387197
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 08:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbhERGHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 02:07:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:64098 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhERGHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 02:07:13 -0400
IronPort-SDR: YfdSSIXDCFdrUhBWn8GxDqCVMswbQIWvXZh2Xj+59TMYX7kiDCbSsxsQ+C0A1/BkQ8GtxlN4Up
 89evlA1Kwj4w==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="261866408"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="261866408"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 23:05:55 -0700
IronPort-SDR: ivAIV17y4bOv3+mf4Y9Ddj0X87lTCkEUd3ffbZgcCv+nRabYH9K3KY6WN1JTFUEhgp5+Q6qGWb
 b/ct6qiTMXMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="473301188"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga002.fm.intel.com with ESMTP; 17 May 2021 23:05:52 -0700
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
 <27ab234c-b36b-bf7f-52f4-92c1804f8245@linux.intel.com>
 <20210518040024.GY2633526@linux.vnet.ibm.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <ce4eba7e-dc2e-1c67-d04d-579f04c2040b@linux.intel.com>
Date:   Tue, 18 May 2021 14:05:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518040024.GY2633526@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 12:00 PM, Srikar Dronamraju wrote:
> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-18 08:59:00]:
> 
>> On 5/17/21 8:57 PM, Srikar Dronamraju wrote:
>>> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-17 20:48:46]:
>>>
>>>> On 5/17/21 6:40 PM, Srikar Dronamraju wrote:
>>>>> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-14 12:11:50]:
>>>>>
>>>>>> On 5/13/21 3:31 PM, Srikar Dronamraju wrote:
>>>>>>> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-12 16:08:24]:
>>>>>>>> On 5/7/21 12:45 AM, Srikar Dronamraju wrote:
>>>>>
>>>>> <snip>
>>>>>
>>>>>>>> Also, for those frequent context-switching tasks with very short idle,
>>>>>>>> it's expensive for scheduler to mark idle/busy every time, that's why
>>>>>>>> my patch only marks idle every time and marks busy ratelimited in
>>>>>>>> scheduler tick.
>>>>>>>>
>>>>>>>
>>>>>>> I have tried few tasks with very short idle times and updating nr_busy
>>>>>>> everytime, doesnt seem to be impacting. Infact, it seems to help in picking
>>>>>>> the idler-llc more often.
>>>>>>>
>>>>>>
>>>>>> How many CPUs in your LLC?
>>>>>
>>>>> I have tried with X86, 48 CPUs, 2 nodes, each having 24 CPUs in LLC
>>>>> +
>>>>> POWER10, Multiple CPUs with 4 CPUs in LLC
>>>>> +
>>>>> POWER9, Multiple CPUs with 8 CPUs in LLC
>>>>>
>>>>>>
>>>>>> This is a system with 192 CPUs, 4 nodes and each node has 48 CPUs in LLC
>>>>>> domain.
>>>>>>
>>>>>
>>>>> Okay,
>>>>>
>>>>>> It looks like for netperf both TCP and UDP cases have the notable change
>>>>>> under 2 x overcommit, it may be not interesting though.
>>>>>>
>>>>>>
>>>>>
>>>>> I believe the extra load on this 24 core LLC could be because we may end up
>>>>> trying to set the idle-core, even when there is no idle core available.
>>>>>
>>>>> If possible, can you please give a try with v3 with the call to
>>>>> set_next_idle_core commented out?
>>>>>
>>>>>
>>>>
>>>> v3 seems not be applicable on tip/sched/core 915a2bc3c6b7?
>>>
>>> I had applied on top of 2ea46c6fc9452ac100ad907b051d797225847e33
>>> which was tag: sched-core-2021-04-28
>>>
>>> The only conflict you get on today's tip is Gautham's one line patch.
>>> Gautham's patch replaced 'this' with 'target'.
>>>
>>> The 2nd patch does away with that line
>>>
>>
>> This is v3. It looks like hackbench gets better. And netperf still has
>> some notable changes under 2 x overcommit cases.
>>
> 
> Thanks Aubrey for the results. netperf (2X) case does seem to regress.
> I was actually expecting the results to get better with overcommit.
> Can you confirm if this was just v3 or with v3 + set_next_idle_core
> disabled?

Do you mean set_idle_cores(not set_next_idle_core) actually? Gautham's patch
changed "this" to "target" in set_idle_cores, and I removed it to apply
v3-2-8-sched-fair-Maintain-the-identity-of-idle-core.patch for tip/sched/core
commit-id 915a2bc3c6b7.
