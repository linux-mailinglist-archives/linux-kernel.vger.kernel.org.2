Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5C3E4177
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhHIISo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:18:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34864 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhHIISn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:18:43 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628497102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zlMdws6cyohkcKoE6LS+JeHUqOT6wr3OqaNW970zyGs=;
        b=lzL1EENgaymAqIl1jCW9hxawXEhOeoNQ2NqfUecla0ivj7gtrpx37WtJKhx09FPfM26XWK
        F78/CNMq06WuOrQjHsVgl5BBw65hl1EGFu0lgpFEh6I4nU0bEzZ7A5Ax7bvR5K7+QmByeL
        sw7oG8wz+FC6J39tRwT0phXcI9OnUqE6HQHJGJyDQdJgjWLAM+az8YQ30ULFhut53ve8FT
        nOKqvLGEpcn2J0S67oJq/35X2RSstOv687FhYEw82OmpFslpyR1tUZ+bGKCBUoO3jY2WG9
        fG4W3L6UbHaYmKbcDxuMceL1MJCy0KeL7QALH+BsQV6L7MUdAyrqo2MFoWrYQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628497102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zlMdws6cyohkcKoE6LS+JeHUqOT6wr3OqaNW970zyGs=;
        b=vWImuFQkcz+k7EjHGJ33+34dzM/uf9L53hfMpbqU2PsmULZlQWKK/kgmbJIv3dLPA3GUJG
        ntuiCZc0ItqafOBw==
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
In-Reply-To: <20210808170535.kotqd5t677tijh4o@offworld>
References: <20210805151300.330412127@linutronix.de>
 <20210805153956.051961951@linutronix.de>
 <20210808170535.kotqd5t677tijh4o@offworld>
Date:   Mon, 09 Aug 2021 10:18:22 +0200
Message-ID: <87o8a7t4j5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08 2021 at 10:05, Davidlohr Bueso wrote:
> On Thu, 05 Aug 2021, Thomas Gleixner wrote:
>
>>From: Thomas Gleixner <tglx@linutronix.de>
>>
>>The accounting is wrong when either the PI sanity check or the
>>requeue PI operation fails. Adjust it in the failure path.
>
> Ok fortunately these accounting errors are benign considering they
> are in error paths. This also made me wonder about the requeue PI
> top-waiter wakeup from futex_proxy_trylock_atomic(), which is always
> required with nr_wakers == 1. We account for it on the successful
> case we acquired the lock on it's behalf (and thus requeue_pi_wake_futex
> was called), but if the corresponding lookup_pi_state fails, we'll retry.
> So, shouldn't the task_count++ only be considered when we know the
> requeueing is next (a successful top_waiter acquiring the lock+pi state)?
>
> @@ -2260,7 +2260,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
> 		 */
> 		if (ret > 0) {
> 			WARN_ON(pi_state);
> -                       task_count++;
> 			/*
> 			 * If we acquired the lock, then the user space value
> 			 * of uaddr2 should be vpid. It cannot be changed by
> @@ -2275,6 +2274,8 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
> 			 */
> 			ret = lookup_pi_state(uaddr2, ret, hb2, &key2,
> 					      &pi_state, &exiting);
> +                       if (!ret)
> +                               task_count++;
> 		}

Yes, but if futex_proxy_trylock_atomic() succeeds and lookup_pi_state()
fails then the user space futex value is already the VPID of the top
waiter and a retry will then fail the futex_proxy_trylock_atomic().

> 		switch (ret) {
>
> Also, looking at the code, I think we can use the goto retry_private
> optimization for private futexes upon futex_proxy_trylock_atomic
> lookup_pi_state errors:
>
> @@ -2290,8 +2290,11 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
> 			double_unlock_hb(hb1, hb2);
> 			hb_waiters_dec(hb2);
> 			ret = fault_in_user_writeable(uaddr2);
> -                       if (!ret)
> +                       if (!ret) {
> +                               if (!(flags & FLAGS_SHARED))
> +                                       goto retry_private;
> 				goto retry;
> +                       }

Yes, we can, but let me stare at that code some more.

Thanks,

        tglx
