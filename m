Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C09B3129B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 05:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBHEUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 23:20:53 -0500
Received: from foss.arm.com ([217.140.110.172]:55882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhBHEUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 23:20:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0784331B;
        Sun,  7 Feb 2021 20:20:03 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC04E3F719;
        Sun,  7 Feb 2021 20:20:00 -0800 (PST)
Subject: Re: [PATCH V3 11/14] coresight: sink: Add TRBE driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
 <20210205175330.GB1636242@xps15>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <183141f9-e3a9-555b-a10e-5dcb479fbcf1@arm.com>
Date:   Mon, 8 Feb 2021 09:50:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205175330.GB1636242@xps15>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/21 11:23 PM, Mathieu Poirier wrote:
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
> 
> I got this message when applying the patch: 
> 
> Applying: coresight: sink: Add TRBE driver
> .git/rebase-apply/patch:76: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.

It could be the additional blank line at the end of documentation file
i.e Documentation/trace/coresight/coresight-trbe.rst, will drop it.
 
>  
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
>>
>> diff --git a/Documentation/trace/coresight/coresight-trbe.rst b/Documentation/trace/coresight/coresight-trbe.rst
>> new file mode 100644
>> index 0000000..1cbb819
>> --- /dev/null
>> +++ b/Documentation/trace/coresight/coresight-trbe.rst
>> @@ -0,0 +1,39 @@
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
>> +genarators (ETE), are plugged in as source device.
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
>> +        align dbm
>> +
>> +*Key file items are:-*
>> +   * ``align``: TRBE write pointer alignment
>> +   * ``dbm``: TRBE updates memory with access and dirty flags
>> +
> 
> Please add documentation for these, the same way it was done for all the other CS
> components [1].
> 
> [1]. https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing
> (sysfs-bus-coresight-device-xyz)

Sure, will add the following new sysfs doc file in this regard.
Marked the KernelVersion as 5.12, will change if required.

new file mode 100644
index 0000000..5cb090f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
@@ -0,0 +1,14 @@
+What:          /sys/bus/coresight/devices/trbe<cpu>/align
+Date:          Feb 2021
+KernelVersion: 5.12
+Contact:       Anshuman Khandual <anshuman.khandual@arm.com>
+Description:   (Read) Shows the TRBE write pointer alignment. This value
+               is fetched from the TRBIDR register.
+
+What:          /sys/bus/coresight/devices/trbe<cpu>/dbm
+Date:          Feb 2021
+KernelVersion:  5.12
+Contact:       Anshuman Khandual <anshuman.khandual@arm.com>
+Description:   (Read) Shows if TRBE updates in the memory are with access
+               and dirty flag updates as well. This value is fetched from
+               the TRBIDR register.

> 
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 85ae4db..9e2e9b7 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -97,6 +97,7 @@
>>  #define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
>>  #define SET_PSTATE_SSBS(x)		__emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
>>  #define SET_PSTATE_TCO(x)		__emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
>> +#define TSB_CSYNC			__emit_inst(0xd503225f)
>>  
>>  #define set_pstate_pan(x)		asm volatile(SET_PSTATE_PAN(x))
>>  #define set_pstate_uao(x)		asm volatile(SET_PSTATE_UAO(x))
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index f154ae7..aa657ab 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -164,6 +164,17 @@ config CORESIGHT_CTI
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called coresight-cti.
>>  
>> +config CORESIGHT_TRBE
>> +	bool "Trace Buffer Extension (TRBE) driver"
> 
> Shouldn't that be "tristate"?

Yes, will change.

> 
>> +	depends on ARM64
> 
> I would make it dependent on ETMv4 as well since it can only be used by that
> component.

Sure, will also add CORESIGHT_SOURCE_ETM4X as dependency.

> 
>> +	help
>> +	  This driver provides support for percpu Trace Buffer Extension (TRBE).
>> +	  TRBE always needs to be used along with it's corresponding percpu ETE
>> +	  component. ETE generates trace data which is then captured with TRBE.
>> +	  Unlike traditional sink devices, TRBE is a CPU feature accessible via
>> +	  system registers. But it's explicit dependency with trace unit (ETE)
>> +	  requires it to be plugged in as a coresight sink device.
> 
> Please add:
> 
>           "To compile this driver as a module, choose M here: the
>           module will be called coresight-trbe."

Added.

> 
> I'm out of time for today, I will continue on Monday.

Sure.
