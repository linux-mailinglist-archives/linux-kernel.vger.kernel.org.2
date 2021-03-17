Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382E933EE90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCQKpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:45:07 -0400
Received: from foss.arm.com ([217.140.110.172]:56744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhCQKo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:44:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA782D6E;
        Wed, 17 Mar 2021 03:44:58 -0700 (PDT)
Received: from [10.57.17.188] (unknown [10.57.17.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6128F3F70D;
        Wed, 17 Mar 2021 03:44:57 -0700 (PDT)
Subject: Re: [PATCH v4 09/19] coresight: etm4x: Move ETM to prohibited region
 for disable
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-10-suzuki.poulose@arm.com>
 <20210316193008.GD1387186@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7e8569f8-9da2-096c-a35a-14248329026a@arm.com>
Date:   Wed, 17 Mar 2021 10:44:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316193008.GD1387186@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu

On 3/16/21 7:30 PM, Mathieu Poirier wrote:
> On Thu, Feb 25, 2021 at 07:35:33PM +0000, Suzuki K Poulose wrote:
>> If the CPU implements Arm v8.4 Trace filter controls (FEAT_TRF),
>> move the ETM to trace prohibited region using TRFCR, while disabling.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> New patch
> 
> I would ask you to refrain from introducing new patches.  Otherwise the goal
> posts keep on moving with every revision and we'll never get through.  Fixes and
> enhancement can come in later patchsets.
> 

While I agree that this is a fix and a new patch, it also attests what
we do in the nvhe hypervisor to disable tracing while we enter the guest, by
using the Trace filter controls.

>> ---
>>   .../coresight/coresight-etm4x-core.c          | 21 +++++++++++++++++--
>>   drivers/hwtracing/coresight/coresight-etm4x.h |  2 ++
>>   2 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 15016f757828..00297906669c 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -31,6 +31,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/property.h>
>>   
>> +#include <asm/barrier.h>
>>   #include <asm/sections.h>
>>   #include <asm/sysreg.h>
>>   #include <asm/local.h>
>> @@ -654,6 +655,7 @@ static int etm4_enable(struct coresight_device *csdev,
>>   static void etm4_disable_hw(void *info)
>>   {
>>   	u32 control;
>> +	u64 trfcr;
>>   	struct etmv4_drvdata *drvdata = info;
>>   	struct etmv4_config *config = &drvdata->config;
>>   	struct coresight_device *csdev = drvdata->csdev;
>> @@ -676,6 +678,16 @@ static void etm4_disable_hw(void *info)
>>   	/* EN, bit[0] Trace unit enable bit */
>>   	control &= ~0x1;
>>   
>> +	/*
>> +	 * If the CPU supports v8.4 Trace filter Control,
>> +	 * set the ETM to trace prohibited region.
>> +	 */
>> +	if (drvdata->trfc) {
>> +		trfcr = read_sysreg_s(SYS_TRFCR_EL1);
>> +		write_sysreg_s(trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE),
>> +			       SYS_TRFCR_EL1);
>> +		isb();
>> +	}
>>   	/*
>>   	 * Make sure everything completes before disabling, as recommended
>>   	 * by section 7.3.77 ("TRCVICTLR, ViewInst Main Control Register,
>> @@ -683,12 +695,16 @@ static void etm4_disable_hw(void *info)
>>   	 */
>>   	dsb(sy);
>>   	isb();
>> +	/* Trace synchronization barrier, is a nop if not supported */
>> +	tsb_csync();
>>   	etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
>>   
>>   	/* wait for TRCSTATR.PMSTABLE to go to '1' */
>>   	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
>>   		dev_err(etm_dev,
>>   			"timeout while waiting for PM stable Trace Status\n");
>> +	if (drvdata->trfc)
>> +		write_sysreg_s(trfcr, SYS_TRFCR_EL1);
> 
> drvdata->trfc is invariably set to true in cpu_enable_tracing() and as such
> testing for it is not required.

That is not true. This is only set when the CPU supports trace filtering.
So, this is more of a capability field for the CPU where the ETM is bound.
Only v8.4+ CPUs implement trace filtering controls.

Cheers
Suzuki


> 
>>   
>>   	/* read the status of the single shot comparators */
>>   	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
>> @@ -873,7 +889,7 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
>>   	return false;
>>   }
>>   
>> -static void cpu_enable_tracing(void)
>> +static void cpu_enable_tracing(struct etmv4_drvdata *drvdata)
>>   {
>>   	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
>>   	u64 trfcr;
>> @@ -881,6 +897,7 @@ static void cpu_enable_tracing(void)
>>   	if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRACE_FILT_SHIFT))
>>   		return;
>>   
>> +	drvdata->trfc = true;
>>   	/*
>>   	 * If the CPU supports v8.4 SelfHosted Tracing, enable
>>   	 * tracing at the kernel EL and EL0, forcing to use the
>> @@ -1082,7 +1099,7 @@ static void etm4_init_arch_data(void *info)
>>   	/* NUMCNTR, bits[30:28] number of counters available for tracing */
>>   	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
>>   	etm4_cs_lock(drvdata, csa);
>> -	cpu_enable_tracing();
>> +	cpu_enable_tracing(drvdata);
> 
> At least for this patch, the above three hunks aren't needed.
> 
>>   }
>>   
>>   static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index 0af60571aa23..f6478ef642bf 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -862,6 +862,7 @@ struct etmv4_save_state {
>>    * @nooverflow:	Indicate if overflow prevention is supported.
>>    * @atbtrig:	If the implementation can support ATB triggers
>>    * @lpoverride:	If the implementation can support low-power state over.
>> + * @trfc:	If the implementation supports Arm v8.4 trace filter controls.
>>    * @config:	structure holding configuration parameters.
>>    * @save_state:	State to be preserved across power loss
>>    * @state_needs_restore: True when there is context to restore after PM exit
>> @@ -912,6 +913,7 @@ struct etmv4_drvdata {
>>   	bool				nooverflow;
>>   	bool				atbtrig;
>>   	bool				lpoverride;
>> +	bool				trfc;
> 
> Nor is this one.
> 
>>   	struct etmv4_config		config;
>>   	struct etmv4_save_state		*save_state;
>>   	bool				state_needs_restore;
>> -- 
>> 2.24.1
>>

