Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7896E39BB1A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFDOug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229656AbhFDOud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622818126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jp1+wVSB+7vvWzgBMXFHA8qcBIuZi+O0ew+V7NeqdBE=;
        b=Kv8VkCjzf0fqi2PR7/UwtesqbWeIHMwljPqPBIxj6cW7YjxKuUJfQl4wkYtUrAVGTnp2Ie
        pOFruiA57L+r8+dOHtX7oxFJSWUYAXeS55iC1hbquxyHQ2kWqLlTkYmSwZd+LifMMkL9zu
        XREJFUWIHnuE9dkiTT+80UfS4lvN0mU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-TFw1viItPCSwN4VC1TE5iw-1; Fri, 04 Jun 2021 10:48:40 -0400
X-MC-Unique: TFw1viItPCSwN4VC1TE5iw-1
Received: by mail-qt1-f200.google.com with SMTP id q3-20020a05622a0303b02902390ac8c906so5306261qtw.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 07:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jp1+wVSB+7vvWzgBMXFHA8qcBIuZi+O0ew+V7NeqdBE=;
        b=q24MAud7MiP0cZHZuYTTfPUope2wT/Ufeu+heNN0AaQxMz7ZZpAMHdm/6ZEwzdi6GC
         fusoEoIsqY2x9X/0apPotohWQd24oTjf8oYc2HLewZ5vHggH/eSCDiybHolcCiQGhzzy
         QMfJVmX68PxvxN2qgDmyEUfPKx+xIIBjWI1GWjPu2rDD3hSaJkl741a/3KDhj3OIZqbs
         HKhmlZSooDRZc7Y8XKI+hpwRqqdmAdmCp66qpbBeeLVVMOAS0+ApN2OCafDtVE43/gyu
         oTDt9oN5w86mSi2l0lpwwQckx0MLopgnLdChF1QZFRC7DN+rluldB/5qcjDZ/wKL5AK9
         OUmA==
X-Gm-Message-State: AOAM530W7lSMvLvqM6boEgeePBHUYvOGDvUYxyFvhzOp4zofpPozA3L3
        u1ucxWB8I69710BHJHFRM1R8F5VqVQWnAA2LJVpoUX0P9Ar0G2mZXzkx55VfA5bJnUfjLetbq1C
        /zXEnRj6NgfTT9qg2caGWTQ9Q
X-Received: by 2002:ac8:5a44:: with SMTP id o4mr4892958qta.189.1622818119988;
        Fri, 04 Jun 2021 07:48:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsTsGcW0ow0eBZ3bFuOemTwfuhys1mG+/ypvjMRj/HwVPu8NxHqgNg+Df85d1TH9IvofYboQ==
X-Received: by 2002:ac8:5a44:: with SMTP id o4mr4892931qta.189.1622818119759;
        Fri, 04 Jun 2021 07:48:39 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-61-184-147-118-108.dsl.bell.ca. [184.147.118.108])
        by smtp.gmail.com with ESMTPSA id 85sm4038779qko.14.2021.06.04.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:48:38 -0700 (PDT)
Date:   Fri, 4 Jun 2021 10:48:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 2/7] mm/thp: try_to_unmap() use TTU_SYNC for safe
 DEBUG_VM splitting
Message-ID: <YLo9RZOrCrp/1f4D@t490s>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011405510.2148@eggly.anvils>
 <YLlOPoP/rIRMm2U5@t490s>
 <alpine.LSU.2.11.2106031945280.12760@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106031945280.12760@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 07:54:11PM -0700, Hugh Dickins wrote:
> On Thu, 3 Jun 2021, Peter Xu wrote:
> > On Tue, Jun 01, 2021 at 02:07:53PM -0700, Hugh Dickins wrote:
> > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > index 2cf01d933f13..b45d22738b45 100644
> > > --- a/mm/page_vma_mapped.c
> > > +++ b/mm/page_vma_mapped.c
> > > @@ -212,6 +212,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > >  			pvmw->ptl = NULL;
> > >  		}
> > >  	} else if (!pmd_present(pmde)) {
> > > +		/*
> > > +		 * If PVMW_SYNC, take and drop THP pmd lock so that we
> > > +		 * cannot return prematurely, while zap_huge_pmd() has
> > > +		 * cleared *pmd but not decremented compound_mapcount().
> > > +		 */
> > > +		if ((pvmw->flags & PVMW_SYNC) &&
> > > +		    PageTransCompound(pvmw->page))
> > > +			spin_unlock(pmd_lock(mm, pvmw->pmd));
> > >  		return false;
> > >  	}
> > >  	if (!map_pte(pvmw))
> > 
> > Sorry if I missed something important, but I'm totally confused on how this
> > unlock is pairing with another lock()..
> 
> I imagine you're reading that as spin_unlock(pmd_lockptr(blah));
> no, the lock is right there, inside spin_unlock(pmd_lock(blah)).

Heh, yeah... Sorry about that.

> 
> > 
> > And.. isn't PVMW_SYNC only meaningful for pte-level only (as I didn't see a
> > reference of it outside map_pte)?
> 
> But you are pointing directly to its reference outside map_pte()!

Right, I was trying to look for the lock() so I needed to look at all the rest
besides this one. :)

I didn't follow Yang's patch, but if Yang's patch can make kernel not crashing
and fault handling done all well, then I'm kind of agree with him: having
workaround code (like taking lock and quickly releasing..) only for debug code
seems an overkill to me, not to mention that the debug code will be even more
strict after this patch, as it means it's even less likely that one can
reproduce one production host race with DEBUG_VM..  Normally debugging code
would affect code execution already, and for this one we're enlarging that gap
"explicitly" - not sure whether it's good.

This also makes me curious what if we make !DEBUG_VM strict too - how much perf
we'll lose?  Haven't even tried to think about it with details, but just raise
it up. Say, is there any chance we make the debug/non-debug paths run the same
logic (e.g. of SYNC version)?

-- 
Peter Xu

