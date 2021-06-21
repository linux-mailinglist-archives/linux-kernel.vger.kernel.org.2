Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62F33AED5E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFUQTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230367AbhFUQTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624292225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lxNM0QUCMLo1E6bAwNt8D/Sfkwf585U1gKeMbqY/jk=;
        b=Z6/LIlNtumsr3gIVaIpIBiKYj9oegPRSRfkwTKvCR5u8hrc2VE0hHuiKnoT0lLu2Wg765P
        lDNlSJoDPuC5DqDDe3wkkZ9Soa/qs7ie2svhYK2uqcD3Zcj9RwNLMnIl1DLdWxxa5dKbuK
        T40oFiMHJmhSIkUgsJOpId8Sbsa4gNI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-Q_vQb9dNN5uuiXanQ53f_g-1; Mon, 21 Jun 2021 12:16:53 -0400
X-MC-Unique: Q_vQb9dNN5uuiXanQ53f_g-1
Received: by mail-qv1-f71.google.com with SMTP id ez18-20020ad459120000b029020e62abfcbdso5911764qvb.16
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1lxNM0QUCMLo1E6bAwNt8D/Sfkwf585U1gKeMbqY/jk=;
        b=OGxCCNcQLZJjzYDTX935Tlsy6NkWoKF2cc9aEZU0yVnElvlNt0awKciKttv6YBZD0/
         JxUHma6WminKmzIFuM40WMKA0/UxL/AeJi3jGJvU5u/FL8iGtdqeT8Ov2s6yLTuWyDmk
         72vRNBvcI5AjxutigJJK7jWGTXOQseMGeVywKbRQoYwB4hkUe1MFmx5KMuM+9LWvH8nG
         2bFI7nmmi7YOIjwxd7Vk9oNNL/WS4Kgv0Wu8EkGQbeYY99O+g+yGImbnMQZUwY0qfBRy
         XhosThEZWi/2dL2UPUAwWFVnBn3LvSTQh5ph7zlE8z0wG/vPJ3ibq5m4D7xWua+ttdHj
         JUXQ==
X-Gm-Message-State: AOAM533v3aV0kw/471UpFWk44bDrXLpRzL9ACBmTQwjQh+GvKqXE67ae
        tbiJgugV9QJlqhGMg+AWFqdYWJOiF73OBK3YjmIjzZQmLasQ6ApJFPhCQrvOtTv4VMLg2/FJ9T1
        PE1dMANUTZZ0K8blO0/8fMFjg
X-Received: by 2002:a05:6214:2a8a:: with SMTP id jr10mr21094079qvb.50.1624292212835;
        Mon, 21 Jun 2021 09:16:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyr8NyDm41sDPcWGbbW3nH7HmA5CPGjpBNBrdzq7EcUuinbByU3GhTpe5HQQ9rYId+u5U//BA==
X-Received: by 2002:a05:6214:2a8a:: with SMTP id jr10mr21094050qvb.50.1624292212565;
        Mon, 21 Jun 2021 09:16:52 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id f11sm10131487qka.55.2021.06.21.09.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:16:52 -0700 (PDT)
Date:   Mon, 21 Jun 2021 12:16:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 08/27] mm: Introduce zap_details.zap_flags
Message-ID: <YNC7csnnSWXz6xvJ@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <20210527202130.30840-1-peterx@redhat.com>
 <5845701.Ud2vPSPtVx@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5845701.Ud2vPSPtVx@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 10:09:00PM +1000, Alistair Popple wrote:
