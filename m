Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC13380918
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhENMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhENMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:05:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7109C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IuuCItDUGLV0tdtVuKODb7PuvmdclIu199LYlyde0kI=; b=Pstq6ZBlF4chwup7HwRi4wea7K
        il7OxIqJX00WtMmA9lFrN/fNB86sgX0uUZAb0r0kXGDgqMr+HAoFyZjkEwVZZmXUWtE7PajHn+NR/
        +osg3O2fa+iEZmou0eBKi935kybyMHAugLM5oiKqVPFHwvqZoTwdWjUj73qGF7zQa4H9H9ekhAKSj
        2ooyxK+DNa5pn4pbDpDQsMc910PKVMz4hGknC/n94HfNNdJHJ2AkT2Rn9QxYl34ZyRC1G4qaDLSC3
        l5wgkJ5EYp/lVnC+V+57KS+FdblAfTrOCmW9uh+uqm5BRrS9r5+shPPhVAEW30XcWo01zfBljOtM5
        +2xNhBsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhWYF-007zBL-DB; Fri, 14 May 2021 12:04:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC45530001C;
        Fri, 14 May 2021 14:04:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DA802BE0F84B; Fri, 14 May 2021 14:04:14 +0200 (CEST)
Date:   Fri, 14 May 2021 14:04:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
Message-ID: <YJ5nPolKPE6xgVsV@hirez.programming.kicks-ass.net>
References: <20210513064837.3949064-1-ying.huang@intel.com>
 <YJ0fkhuAZ7JnNmEw@hirez.programming.kicks-ass.net>
 <20210514015946.nivgnoobef4nqwmw@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514015946.nivgnoobef4nqwmw@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 09:59:46PM -0400, Daniel Jordan wrote:
> On Thu, May 13, 2021 at 02:46:10PM +0200, Peter Zijlstra wrote:
> > Ah, I think I see what you meant to say, it would perhaps help if you
> > write it like so:
> > 
> > 
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 149e77454e3c..94735248dcd2 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -99,11 +99,10 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
> >  
> >  static struct swap_info_struct *swap_type_to_swap_info(int type)
> >  {
> > -	if (type >= READ_ONCE(nr_swapfiles))
> > +	if (type >= MAX_SWAPFILES)
> >  		return NULL;
> >  
> > -	smp_rmb();	/* Pairs with smp_wmb in alloc_swap_info. */
> > -	return READ_ONCE(swap_info[type]);
> > +	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
> >  }
> >  
> >  static inline unsigned char swap_count(unsigned char ent)
> > @@ -2869,14 +2868,11 @@ static struct swap_info_struct *alloc_swap_info(void)
> >  	}
> >  	if (type >= nr_swapfiles) {
> >  		p->type = type;
> > -		WRITE_ONCE(swap_info[type], p);
> >  		/*
> > -		 * Write swap_info[type] before nr_swapfiles, in case a
> > -		 * racing procfs swap_start() or swap_next() is reading them.
> > -		 * (We never shrink nr_swapfiles, we never free this entry.)
> > +		 * Publish the swap_info_struct.
> >  		 */
> > -		smp_wmb();
> > -		WRITE_ONCE(nr_swapfiles, nr_swapfiles + 1);
> > +		smp_store_release(&swap_info[type], p); /* rcu_assign_pointer() */
> > +		nr_swapfiles++;
> 
> Yes, this does help, I didn't understand why smp_wmb stayed around in
> the original post.
> 
> I think the only access smp_store_release() orders is p->type.  Wouldn't
> it be kinda inconsistent to only initialize that one field before
> publishing when many others would be done at the end of
> alloc_swap_info() after the fact?  p->type doesn't seem special.  For
> instance, get_swap_page_of_type() touches si->lock soon after it calls
> swap_type_to_swap_info(), so there could be a small window where there's
> a non-NULL si with an uninitialized lock.
> 
> It's not as if this is likely to be a problem in practice, it would just
> make it harder to understand why smp_store_release is there.  Maybe all
> we need is a WRITE_ONCE, or if it's really necessary for certain fields
> to be set before publication then move them up and explain?

You also care about the zero fill from kvzalloc(). Without the
smp_store_release() the zero-fill from the memset() might only be
visible 'late'.

Unless that also isn't a problem?
