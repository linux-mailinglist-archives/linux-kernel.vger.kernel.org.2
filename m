Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A652A36AF78
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhDZIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhDZIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:10:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E8DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mdNcf1AV82cZAqbKKVJR5a9TfZz/3J+tTladCWTiR98=; b=LRgz3EdAhWNWk9TSkxzT0qJNlm
        6i3IPJ0Ehi54Vmv5Pb45pgVFW7oNjT2CC8t6CFZ46UCwekq+CuUnLIibEeQ5sTnikcdK75J46CqS5
        vEM/V+dr8DPGUSlyLUbviCo8qe12c0tcT9PN9xLnIP2yyBWD+kU6L03M74+V/fXjqYfRty9A+5Ugx
        JtECoFuuJRFZl0+d7jvNq4TrcNxW3tVAA6Al3ihA3WOzqUkMcNXbEXB0gkfKw2to4nqyFylmGaOac
        BE/LLHDPM7TJUd9Bl0ZmbYoQgLms0GYV6/5a/Y2O+gpXI7PKmjS1pKXjLYPt2mVwZ9Z4UGbfay3zr
        6GTgd0sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lawI6-005LqG-Gh; Mon, 26 Apr 2021 08:08:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D900300212;
        Mon, 26 Apr 2021 10:08:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1432E2C988F39; Mon, 26 Apr 2021 10:08:26 +0200 (CEST)
Date:   Mon, 26 Apr 2021 10:08:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ali Saidi <alisaidi@amazon.com>,
        Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH] locking/qrwlock: queued_write_lock_slowpath() cleanup
Message-ID: <YIZ0+hNh0SMQoOkh@hirez.programming.kicks-ass.net>
References: <20210425200637.31298-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425200637.31298-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 04:06:37PM -0400, Waiman Long wrote:

>  void queued_write_lock_slowpath(struct qrwlock *lock)
>  {
> -	int cnts;
> +	int cnts = 0;
>  
>  	/* Put the writer into the wait queue */
>  	arch_spin_lock(&lock->wait_lock);
>  
>  	/* Try to acquire the lock directly if no reader is present */
>  	if (!atomic_read(&lock->cnts) &&
> -	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
> +	    atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED))
>  		goto unlock;

Would not something like:

	if (!(cnts = atomic_read(&lock->cnts)) &&
	    atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)
		goto unlock;

Be clearer?

>  
> -	/* Set the waiting flag to notify readers that a writer is pending */
> -	atomic_add(_QW_WAITING, &lock->cnts);
> +	/*
> +	 * Set the waiting flag to notify readers that a writer is pending
> +	 *
> +	 * As only one writer who is the wait_lock owner can set the waiting
> +	 * flag which will be cleared later on when acquiring the write lock,
> +	 * we can easily replace atomic_or() by an atomic_add() if there is
> +	 * an architecture where an atomic_add() performs better than an
> +	 * atomic_or().

That might be a little overboard on the comment, but sure :-) I don't
think there's any arch that doesn't have atomic_or(), like I wrote
elsewhere, the one that's often an issue is atomic_fetch_or().

> +	 */
> +	atomic_or(_QW_WAITING, &lock->cnts);

