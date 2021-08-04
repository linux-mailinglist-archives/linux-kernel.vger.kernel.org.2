Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF653E09F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhHDVRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230063AbhHDVRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628111859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v0xCOqT4DwRRgK+FhR6M4QKvtKCg8O1LkYdACEO8VNE=;
        b=U+xU5qSQvjtvxga05PQnG7eOhU+L7EW1pN1gUSMPThJjszOtATRgQHYyTuFbYKUmxVlcW4
        GJb+sWxLttohwHSJO5HUkbU6064crAjmukRiQJzrHKPJGvJ7B/RtD+SP0gyI6e09d/hNkq
        ClJhw7TwTABaulX6GjU+uxryPsSjpuI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-TU1AacxuMo6qgIM332nkgg-1; Wed, 04 Aug 2021 17:17:38 -0400
X-MC-Unique: TU1AacxuMo6qgIM332nkgg-1
Received: by mail-qk1-f200.google.com with SMTP id h186-20020a37b7c30000b02903b914d9e335so2791974qkf.17
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=v0xCOqT4DwRRgK+FhR6M4QKvtKCg8O1LkYdACEO8VNE=;
        b=ChfeGM6/lkDRtpjyqfoNOzF6NZsouxE3jmiHGdfx26QFS0WgYPMntjUqHQPEEbdsjq
         C2aJysisFAJ98lFgyhUrs5EeAnfb9mI3kN9cFQM/7onzX281wOFnPIx0UBO81gxP/3aS
         t2dd1z77XXnlOLd3u4gaCp4NLbxXX24vJMIbtHpE0aKglsIpZ2iuEf14eb3OU2ypG0UG
         p4SZ/Yp+RJeNsziBRXj46Pf+/W2p3RdJQuvg//bE2z+m45FIMCrjWARsLjhGvkX3UiC8
         +bC38X5Sy9E082D3k5YvJ1lRMk62FN9vcMARtiyP/DD1VNPfGK0N+/t7qDdKWtBIH2tw
         GXrQ==
X-Gm-Message-State: AOAM5321CNSY7IewlyTH0WagqQc1yv5onpir45M1JQbvXk1JYJmnMYMx
        b+sUEsySwLY+pwAHQEGctz7j9BtZZqHcMrZqitio/Z8i2lo1w8ko1ol+6zeTyxg+fYkkq0luR8P
        Mjq3UVGgaDsmDSQxkQvJwHlOS
X-Received: by 2002:a05:6214:e67:: with SMTP id jz7mr1635484qvb.0.1628111858266;
        Wed, 04 Aug 2021 14:17:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2e0s41ebl8AJKs7FLLqqmyKr34IbfdQMCKuUHiE8IpjkZf/s2CF8BgoKY4kS0tgO1AUCaVw==
X-Received: by 2002:a05:6214:e67:: with SMTP id jz7mr1635475qvb.0.1628111858089;
        Wed, 04 Aug 2021 14:17:38 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id w26sm1932346qki.6.2021.08.04.14.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 14:17:37 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [patch 22/63] locking/spinlock: Split the lock types header
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
 <20210730135206.416779376@linutronix.de>
Message-ID: <977ef5db-17b4-646d-cbb8-b0ca301b55ea@redhat.com>
Date:   Wed, 4 Aug 2021 17:17:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730135206.416779376@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 9:50 AM, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Move raw_spinlock into its own file. Prepare for RT 'sleeping spinlocks' to
> avoid header recursion as RT locks require rtmutex.h which in turn requires
> the raw spinlock types.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/rwlock_types.h       |    4 ++
>   include/linux/spinlock.h           |    4 ++
>   include/linux/spinlock_types.h     |   19 ----------
>   include/linux/spinlock_types_raw.h |   65 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 74 insertions(+), 18 deletions(-)
>   create mode 100644 include/linux/spinlock_types_raw.h
> ---
> --- a/include/linux/rwlock_types.h
> +++ b/include/linux/rwlock_types.h
> @@ -1,6 +1,10 @@
>   #ifndef __LINUX_RWLOCK_TYPES_H
>   #define __LINUX_RWLOCK_TYPES_H
>   
> +#if !defined(__LINUX_SPINLOCK_TYPES_H)
> +# error "Do not include directly, include spinlock_types.h"
> +#endif
> +
>   /*
>    * include/linux/rwlock_types.h - generic rwlock type definitions
>    *				  and initializers
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -12,6 +12,8 @@
>    *  asm/spinlock_types.h: contains the arch_spinlock_t/arch_rwlock_t and the
>    *                        initializers
>    *
> + *  linux/spinlock_types_raw:
> + *			  The raw types and initializers
>    *  linux/spinlock_types.h:
>    *                        defines the generic type and initializers
>    *
> @@ -31,6 +33,8 @@
>    *                        contains the generic, simplified UP spinlock type.
>    *                        (which is an empty structure on non-debug builds)
>    *
> + *  linux/spinlock_types_raw:
> + *			  The raw RT types and initializers
>    *  linux/spinlock_types.h:
>    *                        defines the generic type and initializers
>    *
> --- a/include/linux/spinlock_types.h
> +++ b/include/linux/spinlock_types.h
> @@ -9,24 +9,7 @@
>    * Released under the General Public License (GPL).
>    */
>   
> -#if defined(CONFIG_SMP)
> -# include <asm/spinlock_types.h>
> -#else
> -# include <linux/spinlock_types_up.h>
> -#endif
> -
> -#include <linux/lockdep_types.h>
> -
> -typedef struct raw_spinlock {
> -	arch_spinlock_t raw_lock;
> -#ifdef CONFIG_DEBUG_SPINLOCK
> -	unsigned int magic, owner_cpu;
> -	void *owner;
> -#endif
> -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> -	struct lockdep_map dep_map;
> -#endif
> -} raw_spinlock_t;
> +#include <linux/spinlock_types_raw.h>
>   
>   #define SPINLOCK_MAGIC		0xdead4ead
>   

Most of the code in spinlock_types.h are moved into 
spinlock_types_raw.h. However, macros like SPINLOCK_MAGIC and those that 
followed are not removed from spinlock_types.h in this patch leading to 
the same set of macro definitions in two different files. Should we 
eliminate the duplicate macro definitions either from spinlock_types.h 
or from spinlock_types_raw.h?

Cheers,
Longman

