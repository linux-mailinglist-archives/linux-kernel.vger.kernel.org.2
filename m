Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB3933975F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhCLTZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:25:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhCLTZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:25:18 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615577116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5zLfYrI1ktdYvU0WYUSOt8cuz631ADpBZR0ROWuzBbA=;
        b=fC6Qbeg592YV/SLHSVFbZQR8KJBndBfVtlqO0loaiN8u6znqmN3K3Fet8cQzLFT7JkfYl3
        5ROMJqYfzuSFVfDc4Gd01p+lWycGZjcv/xpAQXGQ+aYxNzhBJtB3EGPu2bFNmTclj7kwe/
        oDv+aUb96fpVhebOVXM/ulXJJC+DmJIFTqOV1i+Npb/S5rIYex0ALXy5YBO/Cg9AOq/sU7
        lVA44ylYCmPKj6rd6hW9sOh7EenSTgB8qMdlQNtVDvlg3o8ojfGEV7Vzb+GxgmAgGt4VBQ
        PgA79PJf1Jpb0Q3ZeKOsaXAw23dIfpG2BRn44cwfvmnOqpoHe26RViFq1KZQ8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615577116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5zLfYrI1ktdYvU0WYUSOt8cuz631ADpBZR0ROWuzBbA=;
        b=nS7IeHhuyXuf91cSN15FRXxDK/WPRkgLYCYWv9/0VxLU1hbe10Dcb4P9nCb5CahYzxCSyZ
        TBzC3MER9npvDQBQ==
To:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patch V2 3/3] signal: Allow tasks to cache one sigqueue struct
In-Reply-To: <20210312161830.GA27820@redhat.com>
References: <20210311132036.228542540@linutronix.de> <20210311141704.424120350@linutronix.de> <20210312113540.7byffvc46cgj75ah@linutronix.de> <20210312161830.GA27820@redhat.com>
Date:   Fri, 12 Mar 2021 20:25:16 +0100
Message-ID: <87eegk2mzn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12 2021 at 17:18, Oleg Nesterov wrote:
> On 03/12, Sebastian Andrzej Siewior wrote:
>>
>> On 2021-03-11 14:20:39 [+0100], Thomas Gleixner wrote:
>> > --- a/kernel/signal.c
>> > +++ b/kernel/signal.c
>> > @@ -433,7 +433,11 @@ static struct sigqueue *
>> >  	rcu_read_unlock();
>> >
>> >  	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
>> > -		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
>> > +		/* Preallocation does not hold sighand::siglock */
>> > +		if (sigqueue_flags || !t->sigqueue_cache)
>> > +			q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
>> > +		else
>> > +			q = xchg(&t->sigqueue_cache, NULL);
>>
>> Could it happen that two tasks saw t->sigqueue_cache != NULL, the first
>> one got the pointer via xchg() and the second got NULL via xchg()?
>
> It is called with sighand::siglock held, we don't even need xchg().

Yes, it was me being lazy. Lemme open code it as it's actually resulting
in a locked instruction.

Thanks,

        tglx
