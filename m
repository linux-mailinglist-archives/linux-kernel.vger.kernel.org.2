Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68E93C9C18
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbhGOJtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50000 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231177AbhGOJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626342406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63rEYMvbRV/seme2lHP04MhulnxJq0wVcWV/g6b7U3A=;
        b=dH7trVCpTZhlmJFxkTM96+C3OY6+k6mbW/mD75XP/iZ612N2srTZNMe+mrWOPBGQDYgAPS
        4+b4ZFrSGKDk0EkvHguW2dURdMGtSIkGhoOfwosBWCAWjbGYOEk/rImMID3rtmecy6SMiT
        kHDa2kJ12/XAws64aYc4UIDhJsDUMMk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-cLu8Ih25MJ2GpdVPigwwfg-1; Thu, 15 Jul 2021 05:46:45 -0400
X-MC-Unique: cLu8Ih25MJ2GpdVPigwwfg-1
Received: by mail-wr1-f70.google.com with SMTP id k3-20020a5d52430000b0290138092aea94so3053655wrc.20
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 02:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=63rEYMvbRV/seme2lHP04MhulnxJq0wVcWV/g6b7U3A=;
        b=EclNFpryopr0O70UvKPdsFKEET+7K01AhuVaFJ9g96hMciim9uwZGDWMM8ei1Xx1ex
         84LcLoPfw9BWfO66q9kGNgcKURl6WcVmGs0jU8Eq2kuIgBVPVV7bKYeE2WlNORrlKQJj
         q/3tJYVhf4DyNDMNn+fgD3FgTj1k/tKDwdSc2Yg5HosXs0k3tZpUkdZ3zTu/OdaUee8H
         YNgqaO+HHXF16tTiCAF60shtz6t7GvxifkD9PiNf96QQ4EZLDm7/QieHrgimLAYMb2Iw
         1OXgxjSbn/p0dnSgq/AoWrqHdzYQxWwqArxs5RUblo0X4g822Fd3dPtjzYb5CzdN3osT
         7r5g==
X-Gm-Message-State: AOAM532Z5Zi3gqlpS3oys2s6VxKvBScIJAnVKXb5tBuect2sDOELqh2Z
        NJAASrhhdo+YMJgBfj27L6k1/G0vNoW9LPgjaS06XgaRTat1ijXe6S7TVoXuFBgC3h6FC/Bn/ss
        0Pk05b+i35kYc7yaBbIEjIAvk
X-Received: by 2002:adf:c849:: with SMTP id e9mr4400927wrh.348.1626342404244;
        Thu, 15 Jul 2021 02:46:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAlRWZdFCQmU4uYFlLS/6X4VeHrqQXEJhJ4ipYEq1DWloKab9RhGjbb5OjL4I9k0gygal+7Q==
X-Received: by 2002:adf:c849:: with SMTP id e9mr4400904wrh.348.1626342404021;
        Thu, 15 Jul 2021 02:46:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id d9sm5813182wrx.76.2021.07.15.02.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 02:46:43 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9951ef78-587a-34e1-7b5b-280285e37098@redhat.com>
Date:   Thu, 15 Jul 2021 11:46:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/21 10:22, Daniel Bristot de Oliveira wrote:
> On 7/14/21 12:35 PM, Paolo Bonzini wrote:
>> On 14/07/21 11:23, Jason Wang wrote:
>>> I think this can be probably fixed here:
>>>
>>> https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/
>>
>> That seems wrong; in particular it wouldn't protect against AB/BA deadlocks.
>> In fact, the bug is with the locking; the code assumes that
>> spin_lock_irqsave/spin_unlock_irqrestore is non-preemptable and therefore
>> increments and decrements the percpu variable inside the critical section.
>>
>> This obviously does not fly with PREEMPT_RT; the right fix should be
>> using a local_lock.  Something like this (untested!!):
> 
> the lock needs to be per-pcu...

Great, thanks for testing and fixing the patch!  Are you going to post 
it again once you've confirmed it works?

Paolo

> The patch looks like this now:
> 
> ------------------------- 8< ---------------------
> Subject: [PATCH] eventfd: protect eventfd_wake_count with a local_lock
> 
> eventfd_signal assumes that spin_lock_irqsave/spin_unlock_irqrestore is
> non-preemptable and therefore increments and decrements the percpu
> variable inside the critical section.
> 
> This obviously does not fly with PREEMPT_RT. If eventfd_signal is
> preempted and an unrelated thread calls eventfd_signal, the result is
> a spurious WARN. To avoid this, protect the percpu variable with a
> local_lock.
> 
> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> Cc: stable@vger.kernel.org
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Co-developed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> ---
>   fs/eventfd.c            | 27 ++++++++++++++++++++++-----
>   include/linux/eventfd.h |  7 +------
>   2 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index e265b6dd4f34..9754fcd38690 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -12,6 +12,7 @@
>   #include <linux/fs.h>
>   #include <linux/sched/signal.h>
>   #include <linux/kernel.h>
> +#include <linux/local_lock.h>
>   #include <linux/slab.h>
>   #include <linux/list.h>
>   #include <linux/spinlock.h>
> @@ -25,8 +26,6 @@
>   #include <linux/idr.h>
>   #include <linux/uio.h>
> 
> -DEFINE_PER_CPU(int, eventfd_wake_count);
> -
>   static DEFINE_IDA(eventfd_ida);
> 
>   struct eventfd_ctx {
> @@ -45,6 +44,20 @@ struct eventfd_ctx {
>   	int id;
>   };
> 
> +struct event_fd_recursion {
> +	local_lock_t lock;
> +	int count;
> +};
> +
> +static DEFINE_PER_CPU(struct event_fd_recursion, event_fd_recursion) = {
> +	.lock = INIT_LOCAL_LOCK(lock),
> +};
> +
> +bool eventfd_signal_count(void)
> +{
> +	return this_cpu_read(event_fd_recursion.count);
> +}
> +
>   /**
>    * eventfd_signal - Adds @n to the eventfd counter.
>    * @ctx: [in] Pointer to the eventfd context.
> @@ -71,18 +84,22 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>   	 * it returns true, the eventfd_signal() call should be deferred to a
>   	 * safe context.
>   	 */
> -	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +	local_lock(&event_fd_recursion.lock);
> +	if (WARN_ON_ONCE(this_cpu_read(event_fd_recursion.count))) {
> +		local_unlock(&event_fd_recursion.lock);
>   		return 0;
> +	}
> 
>   	spin_lock_irqsave(&ctx->wqh.lock, flags);
> -	this_cpu_inc(eventfd_wake_count);
> +	this_cpu_inc(event_fd_recursion.count);
>   	if (ULLONG_MAX - ctx->count < n)
>   		n = ULLONG_MAX - ctx->count;
>   	ctx->count += n;
>   	if (waitqueue_active(&ctx->wqh))
>   		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
> -	this_cpu_dec(eventfd_wake_count);
> +	this_cpu_dec(event_fd_recursion.count);
>   	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
> +	local_unlock(&event_fd_recursion.lock);
> 
>   	return n;
>   }
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index fa0a524baed0..ca89d6c409c1 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -43,12 +43,7 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
> wait_queue_entry_t *w
>   				  __u64 *cnt);
>   void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
> 
> -DECLARE_PER_CPU(int, eventfd_wake_count);
> -
> -static inline bool eventfd_signal_count(void)
> -{
> -	return this_cpu_read(eventfd_wake_count);
> -}
> +bool eventfd_signal_count(void);
> 
>   #else /* CONFIG_EVENTFD */
> 

