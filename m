Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4142A394342
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhE1NNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235297AbhE1NNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622207491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FW9/4jT9qjw9qNpmMNMU5+vfx14NmLdS+jsCbfo2ekM=;
        b=i6h3zNjSkp9JbHxwZD7xaFbiOHLF5Bjt69NeKZ5pL1dLwZMcwpSls+zkZpYpEzicog9Unq
        Q+u0WXuMkCAE8V999MvvDe5CWIC+4zw5YomSlWOfwuCm7thIm8rwh1k+HMKg4AEWRU6s++
        VdbvEOq5EgA5aZQEQbbzAB7WxM9voy0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-bjlAp-_DNvu1VoARdpJHHw-1; Fri, 28 May 2021 09:11:28 -0400
X-MC-Unique: bjlAp-_DNvu1VoARdpJHHw-1
Received: by mail-qt1-f199.google.com with SMTP id b17-20020ac854110000b02901f279c73d75so2141724qtq.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FW9/4jT9qjw9qNpmMNMU5+vfx14NmLdS+jsCbfo2ekM=;
        b=sv9NGWC4tyG93clilRTLSIzd4v+l1GwH5DGmaPXjj8hpmMsA2Rab/4G5LDHjYwqdHC
         qIfZTqoTP9rRRJiAQXm0NikU+MU4urCoUgdf+8f8v66DeeLc2yshrlanVlhVfRboWaPo
         YlJagWmsjJgCdH5qGEqOolezjK2/23bXd5ftweEIf6zKat/NPM/SGw2el/y3chQVeTqv
         oHnkfhIIXaGntOnVMh5NfT9PU7zB+Z+RBOe0gq23WiwF9TIA6m2MdM7NgMQc1xYjOVYU
         VdWWX68RQn3lwluBoKuFjOaMwGNf9KA0H6+qxE/hxM8t/0hJ/68xr8ABB4B+R2iQCdpD
         Oxew==
X-Gm-Message-State: AOAM532ZlXg7ERdtwOPsz8t1LP3p2NK+ULxLXhiDpwAYM0rmy062vYDL
        0sMpAwphtrY02gBY6A1NacZo73GUY6MehBDxKe8wQEJTxI/rsdL35C6cx912bUNHcaBKSLcDnng
        sJKSwXEL4UWQArCpPmrwzOdPW
X-Received: by 2002:a05:6214:8f2:: with SMTP id dr18mr3830642qvb.25.1622207487813;
        Fri, 28 May 2021 06:11:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeO8jD8WA5p6Lyazpu9mOUIrqsQpzhE1ohGBKpqpJPFBu0QqiibLIgKj2MM0bzxmuiSjk/GA==
X-Received: by 2002:a05:6214:8f2:: with SMTP id dr18mr3830596qvb.25.1622207487542;
        Fri, 28 May 2021 06:11:27 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id t137sm3473526qke.50.2021.05.28.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 06:11:26 -0700 (PDT)
Date:   Fri, 28 May 2021 09:11:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        nouveau@lists.freedesktop.org, bskeggs@redhat.com,
        rcampbell@nvidia.com, linux-doc@vger.kernel.org,
        jhubbard@nvidia.com, bsingharora@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@infradead.org, jglisse@redhat.com, willy@infradead.org,
        jgg@nvidia.com, hughd@google.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 07/10] mm: Device exclusive memory access
Message-ID: <YLDr/RyAdUR4q0kk@t490s>
References: <20210524132725.12697-1-apopple@nvidia.com>
 <37725705.JvxlXkkoz5@nvdebian>
 <YK+Y+aAZHDv8+w+Q@t490s>
 <2243324.CkbYuGXDfH@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2243324.CkbYuGXDfH@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 11:48:40AM +1000, Alistair Popple wrote:

[...]

> > > > > +     while (page_vma_mapped_walk(&pvmw)) {
> > > > > +             /* Unexpected PMD-mapped THP? */
> > > > > +             VM_BUG_ON_PAGE(!pvmw.pte, page);
> > > > > +
> > > > > +             if (!pte_present(*pvmw.pte)) {
> > > > > +                     ret = false;
> > > > > +                     page_vma_mapped_walk_done(&pvmw);
> > > > > +                     break;
> > > > > +             }
> > > > > +
> > > > > +             subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
> > > > 
> > > > I see that all pages passed in should be done after FOLL_SPLIT_PMD, so
> > > > is
> > > > this needed?  Or say, should subpage==page always be true?
> > > 
> > > Not always, in the case of a thp there are small ptes which will get
> > > device
> > > exclusive entries.
> > 
> > FOLL_SPLIT_PMD will first split the huge thp into smaller pages, then do
> > follow_page_pte() on them (in follow_pmd_mask):
> > 
> >         if (flags & FOLL_SPLIT_PMD) {
> >                 int ret;
> >                 page = pmd_page(*pmd);
> >                 if (is_huge_zero_page(page)) {
> >                         spin_unlock(ptl);
> >                         ret = 0;
> >                         split_huge_pmd(vma, pmd, address);
> >                         if (pmd_trans_unstable(pmd))
> >                                 ret = -EBUSY;
> >                 } else {
> >                         spin_unlock(ptl);
> >                         split_huge_pmd(vma, pmd, address);
> >                         ret = pte_alloc(mm, pmd) ? -ENOMEM : 0;
> >                 }
> > 
> >                 return ret ? ERR_PTR(ret) :
> >                         follow_page_pte(vma, address, pmd, flags,
> > &ctx->pgmap); }
> > 
> > So I thought all pages are small pages?
> 
> The page will remain as a transparent huge page though (at least as I 
> understand things). FOLL_SPLIT_PMD turns it into a pte mapped thp by splitting 
> the pmd and creating pte's mapping the subpages but doesn't split the page 
> itself. For comparison FOLL_SPLIT (which has been removed in v5.13 due to lack 
> of use) is what would be used to split the page in the above GUP code by 
> calling split_huge_page() rather than split_huge_pmd().

But shouldn't FOLL_SPLIT_PMD filled in small pfns for each pte?  See
__split_huge_pmd_locked():

	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
                ...
		} else {
			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
                        ...
		}
                ...
		set_pte_at(mm, addr, pte, entry);
        }

Then iiuc the coming follow_page_pte() will directly fetch the small pages?

-- 
Peter Xu

