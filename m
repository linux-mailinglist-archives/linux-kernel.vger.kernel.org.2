Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB385418ABF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhIZTYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 15:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229892AbhIZTYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 15:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632684143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoSf6PAqNKKVmkj88GYlQ6NXSkJYepwgfoHiCcAkFaI=;
        b=UGx5Hjw798eUWOegHdTdA1pUl6YLEcPihXx+PyQz08IUBVEiRQ8fKJKg0q0Y2e9hh5+tm/
        ZyjCnfvRVMSaYZkHbuGOPG/Pktcbf2XLjARTAeFlP9R2fUfL9OFt5u7PkPG2NbZPDXwURO
        yDHfkPQrtaM53bSN7B+1gfbPODDzwOs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-HXlg6LrJPRy2ZwiRzQek1Q-1; Sun, 26 Sep 2021 15:22:22 -0400
X-MC-Unique: HXlg6LrJPRy2ZwiRzQek1Q-1
Received: by mail-qk1-f197.google.com with SMTP id h10-20020a05620a284a00b003d30e8c8cb5so58428417qkp.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 12:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WoSf6PAqNKKVmkj88GYlQ6NXSkJYepwgfoHiCcAkFaI=;
        b=Rg3W9rPmidLsS5C4KfDNbmbM1ulp1Ia9pXe+oxunnyVJEnk0lU2X0+R8kcpW4JL+lG
         AiC3CbPMN7/1qGzvIfY1zWF0WbEzNncZR7JK7LorrbkBqK1PmaKPvZI+sYQKrf9HDAZM
         2fO0fVpujGx5XSFzc01LRJuME9rXoZUOdndD/9GhFWpvOxN+qlaY//kSdhPWr5NM4ti2
         9LSkF6sW/p8uFuQev0rlLMraRlgEirPZiU7YSIUPQMRb0hXMRALATwshYuNsaKRknJX/
         TAmDoa9yJ3w4M+aOVYkaKsYSZVZib55ViSeEt95N+h1B3C+l7fV2w0gQY3lDGjoO/tZE
         hCZg==
X-Gm-Message-State: AOAM531onE3c1bCJOCazy05mgf+aRJNzCmPfM2zpb6fqtom5Up2DNr+Y
        chxtyfEL5SqDuuLDhOKtUwRd2aR020uzdQvdNRasC7dS21VQTpTPVkShXBV2Xnx8kWTXHafhLZf
        I6Ugj8Jyp7/AQ6Gl6iuSUsn2Oo1ZKBlNZK20D1faBjCieDjx/unTHoK+ZFGOZjiT/p8nit8pF
X-Received: by 2002:ac8:560b:: with SMTP id 11mr15712996qtr.319.1632684141540;
        Sun, 26 Sep 2021 12:22:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynGYKcWp1w5/0xfsYdxi0HQg7qRVNrkZVBiGh2IGGk6aXA9gw0jZO3byL7M1lq8YFgkB80Iw==
X-Received: by 2002:ac8:560b:: with SMTP id 11mr15712982qtr.319.1632684141324;
        Sun, 26 Sep 2021 12:22:21 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id l13sm11018861qkj.130.2021.09.26.12.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 12:22:20 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/2] locking/rwsem: Use rcu_read_lock_sched to simplify
 codes
To:     Yanfei Xu <yanfei.xu@windriver.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210926101624.2460704-1-yanfei.xu@windriver.com>
 <20210926101624.2460704-2-yanfei.xu@windriver.com>
Message-ID: <4e4c9adf-5444-e331-fefa-0d72aea8ba57@redhat.com>
Date:   Sun, 26 Sep 2021 15:22:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210926101624.2460704-2-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/21 6:16 AM, Yanfei Xu wrote:
> Use rcu_read_lock_sched to simplify the codes, and it also saves
> some cycles of handling rcu nesting counter.
>
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>   kernel/locking/rwsem.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 000e8d5a2884..7afadfe02286 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -616,8 +616,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>   		return false;
>   	}
>   
> -	preempt_disable();
> -	rcu_read_lock();
> +	rcu_read_lock_sched();
>   	owner = rwsem_owner_flags(sem, &flags);
>   	/*
>   	 * Don't check the read-owner as the entry may be stale.
> @@ -625,8 +624,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>   	if ((flags & RWSEM_NONSPINNABLE) ||
>   	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
>   		ret = false;
> -	rcu_read_unlock();
> -	preempt_enable();
> +	rcu_read_unlock_sched();
>   
>   	lockevent_cond_inc(rwsem_opt_fail, !ret);
>   	return ret;

I don't think there is any performance gain with this change. I would 
prefer the original code that is more readable as some people may not 
know rcu_read_lock_sched() will disable preemption if they don't look 
into it.

Cheers,
Longman

