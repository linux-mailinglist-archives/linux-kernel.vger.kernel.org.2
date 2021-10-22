Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43E4437707
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhJVMZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232771AbhJVMZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634905362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4uN7Bo4U3+y1C7VgbQp7PPLcg56dNWgwH6BAkaQdkM=;
        b=b6t2rhm8G5k+PZhKmqpl2xITuU6k0+VV3FMVq3uF10Fev9aN9LMteLWMK1eGsYDSZ7kwCC
        0wXJGBP4BwkHj90k/DDpzdWQLFGs1XyMfPXrewQiCYhkvl97tBrcVegwLI+im8Bc9pv8px
        D1ody2u3nYYA18FcUYH7Leqm5T+O4xk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-sY2_qnZfPLGMP0ZNXNkr0g-1; Fri, 22 Oct 2021 08:22:41 -0400
X-MC-Unique: sY2_qnZfPLGMP0ZNXNkr0g-1
Received: by mail-wr1-f72.google.com with SMTP id f2-20020a5d50c2000000b00167f5c0a206so326474wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 05:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=H4uN7Bo4U3+y1C7VgbQp7PPLcg56dNWgwH6BAkaQdkM=;
        b=g4jLEcyub/HoWtt/tn7WT/H5Eov2IT3s8oOJfrkL9pFb7wN7W/e7odf41TlOA3NF4a
         0Bau5xy+Ob/IYQOz9E2JoBN8ocWhp4uh5jLlkzpo7INvgNs7fdc8cNBLMzgQZcdrEK8x
         To2IA8jNkp1alNSRekYigAA6TayckQJJDHFkOscp/xLeGSuviwpDCU4m04PPMgl2P0NP
         zQqpNA3oIC5dmzkRUKOJCYeJE6QNGMKIpRbok+XIJmEzctv9ErXfY4BM4rFoHufcLXCm
         fV0Jiu1aOSS72VV+ot+bUs7bApeBw1bflxhS6pjDpbN8KvUhLz7a1NA5SwmSA4u3vOp7
         4ZbA==
X-Gm-Message-State: AOAM532LXFbeeBORpDPKCkr0t92VQ8kXZOVIJGnjm59awkHnD1WGKVZi
        xZRVLy8U/EZu8deeUnRL1X2KnbPGLErpgZVXTtDKC0MLZdxqxuC91f25PNzO9pNndvEnb838ZDq
        IsSpZXAwRIclv536rT9TFL0F9
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr4319670wmb.56.1634905360115;
        Fri, 22 Oct 2021 05:22:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG67dsJQyALfIVg8+DPj8y7znG/Th6gJWPkok4xufbVKbgDi71GNG3OuLNdOFz/0NO2m79Dg==
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr4319645wmb.56.1634905359929;
        Fri, 22 Oct 2021 05:22:39 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6324.dip0.t-ipconnect.de. [91.12.99.36])
        by smtp.gmail.com with ESMTPSA id k6sm8042191wri.83.2021.10.22.05.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 05:22:39 -0700 (PDT)
Message-ID: <8ecb9287-5141-81f5-c1a0-63b6aa86eb69@redhat.com>
Date:   Fri, 22 Oct 2021 14:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 1/2] Revert "memblock: exclude NOMAP regions from
 kmemleak"
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20211021070929.23272-1-rppt@kernel.org>
 <20211021070929.23272-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211021070929.23272-2-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.21 09:09, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Commit 6e44bd6d34d6 ("memblock: exclude NOMAP regions from kmemleak")
> breaks boot on EFI systems with kmemleak and VM_DEBUG enabled:
> 
> efi: Processing EFI memory map:
> efi:   0x000090000000-0x000091ffffff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> efi:   0x000092000000-0x0000928fffff [Runtime Data|RUN|  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> ------------[ cut here ]------------
> kernel BUG at mm/kmemleak.c:1140!
> Internal error: Oops - BUG: 0 [#1] SMP
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc6-next-20211019+ #104
> pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : kmemleak_free_part_phys+0x64/0x8c
> lr : kmemleak_free_part_phys+0x38/0x8c
> sp : ffff800011eafbc0
> x29: ffff800011eafbc0 x28: 1fffff7fffb41c0d x27: fffffbfffda0e068
> x26: 0000000092000000 x25: 1ffff000023d5f94 x24: ffff800011ed84d0
> x23: ffff800011ed84c0 x22: ffff800011ed83d8 x21: 0000000000900000
> x20: ffff800011782000 x19: 0000000092000000 x18: ffff800011ee0730
> x17: 0000000000000000 x16: 0000000000000000 x15: 1ffff0000233252c
> x14: ffff800019a905a0 x13: 0000000000000001 x12: ffff7000023d5ed7
> x11: 1ffff000023d5ed6 x10: ffff7000023d5ed6 x9 : dfff800000000000
> x8 : ffff800011eaf6b7 x7 : 0000000000000001 x6 : ffff800011eaf6b0
> x5 : 00008ffffdc2a12a x4 : ffff7000023d5ed7 x3 : 1ffff000023dbf99
> x2 : 1ffff000022f0463 x1 : 0000000000000000 x0 : ffffffffffffffff
> Call trace:
>  kmemleak_free_part_phys+0x64/0x8c
>  memblock_mark_nomap+0x5c/0x78
>  reserve_regions+0x294/0x33c
>  efi_init+0x2d0/0x490
>  setup_arch+0x80/0x138
>  start_kernel+0xa0/0x3ec
>  __primary_switched+0xc0/0xc8
> Code: 34000041 97d526e7 f9418e80 36000040 (d4210000)
> random: get_random_bytes called from print_oops_end_marker+0x34/0x80 with crng_init=0
> ---[ end trace 0000000000000000 ]---
> 
> The crash happens because kmemleak_free_part_phys() tries to use __va()
> before memstart_addr is initialized and this triggers a VM_BUG_ON() in
> arch/arm64/include/asm/memory.h:
> 
> Revert 6e44bd6d34d6 ("memblock: exclude NOMAP regions from kmemleak"), the
> issue it is fixing will be fixed differently.
> 
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/memblock.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5c3503c98b2f..184dcd2e5d99 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -936,12 +936,7 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>   */
>  int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
>  {
> -	int ret = memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
> -
> -	if (!ret)
> -		kmemleak_free_part_phys(base, size);
> -
> -	return ret;
> +	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
>  }
>  
>  /**
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

