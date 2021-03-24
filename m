Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB412346F86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhCXCa3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Mar 2021 22:30:29 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3496 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbhCXCaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:30:17 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F4sbr3XZzzRTSr;
        Wed, 24 Mar 2021 10:28:24 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 24 Mar 2021 10:30:14 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Wed, 24 Mar 2021 10:30:13 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "tiantao (H)" <tiantao6@hisilicon.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dma-mapping: make map_benchmark compile into module
Thread-Topic: [PATCH] dma-mapping: make map_benchmark compile into module
Thread-Index: AQHXIFPOFGbiIAxEO0+6jc+KbhZliqqSZ4OA
Date:   Wed, 24 Mar 2021 02:30:13 +0000
Message-ID: <970499782ce34f8985beb2145504c941@hisilicon.com>
References: <1616552258-22282-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1616552258-22282-1-git-send-email-tiantao6@hisilicon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.12]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: tiantao (H)
> Sent: Wednesday, March 24, 2021 3:18 PM
> To: akpm@linux-foundation.org; peterz@infradead.org; paulmck@kernel.org;
> ast@kernel.org; tglx@linutronix.de; rostedt@goodmis.org; hch@lst.de;
> m.szyprowski@samsung.com; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org; tiantao
> (H) <tiantao6@hisilicon.com>
> Subject: [PATCH] dma-mapping: make map_benchmark compile into module
> 
> under some scenarios, it is necessary to compile map_benchmark
> into module to test iommu, so this patch changed Kconfig and
> export_symbol to implement map_benchmark compiled into module.
> 
> On the other hand, map_benchmark is a driver, which is supposed
> to be able to run as a module.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

Look sensible to me. I like the idea that map_benchmark is
a driver. It seems unreasonable to always require built-in.


>  kernel/dma/Kconfig | 2 +-
>  kernel/kthread.c   | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 77b4055..0468293 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -223,7 +223,7 @@ config DMA_API_DEBUG_SG
>  	  If unsure, say N.
> 
>  config DMA_MAP_BENCHMARK
> -	bool "Enable benchmarking of streaming DMA mapping"
> +	tristate "Enable benchmarking of streaming DMA mapping"
>  	depends on DEBUG_FS
>  	help
>  	  Provides /sys/kernel/debug/dma_map_benchmark that helps with testing
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 1578973..fa4736f 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -455,6 +455,7 @@ void kthread_bind_mask(struct task_struct *p, const struct
> cpumask *mask)
>  {
>  	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
>  }
> +EXPORT_SYMBOL(kthread_bind_mask);
> 
>  /**
>   * kthread_bind - bind a just-created kthread to a cpu.
> --
> 2.7.4

Thanks
Barry

