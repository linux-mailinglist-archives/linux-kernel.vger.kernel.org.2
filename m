Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19ABD3CB79D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbhGPNBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236294AbhGPNBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626440292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjFVjJ9jlDmNbP8AD/NSiTAOAWlIu9GruBGLqG/Mukg=;
        b=gPl6h4BtrJet6mEGjs1DgUf98VtpI+lqxQMpWq6lQYiBMvP3mo1EmQ7JfZma9dlzYvt8o6
        Vdo2qgoVI9kIidocTqRPIeivkMtwKtL+1ZkoJj9kHM83AOC6xWq+cEGR2mj14yW4s/iq5r
        Rxs6TQSjcqN5x7lnD26/vb9vlzQNi5g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-Dln6anZ1PdmzWlaXrqgBBg-1; Fri, 16 Jul 2021 08:58:11 -0400
X-MC-Unique: Dln6anZ1PdmzWlaXrqgBBg-1
Received: by mail-wr1-f72.google.com with SMTP id d9-20020adffbc90000b029011a3b249b10so4758365wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 05:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KjFVjJ9jlDmNbP8AD/NSiTAOAWlIu9GruBGLqG/Mukg=;
        b=YwieWKWOahcqDTXNQZ8ddwmxdC2zvC41OjMcXbqtWLVTgQsgIZDuPFmb4Szb+MpQBF
         fZti1Doa4zlZQXWDo5xbT6jn5zids7Z8JN2HeTOZf17kds2XzvymfYFriwVyOlZrjlKq
         8sodnjnNceE0X31TZCPUVy60H3IJxC69al3RT9itaDtIlhSwguKpeBihQYoTpRR2OM8A
         uaBUZmyi3er1PDCI+37RiUuVHv8v28nNXmvDuNBNzGiuw/LXldz1sNvRUxeIhvreZ2so
         Z22ncG+YS020aUGR720144DZ3I3FCM9LGI5VZiVkzwPHmfEUQMABpEfvqO4bRD2ezecC
         vtug==
X-Gm-Message-State: AOAM531yhvKimu8+xK+Z1bE/LKcOsiBQ7lORZ3xoWOlzQgfnLlOlX9bq
        Epbrixw8i7htNQwl+OpI899xOwhO0Ld0BtGNVBsCLRX8Ow2enMpjvKN2p6dPzYc9/pmTodECyeP
        0xyouMiIDhePNuSMPaGi4r5LwUGxdHBa+HilgJFcc57ONgVUNXKJ7G0+eq5VhNbz/R+iBgpIM
X-Received: by 2002:a7b:c150:: with SMTP id z16mr16304090wmi.104.1626440290400;
        Fri, 16 Jul 2021 05:58:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2JL1Gw4adDvdYjazPsy1G3KUxKBf3eKKGPwrDHBDWTknfSWtgRQC8b9hbaZYN8jG1XR2FUA==
X-Received: by 2002:a7b:c150:: with SMTP id z16mr16304068wmi.104.1626440290212;
        Fri, 16 Jul 2021 05:58:10 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c621f.dip0.t-ipconnect.de. [91.12.98.31])
        by smtp.gmail.com with ESMTPSA id e3sm10163965wra.15.2021.07.16.05.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 05:58:09 -0700 (PDT)
Subject: Re: [PATCH 2/3] mm/vmstat: simplify the array size calculation
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210715122911.15700-1-linmiaohe@huawei.com>
 <20210715122911.15700-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <79fb76da-f811-7030-abd6-1dd970e7ab53@redhat.com>
Date:   Fri, 16 Jul 2021 14:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715122911.15700-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.21 14:29, Miaohe Lin wrote:
> We can replace the array_num * sizeof(array[0]) with sizeof(array) to
> simplify the code.

Could have mentioned taht your fixing indentation of one "return true;"

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/vmstat.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 57e8e7fda7aa..76aef9510f6d 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1889,17 +1889,15 @@ static bool need_update(int cpu)
>   		/*
>   		 * The fast way of checking if there are any vmstat diffs.
>   		 */
> -		if (memchr_inv(pzstats->vm_stat_diff, 0, NR_VM_ZONE_STAT_ITEMS *
> -			       sizeof(pzstats->vm_stat_diff[0])))
> +		if (memchr_inv(pzstats->vm_stat_diff, 0, sizeof(pzstats->vm_stat_diff)))
>   			return true;
>   
>   		if (last_pgdat == zone->zone_pgdat)
>   			continue;
>   		last_pgdat = zone->zone_pgdat;
>   		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
> -		if (memchr_inv(n->vm_node_stat_diff, 0, NR_VM_NODE_STAT_ITEMS *
> -			       sizeof(n->vm_node_stat_diff[0])))
> -		    return true;
> +		if (memchr_inv(n->vm_node_stat_diff, 0, sizeof(n->vm_node_stat_diff)))
> +			return true;
>   	}
>   	return false;
>   }
> 


-- 
Thanks,

David / dhildenb

