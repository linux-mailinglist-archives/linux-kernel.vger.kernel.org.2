Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079CE4031F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244682AbhIHAoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhIHAoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631061795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dmVzBjVacbNmPCi8K+Po+kbIXEQdRx5SLN91yaB+v4A=;
        b=VRuODBURNNxAs0jfb3xLd1VVQpScjro2igtSoDlbUB2JKNCL+HJXH9vLfwVyhIvMujXidq
        ivx/EhEuqmSPwSfJT4JX73Cm8/vfhQI391Pd6buMhux5/fVj0oZrSF2OIekxxnCJGXTA5c
        fDd2eCMO40ZSLXh7PLbfzmmiI2RnQhM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-S5nPZgJjNlioV1oSV_8TUw-1; Tue, 07 Sep 2021 20:43:14 -0400
X-MC-Unique: S5nPZgJjNlioV1oSV_8TUw-1
Received: by mail-qk1-f200.google.com with SMTP id 70-20020a370b49000000b003d2f5f0dcc6so944710qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 17:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dmVzBjVacbNmPCi8K+Po+kbIXEQdRx5SLN91yaB+v4A=;
        b=gEWMEYJm4b6U/l51SjSGo3AikotKku7jQtwcpf4DMBrsKOEsNmlLiL3LN0mKBQ53dy
         K9A9fJ8wdYTl9NrSMTwZ5iEWhvtgDT2mUFEefiGdsDbJdejNosDO9AsgKYQcXhN5Mxmf
         H+hAaXBe2f91Vo9ApnCR4L8P8Ccw9uJsd8LHOHD7Ed8gUpGkWqHB4gFjQxBmjUuyrr12
         97B/xuPG2zwycWyJitMeWuyv2rCsRkwhZIL2jjwtYkxi9oQRjYU/WJtXlQYOWd+phsB4
         yoGTFwrAlKuND4/mat81Y+hIRhQ17+pjoXc3pqwSxrKXgwNlSYnvjrEDf+0h9lQlKeTK
         Otzw==
X-Gm-Message-State: AOAM533vx+SsrdehAR1S1Qhy0VRa+bYGi9nfL6ykheVXG9dpudnpeXAU
        rzEM+aE6aiAAQoUSkL9NgSPvkWN/IkmRiaT50OEAXjKZ0ga0CZb/f0W6yi5uGSYx2XTScfOYROW
        Xtna4ngXGTIk6jzxcKj+PleA9
X-Received: by 2002:a37:6d7:: with SMTP id 206mr1026333qkg.251.1631061793575;
        Tue, 07 Sep 2021 17:43:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzQ3LdxwdgLnAJnpBB6RNLoLM2zvGQzMql6sXI/lPCNdVVaY2yyz9rmAH7cQWSUQWuOeDfZw==
X-Received: by 2002:a37:6d7:: with SMTP id 206mr1026314qkg.251.1631061793298;
        Tue, 07 Sep 2021 17:43:13 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id 207sm539602qkh.45.2021.09.07.17.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 17:43:12 -0700 (PDT)
Date:   Tue, 7 Sep 2021 20:43:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 5/5] mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags
Message-ID: <YTgHH1dufzAkiOSa@t490s>
References: <20210902201721.52796-1-peterx@redhat.com>
 <20210902201836.53605-1-peterx@redhat.com>
 <ecd7c89e-da54-d08c-5085-88c2ee8cdfaf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecd7c89e-da54-d08c-5085-88c2ee8cdfaf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 09:25:51AM +0200, David Hildenbrand wrote:
> On 02.09.21 22:18, Peter Xu wrote:
> > Firstly, the comment in zap_pte_range() is misleading because it checks against
> > details rather than check_mappings, so it's against what the code did.
> > 
> > Meanwhile, it's confusing too on not explaining why passing in the details
> 
> s/on//
> 
> > pointer would mean to skip all swap entries.  New user of zap_details could
> > very possibly miss this fact if they don't read deep until zap_pte_range()
> > because there's no comment at zap_details talking about it at all, so swap
> > entries could be errornously skipped without being noticed.
> 
> s/errornously/erroneously/

