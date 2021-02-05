Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81456311153
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhBERy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:54:58 -0500
Received: from foss.arm.com ([217.140.110.172]:36974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233285AbhBEP3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:29:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EA6311B3;
        Fri,  5 Feb 2021 09:00:01 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C5333F718;
        Fri,  5 Feb 2021 09:00:00 -0800 (PST)
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
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 3/8] sched/fair: Tweak misfit-related capacity checks
In-Reply-To: <CAKfTPtADn0X8=ENfvG5dhzM1KbTD+JCCoOm-i8=bVkh0ZBM2Xg@mail.gmail.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-4-valentin.schneider@arm.com> <CAKfTPtADn0X8=ENfvG5dhzM1KbTD+JCCoOm-i8=bVkh0ZBM2Xg@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Fri, 05 Feb 2021 16:59:55 +0000
Message-ID: <jhjv9b61md0.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 15:31, Vincent Guittot wrote:
> On Thu, 28 Jan 2021 at 19:32, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> During load-balance, groups classified as group_misfit_task are filtered
>> out if they do not pass
>>
>>   group_smaller_max_cpu_capacity(<candidate group>, <local group>);
>
> group_smaller_max_cpu_capacity and  group_smaller_max_cpu_capacity are
> removed in the next patch. Merge this and the next and directly remove
> them
>

OK.

>> @@ -8253,7 +8260,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
>>  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
>>  {
>>         return rq->misfit_task_load &&
>> -               (rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
>> +               (capacity_greater(rq->rd->max_cpu_capacity, rq->cpu_capacity_orig) ||
>
> Why do you add a margin here whereas there was no margin before ?
>

Comparing capacities without any sort of filter can lead to ping-ponging
tasks around (capacity values very easily fluctuate by +/- 1, if not more).
I'm guilty of doing two things at once here: replace existing users, and
convert callsites that should be existing users. I can split the conversion
in a separate patch.
