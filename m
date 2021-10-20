Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C23E434D57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJTOWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:22:05 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39495 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTOWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:22:03 -0400
Received: by mail-oi1-f172.google.com with SMTP id s9so7473161oiw.6;
        Wed, 20 Oct 2021 07:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQR8bA2DDw1T775UVo7jNnRB7J3D07XKlU/rQiyQQnM=;
        b=hw8kjlnFP5HelJJ0iGdWviTMjYxDek3O9gWM+etcHTVK6sIdJCnzoSM//v4h96jdl5
         lGrSX0dfwcleypjLHAJRcKfQI7t0Om/sDzTe7jNTFMKp+cWVw5Jy7EiYC9EbT3czYOtM
         auFIWs8OYd/l4K+SVXuR2S/rhZlRiEO1J0ITVLbZpOWAzBZGh/FHinGbMkB0IWLQ0v7n
         T+Vu5TWqHX79htd5Lxgt1T6CZmMapBwQ0cY5KE+/0mPxBeW28KnoDQqMB/PV8fJeSEu1
         I8famPAcUyGM8W7e1aYmkdqgjCZ5VOlm8j+jmB6g3PmT9GM15TS9+TJ9Jni/dZjy7rJv
         NbUA==
X-Gm-Message-State: AOAM533hkB3ulSDEb2UbKCzxO6MMsFaaNBjbmtiPQ28fcJc/R+KjX1cg
        4aaY5ewThK9DRC/Bgoxbkg==
X-Google-Smtp-Source: ABdhPJxW9P/PudtVYOU9cQ6l4rME3ClU1cNhDdvCc/Xw17GiN25AzsXlt7wEgblNZKsgXYjVar84Rw==
X-Received: by 2002:a05:6808:199d:: with SMTP id bj29mr7759915oib.165.1634739588807;
        Wed, 20 Oct 2021 07:19:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x10sm424722ooa.16.2021.10.20.07.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:19:47 -0700 (PDT)
Received: (nullmailer pid 2299344 invoked by uid 1000);
        Wed, 20 Oct 2021 14:19:45 -0000
Date:   Wed, 20 Oct 2021 09:19:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v15 09/10] of: fdt: Add memory for devices by DT property
 "linux,usable-memory-range"
Message-ID: <YXAlgdZ5q7CdBXw4@robh.at.kernel.org>
References: <20211020020317.1220-1-thunder.leizhen@huawei.com>
 <20211020020317.1220-10-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020020317.1220-10-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 10:03:16AM +0800, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices and never mapped by the first kernel.
> This memory range is advertised to crash dump kernel via DT property
> under /chosen,
>         linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>
> 
> We reused the DT property linux,usable-memory-range and made the low
> memory region as the second range "BASE2 SIZE2", which keeps compatibility
> with existing user-space and older kdump kernels.
> 
> Crash dump kernel reads this property at boot time and call memblock_add()
> to add the low memory region after memblock_cap_memory_range() has been
> called.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/of/fdt.c | 47 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4546572af24bbf1..cf59c847b2c28a5 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -969,8 +969,16 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>  		 elfcorehdr_addr, elfcorehdr_size);
>  }
>  
> -static phys_addr_t cap_mem_addr;
> -static phys_addr_t cap_mem_size;
> +/*
> + * The main usage of linux,usable-memory-range is for crash dump kernel.
> + * Originally, the number of usable-memory regions is one. Now there may
> + * be two regions, low region and high region.
> + * To make compatibility with existing user-space and older kdump, the low
> + * region is always the last range of linux,usable-memory-range if exist.
> + */
> +#define MAX_USABLE_RANGES		2
> +
> +static struct memblock_region cap_mem_regions[MAX_USABLE_RANGES];
>  
>  /**
>   * early_init_dt_check_for_usable_mem_range - Decode usable memory range
> @@ -979,20 +987,30 @@ static phys_addr_t cap_mem_size;
>   */
>  static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>  {
> -	const __be32 *prop;
> -	int len;
> +	const __be32 *prop, *endp;
> +	int len, nr = 0;
> +	struct memblock_region *rgn = &cap_mem_regions[0];
>  
>  	pr_debug("Looking for usable-memory-range property... ");
>  
>  	prop = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
> -	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
> +	if (!prop)
>  		return;
>  
> -	cap_mem_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
> -	cap_mem_size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +	endp = prop + (len / sizeof(__be32));
> +	while ((endp - prop) >= (dt_root_addr_cells + dt_root_size_cells)) {
> +		rgn->base = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +		rgn->size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +
> +		pr_debug("cap_mem_regions[%d]: base=%pa, size=%pa\n",
> +			 nr, &rgn->base, &rgn->size);
> +
> +		if (++nr >= MAX_USABLE_RANGES)
> +			break;
> +
> +		rgn++;
> +	}
>  
> -	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
> -		 &cap_mem_size);
>  }
>  
>  #ifdef CONFIG_SERIAL_EARLYCON
> @@ -1265,7 +1283,8 @@ bool __init early_init_dt_verify(void *params)
>  
>  void __init early_init_dt_scan_nodes(void)
>  {
> -	int rc = 0;
> +	int i, rc = 0;
> +	struct memblock_region *rgn = &cap_mem_regions[0];
>  
>  	/* Initialize {size,address}-cells info */
>  	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> @@ -1279,7 +1298,13 @@ void __init early_init_dt_scan_nodes(void)
>  	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>  
>  	/* Handle linux,usable-memory-range property */
> -	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> +	memblock_cap_memory_range(rgn->base, rgn->size);
> +	for (i = 1; i < MAX_USABLE_RANGES; i++) {
> +		rgn++;

Just use rgn[i].

> +
> +		if (rgn->size)

This check can be in the 'for' conditions check.

> +			memblock_add(rgn->base, rgn->size);
> +	}


There's not really any point in doing all this in 2 steps. I'm 
assuming this needs to be handled after scanning the memory nodes, so 
can you refactor this moving early_init_dt_check_for_usable_mem_range 
out of early_init_dt_scan_chosen() and call it here. You'll have to get 
the offset for /chosen twice or save the offset.

Rob
