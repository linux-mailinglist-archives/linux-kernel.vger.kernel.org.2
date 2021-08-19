Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2123F1FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhHSSZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhHSSZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:25:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5670C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kaHNaocNAfVKVL214If1pYPRH6teE1pwcj11lQ1TYSQ=; b=cNDGqwzLleIHC3O0+5lwGDfE/e
        OLc8S3/QEz8FAZVIGR8cpyUY0R/xB7s83OPBY2I57EW82dtQRCTxgi4k9j1VZO2p/h36OjCoTIx4z
        1CIEdE9EYOZ9HlleClj/UgivD1+Icj4RixXLW9M+TuWH8sfL8pCnakIYrITOSxLYfY4JP0wx3dVKO
        qsVX++7RahJzM68h8yC/lNAO404GlqeEkQwJLsq2OtLlwNOyIGstuBKqg99UumJSJ0mnD3OM7pBTX
        9dnG69GblhAJPQEb4RoSgPxC2eObb6ywbWykJc106ix2qkIFY5lHjd550NboKyoZzYYzoxJeXknVc
        JOL5sf9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGmgZ-005QbL-S3; Thu, 19 Aug 2021 18:22:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC7FB3012AD;
        Thu, 19 Aug 2021 20:22:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C63A820242605; Thu, 19 Aug 2021 20:22:38 +0200 (CEST)
Date:   Thu, 19 Aug 2021 20:22:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] locking/ww_mutex: Initialize waiter.ww_ctx properly
Message-ID: <YR6hbiQLYYpadhkT@hirez.programming.kicks-ass.net>
References: <20210815203225.710392609@linutronix.de>
 <20210815211304.281927514@linutronix.de>
 <20210819165409.GA2335652@roeck-us.net>
 <20210819180850.koqw3ujmxga5wo4n@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819180850.koqw3ujmxga5wo4n@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 08:08:50PM +0200, Sebastian Andrzej Siewior wrote:
> The gathering of the debug code for the ww-mutex initialized moved the
> POISON initialiation into one spot and only set waiter.ww_ctx if the
> ww_ctx was non-NULL thus keeping the POISON value in ww-mutex case.
> 
> For ww-mutex without a context it is expected to set the context to
> NULL, the poison value was intended only for the regular mutex.
> 
> Move the waiter.ww_ctx where it was previously so it is initialized to
> NULL if no ww_ctx was passed.
> 
> Fixes: c0afb0ffc06e6 ("locking/ww_mutex: Gather mutex_waiter initialization")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/locking/mutex.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 05b68931622d1..d1068b0b163af 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -614,8 +614,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  
>  	debug_mutex_lock_common(lock, &waiter);
>  	waiter.task = current;
> -	if (ww_ctx)
> -		waiter.ww_ctx = ww_ctx;
>  
>  	lock_contended(&lock->dep_map, ip);
>  
> @@ -630,6 +628,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
>  		if (ret)
>  			goto err_early_kill;
> +		waiter.ww_ctx = ww_ctx;

Yeah, I suppose this works too, but I wanted to keep the waiter
initialization together. Note how you've already called
__ww_mutex_add_waiter() on it before you actually set part of the waiter
state.


