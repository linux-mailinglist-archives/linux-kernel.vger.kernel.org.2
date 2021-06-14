Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CE43A684A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhFNNrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234035AbhFNNq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623678293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WB47Pni+nWnZCpL3j99qdXOV/pBIAB8A+KnYUYN28RA=;
        b=IA58C7pvf4dGyL9Vt89mklcGWVzHiP9PGQTAR7XSo5YmbgRe18d4N/MnEaN9iEX19EWT1v
        /UGPcJqIF58MzIAfsFwsBngPM6wQ9Ji1sH6opxxcELRunrsteWucEvA5/2CEB9Mxo7Oc/g
        TNjqolFNI0ru+vFh3YkUlfi50/uMuqI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-eFpmnM8iPoCtmu0o4hI8SQ-1; Mon, 14 Jun 2021 09:44:52 -0400
X-MC-Unique: eFpmnM8iPoCtmu0o4hI8SQ-1
Received: by mail-wm1-f69.google.com with SMTP id m33-20020a05600c3b21b02901a44b1d2d87so3427wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 06:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WB47Pni+nWnZCpL3j99qdXOV/pBIAB8A+KnYUYN28RA=;
        b=KsQ8x7dKXGko5rmK+wCIIp1oRayumAZQvQeB0BIY4HTpViBh2pE4eFUlXFzte0UD33
         n7WAKkDcLMQurdCdzf0Yw07aMfdcuHHIH8jpWlYE4vgQMtki8bQoPbAjOx4gQ0OtRw9w
         HRTDqNKwmsaUIWeHIAhYBgzX7AUu9S3hSQdwQcRbeyFBxwNWijhnH5FvdxHFPzxzN6aZ
         GZsE/PPCyyog8/qeFCkR1y0K4cx/lcmHMxP9ewUqB4WoTggWVyPTGD1Qh2nfN7hEAurI
         21+fx0iH5sNG+EPCFUZfsvKXooNOmZwgY6P38+u4oJoBPggz+iZV1Phzd7mFnCyXi3Mz
         nweA==
X-Gm-Message-State: AOAM530hHD32XCnqVUT2bOL8Z87U4QQWMckoMQIG8DEqYxm3t3m/7tyb
        58ymZTv3/5PP1GNTenjpfjH5ELXAgm59+5L0z5tMF7INirU4gCJXlN44Y2akzWVGfOFtVkRn/sJ
        izSUBt1mB3zt+kEqgqolg03E3
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr28719058wmh.101.1623678290830;
        Mon, 14 Jun 2021 06:44:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWpm7VHBHg5E8TavVz/PqtB9z7c94nrDgE5PFAe0bmP/4EluavDGqNCHfZLyv6MB54rYIebA==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr28719035wmh.101.1623678290649;
        Mon, 14 Jun 2021 06:44:50 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66ca.dip0.t-ipconnect.de. [91.12.102.202])
        by smtp.gmail.com with ESMTPSA id 125sm21656180wmb.34.2021.06.14.06.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 06:44:50 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] mm/vmalloc: add vmalloc_no_huge
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20210614132357.10202-1-imbrenda@linux.ibm.com>
 <20210614132357.10202-2-imbrenda@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8f24292e-e8c9-9b9b-0429-2ac984a01611@redhat.com>
Date:   Mon, 14 Jun 2021 15:44:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210614132357.10202-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.21 15:23, Claudio Imbrenda wrote:
> Commit 121e6f3258fe3 ("mm/vmalloc: hugepage vmalloc mappings") added
> support for hugepage vmalloc mappings, it also added the flag
> VM_NO_HUGE_VMAP for __vmalloc_node_range to request the allocation to
> be performed with 0-order non-huge pages.  This flag is not accessible
> when calling vmalloc, the only option is to call directly
> __vmalloc_node_range, which is not exported.
> 
> This means that a module can't vmalloc memory with small pages.
> 
> Case in point: KVM on s390x needs to vmalloc a large area, and it needs
> to be mapped with non-huge pages, because of a hardware limitation.
> 
> This patch adds the function vmalloc_no_huge, which works like vmalloc,
> but it is guaranteed to always back the mapping using small pages. This
> new function is exported, therefore it is usable by modules.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> ---
>   include/linux/vmalloc.h |  1 +
>   mm/vmalloc.c            | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 4d668abb6391..bfaaf0b6fa76 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -135,6 +135,7 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
>   			const void *caller);
>   void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
>   		int node, const void *caller);
> +void *vmalloc_no_huge(unsigned long size);
>   
>   extern void vfree(const void *addr);
>   extern void vfree_atomic(const void *addr);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a13ac524f6ff..296a2fcc3fbe 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2998,6 +2998,22 @@ void *vmalloc(unsigned long size)
>   }
>   EXPORT_SYMBOL(vmalloc);
>   
> +/**
> + * vmalloc_no_huge - allocate virtually contiguous memory using small pages
> + * @size:    allocation size
> + *
> + * Allocate enough non-huge pages to cover @size from the page level
> + * allocator and map them into contiguous kernel virtual space.
> + *
> + * Return: pointer to the allocated memory or %NULL on error
> + */
> +void *vmalloc_no_huge(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END, GFP_KERNEL, PAGE_KERNEL,
> +				    VM_NO_HUGE_VMAP, NUMA_NO_NODE, __builtin_return_address(0));
> +}
> +EXPORT_SYMBOL(vmalloc_no_huge);
> +
>   /**
>    * vzalloc - allocate virtually contiguous memory with zero fill
>    * @size:    allocation size
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

