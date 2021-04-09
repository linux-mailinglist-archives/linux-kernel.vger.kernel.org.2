Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21453597C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhDIIYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231370AbhDIIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617956663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZBU0P5qEZI2XAQHiBBHkCAjyC6MXnqauZxTSWZ9IvE=;
        b=MPtK3c8nkyIsFoYUdZ9aEuWfYKmkqIZEYfHstOnTqWh7a3s0l2lA4TgwDG0w3Zu7JAgLeD
        +VlJAW+Ok8SYRYNrvbXN8+swZ+kfUleEMOuYYoEaqzImPEAi7VYOVjrTOAXm22mgNQPaFN
        mL9zxaE7RC8yrFUsV1BdpmikyOuVRrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-ykjAZNWTOhKv9lnMVfhQsA-1; Fri, 09 Apr 2021 04:24:21 -0400
X-MC-Unique: ykjAZNWTOhKv9lnMVfhQsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F9D418B9F50;
        Fri,  9 Apr 2021 08:24:20 +0000 (UTC)
Received: from [10.36.115.11] (ovpn-115-11.ams2.redhat.com [10.36.115.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 721C719C66;
        Fri,  9 Apr 2021 08:24:19 +0000 (UTC)
Subject: Re: [PATCH] mm/page_alloc: Ensure that HUGETLB_PAGE_ORDER is less
 than MAX_ORDER
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1617947717-2424-1-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5a92f302-1917-1374-a8c7-0badb9ec1b8c@redhat.com>
Date:   Fri, 9 Apr 2021 10:24:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617947717-2424-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.21 07:55, Anshuman Khandual wrote:
> pageblock_order must always be less than MAX_ORDER, otherwise it might lead
> to an warning during boot. A similar problem got fixed on arm64 platform
> with the commit 79cc2ed5a716 ("arm64/mm: Drop THP conditionality from
> FORCE_MAX_ZONEORDER"). Assert the above condition before HUGETLB_PAGE_ORDER
> gets assigned as pageblock_order. This will help detect the problem earlier
> on platforms where HUGETLB_PAGE_SIZE_VARIABLE is enabled.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   mm/page_alloc.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 604dcd69397b..81b7460e1228 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7068,10 +7068,17 @@ void __init set_pageblock_order(void)
>   	if (pageblock_order)
>   		return;
>   
> -	if (HPAGE_SHIFT > PAGE_SHIFT)
> +	if (HPAGE_SHIFT > PAGE_SHIFT) {
> +		/*
> +		 * pageblock_order must always be less than
> +		 * MAX_ORDER. So does HUGETLB_PAGE_ORDER if
> +		 * that is being assigned here.
> +		 */
> +		WARN_ON(HUGETLB_PAGE_ORDER >= MAX_ORDER);

Can't that be a BUILD_BUG_ON() ?

>   		order = HUGETLB_PAGE_ORDER;
> -	else
> +	} else {
>   		order = MAX_ORDER - 1;
> +	}
>   
>   	/*
>   	 * Assume the largest contiguous order of interest is a huge page.
> 


-- 
Thanks,

David / dhildenb

