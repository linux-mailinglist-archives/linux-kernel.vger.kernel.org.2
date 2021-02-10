Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190C7316BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhBJQ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhBJQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:55:40 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6466AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:55:01 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id t25so1620233pga.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GWwnKd6tF2LVRmV4liAlhg5JKWv+BbcGY0sepdq9qsw=;
        b=qCug3jYp2GRbclEY543oynuXjVQPcBCUCUaY/TXKz0cQDMWd38ihLaIRY6i4pNS33D
         DPNUT8H20KfqvLhuqhrlJOxbBV5EwWks3GVD0256OzSSd7i10IShv60RxhOgF7NIpMEX
         mmTsLFocF6mflTDweRic0ZQUC8JQ5G9IdLGwxWjOMYl4y9FAq3G0nf9zViJnQ/ROmpF/
         KBIZvmmlc1JMC6TQfjOhcC8ApzEj7ZFONBfEmXS7yWw3/hzNlaG8O4MSMkFTZunJDF+b
         Zu7GbhGEaiV4q5XbvU/wEYfkNGtM3bGBjbiXozVHpxISnrQiUwZvl+YyeLyoiMa3DNkR
         I49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GWwnKd6tF2LVRmV4liAlhg5JKWv+BbcGY0sepdq9qsw=;
        b=tmd28lAStdQ/u54ate1d/4M65PbyDL2AArvKt+dlw2So+H6UCNft/yl7p2hLPPbBAk
         JyeqihzTbnEfYhB+/uH8PjM7wlGpHX02x+XPje0l4TQtiVViRb0gwqtx0xxbib5VrZVr
         jiUqP413AfJTqQZD70tjr57rES86mWzKjKwEG/H0oI6mEYnQZ8CM8XNTZajadfpsXTXB
         /Pf8v4NzGNjxyvfytcw3vp7rLE78zUR/BJk4u5lFfynqBxP+EOcg0s0AHp95eRLfPEAV
         mctBaJLZc8ykQ+rJ60OTsdwU7EJfC0QXASRPXsqxFiIJEbwJVfkPmqHrSRNoCItAWEHy
         UKnw==
X-Gm-Message-State: AOAM531rf4HVeiBcyK5HRaDzicD42tPgDmGWJVrsKkbGNF1MK1SZJG10
        /DsIX3W57ymcaFMB8FwBaBfa3g==
X-Google-Smtp-Source: ABdhPJwTXvVvXtLtkgwgftAffJtLvmZLtvhI0rZUMb0jdwzz22GCMCiaaangi25sj0AG4Bz2zlKyYQ==
X-Received: by 2002:a62:d453:0:b029:1d6:587b:5d31 with SMTP id u19-20020a62d4530000b02901d6587b5d31mr3797362pfl.58.1612976100788;
        Wed, 10 Feb 2021 08:55:00 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id v4sm2732156pff.156.2021.02.10.08.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:55:00 -0800 (PST)
Date:   Wed, 10 Feb 2021 09:54:58 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 11/14] coresight: sink: Add TRBE driver
Message-ID: <20210210165458.GB2186000@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
 <20210205175330.GB1636242@xps15>
 <20210209173913.GA2186000@xps15>
 <e5eff56e-d894-447f-2b49-b1f2a8967ed5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5eff56e-d894-447f-2b49-b1f2a8967ed5@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:42:29AM +0530, Anshuman Khandual wrote:
