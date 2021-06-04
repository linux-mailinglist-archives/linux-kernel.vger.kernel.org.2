Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FA439C384
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhFDW3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:29:25 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:35657 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhFDW3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:29:24 -0400
Received: by mail-qt1-f173.google.com with SMTP id k19so8207343qta.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 15:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=B3O8UJSMTQQhS99DGyyLVGIi/VQpIh0lbbsZ+SyscJA=;
        b=GrkPZyJMPftAxaIao4byOQfudeLk1Sn7s3Ygjc8rUa5iiInEVgXTpQOj/kkhYL7eZm
         7ptWc5d2vEoZa1+UsMmGsoL2VqLUdwepP53Y1BN2kYZzjLka3BsIy3xtT+xJ8/QQkvFX
         Bvh3oBQnomPw8cNnv1YcWezWVGeaqVXyfcZRB1JthHymknNz6a9vhUCB7Pa8opsszBtx
         2jUheb7w1OzDvA0gS6TpPklvH5VRGTSmeGWTKsLx3FNHjkgmPnT1wWUTW0HqUvtWcBeZ
         E0sYGuDafQKjZCzKXBKBtDCPAXO2PqUtq2kmpXtQY1vuxb+ScfVdl4nUuy82Uz6ik8Qi
         eJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=B3O8UJSMTQQhS99DGyyLVGIi/VQpIh0lbbsZ+SyscJA=;
        b=XbzMFrO0dofWPIxcq9Hruxa/oVJqAS7+avmb113a0kzwEwhqY47jrm5Cc43BReBqQl
         31wdvsmVccIq0PVhuXXzXEi8Zv1bia45PBDalRY6s+c2wXalC0yeQo4lBWHQKD7oKut5
         XKTTzhdjCo9LFHvVWglmy/oGzvBCIENTDf+oyYpsMz9t1XOBgiHP/H5PRUBBGp00NeKH
         DEYLPd7p4POAi5c87QuXx7hkJSbAanBPWGHW0Vb4H3pI7WuQHVoOn2hiaTS7FqJ4E4ao
         6YzQhgATCGbQOZ86aceiQ/YbvGSHOUsQx1FCHOu50ssRYB2wfSMynfw4lBG4My2YPKpX
         AVZg==
X-Gm-Message-State: AOAM533Ii21+x0wMydWJwrhGvKUTNV7fV5nn9vrkpdciE+sjsGwDuBNh
        FDo5z7kLzS7YSSl/Sn47h6DJtA==
X-Google-Smtp-Source: ABdhPJwWxTOvXkrTB/0h/9HGV4Rd7WRZwUDKnigb7/qaeMTDJjZDhtETBrHRC6ThqBg5/HtZIY9UQw==
X-Received: by 2002:ac8:75d4:: with SMTP id z20mr6645712qtq.265.1622845582508;
        Fri, 04 Jun 2021 15:26:22 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p19sm4711150qki.119.2021.06.04.15.26.20
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 04 Jun 2021 15:26:21 -0700 (PDT)
Date:   Fri, 4 Jun 2021 15:26:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/thp: try_to_unmap() use TTU_SYNC for safe DEBUG_VM
 splitting
In-Reply-To: <YLo9RZOrCrp/1f4D@t490s>
Message-ID: <alpine.LSU.2.11.2106041454430.14037@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011405510.2148@eggly.anvils> <YLlOPoP/rIRMm2U5@t490s> <alpine.LSU.2.11.2106031945280.12760@eggly.anvils> <YLo9RZOrCrp/1f4D@t490s>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021, Peter Xu wrote:
> On Thu, Jun 03, 2021 at 07:54:11PM -0700, Hugh Dickins wrote:
> > On Thu, 3 Jun 2021, Peter Xu wrote:
> > > On Tue, Jun 01, 2021 at 02:07:53PM -0700, Hugh Dickins wrote:
> > > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > > index 2cf01d933f13..b45d22738b45 100644
> > > > --- a/mm/page_vma_mapped.c
> > > > +++ b/mm/page_vma_mapped.c
> > > > @@ -212,6 +212,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > > >  			pvmw->ptl = NULL;
> > > >  		}
> > > >  	} else if (!pmd_present(pmde)) {
> > > > +		/*
> > > > +		 * If PVMW_SYNC, take and drop THP pmd lock so that we
> > > > +		 * cannot return prematurely, while zap_huge_pmd() has
> > > > +		 * cleared *pmd but not decremented compound_mapcount().
> > > > +		 */
> > > > +		if ((pvmw->flags & PVMW_SYNC) &&
> > > > +		    PageTransCompound(pvmw->page))
> > > > +			spin_unlock(pmd_lock(mm, pvmw->pmd));
> > > >  		return false;
> > > >  	}
> > > >  	if (!map_pte(pvmw))
> > > 
> > > Sorry if I missed something important, but I'm totally confused on how this
> > > unlock is pairing with another lock()..
> > 
> > I imagine you're reading that as spin_unlock(pmd_lockptr(blah));
> > no, the lock is right there, inside spin_unlock(pmd_lock(blah)).
> 
> Heh, yeah... Sorry about that.

I'll expand that line, as Kirill asks too.

> 
> > 
> > > 
> > > And.. isn't PVMW_SYNC only meaningful for pte-level only (as I didn't see a
> > > reference of it outside map_pte)?
> > 
> > But you are pointing directly to its reference outside map_pte()!
> 
> Right, I was trying to look for the lock() so I needed to look at all the rest
> besides this one. :)
> 
> I didn't follow Yang's patch, but if Yang's patch can make kernel not crashing
> and fault handling done all well, then I'm kind of agree with him: having
> workaround code (like taking lock and quickly releasing..) only for debug code
> seems an overkill to me, not to mention that the debug code will be even more
> strict after this patch, as it means it's even less likely that one can
> reproduce one production host race with DEBUG_VM..  Normally debugging code
> would affect code execution already, and for this one we're enlarging that gap
> "explicitly" - not sure whether it's good.
> 
> This also makes me curious what if we make !DEBUG_VM strict too - how much perf
> we'll lose?  Haven't even tried to think about it with details, but just raise
> it up. Say, is there any chance we make the debug/non-debug paths run the same
> logic (e.g. of SYNC version)?

And Yang Shi suggests the same.

Yes, I'm not fond of doing that differently for DEBUG_VM or not;
but could never quite decide which way to jump.

For so long as we worry about whether split_huge_page() is working
correctly (and Wang Yugui still has a case that we have not solved),
we do want the warning; and for so long as we have the warning, we
do need the TTU_SYNC to prevent showing the warning unnecessarily.

How much overhead added by doing TTU_SYNC now on !DEBUG_VM?  On any
sensible anon THP case, I don't think it could add overhead at all.
But in some shmem cases (multiply mapped but sparsely populated,
populated differently by different tasks) it could add overhead:
dirtying lock cachelines in tasks which don't have the page mapped.

But we're only talking about huge page splitting, that should not
be #1 on anyone's performance list; and has all sorts of other
overheads of its own.  I think I'll go with your preference, and
make this TTU_SYNC for all.  We can easily revert to DEBUG_VM only
if some regression is noticed.

Hugh
