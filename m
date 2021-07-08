Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE23BF78D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhGHJaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:30:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10431 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhGHJaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:30:16 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GL9pq6Qz6zZrgt;
        Thu,  8 Jul 2021 17:24:19 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 8 Jul 2021 17:27:32 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 8 Jul
 2021 17:27:32 +0800
Subject: Re: [RFC PATCH 3/4] ultrasoc: Add ultrasoc AXI Communicator driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linuxarm <linuxarm@huawei.com>
CC:     <alexander.shishkin@linux.intel.com>, <suzuki.poulose@arm.com>,
        <jonathan.zhouwen@huawei.com>, <f.fangjian@huawei.com>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>
References: <1623749684-65432-1-git-send-email-liuqi115@huawei.com>
 <1623749684-65432-4-git-send-email-liuqi115@huawei.com>
 <20210629212224.GB1238591@p14s>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <bc070eac-2a64-444c-c7ab-967b547da323@huawei.com>
Date:   Thu, 8 Jul 2021 17:27:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210629212224.GB1238591@p14s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mathieu,

On 2021/6/30 5:22, Mathieu Poirier wrote:
> On Tue, Jun 15, 2021 at 05:34:43PM +0800, Qi Liu wrote:
>> This patch adds driver for ultrasoc AXI Communicator. It includes
>> a platform driver to probe AXI Communicator device, a set of
>> operations to access the service data, and a service work entry
>> which will be called by the standard communicator service.
>>
>> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---

[...]

>> +
>> +static const struct acpi_device_id ultrasoc_axi_com_acpi_match[] = {
>> +	{"HISI03B1", },
>> +	{},
>> +};
> 
> No need for MODULE_DEVICE_TABLE()?
> 
> I am very confused as to what this IP does...  And I'm even more confused as to
> why ultrasoc.c is needed at all.  As I pointed out in a previous comment there
> is a lot of work to do on this patchset but there is no point in writing more
> while questions about the current design choices are pending.
> thanks for reviewing this patch.

This module is used on Hip08 platform, to store trace data from ETM, you 
can find the data path diagram in kernel document patch.

And this module is developed by Ultrasoc technology, which is acquired 
by Siemens, we still use "Ultrasoc" to name document and structures.

At the beginning we use the ultrasoc.c as a framework to adapt multiple 
hardware devices and support more capabilities. But after discussing 
with suppliers, we are only allowed to upstream the axi-com and smb driver.

So the software architecture seems unreasonable now, I'll refactor it in 
next version, thanks.

Qi
> I am done reviewing this set.
> 
> Thanks,
> Mathieu
> 
>> +
>> +static struct platform_driver axi_com_driver = {
>> +	.driver = {
>> +		.name = "ultrasoc,axi-com",
>> +		.acpi_match_table = ultrasoc_axi_com_acpi_match,
>> +	},
>> +	.probe = axi_com_probe,
>> +	.remove = axi_com_remove,
>> +};
>> +module_platform_driver(axi_com_driver);
>> +
>> +MODULE_DESCRIPTION("Ultrasoc AXI COM driver");
>> +MODULE_LICENSE("Dual MIT/GPL");
>> +MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
>> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
>> diff --git a/drivers/hwtracing/ultrasoc/ultrasoc-axi-com.h b/drivers/hwtracing/ultrasoc/ultrasoc-axi-com.h
>> new file mode 100644
>> index 0000000..64bcf83
>> --- /dev/null
>> +++ b/drivers/hwtracing/ultrasoc/ultrasoc-axi-com.h
>> @@ -0,0 +1,66 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Copyright (C) 2021 Hisilicon Limited Permission is hereby granted, free of
>> + * charge, to any person obtaining a copy of this software and associated
>> + * documentation files (the "Software"), to deal in the Software without
>> + * restriction, including without limitation the rights to use, copy, modify,
>> + * merge, publish, distribute, sublicense, and/or sell copies of the Software,
>> + * and to permit persons to whom the Software is furnished to do so, subject
>> + * to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
>> + * IN THE SOFTWARE.
>> + *
>> + * Code herein communicates with and accesses proprietary hardware which is
>> + * licensed intellectual property (IP) belonging to Siemens Digital Industries
>> + * Software Ltd.
>> + *
>> + * Siemens Digital Industries Software Ltd. asserts and reserves all rights to
>> + * their intellectual property. This paragraph may not be removed or modified
>> + * in any way without permission from Siemens Digital Industries Software Ltd.
>> + */
>> +#ifndef ULTRASOC_AXI_COM_H
>> +#define ULTRASOC_AXI_COM_H
>> +
>> +#include "ultrasoc.h"
>> +
>> +#define AXIC_US_CTL 0X0 /* Upstream general control */
>> +#define AXIC_US_DATA 0XC /* Upstream message data */
>> +#define AXIC_US_BUF_STS 0X10 /* Upstream buffer status */
>> +
>> +#define AXIC_DS_CTL 0X80 /* Downstream general contral */
>> +#define AXIC_DS_DATA 0X8C /* Downstream message data */
>> +#define AXIC_DS_BUF_STS 0X90 /* Downstream buffer status */
>> +#define AXIC_DS_RD_STS 0X94 /* Downstream read status */
>> +
>> +#define AXIC_MSG_LEN_PER_SEND		4
>> +#define AXIC_MSG_LEN_PER_REC		4
>> +#define AXIC_US_CTL_EN 0x1
>> +#define AXIC_DS_CTL_EN 0x1
>> +
>> +struct axi_com_drv_data {
>> +	void __iomem *base;
>> +
>> +	struct device *dev;
>> +	struct ultrasoc_com *com;
>> +
>> +	u32 ds_msg_counter;
>> +
>> +	u32 us_msg_cur;
>> +	spinlock_t us_msg_list_lock;
>> +	struct list_head us_msg_head;
>> +
>> +	u32 ds_msg_cur;
>> +	spinlock_t ds_msg_list_lock;
>> +	struct list_head ds_msg_head;
>> +};
>> +
>> +#endif
>> -- 
>> 2.7.4
>>
> .
> 

