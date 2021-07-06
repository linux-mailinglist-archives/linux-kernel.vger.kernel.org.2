Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42253BD73B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhGFMzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232340AbhGFMzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625575979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMk3jJazj16aYKwIRLSlPWAyzqY2mNy2vWTan63fswE=;
        b=RQjkHKVPWUkgsl/fWLhxMKa3d3rACm4kX7g5XQk+6+WQ3mrjKzKpKw1RTdd1y5Z99sr8K8
        7buJJMS2EOFDhpeXb9LOfOK6EvqoGtSmKTyqFWJuCNnCzWNKY3QRiOjiC2csQXFYlzmBd6
        aLcH9GJgRP2lPDzg1b9V3+UgdYmsR/4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-EiMoJQUTM1WC6I6FYrpyow-1; Tue, 06 Jul 2021 08:52:55 -0400
X-MC-Unique: EiMoJQUTM1WC6I6FYrpyow-1
Received: by mail-qk1-f197.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so16604596qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 05:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JMk3jJazj16aYKwIRLSlPWAyzqY2mNy2vWTan63fswE=;
        b=Jmb3UTphEB2lVoLW3XHssmcumwCFWMObHkSQT+SKiLaL7+11VJHNUYvqEt5knPxosS
         EqOyyXjJ3bNhSjFm4S1OG0hTFRP5ZGQHO+oh8ieU6z/rvnoLZSTdZMvxE5YG+C6vrryh
         AnaWHYlLlVi+Y2MyNAqIzOgg1RfPtAjCkXxLgYInwweYbKDpos81/TAbntviTxKvsdCL
         UmAFtokKN56NZBXIpFnuZHdusiseQH2fdLC+6V9ZNQTcAeXFfKb+Deq+alqRzsWu6X2q
         56hnWwy6lMDCEIekV8A4sScl5tmTwA+iJ5pPVFvP7jC0L4MMBNwyFmII2ok60O1UC3Q5
         N1gw==
X-Gm-Message-State: AOAM531FcGY+G43aasL9e80qkj+VpBzwyWRsJG2t5d1XEijlEeKzUOdf
        HVafEO5wnztcT/8cBk/ZA36M/xkRVrASOHlRCAfm8VwMU54t5oR/6YF7AaZElIm1QlDSV3M+xBQ
        UhKdFxG4+FXyIRTWVV30N6Z6E
X-Received: by 2002:a05:620a:40ce:: with SMTP id g14mr19870681qko.436.1625575975431;
        Tue, 06 Jul 2021 05:52:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfFLOq8iuPYvq5Ae0PBBM8i+ZbdcXtcX0M0SCs3X6yrGwqOC2cqwB5LHVJynkFkoMjjqnstQ==
X-Received: by 2002:a05:620a:40ce:: with SMTP id g14mr19870659qko.436.1625575975241;
        Tue, 06 Jul 2021 05:52:55 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id q12sm2273286qkn.47.2021.07.06.05.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 05:52:54 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/rwsem: Remove an unused parameter of rwsem_wake()
To:     Yehan Xu <yehanxu1@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        xuyehan <xuyehan@xiaomi.com>
References: <1625547043-28103-1-git-send-email-yehanxu1@gmail.com>
Message-ID: <a9be100c-b7b5-4353-37ea-e88d06bc5d2f@redhat.com>
Date:   Tue, 6 Jul 2021 08:52:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1625547043-28103-1-git-send-email-yehanxu1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/21 12:50 AM, Yehan Xu wrote:
> From: xuyehan <xuyehan@xiaomi.com>
>
> The 2nd parameter 'count' is not used in this function.
> The places where the function is called are also modified.
>
> Signed-off-by: xuyehan <xuyehan@xiaomi.com>
> ---
>   kernel/locking/rwsem.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 16bfbb1..8a595b6 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1165,7 +1165,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>    * handle waking up a waiter on the semaphore
>    * - up_read/up_write has decremented the active part of count if we come here
>    */
> -static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count)
> +static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
>   {
>   	unsigned long flags;
>   	DEFINE_WAKE_Q(wake_q);
> @@ -1297,7 +1297,7 @@ static inline void __up_read(struct rw_semaphore *sem)
>   	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
>   		      RWSEM_FLAG_WAITERS)) {
>   		clear_nonspinnable(sem);
> -		rwsem_wake(sem, tmp);
> +		rwsem_wake(sem);
>   	}
>   }
>   
> @@ -1319,7 +1319,7 @@ static inline void __up_write(struct rw_semaphore *sem)
>   	rwsem_clear_owner(sem);
>   	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
>   	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
> -		rwsem_wake(sem, tmp);
> +		rwsem_wake(sem);
>   }
>   
>   /*

Right, the count parameter was added in the past for some optimization 
which had since been taken out. So it is no longer needed.

Acked-by: Waiman Long <longman@redhat.com>

