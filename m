Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62AC32F16D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhCERic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:38:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:60556 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229604AbhCERiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:38:11 -0500
IronPort-SDR: izhapYDIZ02RqLmm3Z1Cv0cCrABfj4NsMLpq26Lw2/19jdT9czyWabQEp0yWmJdnPe7N9WEGK6
 2f91Uf4QxCcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="187747006"
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; 
   d="scan'208";a="187747006"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 09:38:10 -0800
IronPort-SDR: 0zoUl40wgcyBIoi6Yaj6LG1qgmXMuEwIo1btHzlnMq9up0WhMCe6v7qoSkKgefW6TYZy2yqTX6
 MJtNsD6w6Dlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; 
   d="scan'208";a="407326526"
Received: from viggo.jf.intel.com (HELO ray) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 05 Mar 2021 09:38:10 -0800
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by ray (Postfix) with ESMTP id 097DBE0495;
        Thu,  4 Mar 2021 09:02:37 -0800 (PST)
Subject: Re: [PATCH v4 3/3] x86/vmemmap: Handle unpopulated sub-pmd ranges
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210301083230.30924-1-osalvador@suse.de>
 <20210301083230.30924-4-osalvador@suse.de>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <b1aff368-8321-0fa7-05ab-3d6c856c00f8@intel.com>
Date:   Thu, 4 Mar 2021 09:02:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210301083230.30924-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 12:32 AM, Oscar Salvador wrote:
> When the size of a struct page is not multiple of 2MB, sections do
> not span a PMD anymore and so when populating them some parts of the
> PMD will remain unused.

Multiples of 2MB are 2MB, 4MB, 6MB, etc...

I think you meant here that 2MB must be a multiple of the 'struct page'
size.  I don't think there are any non-power-of-2 factors of 2MB, so I
think it's probably simpler and more accurate to say:

	When sizeof(struct page) is not a power of 2...

I also don't think I realized that 2MB of 'struct page'
(2M/sizeof(struct page)=32k) fit perfectly into a 128MB section
(32k/64=128M).

> Because of this, PMDs will be left behind when depopulating sections
> since remove_pmd_table() thinks that those unused parts are still in
> use.
> 
> Fix this by marking the unused parts with PAGE_UNUSED, so memchr_inv()
> will do the right thing and will let us free the PMD when the last user
> of it is gone.
> 
> This patch is based on a similar patch by David Hildenbrand:
> 
> https://lore.kernel.org/linux-mm/20200722094558.9828-9-david@redhat.com/
> https://lore.kernel.org/linux-mm/20200722094558.9828-10-david@redhat.com/
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/x86/mm/init_64.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 98 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 9ecb3c488ac8..7e8de63f02b3 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -871,7 +871,93 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	return add_pages(nid, start_pfn, nr_pages, params);
>  }
>  
> -#define PAGE_INUSE 0xFD
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +#define PAGE_UNUSED 0xFD
> +/*
> + * The unused vmemmap range, which was not yet memset(PAGE_UNUSED) ranges
> + * from unused_pmd_start to next PMD_SIZE boundary.
> + */
> +static unsigned long unused_pmd_start __meminitdata;

This whole 'unused_pmd_start' thing was unmentioned in the changelog.

I also kept reading this and thinking it was a 'pmd_t *', not a 'struct
page *'.  The naming is rather unfortunate that way.

So, is this here so that the memset()s can be avoided?  It's just an
optimization to say: "This is unused, but instead of marking it with
PAGE_UNUSED (which would be slow) I keep a pointer to it"?

> +static void __meminit vmemmap_flush_unused_pmd(void)
> +{
> +	if (!unused_pmd_start)
> +		return;
> +	/*
> +	 * Clears (unused_pmd_start, PMD_END]
> +	 */
> +	memset((void *)unused_pmd_start, PAGE_UNUSED,
> +	       ALIGN(unused_pmd_start, PMD_SIZE) - unused_pmd_start);
> +	unused_pmd_start = 0;
> +}

Oh, and this means: "stop using the unused_pmd_start optimization.  Just
memset the thing".

> +/* Returns true if the PMD is completely unused and thus it can be freed */
> +static bool __meminit vmemmap_unuse_sub_pmd(unsigned long addr, unsigned long end)
> +{
> +	unsigned long start = ALIGN_DOWN(addr, PMD_SIZE);
> +
> +	vmemmap_flush_unused_pmd();

That probably needs a comment like:

	Flush the unused range cache to ensure that the memchr_inv()
	will work for the whole range.

> +	memset((void *)addr, PAGE_UNUSED, end - addr);
> +
> +	return !memchr_inv((void *)start, PAGE_UNUSED, PMD_SIZE);
> +}

