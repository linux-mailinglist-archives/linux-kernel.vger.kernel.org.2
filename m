Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235B745B50A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbhKXHPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:15:54 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14977 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKXHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:15:53 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HzXFt2tLMzZcyJ;
        Wed, 24 Nov 2021 15:10:10 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 15:12:42 +0800
Received: from [10.67.102.185] (10.67.102.185) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 15:12:40 +0800
Subject: Re: [PATCH v3] drivers/coresight: Add Ultrasoc System Memory Buffer
 driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
References: <20211118110016.40398-1-liuqi115@huawei.com>
 <20211123183026.GA2794106@p14s>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <23892559-a300-d886-d945-1a01c4d9ac09@huawei.com>
Date:   Wed, 24 Nov 2021 15:12:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20211123183026.GA2794106@p14s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/24 2:30, Mathieu Poirier wrote:
> Good morning,
> 
> On Thu, Nov 18, 2021 at 07:00:16PM +0800, Qi Liu wrote:
>> This patch adds driver for Ultrasoc SMB(System Memory Buffer)
>> device. SMB provides a way to buffer messages from ETM, and
>> store these CPU instructions in system memory.
>>
>> SMB is developed by Ultrasoc technology, which is acquired by
>> Siemens, and we still use "Ultrasoc" to name driver.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Tested-by: JunHao He <hejunhao2@hisilicon.com>
>>
>> ---
>>
>> Change since v2:
>> - Move ultrasoc driver to drivers/hwtracing/coresight.
>> - Link:https://lists.linaro.org/pipermail/coresight/2021-November/007310.html
>>
>> Change since v1:
>> - Drop the document of Ultrasoc according to Mathieu's comment.
>> - Add comments to explain some private hardware settings.
>> - Address the comments from Mathieu.
>> - Link: https://lists.linaro.org/pipermail/coresight/2021-August/006842.html
>>
>> Change since RFC:
>> - Move ultrasoc driver to drivers/hwtracing/coresight/ultrasoc.
>> - Remove ultrasoc-axi-com.c, as AXI-COM doesn't need to be configured in
>>    basic tracing function.
>> - Remove ultrasoc.c as SMB does not need to register with the ultrasoc core.
>> - Address the comments from Mathieu and Suzuki.
>> - Link: https://lists.linaro.org/pipermail/coresight/2021-June/006535.html
>>
>>   drivers/hwtracing/coresight/Kconfig        |  12 +
>>   drivers/hwtracing/coresight/Makefile       |   2 +
>>   drivers/hwtracing/coresight/ultrasoc-smb.c | 607 +++++++++++++++++++++
>>   drivers/hwtracing/coresight/ultrasoc-smb.h | 116 ++++
>>   4 files changed, 737 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h
> 
> This set is giving me obvious checkpatch warnings, something that is quite
> disappointing since 1) you had plenty of time to fix those and 2) someone with
> your kind of upstream experience should know better.
> 
> Despite the above I have decided to review this patch but next time I will simply
> ignore your submission.
> 

Hi Mathieu,

Sorry for my fault, I'll pay attention to these things latter, thanks.

>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index 514a9b8086e3..d24a5d95153a 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -201,4 +201,16 @@ config CORESIGHT_TRBE
>>   
>>   	  To compile this driver as a module, choose M here: the module will be
>>   	  called coresight-trbe.
>> +
>> +config ULTRASOC_SMB
>> +	tristate "Ultrasoc system memory buffer drivers"
>> +	depends on ARM64 && CORESIGHT
> 
> You don't need to depend on CORESIGHT since this is already enclosed in "if
> CORESIGHT".  But like other sink, this should depend on
> CORESIGHT_LINKS_AND_SINKS.
> 

Got it, will fix this.
>> +	help
>> +	  This driver provides support for the Ultrasoc system memory buffer (SMB).
>> +	  SMB is responsible for receiving the trace data from Coresight ETM devices
>> +	  and storing them to a system buffer.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called ultrasoc-smb.
>> +
>>   endif
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> index b6c4a48140ec..2899e5a5d5cd 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -27,3 +27,5 @@ obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>>   		   coresight-cti-sysfs.o
>> +
> 
> Extra newline.

