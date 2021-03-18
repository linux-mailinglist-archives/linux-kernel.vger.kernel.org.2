Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5E233FE50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 05:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCREqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 00:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhCREqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:46:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DEBC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 21:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F93ivzjYDpHgoLKqz/Drlvs5EXIlgslgFHl2ysODhqY=; b=TTc9/ePOh7n5qN3ogFUpZ0TSFj
        iNcQPGs9OgTvFhNzCFN5skhEb70V1Mlf7JbB60NYv1m33UgkkGMEbgBLow1c7yLw8fMqNnYvM9Wqv
        Xd9vfGJjHZpjejsVVhdOjd9udpgKoai5zzp/PL6umPKoU2Tw4eixcSaDr/CR3fch6QGvdw7oktJM7
        L7eLnAFY2+KUSNLU9LzcZqOzzR8MNbVi6Wxf2Ui8dX1bv3SmWhjV9U+E818WRLwArboaWByKo1d/n
        T/5n/FO6EG45KEY7v/njCRc3LJPxuXekh1lIhaitwT4fihmw9c1OGCxF6jS43cxO5hLgOGIkv2l07
        qdzwNjwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMkXo-002YSO-Rt; Thu, 18 Mar 2021 04:46:06 +0000
Date:   Thu, 18 Mar 2021 04:46:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Aili Yao <yaoaili@kingsoft.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yangfeng1@kingsoft.com,
        sunhao2@kingsoft.com, Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm/gup: check page posion status for coredump.
Message-ID: <20210318044600.GJ3420@casper.infradead.org>
References: <20210317163714.328a038d@alex-virtual-machine>
 <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:12:02AM +0100, David Hildenbrand wrote:
> > +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) && ret == 1) {
> > +		if (unlikely(PageHuge(page) && PageHWPoison(compound_head(page))))
> > +			ret = 0;
> > +		else if (unlikely(PageHWPoison(page)))
> > +			ret = 0;
> > +	}
> 
> I wonder if a simple
> 
> if (PageHWPoison(compound_head(page)))
> 	ret = 0;
> 
> won't suffice. But I guess the "issue" is compound pages that are not huge
> pages or transparent huge pages.

THPs don't set the HWPoison bit on the head page.

https://lore.kernel.org/linux-mm/20210316140947.GA3420@casper.infradead.org/

(and PAGEFLAG(HWPoison, hwpoison, PF_ANY))

By the way,

#ifdef CONFIG_MEMORY_FAILURE
PAGEFLAG(HWPoison, hwpoison, PF_ANY)
TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
#define __PG_HWPOISON (1UL << PG_hwpoison)
extern bool take_page_off_buddy(struct page *page);
#else
PAGEFLAG_FALSE(HWPoison)
#define __PG_HWPOISON 0
#endif

so there's no need for this 
	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)
check, as it simply turns into

	if (PageHuge(page) && 0)
	else if (0)

and the compiler can optimise it all away.
