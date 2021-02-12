Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BA031A339
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhBLRDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhBLRDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:03:39 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6DCC061793
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:02:35 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id m2so36680pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OqAA6wD2DjMDd7cRNoHgVl0nmOgzOr2P9+ONBKdwN5I=;
        b=l61Qj4HDzjGSxnFY8E+jg3MhDKAXZfG+Y2tEi1bMu7CCjSLBb4lE9LA+7TawOAK8wW
         HD/cqp3h3dYzJ01ssjvd0TxImPMe6SCwartYc6hUYQk0qJ6pweTgd74glSxeexJmr5mP
         UmkT4cepakMpYax9Panjpr56ANdloRzJzaaw2jCTIc6EGdKm/9viHInS938nKzEsWQCW
         FKM9UicMHizbk+5cj1Xelv8sfoB+S23aStCiyaFVZYYwjyvGxFqooEF2vtYw2foeJ6Xw
         x0gF7Z3zuT2GYR+UpEwoH+JY2tgPSmNIIlo77fVfo8GL6IPX7MFVSwI1BUzolx6xxUNi
         ypgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OqAA6wD2DjMDd7cRNoHgVl0nmOgzOr2P9+ONBKdwN5I=;
        b=NGhZObxJi1sk/yrxaNhl5fgmHCFxtPUJWEWdAsp/08HOeL754y+0QJHGoc5li9/uvA
         gxp7Kl5OXGyy4+MzVrxAxZ0/CgCzqzwGsUfTQ0OuJq9UnDzWW1GzhGDAI2xLHlUvEzB4
         P+EBh30LBTMWglUna/UjXWrMADV489ns+NG9OgpOosC4iCF4j1NnIzaNT6G86sxhZgiR
         OiZslmVkdPF0B4LlW5E+I3odAcw5IiqDTAZ6q3d1yuZ3x+yYZMJ8qQt8/iWfte8aXPzK
         lfhJXKqqYbiHc5AofeuXshGkXleABX0fb1HMn99eXXsXbiiMyXSI1SFGTdtay6Tma22l
         KzZg==
X-Gm-Message-State: AOAM530z3KY5m1vxT7q5TyVFHLBQA4A8whRUF14BQtiChuyWShVkA5YD
        3y+bk2EwUGPelT2wqPH0Ta2irA==
X-Google-Smtp-Source: ABdhPJwkdIz0d6pjtGrm/NUTxMijc3MOxCcY3uRsUWDTA7rc3DtS+Ldldj5vqrRP5dSE6I9CV5rEEQ==
X-Received: by 2002:a65:56c6:: with SMTP id w6mr1552254pgs.368.1613149354826;
        Fri, 12 Feb 2021 09:02:34 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 17sm9884713pgy.53.2021.02.12.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 09:02:34 -0800 (PST)
Date:   Fri, 12 Feb 2021 10:02:32 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 11/14] coresight: sink: Add TRBE driver
Message-ID: <20210212170232.GB2692426@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
 <20210210190027.GC2186000@xps15>
 <9787ef82-9bd9-b3ec-b899-8e682dfa3971@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9787ef82-9bd9-b3ec-b899-8e682dfa3971@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 11:13:01AM +0530, Anshuman Khandual wrote:
