Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35C63D8BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhG1KV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhG1KV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627467685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDn5Y72Rr4su7CoBBY1GqrLb3wpYh0EzCagsvI1kaUg=;
        b=YtYqD0RcgI4sG+5FC9da2nQGY87mHpIEN5SdM65cl7OXXP+yWegbnfGUYmhRdmaopKZeX/
        CHABrJ0Nm2EnqSdr6ovHQ3CFNz8FBSyGcha90jGFJf9yHPDSvHACEyK5f3Y8MwK8RcSxYn
        oiVGCgkc67911L3rOnrr9Aj5FcpOb6c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-yCgUX-LFOPiN-1je_R50NQ-1; Wed, 28 Jul 2021 06:21:24 -0400
X-MC-Unique: yCgUX-LFOPiN-1je_R50NQ-1
Received: by mail-wm1-f70.google.com with SMTP id w25-20020a1cf6190000b0290252505ddd56so168908wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 03:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RDn5Y72Rr4su7CoBBY1GqrLb3wpYh0EzCagsvI1kaUg=;
        b=IFE0JqX43Vi9TL8IqJW1EC83Jv/DFPnVMu7+KXqiW2MIiw3ZVdW8JhF5qUEcOuyl/h
         N5uFqyk1xWzZ4tNGBUnBfFqEmhdK1tIE/kREhbqIEgG9do8l5q3nFI1PgtQtcIiDmBVE
         Mc5NdK8H2LASEka5XkEJSMSmnF3g463I/i9rXOHNAEhlBNEK6XE1qe7j11V8ftYR8ycj
         HCdxxLbrNqHcO3E1SzSa2wFhXYKilLNpkifCQ2VQPh0rFfEgOhJQ88WJckBDubu1C7qr
         WLe5pGYFiiorYhuIUOFYZ/ImY+slR0vzlUWvtJfC3F8RKv01FWEv7j85qD/f7x01juDu
         3orA==
X-Gm-Message-State: AOAM531Il8c5+uH/l0kSMYrcdrekgmuYSezgiz2tfy6y2JID0dIZeNjY
        hyB4tnLelB7ruThjPSBBXFbygsgsXuBxEfzs1D6c4aVByUROO3EEWvh3kinMkYrwU+dQRUzAfZW
        KSvAr0rLtc5ZBnIYcg8cbHOrZ
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr8718837wmj.68.1627467682794;
        Wed, 28 Jul 2021 03:21:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi8FFdFFYgAvtC9VyN0O2sw0qA1gsTDA8nU5DyPdrTZJoQLE0twsQY+NDrmHY72XUB2DiSyg==
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr8718819wmj.68.1627467682582;
        Wed, 28 Jul 2021 03:21:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d24sm5338315wmb.42.2021.07.28.03.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:21:22 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Wang <jasowang@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>, Jens Axboe <axboe@fb.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <87pmv23lru.ffs@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
Message-ID: <810e01ef-9b71-5b44-8498-b8a377d4e51b@redhat.com>
Date:   Wed, 28 Jul 2021 12:21:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87pmv23lru.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/21 10:06, Thomas Gleixner wrote:
> On Wed, Jul 14 2021 at 12:35, Paolo Bonzini wrote:
>> On 14/07/21 11:23, Jason Wang wrote:
>>    
>> +static local_lock_t eventfd_wake_lock = INIT_LOCAL_LOCK(eventfd_wake_lock);
>>    DEFINE_PER_CPU(int, eventfd_wake_count);
>>    
>>    static DEFINE_IDA(eventfd_ida);
>> @@ -71,8 +73,11 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>>    	 * it returns true, the eventfd_signal() call should be deferred to a
>>    	 * safe context.
>>    	 */
>> -	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
>> +	local_lock(&eventfd_wake_lock);
>> +	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count))) {
>> +		local_unlock(&eventfd_wake_lock);
>>    		return 0;
>> +	}
>>    
>>    	spin_lock_irqsave(&ctx->wqh.lock, flags);
>>    	this_cpu_inc(eventfd_wake_count);
>> @@ -83,6 +88,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>>    		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
>>    	this_cpu_dec(eventfd_wake_count);
>>    	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
>> +	local_unlock(&eventfd_wake_lock);
> 
> Yes, that cures it, but if you think about what this wants to prevent,
> then having the recursion counter per CPU is at least suboptimal.
> 
> Something like the untested below perhaps?

