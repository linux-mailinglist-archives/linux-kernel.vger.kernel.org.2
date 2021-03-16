Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9F33D2D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhCPLU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhCPLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:20:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB24C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 04:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H0+XOLkoMVXCbyysjYiqgZHo2N88kyXyuv8/1eSC17E=; b=f3ToQqg799VhSAQ4JceXZxmXYH
        J+Aq1XkaAgd28fpR/pjlXVgwjITIhE20vs+4v8k9S4eTY485SjmBpx4CRPE8sH+eodsgcv/Hw/2Do
        MRqgbjJqt35JpSdkIbxQylJCHnL/UW72j1agtmy3ln9uYnnh9718ZHK2MVcJcWDHuDAmismgfUtcA
        qTbZ1FdhpKHDoiMBOfMMVt9C/t+qB938Q3RNYKuPAzIMoqxEaD7ZqaxY7fywfvHMa3JkKg2xkDMng
        eQdiBceeXQXc/hksMSj3emTw7COZ9tLehoejuZOHdlTlkeUbwJa3TgPhYXNSbwzO3ev6Z4uBuXhyH
        HADxBdTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM7k3-000Xx3-Tr; Tue, 16 Mar 2021 11:20:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91255305C10;
        Tue, 16 Mar 2021 12:20:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 829202010C4BC; Tue, 16 Mar 2021 12:20:02 +0100 (CET)
Date:   Tue, 16 Mar 2021 12:20:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] futex: Leave the pi lock stealer in a consistent
 state upon successful fault
Message-ID: <YFCUYimuDkUonySp@hirez.programming.kicks-ass.net>
References: <20210315050224.107056-1-dave@stgolabs.net>
 <20210315050224.107056-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315050224.107056-3-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 10:02:24PM -0700, Davidlohr Bueso wrote:
> Before 34b1a1ce145 (futex: Handle faults correctly for PI futexes) any
> concurrent pi_state->owner fixup would assume that the task that fixed
> things on our behalf also correctly updated the userspace value. This
> is not always the case anymore, and can result in scenarios where a lock
> stealer returns a successful FUTEX_PI_LOCK operation but raced during a fault
> with an enqueued top waiter in an immutable state so the uval TID was
> not updated for the stealer, breaking otherwise expected (and valid)
> semantics and confusing the stealer task:


> ---
>  kernel/futex.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index ded7af2ba87f..95ce10c4e33d 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2460,7 +2460,6 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
>  
>  	case -EAGAIN:
>  		cond_resched();
> -		err = 0;
>  		break;
>  
>  	default:
> @@ -2474,11 +2473,22 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
>  	/*
>  	 * Check if someone else fixed it for us:
>  	 */
> -	if (pi_state->owner != oldowner)
> +	if (pi_state->owner != oldowner) {
> +		/*
> +		 * The change might have come from the rare immutable
> +		 * state below, which leaves the userspace value out of
> +		 * sync. But if we are the lock stealer and can update
> +		 * the uval, do so, instead of reporting a successful
> +		 * lock operation with an invalid user state.
> +		 */
> +		if (!err && argowner == current)
> +			goto retry;
> +
>  		return argowner == current;
> +	}
>  
>  	/* Retry if err was -EAGAIN or the fault in succeeded */
> -	if (!err)
> +	if (err == -EAGAIN || !err)
>  		goto retry;
>  

IIRC we made the explicit choice to never loop here. That saves having
to worry about getting stuck in in-kernel loops.

Userspace triggering the case where the futex goes corrupt is UB, after
that we have no obligation for anything to still work. It's on them,
they get to deal with the bits remaining.

