Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E81345BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhCWK3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229986AbhCWK3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616495372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yv7PG4QWv9fYzw7ppRGgMc3QDAT6qa+i0kHDZN8WyOo=;
        b=ROFB+1DVx1I//OEnwzHhQtGfgyPg+inWrV3BAHdkDsKwg7VmPyihbbe7nRcbAqK9Gf7hUT
        o9ccpGa/aUrf/m5AhFZU6UkxP/BkwiVqU0IfZ/D+O9gBboPfPRZuE2ZOB0eOJ4wv3qtd88
        AV6ULrh9oTKvhgVI45lOG9ZnsFPbRc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-HEzIDiXMPcGtuWXjeS5idw-1; Tue, 23 Mar 2021 06:29:28 -0400
X-MC-Unique: HEzIDiXMPcGtuWXjeS5idw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9F169CC1A;
        Tue, 23 Mar 2021 10:29:26 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8965D6E6F5;
        Tue, 23 Mar 2021 10:29:25 +0000 (UTC)
Subject: Re: [PATCH 4/5] mm/migrate.c: use helper migrate_vma_collect_skip()
 in migrate_vma_collect_hole()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     jglisse@redhat.com, shy828301@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210320093701.12829-1-linmiaohe@huawei.com>
 <20210320093701.12829-5-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ebeda43a-e1c2-0c7c-50ba-4129e3198b7f@redhat.com>
Date:   Tue, 23 Mar 2021 11:29:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210320093701.12829-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.21 10:37, Miaohe Lin wrote:
> It's more recommended to use helper function migrate_vma_collect_skip() to
> skip the unexpected case and it also helps remove some duplicated codes.
> Move migrate_vma_collect_skip() above migrate_vma_collect_hole() to avoid
> compiler warning.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/migrate.c | 28 +++++++++++-----------------
>   1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 271081b014cb..3e169b72d7b2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2315,44 +2315,38 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>   #endif /* CONFIG_NUMA */
>   
>   #ifdef CONFIG_DEVICE_PRIVATE
> -static int migrate_vma_collect_hole(unsigned long start,
> +static int migrate_vma_collect_skip(unsigned long start,
>   				    unsigned long end,
> -				    __always_unused int depth,
>   				    struct mm_walk *walk)
>   {
>   	struct migrate_vma *migrate = walk->private;
>   	unsigned long addr;
>   
> -	/* Only allow populating anonymous memory. */
> -	if (!vma_is_anonymous(walk->vma)) {
> -		for (addr = start; addr < end; addr += PAGE_SIZE) {
> -			migrate->src[migrate->npages] = 0;
> -			migrate->dst[migrate->npages] = 0;
> -			migrate->npages++;
> -		}
> -		return 0;
> -	}
> -
>   	for (addr = start; addr < end; addr += PAGE_SIZE) {
> -		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
>   		migrate->dst[migrate->npages] = 0;
> -		migrate->npages++;
> -		migrate->cpages++;
> +		migrate->src[migrate->npages++] = 0;
>   	}
>   
>   	return 0;
>   }
>   
> -static int migrate_vma_collect_skip(unsigned long start,
> +static int migrate_vma_collect_hole(unsigned long start,
>   				    unsigned long end,
> +				    __always_unused int depth,
>   				    struct mm_walk *walk)
>   {
>   	struct migrate_vma *migrate = walk->private;
>   	unsigned long addr;
>   
> +	/* Only allow populating anonymous memory. */
> +	if (!vma_is_anonymous(walk->vma))
> +		return migrate_vma_collect_skip(start, end, walk);
> +
>   	for (addr = start; addr < end; addr += PAGE_SIZE) {
> +		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
>   		migrate->dst[migrate->npages] = 0;
> -		migrate->src[migrate->npages++] = 0;
> +		migrate->npages++;
> +		migrate->cpages++;
>   	}
>   
>   	return 0;
> 


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

