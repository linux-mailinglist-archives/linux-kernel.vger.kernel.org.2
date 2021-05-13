Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C5837F81E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhEMMsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhEMMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:47:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02358C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jkWbVhK6bN6jf9Y4RTIuGYvQYWWOv6acRUUjRrSacgA=; b=RVVSyLZLVK1PgCAQEIn+GeEafj
        qEUOn0zNn3WEsETvFKyhHI/xEQBAVIV6YCLDCIzXdhe3VIOb7l58MsiLTfS7Dcwwtwn63Ve/N+FpT
        W1KBYYHfTxR3urphyVQYEQZRadTORI+GdNPfRmWk65ca/HvllEPbLT3zBwhd5XHCl+NmXMyg3oT6a
        3E3bZC3CJcv1hJUlliZ5x4dS4JjRggCn1TB9BuVNToJEQMoPPm6fJvtyHC+JJz3YY47NeIewfgGJn
        cqexSJL/6QCwQ5LHszst10Uiv5+vnCv0LeaVRGlXXm3M0o7vYnGE/UqKaUC9V23z8GPkUQEGWn5YQ
        oO1Y7GOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhAjD-005YUW-4X; Thu, 13 May 2021 12:46:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D4D130019C;
        Thu, 13 May 2021 14:46:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22E332BCF622A; Thu, 13 May 2021 14:46:10 +0200 (CEST)
Date:   Thu, 13 May 2021 14:46:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>,
        Paul McKenney <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH] mm, swap: Remove unnecessary smp_rmb() in
 swap_type_to_swap_info()
Message-ID: <YJ0fkhuAZ7JnNmEw@hirez.programming.kicks-ass.net>
References: <20210513064837.3949064-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513064837.3949064-1-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 02:48:37PM +0800, Huang Ying wrote:
>  mm/swapfile.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2aad85751991..4c1fb28bbe0e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -100,10 +100,14 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>  
>  static struct swap_info_struct *swap_type_to_swap_info(int type)
>  {
> -	if (type >= READ_ONCE(nr_swapfiles))
> +	if (type >= MAX_SWAPFILES)
>  		return NULL;
>  
> -	smp_rmb();	/* Pairs with smp_wmb in alloc_swap_info. */
> +	/*
> +	 * The data dependency ordering from the READ_ONCE() pairs
> +	 * with smp_wmb() in alloc_swap_info() to guarantee the
> +	 * swap_info_struct fields are read after swap_info[type].
> +	 */
>  	return READ_ONCE(swap_info[type]);
>  }
>  
> @@ -2884,14 +2888,10 @@ static struct swap_info_struct *alloc_swap_info(void)
>  	}
>  	if (type >= nr_swapfiles) {
>  		p->type = type;
> -		WRITE_ONCE(swap_info[type], p);
> -		/*
> -		 * Write swap_info[type] before nr_swapfiles, in case a
> -		 * racing procfs swap_start() or swap_next() is reading them.
> -		 * (We never shrink nr_swapfiles, we never free this entry.)
> -		 */
> +		/* Paired with READ_ONCE() in swap_type_to_swap_info() */
>  		smp_wmb();
> -		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
> +		WRITE_ONCE(swap_info[type], p);
> +		nr_swapfiles++;

Ah, I think I see what you meant to say, it would perhaps help if you
write it like so:


diff --git a/mm/swapfile.c b/mm/swapfile.c
index 149e77454e3c..94735248dcd2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -99,11 +99,10 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
 
 static struct swap_info_struct *swap_type_to_swap_info(int type)
 {
-	if (type >= READ_ONCE(nr_swapfiles))
+	if (type >= MAX_SWAPFILES)
 		return NULL;
 
-	smp_rmb();	/* Pairs with smp_wmb in alloc_swap_info. */
-	return READ_ONCE(swap_info[type]);
+	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
 }
 
 static inline unsigned char swap_count(unsigned char ent)
@@ -2869,14 +2868,11 @@ static struct swap_info_struct *alloc_swap_info(void)
 	}
 	if (type >= nr_swapfiles) {
 		p->type = type;
-		WRITE_ONCE(swap_info[type], p);
 		/*
-		 * Write swap_info[type] before nr_swapfiles, in case a
-		 * racing procfs swap_start() or swap_next() is reading them.
-		 * (We never shrink nr_swapfiles, we never free this entry.)
+		 * Publish the swap_info_struct.
 		 */
-		smp_wmb();
-		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
+		smp_store_release(&swap_info[type], p); /* rcu_assign_pointer() */
+		nr_swapfiles++;
 	} else {
 		defer = p;
 		p = swap_info[type];
