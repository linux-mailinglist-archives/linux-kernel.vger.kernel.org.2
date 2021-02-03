Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C830E2B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhBCSn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:43:59 -0500
Received: from foss.arm.com ([217.140.110.172]:45018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232927AbhBCSnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:43:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5970D6E;
        Wed,  3 Feb 2021 10:42:55 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 627CB3F719;
        Wed,  3 Feb 2021 10:42:54 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 1/8] sched/fair: Clean up active balance nr_balance_failed trickery
In-Reply-To: <20210203151429.rnbdgt7wyoaz2vui@e107158-lin>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-2-valentin.schneider@arm.com> <20210203151429.rnbdgt7wyoaz2vui@e107158-lin>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 03 Feb 2021 18:42:48 +0000
Message-ID: <jhjo8h12dsn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -9805,9 +9810,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>  					active_load_balance_cpu_stop, busiest,
>>  					&busiest->active_balance_work);
>>  			}
>> -
>> -			/* We've kicked active balancing, force task migration. */
>> -			sd->nr_balance_failed = sd->cache_nice_tries+1;
>
> This has an impact on future calls to need_active_balance() too, no? We enter
> this path because need_active_balance() returned true; one of the conditions it
> checks for is
>
> 	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
>
> So since we used to reset nr_balanced_failed to cache_nice_tries+1, the above
> condition would be false in the next call or two IIUC. But since we remove
> that, we could end up here again soon.
>
> Was this intentional?
>

Partially, I'd say :-)

If you look at active_load_balance_cpu_stop(), it does

  sd->nr_balance_failed = 0;

when it successfully pulls a task. So we get a reset of the failed counter
on pull, which I've preserved. As for interactions with later
need_active_balance(), the commit that introduced the current counter write
(which is over 15 years old!):  

  3950745131e2 ("[PATCH] sched: fix SMT scheduling problems")

only states the task_hot() issue; thus I'm doubtful whether said
interaction was intentional.

