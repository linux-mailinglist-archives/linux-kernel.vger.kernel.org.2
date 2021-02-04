Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A51030F747
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhBDQI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237821AbhBDQHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612454783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqu3nubRknQwVla7Lm/qvXqpA+VrKpvkZVGZAWBUJUA=;
        b=PqUOwBHKMBImgk0w8RyPoA9eodgGMLwRzLGDXUZRtXz54EPE4QPAN0pYxWZUz5ZMD8m0LG
        q4miCzWKc6FGphOiqTCV/jzwdgcFeyqWRQM0YX3CCFB6FnwvI+cSHK6u4zeX60LJHq750q
        6j3aTayGCI/aRoWF9XjFPijXrpheJ8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-Jjrjb4s3O0y9biNVITvwhg-1; Thu, 04 Feb 2021 11:06:19 -0500
X-MC-Unique: Jjrjb4s3O0y9biNVITvwhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DC8E801962;
        Thu,  4 Feb 2021 16:06:17 +0000 (UTC)
Received: from [10.36.113.146] (ovpn-113-146.ams2.redhat.com [10.36.113.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9214E60C9B;
        Thu,  4 Feb 2021 16:06:14 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] x86/vmemmap: Drop handling of 1GB vmemmap ranges
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
 <20210204134325.7237-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <89b5e714-c352-81c2-429b-cd057a18a5a0@redhat.com>
Date:   Thu, 4 Feb 2021 17:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210204134325.7237-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.21 14:43, Oscar Salvador wrote:
> We never get to allocate 1GB pages when mapping the vmemmap range.
> Drop the dead code both for the aligned and unaligned cases and leave
> only the direct map handling.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> ---
>   arch/x86/mm/init_64.c | 35 +++++++----------------------------
>   1 file changed, 7 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index b0e1d215c83e..9ecb3c488ac8 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1062,7 +1062,6 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
>   	unsigned long next, pages = 0;
>   	pmd_t *pmd_base;
>   	pud_t *pud;
> -	void *page_addr;
>   
>   	pud = pud_start + pud_index(addr);
>   	for (; addr < end; addr = next, pud++) {
> @@ -1071,33 +1070,13 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
>   		if (!pud_present(*pud))
>   			continue;
>   
> -		if (pud_large(*pud)) {
> -			if (IS_ALIGNED(addr, PUD_SIZE) &&
> -			    IS_ALIGNED(next, PUD_SIZE)) {
> -				if (!direct)
> -					free_pagetable(pud_page(*pud),
> -						       get_order(PUD_SIZE));
> -
> -				spin_lock(&init_mm.page_table_lock);
> -				pud_clear(pud);
> -				spin_unlock(&init_mm.page_table_lock);
> -				pages++;
> -			} else {
> -				/* If here, we are freeing vmemmap pages. */
> -				memset((void *)addr, PAGE_INUSE, next - addr);
> -
> -				page_addr = page_address(pud_page(*pud));
> -				if (!memchr_inv(page_addr, PAGE_INUSE,
> -						PUD_SIZE)) {
> -					free_pagetable(pud_page(*pud),
> -						       get_order(PUD_SIZE));
> -
> -					spin_lock(&init_mm.page_table_lock);
> -					pud_clear(pud);
> -					spin_unlock(&init_mm.page_table_lock);
> -				}
> -			}
> -
> +		if (pud_large(*pud) &&
> +		    IS_ALIGNED(addr, PUD_SIZE) &&
> +		    IS_ALIGNED(next, PUD_SIZE)) {
> +			spin_lock(&init_mm.page_table_lock);
> +			pud_clear(pud);
> +			spin_unlock(&init_mm.page_table_lock);
> +			pages++;
>   			continue;
>   		}
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

