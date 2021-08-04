Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E53E0AE3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 01:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhHDXfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 19:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235323AbhHDXfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 19:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628120087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VQv4qZvsh4gqGG12A1+aEgDS91kf49v/O6T32Q2bwtM=;
        b=bk5oV7Cn1UcN41YmUVaOWLYLnlTUR0jAp6soqdjhY7GTyhBxIK0XIYJzSYia4WSXP+g/gs
        yJshKlS6HzL0qIYYjHnWrGbBtmMCEnqCxCtDWF8OLDqg1Opyj1WNN6QYFf+zTlktevMtoZ
        yGnVvoXWSTkvjah6UMemPBvvuxHT+Y8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-nYKAoBVKObOHMUAcS7qKnA-1; Wed, 04 Aug 2021 19:34:44 -0400
X-MC-Unique: nYKAoBVKObOHMUAcS7qKnA-1
Received: by mail-qk1-f198.google.com with SMTP id b190-20020a3767c70000b02903ca0967b842so1481697qkc.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 16:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VQv4qZvsh4gqGG12A1+aEgDS91kf49v/O6T32Q2bwtM=;
        b=rnxYX1rHC0pvnulN0puLcOAZ1QoCzDFtNMOTZf1FKtQlQSXLFW9VjpyRxk3G8oOFcL
         cMuiMfz8YX0dF3QKYZrK0eFrpELSDmOB8VNsGwiSPBd0fZzgwBKQy436d+dxm7KyWMXO
         KxD5xCOFADq0uVVfjCv6+CfP1onJkyGa8igy7EkAjH90DZebbewzwD9xbK48pc66ezSK
         GhgXXrisFcK1nCY/LrHn+B8LXodTTzM/iQFZWLX+d+5bN2Fk1kiZ36o7otp7aYjUIO25
         GsKpmOIiJb4nJjriR4cFv3hr4iXW9lNwMQ+ToUGWNhJdnSl+fsQRDTgTtm7pdz3OKRBI
         7OPg==
X-Gm-Message-State: AOAM531xXr1VvExsGBARN4t+JjlGXs3cU0Zw+4+J3+jgqlH2pBWxlrWE
        bg0kCFP3iKUYHrLUnZq0PaL2l9JfiSEmHfHByb0rG0bnkzJrJc6enMPUMd1s/Var/MzCZuEg2i2
        1sFltidFBoDHB6CruN+AUqb2F
X-Received: by 2002:a05:622a:104a:: with SMTP id f10mr1945495qte.340.1628120084415;
        Wed, 04 Aug 2021 16:34:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl9rRdjxepiOiyYQS7TcrkbqZpMoDI0ChGVDRK0W7wLv1R/j1RPQNuuHd8hbeeRX1LcABeDg==
X-Received: by 2002:a05:622a:104a:: with SMTP id f10mr1945482qte.340.1628120084211;
        Wed, 04 Aug 2021 16:34:44 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id q194sm2224297qke.83.2021.08.04.16.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 16:34:43 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [patch 30/63] locking/spinlock: Provide RT variant
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135206.865728220@linutronix.de>
Message-ID: <4fa5ec01-ff09-16f3-e1d6-42431036f554@redhat.com>
Date:   Wed, 4 Aug 2021 19:34:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730135206.865728220@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 9:50 AM, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Provide the actual locking functions which make use of the general and
> spinlock specific rtmutex code.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/locking/Makefile      |    1
>   kernel/locking/spinlock_rt.c |  128 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 129 insertions(+)
>   create mode 100644 kernel/locking/spinlock_rt.c
> ---
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_
>   obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
>   obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
>   obj-$(CONFIG_RT_MUTEXES) += rtmutex_api.o
> +obj-$(CONFIG_PREEMPT_RT) += spinlock_rt.o
>   obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
>   obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
>   obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
> --- /dev/null
> +++ b/kernel/locking/spinlock_rt.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PREEMPT_RT substitution for spin/rw_locks
> + *
> + * spin_lock and rw_lock on RT are based on rtmutex with a few twists to
> + * resemble the non RT semantics
> + *
> + * - Contrary to a plain rtmutex, spin_lock and rw_lock are state
> + *   preserving. The task state is saved before blocking on the underlying
> + *   rtmutex and restored when the lock has been acquired. Regular wakeups
> + *   during that time are redirected to the saved state so no wake up is
> + *   missed.
> + *
> + * - Non RT spin/rw_locks disable preemption and evtl. interrupts.

"evtl."?

Cheers,
Longman

