Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905F13A2E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhFJOqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhFJOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:46:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6411C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:44:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623336288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P9i2STUTf93CvmLRHys/MQ1Ky/p6ZQuDDGUamBB9Eck=;
        b=vpDtlHv1NS1/V317LnuTkH896gyzPYuQGYD9mhkWJ10PPjX9wCcpinJkcUnSp3Tu/+tJxr
        AfB+IKciypPYrNNXpjBqeaPTEu+d/wa+MmfNO0p837VWJWJzTBi4QxwOmTVfxqJg1IqTW2
        8xGJRB3dEMztazTWzX0wdlCfuHWmDyoqcsF0M/t8FtyuE98jk2feDZpz89ZHayYWS36/GS
        HpRL3ehlDa3FqbLA5oe6dzxlfiLzXMhY8FEmB8B4hyfR8n6I1qK8JgXl89ea1wbpRP7QyV
        1SEVjyv3IsmFX/mMXmZ23n89/1l01xwlQFCq0pmIVHh/VxfVNXNolqa14xcY3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623336288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P9i2STUTf93CvmLRHys/MQ1Ky/p6ZQuDDGUamBB9Eck=;
        b=+Taf8z23t0At0JDxwlzPar9AdexA4I253DPxA5+DbzYMxBkkWNM4rzOWKyNwJG6HFZZTXN
        vEwl+uECIWOQrHDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v2 2/2] printk: fix cpu lock ordering
In-Reply-To: <YL+DjNG0uhg/uT+C@alley>
References: <20210607200232.22211-1-john.ogness@linutronix.de> <20210607200232.22211-3-john.ogness@linutronix.de> <YL9osWvgvdCo4JAK@alley> <875yyoigms.fsf@jogness.linutronix.de> <YL+DjNG0uhg/uT+C@alley>
Date:   Thu, 10 Jun 2021 16:44:47 +0200
Message-ID: <8735tpu6cg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-08, Petr Mladek <pmladek@suse.com> wrote:
>> 	/*
>> 	 * Guarantee loads and stores from this CPU when it is the lock owner
>> 	 * are _not_ visible to the previous lock owner. This pairs with
>> 	 * cpu_unlock:B.
>> 	 *
>> 	 * Memory barrier involvement:
>> 	 *
>> 	 * If cpu_lock:A reads from cpu_unlock:B, then cpu_unlock:A can never
>> 	 * read from cpu_lock:B.
>> 	 *
>> 	 * Relies on:
>> 	 *
>> 	 * RELEASE from cpu_unlock:A to cpu_unlock:B
>> 	 *    matching
>> 	 * ACQUIRE from cpu_lock:A to cpu_lock:B
>> 	 */
>
> I can't check this so I believe you ;-)

I appreciate your confidence in me, but for the record, we should
operate on proofs. Here is a litmus test for this case that is only
using the 2 memory barriers described in the coments. I also added
commented out non-memory-barrier variants so you can quickly check what
happens if either memory barrier is removed.

-------- BEGIN prevent_backwards_leak.litmus --------
C prevent_backwards_leak

(*
 * Guarantee a previous CPU (P0) in the critical section cannot
 * see data stored by the next CPU (P1) in the critical section.
 *
 * RELEASE in P0 matches ACQUIRE in P1
 *)

{ }

P0(int *lck, int *var)
{
	int old;
	int val;

	old = atomic_cmpxchg_relaxed(lck, 0, 1);
	if (old == 0) {
		val = *var;
		atomic_set_release(lck, 2);
		//atomic_set(lck, 2);
	}
}

P1(int *lck, int *var)
{
	int old;

	old = atomic_cmpxchg_acquire(lck, 2, 3);
	//old = atomic_cmpxchg_relaxed(lck, 2, 3);
	if (old == 2) {
		*var = 1;
		atomic_set(lck, 3);
	}
}

exists (1:old=2 /\ 0:val=1)
-------- END prevent_backwards_leak.litmus --------

And running it shows:

$ herd7 -conf linux-kernel.cfg prevent_backwards_leak.litmus
Test prevent_backwards_leak Allowed
States 3
0:val=0; 1:old=0;
0:val=0; 1:old=1;
0:val=0; 1:old=2;
No
Witnesses
Positive: 0 Negative: 3
Condition exists (1:old=2 /\ 0:val=1)
Observation prevent_backwards_leak Never 0 3
Time prevent_backwards_leak 0.01
Hash=a83f3a63382111d7f61810639fa38ad4

If either of the two memory barriers are removed, the results will show
that @val in first CPU (P0) can be 1 (0:val=1), which was the value set
by the following CPU (P1) in the critical section.

>> 	/*
>> 	 * Guarantee loads and stores from this CPU when it was the
>> 	 * lock owner are visible to the next lock owner. This pairs
>> 	 * with cpu_lock:A.
>> 	 *
>> 	 * Memory barrier involvement:
>> 	 *
>> 	 * If cpu_lock:A reads from cpu_unlock:B, then cpu_lock:B
>> 	 * reads from cpu_unlock:A.
>> 	 *
>> 	 * Relies on:
>> 	 *
>> 	 * RELEASE from cpu_unlock:A to cpu_unlock:B
>> 	 *    matching
>> 	 * ACQUIRE from cpu_lock:A to cpu_lock:B
>> 	 */
>
> Same as for acquire ;-)

And here is the litmus test for this case, also with extra commented out
non-memory-barrier variants.

-------- BEGIN guarantee_forward_visibility.litmus --------
C guarantee_forward_visibility

(*
 * Guarantee data stored by a previous CPU (P0) in the critical
 * section is always visible to the next CPU (P1) in the critical
 * section.
 *
 * RELEASE in P0 matches ACQUIRE in P1
 *)

{ }

P0(int *lck, int *var)
{
	int old;

	old = atomic_cmpxchg_relaxed(lck, 0, 1);
	if (old == 0) {
		*var = 1;
		atomic_set_release(lck, 2);
		//atomic_set(lck, 2);
	}
}

P1(int *lck, int *var)
{
	int old;
	int val;

	old = atomic_cmpxchg_acquire(lck, 2, 3);
	//old = atomic_cmpxchg_relaxed(lck, 2, 3);
	if (old == 2) {
		val = *var;
		atomic_set(lck, 3);
	}
}

exists (1:old=2 /\ 1:val=0 )
-------- END guarantee_forward_visibility.litmus --------

$ herd7 -conf linux-kernel.cfg guarantee_forward_visibility.litmus
Test guarantee_forward_visibility Allowed
States 3
1:old=0; 1:val=0;
1:old=1; 1:val=0;
1:old=2; 1:val=1;
No
Witnesses
Positive: 0 Negative: 3
Condition exists (1:old=2 /\ 1:val=0)
Observation guarantee_forward_visibility Never 0 3
Time guarantee_forward_visibility 0.00
Hash=fad189f07da06da99b97a7ab1215a5dc

Also here, if either of the memory barriers are removed, @val in the
later CPU (P1) can be 0 (1:val=0). Meaning that the a following CPU in
the critical section would not see a value set by the previous CPU in
the critical section.

John Ogness
