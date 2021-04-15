Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21AC360F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhDOPdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:33:01 -0400
Received: from foss.arm.com ([217.140.110.172]:49444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhDOPc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:32:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 347C5106F;
        Thu, 15 Apr 2021 08:32:35 -0700 (PDT)
Received: from [10.57.24.156] (unknown [10.57.24.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20BA93FA35;
        Thu, 15 Apr 2021 08:32:32 -0700 (PDT)
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
To:     Quentin Perret <qperret@google.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, dietmar.eggemann@arm.com
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg8s4VTQdiBNOpr@google.com>
 <20210415143453.GB391924@e120877-lin.cambridge.arm.com>
 <YHhU6pb8E5W2eeCX@google.com>
 <20210415151446.GC391924@e120877-lin.cambridge.arm.com>
 <YHhZrbLcUD6I83m1@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <cc9d7743-7795-a9c9-c1fb-4162cb02bfe2@arm.com>
Date:   Thu, 15 Apr 2021 16:32:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YHhZrbLcUD6I83m1@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 4/15/21 4:20 PM, Quentin Perret wrote:
> On Thursday 15 Apr 2021 at 16:14:46 (+0100), Vincent Donnefort wrote:
>> On Thu, Apr 15, 2021 at 02:59:54PM +0000, Quentin Perret wrote:
>>> On Thursday 15 Apr 2021 at 15:34:53 (+0100), Vincent Donnefort wrote:
>>>> On Thu, Apr 15, 2021 at 01:16:35PM +0000, Quentin Perret wrote:
>>>>> On Thursday 08 Apr 2021 at 18:10:29 (+0100), Vincent Donnefort wrote:
>>>>>> --- a/kernel/sched/cpufreq_schedutil.c
>>>>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>>>>> @@ -10,6 +10,7 @@
>>>>>>   
>>>>>>   #include "sched.h"
>>>>>>   
>>>>>> +#include <linux/energy_model.h>
>>>>>>   #include <linux/sched/cpufreq.h>
>>>>>>   #include <trace/events/power.h>
>>>>>>   
>>>>>> @@ -164,6 +165,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>>>>>>   
>>>>>>   	freq = map_util_freq(util, freq, max);
>>>>>>   
>>>>>> +	/* Avoid inefficient performance states */
>>>>>> +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
>>>>>
>>>>> I remember this was discussed when Douglas sent his patches some time
>>>>> ago, but I still find it sad we index the EM table here but still
>>>>> re-index the cpufreq frequency table later :/
>>>>>
>>>>> Yes in your case this lookup is very inexpensive, but still. EAS relies
>>>>> on the EM's table matching cpufreq's accurately, so this second lookup
>>>>> still feels rather unnecessary ...
>>>>
>>>> To get only a single lookup, we would need to bring the inefficiency knowledge
>>>> directly to the cpufreq framework. But it has its own limitations:
>>>>
>>>>    The cpufreq driver can have its own resolve_freq() callback, which means that
>>>>    not all the drivers would benefit from that feature.
>>>>
>>>>    The cpufreq_table can be ordered and accessed in several ways which brings
>>>>    many combinations that would need to be supported, ending-up with something
>>>>    much more intrusive. (We can though decide to limit the feature to the low to
>>>>    high access that schedutil needs).
>>>>
>>>> As the EM needs schedutil to exist anyway, it seemed to be the right place for
>>>> this code. It allows any cpufreq driver to benefit from the feature, simplify a
>>>> potential extension for a usage by devfreq devices and as a bonus it speeds-up
>>>> energy computing, allowing a more complex Energy Model.
>>>
>>> I was thinking of something a bit simpler. cpufreq_driver_resolve_freq
>>> appears to be used only from schedutil (why is it even then?), so we
>>> could just pull it into cpufreq_schedutil.c and just plain skip the call
>>> to cpufreq_frequency_table_target if the target freq has been indexed in
>>> the EM table -- it should already be matching a real OPP.
>>>
>>> Thoughts?
>>> Quentin
>>
>> Can try that for a V2. That means em_pd_get_efficient_freq() would have to
>> know about policy clamping (but I don't think that's an issue)
> 
> Indeed, and I think we can even see this as an improvement as EAS will
> now see policy clamps as well in compute_energy().

Are you sure that the 'policy' can be accessed from compute_energy()?
It can be from schedutil freq switch path, but I'm not use about our
feec()..

For me this cpufreq_driver_resolve_freq sounds a bit out of this patch
subject.

Regards,
Lukasz
