Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007E93F4A73
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhHWMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235092AbhHWMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629720911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VuOutErs/3kz1A1Pl67QiGCXKD6+QoIdF+PyPh/HBMQ=;
        b=h4/jI115ybfTJVxlfEzTCgcbqlTEhjaRBvLztBQk5JhL1/PFMN9K3+PFRbr5Wpwcs4y9To
        sC8vlXKjofDYcuOz6I+gxx9eDRTQ3b3oLciEVfDqOx0SuK9192Wr55Ad8H8ik7irqV5H0z
        3yIYdrgniEVHNJaOM9MRzdfg736DAms=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-G_80OA5TMauyF0T70Bs8hA-1; Mon, 23 Aug 2021 08:15:10 -0400
X-MC-Unique: G_80OA5TMauyF0T70Bs8hA-1
Received: by mail-wm1-f71.google.com with SMTP id z15-20020a7bc7cf0000b02902e6a68ffd3cso4396061wmk.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VuOutErs/3kz1A1Pl67QiGCXKD6+QoIdF+PyPh/HBMQ=;
        b=g3AeqNdliVo45qqIdKIhY4oKiSwT0EV74Gr1tp1RywseiMeo/UJcbELblRaVsi9FRY
         s7vGcS584K+YU+nmiXty51dlDFr9Kl0X6Z0CbVrm/jaQZQ9Fc63OYlCm9d+lysABEWAQ
         z0uBNJBQwCPv3jxg/iSgPtjiXWPlKB0tRF16lny1K6LyUq9KKAGHmKOhP3ani0dYv+o8
         vWNEJT6aruOqun4Spdr36bGWAvIX8iyJSXeBOQ8C037skNTfEwNeIHWNxEQ9RD5EWwOT
         AXwoOYYDcACgANM91Eg5oDBhh0Zx7qMcrlOcvLL9KFuAGr6E9rlP6K82+Xxw3F/l+92i
         MF2w==
X-Gm-Message-State: AOAM530Lk3yFwCxfApHJKgU227c/2mFLRkSUx2FeojSJBbUX2Xh3Iyk/
        RZ3dxuXeSOzvqio9eAjjB9AX8SspeKBe1nu77fC+gDTOGyZeJFQ2azMrPhQ7JZszrIBJpF2Du7v
        HZUfrEEBhjP1STo25RI851WyBTVMXZeVL7sNC5cWyNv4wvD6vM2CGfhmobTeNktWzPjRRzz6x
X-Received: by 2002:a05:600c:198a:: with SMTP id t10mr15935406wmq.181.1629720909068;
        Mon, 23 Aug 2021 05:15:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybW+zWaolHk2FOUq8+ktueTloCfvGnGzVnfvj/5DjB8RzaLv8qwIpkvrwgPCfE+Yd6cxsUqQ==
X-Received: by 2002:a05:600c:198a:: with SMTP id t10mr15935376wmq.181.1629720908785;
        Mon, 23 Aug 2021 05:15:08 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id d9sm15001473wrw.26.2021.08.23.05.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 05:15:08 -0700 (PDT)
Subject: Re: [PATCH 2/3] mm/memory_hotplug: fix potential permanent lru cache
 disable
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@suse.com, minchan@kernel.org,
        cgoldswo@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210821094246.10149-1-linmiaohe@huawei.com>
 <20210821094246.10149-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <985b591a-ef1f-cbbe-c627-a17240dc7bb6@redhat.com>
Date:   Mon, 23 Aug 2021 14:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210821094246.10149-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.08.21 11:42, Miaohe Lin wrote:
> If offline_pages failed after lru_cache_disable(), it forgot to do
> lru_cache_enable() in error path. So we would have lru cache disabled
> permanently in this case.
> 
> Fixes: d479960e44f2 ("mm: disable LRU pagevec during the migration temporarily")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/memory_hotplug.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d986d3791986..9fd0be32a281 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -2033,6 +2033,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>   	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
>   	memory_notify(MEM_CANCEL_OFFLINE, &arg);
>   failed_removal_pcplists_disabled:
> +	lru_cache_enable();
>   	zone_pcp_enable(zone);
>   failed_removal:
>   	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

As mentioned, this should be backported to stable.

-- 
Thanks,

David / dhildenb

