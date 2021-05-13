Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5472437F80B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhEMMh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhEMMhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:37:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C5EC061760
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ooNLbXkTEFrnDrmch+4N2vrCFIT9f6rQmy04qi/aI0=; b=QzamFht2I/KHT8GUirs3Qhkzhp
        CFf0h475mZ86FQbYN7e1puF6i/qH7IrwM0iTnFZ/gE3O3Abzc/1kqS5agj2Loou5DOzBRYhF6aQsU
        lfkLr/4nQ/z05ltk8l3rKhIrKhLV/n8v5REyXJpDONDJ3fc7kdgob3zX735UcA+//Q/itMb02jyJa
        u5mDQSoYgzm2ObzSnJ1T72SEq5RYdjFuDxmtu//oI85o43Z/NiY9qp7OTlSRozaNUhJtMfcH+hdic
        h7Ts+OiiL0znohQC/CuU3FkATYL+YzC5amXUqkk0QpFWAW4jNstE5SHFwAsgmoEWfAXRTLpv1eclx
        wypHBUTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhAXp-005Wgs-Ie; Thu, 13 May 2021 12:36:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3DD630022A;
        Thu, 13 May 2021 14:34:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB0172BCF6229; Thu, 13 May 2021 14:34:19 +0200 (CEST)
Date:   Thu, 13 May 2021 14:34:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muchun Song <smuchun@gmail.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>,
        Paul McKenney <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] mm, swap: Remove unnecessary smp_rmb() in
 swap_type_to_swap_info()
Message-ID: <YJ0cy00kJdx9MJYJ@hirez.programming.kicks-ass.net>
References: <20210513064837.3949064-1-ying.huang@intel.com>
 <176421ba-77d9-8422-21e0-b5e2951533bd@huawei.com>
 <CAPSr9jEtdSgr5kDX=ESUrVtbuonUNEeFsOHpYYoFxD3PQ20C2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSr9jEtdSgr5kDX=ESUrVtbuonUNEeFsOHpYYoFxD3PQ20C2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 05:54:42PM +0800, Muchun Song wrote:
> On Thu, May 13, 2021 at 5:11 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
> > On 2021/5/13 14:48, Huang Ying wrote:

> > >  mm/swapfile.c | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 2aad85751991..4c1fb28bbe0e 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -100,10 +100,14 @@ atomic_t nr_rotate_swap = ATOMIC_INIT(0);
> > >
> > >  static struct swap_info_struct *swap_type_to_swap_info(int type)
> > >  {
> > > -     if (type >= READ_ONCE(nr_swapfiles))
> > > +     if (type >= MAX_SWAPFILES)
> > >               return NULL;
> > >
> > > -     smp_rmb();      /* Pairs with smp_wmb in alloc_swap_info. */
> > > +     /*
> > > +      * The data dependency ordering from the READ_ONCE() pairs
> > > +      * with smp_wmb() in alloc_swap_info() to guarantee the
> > > +      * swap_info_struct fields are read after swap_info[type].
> > > +      */
> > >       return READ_ONCE(swap_info[type]);
> > >  }
> > >
> > > @@ -2884,14 +2888,10 @@ static struct swap_info_struct *alloc_swap_info(void)
> > >       }
> > >       if (type >= nr_swapfiles) {
> > >               p->type = type;
> > > -             WRITE_ONCE(swap_info[type], p);
> > > -             /*
> > > -              * Write swap_info[type] before nr_swapfiles, in case a
> > > -              * racing procfs swap_start() or swap_next() is reading them.
> > > -              * (We never shrink nr_swapfiles, we never free this entry.)
> > > -              */
> > > +             /* Paired with READ_ONCE() in swap_type_to_swap_info() */
> > >               smp_wmb();
> >
> > Many thank for your patch. The patch looks fine to me. There is one question:
> >
> > There is no smp_rmb() paired with above smp_wmb(). What is this smp_wmb() used for ?
> > Could you please have a explanation ?
> 
> The comment is very clear, it matches READ_ONCE() which implies a
> data dependence barrier on some archs.

This statement doesn't make sense; this isn't code that needs to be
correct on 'some' archs, it needs to be unconditionally correct.

Also, you cannot pair with a single memop, there is no order in a set of
one element.

And if you depend on a data dependency, you need a store order; but you
just removed the store order. in which case the data dependency is also
moot.

All of this is utter confusion. Possibly correct, but a complete
trainwreck non-the-less.

Either you say ordering is irrelevant, because we only ever increase the
number of swapfiles and therefore any load is either NULL or the correct
pointer, as guaranteed by WRITE_ONCE()/READ_ONCE() avoiding load/store
tearing.

Or you need the data dependency, but then you also need the store order
like:

	CPU0					CPU1

	if (type >= READ_ONCE(nr_swapfiles))	WRITE_ONCE(swap_info[type], p);
		return NULL;
	/* data-dependency on type */		smp_wmb();
	return READ_ONCE(swap_info[type]);	WRITE_ONCE(nr_swapfiles, nr_swapfiles+1);

But you cannot have half of both and expect any of it to make sense.
