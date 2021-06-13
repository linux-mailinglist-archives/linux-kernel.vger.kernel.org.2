Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E903A561C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 05:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhFMDRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 23:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFMDRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 23:17:10 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5F8C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 20:14:53 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so1881565oti.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 20:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=V1RhSAK4oVzydpmUQrb0ucBxFw+KSa5ml799NQIt2x4=;
        b=udX1W5pJGANq3Dsx0jMAqmwsZyYb3W8BUgJticS9c2o6F/Aq0I6yLX37uzbCeGA5kX
         +rZNVVmokeAqQH4stnACV7GnyjycmcpIkZWCkauN1CR+n7LsEMfY2KnSb0XNOPAhVR7W
         jlqZMFEZ6HLgoh0DCH3q75insAA7elTwAvBrtPEJvGre/IKsg7eMWLfHXCr3x0GdrS72
         2/z5bEu0n2K+Nj5kXv1qbCN2NEaYAtXQ1h+0wDlksDl6/p7B7UoNSiTCsSVa//Kf295C
         dmP49ZnO6Eq07Qk+KERarQEs4pqFp0cZ+4VXGA3KorFkRnwO33FjyjUeNjFuqTyHRE0k
         ufVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=V1RhSAK4oVzydpmUQrb0ucBxFw+KSa5ml799NQIt2x4=;
        b=cDkMjve0lP7myQ/Q4zWTLnpxWwj7JnfdpgwMBHCbw406kQg60L82EE67dzFfUEfMsT
         yDVeXV5iBLSF+xdWrduUrrAOPCWaZE2u9CUD1VMozsd7AVgoV84J7UQhmS/EWn4bQyrB
         gFSa21HCmwkhSMKe8M5G3g2FryDdcHoGkRqDhwnc3JmH6KNcQOQDvugNVGKWYvYBoSoV
         6zeL9tBcUdRYKUzK4cEH9MnlhFTpR7sHKMiJtaA34c4WzF/FBQ+XutN8zV4jcJNRRlCV
         aCufd99tOvlHgVOly58HDT98KD1HYLF8Z4UAmkmkl0xNS/wvTwtB0NTdJZzqbZbcFUQ2
         Eymg==
X-Gm-Message-State: AOAM531m9GojyNsFXP+52Cnjb8Nn/EIXCyx/cDDFolb7M8EE6AMRzFSs
        oy0Occqh5KyJ7TSOKyiNPWA//A==
X-Google-Smtp-Source: ABdhPJw4CIm2xgPkqqgcbzU8rgkoYbZHVBy9u7p4ht7ZdRaAcqvBZV1VPMOUA8Wq2el5T0qOU9KeVg==
X-Received: by 2002:a9d:7e97:: with SMTP id m23mr9393388otp.286.1623554093026;
        Sat, 12 Jun 2021 20:14:53 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a7sm2214353ooo.9.2021.06.12.20.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 20:14:52 -0700 (PDT)
Date:   Sat, 12 Jun 2021 20:14:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <wetpzy@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Neel Natu <neelnatu@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, futex: Fix shared futex pgoff on shmem huge page
In-Reply-To: <YMTdtRZG+7q8OtkK@casper.infradead.org>
Message-ID: <e3d322e4-57e6-61d0-23e7-11f96f87415d@google.com>
References: <45e8fd67-51fd-7828-fe43-d261d6c33727@google.com> <YMTdtRZG+7q8OtkK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021, Matthew Wilcox wrote:
> On Fri, Jun 11, 2021 at 09:31:16PM -0700, Hugh Dickins wrote:
> > +++ linux/include/linux/pagemap.h	2021-06-11 17:30:28.726720252 -0700
> > @@ -516,8 +516,7 @@ static inline struct page *read_mapping_
> >  }
> >  
> >  /*
> > - * Get index of the page with in radix-tree
> > - * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
> > + * Get index of the page within radix-tree (but not for hugetlb pages).
> >   */
> 
> I think the TODO should be retained.  It's still something that I
> intend to do.

Okay.  I did not mean to imply, by removing those TODOs, that they
should not be done: just that they were a developer's notes to self,
that I found distracting there.

I've restored both TODOs (but changed the second to say
"hugetlb pages" explicitly, rather than the ambiguous "hugepage").

> > --- 5.13-rc5/mm/hugetlb.c	2021-06-06 16:57:26.263006733 -0700
> > +++ linux/mm/hugetlb.c	2021-06-11 17:30:28.730720276 -0700
> > @@ -1588,15 +1588,12 @@ struct address_space *hugetlb_page_mappi
> >  	return NULL;
> >  }
> >  
> > -pgoff_t __basepage_index(struct page *page)
> > +pgoff_t hugetlb_basepage_index(struct page *page)
> >  {
> >  	struct page *page_head = compound_head(page);
> >  	pgoff_t index = page_index(page_head);
> >  	unsigned long compound_idx;
> >  
> > -	if (!PageHuge(page_head))
> > -		return page_index(page);
> > -
> >  	if (compound_order(page_head) >= MAX_ORDER)
> >  		compound_idx = page_to_pfn(page) - page_to_pfn(page_head);
> >  	else
> > 
> 
> urgh.  this trailing bit should be:
> 
> #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
> 	compound_idx = page_to_pfn(page) - page_to_pfn(page_head);
> #else
> 	compound_idx = page - page_head;
> #endif

I don't see what's wrong with what's there, myself.  Unfamiliar territory
to me, but mem_map_next() appears to have the same MAX_ORDER expectation.
Or perhaps you're just suggesting an optimization.

If it were obvious to me, I'd have gladly folded it in; but no,
please send your own patch for that, running it by Mike Kravetz
and Mike Rapoport and David Hildenbrand, I think.

Thanks, v2 follows,
Hugh
