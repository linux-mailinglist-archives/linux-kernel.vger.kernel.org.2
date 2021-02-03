Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23D730E2F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhBCTAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:00:00 -0500
Received: from foss.arm.com ([217.140.110.172]:45304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhBCS76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:59:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8514811FB;
        Wed,  3 Feb 2021 10:59:12 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85C293F719;
        Wed,  3 Feb 2021 10:59:10 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [RFC PATCH] sched/core: Fix premature p->migration_pending completion
In-Reply-To: <20210203172344.uzq2iod4g46ffame@e107158-lin>
References: <20210127193035.13789-1-valentin.schneider@arm.com> <20210203172344.uzq2iod4g46ffame@e107158-lin>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 03 Feb 2021 18:59:08 +0000
Message-ID: <jhjft2d2d1f.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 17:23, Qais Yousef wrote:
> On 01/27/21 19:30, Valentin Schneider wrote:
>> Fiddling some more with a TLA+ model of set_cpus_allowed_ptr() & friends
>> unearthed one more outstanding issue. This doesn't even involve
>> migrate_disable(), but rather affinity changes and execution of the stopper
>> racing with each other.
>> 
>> My own interpretation of the (lengthy) TLA+ splat (note the potential for
>> errors at each level) is:
>> 
>>   Initial conditions:
>>     victim.cpus_mask = {CPU0, CPU1}
>> 
>>   CPU0                             CPU1                             CPU<don't care>
>> 
>>   switch_to(victim)
>> 								    set_cpus_allowed(victim, {CPU1})
>> 								      kick CPU0 migration_cpu_stop({.dest_cpu = CPU1})
>>   switch_to(stopper/0)
>> 								    // e.g. CFS load balance
>> 								    move_queued_task(CPU0, victim, CPU1);
>> 				   switch_to(victim)
>> 								    set_cpus_allowed(victim, {CPU0});
>> 								      task_rq_unlock();
>>   migration_cpu_stop(dest_cpu=CPU1)
>
> This migration stop is due to set_cpus_allowed(victim, {CPU1}), right?
>

Right

>>     task_rq(p) != rq && pending
>>       kick CPU1 migration_cpu_stop({.dest_cpu = CPU1})
>> 
>> 				   switch_to(stopper/1)
>> 				   migration_cpu_stop(dest_cpu=CPU1)
>
> And this migration stop is due to set_cpus_allowed(victim, {CPU0}), right?
>

Nein! This is a retriggering of the "current" stopper (triggered by
set_cpus_allowed(victim, {CPU1})), see the tail of that

  else if (dest_cpu < 0 || pending)

branch in migration_cpu_stop(), is what I'm trying to hint at with that 

task_rq(p) != rq && pending

> If I didn't miss something, then dest_cpu should be CPU0 too, not CPU1 and the
> task should be moved back to CPU0 as expected?
>
> Thanks
>
> --
> Qais Yousef
