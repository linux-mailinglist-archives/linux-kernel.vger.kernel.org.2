Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7213E4434
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhHIKwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhHIKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:52:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6411C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 03:52:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628506326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R3rD6zt7Yj71sWI/j1ern85v6Heo4nPPYxYtS0PtPYY=;
        b=QeA8NcWK+lz7vH/xsiORpAF8cwyGRm2YhnNUWocFTC0rPesnIVmW39DBcBm0VyTmdumTul
        /BFBrK4ISc/SEso1RYupJvc/Gf8kudf+mEey6qB8hsmE4pWlApJYK7tXF7fr1UVNs1TLvL
        /6ZdjMjwbUtbZ1sJkjqJclQLVAXb2rO/HssFS5BQjWKwt4IYAl/DOHUVF5f2TKyRa3IiUq
        UsPvFknzTtY5wbvM1QRKlx4znf40cdwoQkmYnmmNpDkjuZdiY1rsAHGyuTmmjT9leA5FK/
        42Lpej6KJvs9MyaH8j3V8gftGKtgEyR1bSNUGjVuyvc5jSG50IhC6Eh5N4Zpug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628506326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R3rD6zt7Yj71sWI/j1ern85v6Heo4nPPYxYtS0PtPYY=;
        b=L1PC3jl/SG0i5n6rEmleNkloDT0yV/wkxnAFiBrJr740+4CC/mywQWtPihE7BfU4pZM9ZD
        OsDJLp8EcnpBsYBQ==
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V3 56/64] futex: Correct the number of requeued waiters
 for PI
In-Reply-To: <87o8a7t4j5.ffs@tglx>
References: <20210805151300.330412127@linutronix.de>
 <20210805153956.051961951@linutronix.de>
 <20210808170535.kotqd5t677tijh4o@offworld> <87o8a7t4j5.ffs@tglx>
Date:   Mon, 09 Aug 2021 12:52:06 +0200
Message-ID: <87bl66ubzd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2021 at 10:18, Thomas Gleixner wrote:
> On Sun, Aug 08 2021 at 10:05, Davidlohr Bueso wrote:
>> On Thu, 05 Aug 2021, Thomas Gleixner wrote:
>>
>>>From: Thomas Gleixner <tglx@linutronix.de>
>>>
>>>The accounting is wrong when either the PI sanity check or the
>>>requeue PI operation fails. Adjust it in the failure path.
>>
>> Ok fortunately these accounting errors are benign considering they
>> are in error paths. This also made me wonder about the requeue PI
>> top-waiter wakeup from futex_proxy_trylock_atomic(), which is always
>> required with nr_wakers == 1. We account for it on the successful
>> case we acquired the lock on it's behalf (and thus requeue_pi_wake_futex
>> was called), but if the corresponding lookup_pi_state fails, we'll retry.
>> So, shouldn't the task_count++ only be considered when we know the
>> requeueing is next (a successful top_waiter acquiring the lock+pi state)?
>>
>> @@ -2260,7 +2260,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
>> 		 */
>> 		if (ret > 0) {
>> 			WARN_ON(pi_state);
>> -                       task_count++;
>> 			/*
>> 			 * If we acquired the lock, then the user space value
>> 			 * of uaddr2 should be vpid. It cannot be changed by
>> @@ -2275,6 +2274,8 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
>> 			 */
>> 			ret = lookup_pi_state(uaddr2, ret, hb2, &key2,
>> 					      &pi_state, &exiting);
>> +                       if (!ret)
>> +                               task_count++;
>> 		}
>
> Yes, but if futex_proxy_trylock_atomic() succeeds and lookup_pi_state()
> fails then the user space futex value is already the VPID of the top
> waiter and a retry will then fail the futex_proxy_trylock_atomic().

Actually lookup_pi_state() cannot fail here.

If futex_proxy_trylock_atomic() takes the user space futex then there
are no waiters on futex2 and the task for which the proxy trylock
acquired futex2 in the user space storage cannot be exiting because it's
still enqueued on futex1.

That means lookup_pi_state() will take the attach_to_pi_owner() path and
that will succeed because VPID belongs to an alive task.

What's wrong in that code though is the condition further up:

	if (requeue_pi && (task_count - nr_wake < nr_requeue)) {

nr_wake has to be 1 for requeue PI. For the first round task_count is 0
which means the condition is true for any value of nr_requeue >= 0.

It does not really matter because none of the code below that runs the
retry path, but it's at least confusing as hell.

Let me fix all of that muck.

Thanks,

        tglx

