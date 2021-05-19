Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD11E38935F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355058AbhESQOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354944AbhESQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621440776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXwJzRZ7zgWiYl+erQOAZQqpqYQhrjBJ4uZ+DvjP3bk=;
        b=KBeQ1npRDYdtH4KJiVf0TBI3ZVU6GB3j1OtyEhjaA1X8AEg5TrLedpKSvSUy4SC/ugRUfN
        9pOpH34XjCKHZ9nIhtjPjdcidmgIqL+dhMqpDB+CjsPtYpyzpx03ncsktKxFT/NaLbolzt
        NK6j6JJnPHqwVsCeXWqS4OJ17BGMx0M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-7rnnwFAmPHqt1K3Lb6jmag-1; Wed, 19 May 2021 12:12:53 -0400
X-MC-Unique: 7rnnwFAmPHqt1K3Lb6jmag-1
Received: by mail-qv1-f70.google.com with SMTP id n12-20020a0cdc8c0000b02901efdf8d3bc7so7975797qvk.23
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jXwJzRZ7zgWiYl+erQOAZQqpqYQhrjBJ4uZ+DvjP3bk=;
        b=Vmplf4ierjAINlYh3I7/tgzAPYv7cOhygVB84XpfVuF/Idzb/HCiMMxwhHluOra8im
         cDASZt9gJGyK8H4tlSYVAdky99zbwVQ+FzuflQwOLNge8Enm+x5d2MGkaZ+UTe8ngvDS
         wrp1l/MxGP614nav6kN3fiPM5Q67f7AV9pOqPmxvlu7RPGtswMIWqreCm0b8daJke+MD
         /+vBy0Y+k8VmCeNl8nbKcWnSCzAmeR07hhg6/pfzDx+VWJWklNqtZBXgXPx115OMWZzK
         7xTXKBj1KaYqb7323AYQ3iLDWwLUVBivIWpV78cWBHXX5yTfIxKIyKs+fCjWuzFoJbv2
         o0YQ==
X-Gm-Message-State: AOAM530ETohPms9EVS8CRQOTRsC7P4Qv+kpbu0n50GpXBrUaIwUbvXW4
        pVyc1esd5AXYbI7YHb8V76tl4pzsPco1OghFxuV1RL5HFkBr+ePm3HCh7eIPbBdsGNgUseqKyLl
        DX48joUD+z8R45I93vihu775t
X-Received: by 2002:a05:622a:150:: with SMTP id v16mr140735qtw.285.1621440773142;
        Wed, 19 May 2021 09:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2r7R6QUOjc1nMWME2jnGkajLjdS1Ohgz9fANqS5hyT2L1tsM/ZI3FD8SzAC+mCAEaUCwG0Q==
X-Received: by 2002:a05:622a:150:: with SMTP id v16mr140709qtw.285.1621440772955;
        Wed, 19 May 2021 09:12:52 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id d16sm15387281qtw.23.2021.05.19.09.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 09:12:52 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3] locking/mutex: clear MUTEX_FLAGS if wait_list is empty
 due to signal
To:     Peter Zijlstra <peterz@infradead.org>, qiang.zhang@windriver.com
Cc:     mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, maarten.lankhorst@canonical.com
References: <20210517034005.30828-1-qiang.zhang@windriver.com>
 <YKObq4li1qwyEyDa@hirez.programming.kicks-ass.net>
