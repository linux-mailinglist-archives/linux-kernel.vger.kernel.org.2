Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5943C6E00
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhGMJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235591AbhGMJ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626170101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQUA4XjWtFIdSS44lKXsaGZ9gPXuO/+EtKLUDI1CWwM=;
        b=YDKSIxOQM15E4m/EgIlmtEmgRjik3MLDbYx6NECf7VrBy1jhBbqhErKd2MbNs7ePE3I1TR
        AQ/bRIT4V71KSbdLhyc6FvbTBV954oX/VhZgY0+hVZ2yHx4rAIHgT41R62Pfoh33NIT1SG
        244nTDS6rHpBTCTbhUsh1ki+KL7Twy4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-VJ27dwzIP3GMLwt5hju92Q-1; Tue, 13 Jul 2021 05:54:15 -0400
X-MC-Unique: VJ27dwzIP3GMLwt5hju92Q-1
Received: by mail-wr1-f72.google.com with SMTP id p4-20020a5d63840000b0290126f2836a61so8529695wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 02:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UQUA4XjWtFIdSS44lKXsaGZ9gPXuO/+EtKLUDI1CWwM=;
        b=b0m0e3LKSjil84K2PgMDZfigHH2l7k6a2YTxSyRYNImgAJqHsd9Y+Zq0Lj+hVIen+K
         0P6U57EZb9j5aSQCVxRwdZ/OGCIL79t8Wdl7jBYxmkclTrQTw9aWhbhLwhsisMQ6VfuY
         1z2pDQTj7URIjC5jyoinp6viBjOUsCGfQfWq+zj+Pr7xD3LKlE2yAG2tduJ3rBNyK+73
         JEHv+Il1dmCnkqhbx8XVofuZ2nCwp6IO+Cit4Vncc/ZIvZarffEU+JABsVZXMSifvICB
         gTguCv3JfQ1KbzeDQ9qTPwo+ChwfTRBiDCYeapuVs8biX8+hrsaNmHAVjwTBwpcmaW82
         hnlA==
X-Gm-Message-State: AOAM533UXfAn1t/rlmn5nDlaHewUyfK60SeyFPsMHSmzS0gIc/gUJMBm
        33fGGYYcl+PHVVmlyvOBuxbM7r+W6/JKSSm7hR9QrKHYKJEzPHRYdzYOpkQPiJWPCnyIj1wWhtd
        Q8d+VVcVeJM5U7WubQWT2FoHd
X-Received: by 2002:a05:6000:144b:: with SMTP id v11mr4512148wrx.421.1626170049891;
        Tue, 13 Jul 2021 02:54:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUXJjGiSggIjjcS6mq/dEYjjpH3o8CCaZ3jV8jrdUq7JJeLM6LbE8+nzPbmFjA63jBsHlWVQ==
X-Received: by 2002:a05:6000:144b:: with SMTP id v11mr4512130wrx.421.1626170049725;
        Tue, 13 Jul 2021 02:54:09 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id c2sm896405wrs.60.2021.07.13.02.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 02:54:09 -0700 (PDT)
Subject: Re: [PATCH 2/2] mm: memory_hotplug: cleanup after removal of
 pfn_valid_within()
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210713080035.7464-1-rppt@kernel.org>
 <20210713080035.7464-3-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <96c061b4-c9cf-f481-5319-f26464435eb6@redhat.com>
Date:   Tue, 13 Jul 2021 11:54:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713080035.7464-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.21 10:00, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> When test_pages_in_a_zone() used pfn_valid_within() is has some logic
> surrounding pfn_valid_within() checks.
> 
> Since pfn_valid_within() is gone, this logic can be removed.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   mm/memory_hotplug.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1085bd03ecba..ca09045bb587 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1298,7 +1298,7 @@ struct zone *test_pages_in_a_zone(unsigned long start_pfn,
>   	unsigned long pfn, sec_end_pfn;
>   	struct zone *zone = NULL;
>   	struct page *page;
> -	int i;
> +
>   	for (pfn = start_pfn, sec_end_pfn = SECTION_ALIGN_UP(start_pfn + 1);
>   	     pfn < end_pfn;
>   	     pfn = sec_end_pfn, sec_end_pfn += PAGES_PER_SECTION) {
> @@ -1307,13 +1307,10 @@ struct zone *test_pages_in_a_zone(unsigned long start_pfn,
>   			continue;
>   		for (; pfn < sec_end_pfn && pfn < end_pfn;
>   		     pfn += MAX_ORDER_NR_PAGES) {
> -			i = 0;
> -			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
> -				continue;
>   			/* Check if we got outside of the zone */
> -			if (zone && !zone_spans_pfn(zone, pfn + i))
> +			if (zone && !zone_spans_pfn(zone, pfn))
>   				return NULL;
> -			page = pfn_to_page(pfn + i);
> +			page = pfn_to_page(pfn);
>   			if (zone && page_zone(page) != zone)
>   				return NULL;
>   			zone = page_zone(page);
> 

I'd just squash that into the previous commit.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

