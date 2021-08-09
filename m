Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CF63E3E11
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 05:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhHIDBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 23:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231675AbhHIDBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628478070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4dSjgKQoH8rg2Z/W5pbCkJL08kojd3OkQAS8xVSCOU=;
        b=J4uttgq1fiwPm/Yhe9CE3K4lwRrr5s/EuHAdUe6RzXu1ryFMmAOjRqsfO/toMZ+JXbYQLT
        eYExN1X0XgjmzBQKclW2q9AjJ7vv61L9KMHEEF1xDQqAo5GtibUSV4DL3v+W5lD+U8j0rN
        xDNZUHF9RZzwZV7odUNy4N4OJkR/xGw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-ClZJs3R-Nzybgsds2964xQ-1; Sun, 08 Aug 2021 23:01:09 -0400
X-MC-Unique: ClZJs3R-Nzybgsds2964xQ-1
Received: by mail-qk1-f199.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so11712292qkd.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 20:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H4dSjgKQoH8rg2Z/W5pbCkJL08kojd3OkQAS8xVSCOU=;
        b=UkmDmRy/Fa1OyWhpSLljdDAXqO4UWJaNzOi2v5LBG2PYNKMPsjIlq4vZVPPxWL2DSm
         n1P456V7FWgi1w/KKW0b2Puj7iRvq0khEe/xp0xiol5+r/sjjqwNcHjDGn/FlV4pMVvB
         ynxkwjcHZYju6vzYd933Mn0Vqx/E4KTK1s7GihAvC/oyAt2xxRDai1KDfjE1GbaNxoY2
         M0cHXyW/TLHFFQDRuaG8d/vF35PJfpdoNptXE9eNYbIci/ydPgJOHHL5LDrFsd9kTv2q
         S51NhrwRKiXBbEO2jcSkeD5wtedWaE4CoLVmFH2AHgEoUJFWTJzoU8R3LDeMAlWnZUBN
         +olg==
X-Gm-Message-State: AOAM531srVRD/QthG8p2kOcSBDSuefppxKg6+9Anzw+Aafemm8+xxrud
        oI8/Dx+26r+kK7eVhEEHsCMvCDZMOoYcXIrTLyiBzc2TK0DLQuRea4IqzPvtzPy6iA9b5zPLtI8
        yplnPS9oJEx0DLMZL3WrYcb/d
X-Received: by 2002:a05:6214:2025:: with SMTP id 5mr21702146qvf.8.1628478069239;
        Sun, 08 Aug 2021 20:01:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznP2SlYCtkfufBoqLxZD0LFRK8nq3ZjtlpzYJkfqhIZ7O/uh5mzNL5YLYMpdvnmvx4jNf5Uw==
X-Received: by 2002:a05:6214:2025:: with SMTP id 5mr21702132qvf.8.1628478069069;
        Sun, 08 Aug 2021 20:01:09 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id l4sm8574579qkd.77.2021.08.08.20.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 20:01:08 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
To:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com
Cc:     wangle6@huawei.com, xiaoqian9@huawei.com, shaolexi@huawei.com
References: <20210809021215.19991-1-nixiaoming@huawei.com>
Message-ID: <48cddad4-0388-ae8b-f98b-1629b9ae590a@redhat.com>
Date:   Sun, 8 Aug 2021 23:01:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809021215.19991-1-nixiaoming@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/21 10:12 PM, Xiaoming Ni wrote:
> Semaphore is sleeping lock. Add might_sleep() to down*() family
> (with exception of down_trylock()) to detect atomic context sleep.
>
> Previously discussed with Peter Zijlstra, see link:
>   https://lore.kernel.org/lkml/20210806082320.GD22037@worktop.programming.kicks-ass.net
>
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>   kernel/locking/semaphore.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> index 9aa855a96c4a..9ee381e4d2a4 100644
> --- a/kernel/locking/semaphore.c
> +++ b/kernel/locking/semaphore.c
> @@ -54,6 +54,7 @@ void down(struct semaphore *sem)
>   {
>   	unsigned long flags;
>   
> +	might_sleep();
>   	raw_spin_lock_irqsave(&sem->lock, flags);
>   	if (likely(sem->count > 0))
>   		sem->count--;
> @@ -77,6 +78,7 @@ int down_interruptible(struct semaphore *sem)
>   	unsigned long flags;
>   	int result = 0;
>   
> +	might_sleep();
>   	raw_spin_lock_irqsave(&sem->lock, flags);
>   	if (likely(sem->count > 0))
>   		sem->count--;
> @@ -103,6 +105,7 @@ int down_killable(struct semaphore *sem)
>   	unsigned long flags;
>   	int result = 0;
>   
> +	might_sleep();
>   	raw_spin_lock_irqsave(&sem->lock, flags);
>   	if (likely(sem->count > 0))
>   		sem->count--;
> @@ -157,6 +160,7 @@ int down_timeout(struct semaphore *sem, long timeout)
>   	unsigned long flags;
>   	int result = 0;
>   
> +	might_sleep();
>   	raw_spin_lock_irqsave(&sem->lock, flags);
>   	if (likely(sem->count > 0))
>   		sem->count--;

I think it is simpler to just put a "might_sleep()" in __down_common() 
which is the function where sleep can actually happen.

Cheers,
Longman

