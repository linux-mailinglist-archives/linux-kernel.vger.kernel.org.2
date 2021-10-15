Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C7142EE90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbhJOKQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbhJOKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:16:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22735C061753
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 03:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U4e1031d6TmWYqv7Vx3nhBcWsDTkiUa/xrlULU+MxTE=; b=L1IxovQmHEU7qYomhpe95lEp+4
        Oa6RwEa6iKbQlPq7r761ymOVf/rdt/RnO6IPV8BSN2STrdaObM1nkqlRuHkV1Rm3pjUAKizhRRPYX
        30HhhonExaKe1kWxG7ro21Q6Ii4gxBGHTVmR+uJTrD2eH5CDHUA7HW0xjjY9I1eTAySUksoh/9dX2
        NUj5209WsC0VKM4GrB0LdzaPDAyZVBI3iT3FRDbXiL2729sfIIKkVrx/tPhUxFl7vce4HZmuDRFg4
        wxXnxUgigqjxb2Tkdgf+bM3NeA2QPoMnXiLjdQFNO2DUCzDDaQ2lo96MIHnAO2uaVTPiHKcD8fEU/
        Un566vJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbKDw-009z4K-MY; Fri, 15 Oct 2021 10:14:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 937D73004E7;
        Fri, 15 Oct 2021 12:13:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 786392BF1A86B; Fri, 15 Oct 2021 12:13:59 +0200 (CEST)
Date:   Fri, 15 Oct 2021 12:13:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] locking/rwsem: disable preemption for spinning
 region
Message-ID: <YWlUZ5BlUZRA7LGR@hirez.programming.kicks-ass.net>
References: <20211013134154.1085649-1-yanfei.xu@windriver.com>
 <20211013134154.1085649-3-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013134154.1085649-3-yanfei.xu@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 09:41:53PM +0800, Yanfei Xu wrote:
> The spinning region rwsem_spin_on_owner() should not be preempted,
> however the rwsem_down_write_slowpath() invokes it and don't disable
> preemption. Fix it by adding a pair of preempt_disable/enable().

I'm thinking we should do this patch before #1, otherwise we have a
single patch window where we'll trigger the assertion, no?

> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>  kernel/locking/rwsem.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 7b5af452ace2..06925b43c3e7 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1024,6 +1024,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  	enum writer_wait_state wstate;
>  	struct rwsem_waiter waiter;
>  	struct rw_semaphore *ret = sem;
> +	enum owner_state owner_state;
>  	DEFINE_WAKE_Q(wake_q);
>  
>  	/* do optimistic spinning and steal lock if possible */
> @@ -1099,9 +1100,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  		 * In this case, we attempt to acquire the lock again
>  		 * without sleeping.
>  		 */
> -		if (wstate == WRITER_HANDOFF &&
> -		    rwsem_spin_on_owner(sem) == OWNER_NULL)
> -			goto trylock_again;
> +		if (wstate == WRITER_HANDOFF) {
> +			preempt_disable();
> +			owner_state = rwsem_spin_on_owner(sem);
> +			preempt_enable();
> +			if (owner_state == OWNER_NULL)
> +				goto trylock_again;
> +		}
>  
>  		/* Block until there are no active lockers. */
>  		for (;;) {
> -- 
> 2.27.0
> 
