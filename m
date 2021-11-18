Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEF1455C06
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhKRNBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 08:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbhKRNAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:00:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DD7C061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 04:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vw2RtRDqZx0KL5diXS9XJfB4H1fG1sWaBHHCylHETiw=; b=KVVs2tSjH/0c/KaVkXQzyEWA/A
        rSdUGMCgQA+urrM+USutUaBZ4qq09q5xT7e8UHrkI9MDkRz384CTI7vxMgo3jTOUp5A1+Za1favPm
        6/8Eoj2bEEVWSMWwRFwOIokkO4N89uAFOuKwBMw/fspLZqa6/MVo1hGtEH1bcnx4XXL1cIzuFTcKK
        12lAJrgPl3qAIW/545KI9JP9/bPfeCfN5ooeM/UNv48haOmAZH+PLthE81/QcSsrW8KBgZ8yDIt1H
        yE31/EKshBND+p0YICw1IBuWmDkpRS3BwC7Umxnarzkd7bFnG6anHjRnDVerDW4oOWFfxy+clbgH9
        Ptwb3rmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mngyu-008TPz-JM; Thu, 18 Nov 2021 12:57:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F2113001FD;
        Thu, 18 Nov 2021 13:57:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC2652D3CA557; Thu, 18 Nov 2021 13:57:35 +0100 (CET)
Date:   Thu, 18 Nov 2021 13:57:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH] locking/rwsem: Optimize down_read_trylock() under highly
 contended case
Message-ID: <YZZNv3JflBYwRjdd@hirez.programming.kicks-ass.net>
References: <20211118094455.9068-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118094455.9068-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 05:44:55PM +0800, Muchun Song wrote:

> By using the above benchmark, the real executing time on a x86-64 system
> before and after the patch were:

What kind of x86_64 ?

> 
>                   Before Patch  After Patch
>    # of Threads      real          real     reduced by
>    ------------     ------        ------    ----------
>          1          65,373        65,206       ~0.0%
>          4          15,467        15,378       ~0.5%
>         40           6,214         5,528      ~11.0%
> 
> For the uncontended case, the new down_read_trylock() is the same as
> before. For the contended cases, the new down_read_trylock() is faster
> than before. The more contended, the more fast.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  kernel/locking/rwsem.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index c51387a43265..ef2b2a3f508c 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1249,17 +1249,14 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
>  
>  	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
>  
> -	/*
> -	 * Optimize for the case when the rwsem is not locked at all.
> -	 */
> -	tmp = RWSEM_UNLOCKED_VALUE;
> -	do {
> +	tmp = atomic_long_read(&sem->count);
> +	while (!(tmp & RWSEM_READ_FAILED_MASK)) {
>  		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> -					tmp + RWSEM_READER_BIAS)) {
> +						    tmp + RWSEM_READER_BIAS)) {
>  			rwsem_set_reader_owned(sem);
>  			return 1;
>  		}
> -	} while (!(tmp & RWSEM_READ_FAILED_MASK));
> +	}
>  	return 0;
>  }

This is weird... so the only difference is that leading load, but given
contention you'd expect that load to stall, also, given it's a
non-exclusive load, to get stolen by a competing CPU. Whereas the old
code would start with a cmpxchg, which obviously will also stall, but
does an exclusive load.

And the thinking is that the exclusive load and the presence of the
cmpxchg loop would keep the line on that CPU for a little while and
progress is made.

Clearly this isn't working as expected. Also I suppose it would need
wider testing...

