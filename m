Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C9832BFE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386281AbhCCSOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:14:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343706AbhCCPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614785861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kekw656uYC95FPRUxg1j2pExp/VajkKqqTQ75ucp+7I=;
        b=h2Pw4/GGubJZZvePsNY5wqDZ7k1tdWd3dsUfkHiZt50hiZvBVBFIxy2XUb7AeJLdJsKwzS
        lAQ6CnXfQNrrASJnEouVWJp6zJDIJ26S4HKu6I9pUzdkoIHwybwiNjrwUH/MQkEjowUrcJ
        r9RsYUs5x4p69u+gFhhl5igAhsO3Jhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-JhbiPPqlMNevTp_8NVRD6g-1; Wed, 03 Mar 2021 10:37:39 -0500
X-MC-Unique: JhbiPPqlMNevTp_8NVRD6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E66B6800D53;
        Wed,  3 Mar 2021 15:37:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 789205D9C6;
        Wed,  3 Mar 2021 15:37:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  3 Mar 2021 16:37:37 +0100 (CET)
Date:   Wed, 3 Mar 2021 16:37:33 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
Message-ID: <20210303153732.GC28955@redhat.com>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03, Sebastian Andrzej Siewior wrote:
>
> +static struct sigqueue *sigqueue_from_cache(struct task_struct *t)
> +{
> +	struct sigqueue *q = t->sigqueue_cache;
> +
> +	if (q && cmpxchg(&t->sigqueue_cache, q, NULL) == q)
> +		return q;
> +	return NULL;
> +}
> +
> +static bool sigqueue_add_cache(struct task_struct *t, struct sigqueue *q)
> +{
> +	if (!t->sigqueue_cache && cmpxchg(&t->sigqueue_cache, NULL, q) == NULL)
> +		return true;
> +	return false;
> +}

Do we really need cmpxchg? It seems they are always called with spinlock held.

>  static struct sigqueue *
> -__sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimit)
> +__sigqueue_do_alloc(int sig, struct task_struct *t, gfp_t flags,
> +		    int override_rlimit, bool fromslab)
>  {
>  	struct sigqueue *q = NULL;
>  	struct user_struct *user;
> @@ -432,7 +450,10 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimi
>  	rcu_read_unlock();
>
>  	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
> -		q = kmem_cache_alloc(sigqueue_cachep, flags);
> +		if (!fromslab)
> +			q = sigqueue_from_cache(t);
> +		if (!q)
> +			q = kmem_cache_alloc(sigqueue_cachep, flags);

I won't insist but afaics you can avoid the new arg/function and simplify this
patch. __sigqueue_alloc() can simply check "sig > 0" or valid_signal(sig) rather
than "!fromslab".

> +static void __sigqueue_cache_or_free(struct sigqueue *q)
> +{
> +	struct user_struct *up;
> +
> +	if (q->flags & SIGQUEUE_PREALLOC)
> +		return;
> +
> +	up = q->user;
> +	if (atomic_dec_and_test(&up->sigpending))
> +		free_uid(up);
> +	if (!task_is_realtime(current) || !sigqueue_add_cache(current, q))
> +		kmem_cache_free(sigqueue_cachep, q);
> +}

Well, this duplicates __sigqueue_free... Do we really need the new helper?
What if we simply change __sigqueue_free() to do sigqueue_add_cache() if
task_is_realtime() && !PF_EXITING ? This too can simplify the patch...

Oleg.

