Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AC9337A07
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhCKQwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:52:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229699AbhCKQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615481518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2oUQOTqIayM7rAUTJf2DiLhfIeUSxHLTZHaHhcXdXXQ=;
        b=g6C1xG6ssOdu43RQFSWWzv+6mho64H6u9eGwX6H+UrwCdYuwg0go6um4IZZDkjq8TZESZy
        z3TnaT2JlYgk2oDVwhmnv5fiWAZHr/2flikzAvqML8tYHXnTzq5yWzzkSk235LYvSm0yDv
        BlM4cJLBtu+sK9xBxDcq14rdkvK/cYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-ZN6jh1fsMMyibfMV9z6d5A-1; Thu, 11 Mar 2021 11:51:56 -0500
X-MC-Unique: ZN6jh1fsMMyibfMV9z6d5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5306E83DEA6;
        Thu, 11 Mar 2021 16:51:55 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4289560BE5;
        Thu, 11 Mar 2021 16:51:54 +0000 (UTC)
Subject: Re: [PATCH] mm/highmem.c: fix coding style issue
To:     songqiang <songqiang@uniontech.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210311095015.14277-1-songqiang@uniontech.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <96db7761-b332-a1c2-f13c-a09ecd46705e@redhat.com>
Date:   Thu, 11 Mar 2021 17:51:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311095015.14277-1-songqiang@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.21 10:50, songqiang wrote:
> Delete/add some blank lines and some blank spaces
> 
> Signed-off-by: songqiang <songqiang@uniontech.com>
> ---
>   mm/highmem.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/highmem.c b/mm/highmem.c
> index 1352a27951e3..902154b76030 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -110,7 +110,7 @@ EXPORT_SYMBOL(_totalhigh_pages);
>   
>   EXPORT_PER_CPU_SYMBOL(__kmap_atomic_idx);
>   
> -unsigned int nr_free_highpages (void)
> +unsigned int nr_free_highpages(void)
>   {
>   	struct zone *zone;
>   	unsigned int pages = 0;
> @@ -126,7 +126,7 @@ unsigned int nr_free_highpages (void)
>   static int pkmap_count[LAST_PKMAP];
>   static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(kmap_lock);
>   
> -pte_t * pkmap_page_table;
> +pte_t *pkmap_page_table;
>   
>   /*
>    * Most architectures have no use for kmap_high_get(), so let's abstract
> @@ -153,6 +153,7 @@ struct page *kmap_to_page(void *vaddr)
>   
>   	if (addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP)) {
>   		int i = PKMAP_NR(addr);
> +
>   		return pte_page(pkmap_page_table[i]);
>   	}
>   
> @@ -287,9 +288,8 @@ void *kmap_high(struct page *page)
>   	pkmap_count[PKMAP_NR(vaddr)]++;
>   	BUG_ON(pkmap_count[PKMAP_NR(vaddr)] < 2);
>   	unlock_kmap();
> -	return (void*) vaddr;
> +	return (void *) vaddr;
>   }
> -
>   EXPORT_SYMBOL(kmap_high);
>   
>   #ifdef ARCH_NEEDS_KMAP_HIGH_GET
> @@ -314,7 +314,7 @@ void *kmap_high_get(struct page *page)
>   		pkmap_count[PKMAP_NR(vaddr)]++;
>   	}
>   	unlock_kmap_any(flags);
> -	return (void*) vaddr;
> +	return (void *) vaddr;
>   }
>   #endif
>   
> @@ -367,7 +367,6 @@ void kunmap_high(struct page *page)
>   	if (need_wakeup)
>   		wake_up(pkmap_map_wait);
>   }
> -
>   EXPORT_SYMBOL(kunmap_high);
>   #endif	/* CONFIG_HIGHMEM */
>   
> @@ -431,7 +430,6 @@ void *page_address(const struct page *page)
>   	spin_unlock_irqrestore(&pas->lock, flags);
>   	return ret;
>   }
> -
>   EXPORT_SYMBOL(page_address);
>   
>   /**
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

