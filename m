Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0207D3E7B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242414AbhHJPDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:03:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:24648 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234153AbhHJPDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:03:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="214905698"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="214905698"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 08:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="671795060"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2021 08:02:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 84889142; Tue, 10 Aug 2021 18:02:16 +0300 (EEST)
Date:   Tue, 10 Aug 2021 18:02:16 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: Add support for unaccepted memory
Message-ID: <20210810150216.dwn2rylcpzxx6b6l@black.fi.intel.com>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <20210810062626.1012-2-kirill.shutemov@linux.intel.com>
 <dd4b7aff-ccf3-24f6-3f6e-14c4b6aa8b64@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4b7aff-ccf3-24f6-3f6e-14c4b6aa8b64@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 09:48:04AM +0200, David Hildenbrand wrote:
> On 10.08.21 08:26, Kirill A. Shutemov wrote:
> > UEFI Specification version 2.9 introduces concept of memory acceptance:
> > Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> > requiring memory to be accepted before it can be used by the guest.
> > Accepting happens via a protocol specific for the Virtrual Machine
> > platform.
> > 
> > Accepting memory is costly and it makes VMM allocate memory for the
> > accepted guest physical address range. It's better to postpone memory
> > acceptation until memory is needed. It lowers boot time and reduces
> > memory overhead.
> > 
> > Support of such memory requires few changes in core-mm code:
> > 
> >    - memblock has to accept memory on allocation;
> > 
> >    - page allocator has to accept memory on the first allocation of the
> >      page;
> > 
> > Memblock change is trivial.
> > 
> > Page allocator is modified to accept pages on the first allocation.
> > PageOffline() is used to indicate that the page requires acceptance.
> > The flag currently used by hotplug and balloon. Such pages are not
> > available to page allocator.
> > 
> > An architecture has to provide three helpers if it wants to support
> > unaccepted memory:
> > 
> >   - accept_memory() makes a range of physical addresses accepted.
> > 
> >   - maybe_set_page_offline() marks a page PageOffline() if it requires
> >     acceptance. Used during boot to put pages on free lists.
> > 
> >   - clear_page_offline() clears makes a page accepted and clears
> >     PageOffline().
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   mm/internal.h   | 14 ++++++++++++++
> >   mm/memblock.c   |  1 +
> >   mm/page_alloc.c | 13 ++++++++++++-
> >   3 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 31ff935b2547..d2fc8a17fbe0 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -662,4 +662,18 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
> >   int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
> >   		      unsigned long addr, int page_nid, int *flags);
> > +#ifndef CONFIG_UNACCEPTED_MEMORY
> > +static inline void maybe_set_page_offline(struct page *page, unsigned int order)
> > +{
> > +}
> > +
> > +static inline void clear_page_offline(struct page *page, unsigned int order)
> > +{
> > +}
> > +
> > +static inline void accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +}
> 
> Can we find better fitting names for the first two? The function names are
> way too generic. For example:
> 
> accept_or_set_page_offline()
> 
> accept_and_clear_page_offline()

Sounds good.

> I thought for a second if
> 	PAGE_TYPE_OPS(Unaccepted, offline)
> makes sense as well, not sure.

I find Offline fitting the situation. Don't see a reason to add more
terminology here.

> Also, please update the description of PageOffline in page-flags.h to
> include the additional usage with PageBuddy set at the same time.

Okay.

> I assume you don't have to worry about page_offline_freeze/thaw ... as we
> only set PageOffline initially, but not later at runtime when other
> subsystems (/proc/kcore) might stumble over it.

I think so, but I would need to look at this code once again.

-- 
 Kirill A. Shutemov