got it, thanks.
> 
>> +obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> new file mode 100644
>> index 000000000000..b477fc51fbbb
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> @@ -0,0 +1,607 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright (C) 2021 HiSilicon Limited.
>> + *
>> + * Code herein communicates with and accesses proprietary hardware which is
>> + * licensed intellectual property (IP) belonging to Siemens Digital Industries
>> + * Software Ltd.
>> + *
>> + * Siemens Digital Industries Software Ltd. asserts and reserves all rights to
>> + * their intellectual property. This paragraph may not be removed or modified
>> + * in any way without permission from Siemens Digital Industries Software Ltd.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/circ_buf.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "ultrasoc-smb.h"
>> +
>> +DEFINE_CORESIGHT_DEVLIST(sink_devs, "sink_smb");
> 
> DEFINE_CORESIGHT_DEVLIST(sink_devs, "smb");
> got it, will change this.

> More comments at the very bottom of the file.
> 
>> +

[...]
>> +static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
>> +	{"HISI03A1", 0},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
> 
> Please enclose this in #ifdef CONFIG_ACPI as it is done for the funnel and
> replicator drivers.
> 

got it, thanks.
>> +
>> +static struct platform_driver smb_driver = {
>> +	.driver = {
>> +		.name = "ultrasoc,smb",
> 
> "ultrasoc-smb"
> 
got it.
>> +		.acpi_match_table = ACPI_PTR(ultrasoc_smb_acpi_match),
>> +		.suppress_bind_attrs = true,
>> +	},
>> +	.probe = smb_probe,
>> +	.remove = smb_remove,
>> +};
>> +module_platform_driver(smb_driver);
>> +
>> +MODULE_DESCRIPTION("Ultrasoc smb driver");
>> +MODULE_LICENSE("Dual MIT/GPL");
> 
> The dual licence is not reflected properly in the SPDX tag at the top of the
> file.  Please read Documentation/process/license-rules.rst.
> 

I'll fix this next version, thanks.

>> +MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
>> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");

[...]
>> +/**
>> + * struct smb_drv_data - specifics associated to an SMB component
>> + * @base:	Memory mapped base address for SMB component.
>> + * @csdev:	Component vitals needed by the framework.
>> + * @sdb:	Data buffer for SMB.
>> + * @miscdev:	Specifics to handle "/dev/xyz.tmc" entry.
> 
> What tmc entry would this be?

here is a typo, misdev should be an entry to handle /dev/smbx, will fix 
this, thanks.

> 
>> + * @spinlock:	Only one at a time pls.
>> + * @reading:	Synchronise user space access to SMB buffer.
>> + * @pid:	Process ID of the process being monitored by the session
>> + *		that is using this component.
>> + * @mode:	how this SMB is being used, perf mode or sysfs mode.
>> + */
>> +struct smb_drv_data {
>> +	void __iomem *base;
>> +	struct coresight_device	*csdev;
>> +	struct smb_data_buffer sdb;
>> +	struct miscdevice miscdev;
>> +	spinlock_t spinlock;
>> +	local_t reading;
>> +	pid_t pid;
>> +	u32 mode;
>> +};
>> +
>> +#define smb_simple_func(type, name, offset)				\
>> +static ssize_t name##_show(struct device *_dev,				\
>> +			   struct device_attribute *attr, char *buf)	\
>> +{									\
>> +	type *drvdata = dev_get_drvdata(_dev->parent);			\
>> +	u32 val = readl(drvdata->base + offset);				\
>> +									\
>> +	return sysfs_emit(buf, "0x%x\n", val);			\
>> +}									\
>> +static DEVICE_ATTR_RO(name)
> 
> I'm pretty sure you can re-use coresight_tmc_reg() instead of writing
> another macro.  I suggest to look at coresight_tmc_reg() in coresight-tmc-core.c
> for an example.
> 

got it, I've check coresight_tmc_reg and will use this next version.

> I am out of time for today - I will continue tomorrow.

Thanks for reviewing this patch.

Qi
> 
> Thanks,
> Mathieu
> 
>> +
>> +#endif
>> -- 
>> 2.33.0
>>
> .
> 
