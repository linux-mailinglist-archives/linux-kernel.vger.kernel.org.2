Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA8E42211A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhJEIuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232723AbhJEIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633423692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W8cSRh/BjNtkm1NdF8EnGpvtcrgUBRBEv5AvyROV31o=;
        b=h2+8uOUn1O6W/hQu5sDEmkRyH2IZehVmOu4ZJkr6MscRQp0cRJ/01GyGpcxuStW1p/sdel
        /Lia3OWi61VyxgZc8bSnuXtcm8mpe02OQ86LF/aqDC7Gwyc4N7ypaPV4/NHCYGUnekA9B9
        a7ZegmKULkPvLyzJaNX+U8Gh5z7sljg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-96H_pN4dNOK94jWOK6JZpQ-1; Tue, 05 Oct 2021 04:48:11 -0400
X-MC-Unique: 96H_pN4dNOK94jWOK6JZpQ-1
Received: by mail-wm1-f69.google.com with SMTP id h24-20020a7bc938000000b0030d400be5b5so6133817wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 01:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=W8cSRh/BjNtkm1NdF8EnGpvtcrgUBRBEv5AvyROV31o=;
        b=PWlaJcPIoD7uYdNJy25MF22p2RQRapsC6nK3pVk2Rdj/iZGbEdqgbEyVkOBwNDfXYf
         VoDUdCg2Y5vVNJpHpJCz7qKL2t5KgfGCB3WrecncrC8jJc7PXiVeQL8mh1tb9AypMHNG
         suNKU6VR0OZ60oQBnusVxg2Az/NbKINJ9fnd1mOvt5yUG/REExoaGzNwIPiQD6Q6060A
         eTgTFWbH2eNyJQuidxA8CT57hBRX4IVszAFSAMAdBw7X8GYmSDLs42GTCZwnAN2lX1me
         i+uaJ5WaNDgFBk+k5QeVOCLLIMqAHOmB032QDDggUB7KflLHFaZtNUGZ9Pl/0ubqmGRJ
         DE3g==
X-Gm-Message-State: AOAM5338Eczs3phK8Wkfmr59CPjeZMJnJNqOpPfKsr6zsg9YJkOQktjK
        gNl24s5UapZZF3zyKVw6CKMQTcnvZ1m6z0rFXudrUWoPmwNmx5xFldqW4srHq1uQmfLyHFn9jId
        d+XEA42uYHWA/UFx0oN1YUZkQ
X-Received: by 2002:a05:600c:378c:: with SMTP id o12mr2070252wmr.93.1633423690527;
        Tue, 05 Oct 2021 01:48:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEZ2KAbpgcJ1IlPi4jbyBeg9+JeFFqby0fNl4f9gDDYMG97/VkdZUl0OT/2Az0sxYyor8blQ==
X-Received: by 2002:a05:600c:378c:: with SMTP id o12mr2070227wmr.93.1633423690349;
        Tue, 05 Oct 2021 01:48:10 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6741.dip0.t-ipconnect.de. [91.12.103.65])
        by smtp.gmail.com with ESMTPSA id h18sm16485251wrs.75.2021.10.05.01.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 01:48:09 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] mm/cma: add cma_pages_valid to determine if pages
 are in CMA
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-3-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7649db4a-fd21-46c4-efbc-a98893b72104@redhat.com>
Date:   Tue, 5 Oct 2021 10:48:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211001175210.45968-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.21 19:52, Mike Kravetz wrote:
> Add new interface cma_pages_valid() which indicates if the specified
> pages are part of a CMA region.  This interface will be used in a
> subsequent patch by hugetlb code.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   include/linux/cma.h |  1 +
>   mm/cma.c            | 21 +++++++++++++++++----
>   2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 53fd8c3cdbd0..bd801023504b 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -46,6 +46,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>   					struct cma **res_cma);
>   extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
>   			      bool no_warn);
> +extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
>   extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
>   
>   extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
> diff --git a/mm/cma.c b/mm/cma.c
> index 995e15480937..960994b88c7f 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -524,6 +524,22 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>   	return page;
>   }
>   
> +bool cma_pages_valid(struct cma *cma, const struct page *pages,
> +		     unsigned long count)
> +{
> +	unsigned long pfn;
> +
> +	if (!cma || !pages)
> +		return false;
> +
> +	pfn = page_to_pfn(pages);
> +
> +	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
> +		return false;
> +
> +	return true;
> +}
> +
>   /**
>    * cma_release() - release allocated pages
>    * @cma:   Contiguous memory region for which the allocation is performed.
> @@ -539,16 +555,13 @@ bool cma_release(struct cma *cma, const struct page *pages,
>   {
>   	unsigned long pfn;
>   
> -	if (!cma || !pages)
> +	if (!cma_pages_valid(cma, pages, count))
>   		return false;
>   
>   	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
>   
>   	pfn = page_to_pfn(pages);
>   
> -	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
> -		return false;
> -
>   	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
>   
>   	free_contig_range(pfn, count);
> 

Agreed that we might want to perform the pr_debug() now earlier, or do 
another pr_warn before returning false.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

