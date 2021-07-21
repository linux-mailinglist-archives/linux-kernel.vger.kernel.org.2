Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607683D1944
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhGUUzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhGUUzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626903337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U/WZQ3ffHWJN+iuGTm5qHe7VNikHIU8P5Rl+l3AmGKE=;
        b=bxH2f1KwJbCT8Lk9sfiSA5aI8WkcD8w3rxndXBkNeIPLmFYte2svD57wKjrSMHOQCEinbo
        4z7Y5nyh4qFMhBuIPacfuw3cNI6Ka7whfEgO7JwvgaSdY2lCS1YfYXmFgjG2lttf69zC93
        v8cAN6j2FtyPR/1ItcXEbGZ8ZDvfYkk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-qT-j-t6SOQWxEGTLT4trAg-1; Wed, 21 Jul 2021 17:35:35 -0400
X-MC-Unique: qT-j-t6SOQWxEGTLT4trAg-1
Received: by mail-qk1-f197.google.com with SMTP id 81-20020a370b540000b02903b854c43335so2569648qkl.21
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 14:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U/WZQ3ffHWJN+iuGTm5qHe7VNikHIU8P5Rl+l3AmGKE=;
        b=nOH9TwRkk3NEu7ajTt449j8K6BTZcYQKfmi1ia5qL3aqOaKNnPLCSGzIvMGrgbmmgh
         KfYhGmgiJiEiOEPQKfA7mX6663zRAVVpwECSzTckUr21kbEzJjWlZbPEwIfMfycO81Ie
         nxVLFCH/YijkqZt13bEr3DTC5XRIDzx4xrpMvLozUM4zuaPIhJbiPmKLl8jKwSOrPN28
         H0y+RMpNXM4Q4Ez9PARP/nBCpwWNUo1UyqCICsP5Aa496Y09vb8fLAZPpbfIapK6Lo9L
         npGwhoj++Dm71DDGmYJo+LvZ8aFS1fGKLxRabiAAKXLO2knoA1/oMEK5Mf0hoGhZ+Lry
         zvVw==
X-Gm-Message-State: AOAM533fmHFsVMA2maORqhBRiKoIvCTuSvcB/QtD9IXuP866gW07API+
        TLAwR/72xElJf5gBfBmihgQz1IoKMbzmMMV/Z/ewLBpLxExnfeY3WSIGRFA5iFoB1PIvNoOj0p4
        Y0lL8KHx/xAE58+msFiOstq+I
X-Received: by 2002:ae9:dd06:: with SMTP id r6mr37386554qkf.74.1626903335182;
        Wed, 21 Jul 2021 14:35:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgt1yBb7PyOi6Z3ISzruYC8uksXGClR/NuJ9FT9l5G6GNvdCFzD8CrfZDjsQwtmt0bcl86Rg==
X-Received: by 2002:ae9:dd06:: with SMTP id r6mr37386529qkf.74.1626903334931;
        Wed, 21 Jul 2021 14:35:34 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id w19sm7155986qkb.66.2021.07.21.14.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:35:34 -0700 (PDT)
Date:   Wed, 21 Jul 2021 17:35:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v5 05/26] mm/swap: Introduce the idea of special swap ptes
Message-ID: <YPiTJLGxqiLXjbAU@t490s>
References: <20210715201422.211004-1-peterx@redhat.com>
 <6116877.MhgVfB7NV9@nvdebian>
 <YPHZ5cCv+I/hLO08@t490s>
 <23927325.GfNbO0Vjio@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23927325.GfNbO0Vjio@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 09:28:49PM +1000, Alistair Popple wrote:
