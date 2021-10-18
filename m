Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9DD43236E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhJRQEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhJRQET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:04:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7BBC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:02:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso321717pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s2ngofAfTsCozTi9ujgBv7dfRkYBGqqYCREjpW1owbk=;
        b=AzTTda00cH6EjoSZE2TU6eqWuxaM41OMg5wWq98Q7ruZBaAs21R4APHt1M6fCZ44Mo
         3fr/6ZuujTt0oA0seEC2zCfMS/Wd+UZ3EvFAV6aHxz2qHgkE0HMcWtooVtTXFvOMwSZw
         z11MDV5erllB8XY+DZi3RbDdmLvcS8LN/5xbD8IDuWJIznAIvSDh2owwd34ZyFTH3h+P
         ux/dDk3hU+9KOjLOY6BMk/R4Vm0cM0qFT0rBdiTns3FWpz5j/SGi47hXnsLO6wXrdp0i
         bfAQKbhtbYJLuikdC+qiR+PSTuwVS5FQvxvwt1p7d3sAJj0Vw4WjADGXTflNNgEZJxkX
         CLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s2ngofAfTsCozTi9ujgBv7dfRkYBGqqYCREjpW1owbk=;
        b=7WrNEzyzqImWqWVLkSO/TO1LB6KsozRNuBStqx8ZeB0Ae3mBTg0yoSeXt4T3bGhah+
         Tqv487ipppuS/iHIrl63oitN24pbNSNUoQv80jRfLAI/9A2XmVf10CXnXBh6FdI2n1a2
         BRm3g+fSRgESjcvEHXJLo1I8mWo8mu0G3fMFoNivzP2Y4UJzTA1+CwRdDi3IOdyE6oLi
         J2FENCBtVZQ++t4OkaBUB46FRVYdgmN6bvGvPEvnlZX9Gxs9EArT9SPIIJgatafmIePd
         gV8axD01yTDAJtU0PjvhX51o8VD0xABL6zzxuQuQ8qegaFydxLamMBhrv9/0cIles2Rp
         6OAA==
X-Gm-Message-State: AOAM531aDhbi7VsnUpsg6NF+++NwPx+XwzE1u8smycgyvjo1DOrcOTfB
        clW5w58gJDgChcjEs3Ekf7Ks8g==
X-Google-Smtp-Source: ABdhPJw7ny/8h1dzHmObIk54C+X0gAjZCIP4Vvfb9Ov2mmx7TBaChFO+SiYxlakImmhe6UJHnvkm9A==
X-Received: by 2002:a17:902:e5cb:b0:13f:25b7:4d50 with SMTP id u11-20020a170902e5cb00b0013f25b74d50mr27903318plf.38.1634572927197;
        Mon, 18 Oct 2021 09:02:07 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f21sm3741947pfc.203.2021.10.18.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:02:04 -0700 (PDT)
