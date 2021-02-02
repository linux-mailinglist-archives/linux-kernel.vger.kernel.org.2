Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75D130CF63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhBBWvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:51:15 -0500
Received: from foss.arm.com ([217.140.110.172]:59428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233342AbhBBWvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:51:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECABCD6E;
        Tue,  2 Feb 2021 14:50:27 -0800 (PST)
Received: from [10.57.35.108] (unknown [10.57.35.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A2EF3F694;
        Tue,  2 Feb 2021 14:50:26 -0800 (PST)
Subject: Re: [PATCH V3 05/14] coresight: ete: Add support for ETE tracing
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-6-git-send-email-anshuman.khandual@arm.com>
 <20210202185639.GE1536093@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f4e8471a-872b-7733-eaa4-387530564e0e@arm.com>
Date:   Tue, 2 Feb 2021 22:50:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202185639.GE1536093@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 6:56 PM, Mathieu Poirier wrote:
> On Wed, Jan 27, 2021 at 02:25:29PM +0530, Anshuman Khandual wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> Add ETE as one of the supported device types we support
>> with ETM4x driver. The devices are named following the
>> existing convention as ete<N>.
>>
>> ETE mandates that the trace resource status register is programmed
>> before the tracing is turned on. For the moment simply write to
>> it indicating TraceActive.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---

...

>> @@ -1834,10 +1854,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>>   	if (drvdata->cpu < 0)
>>   		return drvdata->cpu;
>>   
>> -	desc.name = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
>> -	if (!desc.name)
>> -		return -ENOMEM;
>> -
>>   	init_arg.drvdata = drvdata;
>>   	init_arg.csa = &desc.access;
>>   	init_arg.pid = etm_pid;
>> @@ -1853,6 +1869,20 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>>   	if (!desc.access.io_mem ||
>>   	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
>>   		drvdata->skip_power_up = true;
> 
> Add a space here...
> 
>> +	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);
>> +	minor = ETM_ARCH_MINOR_VERSION(drvdata->arch);
> 
> And here too.  Othersiwe it makes a big blob in the middle of the function.
> 
>> +	if (etm4x_is_ete(drvdata)) {
>> +		type_name = "ete";
>> +		/* ETE v1 has major version == 5. Adjust this for logging.*/
>> +		major -= 4;
> 
> I don't have the documentation for the ETE but I would not adjust @major.  I
> would simply leave it to what the HW gives us since regardless of the name, the
> major revision of the IP block is 5.
> 

At the moment only register definitions are public and can be found here :

https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers/trcdevarch

The ETE is natural extension of the ETM architecture to support future
architecture changes and is designed in a way that the same software
can driver both ETM and ETE without much changes.

>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index ca24ac5..8b90de5 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -128,6 +128,8 @@
>>   #define TRCCIDR2			0xFF8
>>   #define TRCCIDR3			0xFFC
>>   
>> +#define TRCRSR_TA			BIT(12)
>> +
>>   /*
>>    * System instructions to access ETM registers.
>>    * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
>> @@ -390,6 +392,9 @@
>>   #define ETM_COMMON_SYSREG_LIST_CASES		\
>>   	ETM_COMMON_SYSREG_LIST(NOP, __unused)
>>   
>> +#define ETM4x_ONLY_SYSREG_LIST_CASES		\
>> +	ETM4x_ONLY_SYSREG_LIST(NOP, __unused)
>> +
>>   #define ETM4x_SYSREG_LIST_CASES			\
>>   	ETM_COMMON_SYSREG_LIST_CASES		\
>>   	ETM4x_ONLY_SYSREG_LIST(NOP, __unused)
>> @@ -406,7 +411,6 @@
>>   	ETE_ONLY_SYSREG_LIST(WRITE, (val))
>>   
>>   #define ETE_ONLY_SYSREG_LIST_CASES		\
>> -	ETM_COMMON_SYSREG_LIST_CASES		\
> 
> This goes in patch 04.
> 

Sure, will move it.

> With the above:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks for the review

Suzuki
