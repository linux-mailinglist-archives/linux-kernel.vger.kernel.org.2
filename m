Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3F30BF45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhBBNWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:22:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231670AbhBBNWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612272046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/60teeEdPgl7qYScyFSquW5ice+PAw0Sozx+qSY1fA=;
        b=LnLqifO/BW3hu/esX4liPTQwI+zyfWm9506ROU0OQ+3iuwwRBt8r8OmDjTPJtzskEpWV0F
        VSUgRqnjc5aytUH0qbw93ObotFrziy2tePizgeCLP4OL+g43MqFKPSGG5nB07pmc4CsYdf
        N4OijV80TLtUndV5LXG/woA6LrAIEyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-Rw45LFaRNMiiDaV9Q4vU3w-1; Tue, 02 Feb 2021 08:20:42 -0500
X-MC-Unique: Rw45LFaRNMiiDaV9Q4vU3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABBFC801817;
        Tue,  2 Feb 2021 13:20:40 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 313465C1CF;
        Tue,  2 Feb 2021 13:20:37 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210202112450.11932-1-osalvador@suse.de>
 <20210202112450.11932-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH 1/2] x86/vmemmap: Remove !PAGE_ALIGNED case in
 remove_pte_table
Message-ID: <1d8ca669-6c92-4692-b2c7-1bfaa6f9707e@redhat.com>
Date:   Tue, 2 Feb 2021 14:20:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210202112450.11932-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -962,7 +962,6 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
>   {
>   	unsigned long next, pages = 0;
>   	pte_t *pte;
> -	void *page_addr;
>   	phys_addr_t phys_addr;
>   
>   	pte = pte_start + pte_index(addr);
> @@ -983,42 +982,19 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
>   		if (phys_addr < (phys_addr_t)0x40000000)
>   			return;
>   
> -		if (PAGE_ALIGNED(addr) && PAGE_ALIGNED(next)) {
> -			/*
> -			 * Do not free direct mapping pages since they were
> -			 * freed when offlining, or simplely not in use.
> -			 */
> -			if (!direct)
> -				free_pagetable(pte_page(*pte), 0);
> -
> -			spin_lock(&init_mm.page_table_lock);
> -			pte_clear(&init_mm, addr, pte);
> -			spin_unlock(&init_mm.page_table_lock);
> -
> -			/* For non-direct mapping, pages means nothing. */
> -			pages++;
> -		} else {
> -			/*
> -			 * If we are here, we are freeing vmemmap pages since
> -			 * direct mapped memory ranges to be freed are aligned.
> -			 *
> -			 * If we are not removing the whole page, it means
> -			 * other page structs in this page are being used and
> -			 * we canot remove them. So fill the unused page_structs
> -			 * with 0xFD, and remove the page when it is wholly
> -			 * filled with 0xFD.
> -			 */
> -			memset((void *)addr, PAGE_INUSE, next - addr);
> +		/*
> +		 * Do not free direct mapping pages since they were
> +		 * freed when offlining, or simplely not in use.
> +		 */

s/simplely/simply/ (I know, not your fault :) )

However, that comment is highly confusing. There is nothing to free in 
case of the a direct mapping; we never allocated anything. That's how a 
direct map works.

I'd just get rid of the comment completely - we also don't have one at 
the other "if (!direct)" places.


(side note: all this freeing before unmapping looks very weird, but at 
least we should have valid accesses anymore)

> +		if (!direct)
> +			free_pagetable(pte_page(*pte), 0);

[...]

>   {
> +	/*
> +	 * See comment in vmemmap_populate().
> +	 */

I'd drop this comment ...

> +	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> +	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> +
>   	remove_pagetable(start, end, false, altmap);
>   }
>   
> @@ -1556,6 +1538,15 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>   {
>   	int err;
>   
> +	/*
> +	 * __populate_section_memmap enforces the range to be added to be
> +	 * PMD aligned. Therefore we can be sure that, as long as the
> +	 * struct page size is multiple of 8, the vmemmap range will be
> +	 * PAGE aligned.
> +	 */

... and this comment, moving the details into the patch description.

The commit should be easy to detect using git blame in case anybody 
wonders why.

> +	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> +	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> +
>   	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
>   		err = vmemmap_populate_basepages(start, end, node, NULL);
>   	else if (boot_cpu_has(X86_FEATURE_PSE))
> 

Apart from that looks good, thanks!

-- 
Thanks,

David / dhildenb

