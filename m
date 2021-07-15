Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A153C989B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 07:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhGOGB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231910AbhGOGB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626328714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bys4CYtSgkKoR1XSPOkurwc5Ir5mdkIuDGtdtvpCIGU=;
        b=iYA+/jqIPyCIYHk0576Wu64Sf0AoS+p12cY4zTg7OgOMa5sd/VNG84FA1+uiUT1T/FwppX
        xRPYY8vSgYzRWSo0qIkWvX+UjoThKNhceK1Y1R1vP1WvFz7zB5WWetDzDDAlKl8wCg+uB3
        AqcMf8zCjmL+Pd2YczFQve9WBqj3Zj0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-QdwvScezMzONdUh5l_Wyqg-1; Thu, 15 Jul 2021 01:58:32 -0400
X-MC-Unique: QdwvScezMzONdUh5l_Wyqg-1
Received: by mail-wr1-f70.google.com with SMTP id o10-20020a05600002cab02901426384855aso297768wry.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 22:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bys4CYtSgkKoR1XSPOkurwc5Ir5mdkIuDGtdtvpCIGU=;
        b=ENFpNtKWOT9Qp5WN+oflUUcshzduvjOM17/V/PJJW+UFXpYHLDhGmT9FtPn0NG4QQG
         TowgTkNDbojUOqmjqo0t14gG0iSgBUdef39+eoIPSYauNpZsDm1FhVOzituLdhlfR0Ag
         Gi84s7AJGHANxkw1IBaL+plZYseHRtgD1dJx4YfQvY7+PmmQogmqHRYd1NRT1mmYPb6c
         J5QcSh2PCfR4KAeVxNwHTxXsICsYWCjX4MiggiwOvZ0SEM9+rUdf8vSzDAA3wsLIEryb
         2YS9kbkSxH5i9b0szOBbIHvkSsg6cL2Wiwx6H7/Ja6ZcGnfCpRfqpT4KTZBgzingZjIc
         ekxw==
X-Gm-Message-State: AOAM5315/uU5wPWE3ztQOT6A5lGFhQdv+qgrEZU1XeLAtUKhjFOi/c3R
        CYtt4DQffAeVH4vB9uDHrAiJevfrtiSR4g8u5pJa0C7muN2ugMTrVnIPFsFa8BZbquQ5G7VKmhD
        C54i9qiRlGythCo4/AhwYe7Ru
X-Received: by 2002:a5d:5103:: with SMTP id s3mr3015106wrt.180.1626328711396;
        Wed, 14 Jul 2021 22:58:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3E4SoWUJj2CjUpFkZsDNJKZV50Hbs/CmiuA1iv5C47c1yMiWjEexrW/LoT8GoK2myy1FN6g==
X-Received: by 2002:a5d:5103:: with SMTP id s3mr3015072wrt.180.1626328711040;
        Wed, 14 Jul 2021 22:58:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id y16sm5188687wrw.42.2021.07.14.22.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 22:58:30 -0700 (PDT)
To:     Jason Wang <jasowang@redhat.com>,
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
Message-ID: <52348289-5d4d-f4a4-6fe3-f0c24cc6d9f9@redhat.com>
Date:   Thu, 15 Jul 2021 07:58:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4b53e2be-c38e-7509-dfcf-94f5bf5dcc10@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/21 06:14, Jason Wang wrote:
>> This obviously does not fly with PREEMPT_RT.  If eventfd_signal is
>> preempted and an unrelated thread calls eventfd_signal, the result is
>> a spurious WARN.  To avoid this, protect the percpu variable with a
>> local_lock.
> 
> But local_lock only disable migration not preemption.

On mainline PREEMPT_RT, local_lock is an array of per-CPU spinlocks. 
When two eventfd_signals run on the same CPU and one is preempted, the 
spinlocks avoid that the second sees eventfd_wake_count > 0.

Thanks,

Paolo

> Or anything I missed here?
> 
> Thanks
> 
> 
>>
>> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
>> Cc: stable@vger.kernel.org
>> Cc: He Zhe <zhe.he@windriver.com>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> diff --git a/fs/eventfd.c b/fs/eventfd.c
>> index e265b6dd4f34..7d27b6e080ea 100644
>> --- a/fs/eventfd.c
>> +++ b/fs/eventfd.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/fs.h>
>>  #include <linux/sched/signal.h>
>>  #include <linux/kernel.h>
>> +#include <linux/local_lock.h>
>>  #include <linux/slab.h>
>>  #include <linux/list.h>
>>  #include <linux/spinlock.h>
>> @@ -25,6 +26,7 @@
>>  #include <linux/idr.h>
>>  #include <linux/uio.h>
>>
>> +static local_lock_t eventfd_wake_lock = 
>> INIT_LOCAL_LOCK(eventfd_wake_lock);
>>  DEFINE_PER_CPU(int, eventfd_wake_count);
>>
>>  static DEFINE_IDA(eventfd_ida);
>> @@ -71,8 +73,11 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>>       * it returns true, the eventfd_signal() call should be deferred 
>> to a
>>       * safe context.
>>       */
>> -    if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
>> +    local_lock(&eventfd_wake_lock);
>> +    if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count))) {
>> +        local_unlock(&eventfd_wake_lock);
>>          return 0;
>> +    }
>>
>>      spin_lock_irqsave(&ctx->wqh.lock, flags);
>>      this_cpu_inc(eventfd_wake_count);
>> @@ -83,6 +88,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>>          wake_up_locked_poll(&ctx->wqh, EPOLLIN);
>>      this_cpu_dec(eventfd_wake_count);
>>      spin_unlock_irqrestore(&ctx->wqh.lock, flags);
>> +    local_unlock(&eventfd_wake_lock);
>>
>>      return n;
>>  }
>>
> 