> 
> 
> On 2/9/21 11:09 PM, Mathieu Poirier wrote:
> > On Fri, Feb 05, 2021 at 10:53:30AM -0700, Mathieu Poirier wrote:
> >> On Wed, Jan 27, 2021 at 02:25:35PM +0530, Anshuman Khandual wrote:
> >>> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which is
> >>> accessible via the system registers. The TRBE supports different addressing
> >>> modes including CPU virtual address and buffer modes including the circular
> >>> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_EL1),
> >>> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But the
> >>> access to the trace buffer could be prohibited by a higher exception level
> >>> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a CPU
> >>> private interrupt (PPI) on address translation errors and when the buffer
> >>> is full. Overall implementation here is inspired from the Arm SPE driver.
> >>>
> >>
> >> I got this message when applying the patch: 
> >>
> >> Applying: coresight: sink: Add TRBE driver
> >> .git/rebase-apply/patch:76: new blank line at EOF.
> >> +
> >> warning: 1 line adds whitespace errors.
> >>  
> >>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>> Cc: Mike Leach <mike.leach@linaro.org>
> >>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >>> ---
> >>> Changes in V3:
> >>>
> >>> - Added new DT bindings document TRBE.yaml
> >>> - Changed TRBLIMITR_TRIG_MODE_SHIFT from 2 to 3
> >>> - Dropped isb() from trbe_reset_local()
> >>> - Dropped gap between (void *) and buf->trbe_base
> >>> - Changed 'int' to 'unsigned int' in is_trbe_available()
> >>> - Dropped unused function set_trbe_running(), set_trbe_virtual_mode(),
> >>>   set_trbe_enabled() and set_trbe_limit_pointer()
> >>> - Changed get_trbe_flag_update(), is_trbe_programmable() and
> >>>   get_trbe_address_align() to accept TRBIDR value
> >>> - Changed is_trbe_running(), is_trbe_abort(), is_trbe_wrap(), is_trbe_trg(),
> >>>   is_trbe_irq(), get_trbe_bsc() and get_trbe_ec() to accept TRBSR value
> >>> - Dropped snapshot mode condition in arm_trbe_alloc_buffer()
> >>> - Exit arm_trbe_init() when arm64_kernel_unmapped_at_el0() is enabled
> >>> - Compute trbe_limit before trbe_write to get the updated handle
> >>> - Added trbe_stop_and_truncate_event()
> >>> - Dropped trbe_handle_fatal()
> >>>
> >>>  Documentation/trace/coresight/coresight-trbe.rst |   39 +
> >>>  arch/arm64/include/asm/sysreg.h                  |    1 +
> >>>  drivers/hwtracing/coresight/Kconfig              |   11 +
> >>>  drivers/hwtracing/coresight/Makefile             |    1 +
> >>>  drivers/hwtracing/coresight/coresight-trbe.c     | 1023 ++++++++++++++++++++++
> >>>  drivers/hwtracing/coresight/coresight-trbe.h     |  160 ++++
> >>>  6 files changed, 1235 insertions(+)
> >>>  create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
> >>>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
> >>>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
> >>>

[...]

