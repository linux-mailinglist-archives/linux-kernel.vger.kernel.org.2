Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE538202E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhEPRXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 13:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhEPRXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 13:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621185753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDiEGH8Te8Z5pH38ORG9kA5iAjjhoG8Jb7rNjGB7KsU=;
        b=SIN51zK+jmuD/lA4Dn9oWNN79WXvRE2ArpvKW5IEHqv0s14j1q700lq/7Mb9+Av2B8ppph
        6PuklF/NvTfBYDMLdjEW8kPpfSIzyTIlQs/s/Vssw8nTNtc50chxHGqB9TpmvifNSAsfPQ
        MzQ3uG5p3IPIckC00TEebO5lTFeHCVU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-SX4RB6JBMGiR4VqAHAwCVQ-1; Sun, 16 May 2021 13:22:31 -0400
X-MC-Unique: SX4RB6JBMGiR4VqAHAwCVQ-1
Received: by mail-qk1-f200.google.com with SMTP id s68-20020a372c470000b0290305f75a7cecso3097767qkh.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 10:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YDiEGH8Te8Z5pH38ORG9kA5iAjjhoG8Jb7rNjGB7KsU=;
        b=cHyceZeEzG9zMh1DeohfoiuiR/Sl8aZtU1Lda5/hG2ohiAI9TQv9CI5sY7adDDfYX7
         D/1VYbOpBF0OavRm2fJVUFe9tnfjQ3SOCnunzlFnq2fzKZGvScbfLAI55hYtL+G5njwZ
         rANtpc3XoRK8lnpMP1PaJCVE6LNhiYrjahvm2ai0rYK8+tHTUaby3k5j/vW5tTHeslD1
         X/M+uIwv2XA9PkH1brLCmNY2LYURQKs9w6yqf8rsBrCQ3X8mhYBq8SKI7ihcCXOJ/bNk
         ELTZwRMyE8yqmNCoCVTzoGfLVrGE4PCdydPYromG1i5bEMvMQjfmD03xoyiBoHmu/ccx
         +WLQ==
X-Gm-Message-State: AOAM5327BKcHYJmUCwSy8b4gf4CiFwCq5Ek4tQ8/xm4oKd73ln8PDhCp
        9F9vhFsOvQUv3QJgE89Dh/E2US3rTXG/tcfXc4tX95a8nruQnSXIetNKjE+5kscnTdEcgAeppQN
        3LWM0FMyC7XlSx2TbGKH0A+RfAbxFpn2BTzD0FWqiGHNFLxskvwnA9RiVgtq/dOcfJP8kkft7
X-Received: by 2002:a37:a54b:: with SMTP id o72mr50598462qke.261.1621185750511;
        Sun, 16 May 2021 10:22:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx74KBoZdR70GBY8apz2qJBc8WPR5CFnZ9avzjVDss16Q/f0o3fEI3Ta6objxlN40Z2QZhJ/g==
X-Received: by 2002:a37:a54b:: with SMTP id o72mr50598440qke.261.1621185750215;
        Sun, 16 May 2021 10:22:30 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id d23sm8577479qtg.69.2021.05.16.10.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 10:22:29 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] locking/mutex: clear MUTEX_FLAGS if wait_list is empty
 due to signal
To:     qiang.zhang@windriver.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210516045354.348117-1-qiang.zhang@windriver.com>
Message-ID: <3ff1f3d3-19db-98a6-756d-48161c45acf9@redhat.com>
Date:   Sun, 16 May 2021 13:22:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210516045354.348117-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/21 12:53 AM, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
>
> When call mutex_lock_interruptible(), if after queue waiter to
> lock->wait_list, exit cycle interrupted by signal without obtaining
> lock, the waiter be del from lock->wait_list, if the lock->wait_list
> is empty, and not clear MUTEX_FLAGS, when the lock is acquired again
> , because the lock flags exist, the trylock_fast will be failed,
> and enter slow path acqurie lock, so clear MUTEX_FLAGS when call
> mutex_lock_interruptible() interrupted by a signal and the
> lock->wait_list is empty,  in this way, when the lock is acquired
> again, it will acquire succeed in the fast path.

Well, you have managed to put all these information into one English 
sentence:-)

Anyway, this is not proper English and you need to break it down into 
several sentences.

After looking at the code again, this bug is not a correctness issue. It 
is mainly a performance issue. If the mutex isn't contended enough to 
have a waiter put into the wait queue again, the setting of the WAITER 
bit will force mutex locker to go into the slowpath to acquire the lock 
every time.

BTW, you should have put "Suggested-by: Peter Zijlstra 
<peterz@infradead.org>" before your signed-off line as an attribution to 
him as he had suggested the change in this patch.

Cheers,
Longman

>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>   v1->v2:
>   Make commit info clearer and modify the code again.
>
>   kernel/locking/mutex-debug.c |  4 ++--
>   kernel/locking/mutex-debug.h |  2 +-
>   kernel/locking/mutex.c       | 16 +++++++++++-----
>   kernel/locking/mutex.h       |  4 +---
>   4 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
> index a7276aaf2abc..db9301591e3f 100644
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -57,7 +57,7 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>   	task->blocked_on = waiter;
>   }
>   
> -void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
> +void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>   			 struct task_struct *task)
>   {
>   	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
> @@ -65,7 +65,7 @@ void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>   	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
>   	task->blocked_on = NULL;
>   
> -	list_del_init(&waiter->list);
> +	INIT_LIST_HEAD(&waiter->list);
>   	waiter->task = NULL;
>   }
>   
> diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
> index 1edd3f45a4ec..53e631e1d76d 100644
> --- a/kernel/locking/mutex-debug.h
> +++ b/kernel/locking/mutex-debug.h
> @@ -22,7 +22,7 @@ extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
>   extern void debug_mutex_add_waiter(struct mutex *lock,
>   				   struct mutex_waiter *waiter,
>   				   struct task_struct *task);
> -extern void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
> +extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>   				struct task_struct *task);
>   extern void debug_mutex_unlock(struct mutex *lock);
>   extern void debug_mutex_init(struct mutex *lock, const char *name,
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index cb6b112ce155..4815162d04b1 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -205,6 +205,15 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>   		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
>   }
>   
> +static void
> +__mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
> +{
> +	__list_del(waiter->list.prev, waiter->list.next);
> +	debug_mutex_remove_waiter(lock, waiter, current);
> +	if (likely(list_empty(&lock->wait_list)))
> +		__mutex_clear_flag(lock, MUTEX_FLAGS);
> +}
> +
>   /*
>    * Give up ownership to a specific task, when @task = NULL, this is equivalent
>    * to a regular unlock. Sets PICKUP on a handoff, clears HANDOFF, preserves
> @@ -1061,10 +1070,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   			__ww_mutex_check_waiters(lock, ww_ctx);
>   	}
>   
> -	mutex_remove_waiter(lock, &waiter, current);
> -	if (likely(list_empty(&lock->wait_list)))
> -		__mutex_clear_flag(lock, MUTEX_FLAGS);
> -
> +	__mutex_remove_waiter(lock, &waiter);
>   	debug_mutex_free_waiter(&waiter);
>   
>   skip_wait:
> @@ -1080,7 +1086,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   
>   err:
>   	__set_current_state(TASK_RUNNING);
> -	mutex_remove_waiter(lock, &waiter, current);
> +	__mutex_remove_waiter(lock, &waiter);
>   err_early_kill:
>   	spin_unlock(&lock->wait_lock);
>   	debug_mutex_free_waiter(&waiter);
> diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
> index 1c2287d3fa71..f0c710b1d192 100644
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


