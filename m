Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C322346725
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhCWSFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230370AbhCWSE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616522696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uPBDv/mZ0qWoPNfORl57Q3pvUHhVaQ4+uuhu3tZh9RI=;
        b=dvKJEGTOYQ+Cwh5V5jNjiGTBj6jKocMRNHC2m2blw+n9Goimd84oB1eItCEtHKL93HHlm4
        N/Crc0QaBfQVQ1BCIGkWrudUuuGngpB8036i8awPaY8l9qobPh9SK6UZke8QYx7zUstMCp
        +/yaqzDaFe0qBtqUKKBpjbajhxYuJLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-1vgo39YoP1G6D-t3hbEmMQ-1; Tue, 23 Mar 2021 14:04:55 -0400
X-MC-Unique: 1vgo39YoP1G6D-t3hbEmMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB9D32E95;
        Tue, 23 Mar 2021 18:04:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.84])
        by smtp.corp.redhat.com (Postfix) with SMTP id E952A60BE5;
        Tue, 23 Mar 2021 18:04:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 23 Mar 2021 19:04:52 +0100 (CET)
Date:   Tue, 23 Mar 2021 19:04:42 +0100
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
Subject: Re: [patch V4 2/2] signal: Allow tasks to cache one sigqueue struct
Message-ID: <20210323180442.GC29219@redhat.com>
References: <20210322091941.909544288@linutronix.de>
 <20210322092259.067712342@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322092259.067712342@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22, Thomas Gleixner wrote:
>
> +static void sigqueue_cache_or_free(struct sigqueue *q, bool cache)
> +{
> +	/*
> +	 * Cache one sigqueue per task. This pairs with the consumer side
> +	 * in __sigqueue_alloc() and needs READ/WRITE_ONCE() to prevent the
> +	 * compiler from store tearing and to tell KCSAN that the data race
> +	 * is intentional when run without holding current->sighand->siglock,
> +	 * which is fine as current obviously cannot run __sigqueue_free()
> +	 * concurrently.
> +	 */
> +	if (cache && !READ_ONCE(current->sigqueue_cache))
> +		WRITE_ONCE(current->sigqueue_cache, q);
> +	else
> +		kmem_cache_free(sigqueue_cachep, q);
> +}
> +
> +void exit_task_sigqueue_cache(struct task_struct *tsk)
> +{
> +	/* Race free because @tsk is mopped up */
> +	struct sigqueue *q = tsk->sigqueue_cache;
> +
> +	if (q) {
> +		tsk->sigqueue_cache = NULL;
> +		/* If task is self reaping, don't cache it back */
> +		sigqueue_cache_or_free(q, tsk != current);
                                          ^^^^^^^^^^^^^^
Still not right or I am totally confused.

tsk != current can be true if an exiting (and autoreaping) sub-thread
releases its group leader.

IOW. Suppose a process has 2 threads, its parent ignores SIGCHLD.

The group leader L exits. Then its sub-thread T exits too and calls
release_task(T). In this case the tsk != current is false.

But after that T calls release_task(L) and L != T is true.

I'd suggest to free tsk->sigqueue_cache in __exit_signal() unconditionally and
remove the "bool cache" argument from sigqueue_cache_or_free().

Oleg.

