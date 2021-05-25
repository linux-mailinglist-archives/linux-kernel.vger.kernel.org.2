Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E1B390074
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhEYMBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:01:06 -0400
Received: from foss.arm.com ([217.140.110.172]:55156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232064AbhEYMBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:01:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DF20D6E;
        Tue, 25 May 2021 04:59:34 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33BD83F719;
        Tue, 25 May 2021 04:59:32 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
References: <20210524101617.8965-1-beata.michalska@arm.com>
 <20210524101617.8965-3-beata.michalska@arm.com>
 <cdb4e3a4-569f-1dc2-be22-c0128250996a@arm.com>
 <20210525093039.GA31871@e120325.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8f00a2d4-2443-9656-2d51-6c5798fda552@arm.com>
Date:   Tue, 25 May 2021 13:59:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525093039.GA31871@e120325.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2021 11:30, Beata Michalska wrote:
> On Tue, May 25, 2021 at 10:25:36AM +0200, Dietmar Eggemann wrote:
>> On 24/05/2021 12:16, Beata Michalska wrote:

[...]

>>> @@ -1266,6 +1266,112 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
>>>  	update_group_capacity(sd, cpu);
>>>  }
>>>  
>>> +/**
>>> + * Asymmetric CPU capacity bits
>>> + */
>>> +struct asym_cap_data {
>>> +	struct list_head link;
>>> +	unsigned long    capacity;
>>> +	struct cpumask   *cpu_mask;
>>
>> Not sure if this has been discussed already but shouldn't the flexible
>> array members` approach known from struct sched_group, struct
>> sched_domain or struct em_perf_domain be used here?
>> IIRC the last time this has been discussed in this thread:
>> https://lkml.kernel.org/r/20200910054203.525420-2-aubrey.li@intel.com
>>
> If I got right the discussion you have pointed to, it was about using
> cpumask_var_t which is not the case here. I do not mind moving the code
> to use the array but I am not sure if this changes much. Looking at the
> code changes to support that (to_cpumask namely) it was introduced for
> cases where cpumask_var_t was not appropriate, which again isn't the case
> here.

Yeah, it was more about using `flexible array members` or allocating the
cpumask separately.

Looks like you're using some kind of a mixed approach:

(1) struct asym_cap_data {
        ...
        struct cpumask *cpu_mask;

(2) entry = kzalloc(sizeof(*entry) + cpumask_size(), GFP_KERNEL);

(3) entry->cpu_mask = (struct cpumask *)((char *)entry +
                      sizeof(*entry));

(4) cpumask_intersects(foo, entry->cpu_mask)


E.g. struct em_perf_domain has

(1)  struct em_perf_domain {
         ...
         unsigned long cpus[];

(2) like yours

(3) is not needed.

(4) cpumask_copy(em_span_cpus(pd), foo)

    with #define em_span_cpus(em) (to_cpumask((em)->cpus))

IMHO, it's better to keep this approach aligned between the different
data structures.
