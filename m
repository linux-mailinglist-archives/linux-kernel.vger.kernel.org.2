Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777603F4A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbhHWMPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235358AbhHWMPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629720863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEjMQGX1KeHQQA6Fe8o+7SRlCmyC/TIhEiJOh7GRbZM=;
        b=GnB76PkdGpr0OHFDgM26y4NFVo6i6mlvY9QqXD2gcswRHV1e0x2Zyj2qY73v0rD9svY2tz
        q0RYZwjs/hMCckrCgplc/LEaB8k3DJbC3QIHbBb9ROWmG3+rk9JAyMbqcg/r9N+O/ByFY/
        63de8as8TGVzjFzqYmIxwmm0Y6k9YGs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-dv65t_ktPAGTgwf56wBxvQ-1; Mon, 23 Aug 2021 08:14:21 -0400
X-MC-Unique: dv65t_ktPAGTgwf56wBxvQ-1
Received: by mail-wm1-f70.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so8386293wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WEjMQGX1KeHQQA6Fe8o+7SRlCmyC/TIhEiJOh7GRbZM=;
        b=RCEFbCKXHf3G9QurS7+9KbwJiH+9cU9Mvd9mPy3fXHyArV1vh3lrSViwG5t6QkY8kB
         QGUi+2xLde6uQYa04g/BRBxFa+17coI5xwZ6U2utjB69BqxbC/roac3O+ZPokhGaM68v
         MWpvBs5N/GmPWIB1UBCWFFnlXWU0z9fSPBkX6Fbofq45qhDTk6x9OO7+B0Z6isVJqzLH
         KGv/BwpmSEZDMMfB76bd4g+brPObBZT/dFeYxYCcwfk23m0XjLLF7ZdNmYwIzW6g/Ncz
         6sIOinrgPuXW/hvWCOWIPQcJ2WzaF4kDNWUqPHYSa09AtbAnkFxPZRC7WHQEMfKNAw8j
         lpvA==
X-Gm-Message-State: AOAM530lV+e8JgJe6SORsL8g/Uu+95rfaLptdZn5jBBGH24+6eAFmC7v
        4HpngcMeUrbijAmgFK9NMHI8vnAoCaUi6a4ejDFOm8oqXCja5wvm1Qz1SPt4O2goX9S/7+4uSUM
        ZdI3w4UfTLKKsJCcL1glUs4xR8xQYcn2bd5i8F+iGgHvHBXqBBpnFNXliybpe952/MNYUGVIs
X-Received: by 2002:a1c:4cd:: with SMTP id 196mr3108867wme.10.1629720860616;
        Mon, 23 Aug 2021 05:14:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykF11071BQXfbt/Dl9bGIDAF3TpneD8dS1A2Y1BfOFYHYb40BEohvshrBi+sgGfxgS3p+kqQ==
X-Received: by 2002:a1c:4cd:: with SMTP id 196mr3108831wme.10.1629720860376;
        Mon, 23 Aug 2021 05:14:20 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id 129sm13099311wmz.26.2021.08.23.05.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 05:14:20 -0700 (PDT)
Subject: Re: [PATCH 1/3] mm/memory_hotplug: use helper zone_is_zone_device()
 to simplify the code
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@suse.com, minchan@kernel.org,
        cgoldswo@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210821094246.10149-1-linmiaohe@huawei.com>
 <20210821094246.10149-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <31b111bd-82e6-7cb1-3bd4-590ff2963a83@redhat.com>
Date:   Mon, 23 Aug 2021 14:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210821094246.10149-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.08.21 11:42, Miaohe Lin wrote:
> Use helper zone_is_zone_device() to simplify the code and remove some
> explicit CONFIG_ZONE_DEVICE codes.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/memory_hotplug.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b287ff3d7229..d986d3791986 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -477,15 +477,13 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
>   				 sizeof(struct page) * cur_nr_pages);
>   	}
>   
> -#ifdef CONFIG_ZONE_DEVICE
>   	/*
>   	 * Zone shrinking code cannot properly deal with ZONE_DEVICE. So
>   	 * we will not try to shrink the zones - which is okay as
>   	 * set_zone_contiguous() cannot deal with ZONE_DEVICE either way.
>   	 */
> -	if (zone_idx(zone) == ZONE_DEVICE)
> +	if (zone_is_zone_device(zone))
>   		return;
> -#endif
>   
>   	clear_zone_contiguous(zone);
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

