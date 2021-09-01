Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E73FE29A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbhIAS4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347215AbhIASyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630522421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RbAFmH4NRZDrzTXv6FfKUSaQhi153qBbaeJVhJBO8Pc=;
        b=PECwhlHv6Nzzzndbrj1QxYOj+2rJitIZrUPa/Mra3tz3kbki6OR3fswty6OpI3Sd5W7qsf
        oo/ZiRyaI+quuLrPx42T1jLZC6lyCf1getAYoaY2zEay0xHs2WrIeskT9JypzD96RkJKRH
        mHfLLuUsgZ25vEyhwdZ3PY+IC4nbWyk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-Q_lkAIg6MZWdGjHGZwV7bw-1; Wed, 01 Sep 2021 14:53:40 -0400
X-MC-Unique: Q_lkAIg6MZWdGjHGZwV7bw-1
Received: by mail-qk1-f198.google.com with SMTP id 23-20020a05620a071700b00426392c0e6eso326557qkc.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RbAFmH4NRZDrzTXv6FfKUSaQhi153qBbaeJVhJBO8Pc=;
        b=VZ3KpRH7WKSrCmmY5C/3mQYnw49qYxZqXaUrKf7qtgGq4Etguxy0Mgox6qPBX+Fu89
         JiNY+3oB4u/l0dMmdHPNIj0fFVCCHQP7/kYNCFVFFgQ8qGMe2Re9p3IIpfBhPLQC1HRt
         yX9xATO7ub0wMiXOMGrASiPFDMcE4KZzprgFu6tznxEspyxB8LXBbXk9l/GVslQDCDzp
         RlZMs4vASvm+vr5PExQC9uxLUxHhWz7odAjGMbIO0xPIwi9HrV/4v0OY3mPaVlGMwiar
         hqWwYj3tRCbJ/u7JH+hgSLkpgXZ4WB+LF2S+JoVjpE7SeMQcm1PCge9VSE35WRUipx5g
         nopw==
X-Gm-Message-State: AOAM5313YDA6t8W18Gm+APOOdEnrWOuW4E66doohjVZFwlF++ZpKtxoR
        r0dIFF16X5Mb+JdTwFcX8LXw3VW/4tRvk+7GErxaSp9McoG969BUEzxjXSklqHXIS9E/E1Bcits
        Oa0zYKG072b78yKCYy5eB/AWs7ll+6t0wxqSj0Uf8W7+c+6NsV5TithXui/qtEUJ3LjxTTjCF
X-Received: by 2002:ad4:54e9:: with SMTP id k9mr815593qvx.4.1630522419620;
        Wed, 01 Sep 2021 11:53:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKi7vfN6quLYIR7M0PS7vUWjPFKYW6/sPR+vWMiSg6Dwl4YdkAoFQp4//ijlpvpOLeTJX+fg==
X-Received: by 2002:ad4:54e9:: with SMTP id k9mr815563qvx.4.1630522419329;
        Wed, 01 Sep 2021 11:53:39 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j3sm263353qki.104.2021.09.01.11.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 11:53:38 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC] locking: rwbase: Take care of ordering guarantee for
 fastpath reader
To:     Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
Message-ID: <afd149f2-b3ad-f7e1-7478-ca35685d2340@redhat.com>
Date:   Wed, 1 Sep 2021 14:53:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901150627.620830-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 11:06 AM, Boqun Feng wrote:
> Readers of rwbase can lock and unlock without taking any inner lock, if
> that happens, we need the ordering provided by atomic operations to
> satisfy the ordering semantics of lock/unlock. Without that, considering
> the follow case:
>
> 	{ X = 0 initially }
>
> 	CPU 0			CPU 1
> 	=====			=====
> 				rt_write_lock();
> 				X = 1
> 				rt_write_unlock():
> 				  atomic_add(READER_BIAS - WRITER_BIAS, ->readers);
> 				  // ->readers is READER_BIAS.
> 	rt_read_lock():
> 	  if ((r = atomic_read(->readers)) < 0) // True
> 	    atomic_try_cmpxchg(->readers, r, r + 1); // succeed.
> 	  <acquire the read lock via fast path>
>
> 	r1 = X;	// r1 may be 0, because nothing prevent the reordering
> 	        // of "X=1" and atomic_add() on CPU 1.
>
> Therefore audit every usage of atomic operations that may happen in a
> fast path, and add necessary barriers.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> Hi Thomas and Peter,
>
> Sorry I'm late for the party of PREEMPT_RT lock review. Just want to
> point the problem with this patch. Not even compile test, but show the
> idea and check if I'm missing something subtle.
>
> Regards,
> Boqun
>
>
>   kernel/locking/rwbase_rt.c | 34 ++++++++++++++++++++++++++++++----
>   1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> index 4ba15088e640..a1886fd8bde6 100644
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -41,6 +41,12 @@
>    * The risk of writer starvation is there, but the pathological use cases
>    * which trigger it are not necessarily the typical RT workloads.
>    *
> + * Fast-path orderings:
> + * The lock/unlock of readers can run in fast paths: lock and unlock are only
> + * atomic ops, and there is no inner lock to provide ACQUIRE and RELEASE
> + * semantics of rwbase_rt. Atomic ops then should be stronger than _acquire()
> + * and _release() to provide necessary ordering guarantee.
> + *
>    * Common code shared between RT rw_semaphore and rwlock
>    */
>   
> @@ -53,6 +59,7 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
>   	 * set.
>   	 */
>   	for (r = atomic_read(&rwb->readers); r < 0;) {
> +		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
>   		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))

Should we also change *cmpxchg() to cmpxchg_acquire() as it is a little 
cheaper for ll/sc arches?

The other changes look good to me.

Cheers,
Longman