Date:   Mon, 18 Oct 2021 10:02:02 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        Bransilav Rankov <branislav.rankov@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2] coresight: trbe: Defer the probe on offline CPUs
Message-ID: <20211018160202.GE3163131@p14s>
References: <20211014142238.2221248-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014142238.2221248-1-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 03:22:38PM +0100, Suzuki K Poulose wrote:
> If a CPU is offline during the driver init, we could end up causing
> a kernel crash trying to register the coresight device for the TRBE
> instance. The trbe_cpudata for the TRBE instance is initialized only
> when it is probed. Otherwise, we could end up dereferencing a NULL
> cpudata->drvdata.
> 
> e.g:
> 
> [    0.149999] coresight ete0: CPU0: ete v1.1 initialized
> [    0.149999] coresight-etm4x ete_1: ETM arch init failed
> [    0.149999] coresight-etm4x: probe of ete_1 failed with error -22
> [    0.150085] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
> [    0.150085] Mem abort info:
> [    0.150085]   ESR = 0x96000005
> [    0.150085]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.150085]   SET = 0, FnV = 0
> [    0.150085]   EA = 0, S1PTW = 0
> [    0.150085] Data abort info:
> [    0.150085]   ISV = 0, ISS = 0x00000005
> [    0.150085]   CM = 0, WnR = 0
> [    0.150085] [0000000000000050] user address but active_mm is swapper
> [    0.150085] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [    0.150085] Modules linked in:
> [    0.150085] Hardware name: FVP Base RevC (DT)
> [    0.150085] pstate: 00800009 (nzcv daif -PAN +UAO -TCO BTYPE=--)
> [    0.150155] pc : arm_trbe_register_coresight_cpu+0x74/0x144
> [    0.150155] lr : arm_trbe_register_coresight_cpu+0x48/0x144
>   ...
> 
> [    0.150237] Call trace:
> [    0.150237]  arm_trbe_register_coresight_cpu+0x74/0x144
> [    0.150237]  arm_trbe_device_probe+0x1c0/0x2d8
> [    0.150259]  platform_drv_probe+0x94/0xbc
> [    0.150259]  really_probe+0x1bc/0x4a8
> [    0.150266]  driver_probe_device+0x7c/0xb8
> [    0.150266]  device_driver_attach+0x6c/0xac
> [    0.150266]  __driver_attach+0xc4/0x148
> [    0.150266]  bus_for_each_dev+0x7c/0xc8
> [    0.150266]  driver_attach+0x24/0x30
> [    0.150266]  bus_add_driver+0x100/0x1e0
> [    0.150266]  driver_register+0x78/0x110
> [    0.150266]  __platform_driver_register+0x44/0x50
> [    0.150266]  arm_trbe_init+0x28/0x84
> [    0.150266]  do_one_initcall+0x94/0x2bc
> [    0.150266]  do_initcall_level+0xa4/0x158
> [    0.150266]  do_initcalls+0x54/0x94
> [    0.150319]  do_basic_setup+0x24/0x30
> [    0.150319]  kernel_init_freeable+0xe8/0x14c
> [    0.150319]  kernel_init+0x14/0x18c
> [    0.150319]  ret_from_fork+0x10/0x30
> [    0.150319] Code: f94012c8 b0004ce2 9134a442 52819801 (f9402917)
> [    0.150319] ---[ end trace d23e0cfe5098535e ]---
> [    0.150346] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> Fix this by skipping the step, if we are unable to probe the CPU.
> 
> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
> Reported-by: Bransilav Rankov <branislav.rankov@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Tested-by: Branislav Rankov <branislav.rankov@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

I have applied this patch.

Thanks,
Mathieu

> ---
> Changes since v1:
>  - Explain why we crash
>  - Add a WARN_ON to ensure the probe was successful.
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 5d350acef798..27225b88a2fc 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1182,6 +1182,10 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
>  	if (WARN_ON(trbe_csdev))
>  		return;
>  
> +	/* If the TRBE was not probed on the CPU, we shouldn't be here */
> +	if (WARN_ON(!cpudata->drvdata))
> +		return;
> +
>  	dev = &cpudata->drvdata->pdev->dev;
>  	desc.name = devm_kasprintf(dev, GFP_KERNEL, "trbe%d", cpu);
>  	if (!desc.name)
> @@ -1286,7 +1290,9 @@ static int arm_trbe_probe_coresight(struct trbe_drvdata *drvdata)
>  		return -ENOMEM;
>  
>  	for_each_cpu(cpu, &drvdata->supported_cpus) {
> -		smp_call_function_single(cpu, arm_trbe_probe_cpu, drvdata, 1);
> +		/* If we fail to probe the CPU, let us defer it to hotplug callbacks */
> +		if (smp_call_function_single(cpu, arm_trbe_probe_cpu, drvdata, 1))
> +			continue;
>  		if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
>  			arm_trbe_register_coresight_cpu(drvdata, cpu);
>  		if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
> -- 
> 2.25.4
> 
