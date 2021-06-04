Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271C639BC79
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhFDQDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231213AbhFDQDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622822523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RDgsuICsJTACzPoWFbnkh7BYX0jKRdVUUGWOxYyPhY0=;
        b=JQl02C0V15iHZ12D8yTXwLhD3lhekMdkSnsAs7K7R1mVe7v24fLyktIlB+WQdSn3DTgT+n
        i6XFJCWrjwvnrz3MaUMWPhFxC20qaQlggWTzPUm5xhiDp76OOlJ7v5PhcCyl4jLpLIE48T
        RZYL/9TVG+BmFPw2wa6YQg6GJA0Wupk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-MWGPt1pmMEy2m-DzCjC8iQ-1; Fri, 04 Jun 2021 12:02:01 -0400
X-MC-Unique: MWGPt1pmMEy2m-DzCjC8iQ-1
Received: by mail-qv1-f70.google.com with SMTP id f18-20020a0cbed20000b029021ef79a8921so4765046qvj.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RDgsuICsJTACzPoWFbnkh7BYX0jKRdVUUGWOxYyPhY0=;
        b=Xgt8nLYK/QDHXaFXxd8TUbGa8ukPezho6D4lgL77raMhWR8/9lAVyvPLDvQsVvfELR
         mnbXTJ5DGOzEKqOvC1pRN1S41uzHrrKir1pc6FPGEmYKOgSt7LAUdD8wBenCnXuqtUnx
         3zjj+DFdGn6VKlhzIytuxnGe782y8Fu6VUiT5dQ8DG0e3A/nPrLemlDt4xnkY6AaGgAr
         WF9YLP7HhlClyBZcAfDNqhQP4HBWSoCNKbX31JoPSJr68b2zTUvcO920isV+Nyb1r7Jl
         L0h3suh4K1Y7BeRho4YzFxUj6c9p/M7K5Jk1XvPbJ8mS9XGuuZRQO4QpAIom93qh1HtJ
         YFNA==
X-Gm-Message-State: AOAM533Wcp1O7nzE8mVDYkFjMfYycuK2/WChDY8wX+5PhfXS4c+1I62+
        K+lJMlLRHd6froq7gVpFRaMuZQUdMfPZBlWENBCzBzh1/rC2q/2BmpqwNbgoSEsVSZadyQkn5Um
        DmSG/w3ugnOMzS/AKXAdNWAPR
X-Received: by 2002:a37:e205:: with SMTP id g5mr5154751qki.449.1622822521436;
        Fri, 04 Jun 2021 09:02:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1ecEgBicg8WczI1723MlWffMHmL+hd5u67XDnxq1zyBxl/dNa+udOMKx+w1p+T/+kjodlyA==
X-Received: by 2002:a37:e205:: with SMTP id g5mr5154724qki.449.1622822521195;
        Fri, 04 Jun 2021 09:02:01 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-61-184-147-118-108.dsl.bell.ca. [184.147.118.108])
        by smtp.gmail.com with ESMTPSA id d1sm3892682qti.72.2021.06.04.09.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:02:00 -0700 (PDT)
Date:   Fri, 4 Jun 2021 12:01:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/27] mm/userfaultfd: Introduce special pte for
 unmapped file-backed mem
Message-ID: <YLpOdxWnRbWx9CL+@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <1780227.rxkhHXaqZV@nvdebian>
 <alpine.LSU.2.11.2106031954570.12760@eggly.anvils>
 <2408831.NcqaVN92ti@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2408831.NcqaVN92ti@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 04:16:30PM +1000, Alistair Popple wrote:
> > My understanding is that it does *not* use an additional arch-dependent
> > bit, but puts the _PAGE_UFFD_WP bit (already set aside by any architecture
> > implementing UFFD WP) to an additional use.  That's why I called this
> > design (from Andrea) more elegant than mine (swap type business).
> 
> Oh my bad, I had somehow missed this was reusing an *existing* arch-dependent 
> swap bit (_PAGE_SWP_UFFD_WP, although the same argument could apply) even 
> though it's in the commit message. Obviously I should have read that more 
> carefully, apologies for the noise but thanks for the clarification.

Right, as Hugh mentioned what this series wanted to use is one explicit pte
that no one should ever be using, so ideally that should be the most saving way
per address-space pov.

Meanwhile I think that pte can actually be not related to _PAGE_UFFD_WP at all,
as long as it's a specific pte value then it will service the same goal (even
if to reuse a new swp type, I'll probably only use one pte for it and leave the
rest for other use; but who knows who will start to use the rest!).

I kept using it because that's suggested by Andrea (it actually has
type==off==0 as Hugh suggested too - so it keeps a suggestion of both!) and
it's a good idea to use it since (1) it's never used by anyone before, and (2)
it is _somehow_ related to uffd-wp itself already by having that specific bit
set in the special pte, while that's also the only bit set for the u64 field.

It looks very nice too when debug, because when I dump the ptes it reads 0x4 on
x86.. so the pte value is even easy to read as a number. :)

However I can see that it is less easy to follow than the swap type solution.
In all cases it's still something worth thinking about before using up the swap
types - it's not so rich there, and we keep shrinking MAX_SWAPFILES.. so let's
see whether uffd-wp could be the 1st one to open a new field for unused
"invalid/swap pte" address space.

Meanwhile, I did have a look at ARM on supporting uffd-wp in general, starting
from anonymous pages.  I doubt whether it can be done for old arms (uffd-wp not
even supported on 32bit x86 after all), but for ARM64 I see it has:

For normal ptes:

/*
 * Level 3 descriptor (PTE).
 */
#define PTE_VALID		(_AT(pteval_t, 1) << 0)
#define PTE_TYPE_MASK		(_AT(pteval_t, 3) << 0)
#define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
#define PTE_TABLE_BIT		(_AT(pteval_t, 1) << 1)
#define PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
#define PTE_RDONLY		(_AT(pteval_t, 1) << 7)		/* AP[2] */
#define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
#define PTE_AF			(_AT(pteval_t, 1) << 10)	/* Access Flag */
#define PTE_NG			(_AT(pteval_t, 1) << 11)	/* nG */
#define PTE_GP			(_AT(pteval_t, 1) << 50)	/* BTI guarded */
#define PTE_DBM			(_AT(pteval_t, 1) << 51)	/* Dirty Bit Management */
#define PTE_CONT		(_AT(pteval_t, 1) << 52)	/* Contiguous range */
#define PTE_PXN			(_AT(pteval_t, 1) << 53)	/* Privileged XN */
#define PTE_UXN			(_AT(pteval_t, 1) << 54)	/* User XN */

For swap ptes:

/*
 * Encode and decode a swap entry:
 *	bits 0-1:	present (must be zero)
 *	bits 2-7:	swap type
 *	bits 8-57:	swap offset
 *	bit  58:	PTE_PROT_NONE (must be zero)
 */

So I feel like we still have chance there at least for 64bit ARM? As both
normal/swap ptes have some bits free (bits 2-5,9 for normal ptes; bits 59-63
for swap ptes).  But as I know little on ARM64, I hope I looked at the right
things..

Thanks,

-- 
Peter Xu