Message-ID: <0c7e13ef-12d0-37bf-ce43-3377249c8c33@redhat.com>
Date:   Wed, 19 May 2021 12:12:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YKObq4li1qwyEyDa@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 6:49 AM, Peter Zijlstra wrote:
> On Mon, May 17, 2021 at 11:40:05AM +0800, qiang.zhang@windriver.com wrote:
>> From: Zqiang <qiang.zhang@windriver.com>
>>
>> When a interruptible mutex locker is interrupted by a signal
>> without acquiring this lock and removed from the wait queue.
>> if the mutex isn't contended enough to have a waiter
>> put into the wait queue again, the setting of the WAITER
>> bit will force mutex locker to go into the slowpath to
>> acquire the lock every time, so if the wait queue is empty,
>> the WAITER bit need to be clear.
> I'm still interestd in knowing how you found this. Did you have an
> actual problem, or were you just reading the code?
>
> AFAICT, this needs:
>
> Fixes: 040a0a371005 ("mutex: Add support for wound/wait style locks")
>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> Thanks!
>
> Updated patch below.
>
> ---
> Subject: locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal
> From: Zqiang <qiang.zhang@windriver.com>
> Date: Mon, 17 May 2021 11:40:05 +0800
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> When a interruptible mutex locker is interrupted by a signal
> without acquiring this lock and removed from the wait queue.
> if the mutex isn't contended enough to have a waiter
> put into the wait queue again, the setting of the WAITER
> bit will force mutex locker to go into the slowpath to
> acquire the lock every time, so if the wait queue is empty,
> the WAITER bit need to be clear.
>
> Fixes: 040a0a371005 ("mutex: Add support for wound/wait style locks")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20210517034005.30828-1-qiang.zhang@windriver.com
> ---
>   kernel/locking/mutex-debug.c |    4 ++--
>   kernel/locking/mutex-debug.h |    2 +-
>   kernel/locking/mutex.c       |   18 +++++++++++++-----
>   kernel/locking/mutex.h       |    4 +---
>   4 files changed, 17 insertions(+), 11 deletions(-)
>
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -57,7 +57,7 @@ void debug_mutex_add_waiter(struct mutex
>   	task->blocked_on = waiter;
>   }
>   
> -void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
> +void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>   			 struct task_struct *task)
>   {
>   	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
> @@ -65,7 +65,7 @@ void mutex_remove_waiter(struct mutex *l
>   	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
>   	task->blocked_on = NULL;
>   
> -	list_del_init(&waiter->list);
> +	INIT_LIST_HEAD(&waiter->list);
>   	waiter->task = NULL;
>   }
>   
> --- a/kernel/locking/mutex-debug.h
> +++ b/kernel/locking/mutex-debug.h
> @@ -22,7 +22,7 @@ extern void debug_mutex_free_waiter(stru
>   extern void debug_mutex_add_waiter(struct mutex *lock,
>   				   struct mutex_waiter *waiter,
>   				   struct task_struct *task);
> -extern void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
> +extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>   				struct task_struct *task);
>   extern void debug_mutex_unlock(struct mutex *lock);
>   extern void debug_mutex_init(struct mutex *lock, const char *name,
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -194,7 +194,7 @@ static inline bool __mutex_waiter_is_fir
>    * Add @waiter to a given location in the lock wait_list and set the
>    * FLAG_WAITERS flag if it's the first waiter.
>    */
> -static void __sched
> +static void
>   __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>   		   struct list_head *list)
>   {
> @@ -205,6 +205,16 @@ __mutex_add_waiter(struct mutex *lock, s
>   		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
>   }
>   
> +static void
> +__mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
> +{
> +	list_del(&waiter->list);
> +	if (likely(list_empty(&lock->wait_list)))
> +		__mutex_clear_flag(lock, MUTEX_FLAGS);
> +
> +	debug_mutex_remove_waiter(lock, waiter, current);
> +}
> +
>   /*
>    * Give up ownership to a specific task, when @task = NULL, this is equivalent
>    * to a regular unlock. Sets PICKUP on a handoff, clears HANDOFF, preserves
> @@ -1061,9 +1071,7 @@ __mutex_lock_common(struct mutex *lock,
>   			__ww_mutex_check_waiters(lock, ww_ctx);
>   	}
>   
> -	mutex_remove_waiter(lock, &waiter, current);
> -	if (likely(list_empty(&lock->wait_list)))
> -		__mutex_clear_flag(lock, MUTEX_FLAGS);
> +	__mutex_remove_waiter(lock, &waiter);
>   
>   	debug_mutex_free_waiter(&waiter);
>   
> @@ -1080,7 +1088,7 @@ __mutex_lock_common(struct mutex *lock,
>   
>   err:
>   	__set_current_state(TASK_RUNNING);
> -	mutex_remove_waiter(lock, &waiter, current);
> +	__mutex_remove_waiter(lock, &waiter);
>   err_early_kill:
>   	spin_unlock(&lock->wait_lock);
>   	debug_mutex_free_waiter(&waiter);
> --- a/kernel/locking/mutex.h
> +++ b/kernel/locking/mutex.h
> @@ -10,12 +10,10 @@
>    * !CONFIG_DEBUG_MUTEXES case. Most of them are NOPs:
>    */
>   
> -#define mutex_remove_waiter(lock, waiter, task) \
> -		__list_del((waiter)->list.prev, (waiter)->list.next)
> -
>   #define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
>   #define debug_mutex_free_waiter(waiter)			do { } while (0)
>   #define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
> +#define debug_mutex_remove_waiter(lock, waiter, ti)     do { } while (0)
>   #define debug_mutex_unlock(lock)			do { } while (0)
>   #define debug_mutex_init(lock, name, key)		do { } while (0)
>   
>
Reviewed-by: Waiman Long <longman@redhat.com>

