Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE30F3DF6BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 23:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhHCVKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 17:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhHCVKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 17:10:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D41C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 14:10:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628025031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aYXjvxGH0HQCUvBaWWNs/wWnSrA4zt3AGtwfB1Zssa0=;
        b=ljogT53oihP4xGkDAeUO9r0b+9sgo7YuhQUg9VQ4GE1e8PeALSsC/Saeouk9IF21sdbfap
        nSfJ7joTVOEB+P497BAUC3Ap0yn2e1fUbcZuJpLJk2vVeJ7sHrfCep575SSToZqOvZSu//
        DzAGLBBGixB2oMBOHhGkwvOA/ql83nvIjareeNmYGwjspa8C1ICBrYl+cSmMzuU3YrwI0X
        bY4IGxWTEVTjtyyDunJ8zg6Hz9ijkWafjrM7c04j/ou1G1Mo6q5GxQEmcecT7nil2soL8I
        pSnDFFD2U981rNBSLXD6TMnmwm7H1XN0pb66mVaixhd7nqmVQCUDrQ8Dj0fJFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628025031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aYXjvxGH0HQCUvBaWWNs/wWnSrA4zt3AGtwfB1Zssa0=;
        b=KmBHv0jn+KLHbV4zHl1z/CIl0ZFmfoxbH1iYjCIWjznXBNrBYak817otcy6ggYvTAq6FbD
        MnMU7Ylb9DShc0Dg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 58/63] futex: Prevent requeue_pi() lock nesting issue on RT
In-Reply-To: <20210803102808.GA8641@worktop.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135208.418508738@linutronix.de>
 <YQfraWyUYKtWgsQF@hirez.programming.kicks-ass.net>
 <20210803102808.GA8641@worktop.programming.kicks-ass.net>
Date:   Tue, 03 Aug 2021 23:10:30 +0200
Message-ID: <87sfzq2q0p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03 2021 at 12:28, Peter Zijlstra wrote:

> On Mon, Aug 02, 2021 at 02:56:09PM +0200, Peter Zijlstra wrote:
>>  static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
>>  {
>> +	int old, new;
>>  
>> +	old = atomic_read_acquire(&q->requeue_state);
>> +	do {
>
> 		if (old == Q_REQUEUE_PI_IGNORE)
> 			return;
>
>>  		if (locked >= 0) {
>
> 			WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_PROGRESS &&
> 			             old != Q_REQUEUE_PI_WAIT)
>
>>  			/* Requeue succeeded. Set DONE or LOCKED */
>>  			new = Q_REQUEUE_PI_DONE + locked;
>> +		} else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
>>  			/* Deadlock, no early wakeup interleave */
>>  			new = Q_REQUEUE_PI_NONE;
>>  		} else {
>
> 			WARN_ON_ONCE(old != Q_REQUEUE_PI_WAIT);
>
>
> I think... 

Yes, it's matching the valid transition table.

Thanks,

        tglx
