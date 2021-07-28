Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0D3D996A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhG1X2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:28:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52072 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhG1X2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:28:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 97DF91F41CC4
Subject: Re: [patch 42/50] futex: Cleanup stale comments
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160750.053836299@linutronix.de>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <1c931d28-1ad2-519a-9896-c3d7273384fa@collabora.com>
Date:   Wed, 28 Jul 2021 20:28:44 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210713160750.053836299@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 12:11 de 13/07/21, Thomas Gleixner escreveu:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The futex key reference mechanism is long gone. Cleanup the stale comments
> which still mention it.
> 

There are two comments at futex_wait() that can be cleaned as well:

/*
 * Prepare to wait on uaddr. On success, holds hb lock and increments
 * q.key refs.
 */

/* unqueue_me() drops q.key ref */


> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/futex.c |  9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> ---
> diff --git a/kernel/futex.c b/kernel/futex.c
> index b8eab7a2934b..e0f266fa7249 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1354,7 +1354,7 @@ static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
>   *  -  1 - acquired the lock;
>   *  - <0 - error
>   *
> - * The hb->lock and futex_key refs shall be held by the caller.
> + * The hb->lock must be held by the caller.
>   *
>   * @exiting is only set when the return value is -EBUSY. If so, this holds
>   * a refcount on the exiting task on return and the caller needs to drop it
> @@ -2621,8 +2621,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
>   *
>   * Setup the futex_q and locate the hash_bucket.  Get the futex value and
>   * compare it with the expected value.  Handle atomic faults internally.
> - * Return with the hb lock held and a q.key reference on success, and unlocked
> - * with no q.key reference on failure.
> + * Return with the hb lock held on success, and unlocked on failure.
>   *
>   * Return:
>   *  -  0 - uaddr contains val and hb has been locked;
> @@ -3235,9 +3234,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
>  	 * In order for us to be here, we know our q.key == key2, and since
>  	 * we took the hb->lock above, we also know that futex_requeue() has
>  	 * completed and we no longer have to concern ourselves with a wakeup
> -	 * race with the atomic proxy lock acquisition by the requeue code. The
> -	 * futex_requeue dropped our key1 reference and incremented our key2
> -	 * reference count.
> +	 * race with the atomic proxy lock acquisition by the requeue code.
>  	 */
>  
>  	/*
> 
> 
