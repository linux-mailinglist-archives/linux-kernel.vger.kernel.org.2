Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF30E341A23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCSKeT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Mar 2021 06:34:19 -0400
Received: from foss.arm.com ([217.140.110.172]:44574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhCSKeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:34:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11F00ED1;
        Fri, 19 Mar 2021 03:34:16 -0700 (PDT)
Received: from [10.57.52.33] (unknown [10.57.52.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DD4C3F70D;
        Fri, 19 Mar 2021 03:34:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v4 18/19] coresight: sink: Add TRBE driver
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20210318180824.GA1532406@xps15>
Date:   Fri, 19 Mar 2021 10:34:13 +0000
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org
Content-Transfer-Encoding: 8BIT
Message-Id: <50177F38-6EF9-46F9-88FA-AB2978AD4A9A@arm.com>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-19-suzuki.poulose@arm.com>
 <20210318180824.GA1532406@xps15>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> On 18 Mar 2021, at 18:08, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> 
> Good morning,
> 
> On Thu, Feb 25, 2021 at 07:35:42PM +0000, Suzuki K Poulose wrote:
>> From: Anshuman Khandual <anshuman.khandual@arm.com>
>> 
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

There is a mention of the SPE driver here in the commit description.

>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes:
>> - Replaced TRBLIMITR_LIMIT_SHIFT with TRBBASER_BASE_SHIFT in set_trbe_base_pointer()
>> - Dropped TRBBASER_BASE_MASK and TRBBASER_BASE_SHIFT from get_trbe_base_pointer()
>> - Indentation changes for TRBE_BSC_NOT_[STOPPED|FILLED|TRIGGERED] definitions
>> - Moved DECLARE_PER_CPU(...., csdev_sink) into coresight-priv.h
>> - Moved isb() from trbe_enable_hw() into set_trbe_limit_pointer_enabled()
>> - Dropped the space after type casting before vmap()
>> - Return 0 instead of EINVAL in arm_trbe_update_buffer()
>> - Add a comment in trbe_handle_overflow()
>> - Add a comment in arm_trbe_cpu_startup()
>> - Unregister coresight TRBE device when not supported
>> - Fix potential NULL handle dereference in IRQ handler with a spurious IRQ
>> - Read TRBIDR after is_trbe_programmable() in arm_trbe_probe_coresight_cpu()
>> - Replaced and modified trbe_drain_and_disable_local() in IRQ handler
>> - Updated arm_trbe_update_buffer() for handling a missing interrupt
>> - Dropped kfree() for all devm_xxx() allocated buffer
>> - Dropped additional blank line in documentation coresight/coresight-trbe.rst
>> - Added Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
>> - Changed CONFIG_CORESIGHT_TRBE options, dependencies and helper write up
>> - Added comment for irq_work_run()
>> - Updated comment for minumum buffer length in arm_trbe_alloc_buffer()
>> - Dropped redundant smp_processor_id() from arm_trbe_probe_coresight_cpu()
>> - Fixed indentation in arm_trbe_probe_cpuhp()
>> - Added static for arm_trbe_free_buffer()
>> - Added comment for trbe_base element in trbe_buf structure
>> - Dropped IS_ERR() check from vmap() returned pointer
>> - Added WARN_ON(trbe_csdev) in arm_trbe_probe_coresight_cpu()
>> - Changed TRBE device names from arm_trbeX to just trbeX
>> - Dropped unused argument perf_output_handle from trbe_get_fault_act()
>> - Dropped IS_ERR() from kzalloc_node()/kcalloc() buffer in arm_trbe_alloc_buffer()
>> - Dropped IS_ERR() and return -ENOMEM in arm_trbe_probe_coresight()
>> - Moved TRBE HW disabling before coresight cleanup in arm_trbe_remove_coresight_cpu()
>> - Changed error return codes from arm_trbe_probe_irq()
>> - Changed error return codes from arm_trbe_device_probe()
>> - Changed arm_trbe_remove_coresight() order in arm_trbe_device_remove()
>> - Changed TRBE CPU support probe/remove sequence with for_each_cpu() iterator
>> - Changed coresight_register() in arm_trbe_probe_coresight_cpu()
>> - Changed error return code when cpuhp_setup_state_multi() fails in arm_trbe_probe_cpuhp()
>> - Changed error return code when cpuhp_state_add_instance() fails in arm_trbe_probe_cpuhp()
>> - Changed trbe_dbm as trbe_flag including its sysfs interface
>> - Handle race between update_buffer & IRQ handler
>> - Rework and split the TRBE probe to avoid lockdep due to memory allocation
>>   from IPI calls (via coresight_register())
>> - Fix handle->head updat for snapshot mode.
>> ---
>> .../testing/sysfs-bus-coresight-devices-trbe  |   14 +
>> .../trace/coresight/coresight-trbe.rst        |   38 +
>> drivers/hwtracing/coresight/Kconfig           |   14 +
>> drivers/hwtracing/coresight/Makefile          |    1 +
>> drivers/hwtracing/coresight/coresight-trbe.c  | 1149 +++++++++++++++++
>> drivers/hwtracing/coresight/coresight-trbe.h  |  153 +++
>> 6 files changed, 1369 insertions(+)
>> create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
>> create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
> 
> Please spinoff these two file in a separate patch and CC Jon Corbet and the
> linux-doc mailing list.

Sure, makes sense.

> 
>> create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>> create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
>> 
>> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe b/Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
>> new file mode 100644
>> index 000000000000..ad3bbc6fa751
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
>> @@ -0,0 +1,14 @@
>> +What:		/sys/bus/coresight/devices/trbe<cpu>/align
>> +Date:		March 2021
>> +KernelVersion:	5.13
>> +Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
>> +Description:	(Read) Shows the TRBE write pointer alignment. This value
>> +		is fetched from the TRBIDR register.
>> +
>> +What:		/sys/bus/coresight/devices/trbe<cpu>/flag
>> +Date:		March 2021
>> +KernelVersion:	5.13
>> +Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
>> +Description:	(Read) Shows if TRBE updates in the memory are with access
>> +		and dirty flag updates as well. This value is fetched from
>> +		the TRBIDR register.
> 
> For this file:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
>> diff --git a/Documentation/trace/coresight/coresight-trbe.rst b/Documentation/trace/coresight/coresight-trbe.rst
>> new file mode 100644
>> index 000000000000..b9928ef148da
>> --- /dev/null
>> +++ b/Documentation/trace/coresight/coresight-trbe.rst
>> @@ -0,0 +1,38 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +==============================
>> +Trace Buffer Extension (TRBE).
>> +==============================
>> +
>> +    :Author:   Anshuman Khandual <anshuman.khandual@arm.com>
>> +    :Date:     November 2020
>> +
>> +Hardware Description
>> +--------------------
>> +
>> +Trace Buffer Extension (TRBE) is a percpu hardware which captures in system
>> +memory, CPU traces generated from a corresponding percpu tracing unit. This
>> +gets plugged in as a coresight sink device because the corresponding trace
>> +generators (ETE), are plugged in as source device.
>> +
>> +The TRBE is not compliant to CoreSight architecture specifications, but is
>> +driven via the CoreSight driver framework to support the ETE (which is
>> +CoreSight compliant) integration.
>> +
>> +Sysfs files and directories
>> +---------------------------
>> +
>> +The TRBE devices appear on the existing coresight bus alongside the other
>> +coresight devices::
>> +
>> +	>$ ls /sys/bus/coresight/devices
>> +	trbe0  trbe1  trbe2 trbe3
>> +
>> +The ``trbe<N>`` named TRBEs are associated with a CPU.::
>> +
>> +	>$ ls /sys/bus/coresight/devices/trbe0/
>> +        align flag
>> +
>> +*Key file items are:-*
>> +   * ``align``: TRBE write pointer alignment
>> +   * ``flag``: TRBE updates memory with access and dirty flags
> 
> For this file:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index f154ae7e705d..84530fd80998 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -173,4 +173,18 @@ config CORESIGHT_CTI_INTEGRATION_REGS
>> 	  CTI trigger connections between this and other devices.These
>> 	  registers are not used in normal operation and can leave devices in
>> 	  an inconsistent state.
>> +
>> +config CORESIGHT_TRBE
>> +	tristate "Trace Buffer Extension (TRBE) driver"
>> +	depends on ARM64 && CORESIGHT_SOURCE_ETM4X
>> +	help
>> +	  This driver provides support for percpu Trace Buffer Extension (TRBE).
>> +	  TRBE always needs to be used along with it's corresponding percpu ETE
>> +	  component. ETE generates trace data which is then captured with TRBE.
>> +	  Unlike traditional sink devices, TRBE is a CPU feature accessible via
>> +	  system registers. But it's explicit dependency with trace unit (ETE)
>> +	  requires it to be plugged in as a coresight sink device.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called coresight-trbe.
>> endif
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> index f20e357758d1..d60816509755 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -21,5 +21,6 @@ obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>> obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>> obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>> obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>> +obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>> coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>> 		   coresight-cti-sysfs.o
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> new file mode 100644
>> index 000000000000..41a012b525bb
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -0,0 +1,1149 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * This driver enables Trace Buffer Extension (TRBE) as a per-cpu coresight
>> + * sink device could then pair with an appropriate per-cpu coresight source
>> + * device (ETE) thus generating required trace data. Trace can be enabled
>> + * via the perf framework.
> 
> If I remember correctly the last version stated the driver was tailored on
> Will's SPE driver.
> 

Yes, it was and is, still in there the description. But it is good to mention that here.

>> 
>> +static int arm_trbe_device_probe(struct platform_device *pdev)
>> +{
>> +	struct coresight_platform_data *pdata;
>> +	struct trbe_drvdata *drvdata;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> +	if (!drvdata)
>> +		return -ENOMEM;
>> +
>> +	pdata = coresight_get_platform_data(dev);
>> +	if (IS_ERR(pdata))
>> +		return PTR_ERR(pdata);
> 
> Given there is no in and out ports, do we need a platform data for this driver?
> 
> More comments on this patch tomorrow.

I had the same comment in one of the earlier versions.
 But it looks like the coresight_register() requires this argument, to scan the connections for a component. And we don’t want to break that assumption everywhere in the generic driver.

Cheers
Suzuki

