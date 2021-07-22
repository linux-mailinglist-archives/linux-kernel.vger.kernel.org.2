Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826C53D2696
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhGVOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 10:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232640AbhGVOkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 10:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626967269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m3yy0oPiSTzckzn8RHV/BdePnVnGDqc29Ckw9BO7ESs=;
        b=b7aXilR4wW3RJdSP22S4AYNmAZkIqqAoeuZA6mrkeYzvzFvRx1gCpSYJTlhmaninPZVzgs
        pLs3Omet7V2XLBJjWSISumR03R6Df3A9+fhSv4zoYg3j/rQl5xMVjvMhpvs5vA09Dw1QEa
        bMzKj7OqyYcKo/9uVAuBs0sEFmgiyug=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-FQoCBLQpOFi9beweONKL7w-1; Thu, 22 Jul 2021 11:21:08 -0400
X-MC-Unique: FQoCBLQpOFi9beweONKL7w-1
Received: by mail-qt1-f200.google.com with SMTP id h11-20020ac8138b0000b029025f8084df09so3550538qtj.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 08:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m3yy0oPiSTzckzn8RHV/BdePnVnGDqc29Ckw9BO7ESs=;
        b=FIUxe757XF2PJkPWkoA+adTDwvaLNxKt911xUfOdfxU6iAATmZszOoywIF4283SO57
         puROgEpmvJOZX/lDWmfMBfVw3SCjulAZWb3nKM68wUAfikQf8cVNOOrVvjkKEBYBKAOO
         xeMra0/yN+KR+no9Midj5LA40b4AxormZHBmLaXY/GcxRx1Fss8Egg3Qx9+TnoO6MiIf
         7bxsy+M2WB8H3UDQw9sA1wuVIbgldrCQTKZYsHcvCyiGNShk+zRUKCSbooGBJVBTHYBj
         ug8h2OjXsEtxRO5btyXgC7eh3vGk0jy75SpYb78kT+GNONhqdI7zViGLuzRByVPCHXCy
         CeQw==
X-Gm-Message-State: AOAM531jD50ODcKCDcWOjiZvDZPzY9oufwJW9IZOWCRDYu7pST3u6rHC
        07KJRCSdptjMvoDc+Qs76Aq3wkkeAZQ2hUN3EMDi8Ee8DpNYIVRnP8NUgin/rbY9Kfe/XkKdWsc
        ElAoHPMQXjkargq4Bw6azAoOz
X-Received: by 2002:a05:6214:1366:: with SMTP id c6mr236407qvw.0.1626967268164;
        Thu, 22 Jul 2021 08:21:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa8mlrCeO+o/fUmP3sDIg60x6ccOo4P2MNj72PFZxCfSyGXw+hvWt32M1/cUvdc4Uc1fuZtQ==
X-Received: by 2002:a05:6214:1366:: with SMTP id c6mr236370qvw.0.1626967267867;
        Thu, 22 Jul 2021 08:21:07 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id g76sm12874244qke.127.2021.07.22.08.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 08:21:07 -0700 (PDT)
Date:   Thu, 22 Jul 2021 11:21:05 -0400
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
Message-ID: <YPmM4ThMIde9FTbs@t490s>
References: <20210715201422.211004-1-peterx@redhat.com>
 <23927325.GfNbO0Vjio@nvdebian>
 <YPiTJLGxqiLXjbAU@t490s>
 <5071185.SEdLSG93TQ@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5071185.SEdLSG93TQ@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 11:08:53AM +1000, Alistair Popple wrote:
