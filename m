Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBA403BA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349292AbhIHOg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231164AbhIHOg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631111749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fyCvOUubu5V5znnFPKMe78BgdN44gDtOtp7gcKdSn+c=;
        b=a3GVQrDHqvh7bsrS2tvFuZrsz7OuflkJ2j/EDw3lXE8AxepeZNpI7LYazoyXvtpE8OL0Uu
        qkhU6jq06E9kc95fyjaYaGCHVXw2tAvppi73Id3u61iStra/9/xwNcLhQA2Zt0Cw/zB4VI
        rqeeWqlhEHGaIHlHpeaTu4ZnJRhCjzY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-Ri9WKvsMP8eSSjJ4or1A5A-1; Wed, 08 Sep 2021 10:35:48 -0400
X-MC-Unique: Ri9WKvsMP8eSSjJ4or1A5A-1
Received: by mail-qv1-f72.google.com with SMTP id r18-20020a056214069200b0037a291a6081so1145468qvz.18
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 07:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fyCvOUubu5V5znnFPKMe78BgdN44gDtOtp7gcKdSn+c=;
        b=vK/7Ilya2cFTy31BphUpeuX7tC4n3DDSCOOiLYPUqXuNGrErI+x1jBH9UZa3ZNZY/a
         z/npIjh3JasBo3cP4r7sE61N0nlAppDAZC9dZhGq9sL0XtD11j16sOYj35XQlGdpDgAQ
         dbFLmJYLhYr25M3iiDUXri29ld3uyEbxCeIfZZQMq54qb8CfncaoDQL4MPX8UaSvEYHk
         m8iIiDKvRoH8gTTHc5ZZiLGyq7Ay/5gfSF8MTNpbK97JoaDRxd9kiFhk/GJMUoFAHcgO
         K/t12wuJJqCAqt8UDK1ipVdSGvqBBDNHswTnkydL7IxTDOgj2SCPjAgOgV6jvmQM8dmJ
         p/gw==
X-Gm-Message-State: AOAM5316sS36isvDG5LTZmlf/XqrLWyJHEDlQK2EyaozdN3kSt80syQJ
        FJSEFFfFhiOI5QnwKSg500v26HRa/EIzAUFNCf9TGr+8dJkGDGkgMfLemTswTzbtAmKD2tB+pDX
        tl0EQtozWhyyq4gzeJKhLwvUo
X-Received: by 2002:a05:622a:1347:: with SMTP id w7mr3886378qtk.325.1631111748010;
        Wed, 08 Sep 2021 07:35:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzthtc49bvVEAvQLoKrGXyPvuVdLihAb/JCbXUGSNxHx+kK7a/jyb0auYu1qctCYiPjc7j9BQ==
X-Received: by 2002:a05:622a:1347:: with SMTP id w7mr3886360qtk.325.1631111747794;
        Wed, 08 Sep 2021 07:35:47 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j9sm1498712qta.65.2021.09.08.07.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 07:35:47 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] lockdep: Let lock_is_held_type() detect recursive read
 as read
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Waiman Long <llong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210901162255.u2vhecaxgjsjfdtc@linutronix.de>
 <9af2b074-9fcf-5aea-f37d-9b2482146489@redhat.com>
 <20210903084001.lblecrvz4esl4mrr@linutronix.de>
Message-ID: <6bfddae4-dd66-b105-480f-ad4fe5c03276@redhat.com>
Date:   Wed, 8 Sep 2021 10:35:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210903084001.lblecrvz4esl4mrr@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 4:40 AM, Sebastian Andrzej Siewior wrote:
> lock_is_held_type(, 1) detects acquired read locks. It only recognized
> locks acquired with lock_acquire_shared(). Read locks acquired with
> lock_acquire_shared_recursive() are not recognized because a `2' is
> stored as the read value.
>
> Rework the check to additionally recognise lock's read value one and two
> as a read held lock.
>
> Fixes: e918188611f07 ("locking: More accurate annotations for read_lock()")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2:
>    - simplify the read check to !!read as suggested by Waiman Long.
>
>   kernel/locking/lockdep.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5366,7 +5366,7 @@ int __lock_is_held(const struct lockdep_
>   		struct held_lock *hlock = curr->held_locks + i;
>   
>   		if (match_held_lock(hlock, lock)) {
> -			if (read == -1 || hlock->read == read)
> +			if (read == -1 || hlock->read == !!read)
>   				return LOCK_STATE_HELD;
>   
>   			return LOCK_STATE_NOT_HELD;
>
Thanks for accepting my suggestion.

Acked-by: Waiman Long <longman@redhat.com>

