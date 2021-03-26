Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67AD34A94D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCZOKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230016AbhCZOJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616767769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7QwucvE9nb3RtYI6S5g6QloEEtiiTCmIsioM4emDvQ=;
        b=Z+kRkCuKmAihBi75mpF4KCIB7xOwA6RynJ3dsoD4GGaSRI9D/5x7skHfZIY7xaD/HGbDLD
        F8hBvZkJJkLF8tLrDuE7705xsCjCp+s34WI9zZEk8WQE8wY5gX/4TnafIpf7jxmZPfilOm
        Bk4v8P3kKTOnmK3YlP/au+0RnCN7Nww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-BcaHSwW6Nc6esEc7igM1ag-1; Fri, 26 Mar 2021 10:09:25 -0400
X-MC-Unique: BcaHSwW6Nc6esEc7igM1ag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C793E190D341;
        Fri, 26 Mar 2021 14:09:23 +0000 (UTC)
Received: from [10.36.112.81] (ovpn-112-81.ams2.redhat.com [10.36.112.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9235A5D9DE;
        Fri, 26 Mar 2021 14:09:19 +0000 (UTC)
To:     Aili Yao <yaoaili@kingsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yangfeng1@kingsoft.com, sunhao2@kingsoft.com,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20210317163714.328a038d@alex-virtual-machine>
 <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
 <20210318044600.GJ3420@casper.infradead.org>
 <20210318133412.12078eb7@alex-virtual-machine>
 <20210319104437.6f30e80d@alex-virtual-machine>
 <20210320003516.GC3420@casper.infradead.org>
 <20210322193318.377c9ce9@alex-virtual-machine>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v5] mm/gup: check page hwposion status for coredump.
Message-ID: <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
Date:   Fri, 26 Mar 2021 15:09:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322193318.377c9ce9@alex-virtual-machine>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.21 12:33, Aili Yao wrote:
> When we do coredump for user process signal, this may be one SIGBUS signal
> with BUS_MCEERR_AR or BUS_MCEERR_AO code, which means this signal is
> resulted from ECC memory fail like SRAR or SRAO, we expect the memory
> recovery work is finished correctly, then the get_dump_page() will not
> return the error page as its process pte is set invalid by
> memory_failure().
> 
> But memory_failure() may fail, and the process's related pte may not be
> correctly set invalid, for current code, we will return the poison page,
> get it dumped, and then lead to system panic as its in kernel code.
> 
> So check the hwpoison status in get_dump_page(), and if TRUE, return NULL.
> 
> There maybe other scenario that is also better to check hwposion status
> and not to panic, so make a wrapper for this check, Thanks to David's
> suggestion(<david@redhat.com>).
> 
> Link: https://lkml.kernel.org/r/20210319104437.6f30e80d@alex-virtual-machine
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Aili Yao <yaoaili@kingsoft.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>   mm/gup.c      |  4 ++++
>   mm/internal.h | 20 ++++++++++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index e4c224c..6f7e1aa 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1536,6 +1536,10 @@ struct page *get_dump_page(unsigned long addr)
>   				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
>   	if (locked)
>   		mmap_read_unlock(mm);

Thinking again, wouldn't we get -EFAULT from __get_user_pages_locked() 
when stumbling over a hwpoisoned page?

See __get_user_pages_locked()->__get_user_pages()->faultin_page():

handle_mm_fault()->vm_fault_to_errno(), which translates 
VM_FAULT_HWPOISON to -EFAULT, unless FOLL_HWPOISON is set (-> -EHWPOISON)

?

> +
> +	if (ret == 1 && is_page_hwpoison(page))
> +		return NULL;
> +
>   	return (ret == 1) ? page : NULL;
>   }
>   #endif /* CONFIG_ELF_CORE */
> diff --git a/mm/internal.h b/mm/internal.h
> index 25d2b2439..b751cef 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -97,6 +97,26 @@ static inline void set_page_refcounted(struct page *page)
>   	set_page_count(page, 1);
>   }
>   
> +/*
> + * When kernel touch the user page, the user page may be have been marked
> + * poison but still mapped in user space, if without this page, the kernel
> + * can guarantee the data integrity and operation success, the kernel is
> + * better to check the posion status and avoid touching it, be good not to
> + * panic, coredump for process fatal signal is a sample case matching this
> + * scenario. Or if kernel can't guarantee the data integrity, it's better
> + * not to call this function, let kernel touch the poison page and get to
> + * panic.
> + */
> +static inline bool is_page_hwpoison(struct page *page)
> +{
> +	if (PageHWPoison(page))
> +		return true;
> +	else if (PageHuge(page) && PageHWPoison(compound_head(page)))
> +		return true;
> +
> +	return false;
> +}
> +
>   extern unsigned long highest_memmap_pfn;
>   
>   /*
> 


-- 
Thanks,

David / dhildenb