> On Thursday, 22 July 2021 7:35:32 AM AEST Peter Xu wrote:
> > On Wed, Jul 21, 2021 at 09:28:49PM +1000, Alistair Popple wrote:
> > > On Saturday, 17 July 2021 5:11:33 AM AEST Peter Xu wrote:
> > > > On Fri, Jul 16, 2021 at 03:50:52PM +1000, Alistair Popple wrote:
> > > > > Hi Peter,
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > index ae1f5d0cb581..4b46c099ad94 100644
> > > > > > --- a/mm/memcontrol.c
> > > > > > +++ b/mm/memcontrol.c
> > > > > > @@ -5738,7 +5738,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
> > > > > >  
> > > > > >  	if (pte_present(ptent))
> > > > > >  		page = mc_handle_present_pte(vma, addr, ptent);
> > > > > > -	else if (is_swap_pte(ptent))
> > > > > > +	else if (pte_has_swap_entry(ptent))
> > > > > >  		page = mc_handle_swap_pte(vma, ptent, &ent);
> > > > > >  	else if (pte_none(ptent))
> > > > > >  		page = mc_handle_file_pte(vma, addr, ptent, &ent);
> > > > > 
> > > > > As I understand things pte_none() == False for a special swap pte, but
> > > > > shouldn't this be treated as pte_none() here? Ie. does this need to be
> > > > > pte_none(ptent) || is_swap_special_pte() here?
> > > > 
> > > > Looks correct; here the page/swap cache could hide behind the special pte just
> > > > like a none pte.  Will fix it.  Thanks!
> > > > 
> > > > > 
> > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > index 0e0de08a2cd5..998a4f9a3744 100644
> > > > > > --- a/mm/memory.c
> > > > > > +++ b/mm/memory.c
> > > > > > @@ -3491,6 +3491,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > > > > >  	if (!pte_unmap_same(vmf))
> > > > > >  		goto out;
> > > > > >  
> > > > > > +	/*
> > > > > > +	 * We should never call do_swap_page upon a swap special pte; just be
> > > > > > +	 * safe to bail out if it happens.
> > > > > > +	 */
> > > > > > +	if (WARN_ON_ONCE(is_swap_special_pte(vmf->orig_pte)))
> > > > > > +		goto out;
> > > > > > +
> > > > > >  	entry = pte_to_swp_entry(vmf->orig_pte);
> > > > > >  	if (unlikely(non_swap_entry(entry))) {
> > > > > >  		if (is_migration_entry(entry)) {
> > > > > 
> > > > > Are there other changes required here? Because we can end up with stale special
> > > > > pte's and a special pte is !pte_none don't we need to fix some of the !pte_none
> > > > > checks in these functions:
> > > > > 
> > > > > insert_pfn() -> checks for !pte_none
> > > > > remap_pte_range() -> BUG_ON(!pte_none)
> > > > > apply_to_pte_range() -> didn't check further but it tests for !pte_none
> > > > > 
> > > > > In general it feels like I might be missing something here though. There are
> > > > > plenty of checks in the kernel for pte_none() which haven't been updated. Is
> > > > > there some rule that says none of those paths can see a special pte?
> > > > 
> > > > My rule on doing this was to only care about vma that can be backed by RAM,
> > > > majorly shmem/hugetlb, so the special pte can only exist there within those
> > > > vmas.  I believe in most pte_none() users this special pte won't exist.
> > > > 
> > > > So if it's not related to RAM backed memory at all, maybe it's fine to keep the
> > > > pte_none() usage like before.
> > > > 
> > > > Take the example of insert_pfn() referenced first - I think it can be used to
> > > > map some MMIO regions, but I don't think we'll call that upon a RAM region
> > > > (either shmem or hugetlb), nor can it be uffd wr-protected.  So I'm not sure
> > > > adding special pte check there would be helpful.
> > > > 
> > > > apply_to_pte_range() seems to be a bit special - I think the pte_fn_t matters
> > > > more on whether the special pte will matter.  I had a quick look, it seems
> > > > still be used mostly by all kinds of driver code not mm core.  It's used in two
> > > > forms:
> > > > 
> > > >         apply_to_page_range
> > > >         apply_to_existing_page_range
> > > > 
> > > > The first one creates ptes only, so it ignores the pte_none() check so I skipped.
> > > > 
> > > > The second one has two call sites:
> > > > 
> > > > *** arch/powerpc/mm/pageattr.c:
> > > > change_memory_attr[99]         return apply_to_existing_page_range(&init_mm, start, size,
> > > > set_memory_attr[132]           return apply_to_existing_page_range(&init_mm, start, sz, set_page_attr,
> > > > 
> > > > *** mm/kasan/shadow.c:
> > > > kasan_release_vmalloc[485]     apply_to_existing_page_range(&init_mm,
> > > > 
> > > > I'll leave the ppc callers for now as uffd-wp is not even supported there.  The
> > > > kasan_release_vmalloc() should be for kernel allocated memories only, so should
> > > > not be a target for special pte either.
> > > > 
> > > > So indeed it's hard to 100% cover all pte_none() users to make sure things are
> > > > used right.  As stated above I still believe most callers don't need that, but
> > > > the worst case is if someone triggered uffd-wp issues with a specific feature,
> > > > we can look into it.  I am not sure whether it's good we add this for all the
> > > > pte_none() users, because mostly they'll be useless checks, imho.
> > > 
> > > I wonder then - should we make pte_none() return true for these special pte's
> > > as well? It seems if we do miss any callers it could result in some fairly hard
> > > to find bugs if the code follows a different path due to the presence of an
> > > unexpected special pte changing the result of pte_none().
> > 
> > I thought about something similar before, but I didn't dare to change
> > pte_none() as it's been there for ages and I'm afraid people will get confused
> > when it's meaning changed.  So even if we want to have some helper identifying
> > "either none pte or the swap special pte" it should use a different name.
> > 
> > Modifying the meaning of pte_none() could also have other risks that when we
> > really want an empty pte to be doing something else now.  It turns out there's
> > no easy way to not identify the case one by one, at least to me.  I'm always
> > open to good suggestions.
> 
> I'm not convinced it's changing the behaviour of pte_none() though and my
> concern is that introducing special swap ptes does change it. Prior to this
> clearing a pte would result in pte_none()==True. After this series clearing a
> pte can some sometimes result in pte_none()==False because it doesn't really
> get cleared.

The thing is the uffd special pte is not "none" literally; there's something
inside.  That's what makes it feel not right to me.  I'm not against trapping
all of pte_none(), but as I mentioned I think at least it needs to be renamed
to something else (maybe pte_none_mostly(), but I don't know..).

> 
> Now as you say it's hard to cover 100% of pte_none() uses, so it's possible we
> have missed cases that may now encounter a special pte and take a different
> path (get_mctgt_type() is one example, I stopped looking for other possible
> ones after mm/memory.c).
> 
> So perhaps if we want to keep pte_none() to check for really clear pte's then
> what is required is converting all callers to a new helper
> (pte_none_not_special()?) that treats special swap ptes as pte_none() and warns
> if a special pte is encountered?

By double check all core memory calls to pte_none()?

The special swap pte shouldn't exist for most cases but only for shmem and
hugetlbfs so far.  So we can sensibly drop a lot of pte_none() users IMHO
depending on the type of memory.

> 
> > Btw, as you mentioned before, we can use a new number out of MAX_SWAPFILES,
> > that'll make all these easier a bit here, then we don't need to worry on
> > pte_none() issues too.  Two days ago Hugh has raised some similar concern on
> > whether it's good to implement this uffd-wp special pte like this.  I think we
> > can discuss this separately.
> 
> Yes, I saw that and personally I still prefer that approach.

Yes I see your preference.  Let's hold off a bit on the pte_none() discussions;
I'll re-raise this in the cover letter soon.  If everyone is okay that we use
yet another MAX_SWAPFILES and that's preferred, then I can switch the design.
Then I think I can also avoid touching the pte_none() bits at all, which seems
to be controversial here.

But still, I am also not convinced that we can blindly replace pte_none() into
"either none pte or some special pte", either in this series or (if this series
will switch to swp_entry) in the future when we want to use !pte_present and
!swp_entry ptes.  If we want to replace that, we may still want to check over
all the users of pte_none then it's the same as what we should do now, and do a
proper rename of it.

Thanks,

-- 
Peter Xu

