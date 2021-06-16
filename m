Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63503A9603
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhFPJZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhFPJZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:25:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52899C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TaWNxdzQbSXVk5H8iXNKOPI2Wp8X9rqeLx0uf2Jz6rc=; b=P8yNZOD1WlLVlwOKXGKkCpyQGu
        PjPkhRwmzBJThq/r33o/D/A5TjULFNx4rAEILjoZzaWl4zPCQAcNIQmtlgY3oB26IYdHaN8Klidga
        zMGkEDdVVbpr1senzkVI+qK/hytb/iyq4Cp1KKqemLpbYl2KASnSIJciyccn8btny6/Az79pQR1PG
        hDYPI1iOAraDo6bHB1582RcTGPZjPqbjq7vDj5VlePBeBjLdX53dJBuj+u0DKpLpKDIpiW6ueoPnt
        zy2mhx8pBG8q2Gn1wBTWIobEiUyi8X7rR+0IeoRPFO72u6m+TSMjGcSin1WNmd2faZX8kkYy1kywv
        X/2Uv6Tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltRlg-008HQt-39; Wed, 16 Jun 2021 09:23:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C688B300204;
        Wed, 16 Jun 2021 11:23:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD68F20277F84; Wed, 16 Jun 2021 11:23:33 +0200 (CEST)
Date:   Wed, 16 Jun 2021 11:23:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/6] posix-cpu-timers: Force next_expiration recalc after
 timer reset
Message-ID: <YMnDFQ9bvVPHu/kJ@hirez.programming.kicks-ass.net>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604113159.26177-5-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:31:57PM +0200, Frederic Weisbecker wrote:

> @@ -647,8 +651,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
>  	if (unlikely(timer->it.cpu.firing)) {
>  		timer->it.cpu.firing = -1;
>  		ret = TIMER_RETRY;
> -	} else {
> -		cpu_timer_dequeue(ctmr);
>  	}
>  
>  	/*
> @@ -713,9 +715,13 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
>  	 * For a timer with no notification action, we don't actually
>  	 * arm the timer (we'll just fake it for timer_gettime).
>  	 */
> -	cpu_timer_setexpires(ctmr, new_expires);
> -	if (new_expires != 0 && val < new_expires) {
> -		arm_timer(timer, p);
> +	if (new_expires != 0) {
> +		cpu_timer_dequeue(ctmr);
> +		cpu_timer_setexpires(ctmr, new_expires);
> +		if (val < new_expires)
> +			arm_timer(timer, p);
> +	} else {
> +		disarm_timer(timer, p);
>  	}
>  
>  	unlock_task_sighand(p, &flags);

AFAICT there's an error path in between where you've removed
cpu_timer_dequeue() and added it back. This error path will now leave
the timer enqueued.
