Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010723F74D5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbhHYMMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232681AbhHYMMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629893490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7kAFTtN5GyCnNiW5FdL7RXkuMBaRh4yIij8fQrjUPE=;
        b=Jn/jUwEbL1MLUhqENchwujGHu/saYtOnsUhO0qeRffHHG/zbN9jRf/kp802D0xs/giJsdQ
        wYIIdVGJBqjR8DJMcYEwImvNtXndHVTiDjZPY+sInSdhZtEtl1sJrUXicfDFRB1fG6FyF4
        t5HM6/bUVePlND/LSJ9AvK+PTLgebUw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-_qIRcz-oO9ax3NjAUWw97Q-1; Wed, 25 Aug 2021 08:11:26 -0400
X-MC-Unique: _qIRcz-oO9ax3NjAUWw97Q-1
Received: by mail-wm1-f71.google.com with SMTP id m33-20020a05600c3b2100b002e87a0542efso1169580wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 05:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k7kAFTtN5GyCnNiW5FdL7RXkuMBaRh4yIij8fQrjUPE=;
        b=UjSR2KP55AQ90LAHw7X1YdcivM2efV1gR0mhtiSFgi5VsqPQsGajr4yzPfhpNnUnVM
         uPfmllz2ulqKNJJ2wraJpdKu1I+DTsk6FOrWzjcAuJMYYwuuurglh03LbqOeHbeNmstt
         LNI2l77lw+IPz69DWDrRHyiVtQTeYQ3O91YuZpNvuNtsfIBtEwFQH6Yd63D3Ez9zRp6Q
         1JblhhBS5ej75izKePn9P3sV67hcu9JzRBKTKuUs3uoWhTWMRgR56LhYGkmy7kXNzmVf
         FykMEK97blRZRAX4tO9bNawfpSfCeNQA0267PmplaynfgYnFO6XYS8Idm1Unb8sUGQE7
         i6lQ==
X-Gm-Message-State: AOAM532FWXXJIwUxalKTgKGH1B8Q9ERSWR/bAhdg47k/e+Kob87wEAYw
        ZbgUB5R0JntWHDRyywyRgQ6Vf6DMCkDJigp0zfuLKoWKqdZ7PUPdIoYIyQFFiULw7WtfSnhzj2+
        TuWtIREHLPvwRty34DvGnJIIi
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr25794376wrx.338.1629893485392;
        Wed, 25 Aug 2021 05:11:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUWxbQ6sYbcNx3xboKyyUCEav3TMI8aWyQFtR0PKawKvnU4oRlAimZ8U28nYS6NVFVY6bxGg==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr25794344wrx.338.1629893485099;
        Wed, 25 Aug 2021 05:11:25 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
        by smtp.gmail.com with ESMTPSA id g11sm6329219wrx.30.2021.08.25.05.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 05:11:24 -0700 (PDT)
Subject: Re: [PATCH 1/4] mm/page_alloc: always initialize memory map for the
 holes
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210714123739.16493-1-rppt@kernel.org>
 <20210714123739.16493-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <175e0e1e-90cd-5c69-69a3-9f44462679e3@redhat.com>
Date:   Wed, 25 Aug 2021 14:11:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714123739.16493-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.21 14:37, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Currently memory map for the holes is initialized only when SPARSEMEM
> memory model is used. Yet, even with FLATMEM there could be holes in the
> physical memory layout that have memory map entries.
> 
> For instance, the memory reserved using e820 API on i386 or
> "reserved-memory" nodes in device tree would not appear in memblock.memory
> and hence the struct pages for such holes will be skipped during memory map
> initialization.
> 
> These struct pages will be zeroed because the memory map for FLATMEM
> systems is allocated with memblock_alloc_node() that clears the allocated
> memory. While zeroed struct pages do not cause immediate problems, the
> correct behaviour is to initialize every page using __init_single_page().
> Besides, enabling page poison for FLATMEM case will trigger
> PF_POISONED_CHECK() unless the memory map is properly initialized.
> 
> Make sure init_unavailable_range() is called for both SPARSEMEM and FLATMEM
> so that struct pages representing memory holes would appear as PG_Reserved
> with any memory layout.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   mm/page_alloc.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3b97e17806be..878d7af4403d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6624,7 +6624,6 @@ static void __meminit zone_init_free_lists(struct zone *zone)
>   	}
>   }
>   
> -#if !defined(CONFIG_FLATMEM)
>   /*
>    * Only struct pages that correspond to ranges defined by memblock.memory
>    * are zeroed and initialized by going through __init_single_page() during
> @@ -6669,13 +6668,6 @@ static void __init init_unavailable_range(unsigned long spfn,
>   		pr_info("On node %d, zone %s: %lld pages in unavailable ranges",
>   			node, zone_names[zone], pgcnt);
>   }
> -#else
> -static inline void init_unavailable_range(unsigned long spfn,
> -					  unsigned long epfn,
> -					  int zone, int node)
> -{
> -}
> -#endif
>   
>   static void __init memmap_init_zone_range(struct zone *zone,
>   					  unsigned long start_pfn,
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

