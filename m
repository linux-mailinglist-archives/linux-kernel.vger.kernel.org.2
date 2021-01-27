Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A92305735
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhA0Joq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:44:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58369 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235381AbhA0Jl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611740428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bh5ngCAk4+IwsMtkkrTBoRFwgeLTplyt2bjbip6O240=;
        b=OmmEEt+6U5iI/yP0B4kbzE2JVR8p7tX1bzVMDYZPnyoErONtCp0Oo9WISZLuOsByjT2beh
        WUx+Pijkj2JUi5ugEs8l4Nhc9H9VMj0w0jdp6Zu1YIx9hcZMMc1l+07VeSEtG0u139U0Kt
        R6kWD6wzUI1n5FPpDf7DFIX/Y757vYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-66zrOZuWOdy7ujW7KztTjQ-1; Wed, 27 Jan 2021 04:40:26 -0500
X-MC-Unique: 66zrOZuWOdy7ujW7KztTjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 476B3190A7A0;
        Wed, 27 Jan 2021 09:40:25 +0000 (UTC)
Received: from [10.36.114.237] (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B9A65C5FD;
        Wed, 27 Jan 2021 09:40:23 +0000 (UTC)
Subject: Re: [PATCH] mm/memory_hotplug: use helper function zone_end_pfn() to
 get end_pfn
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210127093211.37714-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9e15556f-8535-d8ae-d5b1-db264d377c20@redhat.com>
Date:   Wed, 27 Jan 2021 10:40:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210127093211.37714-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.21 10:32, Miaohe Lin wrote:
> Commit 108bcc96ef70 ("mm: add & use zone_end_pfn() and zone_spans_pfn()")
> introduced the helper zone_end_pfn() to calculate the zone end pfn.  But
> update_pgdat_span() forgot to use it. Use this helper and re-name local
> variable zone_end_pfn to end_pfn to fix below compilation error:
> 
> mm/memory_hotplug.c: In function ‘update_pgdat_span’:
> mm/memory_hotplug.c:448:32: error: called object ‘zone_end_pfn’ is not a
> function or function pointer
>     unsigned long zone_end_pfn = zone_end_pfn(zone);
>                                  ^~~~~~~~~~~~
> mm/memory_hotplug.c:448:17: note: declared here
>     unsigned long zone_end_pfn = zone_end_pfn(zone);
>                   ^~~~~~~~~~~~
> 

Please don't talk about compilation issues your changes introduce in 
that detail, that's just confusing and looks like something would 
already be broken. Please simplify to something like

"Let's use zone_end_pfn(zone). We have to rename the local variable to 
avoid an identifier clash (variable vs. function)."

With that

Reviewed-by: David Hildenbrand <david@redhat.com>

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/memory_hotplug.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 710e469fb3a1..0483db52b85f 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -493,20 +493,19 @@ static void update_pgdat_span(struct pglist_data *pgdat)
>   
>   	for (zone = pgdat->node_zones;
>   	     zone < pgdat->node_zones + MAX_NR_ZONES; zone++) {
> -		unsigned long zone_end_pfn = zone->zone_start_pfn +
> -					     zone->spanned_pages;
> +		unsigned long end_pfn = zone_end_pfn(zone);
>   
>   		/* No need to lock the zones, they can't change. */
>   		if (!zone->spanned_pages)
>   			continue;
>   		if (!node_end_pfn) {
>   			node_start_pfn = zone->zone_start_pfn;
> -			node_end_pfn = zone_end_pfn;
> +			node_end_pfn = end_pfn;
>   			continue;
>   		}
>   
> -		if (zone_end_pfn > node_end_pfn)
> -			node_end_pfn = zone_end_pfn;
> +		if (end_pfn > node_end_pfn)
> +			node_end_pfn = end_pfn;
>   		if (zone->zone_start_pfn < node_start_pfn)
>   			node_start_pfn = zone->zone_start_pfn;
>   	}
> 


-- 
Thanks,

David / dhildenb

