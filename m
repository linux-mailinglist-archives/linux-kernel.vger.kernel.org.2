Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CF140D9FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbhIPMgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhIPMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631795679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBEXhQstDZeoxkdAnZ7Rzjw92i2hvLl2G4CneC318UI=;
        b=dkgyXeqfezQdyjaMW0IoxKchlEh8CetnyMOfZ0DCJh+SSc8C6SwtUERwfNJPvmYmkzBX6U
        aOt8+DupinyaWXCqEpiosV/nWs6JDyIsAd2qbFeWTMAcx1adLXlnO+NuWNG+ImbpCx/HIh
        JSBsVH+yp/wXZZzoGd8n4LAJ4IoT0QY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-F59unfqUPeSUNzq4JPfFKg-1; Thu, 16 Sep 2021 08:34:38 -0400
X-MC-Unique: F59unfqUPeSUNzq4JPfFKg-1
Received: by mail-wr1-f69.google.com with SMTP id r17-20020adfda510000b02901526f76d738so2406181wrl.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 05:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QBEXhQstDZeoxkdAnZ7Rzjw92i2hvLl2G4CneC318UI=;
        b=Y4mkVGbAKbd6MmyAdXCabGOXxwLqqA4UTpCphNWeSb1qbUvjNr4vRGp6JZDnsmqTJU
         evq9FiSdtgYHIMwXaTqTmSj52a1WxAk+i7c94JGJ87eBTplx6owe3Qyppc5qy15shaKK
         O0253zii1rIk69SvWxnPjAwHEamnKd7ZaN07mQ/Iik6VkeDoPPi9zO7NbDbFt+tecMpD
         UPOxNv3JQ/0sldNIjDTpukyL8UzZaVm0lhzcBvLzn99jkLCLGuThP8FgpwW1X3J9T2pp
         mam8kTnrXgKoH43xa4qfWsl1fT2WCqzCpWNUEyOLQwSryu6IcQ0XFM1ASEGFvD500kIp
         eQLQ==
X-Gm-Message-State: AOAM5326cDzOZGXny4K4y3m6otFGFJOvYlf1hd8khlhPxhVHy4afCCrM
        Shn2vlCqgOtZibArsKBiFh4OqqZdT7wkW+SeKoGIPflP/rcP/9hQS/ojCN7qV9mdasIyYLGluTV
        WMi6sbY5OFxLWkB8dWeaPL4Qo
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr5768927wru.384.1631795677058;
        Thu, 16 Sep 2021 05:34:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd9qXwCe/AwFnN4AbE+vl3QXTc93BU5KiifDyUbnaB/v+81RmlPDaiWycLEWVg1KVu3RPb1A==
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr5768902wru.384.1631795676788;
        Thu, 16 Sep 2021 05:34:36 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23828.dip0.t-ipconnect.de. [79.242.56.40])
        by smtp.gmail.com with ESMTPSA id g9sm7901665wmg.21.2021.09.16.05.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 05:34:36 -0700 (PDT)
Subject: Re: [PATCH] mm/vmalloc: Don't allow VM_NO_GUARD on vmap()
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>
Cc:     andreyknvl@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>,
        keescook@chromium.org
References: <YUMfdA36fuyZ+/xt@hirez.programming.kicks-ass.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9fead1ff-868c-bddd-326b-a5b3eeeb9faf@redhat.com>
Date:   Thu, 16 Sep 2021 14:34:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUMfdA36fuyZ+/xt@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.21 12:41, Peter Zijlstra wrote:
> 
> The vmalloc guard pages are added on top of each allocation, thereby
> isolating any two allocations from one another. The top guard of the
> lower allocation is the bottom guard guard of the higher allocation
> etc.
> 
> Therefore VM_NO_GUARD is dangerous; it breaks the basic premise of
> isolating separate allocations.
> 
> There are only two in-tree users of this flag, neither of which use it
> through the exported interface. Ensure it stays this way.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   include/linux/vmalloc.h | 2 +-
>   mm/vmalloc.c            | 7 +++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 671d402c3778..10e9571ff0b2 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -22,7 +22,7 @@ struct notifier_block;		/* in notifier.h */
>   #define VM_USERMAP		0x00000008	/* suitable for remap_vmalloc_range */
>   #define VM_DMA_COHERENT		0x00000010	/* dma_alloc_coherent */
>   #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
> -#define VM_NO_GUARD		0x00000040      /* don't add guard page */
> +#define VM_NO_GUARD		0x00000040      /* ***DANGEROUS*** don't add guard page */
>   #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
>   #define VM_FLUSH_RESET_PERMS	0x00000100	/* reset direct map and flush TLB on unmap, can't be freed in atomic context */
>   #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d77830ff604c..01927ebea267 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2743,6 +2743,13 @@ void *vmap(struct page **pages, unsigned int count,
>   
>   	might_sleep();
>   
> +	/*
> +	 * Your top guard is someone else's bottom guard. Not having a top
> +	 * guard compromises someone else's mappings too.
> +	 */
> +	if (WARN_ON_ONCE(flags & VM_NO_GUARD))
> +		flags &= ~VM_NO_GUARD;
> +
>   	if (count > totalram_pages())
>   		return NULL;
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

