Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C35B30B8FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhBBHxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:53:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:57420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhBBHxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:53:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4D19AD3E;
        Tue,  2 Feb 2021 07:52:51 +0000 (UTC)
Date:   Tue, 2 Feb 2021 08:52:48 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <20210202075243.GA7037@linux>
References: <20210129064045.18471-1-osalvador@suse.de>
 <b9a2f80e-a90f-62bf-4197-66cdb315cb84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a2f80e-a90f-62bf-4197-66cdb315cb84@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 01:46:33PM +0100, David Hildenbrand wrote:
> >   static void __meminit free_pagetable(struct page *page, int order)
> >   {
> > @@ -1008,10 +1073,10 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
> >   			 * with 0xFD, and remove the page when it is wholly
> >   			 * filled with 0xFD.
> >   			 */
> > -			memset((void *)addr, PAGE_INUSE, next - addr);
> > +			memset((void *)addr, PAGE_UNUSED, next - addr);
> >   			page_addr = page_address(pte_page(*pte));
> > -			if (!memchr_inv(page_addr, PAGE_INUSE, PAGE_SIZE)) {
> > +			if (!memchr_inv(page_addr, PAGE_UNUSED, PAGE_SIZE)) {
> >   				free_pagetable(pte_page(*pte), 0);
> 
> I remember already raising this, in the context of other cleanups, but let's
> start anew:
> 
> How could we ever even end up in "!PAGE_ALIGNED(addr) &&
> PAGE_ALIGNED(next)"? As the comment correctly indicates, it would only make
> sense for "freeing vmemmap pages".
> 
> This would mean we are removing parts of a vmemmap page (4k), calling
> vmemmap_free()->remove_pagetable() on sub-page granularity.
> 
> Even sub-sections (2MB - 512 pages) have a memmap size with base pages:
> - 56 bytes: 7 pages
> - 64 bytes: 8 pages
> - 72 bytes: 9 pages
> 
> sizeof(struct page) is always multiples of 8 bytes, so that will hold.
> 
> E.g., in __populate_section_memmap(), we already enforce proper subsection
> alignment.
> 
> IMHO, we should rip out that code here and enforce page alignment in
> vmemmap_populate()/vmemmap_free().
> 
> Am I missing something?

Thanks David for bringing this up, I must say I was not aware that this
topic was ever discussed.

Ok, I've been having a look into this.
At first I was concerced because of a pure SPARSEMEM configuration, but I
see that those allocations are done in a very diferent way so it does not
bother us.

So we have the following enforcements during hotplug:

add_memory_resource
 check_hotplug_memory_range : Checks range aligned to memory_block_size_bytes,
                            : which means it must be section-size aligned

populate_section_memmap
 __populate_section_memmap  : Checks range aligned to sub-section size

So, IIRC we have two cases during hotplug:
 1) the ones that want memory blocks
 2) the ones that do not want them (pmem stuff)

For #1, we always enforce section alignment in add_memory_resource, and for
#2 we always make sure the range is at least sub-section aligned.

And the important stuff is that boot memory is no longer to be hot-removed
(boot memory had some strange layout sometimes).

So, given the above, I think it should be safe to drop that check in
remote_pte_table.
But do we really need to force page alignment in vmemmap_populate/vmemmap_free?
vmemmap_populate should already receive a page-aligned chunk because 
 __populate_section_memmap made sure of that, and vmemmap_free() should be ok
as we already filtered out at hot-adding stage.

Of course, this will hold as long as struct page size of multiple of 8.
Should that change we might get trouble, but I do not think that can ever
happened (tm).

But anyway, I am fine with placing a couple of checks in vmemmap_{populate,free}
just to double check.

What do you think?

-- 
Oscar Salvador
SUSE L3
