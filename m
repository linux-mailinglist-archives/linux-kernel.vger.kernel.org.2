Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E23A1115
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbhFIKbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235588AbhFIKbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623234589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJKYvOGfDayI4ypz9NAHeg8C4iNhTE3Xb47rb4M/evg=;
        b=iIdlpVCchbbkxBRywuUDJlDowGg9GdpTNo5wrI33rKD4x1KEDb6POAqKcXdtuFz/4K0u3U
        90c6XqWR3KAmunMB9x/3e9Z3/jleBKZCiJDpE4xPL+5NPWfzNplsPe0JKLrP5S20kh2E2Z
        RdNW3lowlwm5h9iZ7Ht09rOh1yzcko0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-PmF0IuE-MV6PWkKVZkA2aw-1; Wed, 09 Jun 2021 06:29:47 -0400
X-MC-Unique: PmF0IuE-MV6PWkKVZkA2aw-1
Received: by mail-wr1-f70.google.com with SMTP id m27-20020a056000025bb0290114d19822edso10572309wrz.21
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AJKYvOGfDayI4ypz9NAHeg8C4iNhTE3Xb47rb4M/evg=;
        b=tsxA7I5z8uW/qrWgulQzDrbKOcNl4YwNVALY4uXU0ckidZ67VeHJUsOpaaVcQNH6ke
         PC29f6ZZSNibPS5JdANK6r0vSEGNEVmsLllyNcbYhWYaqKP6o0bFxMowICAmCwOs2Lgb
         LLG2YVVBH9fZx9GwE1Y/gYNCMwziurKeKwUWfS851yL8M73tgG20hG172Lziv7KhuGYD
         eUvIg67w5UK/X6SmcNOaEB5JFJ3ZT4Q9ao7PJ7OFi3kXRAG/lfLTeZbD9u7XGheicuoa
         OmpeLYbSKueDyCUYtiGkPCM0s+g8jQs+1EbCq4TNor6Qa8Vl1ATWJD1WN378IxWniHnv
         PIDA==
X-Gm-Message-State: AOAM533/UrBebI0ICVNnj5QGl7K6rhFW+tTOQdhqOx3i4Y5AH7f8FmjZ
        8xVSTNS0iOxJCTGnpH7wr0NxWBLPWDh/+3vNhLHZn+PEZAoXKgD0wOoIq6OTm0CS5K+i8ur22UO
        vB9efXG1tAwNAyW6wAeN+XDKq/kXT6N9Ny2CZvyMvjcHNZ3v3IpjbxP/jIvZPp6N2znLejH9C
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr26158573wmk.54.1623234586795;
        Wed, 09 Jun 2021 03:29:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCfBKsc2hGpGgzPI6TcBFUmWxmoZcYpHa6oSIzEs8X7cR/V+42wF1QK1U6zdDyobK3zOUdiQ==
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr26158555wmk.54.1623234586577;
        Wed, 09 Jun 2021 03:29:46 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id y8sm5616010wmi.45.2021.06.09.03.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:29:46 -0700 (PDT)
Subject: Re: [PATCH] mm/page_alloc: fix counting of managed_pages
To:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        yangerkun <yangerkun@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210527125707.3760259-1-liushixin2@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <24751c12-b43e-7860-015b-09d204e6e397@redhat.com>
Date:   Wed, 9 Jun 2021 12:29:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210527125707.3760259-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.05.21 14:57, Liu Shixin wrote:
> The commit f63661566fad (mm/page_alloc.c: clear out zone->lowmem_reserve[]
> if the zone is empty) clear out zone->lowmem_reserve[] if zone is empty.
> But when zone is not empty and sysctl_lowmem_reserve_ratio[i] is set to zero,
> zone_managed_pages(zone) is not counted in the managed_pages either. This is
> inconsistent with the description of lowmen_reserve, so fix it.
> 
> Fixes: f63661566fad ("mm/page_alloc.c: clear out zone->lowmem_reserve[] if the zone is empty")
> Reported-by: yangerkun <yangerkun@huawei.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>   mm/page_alloc.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index aaa1655cf682..49a2efce5a84 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8061,14 +8061,14 @@ static void setup_per_zone_lowmem_reserve(void)
>   			unsigned long managed_pages = 0;
>   
>   			for (j = i + 1; j < MAX_NR_ZONES; j++) {
> -				if (clear) {
> -					zone->lowmem_reserve[j] = 0;
> -				} else {
> -					struct zone *upper_zone = &pgdat->node_zones[j];
> +				struct zone *upper_zone = &pgdat->node_zones[j];
> +
> +				managed_pages += zone_managed_pages(upper_zone);
>   
> -					managed_pages += zone_managed_pages(upper_zone);
> +				if (clear)
> +					zone->lowmem_reserve[j] = 0;
> +				else
>   					zone->lowmem_reserve[j] = managed_pages / ratio;
> -				}
>   			}
>   		}
>   	}
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

