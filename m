Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B52316F76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhBJTCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhBJTBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:01:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935E6C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:00:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gx20so1702313pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JS4FpThZqdop34FmCbp9hig2VuvSisJmQRqbbfLHQr0=;
        b=Jn9AThiHMBuNKTWFR9idQQOOyeZFP26S3LeXRp8wacucXJrzNZduUTEeh7OdiLs3CU
         E4+ec2S70PQBwxQ1Cnn34VkJ8Us96qVV8xAvBPyflaoQ5CH5v8JMMpLLK6qCMGLsrmLN
         XR1u1b4ls3fKkJ7ENdaA/ChfsfEt82S899oiL1N0Ua6GF9VZFc54vGMYKWiTDpLUDEKl
         Esk+AeApjy7Ed8ulkELq46JVwrR0gfCHPpwv7avTdSVOgdN+ilyxRjXAYT69gycAKxH6
         KbJPtxvlazYMD0I3p2z+fwgsKoXKpGEhfoLOt4zZ+aBcvTLz9LSQiaNtIApPIcMH4Kpk
         pezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JS4FpThZqdop34FmCbp9hig2VuvSisJmQRqbbfLHQr0=;
        b=M0KOpWnOOZ3D3zc274EDyJ34Ww96dOyQxJcp/k4xyxjK39vUyRspgDFN8kpkv3S8xA
         k9LsLc3KtBzGLTe1oh06CSyB39SE1YW5UIs4nSoFtUo+bFnAkhKWm0pryJYtDBBNVcRr
         jTVsZcoVUIydg569xC79LFcvOIZoG28MqwesHmOWPWuWd9PbR8iZM1LwwNyBs3EAPj/e
         qMTTBtXhbijGTk5ap7LufiUxfplHkhmjI/XXOhNp7j/B4n1t2t+L9f57Y3tWJOTn7fA/
         aX6bCq65nTIgVU6LtO7gh1kFXq7PkBJpXI+x/t2yRUOZg+wYPeFckP3TGvuBHPv7kV+l
         Dh+g==
X-Gm-Message-State: AOAM530wJPay3VxrvYIOytFN40oLodresSpSeY/9OMEyveYsPkITFloB
        ewiD3A0xrmddyvADzALFRqae7g==
X-Google-Smtp-Source: ABdhPJwXtthP/aPvopsYO6FJfk3kiYm1TKowdY97bvdLrLgyr8CvIoU95K59VM14vI/svDvLMjxLbw==
X-Received: by 2002:a17:90b:4902:: with SMTP id kr2mr333019pjb.130.1612983632050;
        Wed, 10 Feb 2021 11:00:32 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id r4sm2949746pgp.16.2021.02.10.11.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:00:29 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:00:27 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 11/14] coresight: sink: Add TRBE driver
Message-ID: <20210210190027.GC2186000@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:25:35PM +0530, Anshuman Khandual wrote:
> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which is
> accessible via the system registers. The TRBE supports different addressing
> modes including CPU virtual address and buffer modes including the circular
> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_EL1),
> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But the
> access to the trace buffer could be prohibited by a higher exception level
> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a CPU
> private interrupt (PPI) on address translation errors and when the buffer
> is full. Overall implementation here is inspired from the Arm SPE driver.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V3:
> 
> - Added new DT bindings document TRBE.yaml
> - Changed TRBLIMITR_TRIG_MODE_SHIFT from 2 to 3
> - Dropped isb() from trbe_reset_local()
> - Dropped gap between (void *) and buf->trbe_base
> - Changed 'int' to 'unsigned int' in is_trbe_available()
> - Dropped unused function set_trbe_running(), set_trbe_virtual_mode(),
>   set_trbe_enabled() and set_trbe_limit_pointer()
> - Changed get_trbe_flag_update(), is_trbe_programmable() and
>   get_trbe_address_align() to accept TRBIDR value
> - Changed is_trbe_running(), is_trbe_abort(), is_trbe_wrap(), is_trbe_trg(),
>   is_trbe_irq(), get_trbe_bsc() and get_trbe_ec() to accept TRBSR value
> - Dropped snapshot mode condition in arm_trbe_alloc_buffer()
> - Exit arm_trbe_init() when arm64_kernel_unmapped_at_el0() is enabled
> - Compute trbe_limit before trbe_write to get the updated handle
> - Added trbe_stop_and_truncate_event()
> - Dropped trbe_handle_fatal()
> 
>  Documentation/trace/coresight/coresight-trbe.rst |   39 +
>  arch/arm64/include/asm/sysreg.h                  |    1 +
>  drivers/hwtracing/coresight/Kconfig              |   11 +
>  drivers/hwtracing/coresight/Makefile             |    1 +
>  drivers/hwtracing/coresight/coresight-trbe.c     | 1023 ++++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-trbe.h     |  160 ++++
>  6 files changed, 1235 insertions(+)
>  create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
> +

