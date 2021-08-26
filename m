Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60B43F8ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 21:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbhHZTjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 15:39:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243480AbhHZTjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 15:39:12 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630006698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W/9AWcYJSH4xE7X6sIVTqAAgx4sldVO3IC3jE306c0o=;
        b=jz0Wvb/MQBnV8YOgiFnw6pXXwK1AN+HAkC3z5UYr3ILblKpnWD7w7SSyqxK13Ih7I6Jggf
        ARweTSjpxpsGRAR0Gs8zJHxXGQ+DaTiZEcSxegYBFN7XQT8OcyICCcTHyey5+DtR2rxEDB
        FJmgHR3DQ46xvxueafeQXg0Y1yZWLwVGE6CFaOsa2aEptpihw9ZziDPTKHwTQHvMQxB8hN
        u1Oj3rpyjL3YR4G7un7JE2+5sEf/pxrCgLGqNoUIuWjpD0DT3Xy4o9WCcb2IwOWdcZGp8l
        lAwQczrdD+BbtMT5p6qL+DYPF7xe/kylT5sYNYRiErKoul6BSRI7Oy3EMCLdVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630006698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W/9AWcYJSH4xE7X6sIVTqAAgx4sldVO3IC3jE306c0o=;
        b=9fIii1QVwWn8/vDfNmN5v/tyhO/IFsnpVkSK26Rav/gBnXa1rxBpIriXYLkAbzrpGOXzQD
        Kwi6kb9TUmrYvIAw==
To:     Tao Zhou <tao.zhou@linux.dev>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched: Fix get_push_task() vs migrate_disable()
In-Reply-To: <YSfAWkWvd+4MJcvu@geo.homenetwork>
References: <20210826133738.yiotqbtdaxzjsnfj@linutronix.de>
 <YSfAWkWvd+4MJcvu@geo.homenetwork>
Date:   Thu, 26 Aug 2021 21:38:17 +0200
Message-ID: <87k0k82dzq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tao,

On Fri, Aug 27 2021 at 00:24, Tao Zhou wrote:
> On Thu, Aug 26, 2021 at 03:37:38PM +0200, Sebastian Andrzej Siewior wrote:
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index e205b63d6db07..32a4945730a9b 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -2259,6 +2259,9 @@ static inline struct task_struct *get_push_task(struct rq *rq)
>>  	if (p->nr_cpus_allowed == 1)
>>  		return NULL;
>>  
>> +	if (p->migration_disabled)
>> +		return NULL;
>
> Not much I can restore here..
>
> Is is_migration_disabled(p) be more correct to check migration
> disable.

Kinda, but it's not an issue here because get_push_task() is only available when
CONFIG_SMP=y which makes p->migration_disabled available as well.

> And get_push_task() being called in pull_rt_task() has checked migration
> disable first and then call get_push_task(). That means this check in
> get_push_task() in patch is a second repeatly check.

No. The checks are for two different tasks...

Thanks,

        tglx
