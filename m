Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3D744E0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 05:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhKLEMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 23:12:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229698AbhKLEMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 23:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636690182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzT+hJRJDm8whHlBc4wRWRLfgWlK1pSjubMM97S2KVo=;
        b=X3bhBkmzR+5wcRy4Jti8Jr1E4/tGaCu/Nl6qU13mlGZAp3YX3MP4Rdj6vpvkiTw6yAE+P9
        F7rktRSL1TnvwhFQbDHnGeupJzxyRz6RXJ8HvDeg8aUoP7ADH7ZN2D6wqxFvYtj78i/tpG
        qsL7Wtm3/65/dUT/F6LJQ7OZLgM8cd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-a6HEay0LOUyBXhl03T8McQ-1; Thu, 11 Nov 2021 23:09:37 -0500
X-MC-Unique: a6HEay0LOUyBXhl03T8McQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BADC15723;
        Fri, 12 Nov 2021 04:09:35 +0000 (UTC)
Received: from [10.22.32.120] (unknown [10.22.32.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23E2414104;
        Fri, 12 Nov 2021 04:09:31 +0000 (UTC)
Message-ID: <79b7d906-4c2b-3089-450a-1d0e3f3fd9d9@redhat.com>
Date:   Thu, 11 Nov 2021 23:09:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>,
        Hillf Danton <hdanton@sina.com>,
        Maria Yu <quic_aiquny@quicinc.com>
References: <20211111223339.362757-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211111223339.362757-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/21 17:33, Waiman Long wrote:
> There are some inconsistency in the way that the handoff bit is being
> handled in readers and writers.
>
> Firstly, when a queue head writer set the handoff bit, it will clear it
> when the writer is being killed or interrupted on its way out without
> acquiring the lock. That is not the case for a queue head reader. The
> handoff bit will simply be inherited by the next waiter.
>
> Secondly, in the out_nolock path of rwsem_down_read_slowpath(), both
> the waiter and handoff bits are cleared if the wait queue becomes empty.
> For rwsem_down_write_slowpath(), however, the handoff bit is not checked
> and cleared if the wait queue is empty. This can potentially make the
> handoff bit set with empty wait queue.
>
> To make the handoff bit handling more consistent and robust,
> extract out the rwsem flags handling code into a common
> rwsem_out_nolock_clear_flags() function and call it from both the
> reader and writer's out_nolock paths.  The common function will only
> use atomic_long_andnot() to clear bits to avoid possible race condition.
> It will also let the next waiter inherit the handoff bit if it had been
> set.
>
> This will elminate the handoff bit set with empty wait queue case as
> well as the possible race condition that may screw up the count value.
>
> While at it, simplify the trylock for loop in rwsem_down_write_slowpath()
> to make it easier to read.
>
> Fixes: 4f23dbc1e657 ("locking/rwsem: Implement lock handoff to prevent lock starvation")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/rwsem.c | 117 ++++++++++++++++-------------------------
>   1 file changed, 44 insertions(+), 73 deletions(-)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index c51387a43265..d587acd1142b 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -104,10 +104,11 @@
>    * atomic_long_fetch_add() is used to obtain reader lock, whereas
>    * atomic_long_cmpxchg() will be used to obtain writer lock.
>    *
> - * There are three places where the lock handoff bit may be set or cleared.
> - * 1) rwsem_mark_wake() for readers.
> - * 2) rwsem_try_write_lock() for writers.
> - * 3) Error path of rwsem_down_write_slowpath().
> + * There are four places where the lock handoff bit may be set or cleared.
> + * 1) rwsem_mark_wake() for readers            -- set, clear
> + * 2) rwsem_try_write_lock() for writers       -- set, clear
> + * 3) Error path of rwsem_down_write_slowpath() -- clear
> + * 4) Error path of rwsem_down_read_slowpath()  -- clear
>    *
>    * For all the above cases, wait_lock will be held. A writer must also
>    * be the first one in the wait_list to be eligible for setting the handoff
> @@ -334,6 +335,9 @@ struct rwsem_waiter {
>   	struct task_struct *task;
>   	enum rwsem_waiter_type type;
>   	unsigned long timeout;
> +
> +	/* Writer only, not initialized in reader */
> +	bool handoff_set;
>   };
>   #define rwsem_first_waiter(sem) \
>   	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
> @@ -344,12 +348,6 @@ enum rwsem_wake_type {
>   	RWSEM_WAKE_READ_OWNED	/* Waker thread holds the read lock */
>   };
>   
> -enum writer_wait_state {
> -	WRITER_NOT_FIRST,	/* Writer is not first in wait list */
> -	WRITER_FIRST,		/* Writer is first in wait list     */
> -	WRITER_HANDOFF		/* Writer is first & handoff needed */
> -};
> -
>   /*
>    * The typical HZ value is either 250 or 1000. So set the minimum waiting
>    * time to at least 4ms or 1 jiffy (if it is higher than 4ms) in the wait
> @@ -531,13 +529,11 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>    * This function must be called with the sem->wait_lock held to prevent
>    * race conditions between checking the rwsem wait list and setting the
>    * sem->count accordingly.
> - *
> - * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
> - * bit is set or the lock is acquired with handoff bit cleared.
>    */
>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
> -					enum writer_wait_state wstate)
> +					struct rwsem_waiter *waiter)
>   {
> +	bool first = rwsem_first_waiter(sem) == waiter;
>   	long count, new;
>   
>   	lockdep_assert_held(&sem->wait_lock);
> @@ -546,13 +542,15 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   	do {
>   		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>   
> -		if (has_handoff && wstate == WRITER_NOT_FIRST)
> +		if (has_handoff && !first)
>   			return false;
>   
>   		new = count;
>   
>   		if (count & RWSEM_LOCK_MASK) {
> -			if (has_handoff || (wstate != WRITER_HANDOFF))
> +			waiter->handoff_set = true;

Sorry, the setting of the handoff_set flag isn't quite right here. Will 
send another fixed version out.

Cheers,
Longman

