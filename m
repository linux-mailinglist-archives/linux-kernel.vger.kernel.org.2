Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A088537BC59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhELMRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231367AbhELMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620821806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TF0XD7Wknxks/ruabeXwBqFpm/WqgQbDrPxUmrMQUjA=;
        b=H/XcqfSImh3sIZOSOgppgkNC3EADkxUUI7WEAcgeeWtOt/OJRKLroKbxk3FfcOe9pplLyD
        DU/ClGPA5JgJbGspqGy+wCrfDOWvWkWy6/O1OiVT0ZW3l7vE1aOgxSpc12c4K0VByB6qrI
        5Dnlovg8mZKmeh5VZO3ZM7BTYNrm5A8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-ZlCP-KjBOiyiw6VQa1iaVA-1; Wed, 12 May 2021 08:16:45 -0400
X-MC-Unique: ZlCP-KjBOiyiw6VQa1iaVA-1
Received: by mail-ed1-f69.google.com with SMTP id g19-20020a0564021813b029038811907178so12697960edy.14
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TF0XD7Wknxks/ruabeXwBqFpm/WqgQbDrPxUmrMQUjA=;
        b=eLwWBL5FJlpp7Y7LfXEQVVTbo1Ojsj2Na7nKPTal/ZRORhxp3lqGdUn2yt4vpUYyeq
         NjLFTJWgQDG6PqLx5p9dwjo6S74o/sWe/Zq5g2vAv3ExPzE4czHPLpa5ZhocrZ/3ucQ2
         wRtXFk+n1YElGfpUq1qjJkqg37+JLzRWICOZLjWKp9X+ypQ+a6WWMdK2+qq9TFYbLnbL
         TKSZE/eWUZit+NQBg0eVAd+7FqnoN+wsms6cq9rgvslcxaJ1GXawrC605XZaiNf5CjJg
         UaS5InEsa5LwpAnyi94if75h+j4puVQFhrIOVEgUzXQrt/OZiwrN9ADqdSEt+O+kPWai
         dYGw==
X-Gm-Message-State: AOAM5329c1Mf2899hauF1k9k/MGrggAMbnaaEhOHAYW/VjRvjaRZxYWz
        QDux2P4CJX9SDIizbSPKuqYAGBjNrUMyOAHa1jiKSqECv8nxP0JTE50kFIyQpciea9PRVFxWva7
        cCM3e7jSKUPoGW50dkYdg9qnO
X-Received: by 2002:a05:6402:7c7:: with SMTP id u7mr42632436edy.2.1620821803826;
        Wed, 12 May 2021 05:16:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFqU024A/+KpWf3UZK5Qo+0bBLnGu5UeFPvfxz2AbGPhoExfh3BQ94tA24JW4YiogLCriQ4Q==
X-Received: by 2002:a05:6402:7c7:: with SMTP id u7mr42632401edy.2.1620821803582;
        Wed, 12 May 2021 05:16:43 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65ab.dip0.t-ipconnect.de. [91.12.101.171])
        by smtp.gmail.com with ESMTPSA id pw11sm13990518ejb.88.2021.05.12.05.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 05:16:43 -0700 (PDT)
Subject: Re: [PATCH] kernel/resource: Fix return code check in
 __request_free_mem_region
To:     Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc:     bsingharora@gmail.com, dan.j.williams@intel.com,
        daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org,
        jglisse@redhat.com, jhubbard@nvidia.com, linux-mm@kvack.org,
        smuchun@gmail.com, linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <20210512073528.22334-1-apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7f86af3c-15ba-6ad4-8f6e-1e814a6eac1f@redhat.com>
Date:   Wed, 12 May 2021 14:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512073528.22334-1-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.21 09:35, Alistair Popple wrote:
> Splitting an earlier version of a patch that allowed calling
> __request_region() while holding the resource lock into a series of
> patches required changing the return code for the newly introduced
> __request_region_locked().
> 
> Unfortunately this change was not carried through to a subsequent
> commit 56fd94919b8b ("kernel/resource: fix locking in
> request_free_mem_region") in the series. This resulted in a
> use-after-free due to freeing the struct resource without properly
> releasing it. Fix this by correcting the return code check so that the
> struct is not freed if the request to add it was successful.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Fixes: 56fd94919b8b ("kernel/resource: fix locking in request_free_mem_region")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>   kernel/resource.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 028a5ab18818..ca9f5198a01f 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1805,7 +1805,7 @@ static struct resource *__request_free_mem_region(struct device *dev,
>   				REGION_DISJOINT)
>   			continue;
>   
> -		if (!__request_region_locked(res, &iomem_resource, addr, size,
> +		if (__request_region_locked(res, &iomem_resource, addr, size,
>   						name, 0))
>   			break;
>   
> 

Ouch, missed that, would have expected this pops up right away when testing.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

