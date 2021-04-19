Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8A3648EE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbhDSRSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:18:23 -0400
Received: from foss.arm.com ([217.140.110.172]:47076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhDSRSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:18:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8984C1478;
        Mon, 19 Apr 2021 10:17:51 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02DB53F7D7;
        Mon, 19 Apr 2021 10:17:49 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
In-Reply-To: <YH1+zpzUdJeTk0Z3@lorien.usersys.redhat.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com> <20210415175846.494385-3-valentin.schneider@arm.com> <a5abd06c61e4152b483043f8b180ba041f0464d1.camel@surriel.com> <87tuo6lg39.mognet@arm.com> <YH1+zpzUdJeTk0Z3@lorien.usersys.redhat.com>
Date:   Mon, 19 Apr 2021 18:17:47 +0100
Message-ID: <878s5ekxc4.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/21 08:59, Phil Auld wrote:
> On Fri, Apr 16, 2021 at 10:43:38AM +0100 Valentin Schneider wrote:
>> On 15/04/21 16:39, Rik van Riel wrote:
>> > On Thu, 2021-04-15 at 18:58 +0100, Valentin Schneider wrote:
>> >> @@ -7672,6 +7698,15 @@ int can_migrate_task(struct task_struct *p,
>> >> struct lb_env *env)
>> >>      if (tsk_cache_hot == -1)
>> >>              tsk_cache_hot = task_hot(p, env);
>> >>
>> >> +	/*
>> >> +	 * On a (sane) asymmetric CPU capacity system, the increase in
>> >> compute
>> >> +	 * capacity should offset any potential performance hit caused
>> >> by a
>> >> +	 * migration.
>> >> +	 */
>> >> +	if ((env->dst_grp_type == group_has_spare) &&
>> >> +	    !migrate_degrades_capacity(p, env))
>> >> +		tsk_cache_hot = 0;
>> >
>> > ... I'm starting to wonder if we should not rename the
>> > tsk_cache_hot variable to something else to make this
>> > code more readable. Probably in another patch :)
>> >
>>
>> I'd tend to agree, but naming is hard. "migration_harmful" ?
>
> I thought Rik meant tsk_cache_hot, for which I'd suggest at least
> buying a vowel and putting an 'a' in there :)
>

That's the one I was eyeing: s/tsk_cache_hot/migration_harmful/ or
somesuch. Right now we're feeding it:

o migrate_degrades_locality()
o task_hot()

and I'm adding another one, so that's 2/3 which don't actually care about
cache hotness, but rather "does doing this migration degrade/improve
$criterion?"
