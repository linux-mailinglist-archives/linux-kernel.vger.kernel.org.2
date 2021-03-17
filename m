Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6234F33EF56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhCQLQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229960AbhCQLP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615979756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GFyEZNWKonRodWhCRVOl3ZSa9WnT0DrLppB1MwFbx2w=;
        b=R7YG6ClG09J5dmyRQFPDewe0BOMGhaa4KoOlmeepZMeo15mIybwR08L3G2CRWtG0bYb14A
        c6Kw6ta1zTxYK8Bx0UsimQGbGZno+1qEc2cOsbRMk5MgM+BQAWR0C66JagFxG/fBft1tIj
        oehLvOVFAUZCTcuiB7n3pqxmqIJ0k4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-BBbtoLJxNJW1XzY-sQAIjQ-1; Wed, 17 Mar 2021 07:15:54 -0400
X-MC-Unique: BBbtoLJxNJW1XzY-sQAIjQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71C1B107B7C4;
        Wed, 17 Mar 2021 11:15:51 +0000 (UTC)
Received: from [10.36.112.124] (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 170795D74F;
        Wed, 17 Mar 2021 11:15:48 +0000 (UTC)
Subject: Re: [PATCH v5 5/5] mm,page_alloc: Drop unnecessary checks from
 pfn_range_valid_contig
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-6-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <001bc29f-ba70-b8f3-c77d-61345e30c0d7@redhat.com>
Date:   Wed, 17 Mar 2021 12:15:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317111251.17808-6-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.21 12:12, Oscar Salvador wrote:
> pfn_range_valid_contig() bails out when it finds an in-use page or a
> hugetlb page, among other things.
> We can drop the in-use page check since __alloc_contig_pages can migrate
> away those pages, and the hugetlb page check can go too since
> isolate_migratepages_range is now capable of dealing with hugetlb pages.
> Either way, those checks are racy so let the end function handle it
> when the time comes.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/page_alloc.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4cb455355f6d..50d73e68b79e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8685,12 +8685,6 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>   
>   		if (PageReserved(page))
>   			return false;
> -
> -		if (page_count(page) > 0)
> -			return false;
> -
> -		if (PageHuge(page))
> -			return false;
>   	}
>   	return true;
>   }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