Also, logically, it would make a lot of sense if you can move the actual
PMD freeing logic in here.  That way, the caller is just saying, "unuse
this PMD region", and then this takes care of the rest.  As it stands,
it's a bit weird that the caller takes care of the freeing.

> +static void __meminit __vmemmap_use_sub_pmd(unsigned long start)
> +{
> +	/*
> +	 * As we expect to add in the same granularity as we remove, it's
> +	 * sufficient to mark only some piece used to block the memmap page from
> +	 * getting removed when removing some other adjacent memmap (just in
> +	 * case the first memmap never gets initialized e.g., because the memory
> +	 * block never gets onlined).
> +	 */
> +	memset((void *)start, 0, sizeof(struct page));
> +}
> +
> +static void __meminit vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
> +{
> +	/*
> +	 * We only optimize if the new used range directly follows the
> +	 * previously unused range (esp., when populating consecutive sections).
> +	 */
> +	if (unused_pmd_start == start) {
> +		if (likely(IS_ALIGNED(end, PMD_SIZE)))
> +			unused_pmd_start = 0;
> +		else
> +			unused_pmd_start = end;
> +		return;
> +	}
> +
> +	vmemmap_flush_unused_pmd();
> +	__vmemmap_use_sub_pmd(start);
> +}
> +
> +static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
> +{
> +	vmemmap_flush_unused_pmd();
> +
> +	/*
> +	 * Could be our memmap page is filled with PAGE_UNUSED already from a
> +	 * previous remove.
> +	 */
> +	__vmemmap_use_sub_pmd(start);
> +
> +	/*
> +	 * Mark the unused parts of the new memmap range
> +	 */
> +	if (!IS_ALIGNED(start, PMD_SIZE))
> +		memset((void *)start, PAGE_UNUSED,
> +		       start - ALIGN_DOWN(start, PMD_SIZE));
> +	/*
> +	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap of
> +	 * consecutive sections. Remember for the last added PMD the last
> +	 * unused range in the populated PMD.
> +	 */
> +	if (!IS_ALIGNED(end, PMD_SIZE))
> +		unused_pmd_start = end;
> +}
> +#endif
>  
>  static void __meminit free_pagetable(struct page *page, int order)
>  {
> @@ -1006,7 +1092,6 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
>  	unsigned long next, pages = 0;
>  	pte_t *pte_base;
>  	pmd_t *pmd;
> -	void *page_addr;
>  
>  	pmd = pmd_start + pmd_index(addr);
>  	for (; addr < end; addr = next, pmd++) {
> @@ -1027,12 +1112,11 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
>  				spin_unlock(&init_mm.page_table_lock);
>  				pages++;
>  			} else {
> -				/* If here, we are freeing vmemmap pages. */
> -				memset((void *)addr, PAGE_INUSE, next - addr);
> -
> -				page_addr = page_address(pmd_page(*pmd));
> -				if (!memchr_inv(page_addr, PAGE_INUSE,
> -						PMD_SIZE)) {
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +				/*
> +				 * Free the PMD if the whole range is unused.
> +				 */
> +				if (vmemmap_unuse_sub_pmd(addr, next)) {
>  					free_hugepage_table(pmd_page(*pmd),
>  							    altmap);
>  
> @@ -1040,6 +1124,7 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
>  					pmd_clear(pmd);
>  					spin_unlock(&init_mm.page_table_lock);
>  				}
> +#endif
>  			}

This doesn't look like the world's longest if() statement, but it might
be nice to use the IS_ENABLED() syntax instead of an #ifdef.  I suspect
the compiler could even make quick work of the static functions that
never get called as a result.

>  			continue;
> @@ -1492,11 +1577,16 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
>  
>  				addr_end = addr + PMD_SIZE;
>  				p_end = p + PMD_SIZE;
> +
> +				if (!IS_ALIGNED(addr, PMD_SIZE) ||
> +				    !IS_ALIGNED(next, PMD_SIZE))
> +					vmemmap_use_new_sub_pmd(addr, next);
>  				continue;
>  			} else if (altmap)
>  				return -ENOMEM; /* no fallback */
>  		} else if (pmd_large(*pmd)) {
>  			vmemmap_verify((pte_t *)pmd, node, addr, next);
> +			vmemmap_use_sub_pmd(addr, next);
>  			continue;
>  		}
>  		if (vmemmap_populate_basepages(addr, next, node, NULL))
> 

This overall looks like a good thing to do.  The implementation is even
pretty nice and simple. But, it took me an awfully long time to figure
out what was going on.

I wonder if you could take one more pass at these and especially see if
you can better explain the use of 'unused_pmd_start'.
