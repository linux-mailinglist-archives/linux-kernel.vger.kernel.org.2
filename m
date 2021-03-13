Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B404339F38
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhCMQt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 11:49:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233570AbhCMQtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 11:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615654192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xWfmgenJ5fz6j3ee7IU4/fm/YAyf6aJba6DCt9PRqmo=;
        b=edWOOQjaECliXq521NYs600TtatmCbhAGScCvEaLlehGMWfzIE7vPgil6Y3OkUQYwlg5af
        uGq176+zKjOsoFkQXc4jGJV3qNSt3keZER3SI5143z5GQHYnq2gYCOWGJIAl76NUbNAUaG
        VLZ2curMN4pN9l/5Z5m1pktkQQ0PRWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-dlkZOjr3NiuUTajx998kqQ-1; Sat, 13 Mar 2021 11:49:49 -0500
X-MC-Unique: dlkZOjr3NiuUTajx998kqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B555801817;
        Sat, 13 Mar 2021 16:49:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.94])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0AF0A620DE;
        Sat, 13 Mar 2021 16:49:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 13 Mar 2021 17:49:47 +0100 (CET)
Date:   Sat, 13 Mar 2021 17:49:36 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <20210313164935.GA2362@redhat.com>
References: <20210311132036.228542540@linutronix.de>
 <20210311141704.424120350@linutronix.de>
 <20210312161148.GA25946@redhat.com>
 <87blbo2my0.fsf@nanos.tec.linutronix.de>
 <871rck2hze.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rck2hze.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12, Thomas Gleixner wrote:
>
> On Fri, Mar 12 2021 at 20:26, Thomas Gleixner wrote:
> > On Fri, Mar 12 2021 at 17:11, Oleg Nesterov wrote:
> >> On 03/11, Thomas Gleixner wrote:
> >>>
> >>> @@ -456,7 +460,12 @@ static void __sigqueue_free(struct sigqu
> >>>  		return;
> >>>  	if (atomic_dec_and_test(&q->user->sigpending))
> >>>  		free_uid(q->user);
> >>> -	kmem_cache_free(sigqueue_cachep, q);
> >>> +
> >>> +	/* Cache one sigqueue per task */
> >>> +	if (!current->sigqueue_cache)
> >>> +		current->sigqueue_cache = q;
> >>> +	else
> >>> +		kmem_cache_free(sigqueue_cachep, q);
> >>>  }
> >>
> >> This doesn't look right, note that __exit_signal() does
> >> flush_sigqueue(&sig->shared_pending) at the end, after exit_task_sighand()
> >> was already called.
> >>
> >> I'd suggest to not add the new exit_task_sighand() helper and simply free
> >> current->sigqueue_cache at the end of __exit_signal().
> >
> > Ooops. Thanks for spotting this!
>
> Hrm.
>
> The task which is released is obviously not current, so even if there
> are still sigqueues in shared_pending then they wont end up in the
> released tasks sigqueue_cache. They can only ever end up in
> current->sigqueue_cache.

The task which is released can be "current" if this task autoreaps.
For example, if its parent ignores SIGCHLD. In this case exit_notify()
does release_task(current).

> But that brings my memory back why I had cmpxchg() in the original
> version. This code runs without current->sighand->siglock held.

Yes, I was wrong too. This code runs without exiting_task->sighand->siglock
and this is fine in that it can not race with send_signal(exiting_task),
but somehow I missed the fact that it always populates current->sigqueue_cache,
not exiting_task->sigqueue_cache.

Oleg.