Yes, that works (it should just be #ifdef CONFIG_EVENTFD).

On !PREEMPT_RT the percpu variable consumes memory while your patch uses 
none (there are plenty of spare bits in current), but it is otherwise 
basically the same.  On PREEMPT_RT the local_lock is certainly more 
expensive.

Thanks,

Paolo

> Thanks,
> 
>          tglx
> ---
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_que
>   		list_del(&iocb->ki_list);
>   		iocb->ki_res.res = mangle_poll(mask);
>   		req->done = true;
> -		if (iocb->ki_eventfd && eventfd_signal_count()) {
> +		if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
>   			iocb = NULL;
>   			INIT_WORK(&req->work, aio_poll_put_work);
>   			schedule_work(&req->work);
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -25,8 +25,6 @@
>   #include <linux/idr.h>
>   #include <linux/uio.h>
>   
> -DEFINE_PER_CPU(int, eventfd_wake_count);
> -
>   static DEFINE_IDA(eventfd_ida);
>   
>   struct eventfd_ctx {
> @@ -67,21 +65,21 @@ struct eventfd_ctx {
>   	 * Deadlock or stack overflow issues can happen if we recurse here
>   	 * through waitqueue wakeup handlers. If the caller users potentially
>   	 * nested waitqueues with custom wakeup handlers, then it should
> -	 * check eventfd_signal_count() before calling this function. If
> -	 * it returns true, the eventfd_signal() call should be deferred to a
> +	 * check eventfd_signal_allowed() before calling this function. If
> +	 * it returns false, the eventfd_signal() call should be deferred to a
>   	 * safe context.
>   	 */
> -	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +	if (WARN_ON_ONCE(current->in_eventfd_signal))
>   		return 0;
>   
>   	spin_lock_irqsave(&ctx->wqh.lock, flags);
> -	this_cpu_inc(eventfd_wake_count);
> +	current->in_eventfd_signal = 1;
>   	if (ULLONG_MAX - ctx->count < n)
>   		n = ULLONG_MAX - ctx->count;
>   	ctx->count += n;
>   	if (waitqueue_active(&ctx->wqh))
>   		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
> -	this_cpu_dec(eventfd_wake_count);
> +	current->in_eventfd_signal = 0;
>   	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
>   
>   	return n;
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -43,11 +43,9 @@ int eventfd_ctx_remove_wait_queue(struct
>   				  __u64 *cnt);
>   void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
>   
> -DECLARE_PER_CPU(int, eventfd_wake_count);
> -
> -static inline bool eventfd_signal_count(void)
> +static inline bool eventfd_signal_allowed(void)
>   {
> -	return this_cpu_read(eventfd_wake_count);
> +	return !current->in_eventfd_signal;
>   }
>   
>   #else /* CONFIG_EVENTFD */
> @@ -78,9 +76,9 @@ static inline int eventfd_ctx_remove_wai
>   	return -ENOSYS;
>   }
>   
> -static inline bool eventfd_signal_count(void)
> +static inline bool eventfd_signal_allowed(void)
>   {
> -	return false;
> +	return true;
>   }
>   
>   static inline void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -863,6 +863,8 @@ struct task_struct {
>   	/* Used by page_owner=on to detect recursion in page tracking. */
>   	unsigned			in_page_owner:1;
>   #endif
> +	/* Recursion prevention for eventfd_signal() */
> +	unsigned			in_eventfd_signal:1;
>   
>   	unsigned long			atomic_flags; /* Flags requiring atomic access. */
>   
> 

