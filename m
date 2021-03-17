Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7833EC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCQJMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229862AbhCQJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615972331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXOs6mZAlCWSvaMfHmcycfvIXW875uH92/u8ZDv0UJo=;
        b=AO0Bo50vIVfYWeZ8fSt0JOzXHq5qvfo/7EvNI2+vpf5alOBQ663cN4SFZrtBWZbv6O79eF
        lmQGiMcZkhHrq714/6NVcMO8XKTFtkM0uY2mZSpz1pphMZyCB/1efgy5ZcYQ7UydBwAEl7
        NvYrAYzPcbDmUcAINQ2FoxspAG/JkQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-wIq3b8rqOYmoDSvdR4gktg-1; Wed, 17 Mar 2021 05:12:08 -0400
X-MC-Unique: wIq3b8rqOYmoDSvdR4gktg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D6F69393E;
        Wed, 17 Mar 2021 09:12:06 +0000 (UTC)
Received: from [10.36.112.124] (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E3055D9C0;
        Wed, 17 Mar 2021 09:12:03 +0000 (UTC)
Subject: Re: [PATCH] mm/gup: check page posion status for coredump.
To:     Aili Yao <yaoaili@kingsoft.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yangfeng1@kingsoft.com, sunhao2@kingsoft.com,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20210317163714.328a038d@alex-virtual-machine>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
Date:   Wed, 17 Mar 2021 10:12:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317163714.328a038d@alex-virtual-machine>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.21 09:37, Aili Yao wrote:
> When we do coredump for user process signal, this may be an SIGBUS signal
> with BUS_MCEERR_AR or BUS_MCEERR_AO code, which means this signal is
> resulted from ECC memory fail like SRAR or SRAO, we expect the memory
> recovery work is finished correctly, then the get_dump_page() will not
> return the error page as its process pte is set invalid by
> memory_failure().
> 
> But memory_failure() may fail, and the process's related pte may not be
> correctly set invalid, for current code, we will return the poison page
> and get it dumped and lead to system panic as its in kernel code.
> 
> So check the poison status in get_dump_page(), and if TRUE, return NULL.
> 
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> ---
>   mm/gup.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index e4c224c..499a496 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1536,6 +1536,14 @@ struct page *get_dump_page(unsigned long addr)
>   				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
>   	if (locked)
>   		mmap_read_unlock(mm);
> +
> +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) && ret == 1) {
> +		if (unlikely(PageHuge(page) && PageHWPoison(compound_head(page))))
> +			ret = 0;
> +		else if (unlikely(PageHWPoison(page)))
> +			ret = 0;
> +	}

I wonder if a simple

if (PageHWPoison(compound_head(page)))
	ret = 0;

won't suffice. But I guess the "issue" is compound pages that are not 
huge pages or transparent huge pages.

If not, we certainly want a wrapper for that magic, otherwise we have to 
replicate the same logic all over the place.

> +
>   	return (ret == 1) ? page : NULL;
>   }
>   #endif /* CONFIG_ELF_CORE */
> 


-- 
Thanks,

David / dhildenb

