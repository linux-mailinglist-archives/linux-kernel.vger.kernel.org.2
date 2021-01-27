Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6295A306760
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhA0W6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhA0Wz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:55:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94035C061351
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7AtM/QmstSC9H7cv+04zDX0FRsehfo4S9RTjsnDMAHE=; b=nT0LngdIoStZ4i+ZhMKCNhEkbq
        +Ot/Agy4MpX6+i9qpA8LZb8eU8HQCEl/PXudCzCxfjmbl5pVn+p2IBe7pS7STlodegSHfU9NVi6GJ
        fraU29kjeCS92ldEQrfiqW0lPsU7isyXiVVrkHWcfKBvHqdbgBgwAKB0564qhjxSzAyaqh3i5CO0W
        vzELGLa+8flwas442njT3SYMXl7nGRHPTd3mgl+EEDBniAsaGjduQiFn/sXdz9KYc86kIt0FZTCQB
        gpcNMg1FIZCnR2T030iyhDJ752We1w/Ef+x6b636j6v7OeTOcHuHSpjN9tgg2vJ2VXMvZuSID/g+a
        S7yyrc2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4tXV-007bu6-Ba; Wed, 27 Jan 2021 22:43:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 115A4300455;
        Wed, 27 Jan 2021 23:43:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF41B200F8CC5; Wed, 27 Jan 2021 23:43:52 +0100 (CET)
Date:   Wed, 27 Jan 2021 23:43:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] qspinlock: Ensure writes are pushed out of core
 write buffer
Message-ID: <YBHsqIjop6X0Z+1c@hirez.programming.kicks-ass.net>
References: <20210127200109.16412-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127200109.16412-1-alexander.sverdlin@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:01:08PM +0100, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Ensure writes are pushed out of core write buffer to prevent waiting code
> on another cores from spinning longer than necessary.

Our smp_wmb() as defined does not have that property. You're relying on
some arch specific details which do not belong in common code.


> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> index 5e10153..10e497a 100644
> --- a/kernel/locking/mcs_spinlock.h
> +++ b/kernel/locking/mcs_spinlock.h
> @@ -89,6 +89,11 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
>  		return;
>  	}
>  	WRITE_ONCE(prev->next, node);
> +	/*
> +	 * This is necessary to make sure that the corresponding "while" in the
> +	 * mcs_spin_unlock() doesn't loop forever
> +	 */

This comment is utterly inadequate, since it does not describe an
explicit ordering between two (or more) stores.

> +	smp_wmb();
>  
>  	/* Wait until the lock holder passes the lock down. */
>  	arch_mcs_spin_lock_contended(&node->locked);
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index cbff6ba..577fe01 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -469,6 +469,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  
>  		/* Link @node into the waitqueue. */
>  		WRITE_ONCE(prev->next, node);
> +		/*
> +		 * This is necessary to make sure that the corresponding
> +		 * smp_cond_load_relaxed() below (running on another core)
> +		 * doesn't spin forever.
> +		 */
> +		smp_wmb();

That's insane, cache coherency should not allow that to happen in the
first place. Our smp_wmb() cannot help with that.

>  		pv_wait_node(node, prev);
>  		arch_mcs_spin_lock_contended(&node->locked);

