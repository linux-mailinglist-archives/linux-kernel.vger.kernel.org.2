Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681153EABD9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbhHLUfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhHLUfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:35:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44324C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:34:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y34so15736418lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WbT2Y/qRqTYMOLIgDiAlPur6EimbqnsytMdLoRasZoM=;
        b=AyOWzJ2ElYARqGk8GcwFZ7QYPk7RpVVs4+zMu7Xi8u1nGtuIh7mP4tiR+o4DAZQaII
         tJXYVJ6SPYV36CejuVL1VSqxs+AyAdG5pDQUsFT3XS++1iZSbXc6alCB2rYodYRZ4QvO
         lzR4hT5IR5sovz1lSSlhNrkuBXt1v+XeHgHEixBvHp2tkG/xsjwC6lwFTRrp6DoD4eE5
         W0vsPvJc02WRG8rqSOzVLzQRJIiYH9yBDl5805VN+hMgHYho9GBBxLJBd3L/KT1Uc61P
         MBBkCeUxoFnrbMAlmU96txHGtVbOoPdsWuvccj62EH8UpOHE6f/fO6+Nma7xC2T+H+Wk
         5elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WbT2Y/qRqTYMOLIgDiAlPur6EimbqnsytMdLoRasZoM=;
        b=ETCKIAdEj6kmLoWg8dSUybySw9yIGFpWDoVyIyAA1xS8GLdSbljCH/+O3rL5MLRgg3
         Hq+UJ8X2RS6w/TMve/UZI8/r+IaUDNuyjHOpSYoLTuR8BzjpcyBD7G1Zk+4wREFoNEwB
         cHhXy+gwXEnn8lO8o6AXzPDd+HSYcEFZJcM2AIT/bC+4GLEIHrCpu5RYI6vs7S8EFF9X
         dS/KQ2VU+TqWP6kJXA6uy2erWAL+CEukw5iMpqObGaLAX087BdUD4ndDPhMecalD8B0a
         7XnoMRDyujqyI2K5iplKG9EZaBZIZw0fzva7XN5n44GQtI2g+UVYb2lFgOaC1ee7G+Ns
         l0OQ==
X-Gm-Message-State: AOAM530X0BlWSegkJdarMF6DrTAC7jnd6x8sTbT3zulifs37zBYX38BY
        lgDx92EarJ4YutNcTdaS6aeelQ==
X-Google-Smtp-Source: ABdhPJxPnl/3ZvpGm9NlFCtffH7hxLvwR+kgerqlOFaM1gutMTpql47rTjRpqAfXyy+surckQjorJw==
X-Received: by 2002:a05:6512:b09:: with SMTP id w9mr3683314lfu.273.1628800485549;
        Thu, 12 Aug 2021 13:34:45 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w19sm412018ljd.67.2021.08.12.13.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:34:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8CDC8102BEE; Thu, 12 Aug 2021 23:34:58 +0300 (+03)
Date:   Thu, 12 Aug 2021 23:34:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Message-ID: <20210812203458.oobmqnjhmilewnai@box.shutemov.name>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <20210810062626.1012-2-kirill.shutemov@linux.intel.com>
 <dd4b7aff-ccf3-24f6-3f6e-14c4b6aa8b64@redhat.com>
 <20210810150216.dwn2rylcpzxx6b6l@black.fi.intel.com>
 <2e45209d-6a99-9496-6cb0-111291bd481a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e45209d-6a99-9496-6cb0-111291bd481a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 05:21:48PM +0200, David Hildenbrand wrote:
