Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09163A46BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFKQpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:45:36 -0400
Received: from foss.arm.com ([217.140.110.172]:34888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhFKQp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:45:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B7F9D6E;
        Fri, 11 Jun 2021 09:43:30 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3A2F3F719;
        Fri, 11 Jun 2021 09:43:27 -0700 (PDT)
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
References: <20210608231132.32012-1-joshdon@google.com>
 <e3fc3338-c469-0c0c-ada2-a0bbc9f969fe@arm.com>
 <CABk29Nu=mxz3tugjhDV9xCF7DRsMi9U747H+BqubviEva36RUw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7222c20a-5cbb-d443-a2fd-19067652a38e@arm.com>
Date:   Fri, 11 Jun 2021 18:43:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABk29Nu=mxz3tugjhDV9xCF7DRsMi9U747H+BqubviEva36RUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2021 21:14, Josh Don wrote:
> Hey Dietmar,
> 
> On Thu, Jun 10, 2021 at 5:53 AM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> Any reason why this should only work on cgroup-v2?
> 
> My (perhaps incorrect) assumption that new development should not
> extend v1. I'd actually prefer making this work on v1 as well; I'll
> add that support.
> 
>> struct cftype cpu_legacy_files[] vs. cpu_files[]
>>
>> [...]
>>
>>> @@ -11340,10 +11408,14 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
>>>
>>>  static DEFINE_MUTEX(shares_mutex);
>>>
>>> -int sched_group_set_shares(struct task_group *tg, unsigned long shares)
>>> +#define IDLE_WEIGHT sched_prio_to_weight[ARRAY_SIZE(sched_prio_to_weight) - 1]
>>
>> Why not 3 ? Like for tasks (WEIGHT_IDLEPRIO)?
>>
>> [...]
> 
> Went back and forth on this; on second look, I do think it makes sense
> to use the IDLEPRIO weight of 3 here. This gets converted to a 0,
> rather than a 1 for display of cpu.weight, which is also actually a
> nice property.

I'm struggling to see the benefit here.

For a taskgroup A: Why setting A/cpu.idle=1 to force a minimum A->shares
when you can set it directly via A/cpu.weight (to 1 (minimum))?

WEIGHT	   cpu.weight 	tg->shares

3	   0		3072

15	   1		15360

	   1		10240

`A/cpu.weight` follows cgroup-v2's `weights` `resource distribution
model`* but I can only see `A/cpu.idle` as a layer on top of it forcing
`A/cpu.weight` to get its minimum value?

*Documentation/admin-guide/cgroup-v2.rst
