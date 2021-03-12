Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309A23392F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhCLQTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:19:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232109AbhCLQSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615565928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5c5N1ZK1U0xPecIFlI/Fl2cm3KIuypx4d5GpgtQy3DI=;
        b=hbZ/g4ELTBU7RqjibaXc190FLfxi7gJ0/F9ScyBW3xuiAOc4z5VUgDuhRO1JfHRi94wycF
        mcFioYNCMd2OdZTh7bSHedZqBwp3zqPShOjuScWaECnx23W8+QLn/t2lpb6u0Iskb9GbuF
        7xbRX1ZTNczhFQpJOYiaxjEHGcI/454=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-vBvgoyUhNMaKFinv31tAiA-1; Fri, 12 Mar 2021 11:18:44 -0500
X-MC-Unique: vBvgoyUhNMaKFinv31tAiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05911100C619;
        Fri, 12 Mar 2021 16:18:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id A0DFA100164A;
        Fri, 12 Mar 2021 16:18:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 12 Mar 2021 17:18:41 +0100 (CET)
Date:   Fri, 12 Mar 2021 17:18:31 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20210312161830.GA27820@redhat.com>
References: <20210311132036.228542540@linutronix.de>
 <20210311141704.424120350@linutronix.de>
 <20210312113540.7byffvc46cgj75ah@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312113540.7byffvc46cgj75ah@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12, Sebastian Andrzej Siewior wrote:
>
> On 2021-03-11 14:20:39 [+0100], Thomas Gleixner wrote:
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -433,7 +433,11 @@ static struct sigqueue *
> >  	rcu_read_unlock();
> >
> >  	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
> > -		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
> > +		/* Preallocation does not hold sighand::siglock */
> > +		if (sigqueue_flags || !t->sigqueue_cache)
> > +			q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
> > +		else
> > +			q = xchg(&t->sigqueue_cache, NULL);
>
> Could it happen that two tasks saw t->sigqueue_cache != NULL, the first
> one got the pointer via xchg() and the second got NULL via xchg()?

It is called with sighand::siglock held, we don't even need xchg().

Oleg.

