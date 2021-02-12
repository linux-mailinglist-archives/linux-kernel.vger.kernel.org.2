Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44563199C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 06:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhBLFnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 00:43:31 -0500
Received: from foss.arm.com ([217.140.110.172]:60810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhBLFn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 00:43:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7533E113E;
        Thu, 11 Feb 2021 21:42:42 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DABE33F719;
        Thu, 11 Feb 2021 21:42:39 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V3 11/14] coresight: sink: Add TRBE driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
 <20210210190027.GC2186000@xps15>
Message-ID: <9787ef82-9bd9-b3ec-b899-8e682dfa3971@arm.com>
Date:   Fri, 12 Feb 2021 11:13:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210190027.GC2186000@xps15>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/21 12:30 AM, Mathieu Poirier wrote:
> On Wed, Jan 27, 2021 at 02:25:35PM +0530, Anshuman Khandual wrote:
>> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which is
>> accessible via the system registers. The TRBE supports different addressing
>> modes including CPU virtual address and buffer modes including the circular
>> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_EL1),
>> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But the
>> access to the trace buffer could be prohibited by a higher exception level
>> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a CPU
>> private interrupt (PPI) on address translation errors and when the buffer
>> is full. Overall implementation here is inspired from the Arm SPE driver.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V3:
>>
>> - Added new DT bindings document TRBE.yaml
>> - Changed TRBLIMITR_TRIG_MODE_SHIFT from 2 to 3
>> - Dropped isb() from trbe_reset_local()
>> - Dropped gap between (void *) and buf->trbe_base
>> - Changed 'int' to 'unsigned int' in is_trbe_available()
>> - Dropped unused function set_trbe_running(), set_trbe_virtual_mode(),
>>   set_trbe_enabled() and set_trbe_limit_pointer()
>> - Changed get_trbe_flag_update(), is_trbe_programmable() and
>>   get_trbe_address_align() to accept TRBIDR value
>> - Changed is_trbe_running(), is_trbe_abort(), is_trbe_wrap(), is_trbe_trg(),
>>   is_trbe_irq(), get_trbe_bsc() and get_trbe_ec() to accept TRBSR value
>> - Dropped snapshot mode condition in arm_trbe_alloc_buffer()
>> - Exit arm_trbe_init() when arm64_kernel_unmapped_at_el0() is enabled
>> - Compute trbe_limit before trbe_write to get the updated handle
>> - Added trbe_stop_and_truncate_event()
>> - Dropped trbe_handle_fatal()
>>
>>  Documentation/trace/coresight/coresight-trbe.rst |   39 +
>>  arch/arm64/include/asm/sysreg.h                  |    1 +
>>  drivers/hwtracing/coresight/Kconfig              |   11 +
>>  drivers/hwtracing/coresight/Makefile             |    1 +
>>  drivers/hwtracing/coresight/coresight-trbe.c     | 1023 ++++++++++++++++++++++
>>  drivers/hwtracing/coresight/coresight-trbe.h     |  160 ++++
>>  6 files changed, 1235 insertions(+)
>>  create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
>>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
>> +
> 
> [...]
> 
>> +static void arm_trbe_probe_coresight_cpu(void *info)
>> +{
>> +	struct trbe_drvdata *drvdata = info;
>> +	struct coresight_desc desc = { 0 };
>> +	int cpu = smp_processor_id();
>> +	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
>> +	struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
>> +	u64 trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
>> +	struct device *dev;
>> +
>> +	if (WARN_ON(!cpudata))
>> +		goto cpu_clear;
> 
> There is already a check for this in arm_trbe_probe_coresight(), we couldn't be
> here if there was a problem with the allocation.

Right but just to be extra cautious. Do you really want this to be dropped ?

> 
>> +
>> +	if (trbe_csdev)
>> +		return;
> 
> Now that's a reason to have a WARN_ON().  If we are probing and a sink is
> already present in this cpu's slot, something went seriously wrong and we should
> be clear about it.

Right, will add an WARN_ON().

> 
>> +
>> +	cpudata->cpu = smp_processor_id();
>> +	cpudata->drvdata = drvdata;
>> +	dev = &cpudata->drvdata->pdev->dev;
>> +
>> +	if (!is_trbe_available()) {
>> +		pr_err("TRBE is not implemented on cpu %d\n", cpudata->cpu);
>> +		goto cpu_clear;
>> +	}
>> +
>> +	if (!is_trbe_programmable(trbidr)) {
>> +		pr_err("TRBE is owned in higher exception level on cpu %d\n", cpudata->cpu);
>> +		goto cpu_clear;
>> +	}
>> +	desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", DRVNAME, smp_processor_id());
> 
> We will end up with "arm_trbe0", "arm_trbe1" and so on in sysfs...  Is the
> "arm_" part absolutely needed?  I think this should be like what we do for etmv3
> and etmv4 where only "etmX" shows up in sysfs.

Okay, will drop arm_ here. IIRC this was originally trbeX where X is the cpu number
but then ended up using DRVNAME as prefix.

> 
>> +	if (IS_ERR(desc.name))
>> +		goto cpu_clear;
>> +
>> +	desc.type = CORESIGHT_DEV_TYPE_SINK;
>> +	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
>> +	desc.ops = &arm_trbe_cs_ops;
>> +	desc.pdata = dev_get_platdata(dev);
>> +	desc.groups = arm_trbe_groups;
>> +	desc.dev = dev;
>> +	trbe_csdev = coresight_register(&desc);
>> +	if (IS_ERR(trbe_csdev))
>> +		goto cpu_clear;
>> +
>> +	dev_set_drvdata(&trbe_csdev->dev, cpudata);
>> +	cpudata->trbe_dbm = get_trbe_flag_update(trbidr);
>> +	cpudata->trbe_align = 1ULL << get_trbe_address_align(trbidr);
>> +	if (cpudata->trbe_align > SZ_2K) {
>> +		pr_err("Unsupported alignment on cpu %d\n", cpudata->cpu);
>> +		goto cpu_clear;
> 
> Here coresight_unregister() should be called.  The other option is to call
> coresight_register() when everything else is known to be fine, which is the
> favoured approach.

Okay, will change accordingly.

> 
>> +	}
>> +	per_cpu(csdev_sink, cpu) = trbe_csdev;
>> +	trbe_reset_local();
>> +	enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
>> +	return;
>> +cpu_clear:
>> +	cpumask_clear_cpu(cpudata->cpu, &cpudata->drvdata->supported_cpus);
>> +}
>> +
>> +static void arm_trbe_remove_coresight_cpu(void *info)
>> +{
>> +	int cpu = smp_processor_id();
>> +	struct trbe_drvdata *drvdata = info;
>> +	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
>> +	struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
>> +
>> +	if (trbe_csdev) {
> 
> In what scenario do you see not having a trbe_csdev and still needing to disable
> IRQs for the HW?  If there is a such a case then a few lines of comment is
> needed.
> 
>> +		coresight_unregister(trbe_csdev);
>> +		cpudata->drvdata = NULL;
>> +		per_cpu(csdev_sink, cpu) = NULL;
>> +	}
>> +	disable_percpu_irq(drvdata->irq);
>> +	trbe_reset_local();
> 
> Theoretically this code shouldn't run when the TRBE is enabled, because the CS
> core will prevent that from happening.  As sush disabling interrupts after
> coresight_unregister() has been called and setting cpudata->drvdata to NULL
> should be fine.  But from an outsider's point of view it will look very bizarre.
> Either write a comment to explain all that or call the above two before doing
> the cleanup.

Okay, will move them before the cleanup.

> 
>> +}
>> +
>> +static int arm_trbe_probe_coresight(struct trbe_drvdata *drvdata)
>> +{
>> +	drvdata->cpudata = alloc_percpu(typeof(*drvdata->cpudata));
>> +	if (IS_ERR(drvdata->cpudata))
>> +		return PTR_ERR(drvdata->cpudata);
> 
> As far as I can tell alloc_percpu() returns NULL on failure and nothing else.

Sure, will change the return code as -ENOMEM when alloc_percpu() returns NULL.

> 
>> +
>> +	arm_trbe_probe_coresight_cpu(drvdata);
>> +	smp_call_function_many(&drvdata->supported_cpus, arm_trbe_probe_coresight_cpu, drvdata, 1);
> 
> The above two calls look racy to me.  The executing process could be moved to
> another CPU between the call to arm_trbe_probe_coresight_cpu() and
> smp_call_function_many(), which would prevent the initialisation of the TRBE on
> the new CPU to be done.  I suggest using a for_each_cpu() loop where
> smp_call_function_single() would be used.  That way we are guaranteed all the
> TRBEs will be initialised.

Okay, will change.

> 
>> +	return 0;
>> +}
>> +
>> +static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
>> +{
>> +	arm_trbe_remove_coresight_cpu(drvdata);
>> +	smp_call_function_many(&drvdata->supported_cpus, arm_trbe_remove_coresight_cpu, drvdata, 1);
> 
> Same as above.

Okay, will do.

> 
> I'm out of time for today, more to come tomorrow.

Okay.

> 
> Mathieu

- Anshuman
