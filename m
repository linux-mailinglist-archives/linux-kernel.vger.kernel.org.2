Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625D53D35F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 10:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhGWHT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 03:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234394AbhGWHT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627027200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6uvraZMVqX8aF1W4N70FaqsuTWyA0iUE4yIvTyzmQmo=;
        b=OfkaW1vEEKJpnVP5Z2xKt06/K4fLlW/dbH8zVvO/CpEhngMltp0GoTpg3Cb6mqPGcTQ34U
        ySoMBEjclGul7QADXiDNIG/WPxXSUpvUkW9o5zG42/fvubTw5sSgjaG3AQSJPwR/7cDyzl
        Ydl2hccwRb9LTM9rg7ZcxJdBuoXDg7o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-0Y1CqN5sPzS9TPkCS8dveg-1; Fri, 23 Jul 2021 03:59:58 -0400
X-MC-Unique: 0Y1CqN5sPzS9TPkCS8dveg-1
Received: by mail-ej1-f69.google.com with SMTP id a19-20020a1709063e93b0290551ea218ea2so379217ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6uvraZMVqX8aF1W4N70FaqsuTWyA0iUE4yIvTyzmQmo=;
        b=aAeXvyFTTPsbunw5G0xIubmmMNqH47mRtrsN5rgLiLBzHdiFKFKM+FOu1Xk/HnpRTT
         9zqJ7pI5bTLpHTHnwVY6zp9y0ldZHX33+z+U3+NiD6A6KKB5oIChnat7dcUAZcQ3pWFn
         VtubSbcTrSfGRg0L9gZ9wiwelT6A2S1xCxqh8+Fcn6v4BmNQ+nELFGixL18cF593N6FB
         24U9giKKPywdj0m/Hf3rmHzX4gjxF70Q23cVQdFQWxsPT8t0y2dyeBFdyZzgfswKW2rM
         wcyh2nkX/1z38WtKYeVCwM/Ya92YlKDZonNuQk2x8+mcCu6zfsDtrEa3ZrCw+/XX81aa
         1R6A==
X-Gm-Message-State: AOAM532JAPFnfsbfKnjc/5KJXztGqQItytEmthQR3pnJbMw/1dbDy8U7
        zrR3Pk1BebwR3GYrxzMTqDp0UX9waNPndZhHa0+UZ/2nynPB7KCH2NxODMiM0HqV6irj8ETsbYk
        JIdKSyifZMpSfhcgwflSpejGM
X-Received: by 2002:aa7:db93:: with SMTP id u19mr4072434edt.227.1627027197270;
        Fri, 23 Jul 2021 00:59:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1IuqfFkKXnxgQVCoSZjXToQiISMmjADv23qluIObHgUSZYrjAIJuL+QNjsAMkwyHtXPu3Kw==
X-Received: by 2002:aa7:db93:: with SMTP id u19mr4072421edt.227.1627027197069;
        Fri, 23 Jul 2021 00:59:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id u26sm10252677ejj.4.2021.07.23.00.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 00:59:56 -0700 (PDT)
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <20210715102249.2205-1-hdanton@sina.com>
 <20210716020611.2288-1-hdanton@sina.com>
 <20210716075539.2376-1-hdanton@sina.com>
 <20210716093725.2438-1-hdanton@sina.com>
 <20210718124219.1521-1-hdanton@sina.com>
 <20210721070452.1008-1-hdanton@sina.com>
 <20210721101119.1103-1-hdanton@sina.com>
 <20210723022356.1301-1-hdanton@sina.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
Message-ID: <f4ee6cdd-85a0-5f24-b028-0e3736027e7a@redhat.com>
Date:   Fri, 23 Jul 2021 09:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723022356.1301-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/21 04:23, Hillf Danton wrote:
> Detect concurrent reader and writer by reading event counter before and
> after poll_wait(), and determine feedback with the case of unstable
> counter taken into account.
> 
> Cut the big comment as the added barriers speak for themselves.

First and foremost, I'm not sure what you are trying to fix.

Second, the patch is wrong even without taking into account the lockless
accesses, because the condition for returning EPOLLOUT is certainly wrong.

Third, barriers very rarely speak for themselves.  In particular what
do they pair with?  It seems to me that you are basically reintroducing
the same mistake that commit a484c3dd9426 ("eventfd: document lockless
access in eventfd_poll", 2016-03-22) fixed, at the time where the big
comment was introduced:

     Things aren't as simple as the read barrier in eventfd_poll
     would suggest.  In fact, the read barrier, besides lacking a
     comment, is not paired in any obvious manner with another read
     barrier, and it is pointless because it is sitting between a write
     (deep in poll_wait) and the read of ctx->count.

Paolo


> +++ x/fs/eventfd.c
> @@ -131,49 +131,20 @@ static __poll_t eventfd_poll(struct file
>   {
>   	struct eventfd_ctx *ctx = file->private_data;
>   	__poll_t events = 0;
> -	u64 count;
> +	u64 c0, count;
> +
> +	c0 = ctx->count;
> +	smp_rmb();
>   
>   	poll_wait(file, &ctx->wqh, wait);
>   
> -	/*
> -	 * All writes to ctx->count occur within ctx->wqh.lock.  This read
> -	 * can be done outside ctx->wqh.lock because we know that poll_wait
> -	 * takes that lock (through add_wait_queue) if our caller will sleep.
> -	 *
> -	 * The read _can_ therefore seep into add_wait_queue's critical
> -	 * section, but cannot move above it!  add_wait_queue's spin_lock acts
> -	 * as an acquire barrier and ensures that the read be ordered properly
> -	 * against the writes.  The following CAN happen and is safe:
> -	 *
> -	 *     poll                               write
> -	 *     -----------------                  ------------
> -	 *     lock ctx->wqh.lock (in poll_wait)
> -	 *     count = ctx->count
> -	 *     __add_wait_queue
> -	 *     unlock ctx->wqh.lock
> -	 *                                        lock ctx->qwh.lock
> -	 *                                        ctx->count += n
> -	 *                                        if (waitqueue_active)
> -	 *                                          wake_up_locked_poll
> -	 *                                        unlock ctx->qwh.lock
> -	 *     eventfd_poll returns 0
> -	 *
> -	 * but the following, which would miss a wakeup, cannot happen:
> -	 *
> -	 *     poll                               write
> -	 *     -----------------                  ------------
> -	 *     count = ctx->count (INVALID!)
> -	 *                                        lock ctx->qwh.lock
> -	 *                                        ctx->count += n
> -	 *                                        **waitqueue_active is false**
> -	 *                                        **no wake_up_locked_poll!**
> -	 *                                        unlock ctx->qwh.lock
> -	 *     lock ctx->wqh.lock (in poll_wait)
> -	 *     __add_wait_queue
> -	 *     unlock ctx->wqh.lock
> -	 *     eventfd_poll returns 0
> -	 */
> -	count = READ_ONCE(ctx->count);
> +	smp_rmb();
> +	count = ctx->count;
> +
> +	if (c0 < count)
> +		return EPOLLIN;
> +	if (c0 > count)
> +		return EPOLLOUT;
>   
>   	if (count > 0)
>   		events |= EPOLLIN;
> 