Will fix, thanks.

> 
> > 
> > Actually very recently we introduced unmap_mapping_page() in 22061a1ffabd, I
> > think that should also look into swap entries.  Add a comment there.  IOW, this
> > patch will be a functional change to unmap_mapping_page() but hopefully in the
> > right way to do it.

I'll remove this paragraph, as explained elsewhere.

> > 
> > This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
> > but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
> > "details" parameter: the caller should explicitly set this to skip swap
> > entries, otherwise swap entries will always be considered (which should still
> > be the major case here).
> > 
> > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > Cc: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/linux/mm.h | 16 ++++++++++++++++
> >   mm/memory.c        |  6 +++---
> >   2 files changed, 19 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 81e402a5fbc9..a7bcdb2ec956 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1716,12 +1716,18 @@ static inline bool can_do_mlock(void) { return false; }
> >   extern int user_shm_lock(size_t, struct ucounts *);
> >   extern void user_shm_unlock(size_t, struct ucounts *);
> > +typedef unsigned int __bitwise zap_flags_t;
> > +
> > +/* Whether to skip zapping swap entries */
> > +#define  ZAP_FLAG_SKIP_SWAP  ((__force zap_flags_t) BIT(0))
> 
> Interestingly, this will also skip fake some swap entries (e.g., migration
> entries but not private/exclusive entries). Maybe extend that documentation
> a bit.
> 
> ... but, looking into zap_pmd_range(), we don't care about "details" when
> calling zap_huge_pmd(), which will zap pmd migration entries IIUC ... so
> it's really unclear to me what the flag (and current behavior) really is and
> what should be documented. Should we maybe really only care about "real"
> swap entries?

Indeed, I tried to look into it today and see why we wanted to skip swap
entries but I failed to figure it out easily - it goes back to the 1st git
commit of Linux.

Maybe there'll be some experienced developer who knows the history, but before
that I decided to just keep the behavior.

The final goal of mine is to make the code clean and also prepares for the
uffd-wp that will allow free-style use of "details" pointer, rather than have
an implicit hint on "skip swap entry" then it'll be enough for this patch.

> 
> Most probably I'm just missing something important.
> 
> > +
> >   /*
> >    * Parameter block passed down to zap_pte_range in exceptional cases.
> >    */
> >   struct zap_details {
> >   	struct address_space *zap_mapping;	/* Check page->mapping if set */
> >   	struct page *single_page;		/* Locked page to be unmapped */
> > +	zap_flags_t zap_flags;			/* Extra flags for zapping */
> >   };
> >   /*
> > @@ -1737,6 +1743,16 @@ zap_skip_check_mapping(struct zap_details *details, struct page *page)
> >   	return details->zap_mapping != page_rmapping(page);
> >   }
> > +/* Return true if skip swap entries, false otherwise */
> > +static inline bool
> > +zap_skip_swap(struct zap_details *details)
> > +{
> > +	if (!details)
> > +		return false;
> > +
> > +	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
> > +}
> > +
> >   struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> >   			     pte_t pte);
> >   struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > diff --git a/mm/memory.c b/mm/memory.c
> > index e5ee8399d270..4cb269ca8249 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1379,8 +1379,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >   			continue;
> >   		}
> > -		/* If details->check_mapping, we leave swap entries. */
> > -		if (unlikely(details))
> > +		if (unlikely(zap_skip_swap(details)))
> >   			continue;
> >   		if (!non_swap_entry(entry))
> > @@ -3351,6 +3350,7 @@ void unmap_mapping_page(struct page *page)
> >   	first_index = page->index;
> >   	last_index = page->index + thp_nr_pages(page) - 1;
> > +	/* Keep ZAP_FLAG_SKIP_SWAP cleared because we're truncating */

As to keep the behavior, I shouldn't fiddle around with this, so I'll also
attach ZAP_FLAG_SKIP_SWAP to unmap_mapping_page() too in v3.

> >   	details.zap_mapping = mapping;
> >   	details.single_page = page;

Thanks,

-- 
Peter Xu

