Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE903C9705
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 06:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhGOERm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 00:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233862AbhGOERl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626322488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46nqW8DAvxZ4d9NOPpXHF/nyKumPjQmdJUEBZ822R6k=;
        b=hnxTSyrR5EAHagS8WM21NptdGjqt2Slduil6A2D7Qqk+T7txpNcNj6S1HpfHdxxkdIFZSX
        Z2PqWRNmu6pK4VjlSCr0B1OVJf9hD9K7CUPsxEhFaqFTOUFsbvc4ZRCXqWF8FaCDBBIfns
        tgGICR0vRme3jIc3lIxvJ0ne0LYzsT4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-9gIjh7emMqq05rwfSsf5uw-1; Thu, 15 Jul 2021 00:14:46 -0400
X-MC-Unique: 9gIjh7emMqq05rwfSsf5uw-1
Received: by mail-pg1-f200.google.com with SMTP id x9-20020a6541490000b0290222fe6234d6so3373548pgp.14
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 21:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=46nqW8DAvxZ4d9NOPpXHF/nyKumPjQmdJUEBZ822R6k=;
        b=ptOZBZQB6tXGFLDI4CxIFMLTvSXWW6qCCQdJVLizN8SJtNLGBdRPCoSnkC41VxAeo0
         /Q88Y4vZ/qjRgDyljs3uAOoj4g3HSLi3pQjoLdLbSDMcyqh6vYjvjWyZ1IdSuw/dzsIo
         kL2usI0ilfTXhwuraNl2YYMnlucX3gzLIotYcExxDMJ9oStBFyV9HfIa4QFwwHdhUukx
         cYTGVDEzOsU0z8zLR9UAW8Ew4VvWGYl+Jqt5o+uGUO2lIgwbwevGGFLu/FTAh4tkI+2+
         z1roicwFXP4G9f3rC2YO7WJDtVmQ9Tc515hzBLJNPsA6Jm1Ns2VYs3NdEVVxhR2anEOD
         4LIw==
X-Gm-Message-State: AOAM531OqcYQ/e6OWvJaF4Fs7NjHzWG/hOMHR2OgPNq/Xx7v8YpiJNDJ
        HMVnQtUhUH13eIzk27610KpUJ7w9qy41kte4SXL26iAa8nPHHXzURcbdKAV2rUUzPrzNcmRZ1b8
        slfyUdaSYy2CtUeKxJEv9vuE4
X-Received: by 2002:a17:902:d652:b029:12b:45c1:21ba with SMTP id y18-20020a170902d652b029012b45c121bamr1585587plh.9.1626322485781;
        Wed, 14 Jul 2021 21:14:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznF+pXe4rDHrMmM9hW4X2YwNPTYLHbnR9mjaMrfItnzAt+oi7sJGE+qjAS68FBStfC98NNDg==
X-Received: by 2002:a17:902:d652:b029:12b:45c1:21ba with SMTP id y18-20020a170902d652b029012b45c121bamr1585562plh.9.1626322485447;
        Wed, 14 Jul 2021 21:14:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x6sm5177267pgq.67.2021.07.14.21.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 21:14:44 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4b53e2be-c38e-7509-dfcf-94f5bf5dcc10@redhat.com>
Date:   Thu, 15 Jul 2021 12:14:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/14 下午6:35, Paolo Bonzini 写道:
> On 14/07/21 11:23, Jason Wang wrote:
>>> This was added in 2020, so it's unlikely to be the direct cause of the
>>> change.  What is a known-good version for the host?
>>>
>>> Since it is not KVM stuff, I'm CCing Michael and Jason.
>>
>> I think this can be probably fixed here:
>>
>> https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/ 
>>
>
> That seems wrong; in particular it wouldn't protect against AB/BA 
> deadlocks.
> In fact, the bug is with the locking; the code assumes that
> spin_lock_irqsave/spin_unlock_irqrestore is non-preemptable and therefore
> increments and decrements the percpu variable inside the critical 
> section.
>
> This obviously does not fly with PREEMPT_RT; the right fix should be
> using a local_lock.  Something like this (untested!!):
>
> --------------- 8< ---------------
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] eventfd: protect eventfd_wake_count with a local_lock
>
> eventfd_signal assumes that spin_lock_irqsave/spin_unlock_irqrestore is
> non-preemptable and therefore increments and decrements the percpu
> variable inside the critical section.
>
> This obviously does not fly with PREEMPT_RT.  If eventfd_signal is
> preempted and an unrelated thread calls eventfd_signal, the result is
> a spurious WARN.  To avoid this, protect the percpu variable with a
> local_lock.


But local_lock only disable migration not preemption.

Or anything I missed here?

Thanks


>
> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> Cc: stable@vger.kernel.org
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index e265b6dd4f34..7d27b6e080ea 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -12,6 +12,7 @@
>  #include <linux/fs.h>
>  #include <linux/sched/signal.h>
>  #include <linux/kernel.h>
> +#include <linux/local_lock.h>
>  #include <linux/slab.h>
>  #include <linux/list.h>
>  #include <linux/spinlock.h>
> @@ -25,6 +26,7 @@
>  #include <linux/idr.h>
>  #include <linux/uio.h>
>
> +static local_lock_t eventfd_wake_lock = 
> INIT_LOCAL_LOCK(eventfd_wake_lock);
>  DEFINE_PER_CPU(int, eventfd_wake_count);
>
>  static DEFINE_IDA(eventfd_ida);
> @@ -71,8 +73,11 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>       * it returns true, the eventfd_signal() call should be deferred 
> to a
>       * safe context.
>       */
> -    if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +    local_lock(&eventfd_wake_lock);
> +    if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count))) {
> +        local_unlock(&eventfd_wake_lock);
>          return 0;
> +    }
>
>      spin_lock_irqsave(&ctx->wqh.lock, flags);
>      this_cpu_inc(eventfd_wake_count);
> @@ -83,6 +88,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>          wake_up_locked_poll(&ctx->wqh, EPOLLIN);
>      this_cpu_dec(eventfd_wake_count);
>      spin_unlock_irqrestore(&ctx->wqh.lock, flags);
> +    local_unlock(&eventfd_wake_lock);
>
>      return n;
>  }
>

