Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284DE30BBC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhBBKIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:08:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231217AbhBBKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612260374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DznrvedIFVUd6PchGLao8qCBfJlVvrS8p4p4tPArn88=;
        b=Kz1sRfCJ6B0Hp9CQGfbePH2iWg+p2r7Psy7eiPIdDvTPn3FNQh0IdIYMI2u9kchi0t60wK
        UWTyBo1XKCmT1oJDQlraG5FmElIukUEB59tIXXwP2GIhGxom5dColbYMiCr96/W5jL0iJZ
        xCzbPj8Ipg8Et/oboH7NvpdfyEjuh3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-oevE_YrLOaCiD8FqNbOscA-1; Tue, 02 Feb 2021 05:06:13 -0500
X-MC-Unique: oevE_YrLOaCiD8FqNbOscA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C403D59;
        Tue,  2 Feb 2021 10:06:11 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B07C15D9C6;
        Tue,  2 Feb 2021 10:06:10 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: remove a meaningless if statement in gigantic
 page initialization
To:     yanfei.xu@windriver.com, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210202101209.72795-1-yanfei.xu@windriver.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <18d3db7b-da3c-db14-ab99-b2c966c70024@redhat.com>
Date:   Tue, 2 Feb 2021 11:06:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210202101209.72795-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.21 11:12, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> Gigantic page is a compound page and its order is more than 1.
> Thus it must be available for hpage_pincount. Let's remove this
> meaningless if statement.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>   mm/hugetlb.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a3e4fa2c5e94..73d602f8c7e2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1501,9 +1501,7 @@ static void prep_compound_gigantic_page(struct page *page, unsigned int order)
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

I can spot similar handling in destroy_compound_gigantic_page(). If this 
is correct (which I think it is), we should tackle both occurrences at once.

-- 
Thanks,

David / dhildenb