> On 10.08.21 17:02, Kirill A. Shutemov wrote:
> > On Tue, Aug 10, 2021 at 09:48:04AM +0200, David Hildenbrand wrote:
> > > On 10.08.21 08:26, Kirill A. Shutemov wrote:
> > > > UEFI Specification version 2.9 introduces concept of memory acceptance:
> > > > Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> > > > requiring memory to be accepted before it can be used by the guest.
> > > > Accepting happens via a protocol specific for the Virtrual Machine
> > > > platform.
> > > > 
> > > > Accepting memory is costly and it makes VMM allocate memory for the
> > > > accepted guest physical address range. It's better to postpone memory
> > > > acceptation until memory is needed. It lowers boot time and reduces
> > > > memory overhead.
> > > > 
> > > > Support of such memory requires few changes in core-mm code:
> > > > 
> > > >     - memblock has to accept memory on allocation;
> > > > 
> > > >     - page allocator has to accept memory on the first allocation of the
> > > >       page;
> > > > 
> > > > Memblock change is trivial.
> > > > 
> > > > Page allocator is modified to accept pages on the first allocation.
> > > > PageOffline() is used to indicate that the page requires acceptance.
> > > > The flag currently used by hotplug and balloon. Such pages are not
> > > > available to page allocator.
> > > > 
> > > > An architecture has to provide three helpers if it wants to support
> > > > unaccepted memory:
> > > > 
> > > >    - accept_memory() makes a range of physical addresses accepted.
> > > > 
> > > >    - maybe_set_page_offline() marks a page PageOffline() if it requires
> > > >      acceptance. Used during boot to put pages on free lists.
> > > > 
> > > >    - clear_page_offline() clears makes a page accepted and clears
> > > >      PageOffline().
> > > > 
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > ---
> > > >    mm/internal.h   | 14 ++++++++++++++
> > > >    mm/memblock.c   |  1 +
> > > >    mm/page_alloc.c | 13 ++++++++++++-
> > > >    3 files changed, 27 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/internal.h b/mm/internal.h
> > > > index 31ff935b2547..d2fc8a17fbe0 100644
> > > > --- a/mm/internal.h
> > > > +++ b/mm/internal.h
> > > > @@ -662,4 +662,18 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
> > > >    int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
> > > >    		      unsigned long addr, int page_nid, int *flags);
> > > > +#ifndef CONFIG_UNACCEPTED_MEMORY
> > > > +static inline void maybe_set_page_offline(struct page *page, unsigned int order)
> > > > +{
> > > > +}
> > > > +
> > > > +static inline void clear_page_offline(struct page *page, unsigned int order)
> > > > +{
> > > > +}
> > > > +
> > > > +static inline void accept_memory(phys_addr_t start, phys_addr_t end)
> > > > +{
> > > > +}
> > > 
> > > Can we find better fitting names for the first two? The function names are
> > > way too generic. For example:
> > > 
> > > accept_or_set_page_offline()
> > > 
> > > accept_and_clear_page_offline()
> > 
> > Sounds good.
> > 
> > > I thought for a second if
> > > 	PAGE_TYPE_OPS(Unaccepted, offline)
> > > makes sense as well, not sure.
> > 
> > I find Offline fitting the situation. Don't see a reason to add more
> > terminology here.
> > 
> > > Also, please update the description of PageOffline in page-flags.h to
> > > include the additional usage with PageBuddy set at the same time.
> > 
> > Okay.
> > 
> > > I assume you don't have to worry about page_offline_freeze/thaw ... as we
> > > only set PageOffline initially, but not later at runtime when other
> > > subsystems (/proc/kcore) might stumble over it.
> > 
> > I think so, but I would need to look at this code once again.
> > 
> 
> Another thing to look into would be teaching makedumpfile via vmcoreinfo
> about these special buddy pages:
> 
> makedumpfile will naturally skip all PageOffline pages and skip PageBuddy
> pages if requested to skip free pages. It detects these pages via the
> mapcount value. You will want makedumpfile to treat them like PageOffline
> pages: kernel/crash_core.c
> 
> #define PAGE_BUDDY_MAPCOUNT_VALUE	(~PG_buddy)
> VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
> 
> #define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
> VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
> 
> We could export PAGE_BUDDY_OFFLINE_MAPCOUNT_VALUE or just compute it inside
> makedumpfile from the other two values.

Thanks, for digging it up. I'll look into makedumpfile, but it's not on
top of my todo list, so may take a while.

-- 
 Kirill A. Shutemov
