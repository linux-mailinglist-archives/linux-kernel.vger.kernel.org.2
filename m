Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B503C98E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhGOGsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231352AbhGOGsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626331537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mwi10TZc1sOVU5XYi2wL7hupe8YHyAn6IrGpWJ2vsRw=;
        b=ZooD0VdhX+sKkrYdtuDT0cZXtzGO4Wq7mu8FkILqaeRpVthkBk5Q2YBVw5PD65axfcDDbk
        wY6TApcC2n+YoO6it+KO+HtRsvYwBTbwK5c/vYefe0rtEzIosGRRnobrbg2dp3ZpZwzr9o
        iIvGPjQPAZff4eYe6N+Am9YJSUip78Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-zSaansEWO4mrXfN2xw_SNg-1; Thu, 15 Jul 2021 02:45:36 -0400
X-MC-Unique: zSaansEWO4mrXfN2xw_SNg-1
Received: by mail-pg1-f200.google.com with SMTP id 29-20020a63105d0000b029022c245c3492so3630542pgq.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Mwi10TZc1sOVU5XYi2wL7hupe8YHyAn6IrGpWJ2vsRw=;
        b=DFSKlZezkHzSENvxY4vVP/nX93XGX6ZKJbRlF/2E6UdWkV+gHqm5iC3dl4UHtbkkd7
         8Qgm7cAFsHfY2loyZL5NR/cPsj1mrUYNdZNmTSdnS9REwZxlhJiHmn1131UcUw215Xk+
         r8KGzN+Ues1bcuRsA2uQElBjRc7mZnpLQ3FMk7KghqvDvsxChSf13QCiZ6Mm4oPl7a8+
         N+2L+W0Lw+zhqanDyk4KDx2rPdaWDq0rezBicXRTYJ5oWHxJ8Ph36Kv19qRGh/jySPIA
         L8SgJeUEtClpfb8Jbo2EqyY4KRbOr0j8ijSiqFUzyI11KQDeGJ/7Yh3O7iNtFI/vk0/+
         n3QA==
X-Gm-Message-State: AOAM530LVaBLNjbhmnfwBfsUiwyg4UQuoCP1cKLp7wa/yxw1qGvo858i
        ynUxDkEGM7SpnLHxVaaxwgwso/uhJO4a9HQAAsoKupsPZbGTiF5F7eZTFKbe7pfE9/udjrJ09ci
        YRurQx7VJ7agBJdlBmpr2wnsY
X-Received: by 2002:a17:90a:a798:: with SMTP id f24mr2785300pjq.8.1626331535202;
        Wed, 14 Jul 2021 23:45:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfqyK19LEtsygJL/KLKR1mr/sWPJaJdZwDH6P4bSe1nJu+W1HJ8zXJWxL5yx1E1hZaadCZbg==
X-Received: by 2002:a17:90a:a798:: with SMTP id f24mr2785283pjq.8.1626331534920;
        Wed, 14 Jul 2021 23:45:34 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i12sm4144911pjj.9.2021.07.14.23.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 23:45:34 -0700 (PDT)
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
 <4b53e2be-c38e-7509-dfcf-94f5bf5dcc10@redhat.com>
 <52348289-5d4d-f4a4-6fe3-f0c24cc6d9f9@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <987e69e1-21d7-625d-4e45-bc40857a526c@redhat.com>
Date:   Thu, 15 Jul 2021 14:45:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <52348289-5d4d-f4a4-6fe3-f0c24cc6d9f9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/15 下午1:58, Paolo Bonzini 写道:
> On 15/07/21 06:14, Jason Wang wrote:
>>> This obviously does not fly with PREEMPT_RT.  If eventfd_signal is
>>> preempted and an unrelated thread calls eventfd_signal, the result is
>>> a spurious WARN.  To avoid this, protect the percpu variable with a
>>> local_lock.
>>
>> But local_lock only disable migration not preemption.
>
> On mainline PREEMPT_RT, local_lock is an array of per-CPU spinlocks. 
> When two eventfd_signals run on the same CPU and one is preempted, the 
> spinlocks avoid that the second sees eventfd_wake_count > 0.
>
> Thanks,
>
> Paolo


Right, I see.

Thanks


>
>> Or anything I missed here?
>>
>> Thanks
>>
>>
>>>
>>> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>>> Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
>>> Cc: stable@vger.kernel.org
>>> Cc: He Zhe <zhe.he@windriver.com>
>>> Cc: Jens Axboe <axboe@kernel.dk>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> diff --git a/fs/eventfd.c b/fs/eventfd.c
>>> index e265b6dd4f34..7d27b6e080ea 100644
>>> --- a/fs/eventfd.c
>>> +++ b/fs/eventfd.c
>>> @@ -12,6 +12,7 @@
>>>  #include <linux/fs.h>
>>>  #include <linux/sched/signal.h>
>>>  #include <linux/kernel.h>
>>> +#include <linux/local_lock.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/list.h>
>>>  #include <linux/spinlock.h>
>>> @@ -25,6 +26,7 @@
>>>  #include <linux/idr.h>
>>>  #include <linux/uio.h>
>>>
>>> +static local_lock_t eventfd_wake_lock = 
>>> INIT_LOCAL_LOCK(eventfd_wake_lock);
>>>  DEFINE_PER_CPU(int, eventfd_wake_count);
>>>
>>>  static DEFINE_IDA(eventfd_ida);
>>> @@ -71,8 +73,11 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, 
>>> __u64 n)
>>>       * it returns true, the eventfd_signal() call should be 
>>> deferred to a
>>>       * safe context.
>>>       */
>>> -    if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
>>> +    local_lock(&eventfd_wake_lock);
>>> +    if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count))) {
>>> +        local_unlock(&eventfd_wake_lock);
>>>          return 0;
>>> +    }
>>>
>>>      spin_lock_irqsave(&ctx->wqh.lock, flags);
>>>      this_cpu_inc(eventfd_wake_count);
>>> @@ -83,6 +88,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, 
>>> __u64 n)
>>>          wake_up_locked_poll(&ctx->wqh, EPOLLIN);
>>>      this_cpu_dec(eventfd_wake_count);
>>>      spin_unlock_irqrestore(&ctx->wqh.lock, flags);
>>> +    local_unlock(&eventfd_wake_lock);
>>>
>>>      return n;
>>>  }
>>>
>>
>

