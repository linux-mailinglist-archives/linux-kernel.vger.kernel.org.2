Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52F3423E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhCSR7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhCSR6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:58:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC51FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:58:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j25so6427267pfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FB3PLWLZTbdrOnbS8xWz0IOQ83nreWeH/VNfOX0Ozes=;
        b=NIZJNfbqFY63sxAgqzLTZJEoPaq1JPsTTBd2Ss9vOAPicp9dMzcj0iqitKbxLE5lE2
         KnZfAQ2D8ifCEYiuHQik4kflNXrQ4WMGv+dWRUxkVknoyduxjcYHVBjLKaEEXAK75wXh
         AbjbjsjW6MyAK1tcVDUGW6kHMEfTQC3m+AT5hv6lb3Dj43Z4FqtlVSfVSO1yd49FedAE
         jMqfY5/KPpwoFAAMXcOI3lpcneF2fwzHx8p6/8Vanunxzm8oIK4SAJOfEBrSfWP+95bU
         V2GyIyZOCf1UmZpPtz8EAN/MQiEo1ypwwH0DcuFS9QZoGSvnDK2OcDFEsFiaySxWNUng
         cl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FB3PLWLZTbdrOnbS8xWz0IOQ83nreWeH/VNfOX0Ozes=;
        b=pLiVXk1SHlwZ5p3+XLRrTN67p99xkxoxyg93fVOI6JlkXfmBptDjy8wUlQ1U37GitI
         B1B/Bvd1n0ZHP4g9HA/My38Pasbpckk2OIjOODml4V7GBPwXaIWgBGiWyQXVcCrXso2e
         G+HgZqDnXwrf65y5etvJr+Xy++s3NIJAThnWpR9DHmjmWy6EeOG77avUa3YCuATcqfjn
         aphcstJG2EmgWJ0WtKSY5GmCyQHcKKXjpPAeEeKlgXNrfWiURIViyZqJ+OX6NSnstNsw
         KVdBRYzNa+YNbkIVyIFxCFjzLxb/rmej41O8qwcHL27xQ+zfse/fZMnTlfQU517yjBAR
         WVJA==
X-Gm-Message-State: AOAM531pP4stxMfwaJ9CZA02jkbGguqpa3DmT4aAgViNqI9F7xXx9yKB
        KIM1LSpy/DsouiIGwSJOSioC0g==
X-Google-Smtp-Source: ABdhPJxUtMcKBaTwHJNRYSJa1FS5tcwf67J60r+c73V4pijB/gRss4/n/AO8WtT1Xa5hPnAxrKgd1A==
X-Received: by 2002:a63:4956:: with SMTP id y22mr12768848pgk.309.1616176711364;
        Fri, 19 Mar 2021 10:58:31 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l10sm5835178pfc.125.2021.03.19.10.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:58:30 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:58:28 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org
Subject: Re: [PATCH v4 18/19] coresight: sink: Add TRBE driver
Message-ID: <20210319175828.GA1578047@xps15>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-19-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225193543.2920532-19-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:35:42PM +0000, Suzuki K Poulose wrote:
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> 
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
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---

[...]
 
> +
> +static const struct coresight_ops_sink arm_trbe_sink_ops = {
> +	.enable		= arm_trbe_enable,
> +	.disable	= arm_trbe_disable,
> +	.alloc_buffer	= arm_trbe_alloc_buffer,
> +	.free_buffer	= arm_trbe_free_buffer,
> +	.update_buffer	= arm_trbe_update_buffer,
> +};
> +
> +static const struct coresight_ops arm_trbe_cs_ops = {
> +	.sink_ops	= &arm_trbe_sink_ops,
> +};

I have reviewed everything below this point and things look quite good.  I will
continue with the above on Monday.

Mathieu

