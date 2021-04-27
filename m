Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAE36C074
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhD0H5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230255AbhD0H5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:57:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 583ED613B2;
        Tue, 27 Apr 2021 07:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619510224;
        bh=bRHNZqpmvvRiQ6H9p8ANRgoi0Mwfrn+Q5Crphixp5Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLyN9Lmb44e2uJ01/HCrO6LhwSGIBY2LirJw5a1OM/W1QsYIu3Gi7h3eklwSmJ3ak
         tyTxzoRDUnA7RDKSnVLkPr2SmqGlz9+uAbEHbx9vkW0DQQnbkJyY4TsWBruhHXhSYZ
         +xBh6SDnO7XRgOUUVYFi4RW5wdcEa4w0RZpkfrRBgmpIhfKBcwMtNUVT33eiBr2hYE
         r04lz3b80T1Z66MEBCR8aJ2GpFL4mn7delHQyMRyjI3E4ANLd6Df/w+KeGwEmmRL1/
         5MhnpbV+Um192T4n8eW7fMDKNOQnLAggfiWcSj06opKa5opDpxfdtgkySbJBjk7bk2
         VjA4RazSoRgNA==
Date:   Tue, 27 Apr 2021 08:56:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ali Saidi <alisaidi@amazon.com>,
        Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH] locking/qrwlock: queued_write_lock_slowpath() cleanup
Message-ID: <20210427075659.GA6675@willie-the-truck>
References: <20210426185017.19815-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426185017.19815-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 02:50:17PM -0400, Waiman Long wrote:
> Make the code more readable by replacing the atomic_cmpxchg_acquire()
> by an equivalent atomic_try_cmpxchg_acquire() and change atomic_add()
> to atomic_or().
> 
> For architectures that use qrwlock, I do not find one that has an
> atomic_add() defined but not an atomic_or().  I guess it should be fine
> by changing atomic_add() to atomic_or().
> 
> Note that the previous use of atomic_add() isn't wrong as only one
> writer that is the wait_lock owner can set the waiting flag and the
> flag will be cleared later on when acquiring the write lock.

Right, there's no functional change here.

> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qrwlock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index b94f3831e963..ec36b73f4733 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -66,12 +66,12 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
>  	arch_spin_lock(&lock->wait_lock);
>  
>  	/* Try to acquire the lock directly if no reader is present */
> -	if (!atomic_read(&lock->cnts) &&
> -	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
> +	if (!(cnts = atomic_read(&lock->cnts)) &&
> +	    atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED))
>  		goto unlock;
>  
>  	/* Set the waiting flag to notify readers that a writer is pending */
> -	atomic_add(_QW_WAITING, &lock->cnts);
> +	atomic_or(_QW_WAITING, &lock->cnts);

Acked-by: Will Deacon <will@kernel.org>

Will
