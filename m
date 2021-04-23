Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F0A368B99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhDWDb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 23:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbhDWDbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:31:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ADBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:30:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u11so18746452pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mTW9BU0qu5zkGAkUZX5+AC9QHEbI9XXxzmhAVZrzHik=;
        b=WUST2SSwPGBugm4bztLBClW89OcLlClbRCNlHKy3Hnr5cFerXt4H4BguTR1QZixTy1
         1PJRZt9WHg5Mz6hZJyCW8JNk0fztkehYsvFf4j6WrOFZ+MNg3kNIUcG+QhfiUA8w5KMq
         HKJaF4JKMkPMznC+V/L1Av62DTBac1zSGCiGn2smzRU1XEA6UhsK+rmYrfiZaXTRsW4R
         haIQoWkhfvKAXwk7rlQi17GN8N1jewRw4L8tItrK07sbDdcdVdrPgSMI37etULLx62n2
         CNhWm57aa170L2KClG4j4Vr6CvpJJIo0Yns4QOtCdZ6BajJR4leLVUIu367/sZBpSRjr
         LSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mTW9BU0qu5zkGAkUZX5+AC9QHEbI9XXxzmhAVZrzHik=;
        b=nywJ7KLjj5MpCOSFrXNbEBICiK7BdYoGj94fKXIumPBcjn771SW6QFFQbJhp7otmlU
         LRta5GhhcGCbMIjpDhlcTpLDpgI4KByPbgzZG+esCOE8EgUFeHlP9Bgl2wQEXmHLapeO
         9qmcIbRYQREUGxEk/2wd0vkfsTtc3Ah154Ne5F81l5IMX9nG4nbz4w1xVCbKe267dr9p
         2+olGpGvgkKOOLOrT5n/XWo3VJyVH+W1PIA6GxgPd3z14U7RH0+df0EwUM9isLVkLass
         7OYdFgf+tyQ1oWc5IAdFq+cMP5C8k9imQh3Ng69wJFgDaxibmIvcuYUI1b0sz2LXTpc/
         zJVQ==
X-Gm-Message-State: AOAM53015pGur/fR0zVTkLJToZzV0YMXKYpVW1q4yxco+5OwV7/uDst2
        7n3pvUs3R1xNBPX8r5Ol9hOf3Q==
X-Google-Smtp-Source: ABdhPJxXpyZ8RURl7wDnwkagiTl19h26b1Pmk59A3BIsOpq9YrI8pL/bXbP/Jm6cmSYxPbvaGoY+4A==
X-Received: by 2002:a17:902:d884:b029:ec:9fcd:2311 with SMTP id b4-20020a170902d884b02900ec9fcd2311mr1997014plz.80.1619148647235;
        Thu, 22 Apr 2021 20:30:47 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i22sm3533997pgj.90.2021.04.22.20.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 20:30:46 -0700 (PDT)
Date:   Thu, 22 Apr 2021 20:30:46 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 20:26:48 PDT (-0700)
Subject:     Re: [PATCH v3 3/5] RISC-V: Improve init_resources
In-Reply-To: <20210405085712.1953848-4-mick@ics.forth.gr>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, mick@ics.forth.gr,
        geert@linux-m68k.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Message-ID: <mhng-40060f4b-2157-42a2-9e60-0d806220fd44@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Apr 2021 01:57:10 PDT (-0700), mick@ics.forth.gr wrote:
> * Kernel region is always present and we know where it is, no
> need to look for it inside the loop, just ignore it like the
> rest of the reserved regions within system's memory.
>
> * Don't call memblock_free inside the loop, if called it'll split
> the region of pre-allocated resources in two parts, messing things
> up, just re-use the previous pre-allocated resource and free any
> unused resources after both loops finish.
>
> * memblock_alloc may add a region when called, so increase the
> number of pre-allocated regions by one to be on the safe side
> (reported and patched by Geert Uytterhoeven)

IIUC this one has already been fixen on for-next.  Either way, it caused 
a merge conflict.  I think I've fixed it up, LMK if something went 
wrong.

Also: I cleaned up the commit text a bit, as this is an odd way to do 
it.  It's probably best to just have split this into two commits.

