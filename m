Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B803468F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhCWTZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhCWTY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:24:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:24:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616527496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XymQE3BZ9skWIXCgwTWfmoNnNNp3VHzyUS4ZrjkJeUg=;
        b=O775ff2bjRjYnLHoLeFWDQd+4wYMCWfGMvIp10xPJCkF2qk8KocULa20ydWwHQEtk1+hzP
        MbONTRPZACM9a6wD/b14nwcTE1zIeE/acKg3F8RA4MrCZ6eaRAGKMVc4x9Qy00xo4BZf32
        fhL6ajmNedDpkbPTyBxJmy8wMrBMbuZAV7ul1tswgmyItd7tcufzNe0UTEQSlEC8v0bLu+
        vrNchJa0Vxqx1pngaddk2FY6fjjoMCaLWoP0pVhR5evT+iFcnl/a7GrfWiStnJ9JlCj4xw
        H2sLUh2hHmOfULUF167pMdVRAVHjCGF4TM15VK1iDfuzdXwnrOuPlWvyBtcuSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616527496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XymQE3BZ9skWIXCgwTWfmoNnNNp3VHzyUS4ZrjkJeUg=;
        b=zoMwwjdoSxKI8PnoYGj3/b3ZPRZkKAALrAtKfj8ePvwlI+cptT8ioENIHWm2IWWnj6+HzB
        z3/JfVjcUhGLEMCw==
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
Subject: Re: [patch V4 2/2] signal: Allow tasks to cache one sigqueue struct
In-Reply-To: <20210323180442.GC29219@redhat.com>
References: <20210322091941.909544288@linutronix.de> <20210322092259.067712342@linutronix.de> <20210323180442.GC29219@redhat.com>
Date:   Tue, 23 Mar 2021 20:24:55 +0100
Message-ID: <87o8f9r7ug.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23 2021 at 19:04, Oleg Nesterov wrote:
> On 03/22, Thomas Gleixner wrote:
>> +static void sigqueue_cache_or_free(struct sigqueue *q, bool cache)
>> +	if (q) {
>> +		tsk->sigqueue_cache = NULL;
>> +		/* If task is self reaping, don't cache it back */
>> +		sigqueue_cache_or_free(q, tsk != current);
>                                           ^^^^^^^^^^^^^^
> Still not right or I am totally confused.
>
> tsk != current can be true if an exiting (and autoreaping) sub-thread
> releases its group leader.
>
> IOW. Suppose a process has 2 threads, its parent ignores SIGCHLD.
>
> The group leader L exits. Then its sub-thread T exits too and calls
> release_task(T). In this case the tsk != current is false.
>
> But after that T calls release_task(L) and L != T is true.

Bah. yes.

> I'd suggest to free tsk->sigqueue_cache in __exit_signal() unconditionally and
> remove the "bool cache" argument from sigqueue_cache_or_free().

That's what you get from trying to be clever, dammit.

Thanks for walking me through the oddities of exit !

       tglx