> On Friday, 28 May 2021 6:21:30 AM AEST Peter Xu wrote:
> > Instead of trying to introduce one variable for every new zap_details fields,
> > let's introduce a flag so that it can start to encode true/false informations.
> > 
> > Let's start to use this flag first to clean up the only check_mapping variable.
> > Firstly, the name "check_mapping" implies this is a "boolean", but actually it
> > stores the mapping inside, just in a way that it won't be set if we don't want
> > to check the mapping.
> > 
> > To make things clearer, introduce the 1st zap flag ZAP_FLAG_CHECK_MAPPING, so
> > that we only check against the mapping if this bit set.  At the same time, we
> > can rename check_mapping into zap_mapping and set it always.
> > 
> > Since at it, introduce another helper zap_check_mapping_skip() and use it in
> > zap_pte_range() properly.
> > 
> > Some old comments have been removed in zap_pte_range() because they're
> > duplicated, and since now we're with ZAP_FLAG_CHECK_MAPPING flag, it'll be very
> > easy to grep this information by simply grepping the flag.
> > 
> > It'll also make life easier when we want to e.g. pass in zap_flags into the
> > callers like unmap_mapping_pages() (instead of adding new booleans besides the
> > even_cows parameter).
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/mm.h | 19 ++++++++++++++++++-
> >  mm/memory.c        | 31 ++++++++-----------------------
> >  2 files changed, 26 insertions(+), 24 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index db155be8e66c..52d3ef2ed753 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1721,13 +1721,30 @@ static inline bool can_do_mlock(void) { return false; }
> >  extern int user_shm_lock(size_t, struct user_struct *);
> >  extern void user_shm_unlock(size_t, struct user_struct *);
> >  
> > +/* Whether to check page->mapping when zapping */
> > +#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> > +
> >  /*
> >   * Parameter block passed down to zap_pte_range in exceptional cases.
> >   */
> >  struct zap_details {
> > -	struct address_space *check_mapping;	/* Check page->mapping if set */
> > +	struct address_space *zap_mapping;
> > +	unsigned long zap_flags;
> >  };
> >  
> > +/* Return true if skip zapping this page, false otherwise */
> > +static inline bool
> > +zap_check_mapping_skip(struct zap_details *details, struct page *page)
> > +{
> > +	if (!details || !page)
> > +		return false;
> > +
> > +	if (!(details->zap_flags & ZAP_FLAG_CHECK_MAPPING))
> > +		return false;

[1]

> > +
> > +	return details->zap_mapping != page_rmapping(page);
> 
> I doubt this matters in practice, but there is a slight behaviour change
> here that might be worth checking. Previously this check was equivalent
> to:
> 
> details->zap_mapping && details->zap_mapping != page_rmapping(page)

Yes; IMHO "details->zap_mapping" is just replaced by the check at [1].

For example, there's only one real user of this mapping check, which is
unmap_mapping_pages() below [2].

With the old code, we have:

    details.check_mapping = even_cows ? NULL : mapping;

So "details->zap_mapping" is only true if "!even_cows".

With the new code, we'll have:

    if (!even_cows)
        details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;

So ZAP_FLAG_CHECK_MAPPING is only set if "!even_cows", while that's what we
check exactly at [1].

> 
> Otherwise I think this looks good.
> 
> > +}
> > +
> >  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> >  			     pte_t pte);
> >  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 27cf8a6375c6..c9dc4e9e05b5 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1330,16 +1330,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  			struct page *page;
> >  
> >  			page = vm_normal_page(vma, addr, ptent);
> > -			if (unlikely(details) && page) {
> > -				/*
> > -				 * unmap_shared_mapping_pages() wants to
> > -				 * invalidate cache without truncating:
> > -				 * unmap shared but keep private pages.
> > -				 */
> > -				if (details->check_mapping &&
> > -				    details->check_mapping != page_rmapping(page))
> > -					continue;
> > -			}
> > +			if (unlikely(zap_check_mapping_skip(details, page)))
> > +				continue;
> >  			ptent = ptep_get_and_clear_full(mm, addr, pte,
> >  							tlb->fullmm);
> >  			tlb_remove_tlb_entry(tlb, pte, addr);
> > @@ -1372,17 +1364,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  		    is_device_exclusive_entry(entry)) {
> >  			struct page *page = pfn_swap_entry_to_page(entry);
> >  
> > -			if (unlikely(details && details->check_mapping)) {
> > -				/*
> > -				 * unmap_shared_mapping_pages() wants to
> > -				 * invalidate cache without truncating:
> > -				 * unmap shared but keep private pages.
> > -				 */
> > -				if (details->check_mapping !=
> > -				    page_rmapping(page))
> > -					continue;
> > -			}
> > -
> > +			if (unlikely(zap_check_mapping_skip(details, page)))
> > +				continue;
> >  			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> >  			rss[mm_counter(page)]--;
> >  
> > @@ -3345,9 +3328,11 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
> >  		pgoff_t nr, bool even_cows)
> >  {
> >  	pgoff_t	first_index = start, last_index = start + nr - 1;
> > -	struct zap_details details = { };
> > +	struct zap_details details = { .zap_mapping = mapping };
> > +
> > +	if (!even_cows)
> > +		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
> >  
> > -	details.check_mapping = even_cows ? NULL : mapping;

[2]

> >  	if (last_index < first_index)
> >  		last_index = ULONG_MAX;

Thanks,

-- 
Peter Xu