> On Saturday, 17 July 2021 5:11:33 AM AEST Peter Xu wrote:
> > On Fri, Jul 16, 2021 at 03:50:52PM +1000, Alistair Popple wrote:
> > > Hi Peter,
> > > 
> > > [...]
> > > 
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index ae1f5d0cb581..4b46c099ad94 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -5738,7 +5738,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
> > > >  
> > > >  	if (pte_present(ptent))
> > > >  		page = mc_handle_present_pte(vma, addr, ptent);
> > > > -	else if (is_swap_pte(ptent))
> > > > +	else if (pte_has_swap_entry(ptent))
> > > >  		page = mc_handle_swap_pte(vma, ptent, &ent);
> > > >  	else if (pte_none(ptent))
> > > >  		page = mc_handle_file_pte(vma, addr, ptent, &ent);
> > > 
> > > As I understand things pte_none() == False for a special swap pte, but
> > > shouldn't this be treated as pte_none() here? Ie. does this need to be
> > > pte_none(ptent) || is_swap_special_pte() here?
> > 
> > Looks correct; here the page/swap cache could hide behind the special pte just
> > like a none pte.  Will fix it.  Thanks!
> > 
> > > 
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 0e0de08a2cd5..998a4f9a3744 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -3491,6 +3491,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > > >  	if (!pte_unmap_same(vmf))
> > > >  		goto out;
> > > >  
> > > > +	/*
> > > > +	 * We should never call do_swap_page upon a swap special pte; just be
> > > > +	 * safe to bail out if it happens.
> > > > +	 */
> > > > +	if (WARN_ON_ONCE(is_swap_special_pte(vmf->orig_pte)))
> > > > +		goto out;
> > > > +
> > > >  	entry = pte_to_swp_entry(vmf->orig_pte);
> > > >  	if (unlikely(non_swap_entry(entry))) {
> > > >  		if (is_migration_entry(entry)) {
> > > 
> > > Are there other changes required here? Because we can end up with stale special
> > > pte's and a special pte is !pte_none don't we need to fix some of the !pte_none
> > > checks in these functions:
> > > 
> > > insert_pfn() -> checks for !pte_none
> > > remap_pte_range() -> BUG_ON(!pte_none)
> > > apply_to_pte_range() -> didn't check further but it tests for !pte_none
> > > 
> > > In general it feels like I might be missing something here though. There are
> > > plenty of checks in the kernel for pte_none() which haven't been updated. Is
> > > there some rule that says none of those paths can see a special pte?
> > 
> > My rule on doing this was to only care about vma that can be backed by RAM,
> > majorly shmem/hugetlb, so the special pte can only exist there within those
> > vmas.  I believe in most pte_none() users this special pte won't exist.
> > 
> > So if it's not related to RAM backed memory at all, maybe it's fine to keep the
> > pte_none() usage like before.
> > 
> > Take the example of insert_pfn() referenced first - I think it can be used to
> > map some MMIO regions, but I don't think we'll call that upon a RAM region
> > (either shmem or hugetlb), nor can it be uffd wr-protected.  So I'm not sure
> > adding special pte check there would be helpful.
> > 
> > apply_to_pte_range() seems to be a bit special - I think the pte_fn_t matters
> > more on whether the special pte will matter.  I had a quick look, it seems
> > still be used mostly by all kinds of driver code not mm core.  It's used in two
> > forms:
> > 
> >         apply_to_page_range
> >         apply_to_existing_page_range
> > 
> > The first one creates ptes only, so it ignores the pte_none() check so I skipped.
> > 
> > The second one has two call sites:
> > 
> > *** arch/powerpc/mm/pageattr.c:
> > change_memory_attr[99]         return apply_to_existing_page_range(&init_mm, start, size,
> > set_memory_attr[132]           return apply_to_existing_page_range(&init_mm, start, sz, set_page_attr,
> > 
> > *** mm/kasan/shadow.c:
> > kasan_release_vmalloc[485]     apply_to_existing_page_range(&init_mm,
> > 
> > I'll leave the ppc callers for now as uffd-wp is not even supported there.  The
> > kasan_release_vmalloc() should be for kernel allocated memories only, so should
> > not be a target for special pte either.
> > 
> > So indeed it's hard to 100% cover all pte_none() users to make sure things are
> > used right.  As stated above I still believe most callers don't need that, but
> > the worst case is if someone triggered uffd-wp issues with a specific feature,
> > we can look into it.  I am not sure whether it's good we add this for all the
> > pte_none() users, because mostly they'll be useless checks, imho.
> 
> I wonder then - should we make pte_none() return true for these special pte's
> as well? It seems if we do miss any callers it could result in some fairly hard
> to find bugs if the code follows a different path due to the presence of an
> unexpected special pte changing the result of pte_none().

I thought about something similar before, but I didn't dare to change
pte_none() as it's been there for ages and I'm afraid people will get confused
when it's meaning changed.  So even if we want to have some helper identifying
"either none pte or the swap special pte" it should use a different name.

Modifying the meaning of pte_none() could also have other risks that when we
really want an empty pte to be doing something else now.  It turns out there's
no easy way to not identify the case one by one, at least to me.  I'm always
open to good suggestions.

Btw, as you mentioned before, we can use a new number out of MAX_SWAPFILES,
that'll make all these easier a bit here, then we don't need to worry on
pte_none() issues too.  Two days ago Hugh has raised some similar concern on
whether it's good to implement this uffd-wp special pte like this.  I think we
can discuss this separately.

> 
> > So far what I planned to do is to cover most things we know that may be
> > affected like this patch so the change may bring a difference, hopefully we
> > won't miss any important spots.
> > 
> > > 
> > > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > > index 23cbd9de030b..b477d0d5f911 100644
> > > > --- a/mm/migrate.c
> > > > +++ b/mm/migrate.c
> > > > @@ -294,7 +294,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> > > >  
> > > >  	spin_lock(ptl);
> > > >  	pte = *ptep;
> > > > -	if (!is_swap_pte(pte))
> > > > +	if (!pte_has_swap_entry(pte))
> > > >  		goto out;
> > > >  
> > > >  	entry = pte_to_swp_entry(pte);
> > > > @@ -2276,7 +2276,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> > > >  
> > > >  		pte = *ptep;
> > > >  
> > > > -		if (pte_none(pte)) {
> > > > +		if (pte_none(pte) || is_swap_special_pte(pte)) {
> > > 
> > > I was wondering if we can loose the special pte information here? However I see
> > > that in migrate_vma_insert_page() we check again and fail the migration if
> > > !pte_none() so I think this is ok.
> > > 
> > > I think it would be better if this check was moved below so the migration fails
> > > early. Ie:
> > > 
> > > 		if (pte_none(pte)) {
> > >  			if (vma_is_anonymous(vma) && !is_swap_special_pte(pte)) {
> > 
> > Hmm.. but shouldn't vma_is_anonymous()==true already means it must not be a
> > swap special pte?  Because swap special pte only exists when !vma_is_anonymous().
> 
> Oh ok that makes sense. With the code written that way it is easy to forget
> that though so maybe a comment would help?

I've put most words in comment of is_swap_special_pte().  Do you perhaps have a
suggestion on the comment here?

> 
> > > 
> > > Also how does this work for page migration in general? I can see in
> > > page_vma_mapped_walk() that we skip special pte's, but doesn't this mean we
> > > loose the special pte in that instance? Or is that ok for some reason?
> > 
> > Do you mean try_to_migrate_one()? Does it need to be aware of that?  Per my
> > understanding that's only for anonymous private memory, while in that world
> > there should have no swap special pte (page_lock_anon_vma_read will return NULL
> > early for !vma_is_anonymous).
> 
> As far as I know try_to_migrate_one() gets called for both anonymous pages and
> file-backed pages. page_lock_anon_vma_read() is only called in the case of an
> anonymous vma. See the implementation of rmap_walk() - it will call either
> rmap_walk_anon() or rmap_walk_file() depending on the result of PageAnon().

I may have replied too soon there. :)  I think you're right.

So I think how it should work with page migration is: we skip that pte just
like what you said (check_pte returns false), then the per-pte info will be
kept there, irrelevant of what's the backing page is.  When it faults, it'll
bring up with either the old/new page depending on migration finished or not.
Does that sound working to you?

Thanks,

-- 
Peter Xu

