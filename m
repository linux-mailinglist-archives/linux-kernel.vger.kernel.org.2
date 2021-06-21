Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538253AEEA0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhFUQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231560AbhFUQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624292787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qKkXwwbllZu80vSnXLRPT1a/f0c84KqiWlFVpCbhJxY=;
        b=UmmK836w5boPLuuQMUF7G7813hx61oqq1nH1E0khFE8d38W+tLIzAq7RROHmGWtTwR9lOR
        MwwR2JK8GfUdVj8i8jt/+cEJM3XXMxqsSLstjGCXlecBYhFI78fKFBojUJDfr1EiJ5/UQb
        7nl9yTCxXRfZS6lPA1ADjq2grRn7uok=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-pwIPlAUAMFCnx4imSQylHA-1; Mon, 21 Jun 2021 12:26:25 -0400
X-MC-Unique: pwIPlAUAMFCnx4imSQylHA-1
Received: by mail-qk1-f199.google.com with SMTP id 142-20020a370d940000b02903b12767b75aso10857938qkn.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qKkXwwbllZu80vSnXLRPT1a/f0c84KqiWlFVpCbhJxY=;
        b=d7T/vW/EziZT0PPbRVBggUPhq7RcWfiNN6WDU1fnMy5BLfeQkMfHOvEQrliMitCryE
         bZHRsVDRM/x7LvWlwvSV1hdplnXmScqv0Ficvvt1H88L6kWS0Y0pq2/nqOhba3mbkPXo
         oeB9aZLwgM8R0tU9Mq17tD5zHp2kLYqJIlrpRcmiBAABH08Mzf3SFTe0DYbV6np1w0eN
         VC7MTkxM7+ApqJb//Ijb8sHsMYZqTN++3WQpHqpElCImeqNE8ovBarT69wWmM52kmg3w
         iRKVfs9uHGPp2fYoL8SUmOkoW9h59MY+dnKEma72AT1sLUImREUW40QaBO4MDX4DmEPz
         ea/Q==
X-Gm-Message-State: AOAM531IphJOZyo1hIrX58/UeCGN8kLP6OThRUjQy5rzq9I0HGkNGQhU
        GMmPWdSLaFLmwmnP0ps8ZnmplQu9LuFbDphSj8gx3/rmGuS/cPnhR7r0CiD6W9nLXNhOPgegWOG
        IO++8AWCg5EAeEwIiCL1qIabr
X-Received: by 2002:a05:620a:1110:: with SMTP id o16mr7164919qkk.399.1624292785454;
        Mon, 21 Jun 2021 09:26:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1QuLceinHpKjxVIKV/JvwK80nF6xWCGlZeAZS11VKaUOqogtDOaDzT6YcNUxlHXRdr83iIg==
X-Received: by 2002:a05:620a:1110:: with SMTP id o16mr7164888qkk.399.1624292785239;
        Mon, 21 Jun 2021 09:26:25 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id i19sm4271115qkk.45.2021.06.21.09.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:26:24 -0700 (PDT)
Date:   Mon, 21 Jun 2021 12:26:23 -0400
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
Subject: Re: [PATCH v3 09/27] mm: Introduce ZAP_FLAG_SKIP_SWAP
Message-ID: <YNC9r7Vvf+pdX2t5@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <20210527202135.30890-1-peterx@redhat.com>
 <5565576.ugXqPVlkE4@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5565576.ugXqPVlkE4@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 10:36:46PM +1000, Alistair Popple wrote:
> On Friday, 28 May 2021 6:21:35 AM AEST Peter Xu wrote:
> > Firstly, the comment in zap_pte_range() is misleading because it checks against
> > details rather than check_mappings, so it's against what the code did.
> > 
> > Meanwhile, it's confusing too on not explaining why passing in the details
> > pointer would mean to skip all swap entries.  New user of zap_details could
> > very possibly miss this fact if they don't read deep until zap_pte_range()
> > because there's no comment at zap_details talking about it at all, so swap
> > entries could be errornously skipped without being noticed.
> > 
> > This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
> > but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
> > "details" parameter: the caller should explicitly set this to skip swap
> > entries, otherwise swap entries will always be considered (which is still the
> > major case here).
> > 
> > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/mm.h | 12 ++++++++++++
> >  mm/memory.c        |  8 +++++---
> >  2 files changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 52d3ef2ed753..1adf313a01fe 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1723,6 +1723,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
> >  
> >  /* Whether to check page->mapping when zapping */
> >  #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> > +/* Whether to skip zapping swap entries */
> > +#define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
> >  
> >  /*
> >   * Parameter block passed down to zap_pte_range in exceptional cases.
> > @@ -1745,6 +1747,16 @@ zap_check_mapping_skip(struct zap_details *details, struct page *page)
> >  	return details->zap_mapping != page_rmapping(page);
> >  }
> >  
> > +/* Return true if skip swap entries, false otherwise */
> > +static inline bool
> > +zap_skip_swap(struct zap_details *details)
> 
> Minor nit-pick but imho it would be nice if the naming was consistent between
> this and check mapping. Ie. zap_skip_swap()/zap_skip_check_mapping() or
> zap_swap_skip()/zap_check_mapping_skip().

Makes sense; I'll use zap_skip_swap()/zap_skip_check_mapping() I think, then I
keep this patch untouched.

> 
> > +{
> > +	if (!details)
> > +		return false;
> > +
> > +	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
> > +}
> > +
> >  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> >  			     pte_t pte);
> >  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > diff --git a/mm/memory.c b/mm/memory.c
> > index c9dc4e9e05b5..8a3751be87ba 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1376,8 +1376,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  			continue;
> >  		}
> >  
> > -		/* If details->check_mapping, we leave swap entries. */
> > -		if (unlikely(details))
> > +		if (unlikely(zap_skip_swap(details)))
> >  			continue;
> >  
> >  		if (!non_swap_entry(entry))
> > @@ -3328,7 +3327,10 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
> >  		pgoff_t nr, bool even_cows)
> >  {
> >  	pgoff_t	first_index = start, last_index = start + nr - 1;
> > -	struct zap_details details = { .zap_mapping = mapping };
> > +	struct zap_details details = {
> > +		.zap_mapping = mapping,
> 
> I meant to comment on this in the previous patch, but it might be nice to set
> .zap_mapping in the !even_cows case below to make it very obvious it only
> applies to ZAP_FLAG_CHECK_MAPPING.

I wanted to make it easy to understand by having zap_mapping always points to
the mapping it's zapping, so it does not contain any other information like
"whether we want to check the mapping is the same when zap", which now stays
fully in the flags. Then it's always legal to reference zap_mapping without any
prior knowledge.  But indeed it's only used by ZAP_FLAG_CHECK_MAPPING.

I do have a slight preference to keep it as the patch does, but I don't have a
strong opinion.  Let me know if you insist; I can change.

> 
> Otherwise I think this is a good clean up which makes things clearer. I double
> checked that unmap_mapping_pages() was the only place in the existing code that
> needs ZAP_FLAG_SKIP_SWAP and that appears to be the case so there shouldn't be
> any behaviour changes from this.
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Since I won't change anything within this patch, I'll take this away, thanks!

-- 
Peter Xu

