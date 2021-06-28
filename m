Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FF53B6803
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhF1SAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231950AbhF1SAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624903064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WGSZJwLu54dZ1SXYRBBCBs+9QaI0qgizM8sbdetDwM=;
        b=Itx2qoTuAK/jxRKqcWnNB7Y3tJyxFw7ctl/6iv3RyiIcSsBSMnmvcccEtM7d/a8TiuM50L
        EnP8B6gx9V32PcbrTXTnNqLqv4ht1TGsJUAlyD2OW+P1BOQ6XDzJweryCe0exPvSlUEhqe
        zPpLwwP+pgzb9vSJlEFufz6boq0V5q8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-fXnrd-PKPfWtA78NRvZw0Q-1; Mon, 28 Jun 2021 13:57:42 -0400
X-MC-Unique: fXnrd-PKPfWtA78NRvZw0Q-1
Received: by mail-qt1-f199.google.com with SMTP id l14-20020ac84a8e0000b0290250ca4407e3so1247281qtq.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 10:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9WGSZJwLu54dZ1SXYRBBCBs+9QaI0qgizM8sbdetDwM=;
        b=menieuJmCDlAnct19cXJK8yokvn6ioO/zUIL1jlbnC+Q9yPGQMzuBqW76WQgNQrsPt
         S2r5eMS3wlAmIqbzFK5y23G8/J8USiyKbJ+IRPlZSlz1IjJSFvKAZQWfLc1CUNdekEma
         DbwhEKofLUj243sYMPiXdLI7bxU3ThUludi18TtmPH3mb50N25eEYQJKJCkb4hwU6All
         Mo8kZtsb0E/rdt5wusbqNnLwZlF7wtVQf1lWRMDXaYRq8QPrFGbzvyqB9yNGaZ5e5JUD
         CL2dw1yzbO6wuvuP+Ya/zDa1XU2z3LQR3Znpt3r/9j/CN1VMcbFwX0PjEtwXYQUXwzFF
         V1Rw==
X-Gm-Message-State: AOAM533q3czrfq1WmVpebuZk7lIW1+B1gq9Hmz8Qdn3XXG1Wic6BHHdG
        Y7VqbYjJv8zyS+U8R2brPQGwMlOmd0G2jHW0eN6GxBA3hCMnAIEBgGPVzDafyLozOAUvpX/Mkwf
        haGhyZ9CZWNt/Pjh7CyJA3t605Nf6wwGMbtBpfr6Ns7iRmKFj6zQw+fOEZlAc1ACvBWsUXqc4
X-Received: by 2002:ac8:5a44:: with SMTP id o4mr18771916qta.105.1624903062072;
        Mon, 28 Jun 2021 10:57:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvzsG+Y50g+nhJCdd145CH3hC/wAN38BytA0/QmqTyzZwxzcVHe7tP8qsb7TeJUaj0+gUTZA==
X-Received: by 2002:ac8:5a44:: with SMTP id o4mr18771899qta.105.1624903061750;
        Mon, 28 Jun 2021 10:57:41 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b66sm10885314qkc.4.2021.06.28.10.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 10:57:41 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/mutex: fix the MUTEX_FLAG_HANDOFF bit is cleared
 unexpected
To:     Yanfei Xu <yanfei.xu@windriver.com>, peterz@infradead.org,
        mingo@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210628155155.11623-1-yanfei.xu@windriver.com>
Message-ID: <e914d4fd-5afc-35f9-c068-7044ceda53dd@redhat.com>
Date:   Mon, 28 Jun 2021 13:57:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210628155155.11623-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 11:51 AM, Yanfei Xu wrote:
> When the mutex unlock path is excuted with WAITERS bit and without
> HANDOFF bit set, it will wake up the first task in wait_list. If
> there are some tasks not in wait_list are stealing lock, it is very
> likely successfully due to the task field of lock is NULL and flags
> field is non-NULL. Then the HANDOFF bit will be cleared. But if the
> HANDOFF bit was just set by the waked task in wait_list, this clearing
> is unexcepted.

I think you mean "unexpected". Right? Anyway, all the setting and 
clearing of the HANDOFF bit are atomic. There shouldn't be any 
unexpected clearing.

> __mutex_lock_common                   __mutex_lock_common
>    __mutex_trylock                       schedule_preempt_disabled
>      /*steal lock successfully*/         __mutex_set_flag(lock,MUTEX_FLAG_HANDOFF)
>      __mutex_trylock_or_owner
>        if (task==NULL)
>        flags &= ~MUTEX_FLAG_HANDOFF
>        atomic_long_cmpxchg_acquire
>                                          __mutex_trylock  //failed
>                                          mutex_optimistic_spin  //failed
>                                          schedule_preempt_disabled  //sleep without HANDOFF bit
>
> So the HANDOFF bit should be set as late as possible, here we defer
> it util the task is going to be scheduled.
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>
> Hi maintainers,
>
> I am not very sure if I missed or misunderstanded something, please help
> to review. Many thanks!
>
>   kernel/locking/mutex.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 013e1b08a1bf..e57d920e96bf 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -1033,17 +1033,17 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   		}
>   
>   		spin_unlock(&lock->wait_lock);
> +
> +		if (first)
> +			__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
>   		schedule_preempt_disabled();
>   
>   		/*
>   		 * ww_mutex needs to always recheck its position since its waiter
>   		 * list is not FIFO ordered.
>   		 */
> -		if (ww_ctx || !first) {
> +		if (ww_ctx || !first)
>   			first = __mutex_waiter_is_first(lock, &waiter);
> -			if (first)
> -				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
> -		}
>   
>   		set_current_state(state);
>   		/*

In general, I don't mind setting the HANDOFF bit later, but 
mutex_optimistic_spin() at the end of the loop should only be called 
after the HANDOFF bit is set. So the logic isn't quite right yet.

Cheers,
Longman

