Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D13BDA49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhGFPiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 11:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231758AbhGFPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625585722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a4kZkm/ribAVqSEiHP5Q3y5RoHp90rtHpwlN5Wsac70=;
        b=JTEbFPzlXVeCoi6aspMomWWTBp9NdfONZs/nD2Ap8ZEyvQH44vil3oYI4tED/f6zKU5KQQ
        gJnY9y+zJlyx/oZSiMjkDkX4XoGrE9vgtn6yBd2YnzUxazfN9jCcsasZB8Ad40Nwq7saYc
        Lsw5JXDz+O1nk2ghD+QzPsevC2noqes=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-4NK2BPy7O4mBqoBC--Zpew-1; Tue, 06 Jul 2021 11:35:21 -0400
X-MC-Unique: 4NK2BPy7O4mBqoBC--Zpew-1
Received: by mail-qt1-f199.google.com with SMTP id w3-20020ac80ec30000b029024e8c2383c1so11416021qti.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 08:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a4kZkm/ribAVqSEiHP5Q3y5RoHp90rtHpwlN5Wsac70=;
        b=JpLtluH1ufx6E3lDpqz5PPYrRLKYH8fxcIFEGd7Vx7R9WiD3F2LqIH5dcjppi2vGyu
         P1v33uUPFBHl+F1B661Few1VRss0XKwdMfWhxT+CLPEucXpH7684mchuYqbB/CjsAOtj
         jmetWuGhTFAMkyNWxZIhOcuAiQKiDvlf94GxnDthc6q3RypYfSdS1X5GeAV8rZbQ/TqT
         YNjlZVKP91xrvHxeutWWRBXPOGXmGL0gDmYhKKBaxgOPZljiiIxXc6XvxHCFslH2QuHb
         OtbaPr7AIUiFlbTFvA3PwZSCLgsTM7Jg8mt2HjseThxjTBL4AM/IamVzv+gtFKTLdqW1
         AfZg==
X-Gm-Message-State: AOAM531XkU5jlENockB2Df8HuMslwsaDUqZhfBCqWIP/2WXOAOBXdbOu
        s1/tgBcMWoZD+0GrFjNDv4IQAszxvBnlgrtv1d6RCO6wMX8EZwHU1vS96M9Qmgce/FHotbSRB2r
        Mpv1TdIXaRJwKI4w+kCc9GMaD
X-Received: by 2002:a05:620a:e12:: with SMTP id y18mr20545977qkm.106.1625585720614;
        Tue, 06 Jul 2021 08:35:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB4JKFnwADX60ygqTprBfwDVLYXpYH+ZxF66dtAY5XI/X045YlM3wUSG8UVrmeoCjQO46t8w==
X-Received: by 2002:a05:620a:e12:: with SMTP id y18mr20545942qkm.106.1625585720300;
        Tue, 06 Jul 2021 08:35:20 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id l5sm7026642qkb.62.2021.07.06.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:35:19 -0700 (PDT)
Date:   Tue, 6 Jul 2021 11:35:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 11/27] shmem/userfaultfd: Persist uffd-wp bit across
 zapping for file-backed
Message-ID: <YOR4NmRmk54ULkkp@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <1857347.At2d1zFpmm@nvdebian>
 <YNNTzau6cjx6UGDk@t490s>
 <3895609.yFXQBJUcoq@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3895609.yFXQBJUcoq@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 03:40:42PM +1000, Alistair Popple wrote:
