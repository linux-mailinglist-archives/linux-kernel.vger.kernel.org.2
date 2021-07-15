Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8603C9A75
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbhGOIZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231991AbhGOIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626337372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7yqdl1PqMyvlian8B8rxjKb0iqUjKQ4YNnWrYVQzMaI=;
        b=g2qkIimWa8YdqOzsaiPPE3RuriI6t2DX2tRHegwDQfHE5nuZB8h4xjMLd3f2gyU05XdVkb
        k2GdIQqzWgldoaClXP+BQ7dEOsucWvQS3C1bKBI2aVn+rHSjSA+gW+CantcUMOJg8eny2P
        H9W9ygX85Gp58Z+BoVbswDz3kk+8WHk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-L7DCvWstP4maeUVtEIml7Q-1; Thu, 15 Jul 2021 04:22:49 -0400
X-MC-Unique: L7DCvWstP4maeUVtEIml7Q-1
Received: by mail-ej1-f70.google.com with SMTP id k1-20020a17090666c1b029041c273a883dso1885096ejp.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7yqdl1PqMyvlian8B8rxjKb0iqUjKQ4YNnWrYVQzMaI=;
        b=DlmeP3iELBm0sZzDKPS3f0L3UbGqA/Ze8oRDZbg+tqKvulxRKH8BSwPE3UXWGj3vtt
         rj+QakzILPbqxNbprIt27zRyMK1YvgGLMBG5eP/jNUIL1D5nH6saZJDJg9CSDUQXCDcB
         3aUWDt9zMS+6EXtpz/j2UZECn+Bts3WcGkXQTbFG+MTyeOBX+MSUwI7WyxRjQxSaeL+8
         RKe+PD6h0a235iMMGHP2xaizHlp+oSZ/ZdzJWBAIryPM9PNBA7F6sgV8La7xoZodOT3Q
         cOL5/c1TSbc/3ovGHjsaHhGQE1A5O7MO0H9z0CVcZUuyab5rr0HX4MfGQnFnaJIpGH7/
         QYMQ==
X-Gm-Message-State: AOAM532rHdy6M3aew9PMuucLwSbb0lNpWwKtqNaVtDCwXnSv0wppkUga
        jJwH/KTF23QYJri7mKhNmsfmOqzNqiCUdA+CQ7FEbp01oQqIKSeOjHvCAKjVzfmVyFFHicF+hnK
        +rXrIkB82MfrugQGA+eycI9vJ
X-Received: by 2002:a17:906:b18d:: with SMTP id w13mr4190277ejy.341.1626337367926;
        Thu, 15 Jul 2021 01:22:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyirkMw8u5BJ8adDJAcsbY32jNN4zyG3uBVO06JiIXmWmTcoCWqWVo6xp9vUFG9E/zOX9GzDw==
X-Received: by 2002:a17:906:b18d:: with SMTP id w13mr4190245ejy.341.1626337367643;
        Thu, 15 Jul 2021 01:22:47 -0700 (PDT)
Received: from x1.bristot.me (host-79-37-206-118.retail.telecomitalia.it. [79.37.206.118])
        by smtp.gmail.com with ESMTPSA id q24sm2035993edc.82.2021.07.15.01.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 01:22:47 -0700 (PDT)
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
Message-ID: <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
Date:   Thu, 15 Jul 2021 10:22:46 +0200
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

the lock needs to be per-pcu... but so far, so good. I will continue using the
system in the next days to see if it blows on another way.

The patch looks like this now:

------------------------- 8< ---------------------
Subject: [PATCH] eventfd: protect eventfd_wake_count with a local_lock

eventfd_signal assumes that spin_lock_irqsave/spin_unlock_irqrestore is
non-preemptable and therefore increments and decrements the percpu
variable inside the critical section.

This obviously does not fly with PREEMPT_RT. If eventfd_signal is
preempted and an unrelated thread calls eventfd_signal, the result is
a spurious WARN. To avoid this, protect the percpu variable with a
local_lock.

Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
Cc: stable@vger.kernel.org
Cc: He Zhe <zhe.he@windriver.com>
Cc: Jens Axboe <axboe@kernel.dk>
Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 fs/eventfd.c            | 27 ++++++++++++++++++++++-----
 include/linux/eventfd.h |  7 +------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..9754fcd38690 100644
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
@@ -25,8 +26,6 @@
 #include <linux/idr.h>
 #include <linux/uio.h>

-DEFINE_PER_CPU(int, eventfd_wake_count);
-
 static DEFINE_IDA(eventfd_ida);

 struct eventfd_ctx {
@@ -45,6 +44,20 @@ struct eventfd_ctx {
 	int id;
 };

+struct event_fd_recursion {
+	local_lock_t lock;
+	int count;
+};
+
+static DEFINE_PER_CPU(struct event_fd_recursion, event_fd_recursion) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+};
+
+bool eventfd_signal_count(void)
+{
+	return this_cpu_read(event_fd_recursion.count);
+}
+
 /**
  * eventfd_signal - Adds @n to the eventfd counter.
  * @ctx: [in] Pointer to the eventfd context.
@@ -71,18 +84,22 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * it returns true, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	local_lock(&event_fd_recursion.lock);
+	if (WARN_ON_ONCE(this_cpu_read(event_fd_recursion.count))) {
+		local_unlock(&event_fd_recursion.lock);
 		return 0;
+	}

 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	this_cpu_inc(eventfd_wake_count);
+	this_cpu_inc(event_fd_recursion.count);
 	if (ULLONG_MAX - ctx->count < n)
 		n = ULLONG_MAX - ctx->count;
 	ctx->count += n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	this_cpu_dec(eventfd_wake_count);
+	this_cpu_dec(event_fd_recursion.count);
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
+	local_unlock(&event_fd_recursion.lock);

 	return n;
 }
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index fa0a524baed0..ca89d6c409c1 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -43,12 +43,7 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
wait_queue_entry_t *w
 				  __u64 *cnt);
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);

-DECLARE_PER_CPU(int, eventfd_wake_count);
-
-static inline bool eventfd_signal_count(void)
-{
-	return this_cpu_read(eventfd_wake_count);
-}
+bool eventfd_signal_count(void);

 #else /* CONFIG_EVENTFD */

-- 

