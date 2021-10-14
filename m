Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A947E42DE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhJNP0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhJNP0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634225085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBGMhkW5l3xF58RlsWd4EAEKmLqaalQ7yZY4iWVTFTE=;
        b=Jjbea336RT/aL/DaqDW/p8ChAjnfygWDOqaiFcCIwJeEbB5OgttId5YRglkjINAy3ZogQr
        RwcQ15JenuKxzY6ta2UJeudA5C6O54166J+HLJBLGBI34J0WVc/OcUPFYkJKxzkgn6/V7d
        F9RgVs5gWVNRsUi30OEAgERisHnkbOk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-vTpZKFwTO5aZTNtMU5pLOQ-1; Thu, 14 Oct 2021 11:24:44 -0400
X-MC-Unique: vTpZKFwTO5aZTNtMU5pLOQ-1
Received: by mail-wr1-f71.google.com with SMTP id a15-20020a056000188f00b00161068d8461so4854023wri.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HBGMhkW5l3xF58RlsWd4EAEKmLqaalQ7yZY4iWVTFTE=;
        b=cHBJZQ9cbAiE7UYeyoIr29fjF0nPCnbFq6B/C0TYUlwaF4wuJ65lZGVeokZcRSbOiT
         v6kI9NS0QBVFHzuUK2kJMNj3HCBXKhXAQLa3gKXti6EjH+HRNYsoSaxYy0hdlq7YsOas
         nhRU2EAdovsKB3rzv2PBwyiHtTkAmTAqyxfGw29n/yRp5RP7jQ4//j1Je5FIs4OYXp4w
         QUxqnQMIeta61nZL9mxQwq9BQCUTM7INX6FYJECmbyMu6r8oCsH4J1tDTg3jUnE83MLR
         Jc4n/cC3HNxXwgP6AddaId8deNke0Cj6EYTsNN1KH8jbImx6cLsjmyUZSjEiscHiUX7M
         GQQg==
X-Gm-Message-State: AOAM53311dDy2AfpQABNGuKCvRmyMKkYBeOdMVZEaw5Kzfrl8Kr2Xrra
        wkrsSSUw+NxfoRJRoD5uzcML7VafxEOfo+YSBjuErMjnCEsjlAzwxNdzqbVSj3PJhHyNYQpBwc1
        ATUhc5i+1gBKPFCPTMRsUx+0f
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr6387175wmq.54.1634225083147;
        Thu, 14 Oct 2021 08:24:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYP7fwAuhg8aaoUbBVxOQCwoZYB4gcFaYUWfrZsNY6fPstrdXmDGBHNtD9+emUpkCG1n2fEg==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr6387148wmq.54.1634225082934;
        Thu, 14 Oct 2021 08:24:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c694e.dip0.t-ipconnect.de. [91.12.105.78])
        by smtp.gmail.com with ESMTPSA id v185sm8368508wme.35.2021.10.14.08.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:24:42 -0700 (PDT)
Message-ID: <84b44b45-217e-885a-c513-de266315888f@redhat.com>
Date:   Thu, 14 Oct 2021 17:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] memcg: page_alloc: skip bulk allocator for
 __GFP_ACCOUNT
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211014151607.2171970-1-shakeelb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211014151607.2171970-1-shakeelb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.10.21 17:16, Shakeel Butt wrote:
> The commit 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in
> __vmalloc_area_node()") switched to bulk page allocator for order 0
> allocation backing vmalloc. However bulk page allocator does not support
> __GFP_ACCOUNT allocations and there are several users of
> kvmalloc(__GFP_ACCOUNT).
> 
> For now make __GFP_ACCOUNT allocations bypass bulk page allocator. In
> future if there is workload that can be significantly improved with the
> bulk page allocator with __GFP_ACCCOUNT support, we can revisit the
> decision.
> 
> Fixes: 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in __vmalloc_area_node()")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changes since v1:
> - do fallback allocation instead of failure, suggested by Michal Hocko.
> - Added memcg_kmem_enabled() check, corrected by Vasily Averin
> 
>  mm/page_alloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 668edb16446a..9ca871dc8602 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5230,6 +5230,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	if (unlikely(page_array && nr_pages - nr_populated == 0))
>  		goto out;
>  
> +	/* Bulk allocator does not support memcg accounting. */
> +	if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT))
> +		goto failed;
> +
>  	/* Use the single page allocator for one page. */
>  	if (nr_pages - nr_populated == 1)
>  		goto failed;
> 

LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

