Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6460136ECC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbhD2OxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233128AbhD2OxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619707941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6lxQeZ3rFbs3JiKojmdVgu0t7tnrrD3u7eTUsMmffGw=;
        b=NJHzKmBS+3ePGyB3bvOwDqAbxlwb/ILXZW5JUIitF+bs8Ui2TX/q8Sss6UA3qqrBX8x5hq
        FsXhpKoV9pWvk9EK02Do8sVfh7KGy5snyBt18xNxw+NidGtyqxZgP099Gqtt9sLkzfiwdV
        LsBFc++yQIDuZpb92fGlTqibxxGhOGI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-vkLdZ2W7O16qZpMV81iLsw-1; Thu, 29 Apr 2021 10:52:19 -0400
X-MC-Unique: vkLdZ2W7O16qZpMV81iLsw-1
Received: by mail-wm1-f70.google.com with SMTP id g17-20020a05600c0011b029014399f816a3so1478168wmc.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6lxQeZ3rFbs3JiKojmdVgu0t7tnrrD3u7eTUsMmffGw=;
        b=XUOYHYq3F9/lbV2EIWYgyDOw3PfuPz02afw1+ewyTyCnydtHJyioQzffjUIM4qnKPM
         xfBx51xmPHpsVmkzYieJqtQQrUMFiw4BjzVYrUtciHJbZzOxs+DhQKsdVRXvDdXBIOIH
         r/OFZrFp0pJQWagBIdXRNxxJHuvpYhqzGz695f1igDPVchHJtbPrvvtQ3lnMMzjapRCc
         DnhfcHB32vxS8PEPO8ns6Yu3BUvaU9hrWrZONcNAsU8Qm19oWWG/U3Bn9eZsaKJjfT+v
         Lvs6DK9weekHyLw2WedsbkwmCxe/fRXf+S/iXACJNUfabbyiwVZuTpAWzm5bnsTcsh+z
         JRRw==
X-Gm-Message-State: AOAM5331xVZgs7OaMgSQyCQ50wJLoAPU/VyzZ6TQJP7FZ99N5Jsf7d9c
        XdnWlOj3gSBLeSHvlWziX4IBioobpmDaS5q0mMtxy7dZzaZ2VDItizbmsfJpj7rgbVemCH92ODd
        6z9TbuzqnBkxJ9IJ94lsRBcqo
X-Received: by 2002:a05:600c:ac2:: with SMTP id c2mr436213wmr.23.1619707937997;
        Thu, 29 Apr 2021 07:52:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzREobSjw9+ep7qp65Qsyqe0mmsMCMmXyHmNKtRFVawQb8jsvu7DTK65VQQ9/FC2uyyK6KgEw==
X-Received: by 2002:a05:600c:ac2:: with SMTP id c2mr436189wmr.23.1619707937796;
        Thu, 29 Apr 2021 07:52:17 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6158.dip0.t-ipconnect.de. [91.12.97.88])
        by smtp.gmail.com with ESMTPSA id p18sm5105591wrs.68.2021.04.29.07.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 07:52:17 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] mm/huge_memory.c: use page->deferred_list
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, william.kucharski@oracle.com, willy@infradead.org,
        yang.shi@linux.alibaba.com, aneesh.kumar@linux.ibm.com,
        rcampbell@nvidia.com, songliubraving@fb.com,
        kirill.shutemov@linux.intel.com, riel@surriel.com,
        hannes@cmpxchg.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210429132648.305447-1-linmiaohe@huawei.com>
 <20210429132648.305447-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7b0d3d84-02fc-e913-e894-740fc1b704e9@redhat.com>
Date:   Thu, 29 Apr 2021 16:52:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210429132648.305447-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 15:26, Miaohe Lin wrote:
> Now that we can represent the location of ->deferred_list instead of
> ->mapping + ->index, make use of it to improve readability.
> 
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/huge_memory.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..76ca1eb2a223 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2868,7 +2868,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>   	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>   	/* Take pin on all head pages to avoid freeing them under us */
>   	list_for_each_safe(pos, next, &ds_queue->split_queue) {
> -		page = list_entry((void *)pos, struct page, mapping);
> +		page = list_entry((void *)pos, struct page, deferred_list);
>   		page = compound_head(page);
>   		if (get_page_unless_zero(page)) {
>   			list_move(page_deferred_list(page), &list);
> @@ -2883,7 +2883,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>   	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>   
>   	list_for_each_safe(pos, next, &list) {
> -		page = list_entry((void *)pos, struct page, mapping);
> +		page = list_entry((void *)pos, struct page, deferred_list);
>   		if (!trylock_page(page))
>   			goto next;
>   		/* split_huge_page() removes page from list on success */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

