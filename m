Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F4A32E6E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCEK6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:58:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhCEK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614941895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHlrpn4zse8BQ0Odyiv2E1am7E/hOFAxlulV7HXZ0PM=;
        b=ZCmABzpTrR0DTSBHwH0N3PJLqpBjM8JJx+vXKMb1+flbAXrfp4OCqNxsR0R/zoOBY4uflK
        W9eKwttTZ8K1zWve6jNwPkEbluAB3THifv3RNXeRr6TbvuAxOAUaBAj36fL9W0bxQj/DaC
        Dcu/TnG1wIu53/4vmgVIht8im11YES0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-ErG1G87MPb-WDEP0o854_Q-1; Fri, 05 Mar 2021 05:58:13 -0500
X-MC-Unique: ErG1G87MPb-WDEP0o854_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46E6C1054F90;
        Fri,  5 Mar 2021 10:58:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.191])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8C48760C43;
        Fri,  5 Mar 2021 10:57:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  5 Mar 2021 11:58:10 +0100 (CET)
Date:   Fri, 5 Mar 2021 11:57:57 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
Message-ID: <20210305105756.GA20900@redhat.com>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de>
 <20210303153732.GC28955@redhat.com>
 <87im6662xg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im6662xg.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04, Thomas Gleixner wrote:
>
> On Wed, Mar 03 2021 at 16:37, Oleg Nesterov wrote:
> > On 03/03, Sebastian Andrzej Siewior wrote:
> >>
> >> +static struct sigqueue *sigqueue_from_cache(struct task_struct *t)
> >> +{
> >> +	struct sigqueue *q = t->sigqueue_cache;
> >> +
> >> +	if (q && cmpxchg(&t->sigqueue_cache, q, NULL) == q)
> >> +		return q;
> >> +	return NULL;
> >> +}
> >> +
> >> +static bool sigqueue_add_cache(struct task_struct *t, struct sigqueue *q)
> >> +{
> >> +	if (!t->sigqueue_cache && cmpxchg(&t->sigqueue_cache, NULL, q) == NULL)
> >> +		return true;
> >> +	return false;
> >> +}
> >
> > Do we really need cmpxchg? It seems they are always called with
> > spinlock held.
>
> With which spinlock held?
>
> __send_signal()         <- sighand::siglock held
>   __sigqueue_alloc()
>
> alloc_posix_timer()
>   sigqueue_alloc()      <- No lock held
>     __sigqueue_alloc()

In the last case "fromslab" is true, sigqueue_from_cache() won't be called.

> and on the free side we have a bunch of callers which do not hold
> sighand::siglock either.

Where?

Oleg.

