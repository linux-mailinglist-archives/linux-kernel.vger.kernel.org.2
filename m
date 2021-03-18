Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4510D340E20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhCRTW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhCRTWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:22:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBCFC06174A;
        Thu, 18 Mar 2021 12:22:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bt4so3432976pjb.5;
        Thu, 18 Mar 2021 12:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TM+vEBqjvzmGZFh854VHWSVx/dlysQ2NuONxv+B86HU=;
        b=LBxnTBlH06B0fQtsE0BvxU3j7rlfq3katQi7WoUGretXjpngZM5x897LI0NpbDoopk
         hX9iBFP1dRVeJ5lS7Yl+9a5OIDATku9d98R1Rx/4FFArP6hpBi0J3iDd+Rsz0PQwTw5c
         R7rsUuPuCQGPFsFO98LjnZNtEuIuaNEt1RD0TCsr7vxGZBm7MRs0f+S9DO/WW5b2H9f9
         M/2bQqXtzMxL2aZnVTEeR0mnDwnH90eSyMZ2Z4GwX2+Hh3LbpAfBUZGEU5vhgSpsP3L5
         eo9J50pKpEeagWcG3ytdINWi0vle6C8TvUyy2NJly5kyWfI6GqZVMYO9r7Ww35jE4yJA
         f74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TM+vEBqjvzmGZFh854VHWSVx/dlysQ2NuONxv+B86HU=;
        b=TM4SdMPlnb0irTOEDTVdi2REHFJdr4DCgAs9Tpr4wWXCFgwaNfCRenhpT8ks458HaB
         61hQCW8GdGSWWoP/kKW26lAJTDGpW64VT2qK6wAy/8qts23Sc9B5q2JdKLcHZ6JsEkOz
         IIxFFZdTQsh3R8zQGgTscOoQHZnUwfDWwy/vz4hLTD+MfXkdqmpMdujxO0wgWOdFt4T1
         ZWfE8KW/5HZMv9qEh9ySvRgTxonZCztCBeVBNT1u+X2bxQ2IvdgX9XiJWLTlEyRtaCka
         eTcq+bT49qatsQMKJtb7SH6bme/9eoIGql6WbeTTYj81mnNVFIdoxJGqAgNFzMnIIIRl
         b/tg==
X-Gm-Message-State: AOAM533iJQPDPpT4n85GTKyKK24K6ut4awlsIeSUFmgnzZudFCH+aMzH
        XPNLkOIZfG6aWHzPFl6WUfI=
X-Google-Smtp-Source: ABdhPJw09QkiSEVKSoCdawiAp/3PCs1M1aROIkZX2/evRD9NZFUJ9/DhqAKS6v+Uak31oZ4vJmhfdw==
X-Received: by 2002:a17:90a:e556:: with SMTP id ei22mr5793082pjb.214.1616095338892;
        Thu, 18 Mar 2021 12:22:18 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h19sm3290393pfc.172.2021.03.18.12.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 12:22:18 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
To:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     opendmb@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
Date:   Thu, 18 Mar 2021 12:22:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318191816.4185226-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2021 12:18 PM, Florian Fainelli wrote:
> It may be useful to disable the SWIOTLB completely for testing or when a
> platform is known not to have any DRAM addressing limitations what so
> ever.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Christoph, in addition to this change, how would you feel if we
qualified the swiotlb_init() in arch/arm/mm/init.c with a:


if (memblock_end_of_DRAM() >= SZ_4G)
	swiotlb_init(1)

right now this is made unconditional whenever ARM_LPAE is enabled which
is the case for the platforms I maintain (ARCH_BRCMSTB) however we do
not really need a SWIOTLB so long as the largest DRAM physical address
does not exceed 4GB AFAICT.

Thanks!

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 1 +
>  include/linux/swiotlb.h                         | 1 +
>  kernel/dma/swiotlb.c                            | 9 +++++++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..b0223e48921e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5278,6 +5278,7 @@
>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
>  			noforce -- Never use bounce buffers (for debugging)
> +			off -- Completely disable SWIOTLB
>  
>  	switches=	[HW,M68k]
>  
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 5857a937c637..23f86243defe 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -15,6 +15,7 @@ enum swiotlb_force {
>  	SWIOTLB_NORMAL,		/* Default - depending on HW DMA mask etc. */
>  	SWIOTLB_FORCE,		/* swiotlb=force */
>  	SWIOTLB_NO_FORCE,	/* swiotlb=noforce */
> +	SWIOTLB_OFF,		/* swiotlb=off */
>  };
>  
>  /*
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c10e855a03bc..d7a4a789c7d3 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -126,6 +126,8 @@ setup_io_tlb_npages(char *str)
>  	} else if (!strcmp(str, "noforce")) {
>  		swiotlb_force = SWIOTLB_NO_FORCE;
>  		io_tlb_nslabs = 1;
> +	} else if (!strcmp(str, "off")) {
> +		swiotlb_force = SWIOTLB_OFF;
>  	}
>  
>  	return 0;
> @@ -229,6 +231,9 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  	unsigned long i, bytes;
>  	size_t alloc_size;
>  
> +	if (swiotlb_force == SWIOTLB_OFF)
> +		return 0;
> +
>  	bytes = nslabs << IO_TLB_SHIFT;
>  
>  	io_tlb_nslabs = nslabs;
> @@ -284,6 +289,9 @@ swiotlb_init(int verbose)
>  	unsigned char *vstart;
>  	unsigned long bytes;
>  
> +	if (swiotlb_force == SWIOTLB_OFF)
> +		goto out;
> +
>  	if (!io_tlb_nslabs) {
>  		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
>  		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> @@ -302,6 +310,7 @@ swiotlb_init(int verbose)
>  		io_tlb_start = 0;
>  	}
>  	pr_warn("Cannot allocate buffer");
> +out:
>  	no_iotlb_memory = true;
>  }
>  
> 

-- 
Florian
