Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C8F430E11
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 05:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJRDLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 23:11:04 -0400
Received: from foss.arm.com ([217.140.110.172]:60082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhJRDLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 23:11:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10A9B11D4;
        Sun, 17 Oct 2021 20:08:52 -0700 (PDT)
Received: from [10.163.74.6] (unknown [10.163.74.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A75F33F73D;
        Sun, 17 Oct 2021 20:08:49 -0700 (PDT)
Subject: Re: [PATCH v2] coresight: trbe: Defer the probe on offline CPUs
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        Bransilav Rankov <branislav.rankov@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
References: <20211014142238.2221248-1-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b6a0a926-2008-c540-25cf-9c39f082c163@arm.com>
Date:   Mon, 18 Oct 2021 08:38:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211014142238.2221248-1-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/21 7:52 PM, Suzuki K Poulose wrote:
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

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

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
> 
