Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466F9306780
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhA0XFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:05:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233581AbhA0XBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:01:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11DAE61601;
        Wed, 27 Jan 2021 22:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611786124;
        bh=ibjxoXuujl5mHGAJ4LR3vpxOtWoS8wLc4XA/OntCLhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QI8f6A9fMhniIWgd99cQVkiuyMjXtPpbJpFE/gSyELALOS98i3As4WfeaQEOVUSc7
         i0MQpk8rcvA5gxJMa8c36l2FEblX0jIHwi4M1V8kbDgSmRa4YxkkB5Uu+SsLQQHWqN
         YlGX9t85tf7e+wE3whVkER4O6cZacb7k7EIvfKwXpqVHvgqM2Z55q7+w2Em8eQ6mGT
         nf7ycfb6R8vaYLLHHS59UJUvVnctqeahYJvS3uszHmSdmsnsHHsQgXirK3U056Jbuk
         7CHf/GvpHdCOrtoyzoNRn67Q7zO21C13eO1u4WY/Iw9L6cQNqOEciaAqZf4T6VAya7
         5IM51Xb7FU1rg==
Date:   Wed, 27 Jan 2021 22:21:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] qspinlock: Ensure writes are pushed out of core
 write buffer
Message-ID: <20210127222158.GB848@willie-the-truck>
References: <20210127200109.16412-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127200109.16412-1-alexander.sverdlin@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:01:08PM +0100, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Ensure writes are pushed out of core write buffer to prevent waiting code
> on another cores from spinning longer than necessary.
> 
> 6 threads running tight spinlock loop competing for the same lock
> on 6 cores on MIPS/Octeon do 1000000 iterations...
> 
> before the patch in:	4.3 sec
> after the patch in:	1.2 sec

If you only have 6 cores, I'm not sure qspinlock makes any sense...

> Same 6-core Octeon machine:
> sysbench --test=mutex --num-threads=64 --memory-scope=local run
> 
> w/o patch:	1.53s
> with patch:	1.28s
> 
> This will also allow to remove the smp_wmb() in
> arch/arm/include/asm/mcs_spinlock.h (was it actually addressing the same
> issue?).
> 
> Finally our internal quite diverse test suite of different IPC/network
> aspects didn't detect any regressions on ARM/ARM64/x86_64.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  kernel/locking/mcs_spinlock.h | 5 +++++
>  kernel/locking/qspinlock.c    | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
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
> +	smp_wmb();

If it loops forever, that's broken hardware design; store buffers need to
drain. I don't think we should add unconditional barriers to bodge this.

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

Likewise.

Will
