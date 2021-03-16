Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22633D3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhCPMha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhCPMgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:36:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1EBC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:36:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615898208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5T67T4qaHiDXoMpkcWjiAOffgIMzg2knxoBAdctmpig=;
        b=N04Bg9gpGocYqg54uYD76jm4xm9zgsIb5Sg0h06ngKHPk+BLqGV7/dQmbjBUh+d5KPrnWc
        tauQncAmWcn719qxpp5gK0I3hK2SMl27LNLCHGDqtIiMb+JzAQ9h07YxjNvm6YrjlOcCmy
        9igHjmTt9wKl0rgBfYLsVbOjQHmtXbPUuCujidxv44yBStYUoKXMJzbyZE7efaWIJu8eah
        CoX9ygjvMJb3nuTGZ2BQaIhDguJaJIpFW8gW+xY1mcWuuj0j51gPdWiaoVAGrUPNR8DFp7
        GhedI7TCYHngOmvzfOK80pOdyalfoVHKnaMgZzXY/L/HrJ04kTrP6IU6XXXUhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615898208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5T67T4qaHiDXoMpkcWjiAOffgIMzg2knxoBAdctmpig=;
        b=e5/nR+vprFNQLmlb+Mg/BnhDch0HBuYP7/jJ0zTTn46X25PS07iRR0kh3pWPf290pVhnrI
        mtFLwkyQMIPQRrCg==
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
In-Reply-To: <20210313164935.GA2362@redhat.com>
References: <20210311132036.228542540@linutronix.de> <20210311141704.424120350@linutronix.de> <20210312161148.GA25946@redhat.com> <87blbo2my0.fsf@nanos.tec.linutronix.de> <871rck2hze.fsf@nanos.tec.linutronix.de> <20210313164935.GA2362@redhat.com>
Date:   Tue, 16 Mar 2021 13:36:47 +0100
Message-ID: <87mtv31di8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13 2021 at 17:49, Oleg Nesterov wrote:
> On 03/12, Thomas Gleixner wrote:
>>
>> On Fri, Mar 12 2021 at 20:26, Thomas Gleixner wrote:
>> > On Fri, Mar 12 2021 at 17:11, Oleg Nesterov wrote:
>> >> On 03/11, Thomas Gleixner wrote:
>> >>>
>> >>> @@ -456,7 +460,12 @@ static void __sigqueue_free(struct sigqu
>> >>>  		return;
>> >>>  	if (atomic_dec_and_test(&q->user->sigpending))
>> >>>  		free_uid(q->user);
>> >>> -	kmem_cache_free(sigqueue_cachep, q);
>> >>> +
>> >>> +	/* Cache one sigqueue per task */
>> >>> +	if (!current->sigqueue_cache)
>> >>> +		current->sigqueue_cache = q;
>> >>> +	else
>> >>> +		kmem_cache_free(sigqueue_cachep, q);
>> >>>  }
>> >>
>> >> This doesn't look right, note that __exit_signal() does
>> >> flush_sigqueue(&sig->shared_pending) at the end, after exit_task_sighand()
>> >> was already called.
>> >>
>> >> I'd suggest to not add the new exit_task_sighand() helper and simply free
>> >> current->sigqueue_cache at the end of __exit_signal().
>> >
>> > Ooops. Thanks for spotting this!
>>
>> Hrm.
>>
>> The task which is released is obviously not current, so even if there
>> are still sigqueues in shared_pending then they wont end up in the
>> released tasks sigqueue_cache. They can only ever end up in
>> current->sigqueue_cache.
>
> The task which is released can be "current" if this task autoreaps.
> For example, if its parent ignores SIGCHLD. In this case exit_notify()
> does release_task(current).

Bah. Let me stare at it moar.