> > > > > > > >  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> > > > > > > >  			     pte_t pte);
> > > > > > > >  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > > > > > > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > > > > > > index 355ea1ee32bd..c29a6ef3a642 100644
> > > > > > > > --- a/include/linux/mm_inline.h
> > > > > > > > +++ b/include/linux/mm_inline.h
> > > > > > > > @@ -4,6 +4,8 @@
> > > > > > > >  
> > > > > > > >  #include <linux/huge_mm.h>
> > > > > > > >  #include <linux/swap.h>
> > > > > > > > +#include <linux/userfaultfd_k.h>
> > > > > > > > +#include <linux/swapops.h>
> > > > > > > >  
> > > > > > > >  /**
> > > > > > > >   * page_is_file_lru - should the page be on a file LRU or anon LRU?
> > > > > > > > @@ -104,4 +106,45 @@ static __always_inline void del_page_from_lru_list(struct page *page,
> > > > > > > >  	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
> > > > > > > >  			-thp_nr_pages(page));
> > > > > > > >  }
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > > + * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
> > > > > > > > + * replace a none pte.  NOTE!  This should only be called when *pte is already
> > > > > > > > + * cleared so we will never accidentally replace something valuable.  Meanwhile
> > > > > > > > + * none pte also means we are not demoting the pte so if tlb flushed then we
> > > > > > > > + * don't need to do it again; otherwise if tlb flush is postponed then it's
> > > > > > > > + * even better.
> > > > > > > > + *
> > > > > > > > + * Must be called with pgtable lock held.
> > > > > > > > + */
> > > > > > > > +static inline void
> > > > > > > > +pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
> > > > > > > > +			      pte_t *pte, pte_t pteval)
> > > > > > > > +{
> > > > > > > > +#ifdef CONFIG_USERFAULTFD
> > > > > > > > +	bool arm_uffd_pte = false;
> > > > > > > > +
> > > > > > > > +	/* The current status of the pte should be "cleared" before calling */
> > > > > > > > +	WARN_ON_ONCE(!pte_none(*pte));
> > > > > > > > +
> > > > > > > > +	if (vma_is_anonymous(vma))
> > > > > > > > +		return;
> > > > > > > > +
> > > > > > > > +	/* A uffd-wp wr-protected normal pte */
> > > > > > > > +	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
> > > > > > > > +		arm_uffd_pte = true;
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * A uffd-wp wr-protected swap pte.  Note: this should even work for
> > > > > > > > +	 * pte_swp_uffd_wp_special() too.
> > > > > > > > +	 */
> > > > > > > 
> > > > > > > I'm probably missing something but when can we actually have this case and why
> > > > > > > would we want to leave a special pte behind? From what I can tell this is
> > > > > > > called from try_to_unmap_one() where this won't be true or from zap_pte_range()
> > > > > > > when not skipping swap pages.
> > > > > > 
> > > > > > Yes this is a good question..
> > > > > > 
> > > > > > Initially I made this function make sure I cover all forms of uffd-wp bit, that
> > > > > > contains both swap and present ptes; imho that's pretty safe.  However for
> > > > > > !anonymous cases we don't keep swap entry inside pte even if swapped out, as
> > > > > > they should reside in shmem page cache indeed.  The only missing piece seems to
> > > > > > be the device private entries as you also spotted below.
> > > > > 
> > > > > Yes, I think it's *probably* safe although I don't yet have a strong opinion
> > > > > here ...
> > > > > 
> > > > > > > > +	if (unlikely(is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)))
> > > > > 
> > > > > ... however if this can never happen would a WARN_ON() be better? It would also
> > > > > mean you could remove arm_uffd_pte.
> > > > 
> > > > Hmm, after a second thought I think we can't make it a WARN_ON_ONCE().. this
> > > > can still be useful for private mapping of shmem files: in that case we'll have
> > > > swap entry stored in pte not page cache, so after page reclaim it will contain
> > > > a valid swap entry, while it's still "!anonymous".

[1]

> > > 
> > > There's something (probably obvious) I must still be missing here. During
> > > reclaim won't a private shmem mapping still have a present pteval here?
> > > Therefore it won't trigger this case - the uffd wp bit is set when the swap
> > > entry is established further down in try_to_unmap_one() right?
> > 
> > I agree if it's at the point when it get reclaimed, however what if we zap a
> > pte of a page already got reclaimed?  It should have the swap pte installed,
> > imho, which will have "is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)"==true.
> 
> Apologies for the delay getting back to this, I hope to find some more time
> to look at this again this week.

No problem, please take your time on reviewing the series.

> 
> I guess what I am missing is why we care about a swap pte for a reclaimed page
> getting zapped. I thought that would imply the mapping was getting torn down,
> although I suppose in that case you still want the uffd-wp to apply in case a
> new mapping appears there?

For the torn down case it'll always have ZAP_FLAG_DROP_FILE_UFFD_WP set, so
pte_install_uffd_wp_if_needed() won't be called, as zap_drop_file_uffd_wp()
will return true:

static inline void
zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
			      unsigned long addr, pte_t *pte,
			      struct zap_details *details, pte_t pteval)
{
	if (zap_drop_file_uffd_wp(details))
		return;

	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
}

If you see it's non-trivial to fully digest all the caller stacks of it. What I
wanted to do with pte_install_uffd_wp_if_needed is simply to provide a helper
that can convert any form of uffd-wp ptes into a pte marker before being set as
none pte.  Since uffd-wp can exist in two forms (either present, or swap), then
cover all these two forms (and for swap form also cover the uffd-wp special pte
itself) is very clear idea and easy to understand to me.  I don't even need to
worry about who is calling it, and which case can be swap pte, which case must
not - we just call it when we want to persist the uffd-wp bit (after a pte got
cleared).  That's why in all cases I still prefer to keep it as is, as it just
makes things straightforward to me.

Thanks,

-- 
Peter Xu

