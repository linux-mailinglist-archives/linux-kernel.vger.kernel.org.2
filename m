Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427603648DB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbhDSRNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:13:52 -0400
Received: from foss.arm.com ([217.140.110.172]:46924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233576AbhDSRNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A83E1478;
        Mon, 19 Apr 2021 10:13:18 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25A513F7D7;
        Mon, 19 Apr 2021 10:13:17 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH 1/2] sched/fair: Filter out locally-unsolvable misfit imbalances
In-Reply-To: <CAKfTPtA7uq24hFv57c=W_XkXH-g9b2xo7OfJHRP+cbKoh-0TOQ@mail.gmail.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com> <20210415175846.494385-2-valentin.schneider@arm.com> <CAKfTPtA7uq24hFv57c=W_XkXH-g9b2xo7OfJHRP+cbKoh-0TOQ@mail.gmail.com>
Date:   Mon, 19 Apr 2021 18:13:10 +0100
Message-ID: <87czuqkxjt.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/21 15:29, Vincent Guittot wrote:
> On Thu, 15 Apr 2021 at 19:58, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> @@ -9441,8 +9465,8 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>>                  * average load.
>>                  */
>>                 if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
>> -                   !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
>> -                   nr_running == 1)
>> +                   env->src_grp_type <= group_fully_busy &&
>> +                   !capacity_greater(capacity_of(env->dst_cpu), capacity))
>>                         continue;
>>
>>                 switch (env->migration_type) {
>> @@ -9504,15 +9528,18 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>>                 case migrate_misfit:
>>                         /*
>>                          * For ASYM_CPUCAPACITY domains with misfit tasks we
>> -                        * simply seek the "biggest" misfit task.
>> +                        * simply seek the "biggest" misfit task we can
>> +                        * accommodate.
>>                          */
>> +                       if (!cpu_capacity_greater(env->dst_cpu, i))
>
> Use the same level of interface as above. This makes code and the
> condition easier to follow in find_busiest_queue()
>
> capacity_greater(capacity_of(env->dst_cpu), capacity_of(i))
>

OK
