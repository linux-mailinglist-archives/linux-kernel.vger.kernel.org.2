Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0033033166D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCHSoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:44:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:37850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbhCHSne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:43:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D068AD2B;
        Mon,  8 Mar 2021 18:43:33 +0000 (UTC)
Date:   Mon, 8 Mar 2021 19:43:30 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <20210308184330.GB25767@linux>
References: <20210301083230.30924-1-osalvador@suse.de>
 <20210301083230.30924-4-osalvador@suse.de>
 <b1aff368-8321-0fa7-05ab-3d6c856c00f8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1aff368-8321-0fa7-05ab-3d6c856c00f8@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 09:02:36AM -0800, Dave Hansen wrote:
> On 3/1/21 12:32 AM, Oscar Salvador wrote:
> > When the size of a struct page is not multiple of 2MB, sections do
> > not span a PMD anymore and so when populating them some parts of the
> > PMD will remain unused.
> 
> Multiples of 2MB are 2MB, 4MB, 6MB, etc...
> 
> I think you meant here that 2MB must be a multiple of the 'struct page'
> size.  I don't think there are any non-power-of-2 factors of 2MB, so I
> think it's probably simpler and more accurate to say:
> 
> 	When sizeof(struct page) is not a power of 2...

Yes, I think this was a poor choice of words.
It was the other way around, that PMD must be multiple of struct page size.
"When sizeof(struct page) is not a power of 2..." sounds definitely better.

> > +static unsigned long unused_pmd_start __meminitdata;
> 
> This whole 'unused_pmd_start' thing was unmentioned in the changelog.

Sorry, I will expand some more.

> I also kept reading this and thinking it was a 'pmd_t *', not a 'struct
> page *'.  The naming is rather unfortunate that way.

Well, it is the pmd range.

> 
> So, is this here so that the memset()s can be avoided?  It's just an
> optimization to say: "This is unused, but instead of marking it with
> PAGE_UNUSED (which would be slow) I keep a pointer to it"?

Yes, it is an optimization that let us avoid a memset() in case the sections
we are adding are consetuvie.

> > +static void __meminit vmemmap_flush_unused_pmd(void)
> > +{
> > +	if (!unused_pmd_start)
> > +		return;
> > +	/*
> > +	 * Clears (unused_pmd_start, PMD_END]
> > +	 */
> > +	memset((void *)unused_pmd_start, PAGE_UNUSED,
> > +	       ALIGN(unused_pmd_start, PMD_SIZE) - unused_pmd_start);
> > +	unused_pmd_start = 0;
> > +}
> 
> Oh, and this means: "stop using the unused_pmd_start optimization.  Just
> memset the thing".

Yes, as stated above, this optimization only takes place as long as the sections
are being added consecutive.
As soon as that is not the case, we memset the last range recorded and reset
unused_pmd_start.

> > +/* Returns true if the PMD is completely unused and thus it can be freed */
> > +static bool __meminit vmemmap_unuse_sub_pmd(unsigned long addr, unsigned long end)
> > +{
> > +	unsigned long start = ALIGN_DOWN(addr, PMD_SIZE);
> > +
> > +	vmemmap_flush_unused_pmd();
> 
> That probably needs a comment like:
> 
> 	Flush the unused range cache to ensure that the memchr_inv()
> 	will work for the whole range.

Sure, I will add a comment.

> 
> > +	memset((void *)addr, PAGE_UNUSED, end - addr);
> > +
> > +	return !memchr_inv((void *)start, PAGE_UNUSED, PMD_SIZE);
> > +}
> 
> Also, logically, it would make a lot of sense if you can move the actual
> PMD freeing logic in here.  That way, the caller is just saying, "unuse
> this PMD region", and then this takes care of the rest.  As it stands,
> it's a bit weird that the caller takes care of the freeing.

You mean to move the 

 free_hugepage_table(pmd_page(*pmd), altmap);
 spin_lock(&init_mm.page_table_lock);
 pmd_clear(pmd);
 spin_unlock(&init_mm.page_table_lock);

block in there?

Well, from where I see it, it is more like:

 if (is_the_range_unused())
  : if so, free everything

But I agree with you what it might make some sense to move it there.
Since I do not feel strong about this, I will move it.

> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> > +				/*
> > +				 * Free the PMD if the whole range is unused.
> > +				 */
> > +				if (vmemmap_unuse_sub_pmd(addr, next)) {
> >  					free_hugepage_table(pmd_page(*pmd),
> >  							    altmap);
> >  
> > @@ -1040,6 +1124,7 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
> >  					pmd_clear(pmd);
> >  					spin_unlock(&init_mm.page_table_lock);
> >  				}
> > +#endif
> >  			}
> 
> This doesn't look like the world's longest if() statement, but it might
> be nice to use the IS_ENABLED() syntax instead of an #ifdef.  I suspect
> the compiler could even make quick work of the static functions that
> never get called as a result.

Sure, I will replace the #ifdef with IS_ENABLED.

> 
> >  			continue;
> > @@ -1492,11 +1577,16 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
> >  
> >  				addr_end = addr + PMD_SIZE;
> >  				p_end = p + PMD_SIZE;
> > +
> > +				if (!IS_ALIGNED(addr, PMD_SIZE) ||
> > +				    !IS_ALIGNED(next, PMD_SIZE))
> > +					vmemmap_use_new_sub_pmd(addr, next);
> >  				continue;
> >  			} else if (altmap)
> >  				return -ENOMEM; /* no fallback */
> >  		} else if (pmd_large(*pmd)) {
> >  			vmemmap_verify((pte_t *)pmd, node, addr, next);
> > +			vmemmap_use_sub_pmd(addr, next);
> >  			continue;
> >  		}
> >  		if (vmemmap_populate_basepages(addr, next, node, NULL))
> > 
> 
> This overall looks like a good thing to do.  The implementation is even
> pretty nice and simple. But, it took me an awfully long time to figure
> out what was going on.
> 
> I wonder if you could take one more pass at these and especially see if
> you can better explain the use of 'unused_pmd_start'.

In order to ease the review, I will split the core-changes and the optimization.
So I will place the whole unused_pmd_start opimization in a different patch.

Thanks for the feedback Dave!


-- 
Oscar Salvador
SUSE L3