> >>> +
> >>> +static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
> >>> +{
> >>> +	struct perf_output_handle **handle_ptr = dev;
> >>> +	struct perf_output_handle *handle = *handle_ptr;
> >>> +	enum trbe_fault_action act;
> >>> +
> >>> +	WARN_ON(!is_trbe_irq(read_sysreg_s(SYS_TRBSR_EL1)));
> >>> +	clr_trbe_irq();
> >>> +
> >>> +	/*
> >>> +	 * Ensure the trace is visible to the CPUs and
> >>> +	 * any external aborts have been resolved.
> >>> +	 */
> >>> +	trbe_drain_buffer();
> >>> +	isb();
> >>> +
> >>> +	if (!perf_get_aux(handle))
> >>> +		return IRQ_NONE;
> >>> +
> >>> +	if (!is_perf_trbe(handle))
> >>> +		return IRQ_NONE;
> >>> +
> >>> +	irq_work_run();
> > 
> > There is a comment in the SPE driver about this.  Since this driver closely
> > follows that implementation it would be nice to have the comments as well.
> > Otherwise the reader has to constantly go back to the original driver.
> 
> Sure, will add the following comment before irq_work_run().
> 
>         /*
>          * Ensure perf callbacks have completed, which may disable the
>          * profiling buffer in response to a TRUNCATION flag.
>          */
> 
> > 
> > I will come back to this function later.
> 
> Okay.
> 
> > 
> >>> +
> >>> +	act = trbe_get_fault_act(handle);
> >>> +	switch (act) {
> >>> +	case TRBE_FAULT_ACT_WRAP:
> >>> +		trbe_handle_overflow(handle);
> >>> +		break;
> >>> +	case TRBE_FAULT_ACT_SPURIOUS:
> >>> +		trbe_handle_spurious(handle);
> >>> +		break;
> >>> +	case TRBE_FAULT_ACT_FATAL:
> >>> +		trbe_stop_and_truncate_event(handle);
> >>> +		break;
> >>> +	}
> >>> +	return IRQ_HANDLED;
> >>> +}
> >>> +
> >>> +static const struct coresight_ops_sink arm_trbe_sink_ops = {
> >>> +	.enable		= arm_trbe_enable,
> >>> +	.disable	= arm_trbe_disable,
> >>> +	.alloc_buffer	= arm_trbe_alloc_buffer,
> >>> +	.free_buffer	= arm_trbe_free_buffer,
> >>> +	.update_buffer	= arm_trbe_update_buffer,
> >>> +};
> >>> +
> >>> +static const struct coresight_ops arm_trbe_cs_ops = {
> >>> +	.sink_ops	= &arm_trbe_sink_ops,
> >>> +};
> >>> +
> >>> +static ssize_t align_show(struct device *dev, struct device_attribute *attr, char *buf)
> >>> +{
> >>> +	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
> >>> +
> >>> +	return sprintf(buf, "%llx\n", cpudata->trbe_align);
> >>> +}
> >>> +static DEVICE_ATTR_RO(align);
> >>> +
> >>> +static ssize_t dbm_show(struct device *dev, struct device_attribute *attr, char *buf)
> >>> +{
> >>> +	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
> >>> +
> >>> +	return sprintf(buf, "%d\n", cpudata->trbe_dbm);
> >>> +}
> >>> +static DEVICE_ATTR_RO(dbm);
> >>> +
> >>> +static struct attribute *arm_trbe_attrs[] = {
> >>> +	&dev_attr_align.attr,
> >>> +	&dev_attr_dbm.attr,
> >>> +	NULL,
> >>> +};
> >>> +
> >>> +static const struct attribute_group arm_trbe_group = {
> >>> +	.attrs = arm_trbe_attrs,
> >>> +};
> >>> +
> >>> +static const struct attribute_group *arm_trbe_groups[] = {
> >>> +	&arm_trbe_group,
> >>> +	NULL,
> >>> +};
> >>> +
> >>> +static void arm_trbe_probe_coresight_cpu(void *info)
> >>> +{
> >>> +	struct trbe_drvdata *drvdata = info;
> >>> +	struct coresight_desc desc = { 0 };
> >>> +	int cpu = smp_processor_id();
> >>> +	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> >>> +	struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
> >>> +	u64 trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
> >>> +	struct device *dev;
> >>> +
> >>> +	if (WARN_ON(!cpudata))
> >>> +		goto cpu_clear;
> > 
> > Where was the memory for cpudata allocated?  As far as I can tell, at this time
> > it is just a pointer that was not allocated and as such it should be NULL.
> 
> cpudata gets allocated in arm_trbe_probe_coresight() just before calling
> individual CPU based probes i.e arm_trbe_probe_coresight_cpu() directly
> and via smp_call_function_many().
> 
> arm_trbe_device_probe()
> 	arm_trbe_probe_coresight()
> 		arm_trbe_probe_coresight_cpu()

Ah yes, my apologies here.  Looking at the code I realised I skipped
arm_trbe_probe_coresight() and went straight to arm_trbe_probe_coresight_cpu().
No wonder things didn't make sense.  I will take another look at this function. 

> 
> > 
> >>> +
> >>> +	if (trbe_csdev)
> >>> +		return;
> >>> +
> >>> +	cpudata->cpu = smp_processor_id();
> > 
> > Why call this again when you already did above?  And how is
> 
> Right, this is redundant. Will just assign it as cpu which has already
> been computed.
> 
> > arm_trbe_probe_coresight_cpu() is called for every CPU in the system?
> 
> During boot in arm_trbe_probe_coresight(), it is called once directly on
> the executing cpu and on all other via smp_call_function_many().
> 
> > 
> >>> +	cpudata->drvdata = drvdata;
> >>> +	dev = &cpudata->drvdata->pdev->dev;
> >>> +
> >>> +	if (!is_trbe_available()) {
> >>> +		pr_err("TRBE is not implemented on cpu %d\n", cpudata->cpu);
> >>> +		goto cpu_clear;
> >>> +	}
> >>> +
> >>> +	if (!is_trbe_programmable(trbidr)) {
> >>> +		pr_err("TRBE is owned in higher exception level on cpu %d\n", cpudata->cpu);
> >>> +		goto cpu_clear;
> >>> +	}
> >>> +	desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", DRVNAME, smp_processor_id());
> >>> +	if (IS_ERR(desc.name))
> >>> +		goto cpu_clear;
> >>> +
> >>> +	desc.type = CORESIGHT_DEV_TYPE_SINK;
> >>> +	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
> >>> +	desc.ops = &arm_trbe_cs_ops;
> >>> +	desc.pdata = dev_get_platdata(dev);
> >>> +	desc.groups = arm_trbe_groups;
> >>> +	desc.dev = dev;
> >>> +	trbe_csdev = coresight_register(&desc);
> >>> +	if (IS_ERR(trbe_csdev))
> >>> +		goto cpu_clear;
> >>> +
> >>> +	dev_set_drvdata(&trbe_csdev->dev, cpudata);
> >>> +	cpudata->trbe_dbm = get_trbe_flag_update(trbidr);
> >>> +	cpudata->trbe_align = 1ULL << get_trbe_address_align(trbidr);
> >>> +	if (cpudata->trbe_align > SZ_2K) {
> >>> +		pr_err("Unsupported alignment on cpu %d\n", cpudata->cpu);
> >>> +		goto cpu_clear;
> >>> +	}
> >>> +	per_cpu(csdev_sink, cpu) = trbe_csdev;
> >>> +	trbe_reset_local();
> >>> +	enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
> >>> +	return;
> >>> +cpu_clear:
> >>> +	cpumask_clear_cpu(cpudata->cpu, &cpudata->drvdata->supported_cpus);
> >>> +}
> >>> +
> >>> +static void arm_trbe_remove_coresight_cpu(void *info)
> >>> +{
> >>> +	int cpu = smp_processor_id();
> >>> +	struct trbe_drvdata *drvdata = info;
> >>> +	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> >>> +	struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
> >>> +
> >>> +	if (trbe_csdev) {
> >>> +		coresight_unregister(trbe_csdev);
> >>> +		cpudata->drvdata = NULL;
> >>> +		per_cpu(csdev_sink, cpu) = NULL;
> >>> +	}
> >>> +	disable_percpu_irq(drvdata->irq);
> >>> +	trbe_reset_local();
> >>> +}
> >>> +
> >>> +static int arm_trbe_probe_coresight(struct trbe_drvdata *drvdata)
> >>> +{
> >>> +	drvdata->cpudata = alloc_percpu(typeof(*drvdata->cpudata));
> >>> +	if (IS_ERR(drvdata->cpudata))
> >>> +		return PTR_ERR(drvdata->cpudata);
> >>> +
> >>> +	arm_trbe_probe_coresight_cpu(drvdata);
> >>> +	smp_call_function_many(&drvdata->supported_cpus, arm_trbe_probe_coresight_cpu, drvdata, 1);
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
> >>> +{
> >>> +	arm_trbe_remove_coresight_cpu(drvdata);
> >>> +	smp_call_function_many(&drvdata->supported_cpus, arm_trbe_remove_coresight_cpu, drvdata, 1);
> >>> +	free_percpu(drvdata->cpudata);
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int arm_trbe_cpu_startup(unsigned int cpu, struct hlist_node *node)
> >>> +{
> >>> +	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
> >>> +
> >>> +	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
> >>> +		if (!per_cpu(csdev_sink, cpu)) {
> >>> +			arm_trbe_probe_coresight_cpu(drvdata);
> >>> +		} else {
> >>> +			trbe_reset_local();
> >>> +			enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
> >>> +		}
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
> >>> +{
> >>> +	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
> >>> +
> >>> +	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
> >>> +		disable_percpu_irq(drvdata->irq);
> >>> +		trbe_reset_local();
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int arm_trbe_probe_cpuhp(struct trbe_drvdata *drvdata)
> >>> +{
> >>> +	enum cpuhp_state trbe_online;
> >>> +
> >>> +	trbe_online = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRVNAME,
> >>> +					arm_trbe_cpu_startup, arm_trbe_cpu_teardown);
> >>> +	if (trbe_online < 0)
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (cpuhp_state_add_instance(trbe_online, &drvdata->hotplug_node))
> >>> +		return -EINVAL;
> >>> +
> >>> +	drvdata->trbe_online = trbe_online;
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static void arm_trbe_remove_cpuhp(struct trbe_drvdata *drvdata)
> >>> +{
> >>> +	cpuhp_remove_multi_state(drvdata->trbe_online);
> >>> +}
> >>> +
> >>> +static int arm_trbe_probe_irq(struct platform_device *pdev,
> >>> +			      struct trbe_drvdata *drvdata)
> >>> +{
> >>> +	drvdata->irq = platform_get_irq(pdev, 0);
> >>> +	if (!drvdata->irq) {
> > 
> > Please use function platform_get_irq() properly - there is even an example on
> > how to do so in the documentation section of the function.
> 
> The documentation says, the format should be.
> 
> int irq = platform_get_irq(pdev, 0);
> if (irq < 0)
> 	return irq;
> 
> Will change the conditional check above.
> 
> > 
> >>> +		pr_err("IRQ not found for the platform device\n");
> >>> +		return -ENXIO;
> > 
> > Why use a different error code?
> 
> We could return the irq (which is < 0) but followed the SPE
> driver which returns ENXIO here. Happy to change either way.

Please use the right error code.

> 
> > 
> >>> +	}
> >>> +
> >>> +	if (!irq_is_percpu(drvdata->irq)) {
> >>> +		pr_err("IRQ is not a PPI\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	if (irq_get_percpu_devid_partition(drvdata->irq, &drvdata->supported_cpus))
> >>> +		return -EINVAL;
> >>> +
> >>> +	drvdata->handle = alloc_percpu(typeof(*drvdata->handle));
> >>> +	if (!drvdata->handle)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	if (request_percpu_irq(drvdata->irq, arm_trbe_irq_handler, DRVNAME, drvdata->handle)) {
> >>> +		free_percpu(drvdata->handle);
> >>> +		return -EINVAL;
> > 
> > Here too you need to use the error code from the calling function rather than
> > making your own.  Please revise for the entire patch.
> 
> Okay, will capture the return value from request_percpu_irq() and
> return the same when it is an error case i.e being positive.
> 
> > 
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static void arm_trbe_remove_irq(struct trbe_drvdata *drvdata)
> >>> +{
> >>> +	free_percpu_irq(drvdata->irq, drvdata->handle);
> >>> +	free_percpu(drvdata->handle);
> >>> +}
> >>> +
> >>> +static int arm_trbe_device_probe(struct platform_device *pdev)
> >>> +{
> >>> +	struct coresight_platform_data *pdata;
> >>> +	struct trbe_drvdata *drvdata;
> >>> +	struct device *dev = &pdev->dev;
> >>> +	int ret;
> >>> +
> >>> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> >>> +	if (IS_ERR(drvdata))
> >>> +		return -ENOMEM;
> > 
> >         if (!drvdata)
> 
> Changed.
> 
> > 
> >>> +
> >>> +	pdata = coresight_get_platform_data(dev);
> >>> +	if (IS_ERR(pdata)) {
> >>> +		kfree(drvdata);
> > 
> > No need to do this since devm_kzalloc() was used above.
> 
> Suzuki had pointed out these issues, have already incorporated them i.e
> dropped kfree() here.
> 

To avoid getting tunel vision I don't look at other comments before reviewing a
patchset.  As such it is possible to get redundant comments.

More to come shortly.

> > 
> >>> +		return -ENOMEM;
> > 
> > Why not using the error from coresight_get_platform_data() instead of
> > masking it?
> 
> Okay, will return PTR_ERR(pdata) instead.
> 
> > 
> >>> +	}
> >>> +
> >>> +	dev_set_drvdata(dev, drvdata);
> >>> +	dev->platform_data = pdata;
> >>> +	drvdata->pdev = pdev;
> >>> +	ret = arm_trbe_probe_irq(pdev, drvdata);
> >>> +	if (ret)
> >>> +		goto irq_failed;
> >>> +
> >>> +	ret = arm_trbe_probe_coresight(drvdata);
> >>> +	if (ret)
> >>> +		goto probe_failed;
> >>> +
> >>> +	ret = arm_trbe_probe_cpuhp(drvdata);
> >>> +	if (ret)
> >>> +		goto cpuhp_failed;
> >>> +
> >>> +	return 0;
> >>> +cpuhp_failed:
> >>> +	arm_trbe_remove_coresight(drvdata);
> >>> +probe_failed:
> >>> +	arm_trbe_remove_irq(drvdata);
> >>> +irq_failed:
> >>> +	kfree(pdata);
> >>> +	kfree(drvdata);
> > 
> > Same here - both @pdata and @drvdata have been allocated by devm_kzalloc().
> > devm_kzalloc().
> 
> Dropped these kfree() statements.
> 
> - Anshuman