> 
> 
> On 2/11/21 12:30 AM, Mathieu Poirier wrote:
> > On Wed, Jan 27, 2021 at 02:25:35PM +0530, Anshuman Khandual wrote:
> >> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which is
> >> accessible via the system registers. The TRBE supports different addressing
> >> modes including CPU virtual address and buffer modes including the circular
> >> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_EL1),
> >> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But the
> >> access to the trace buffer could be prohibited by a higher exception level
> >> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a CPU
> >> private interrupt (PPI) on address translation errors and when the buffer
> >> is full. Overall implementation here is inspired from the Arm SPE driver.
> >>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Mike Leach <mike.leach@linaro.org>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >> Changes in V3:
> >>
> >> - Added new DT bindings document TRBE.yaml
> >> - Changed TRBLIMITR_TRIG_MODE_SHIFT from 2 to 3
> >> - Dropped isb() from trbe_reset_local()
> >> - Dropped gap between (void *) and buf->trbe_base
> >> - Changed 'int' to 'unsigned int' in is_trbe_available()
> >> - Dropped unused function set_trbe_running(), set_trbe_virtual_mode(),
> >>   set_trbe_enabled() and set_trbe_limit_pointer()
> >> - Changed get_trbe_flag_update(), is_trbe_programmable() and
> >>   get_trbe_address_align() to accept TRBIDR value
> >> - Changed is_trbe_running(), is_trbe_abort(), is_trbe_wrap(), is_trbe_trg(),
> >>   is_trbe_irq(), get_trbe_bsc() and get_trbe_ec() to accept TRBSR value
> >> - Dropped snapshot mode condition in arm_trbe_alloc_buffer()
> >> - Exit arm_trbe_init() when arm64_kernel_unmapped_at_el0() is enabled
> >> - Compute trbe_limit before trbe_write to get the updated handle
> >> - Added trbe_stop_and_truncate_event()
> >> - Dropped trbe_handle_fatal()
> >>
> >>  Documentation/trace/coresight/coresight-trbe.rst |   39 +
> >>  arch/arm64/include/asm/sysreg.h                  |    1 +
> >>  drivers/hwtracing/coresight/Kconfig              |   11 +
> >>  drivers/hwtracing/coresight/Makefile             |    1 +
> >>  drivers/hwtracing/coresight/coresight-trbe.c     | 1023 ++++++++++++++++++++++
> >>  drivers/hwtracing/coresight/coresight-trbe.h     |  160 ++++
> >>  6 files changed, 1235 insertions(+)
> >>  create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
> >>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
> >> +
> > 
> > [...]
> > 
> >> +static void arm_trbe_probe_coresight_cpu(void *info)
> >> +{
> >> +	struct trbe_drvdata *drvdata = info;
> >> +	struct coresight_desc desc = { 0 };
> >> +	int cpu = smp_processor_id();
> >> +	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> >> +	struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
> >> +	u64 trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
> >> +	struct device *dev;
> >> +
> >> +	if (WARN_ON(!cpudata))
> >> +		goto cpu_clear;
> > 
> > There is already a check for this in arm_trbe_probe_coresight(), we couldn't be
> > here if there was a problem with the allocation.
> 
> Right but just to be extra cautious. Do you really want this to be dropped ?

I don't think it is necessary but there is no harm in keeping it if you are keen
on it.

> 
> > 
> >> +
> >> +	if (trbe_csdev)
> >> +		return;
> > 
> > Now that's a reason to have a WARN_ON().  If we are probing and a sink is
> > already present in this cpu's slot, something went seriously wrong and we should
> > be clear about it.
> 
> Right, will add an WARN_ON().
> 
> > 
> >> +
> >> +	cpudata->cpu = smp_processor_id();
> >> +	cpudata->drvdata = drvdata;
> >> +	dev = &cpudata->drvdata->pdev->dev;
> >> +
> >> +	if (!is_trbe_available()) {
> >> +		pr_err("TRBE is not implemented on cpu %d\n", cpudata->cpu);
> >> +		goto cpu_clear;
> >> +	}
> >> +
> >> +	if (!is_trbe_programmable(trbidr)) {
> >> +		pr_err("TRBE is owned in higher exception level on cpu %d\n", cpudata->cpu);
> >> +		goto cpu_clear;
> >> +	}
> >> +	desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", DRVNAME, smp_processor_id());
> > 
> > We will end up with "arm_trbe0", "arm_trbe1" and so on in sysfs...  Is the
> > "arm_" part absolutely needed?  I think this should be like what we do for etmv3
> > and etmv4 where only "etmX" shows up in sysfs.
> 
> Okay, will drop arm_ here. IIRC this was originally trbeX where X is the cpu number
> but then ended up using DRVNAME as prefix.
> 
> > 
> >> +	if (IS_ERR(desc.name))
> >> +		goto cpu_clear;
> >> +
> >> +	desc.type = CORESIGHT_DEV_TYPE_SINK;
> >> +	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
> >> +	desc.ops = &arm_trbe_cs_ops;
> >> +	desc.pdata = dev_get_platdata(dev);
> >> +	desc.groups = arm_trbe_groups;
> >> +	desc.dev = dev;
> >> +	trbe_csdev = coresight_register(&desc);
> >> +	if (IS_ERR(trbe_csdev))
> >> +		goto cpu_clear;
> >> +
> >> +	dev_set_drvdata(&trbe_csdev->dev, cpudata);
> >> +	cpudata->trbe_dbm = get_trbe_flag_update(trbidr);
> >> +	cpudata->trbe_align = 1ULL << get_trbe_address_align(trbidr);
> >> +	if (cpudata->trbe_align > SZ_2K) {
> >> +		pr_err("Unsupported alignment on cpu %d\n", cpudata->cpu);
> >> +		goto cpu_clear;
> > 
> > Here coresight_unregister() should be called.  The other option is to call
> > coresight_register() when everything else is known to be fine, which is the
> > favoured approach.
> 
> Okay, will change accordingly.
> 
> > 
> >> +	}
> >> +	per_cpu(csdev_sink, cpu) = trbe_csdev;
> >> +	trbe_reset_local();
> >> +	enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
> >> +	return;
> >> +cpu_clear:
> >> +	cpumask_clear_cpu(cpudata->cpu, &cpudata->drvdata->supported_cpus);
> >> +}
> >> +
> >> +static void arm_trbe_remove_coresight_cpu(void *info)
> >> +{
> >> +	int cpu = smp_processor_id();
> >> +	struct trbe_drvdata *drvdata = info;
> >> +	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
> >> +	struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
> >> +
> >> +	if (trbe_csdev) {
> > 
> > In what scenario do you see not having a trbe_csdev and still needing to disable
> > IRQs for the HW?  If there is a such a case then a few lines of comment is
> > needed.
> > 
> >> +		coresight_unregister(trbe_csdev);
> >> +		cpudata->drvdata = NULL;
> >> +		per_cpu(csdev_sink, cpu) = NULL;
> >> +	}
> >> +	disable_percpu_irq(drvdata->irq);
> >> +	trbe_reset_local();
> > 
> > Theoretically this code shouldn't run when the TRBE is enabled, because the CS
> > core will prevent that from happening.  As sush disabling interrupts after
> > coresight_unregister() has been called and setting cpudata->drvdata to NULL
> > should be fine.  But from an outsider's point of view it will look very bizarre.
> > Either write a comment to explain all that or call the above two before doing
> > the cleanup.
> 
> Okay, will move them before the cleanup.
> 
> > 
> >> +}
> >> +
> >> +static int arm_trbe_probe_coresight(struct trbe_drvdata *drvdata)
> >> +{
> >> +	drvdata->cpudata = alloc_percpu(typeof(*drvdata->cpudata));
> >> +	if (IS_ERR(drvdata->cpudata))
> >> +		return PTR_ERR(drvdata->cpudata);
> > 
> > As far as I can tell alloc_percpu() returns NULL on failure and nothing else.
> 
> Sure, will change the return code as -ENOMEM when alloc_percpu() returns NULL.
> 
> > 
> >> +
> >> +	arm_trbe_probe_coresight_cpu(drvdata);
> >> +	smp_call_function_many(&drvdata->supported_cpus, arm_trbe_probe_coresight_cpu, drvdata, 1);
> > 
> > The above two calls look racy to me.  The executing process could be moved to
> > another CPU between the call to arm_trbe_probe_coresight_cpu() and
> > smp_call_function_many(), which would prevent the initialisation of the TRBE on
> > the new CPU to be done.  I suggest using a for_each_cpu() loop where
> > smp_call_function_single() would be used.  That way we are guaranteed all the
> > TRBEs will be initialised.
> 
> Okay, will change.
> 
> > 
> >> +	return 0;
> >> +}
> >> +
> >> +static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
> >> +{
> >> +	arm_trbe_remove_coresight_cpu(drvdata);
> >> +	smp_call_function_many(&drvdata->supported_cpus, arm_trbe_remove_coresight_cpu, drvdata, 1);
> > 
> > Same as above.
> 
> Okay, will do.
> 
> > 
> > I'm out of time for today, more to come tomorrow.
> 
> Okay.
> 
> > 
> > Mathieu
> 
> - Anshuman
