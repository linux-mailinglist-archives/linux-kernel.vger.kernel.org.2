Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75EB33C6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhCOTYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:24:42 -0400
Received: from foss.arm.com ([217.140.110.172]:37662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232655AbhCOTYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:24:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F248B1FB;
        Mon, 15 Mar 2021 12:24:32 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FFDF3F718;
        Mon, 15 Mar 2021 12:24:31 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH v3 3/7] sched/fair: Add more sched_asym_cpucapacity static branch checks
In-Reply-To: <CAKfTPtC-=PYTy5c6iOEwU=53S+gAYVzc6=GMTyEzjQWuyk7_uQ@mail.gmail.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com> <20210311120527.167870-4-valentin.schneider@arm.com> <CAKfTPtC-=PYTy5c6iOEwU=53S+gAYVzc6=GMTyEzjQWuyk7_uQ@mail.gmail.com>
Date:   Mon, 15 Mar 2021 19:24:29 +0000
Message-ID: <87tupcrziq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vincent,

Thanks for taking another look at this.

On 15/03/21 15:18, Vincent Guittot wrote:
> On Thu, 11 Mar 2021 at 13:05, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> Rik noted a while back that a handful of
>>
>>   sd->flags & SD_ASYM_CPUCAPACITY
>>
>> & family in the CFS load-balancer code aren't guarded by the
>> sched_asym_cpucapacity static branch.
>
> guarding asym capacity with static branch in fast path makes sense but
> I see no benefit in this slow path but hiding and complexifying the
> code. Also if you start with this way then you have to add a nop in
> all other places where flag or a group_type might be unused.
>

OK, fair enough, I'll drop this one.