> +
> +static ssize_t align_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%llx\n", cpudata->trbe_align);
> +}
> +static DEVICE_ATTR_RO(align);
> +
> +static ssize_t flag_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", cpudata->trbe_flag);
> +}
> +static DEVICE_ATTR_RO(flag);
> +
> +static struct attribute *arm_trbe_attrs[] = {
> +	&dev_attr_align.attr,
> +	&dev_attr_flag.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group arm_trbe_group = {
> +	.attrs = arm_trbe_attrs,
> +};
> +
> +static const struct attribute_group *arm_trbe_groups[] = {
> +	&arm_trbe_group,
> +	NULL,
> +};
> +
> +static void arm_trbe_enable_cpu(void *info)
> +{
> +	struct trbe_drvdata *drvdata = info;
> +
> +	trbe_reset_local();
> +	enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
> +}
> +
> +static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cpu)
> +{
> +	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> +	struct coresight_device *trbe_csdev = coresight_get_percpu_sink(cpu);
> +	struct coresight_desc desc = { 0 };
> +	struct device *dev;
> +
> +	if (WARN_ON(trbe_csdev))
> +		return;
> +
> +	dev = &cpudata->drvdata->pdev->dev;
> +	desc.name = devm_kasprintf(dev, GFP_KERNEL, "trbe%d", cpu);
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
> +	coresight_set_percpu_sink(cpu, trbe_csdev);
> +	return;
> +cpu_clear:
> +	cpumask_clear_cpu(cpu, &drvdata->supported_cpus);
> +}
> +
> +static void arm_trbe_probe_cpu(void *info)
> +{
> +	struct trbe_drvdata *drvdata = info;
> +	int cpu = smp_processor_id();
> +	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> +	u64 trbidr;
> +
> +	if (WARN_ON(!cpudata))
> +		goto cpu_clear;
> +
> +	if (!is_trbe_available()) {
> +		pr_err("TRBE is not implemented on cpu %d\n", cpu);
> +		goto cpu_clear;
> +	}
> +
> +	trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
> +	if (!is_trbe_programmable(trbidr)) {
> +		pr_err("TRBE is owned in higher exception level on cpu %d\n", cpu);
> +		goto cpu_clear;
> +	}
> +
> +	cpudata->trbe_align = 1ULL << get_trbe_address_align(trbidr);
> +	if (cpudata->trbe_align > SZ_2K) {
> +		pr_err("Unsupported alignment on cpu %d\n", cpu);
> +		goto cpu_clear;
> +	}
> +	cpudata->trbe_flag = get_trbe_flag_update(trbidr);
> +	cpudata->cpu = cpu;
> +	cpudata->drvdata = drvdata;
> +	return;
> +cpu_clear:
> +	cpumask_clear_cpu(cpu, &drvdata->supported_cpus);
> +}
> +
> +static void arm_trbe_remove_coresight_cpu(void *info)
> +{
> +	int cpu = smp_processor_id();
> +	struct trbe_drvdata *drvdata = info;
> +	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> +	struct coresight_device *trbe_csdev = coresight_get_percpu_sink(cpu);
> +
> +	disable_percpu_irq(drvdata->irq);
> +	trbe_reset_local();
> +	if (trbe_csdev) {
> +		coresight_unregister(trbe_csdev);
> +		cpudata->drvdata = NULL;
> +		coresight_set_percpu_sink(cpu, NULL);
> +	}
> +}
> +
> +static int arm_trbe_probe_coresight(struct trbe_drvdata *drvdata)
> +{
> +	int cpu;
> +
> +	drvdata->cpudata = alloc_percpu(typeof(*drvdata->cpudata));
> +	if (!drvdata->cpudata)
> +		return -ENOMEM;
> +
> +	for_each_cpu(cpu, &drvdata->supported_cpus) {
> +		smp_call_function_single(cpu, arm_trbe_probe_cpu, drvdata, 1);
> +		if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
> +			arm_trbe_register_coresight_cpu(drvdata, cpu);
> +		if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
> +			smp_call_function_single(cpu, arm_trbe_enable_cpu, drvdata, 1);
> +	}
> +	return 0;
> +}
> +
> +static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
> +{
> +	int cpu;
> +
> +	for_each_cpu(cpu, &drvdata->supported_cpus)
> +		smp_call_function_single(cpu, arm_trbe_remove_coresight_cpu, drvdata, 1);
> +	free_percpu(drvdata->cpudata);
> +	return 0;
> +}
> +
> +static int arm_trbe_cpu_startup(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
> +
> +	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
> +
> +		/*
> +		 * If this CPU was not probed for TRBE,
> +		 * initialize it now.
> +		 */
> +		if (!coresight_get_percpu_sink(cpu)) {
> +			arm_trbe_probe_cpu(drvdata);
> +			if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
> +				arm_trbe_register_coresight_cpu(drvdata, cpu);
> +			if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
> +				arm_trbe_enable_cpu(drvdata);
> +		} else {
> +			arm_trbe_enable_cpu(drvdata);
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
> +	int ret;
> +
> +	trbe_online = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRVNAME,
> +					      arm_trbe_cpu_startup, arm_trbe_cpu_teardown);
> +	if (trbe_online < 0)
> +		return trbe_online;
> +
> +	ret = cpuhp_state_add_instance(trbe_online, &drvdata->hotplug_node);
> +	if (ret) {
> +		cpuhp_remove_multi_state(trbe_online);
> +		return ret;
> +	}
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
> +	int ret;
> +
> +	drvdata->irq = platform_get_irq(pdev, 0);
> +	if (drvdata->irq < 0) {
> +		pr_err("IRQ not found for the platform device\n");
> +		return drvdata->irq;
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
> +	ret = request_percpu_irq(drvdata->irq, arm_trbe_irq_handler, DRVNAME, drvdata->handle);
> +	if (ret) {
> +		free_percpu(drvdata->handle);
> +		return ret;
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
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +
> +	dev_set_drvdata(dev, drvdata);
> +	dev->platform_data = pdata;
> +	drvdata->pdev = pdev;
> +	ret = arm_trbe_probe_irq(pdev, drvdata);
> +	if (ret)
> +		return ret;
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
> +	return ret;
> +}
> +
> +static int arm_trbe_device_remove(struct platform_device *pdev)
> +{
> +	struct trbe_drvdata *drvdata = platform_get_drvdata(pdev);
> +
> +	arm_trbe_remove_cpuhp(drvdata);
> +	arm_trbe_remove_coresight(drvdata);
> +	arm_trbe_remove_irq(drvdata);
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
> index 000000000000..499b846ccfee
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-trbe.h
> @@ -0,0 +1,153 @@
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
> +#define TRBE_BSC_NOT_STOPPED 0
> +#define TRBE_BSC_FILLED      1
> +#define TRBE_BSC_TRIGGERED   2
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
> +	return read_sysreg_s(SYS_TRBPTR_EL1);
> +}
> +
> +static inline void set_trbe_write_pointer(unsigned long addr)
> +{
> +	WARN_ON(is_trbe_enabled());
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
> +	unsigned long addr = trbbaser & (TRBBASER_BASE_MASK << TRBBASER_BASE_SHIFT);
> +
> +	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
> +	return addr;
> +}
> +
> +static inline void set_trbe_base_pointer(unsigned long addr)
> +{
> +	WARN_ON(is_trbe_enabled());
> +	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBBASER_BASE_SHIFT)));
> +	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
> +	write_sysreg_s(addr, SYS_TRBBASER_EL1);
> +}
> -- 
> 2.24.1
> 
