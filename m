Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB9C398F8A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhFBQFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232624AbhFBQFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:05:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B653A6162E;
        Wed,  2 Jun 2021 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622649838;
        bh=MT3465/9NA3wR+JslezglEfBk9PtRM3VfQrhsq1XZaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+zS+Yh/9eZwBPulYurBlP1e7GQ4RGt3G0sf/QP/LEsNe3jRZ1a1Mt69tK9bugsvO
         5mLPPYZGfq4pkwvMyWAKSUS3ALC8keedFRcUzY7zdfhTykbfj7iwV8uut+5TLyLuya
         JNOcHmlRGNwh1OT8uwFXjbDWMAM9tIVpUVbh277swTo0DS1e5PTyrVnMb35y/B4tyC
         DPHeu4Rgdez6WgiqZ0IDhcRWN1XY6swRZdGqkwpUB5I+TBW1B44FBV/Oih9N37TUgL
         E7bfHM9VKg+zB+4HaqfDYMeIrC9tf7Uu3oQgq06n4pHUE+9mKnq+bUo/xKOnSa0K1I
         r8dF1oVTJrK0A==
Date:   Wed, 2 Jun 2021 17:03:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>,
        Paul McKenney <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH -V2] mm, swap: Remove unnecessary smp_rmb() in
 swap_type_to_swap_info()
Message-ID: <20210602160351.GG31179@willie-the-truck>
References: <20210520073301.1676294-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520073301.1676294-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 03:33:01PM +0800, Huang Ying wrote:
> Before commit c10d38cc8d3e ("mm, swap: bounds check swap_info array
> accesses to avoid NULL derefs"), the typical code to reference the
> swap_info[] is as follows,
> 
>   type = swp_type(swp_entry);
>   if (type >= nr_swapfiles)
>           /* handle invalid swp_entry */;
>   p = swap_info[type];
>   /* access fields of *p.  OOPS! p may be NULL! */
> 
> Because the ordering isn't guaranteed, it's possible that
> swap_info[type] is read before "nr_swapfiles".  And that may result
> in NULL pointer dereference.
> 
> So after commit c10d38cc8d3e, the code becomes,
> 
>   struct swap_info_struct *swap_type_to_swap_info(int type)
>   {
> 	  if (type >= READ_ONCE(nr_swapfiles))
> 		  return NULL;
> 	  smp_rmb();
> 	  return READ_ONCE(swap_info[type]);
>   }
> 
>   /* users */
>   type = swp_type(swp_entry);
>   p = swap_type_to_swap_info(type);
>   if (!p)
> 	  /* handle invalid swp_entry */;
>   /* dereference p */
> 
> Where the value of swap_info[type] (that is, "p") is checked to be
> non-zero before being dereferenced.  So, the NULL deferencing
> becomes impossible even if "nr_swapfiles" is read after
> swap_info[type].  Therefore, the "smp_rmb()" becomes unnecessary.
> 
> And, we don't even need to read "nr_swapfiles" here.  Because the
> non-zero checking for "p" is sufficient.  We just need to make sure we
> will not access out of the boundary of the array.  With the change,
> nr_swapfiles will only be accessed with swap_lock held, except in
> swapcache_free_entries().  Where the absolute correctness of the value
> isn't needed, as described in the comments.
> 
> We still need to guarantee swap_info[type] is read before being
> dereferenced.  That can be satisfied via the data dependency ordering
> enforced by READ_ONCE(swap_info[type]).  This needs to be paired with
> proper write barriers.  So smp_store_release() is used in
> alloc_swap_info() to guarantee the fields of *swap_info[type] is
> initialized before swap_info[type] itself being written.  Note that
> the fields of *swap_info[type] is initialized to be 0 via kvzalloc()
> firstly.  The assignment and deferencing of swap_info[type] is like
> rcu_assign_pointer() and rcu_dereference().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Paul McKenney <paulmck@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> 
> v2:
> 
> - Revise the patch description and comments per Peter's comments.
> 
> ---
>  mm/swapfile.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2aad85751991..65dd979a0f94 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -100,11 +100,10 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>  
>  static struct swap_info_struct *swap_type_to_swap_info(int type)
>  {
> -	if (type >= READ_ONCE(nr_swapfiles))
> +	if (type >= MAX_SWAPFILES)
>  		return NULL;
>  
> -	smp_rmb();	/* Pairs with smp_wmb in alloc_swap_info. */
> -	return READ_ONCE(swap_info[type]);
> +	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
>  }
>  
>  static inline unsigned char swap_count(unsigned char ent)
> @@ -2884,14 +2883,12 @@ static struct swap_info_struct *alloc_swap_info(void)
>  	}
>  	if (type >= nr_swapfiles) {
>  		p->type = type;
> -		WRITE_ONCE(swap_info[type], p);
>  		/*
> -		 * Write swap_info[type] before nr_swapfiles, in case a
> -		 * racing procfs swap_start() or swap_next() is reading them.
> -		 * (We never shrink nr_swapfiles, we never free this entry.)
> +		 * Publish the swap_info_struct after initializing it.
> +		 * Note that kvzalloc() above zeroes all its fields.
>  		 */
> -		smp_wmb();
> -		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
> +		smp_store_release(&swap_info[type], p); /* rcu_assign_pointer() */
> +		nr_swapfiles++;

Although I like this change, I comment you are removing refers to some
dodgy-looking code. For example, swap_start() has this loop:

	for (type = 0; (si = swap_type_to_swap_info(type)); type++) {
		if (!(si->flags & SWP_USED) || !si->swap_map)
			continue;

so won't this just end up dereferencing NULL if nr_swapfiles < MAX_SWAPFILES?

I think you need to check all callers of swap_type_to_swap_info() are
either validating the 'type' they pass in or check the returned pointer.

Will
