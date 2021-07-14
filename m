Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D603C8300
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhGNKiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237788AbhGNKiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626258933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3KIYCSf9X+ZJavrWUxtPNDdTZq1RJ8yszuWmcr939Q=;
        b=bslzIiITEjbZiIcNl8esDkG8iZWO1LBqNFncvL8XZX/9dvGKOxfPdVjZ86ymttIFgQpLFo
        lVhGNe43QU3dKTAolZTPg4JdW8IEpJ3a2eAEpMDn/+aXeXror2IgoKYcNI/e2ONf7ALmaK
        n5l2GxLGHFJSt9apaTeHQ7OBMwTKV5o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-fRaOUvxyMqGo2vd5Eu0Pjg-1; Wed, 14 Jul 2021 06:35:32 -0400
X-MC-Unique: fRaOUvxyMqGo2vd5Eu0Pjg-1
Received: by mail-wm1-f70.google.com with SMTP id z127-20020a1c7e850000b02901e46e4d52c0so1165837wmc.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v3KIYCSf9X+ZJavrWUxtPNDdTZq1RJ8yszuWmcr939Q=;
        b=Ms7ijBaG/4Ih41A5iMYI42aBgil8F8GrFIUo8fxLCFRVGVt4GjYjyykWj0Hw0nPrzO
         cvvuQnpXCs3oaPmYUSPsbMpSG3HrRqwT/M0+tguc+ygqZtWA/TzfQ+OTrD7OL7ML40a9
         tS7Ypy3xvHPvoTKcqWoYtSu/Gr0kqhu0thLZgwuEfzdQZUL5UTofgl4Z3aCjg6qyn79N
         uhIN/StCruSFuffGR6qlOifBTaIFr9JOC7GmCgxuemjNYimHuAt0HrHUUCuJ6f2SHWob
         YsnPmPbizqokfA4O0hE2VaO8VzV2IaH/gtURtV4IIuXxsZFgkZAnNKsozanKqsE8ntQX
         dEvA==
X-Gm-Message-State: AOAM5335FAck82d/C8+b6okt9wvNo5+FP7XwwNCcd3HvX684BZ4OOTR4
        WVEQaZWTAoNKle866N61ob7XeL3alvsbMvP6BkfMQpFn4W7CocgmsBWtLsX90jPhsqDJA/mNlVn
        Uxn0x+1pLbFxuwSqaj4i1B/tS
X-Received: by 2002:a1c:f206:: with SMTP id s6mr10072094wmc.102.1626258930942;
        Wed, 14 Jul 2021 03:35:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrtjSTmVv9ipxn4QRDV5B/0O+vTJ5zFO0HvT70/H9NIx2XhOBnFP1cw7S9slrebGy0OpDlZg==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr10072068wmc.102.1626258930618;
        Wed, 14 Jul 2021 03:35:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id w9sm1733597wmc.19.2021.07.14.03.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 03:35:29 -0700 (PDT)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
Message-ID: <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
Date:   Wed, 14 Jul 2021 12:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/21 11:23, Jason Wang wrote:
>> This was added in 2020, so it's unlikely to be the direct cause of the
>> change.  What is a known-good version for the host?
>>
>> Since it is not KVM stuff, I'm CCing Michael and Jason.
> 
> I think this can be probably fixed here:
> 
> https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/

That seems wrong; in particular it wouldn't protect against AB/BA deadlocks.
In fact, the bug is with the locking; the code assumes that
spin_lock_irqsave/spin_unlock_irqrestore is non-preemptable and therefore
increments and decrements the percpu variable inside the critical section.

This obviously does not fly with PREEMPT_RT; the right fix should be
using a local_lock.  Something like this (untested!!):

--------------- 8< ---------------
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] eventfd: protect eventfd_wake_count with a local_lock

eventfd_signal assumes that spin_lock_irqsave/spin_unlock_irqrestore is
non-preemptable and therefore increments and decrements the percpu
variable inside the critical section.

This obviously does not fly with PREEMPT_RT.  If eventfd_signal is
preempted and an unrelated thread calls eventfd_signal, the result is
a spurious WARN.  To avoid this, protect the percpu variable with a
local_lock.

Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
Cc: stable@vger.kernel.org
Cc: He Zhe <zhe.he@windriver.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..7d27b6e080ea 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -12,6 +12,7 @@
  #include <linux/fs.h>
  #include <linux/sched/signal.h>
  #include <linux/kernel.h>
+#include <linux/local_lock.h>
  #include <linux/slab.h>
  #include <linux/list.h>
  #include <linux/spinlock.h>
@@ -25,6 +26,7 @@
  #include <linux/idr.h>
  #include <linux/uio.h>
  
+static local_lock_t eventfd_wake_lock = INIT_LOCAL_LOCK(eventfd_wake_lock);
  DEFINE_PER_CPU(int, eventfd_wake_count);
  
  static DEFINE_IDA(eventfd_ida);
@@ -71,8 +73,11 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
  	 * it returns true, the eventfd_signal() call should be deferred to a
  	 * safe context.
  	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	local_lock(&eventfd_wake_lock);
+	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count))) {
+		local_unlock(&eventfd_wake_lock);
  		return 0;
+	}
  
  	spin_lock_irqsave(&ctx->wqh.lock, flags);
  	this_cpu_inc(eventfd_wake_count);
@@ -83,6 +88,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
  		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
  	this_cpu_dec(eventfd_wake_count);
  	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
+	local_unlock(&eventfd_wake_lock);
  
  	return n;
  }

