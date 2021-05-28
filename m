Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE3393F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbhE1JCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:02:39 -0400
Received: from foss.arm.com ([217.140.110.172]:38280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhE1JCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:02:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 861B011D4;
        Fri, 28 May 2021 02:01:03 -0700 (PDT)
Received: from [10.57.8.168] (unknown [10.57.8.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3690D3F719;
        Fri, 28 May 2021 02:01:01 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
 <20210528050426.txs4kx2s37jwzpfe@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f54a1dd5-fe1f-1d2e-3fd9-6ba019157e4a@arm.com>
Date:   Fri, 28 May 2021 10:00:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210528050426.txs4kx2s37jwzpfe@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 6:04 AM, Viresh Kumar wrote:
> On 21-05-21, 17:54, Vincent Donnefort wrote:
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> +static inline
>> +struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
>> +						unsigned long freq)
>> +{
>> +	struct em_perf_state *ps;
>> +	int i;
>> +
>> +	for (i = 0; i < pd->nr_perf_states; i++) {
>> +		ps = &pd->table[i];
>> +		if (ps->flags & EM_PERF_STATE_INEFFICIENT)
>> +			continue;
>> +		if (ps->frequency >= freq)
>> +			break;
> 
> I believe it may be more optimal if we change the sequence of these two 'if'
> blocks here. We only need to check for inefficient frequencies if it is >= freq.

Make sense (especially in context of your example below).

> 
>> +	}
>> +
>> +	return ps;
>> +}
> 
> 
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> @@ -153,6 +154,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>>   
>>   	freq = map_util_freq(util, freq, max);
>>   
>> +	/* Avoid inefficient performance states */
>> +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
>> +
>>   	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>>   		return sg_policy->next_freq;
> 
> Assume this freq-table (E=efficient, IE=inefficient): 800M (E), 1G (E), 1.2G (IE), 1.4G (IE), 1.6G (E).
> Thermal limits max to 1.4G
> 
> Freq returned by map_util_freq() is 1.01G.
> 
> Will we not end up selecting 1.4G here ? Inefficient as well as much higher than
> what we requested for ?
> 

Correct, it will be 1.4G, instead of selecting 1.2G, in this example.
The two or more consecutive inefficient OPPs in the table ruins the
proper behavior. We have to reevaluate this.

Thanks Viresh for pointing this out.

Regards,
Lukasz