[...]

> +static void arm_trbe_probe_coresight_cpu(void *info)
> +{
> +	struct trbe_drvdata *drvdata = info;
> +	struct coresight_desc desc = { 0 };
> +	int cpu = smp_processor_id();
> +	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> +	struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
> +	u64 trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
> +	struct device *dev;
> +
> +	if (WARN_ON(!cpudata))
> +		goto cpu_clear;

There is already a check for this in arm_trbe_probe_coresight(), we couldn't be
here if there was a problem with the allocation.

> +
> +	if (trbe_csdev)
> +		return;

Now that's a reason to have a WARN_ON().  If we are probing and a sink is
already present in this cpu's slot, something went seriously wrong and we should
be clear about it.

> +
> +	cpudata->cpu = smp_processor_id();
> +	cpudata->drvdata = drvdata;
> +	dev = &cpudata->drvdata->pdev->dev;
> +
> +	if (!is_trbe_available()) {
> +		pr_err("TRBE is not implemented on cpu %d\n", cpudata->cpu);
> +		goto cpu_clear;
> +	}
> +
> +	if (!is_trbe_programmable(trbidr)) {
> +		pr_err("TRBE is owned in higher exception level on cpu %d\n", cpudata->cpu);
> +		goto cpu_clear;
> +	}
> +	desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", DRVNAME, smp_processor_id());

We will end up with "arm_trbe0", "arm_trbe1" and so on in sysfs...  Is the
"arm_" part absolutely needed?  I think this should be like what we do for etmv3
and etmv4 where only "etmX" shows up in sysfs.

> +	if (IS_ERR(desc.name))
> +		goto cpu_clear;
> +
> +	desc.type = CORESIGHT_DEV_TYPE_SINK;
> +	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
> +	desc.ops = &arm_trbe_cs_ops;
> +	desc.pdata = dev_get_platdata(dev);
> +	desc.groups = arm_trbe_groups;
> +	desc.dev = dev;
> +	trbe_csdev = coresight_register(&desc);
> +	if (IS_ERR(trbe_csdev))
> +		goto cpu_clear;
> +
> +	dev_set_drvdata(&trbe_csdev->dev, cpudata);
> +	cpudata->trbe_dbm = get_trbe_flag_update(trbidr);
> +	cpudata->trbe_align = 1ULL << get_trbe_address_align(trbidr);
> +	if (cpudata->trbe_align > SZ_2K) {
> +		pr_err("Unsupported alignment on cpu %d\n", cpudata->cpu);
> +		goto cpu_clear;

Here coresight_unregister() should be called.  The other option is to call
coresight_register() when everything else is known to be fine, which is the
favoured approach.

> +	}
> +	per_cpu(csdev_sink, cpu) = trbe_csdev;
> +	trbe_reset_local();
> +	enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
> +	return;
> +cpu_clear:
> +	cpumask_clear_cpu(cpudata->cpu, &cpudata->drvdata->supported_cpus);
> +}
> +
> +static void arm_trbe_remove_coresight_cpu(void *info)
> +{
> +	int cpu = smp_processor_id();
> +	struct trbe_drvdata *drvdata = info;
> +	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> +	struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
> +
> +	if (trbe_csdev) {

In what scenario do you see not having a trbe_csdev and still needing to disable
IRQs for the HW?  If there is a such a case then a few lines of comment is
needed.

> +		coresight_unregister(trbe_csdev);
> +		cpudata->drvdata = NULL;
> +		per_cpu(csdev_sink, cpu) = NULL;
> +	}
> +	disable_percpu_irq(drvdata->irq);
> +	trbe_reset_local();

Theoretically this code shouldn't run when the TRBE is enabled, because the CS
core will prevent that from happening.  As sush disabling interrupts after
coresight_unregister() has been called and setting cpudata->drvdata to NULL
should be fine.  But from an outsider's point of view it will look very bizarre.
Either write a comment to explain all that or call the above two before doing
the cleanup.

> +}
> +
> +static int arm_trbe_probe_coresight(struct trbe_drvdata *drvdata)
> +{
> +	drvdata->cpudata = alloc_percpu(typeof(*drvdata->cpudata));
> +	if (IS_ERR(drvdata->cpudata))
> +		return PTR_ERR(drvdata->cpudata);

As far as I can tell alloc_percpu() returns NULL on failure and nothing else.

> +
> +	arm_trbe_probe_coresight_cpu(drvdata);
> +	smp_call_function_many(&drvdata->supported_cpus, arm_trbe_probe_coresight_cpu, drvdata, 1);

The above two calls look racy to me.  The executing process could be moved to
another CPU between the call to arm_trbe_probe_coresight_cpu() and
smp_call_function_many(), which would prevent the initialisation of the TRBE on
the new CPU to be done.  I suggest using a for_each_cpu() loop where
smp_call_function_single() would be used.  That way we are guaranteed all the
TRBEs will be initialised.

> +	return 0;
> +}
> +
> +static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
> +{
> +	arm_trbe_remove_coresight_cpu(drvdata);
> +	smp_call_function_many(&drvdata->supported_cpus, arm_trbe_remove_coresight_cpu, drvdata, 1);

Same as above.

I'm out of time for today, more to come tomorrow.

Mathieu

> +	free_percpu(drvdata->cpudata);
> +	return 0;
> +}
> +
> +static int arm_trbe_cpu_startup(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
> +
> +	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
> +		if (!per_cpu(csdev_sink, cpu)) {
> +			arm_trbe_probe_coresight_cpu(drvdata);
> +		} else {
> +			trbe_reset_local();
> +			enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
> +
> +	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
> +		disable_percpu_irq(drvdata->irq);
> +		trbe_reset_local();
> +	}
> +	return 0;
> +}
> +
> +static int arm_trbe_probe_cpuhp(struct trbe_drvdata *drvdata)
> +{
> +	enum cpuhp_state trbe_online;
> +
> +	trbe_online = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRVNAME,
> +					arm_trbe_cpu_startup, arm_trbe_cpu_teardown);
> +	if (trbe_online < 0)
> +		return -EINVAL;
> +
> +	if (cpuhp_state_add_instance(trbe_online, &drvdata->hotplug_node))
> +		return -EINVAL;
> +
> +	drvdata->trbe_online = trbe_online;
> +	return 0;
> +}
> +
> +static void arm_trbe_remove_cpuhp(struct trbe_drvdata *drvdata)
> +{
> +	cpuhp_remove_multi_state(drvdata->trbe_online);
> +}
> +
> +static int arm_trbe_probe_irq(struct platform_device *pdev,
> +			      struct trbe_drvdata *drvdata)
> +{
> +	drvdata->irq = platform_get_irq(pdev, 0);
> +	if (!drvdata->irq) {
> +		pr_err("IRQ not found for the platform device\n");
> +		return -ENXIO;
> +	}
> +
> +	if (!irq_is_percpu(drvdata->irq)) {
> +		pr_err("IRQ is not a PPI\n");
> +		return -EINVAL;
> +	}
> +
> +	if (irq_get_percpu_devid_partition(drvdata->irq, &drvdata->supported_cpus))
> +		return -EINVAL;
> +
> +	drvdata->handle = alloc_percpu(typeof(*drvdata->handle));
> +	if (!drvdata->handle)
> +		return -ENOMEM;
> +
> +	if (request_percpu_irq(drvdata->irq, arm_trbe_irq_handler, DRVNAME, drvdata->handle)) {
> +		free_percpu(drvdata->handle);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static void arm_trbe_remove_irq(struct trbe_drvdata *drvdata)
> +{
> +	free_percpu_irq(drvdata->irq, drvdata->handle);
> +	free_percpu(drvdata->handle);
> +}
> +
> +static int arm_trbe_device_probe(struct platform_device *pdev)
> +{
> +	struct coresight_platform_data *pdata;
> +	struct trbe_drvdata *drvdata;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (IS_ERR(drvdata))
> +		return -ENOMEM;
> +
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata)) {
> +		kfree(drvdata);
> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata(dev, drvdata);
> +	dev->platform_data = pdata;
> +	drvdata->pdev = pdev;
> +	ret = arm_trbe_probe_irq(pdev, drvdata);
> +	if (ret)
> +		goto irq_failed;
> +
> +	ret = arm_trbe_probe_coresight(drvdata);
> +	if (ret)
> +		goto probe_failed;
> +
> +	ret = arm_trbe_probe_cpuhp(drvdata);
> +	if (ret)
> +		goto cpuhp_failed;
> +
> +	return 0;
> +cpuhp_failed:
> +	arm_trbe_remove_coresight(drvdata);
> +probe_failed:
> +	arm_trbe_remove_irq(drvdata);
> +irq_failed:
> +	kfree(pdata);
> +	kfree(drvdata);
> +	return ret;
> +}
> +
> +static int arm_trbe_device_remove(struct platform_device *pdev)
> +{
> +	struct coresight_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct trbe_drvdata *drvdata = platform_get_drvdata(pdev);
> +
> +	arm_trbe_remove_coresight(drvdata);
> +	arm_trbe_remove_cpuhp(drvdata);
> +	arm_trbe_remove_irq(drvdata);
> +	kfree(pdata);
> +	kfree(drvdata);
> +	return 0;
> +}
> +
> +static const struct of_device_id arm_trbe_of_match[] = {
> +	{ .compatible = "arm,trace-buffer-extension"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, arm_trbe_of_match);
> +
> +static struct platform_driver arm_trbe_driver = {
> +	.driver	= {
> +		.name = DRVNAME,
> +		.of_match_table = of_match_ptr(arm_trbe_of_match),
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe	= arm_trbe_device_probe,
> +	.remove	= arm_trbe_device_remove,
> +};
> +
> +static int __init arm_trbe_init(void)
> +{
> +	int ret;
> +
> +	if (arm64_kernel_unmapped_at_el0()) {
> +		pr_err("TRBE wouldn't work if kernel gets unmapped at EL0\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = platform_driver_register(&arm_trbe_driver);
> +	if (!ret)
> +		return 0;
> +
> +	pr_err("Error registering %s platform driver\n", DRVNAME);
> +	return ret;
> +}
> +
> +static void __exit arm_trbe_exit(void)
> +{
> +	platform_driver_unregister(&arm_trbe_driver);
> +}
> +module_init(arm_trbe_init);
> +module_exit(arm_trbe_exit);
> +
> +MODULE_AUTHOR("Anshuman Khandual <anshuman.khandual@arm.com>");
> +MODULE_DESCRIPTION("Arm Trace Buffer Extension (TRBE) driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
> new file mode 100644
> index 0000000..43308bc
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-trbe.h
> @@ -0,0 +1,160 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This contains all required hardware related helper functions for
> + * Trace Buffer Extension (TRBE) driver in the coresight framework.
> + *
> + * Copyright (C) 2020 ARM Ltd.
> + *
> + * Author: Anshuman Khandual <anshuman.khandual@arm.com>
> + */
> +#include <linux/coresight.h>
> +#include <linux/device.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>
> +
> +#include "coresight-etm-perf.h"
> +
> +DECLARE_PER_CPU(struct coresight_device *, csdev_sink);
> +
> +static inline bool is_trbe_available(void)
> +{
> +	u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> +	unsigned int trbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_TRBE_SHIFT);
> +
> +	return trbe >= 0b0001;
> +}
> +
> +static inline bool is_trbe_enabled(void)
> +{
> +	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
> +
> +	return trblimitr & TRBLIMITR_ENABLE;
> +}
> +
> +#define TRBE_EC_OTHERS		0
> +#define TRBE_EC_STAGE1_ABORT	36
> +#define TRBE_EC_STAGE2_ABORT	37
> +
> +static inline int get_trbe_ec(u64 trbsr)
> +{
> +	return (trbsr >> TRBSR_EC_SHIFT) & TRBSR_EC_MASK;
> +}
> +
> +#define TRBE_BSC_NOT_STOPPED	0
> +#define	TRBE_BSC_FILLED		1
> +#define TRBE_BSC_TRIGGERED	2
> +
> +static inline int get_trbe_bsc(u64 trbsr)
> +{
> +	return (trbsr >> TRBSR_BSC_SHIFT) & TRBSR_BSC_MASK;
> +}
> +
> +static inline void clr_trbe_irq(void)
> +{
> +	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
> +
> +	trbsr &= ~TRBSR_IRQ;
> +	write_sysreg_s(trbsr, SYS_TRBSR_EL1);
> +}
> +
> +static inline bool is_trbe_irq(u64 trbsr)
> +{
> +	return trbsr & TRBSR_IRQ;
> +}
> +
> +static inline bool is_trbe_trg(u64 trbsr)
> +{
> +	return trbsr & TRBSR_TRG;
> +}
> +
> +static inline bool is_trbe_wrap(u64 trbsr)
> +{
> +	return trbsr & TRBSR_WRAP;
> +}
> +
> +static inline bool is_trbe_abort(u64 trbsr)
> +{
> +	return trbsr & TRBSR_ABORT;
> +}
> +
> +static inline bool is_trbe_running(u64 trbsr)
> +{
> +	return !(trbsr & TRBSR_STOP);
> +}
> +
> +#define TRBE_TRIG_MODE_STOP		0
> +#define TRBE_TRIG_MODE_IRQ		1
> +#define TRBE_TRIG_MODE_IGNORE		3
> +
> +#define TRBE_FILL_MODE_FILL		0
> +#define TRBE_FILL_MODE_WRAP		1
> +#define TRBE_FILL_MODE_CIRCULAR_BUFFER	3
> +
> +static inline void set_trbe_disabled(void)
> +{
> +	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
> +
> +	trblimitr &= ~TRBLIMITR_ENABLE;
> +	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
> +}
> +
> +static inline bool get_trbe_flag_update(u64 trbidr)
> +{
> +	return trbidr & TRBIDR_FLAG;
> +}
> +
> +static inline bool is_trbe_programmable(u64 trbidr)
> +{
> +	return !(trbidr & TRBIDR_PROG);
> +}
> +
> +static inline int get_trbe_address_align(u64 trbidr)
> +{
> +	return (trbidr >> TRBIDR_ALIGN_SHIFT) & TRBIDR_ALIGN_MASK;
> +}
> +
> +static inline unsigned long get_trbe_write_pointer(void)
> +{
> +	u64 trbptr = read_sysreg_s(SYS_TRBPTR_EL1);
> +	unsigned long addr = (trbptr >> TRBPTR_PTR_SHIFT) & TRBPTR_PTR_MASK;
> +
> +	return addr;
> +}
> +
> +static inline void set_trbe_write_pointer(unsigned long addr)
> +{
> +	WARN_ON(is_trbe_enabled());
> +	addr = (addr >> TRBPTR_PTR_SHIFT) & TRBPTR_PTR_MASK;
> +	write_sysreg_s(addr, SYS_TRBPTR_EL1);
> +}
> +
> +static inline unsigned long get_trbe_limit_pointer(void)
> +{
> +	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
> +	unsigned long limit = (trblimitr >> TRBLIMITR_LIMIT_SHIFT) & TRBLIMITR_LIMIT_MASK;
> +	unsigned long addr = limit << TRBLIMITR_LIMIT_SHIFT;
> +
> +	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
> +	return addr;
> +}
> +
> +static inline unsigned long get_trbe_base_pointer(void)
> +{
> +	u64 trbbaser = read_sysreg_s(SYS_TRBBASER_EL1);
> +	unsigned long addr = (trbbaser >> TRBBASER_BASE_SHIFT) & TRBBASER_BASE_MASK;
> +
> +	addr = addr << TRBBASER_BASE_SHIFT;
> +	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
> +	return addr;
> +}
> +
> +static inline void set_trbe_base_pointer(unsigned long addr)
> +{
> +	WARN_ON(is_trbe_enabled());
> +	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBLIMITR_LIMIT_SHIFT)));
> +	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
> +	write_sysreg_s(addr, SYS_TRBBASER_EL1);
> +}
> -- 
> 2.7.4
> 
