Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C028630DB6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhBCNhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:37:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232065AbhBCNfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612359245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FwewrJ1tvyEUzunf+cDTiQWAfhlcXzGjEESHCGxVAZ4=;
        b=f7DIdVpPP6wmvWnNrnP+g6yF6GTu/Hjc3yb68F8ois3loOiI6RZltneSdw6dUn3bXqfzmS
        ypT2MONPRZT6iloOEPdAxJTabJ4KygvyKzVqHnsjVYHHWGj02yXmXZn5qbLPbcWruPi0f3
        m3RVti57XrwRCb4tI8gPwhh8f+0HG8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-kNYjUF_qOZ2pJlnjhZEqAg-1; Wed, 03 Feb 2021 08:34:02 -0500
X-MC-Unique: kNYjUF_qOZ2pJlnjhZEqAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 149BA100C660;
        Wed,  3 Feb 2021 13:34:00 +0000 (UTC)
Received: from [10.36.112.222] (ovpn-112-222.ams2.redhat.com [10.36.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88E2277BE3;
        Wed,  3 Feb 2021 13:33:57 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] x86/vmemmap: Drop handling of 1GB vmemmap ranges
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
 <20210203104750.23405-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ec2f6a46-b2a8-8131-a2ac-48a02a1ea201@redhat.com>
Date:   Wed, 3 Feb 2021 14:33:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210203104750.23405-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.21 11:47, Oscar Salvador wrote:
> We never get to allocate 1GB pages when mapping the vmemmap range.
> Drop the dead code both for the aligned and unaligned cases and leave
> only the direct map handling.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> ---
>   arch/x86/mm/init_64.c | 31 ++++---------------------------
>   1 file changed, 4 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index b0e1d215c83e..28729c6b9775 100644
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
> @@ -1072,32 +1071,10 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
>   			continue;
>   
>   		if (pud_large(*pud)) {
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
> +			spin_lock(&init_mm.page_table_lock);
> +			pud_clear(pud);
> +			spin_unlock(&init_mm.page_table_lock);
> +			pages++;
>   			continue;
>   		}

One problem I see with existing code / this change making more obvious 
is that when trying to remove in other granularity than we added (e.g., 
unplug a 128MB DIMM avaialble during boot), we remove the direct map of 
unrelated DIMMs.

I think we should keep the

if (IS_ALIGNED(addr, PUD_SIZE) &&
     IS_ALIGNED(next, PUD_SIZE)) {
...
}

bits. Thoguhts?

Apart from that looks good.

-- 
Thanks,

David / dhildenb

