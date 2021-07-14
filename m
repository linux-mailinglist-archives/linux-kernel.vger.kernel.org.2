Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9D3C8467
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbhGNMX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231336AbhGNMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626265233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Zq+6d7ua37wwgdP0ISyZcAl5/OfM+5HqwiKKHrjYd4=;
        b=P0RhrmDx7Z0x7+JQlOMMvO5F2tMDnSmhcUdjQl+IYlDYEkvedHZy2B9fBzii/wwRT3pccE
        O8rpVAZCIwYcD00i2mMo1REcpQVG6NFZm05uidT99rYVGsO4Rd8UI9NtAazM7wfSpJNm0/
        AjEZ8koAotsnfU7ctGMMh68u8sBgwlE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-LlSROqsvMDKB5798OPMyxQ-1; Wed, 14 Jul 2021 08:20:32 -0400
X-MC-Unique: LlSROqsvMDKB5798OPMyxQ-1
Received: by mail-ed1-f72.google.com with SMTP id p13-20020a05640210cdb029039560ff6f46so1129062edu.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 05:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Zq+6d7ua37wwgdP0ISyZcAl5/OfM+5HqwiKKHrjYd4=;
        b=nAm9A/qYutWMsdjQQ4M5tZzbmNAl3yq4zkDCd1jrAyRAjXMkEMkxAjkihrx4sZQcWB
         F+2DyA03lCKDVwWHLQ+GZW/5W0trvZnjqKuT/EfhHw8T9G9EpRLFPV80APWGYN6foWJ3
         eGpLYD6E98lRJVKZOKyJCbHpi5pZMeg/5gWfuSyBrmU4UjAdRgk3NCWDxlSA4N8gfmwI
         xqh1FFru9DyG0cZXXV010tLMyqKZF6w2e8o+lE+ds2BhQVKuZcD85eL0JqTG6+gJU2Tm
         itiTVIhUbUdn8FP5qUNCJ5hbwQzyyr/3Rzj1xNZ/o+jdq7Fs5IPqH4BxUtPyjB1hiZ3p
         Acww==
X-Gm-Message-State: AOAM530cxaVA45wpR+SSpfzeMItSTd3FbPJmkp/+TURqD5B2q7CdPhR/
        OQWM02Ws8KWEIOdTeMm7tZZagPsZx/zNNSdrWIuTFerLroZs2kdE1fxMN0jRMISw1hA22liuFEs
        VYg2fCNF0cyyvpFXUJOSPmtpR
X-Received: by 2002:aa7:c14e:: with SMTP id r14mr13086973edp.251.1626265231258;
        Wed, 14 Jul 2021 05:20:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4QFRle0fn6/KmhiAIAsNAhfzH2hcyPZ67u2kEKgeRynrjZ26LIUe8MQULfYUqjLIUUXOlAw==
X-Received: by 2002:aa7:c14e:: with SMTP id r14mr13086948edp.251.1626265231055;
        Wed, 14 Jul 2021 05:20:31 -0700 (PDT)
Received: from x1.bristot.me (host-79-37-206-118.retail.telecomitalia.it. [79.37.206.118])
        by smtp.gmail.com with ESMTPSA id dd24sm944567edb.45.2021.07.14.05.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 05:20:30 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Paolo Bonzini <pbonzini@redhat.com>,
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
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <b8a50f4c-0b14-3f13-923d-3bad190eac2a@redhat.com>
Date:   Wed, 14 Jul 2021 14:20:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/21 12:35 PM, Paolo Bonzini wrote:
> On 14/07/21 11:23, Jason Wang wrote:
>>> This was added in 2020, so it's unlikely to be the direct cause of the
>>> change.  What is a known-good version for the host?
>>>
>>> Since it is not KVM stuff, I'm CCing Michael and Jason.
>>
>> I think this can be probably fixed here:
>>
>> https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/
> 
> That seems wrong; in particular it wouldn't protect against AB/BA deadlocks.
> In fact, the bug is with the locking; the code assumes that
> spin_lock_irqsave/spin_unlock_irqrestore is non-preemptable and therefore
> increments and decrements the percpu variable inside the critical section.
> 
> This obviously does not fly with PREEMPT_RT; the right fix should be
> using a local_lock.  Something like this (untested!!):

Makes sense, testing the patch.

-- Daniel

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
> +static local_lock_t eventfd_wake_lock = INIT_LOCAL_LOCK(eventfd_wake_lock);
>  DEFINE_PER_CPU(int, eventfd_wake_count);
>  
>  static DEFINE_IDA(eventfd_ida);
> @@ -71,8 +73,11 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>       * it returns true, the eventfd_signal() call should be deferred to a
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

