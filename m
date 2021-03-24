Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3B3476D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhCXLKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhCXLKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:10:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6DDC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 04:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3T8iu/qdOkx2N3h+JT3OPgD2ctqodSwNmXaB7wutWzA=; b=lnQQHrIn6MADzhda+f8n/XYl6e
        ZR3Cyl1TtYeVGMyTw9gmG3b6Z4zz4MQI+pIdHuPq85cl/9zzqG6+Z0MGRDdEMagII+txSiRO7PeWA
        r0F/HEOkTcnToQ1quMwVezUsvRZyu0yO8FuWUwJKHo2IgZUGZ6wlW5mi9bP7X8f+yRwF9V5ITBY/K
        levcbfd3jRvy5iItCXZq87VNBi7jbIkbqBeg+h4f/ro1SrF5NQUuNhLGvn88cdNzMAYy0UeZ5zGpS
        Zeoa6fJ3RamzmkB09WJrJ5WJHK/8XutRPGgSZKfBdmC1VAde5w/v+6/ObAKO09+406yUAN6zyKVm5
        q8xCtr5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP1OH-00BGwS-AS; Wed, 24 Mar 2021 11:09:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F6413010C8;
        Wed, 24 Mar 2021 12:09:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C17A28B290D3; Wed, 24 Mar 2021 12:09:32 +0100 (CET)
Date:   Wed, 24 Mar 2021 12:09:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Message-ID: <YFsd7A6xzrWXi1l5@hirez.programming.kicks-ass.net>
References: <1616580892-80815-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616580892-80815-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:14:52AM +0000, guoren@kernel.org wrote:
> +static inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	arch_spinlock_t lockval;
> +	u32 tmp;
> +
> +	asm volatile (
> +		"1:	lr.w	%0, %2		\n"
> +		"	mv	%1, %0		\n"
> +		"	addw	%0, %0, %3	\n"
> +		"	sc.w	%0, %0, %2	\n"
> +		"	bnez	%0, 1b		\n"
> +		: "=&r" (tmp), "=&r" (lockval), "+A" (lock->lock)
> +		: "r" (1 << TICKET_NEXT)
> +		: "memory");
>  
> +	while (lockval.tickets.next != lockval.tickets.owner) {
> +		/*
> +		 * FIXME - we need wfi/wfe here to prevent:
> +		 *  - cache line bouncing
> +		 *  - saving cpu pipeline in multi-harts-per-core
> +		 *    processor
> +		 */
> +		lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
> +	}
>  
> +	__atomic_acquire_fence();
>  }

> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
>  {
> +	smp_store_release(&lock->tickets.owner, lock->tickets.owner + 1);
> +	/* FIXME - we need ipi/sev here to notify above */
>  }

Urgh, are you saying your WFE requires an explicit SEV like on ARM ? The
ARM64 model is far superious IMO, and then you can use
smp_cond_load_acquire() in arch_spin_lock() and call it a day.
