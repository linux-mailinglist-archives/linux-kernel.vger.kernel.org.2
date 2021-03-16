Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E7133DD21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhCPTHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:07:18 -0400
Received: from foss.arm.com ([217.140.110.172]:57300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240312AbhCPTGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:06:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ADDFD6E;
        Tue, 16 Mar 2021 12:06:12 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994123F70D;
        Tue, 16 Mar 2021 12:06:10 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] sched/fair: Ignore percpu threads for imbalance
 pulls
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com>
 <20210311120527.167870-2-valentin.schneider@arm.com>
 <bdea6c4f-262b-c3cb-637e-d4896e688dd3@arm.com> <87pmzzronf.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <0377d32d-52ac-76e1-4f73-8fa426136e8c@arm.com>
Date:   Tue, 16 Mar 2021 20:06:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87pmzzronf.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2021 18:31, Valentin Schneider wrote:
> On 16/03/21 16:49, Dietmar Eggemann wrote:
>> On 11/03/2021 13:05, Valentin Schneider wrote:
>>> From: Lingutla Chandrasekhar <clingutla@codeaurora.org>
>>>
>>> In load balancing, when balancing group is unable to pull task
>>> due to ->cpus_ptr constraints from busy group, then it sets
>>> LBF_SOME_PINNED to lb env flags, as a consequence, sgc->imbalance
>>> is set for its parent domain level. which makes the group
>>> classified as imbalance to get help from another balancing cpu.
>>>
>>> Consider a 4-CPU big.LITTLE system with CPUs 0-1 as LITTLEs and
>>
>> Does it have to be a big.LITTLE system? I assume this issue also happens
>> on an SMP system.
>>
> 
> Aye, though the consequences are "worse" on asym CPU capacity systems.

I can only think of higher group_type 'group_imbalanced' eclipses
'group_misfit_task' here?

> 
>>> CPUs 2-3 as Bigs with below scenario:
>>> - CPU0 doing newly_idle balancing
>>> - CPU1 running percpu kworker and RT task (small tasks)
>>
>> What's the role of the small RT task here in the story?
>>
> 
> I don't think it matters much here.

Chandra already mentioned that this is part of the story, namely to
start trying to move task on lb MC CPU1->CPU0 (if (busiest->nr_running >
1)).

[...]

>> This sentence mentioned per-cpu threads (and so does the patch name) but
>> the implementation (only) deals with per-cpu kernel threads. IMHO, it
>> would be good to align this.
>>
> 
> Tell you what, I'll go for:
> 1) how can pcpu kthreads cause LBF_SOME_PINNED
> 2) why we may not want this, but still ignore !kthread pcpu tasks
> 3) why this is even more important for big.LITTLE

LGTM.

