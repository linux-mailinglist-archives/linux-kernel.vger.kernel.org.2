Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A938A408AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbhIMMQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237106AbhIMMQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631535328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2p5SDD6IORI+fInxe4LBTCv8TDK2jhwukd7jpIldoU=;
        b=H3z+jgX3Y6D2RDkKriqjEnnBV3g+KfTjaMgRrwaXE/eUzPKpGx/jJSyCAZHVEElHv8Wd3x
        tNUoIjyL0NVRqiyElUXxwEeycoCirkgEH+21smqAlVxbVbKxEDtlXIKjz2jy9Chna2fOUh
        isbbbKFMd5bbS9Ws0w4DhxVCgKq0pbM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-AU5bb8LDPDWmdzh4FriIwQ-1; Mon, 13 Sep 2021 08:15:27 -0400
X-MC-Unique: AU5bb8LDPDWmdzh4FriIwQ-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so4849127wmj.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 05:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y2p5SDD6IORI+fInxe4LBTCv8TDK2jhwukd7jpIldoU=;
        b=eh1qtInrCfBm4Phurg3cOlXP+51+phWOAoqniCjLPP3TGkiZdrlmRGXRzJnfSB1kyx
         tYW6gPHNZIQIb1mjnUE563iVMhxUVmKB9a/AM3paAwXLrRXy3wQwa8IR8uOeEI+srofb
         Tb2i6Tcep3ySVMPvg4Nf5OzRkmV53OuoYeCHX14Vs0qxte9z5h98HdG8f6pLPeR7zQoq
         rDF8EpvPvWvPFgpIS9+biNbyD0J3JZyE0lgP8zWpNB/kSnvONV8pCrcYHvx2weiy/Ugm
         O8/oC3ZKBJR9bDnUruPWzPfK/EW8O0NjWeZQ7W2LvBlW5yQLz6aRv785OQG2MhqlmuUy
         MFkg==
X-Gm-Message-State: AOAM532LEF7EYs6zZ/sXCWf+TgGeVJ430YIS2PxsPWSfy1WZRv9c0tYa
        oogH/Dwtf0xYTQ7OkUuqVZCupCrRpVutDsr2NIs3L591geFABPXSHkO4u7GnLy9G6qnEphyu2VI
        dTfuYkTrRgnrrZGLYSF8JbDfOR+TbJVz8vz8oj7PagdNuaHD4758QWqswDtauFWOVwYn8aPLB
X-Received: by 2002:adf:eb89:: with SMTP id t9mr12555017wrn.66.1631535326648;
        Mon, 13 Sep 2021 05:15:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCxFO6DKktrj8lKNb1+U4fp7k8BOq4Ntk4gLy+hpqYduDMn4fqB/UjPSNSs1Kk2rNklNZzRg==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr12554979wrn.66.1631535326400;
        Mon, 13 Sep 2021 05:15:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6576.dip0.t-ipconnect.de. [91.12.101.118])
        by smtp.gmail.com with ESMTPSA id m3sm9583281wrg.45.2021.09.13.05.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 05:15:26 -0700 (PDT)
Subject: Re: [PATCH v2] mm/page_isolation: don't putback unisolated page
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     jhubbard@nvidia.com, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210913115021.27597-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6a096a23-83b8-139d-b2dd-87ea3e405050@redhat.com>
Date:   Mon, 13 Sep 2021 14:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210913115021.27597-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.21 13:50, Miaohe Lin wrote:
> If __isolate_free_page() failed, due to zone watermark check, the page is
> still on the free list. But this page will be put back to free list again
> via __putback_isolated_page() now. This may trigger page->flags checks in
> __free_one_page() if PageReported is set. Or we will corrupt the free list
> because list_add() will be called for pages already on another list.
> 
> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v1->v2:
>    Add VM_WARN_ON to catch unexpected isolating failure.
> ---
>   mm/page_isolation.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index f93cc63d8fa1..f67c4c70f17f 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -94,8 +94,13 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>   			buddy = page + (buddy_pfn - pfn);
>   
>   			if (!is_migrate_isolate_page(buddy)) {
> -				__isolate_free_page(page, order);
> -				isolated_page = true;
> +				isolated_page = !!__isolate_free_page(page, order);
> +				/*
> +				 * Isolating a free page in an isolated pageblock
> +				 * is expected to always work as watermarks don't
> +				 * apply here.
> +				 */
> +				VM_WARN_ON(!isolated_page);


Didn't we discuss that this can never happen?

In that case, the patch description+subject needs updating and the 
"Fixes" line would be wrong.

>   			}
>   		}
>   	}
> 


-- 
Thanks,

David / dhildenb

