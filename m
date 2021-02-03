Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D14E30DB54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhBCNbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231493AbhBCNbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612358983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kyct1BXITFcuhoO2Hiui7Y3EdjNkgvu7ji5riFNhbs4=;
        b=RvYr4cDGTsApbg+276BcEWetHhStKUoJIFH2kUJFkRYKy3E+CdnvviuSwB9lScEOzQUuWO
        1wqnh2q98MwfdJqJOkR+7gYmhF11tRXzxTqCvt7ng1WegbKz8I5SvDFJj++CovUWTrp/3V
        fZiYrf2JP8oIsFyQMnyAU0zt3HA/UzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-eFmn_GcyMHi7ep49nKdizw-1; Wed, 03 Feb 2021 08:29:38 -0500
X-MC-Unique: eFmn_GcyMHi7ep49nKdizw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D85B1180A099;
        Wed,  3 Feb 2021 13:29:31 +0000 (UTC)
Received: from [10.36.112.222] (ovpn-112-222.ams2.redhat.com [10.36.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0ECE5D9E3;
        Wed,  3 Feb 2021 13:29:28 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] x86/vmemmap: Drop handling of 4K unaligned vmemmap
 range
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
References: <20210203104750.23405-1-osalvador@suse.de>
 <20210203104750.23405-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6355eb93-db4e-9e4f-557d-e10a053721a1@redhat.com>
Date:   Wed, 3 Feb 2021 14:29:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210203104750.23405-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.21 11:47, Oscar Salvador wrote:
> remove_pte_table() is prepared to handle the case where either the
> start or the end of the range is not PAGE aligned.
> This cannot actually happen:
> 
> __populate_section_memmap enforces the range to be PMD aligned,
> so as long as the size of the struct page remains multiple of 8,
> the vmemmap range will be aligned to PAGE_SIZE.
> 
> Drop the dead code and place a VM_BUG_ON in vmemmap_{populate,free}
> to catch nasty cases.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> ---
>   arch/x86/mm/init_64.c | 48 ++++++++++++-------------------------------
>   1 file changed, 13 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index b5a3fa4033d3..b0e1d215c83e 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -962,7 +962,6 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
>   {
>   	unsigned long next, pages = 0;
>   	pte_t *pte;
> -	void *page_addr;
>   	phys_addr_t phys_addr;
>   
>   	pte = pte_start + pte_index(addr);
> @@ -983,42 +982,15 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
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
> +		if (!direct)
> +			free_pagetable(pte_page(*pte), 0);
>   
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
> -
> -			page_addr = page_address(pte_page(*pte));
> -			if (!memchr_inv(page_addr, PAGE_INUSE, PAGE_SIZE)) {
> -				free_pagetable(pte_page(*pte), 0);
> +		spin_lock(&init_mm.page_table_lock);
> +		pte_clear(&init_mm, addr, pte);
> +		spin_unlock(&init_mm.page_table_lock);
>   
> -				spin_lock(&init_mm.page_table_lock);
> -				pte_clear(&init_mm, addr, pte);
> -				spin_unlock(&init_mm.page_table_lock);
> -			}
> -		}
> +		/* For non-direct mapping, pages means nothing. */
> +		pages++;
>   	}
>   
>   	/* Call free_pte_table() in remove_pmd_table(). */
> @@ -1197,6 +1169,9 @@ remove_pagetable(unsigned long start, unsigned long end, bool direct,
>   void __ref vmemmap_free(unsigned long start, unsigned long end,
>   		struct vmem_altmap *altmap)
>   {
> +	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> +	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> +
>   	remove_pagetable(start, end, false, altmap);
>   }
>   
> @@ -1556,6 +1531,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>   {
>   	int err;
>   
> +	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> +	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> +
>   	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
>   		err = vmemmap_populate_basepages(start, end, node, NULL);
>   	else if (boot_cpu_has(X86_FEATURE_PSE))
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