>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> ---
>  arch/riscv/kernel/setup.c | 90 ++++++++++++++++++++-------------------
>  1 file changed, 46 insertions(+), 44 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index e85bacff1..030554bab 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -60,6 +60,7 @@ static DEFINE_PER_CPU(struct cpu, cpu_devices);
>   * also add "System RAM" regions for compatibility with other
>   * archs, and the rest of the known regions for completeness.
>   */
> +static struct resource kimage_res = { .name = "Kernel image", };
>  static struct resource code_res = { .name = "Kernel code", };
>  static struct resource data_res = { .name = "Kernel data", };
>  static struct resource rodata_res = { .name = "Kernel rodata", };
> @@ -80,45 +81,54 @@ static int __init add_resource(struct resource *parent,
>  	return 1;
>  }
>
> -static int __init add_kernel_resources(struct resource *res)
> +static int __init add_kernel_resources(void)
>  {
>  	int ret = 0;
>
>  	/*
>  	 * The memory region of the kernel image is continuous and
> -	 * was reserved on setup_bootmem, find it here and register
> -	 * it as a resource, then register the various segments of
> -	 * the image as child nodes
> +	 * was reserved on setup_bootmem, register it here as a
> +	 * resource, with the various segments of the image as
> +	 * child nodes.
>  	 */
> -	if (!(res->start <= code_res.start && res->end >= data_res.end))
> -		return 0;
>
> -	res->name = "Kernel image";
> -	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +	code_res.start = __pa_symbol(_text);
> +	code_res.end = __pa_symbol(_etext) - 1;
> +	code_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>
> -	/*
> -	 * We removed a part of this region on setup_bootmem so
> -	 * we need to expand the resource for the bss to fit in.
> -	 */
> -	res->end = bss_res.end;
> +	rodata_res.start = __pa_symbol(__start_rodata);
> +	rodata_res.end = __pa_symbol(__end_rodata) - 1;
> +	rodata_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>
> -	ret = add_resource(&iomem_resource, res);
> +	data_res.start = __pa_symbol(_data);
> +	data_res.end = __pa_symbol(_edata) - 1;
> +	data_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +
> +	bss_res.start = __pa_symbol(__bss_start);
> +	bss_res.end = __pa_symbol(__bss_stop) - 1;
> +	bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +
> +	kimage_res.start = code_res.start;
> +	kimage_res.end = bss_res.end;
> +	kimage_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +
> +	ret = add_resource(&iomem_resource, &kimage_res);
>  	if (ret < 0)
>  		return ret;
>
> -	ret = add_resource(res, &code_res);
> +	ret = add_resource(&kimage_res, &code_res);
>  	if (ret < 0)
>  		return ret;
>
> -	ret = add_resource(res, &rodata_res);
> +	ret = add_resource(&kimage_res, &rodata_res);
>  	if (ret < 0)
>  		return ret;
>
> -	ret = add_resource(res, &data_res);
> +	ret = add_resource(&kimage_res, &data_res);
>  	if (ret < 0)
>  		return ret;
>
> -	ret = add_resource(res, &bss_res);
> +	ret = add_resource(&kimage_res, &bss_res);
>
>  	return ret;
>  }
> @@ -129,53 +139,42 @@ static void __init init_resources(void)
>  	struct resource *res = NULL;
>  	struct resource *mem_res = NULL;
>  	size_t mem_res_sz = 0;
> -	int ret = 0, i = 0;
> -
> -	code_res.start = __pa_symbol(_text);
> -	code_res.end = __pa_symbol(_etext) - 1;
> -	code_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> -
> -	rodata_res.start = __pa_symbol(__start_rodata);
> -	rodata_res.end = __pa_symbol(__end_rodata) - 1;
> -	rodata_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> -
> -	data_res.start = __pa_symbol(_data);
> -	data_res.end = __pa_symbol(_edata) - 1;
> -	data_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +	int num_resources = 0, res_idx = 0;
> +	int ret = 0;
>
> -	bss_res.start = __pa_symbol(__bss_start);
> -	bss_res.end = __pa_symbol(__bss_stop) - 1;
> -	bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +	/* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
> +	num_resources = memblock.memory.cnt + memblock.reserved.cnt + 1;
> +	res_idx = num_resources - 1;
>
> -	mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt) * sizeof(*mem_res);
> +	mem_res_sz = num_resources * sizeof(*mem_res);
>  	mem_res = memblock_alloc(mem_res_sz, SMP_CACHE_BYTES);
>  	if (!mem_res)
>  		panic("%s: Failed to allocate %zu bytes\n", __func__, mem_res_sz);
> +
>  	/*
>  	 * Start by adding the reserved regions, if they overlap
>  	 * with /memory regions, insert_resource later on will take
>  	 * care of it.
>  	 */
> +	ret = add_kernel_resources();
> +	if (ret < 0)
> +		goto error;
> +
>  	for_each_reserved_mem_region(region) {
> -		res = &mem_res[i++];
> +		res = &mem_res[res_idx--];
>
>  		res->name = "Reserved";
>  		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>  		res->start = __pfn_to_phys(memblock_region_reserved_base_pfn(region));
>  		res->end = __pfn_to_phys(memblock_region_reserved_end_pfn(region)) - 1;
>
> -		ret = add_kernel_resources(res);
> -		if (ret < 0)
> -			goto error;
> -		else if (ret)
> -			continue;
> -
>  		/*
>  		 * Ignore any other reserved regions within
>  		 * system memory.
>  		 */
>  		if (memblock_is_memory(res->start)) {
> -			memblock_free((phys_addr_t) res, sizeof(struct resource));
> +			/* Re-use this pre-allocated resource */
> +			res_idx++;
>  			continue;
>  		}
>
> @@ -186,7 +185,7 @@ static void __init init_resources(void)
>
>  	/* Add /memory regions to the resource tree */
>  	for_each_mem_region(region) {
> -		res = &mem_res[i++];
> +		res = &mem_res[res_idx--];
>
>  		if (unlikely(memblock_is_nomap(region))) {
>  			res->name = "Reserved";
> @@ -204,6 +203,9 @@ static void __init init_resources(void)
>  			goto error;
>  	}
>
> +	/* Clean-up any unused pre-allocated resources */
> +	mem_res_sz = (num_resources - res_idx + 1) * sizeof(*mem_res);
> +	memblock_free((phys_addr_t) mem_res, mem_res_sz);
>  	return;
>
>   error:
