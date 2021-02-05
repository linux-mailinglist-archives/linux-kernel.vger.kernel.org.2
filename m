Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCF43106A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBEI2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:28:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229496AbhBEI2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612513599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oDMQ6BYUDWHg8nMQB3rlhW/i1MEjtZA4avHL+byLM6c=;
        b=e6HEAIeKffYlFNjEkapC1dzBcOJvOzJnuUmLJqm1JpJNvkC0UH+wkJmYVvvBVxNFRzfSvQ
        9yVNKlXpUs9XLsvHWiSdhZYXdIQJCJFYKNif5J3QtSnLZjH82sF+1TF4rKHmYRZhLvrlXX
        npBAsf7RG5tXW1NgslZMvPu1iPRFy/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-4fosFxWWPOWdlATZ_79JpQ-1; Fri, 05 Feb 2021 03:26:34 -0500
X-MC-Unique: 4fosFxWWPOWdlATZ_79JpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA0481083E8F;
        Fri,  5 Feb 2021 08:26:31 +0000 (UTC)
Received: from [10.36.113.156] (ovpn-113-156.ams2.redhat.com [10.36.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35F6510016F5;
        Fri,  5 Feb 2021 08:26:29 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210204134325.7237-1-osalvador@suse.de>
 <20210204134325.7237-4-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v3 3/3] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <41c06727-dda6-0154-fa31-51b0764005bb@redhat.com>
Date:   Fri, 5 Feb 2021 09:26:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210204134325.7237-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.21 14:43, Oscar Salvador wrote:
> When the size of a struct page is not multiple of 2MB, sections do
> not span a PMD anymore and so when populating them some parts of the
> PMD will remain unused.
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
> ---
>   arch/x86/mm/init_64.c | 106 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 98 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 9ecb3c488ac8..7e8de63f02b3 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -871,7 +871,93 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   	return add_pages(nid, start_pfn, nr_pages, params);
>   }
>   
> -#define PAGE_INUSE 0xFD
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +#define PAGE_UNUSED 0xFD
> +
> +/*
> + * The unused vmemmap range, which was not yet memset(PAGE_UNUSED) ranges
> + * from unused_pmd_start to next PMD_SIZE boundary.
> + */
> +static unsigned long unused_pmd_start __meminitdata;
> +
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
> +
> +/* Returns true if the PMD is completely unused and thus it can be freed */
> +static bool __meminit vmemmap_unuse_sub_pmd(unsigned long addr, unsigned long end)
> +{
> +	unsigned long start = ALIGN_DOWN(addr, PMD_SIZE);
> +
> +	vmemmap_flush_unused_pmd();
> +	memset((void *)addr, PAGE_UNUSED, end - addr);
> +
> +	return !memchr_inv((void *)start, PAGE_UNUSED, PMD_SIZE);
> +}
> +
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
>   static void __meminit free_pagetable(struct page *page, int order)
>   {
> @@ -1006,7 +1092,6 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
>   	unsigned long next, pages = 0;
>   	pte_t *pte_base;
>   	pmd_t *pmd;
> -	void *page_addr;
>   
>   	pmd = pmd_start + pmd_index(addr);
>   	for (; addr < end; addr = next, pmd++) {
> @@ -1027,12 +1112,11 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
>   				spin_unlock(&init_mm.page_table_lock);
>   				pages++;
>   			} else {
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
>   					free_hugepage_table(pmd_page(*pmd),
>   							    altmap);
>   
> @@ -1040,6 +1124,7 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
>   					pmd_clear(pmd);
>   					spin_unlock(&init_mm.page_table_lock);
>   				}
> +#endif
>   			}
>   
>   			continue;
> @@ -1492,11 +1577,16 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
>   
>   				addr_end = addr + PMD_SIZE;
>   				p_end = p + PMD_SIZE;
> +
> +				if (!IS_ALIGNED(addr, PMD_SIZE) ||
> +				    !IS_ALIGNED(next, PMD_SIZE))
> +					vmemmap_use_new_sub_pmd(addr, next);
>   				continue;
>   			} else if (altmap)
>   				return -ENOMEM; /* no fallback */
>   		} else if (pmd_large(*pmd)) {
>   			vmemmap_verify((pte_t *)pmd, node, addr, next);
> +			vmemmap_use_sub_pmd(addr, next);
>   			continue;
>   		}
>   		if (vmemmap_populate_basepages(addr, next, node, NULL))
> 

LGTM, thanks

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

