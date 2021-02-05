Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC5310677
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhBEIR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:17:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231640AbhBEIRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612512940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4IDZRK/m8IaLtY1N+dlfiekFNzwDKCGyPsbAx0sv8Q=;
        b=R2oh12KgLubIeSmLYDpz732BXhtf9YnTv5Why0ytreNN9avtZvqcvsuzSa6igADrQnoCIV
        p9lJl1sQKRPVlk4bczQ2ekOWA2nT63z3l0ka6DIwZHs2cnd75FlFHlQU1Tw/9sALONKg50
        4VM7TJ0psRUFjAjJsFLuIjjxGzkKRXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-AHE4xkEQPfeQO88hUCP7Rw-1; Fri, 05 Feb 2021 03:15:37 -0500
X-MC-Unique: AHE4xkEQPfeQO88hUCP7Rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D434F804022;
        Fri,  5 Feb 2021 08:15:35 +0000 (UTC)
Received: from [10.36.113.156] (ovpn-113-156.ams2.redhat.com [10.36.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BECC91A26A;
        Fri,  5 Feb 2021 08:15:34 +0000 (UTC)
Subject: Re: [PATCH v2] mm/hugetlb: remove redundant check in preparing and
 destroying gigantic page
To:     yanfei.xu@windriver.com, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210202112002.73170-1-yanfei.xu@windriver.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2f54a29c-9d81-e8bd-2d37-779cb2be6b21@redhat.com>
Date:   Fri, 5 Feb 2021 09:15:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210202112002.73170-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.21 12:20, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> Gigantic page is a compound page and its order is more than 1.
> Thus it must be available for hpage_pincount. Let's remove the
> redundant check for gigantic page.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>   mm/hugetlb.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a3e4fa2c5e94..dac5db569ccb 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1219,8 +1219,7 @@ static void destroy_compound_gigantic_page(struct page *page,
>   	struct page *p = page + 1;
>   
>   	atomic_set(compound_mapcount_ptr(page), 0);
> -	if (hpage_pincount_available(page))
> -		atomic_set(compound_pincount_ptr(page), 0);
> +	atomic_set(compound_pincount_ptr(page), 0);
>   
>   	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>   		clear_compound_head(p);
> @@ -1501,9 +1500,7 @@ static void prep_compound_gigantic_page(struct page *page, unsigned int order)
>   		set_compound_head(p, page);
>   	}
>   	atomic_set(compound_mapcount_ptr(page), -1);
> -
> -	if (hpage_pincount_available(page))
> -		atomic_set(compound_pincount_ptr(page), 0);
> +	atomic_set(compound_pincount_ptr(page), 0);
>   }
>   
>   /*
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

