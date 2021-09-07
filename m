Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2E402638
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhIGJdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:33:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9403 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhIGJdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:33:12 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H3g0b3mLxz8yCY;
        Tue,  7 Sep 2021 17:27:43 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 7 Sep 2021 17:32:03 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Tue, 7 Sep
 2021 17:32:02 +0800
Subject: Re: [PATCH 2/2] coresight: ultrasoc: Add System Memory Buffer driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linuxarm <linuxarm@huawei.com>
CC:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210719111737.47891-1-liuqi115@huawei.com>
 <20210719111737.47891-3-liuqi115@huawei.com> <20210906173034.GC1228692@p14s>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <2676719b-12b7-8458-910c-6fffd8d72410@huawei.com>
Date:   Tue, 7 Sep 2021 17:32:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210906173034.GC1228692@p14s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/7 1:30, Mathieu Poirier wrote:
> Good morning Liu,
> 
Hi Mathieu, thanks for your reviewing, and sorry for lacking comment in 
this patch, I'll add comments to reduce misunderstanding and confusion 
next time.

> On Mon, Jul 19, 2021 at 07:17:37PM +0800, Qi Liu wrote:
>> This patch adds driver for Ultrasoc SMB(System Memory Buffer)
>> device. SMB provides a way to buffer messages from ETM, and
>> store these CPU instructions in system memory.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   MAINTAINERS                                   |   7 +
>>   drivers/hwtracing/coresight/Kconfig           |   3 +
>>   drivers/hwtracing/coresight/Makefile          |   2 +
>>   drivers/hwtracing/coresight/ultrasoc/Kconfig  |  12 +
>>   drivers/hwtracing/coresight/ultrasoc/Makefile |   6 +
>>   .../coresight/ultrasoc/ultrasoc-smb.c         | 722 ++++++++++++++++++
>>   .../coresight/ultrasoc/ultrasoc-smb.h         | 142 ++++
>>   7 files changed, 894 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc/Kconfig
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc/Makefile
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.c
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a61f4f3b78a9..2b9a821ee4e8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1836,6 +1836,13 @@ F:	tools/perf/arch/arm/util/pmu.c
>>   F:	tools/perf/util/cs-etm-decoder/*
>>   F:	tools/perf/util/cs-etm.*
>>   
>> +SIEMENS EMBEDDED ANALYTICS DRIVER
>> +M:	Jonathan Zhou <Jonathan.zhouwen@huawei.com>
>> +M:	Qi Liu <liuqi115@huawei.com>
>> +S:	Supported
>> +F:	Documentation/trace/coresight/ultrasoc-trace.rst
>> +F:	drivers/hwtracing/coresight/ultrasoc/*
> 
> This IP block embeds itself in the CS architecture and as such I don't think we
> need a specific subsystem for it.  I am perfectly happy with "ultrasoc-smb.c"
> living in the same directory as the other CS drivers.
> 

Got it, I'll remove this next time.
>> +
>>   ARM/CORGI MACHINE SUPPORT
>>   M:	Richard Purdie <rpurdie@rpsys.net>
>>   S:	Maintained
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index 84530fd80998..8d5c413f57bf 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -187,4 +187,7 @@ config CORESIGHT_TRBE
>>   
>>   	  To compile this driver as a module, choose M here: the module will be
>>   	  called coresight-trbe.
>> +
>> +source "drivers/hwtracing/coresight/ultrasoc/Kconfig"
>> +
>>   endif
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> index d60816509755..f3b9c9705f4d 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -24,3 +24,5 @@ obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>>   		   coresight-cti-sysfs.o
>> +
>> +obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc/
>> diff --git a/drivers/hwtracing/coresight/ultrasoc/Kconfig b/drivers/hwtracing/coresight/ultrasoc/Kconfig
>> new file mode 100644
>> index 000000000000..5dc5ab0c6d2d
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc/Kconfig
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: MIT
>> +#
>> +# ultrasoc configuration
>> +#
>> +config ULTRASOC_SMB
>> +	tristate "Ultrasoc System memory buffer drivers"
>> +        depends on ARM64 && CORESIGHT
>> +	help
>> +	  This enables support for Ultrasoc System memory buffer drivers
> 
> s/"support for Ultrasoc"/support for the Ultrasoc"
> 
> s/"buffer drivers"/"buffer driver"

got it, thanks.
> 
>> +	  that are responsible for receiving the message data from Coresight
> 
> s/"that are responsible"/"that is responsible"
> 
> s/"receiving the message data"/"receiving the trace data"
got it, thanks.
> 
>> +	  ETM device and storing these CPU instructions to a system memory
>> +	  buffer respectively.
> 
> ETM devices and storing them to a system buffer.
got it, thanks.
> 
>> diff --git a/drivers/hwtracing/coresight/ultrasoc/Makefile b/drivers/hwtracing/coresight/ultrasoc/Makefile
>> new file mode 100644
>> index 000000000000..8469be50fc6a
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Makefile for ultrasoc drivers.
>> +#
>> +
>> +obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>> diff --git a/drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.c
>> new file mode 100644
>> index 000000000000..7d9e40c80b82
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.c
>> @@ -0,0 +1,722 @@
>> +// SPDX-License-Identifier: MIT
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
> 
> The SPDX license identifier was created to remove these long copyright notices.
> Please look at other examples in the kernel and do the same here.
> 

ok, I'll look at other MIT License and change this log, thanks.

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
>> +static inline int smb_hw_buffer_empty(struct smb_drv_data *drvdata)
>> +{
>> +	u32 buf_status = readl(drvdata->base + SMB_LB_INT_STS);
>> +
>> +	return buf_status & BIT(0) ? 0 : 1;
>> +}
>> +
>> +static inline int smb_buffer_pointer_pos(struct smb_drv_data *drvdata)
>> +{
> 
> Please make the return type a bool.
> 
ok, will change this, thanks.
>> +	u32 wr_offset, rd_offset;
>> +
>> +	wr_offset = readl(drvdata->base + SMB_LB_WR_ADDR);
>> +	rd_offset = readl(drvdata->base + SMB_LB_RD_ADDR);
>> +	return wr_offset == rd_offset;
>> +}
>> +
>> +static inline int smb_hw_buffer_full(struct smb_drv_data *drvdata)
>> +{
>> +	return smb_buffer_pointer_pos(drvdata) && !smb_hw_buffer_empty(drvdata);
>> +}
>> +
>> +static inline void smb_clear_buf_status(struct smb_drv_data *drvdata)
>> +{
>> +	struct smb_data_buffer *sdb = &drvdata->smb_db;
>> +
>> +	if (smb_buffer_pointer_pos(drvdata) && !sdb->to_copy)
>> +		writel(0xf, drvdata->base + SMB_LB_INT_STS);
> 
> Why is there anything to clear if the read and write pointers are the same and
> there is nothing to copy?  I have to ask because there is no comments describing
> why this is done.
> 

smb_clear_buf_status() is used to clear the status of SMB after data 
have been updated by sysfs interface or perf interface, which means all 
data in SMB buffer have been updated and SMB is an empty buffer now.

But SMB status register has a hardware limitation: SMB status could only 
be cleared when read and write pointers are the same, so we check the 
pointer then clear the status.

Sorry for lacking comments here, I'll add comments to explain the 
limitation next time.

> Overall this driver is hard to review because it lacks comments, which often
> forces me to guess what is going on.  It also takes me twice as much time
> because, again, I have to guess.
> 
>> +}
>> +
>> +static void smb_update_hw_write_size(struct smb_drv_data *drvdata)
>> +{
>> +	struct smb_data_buffer *sdb = &drvdata->smb_db;
>> +	u32 write_offset, write_base;
>> +
>> +	sdb->lost = false;
>> +	writel(0x1, drvdata->base + SMB_LB_PURGE);
>> +	if (smb_hw_buffer_empty(drvdata)) {
>> +		sdb->to_copy = 0;
>> +		return;
>> +	}
>> +
>> +	if (smb_hw_buffer_full(drvdata)) {
>> +		sdb->to_copy = sdb->buf_size;
>> +		return;
>> +	}
>> +
>> +	write_base = sdb->buf_base_phys & SMB_BUF_WRITE_BASE;
>> +	write_offset = readl(drvdata->base + SMB_LB_WR_ADDR) - write_base;
>> +	sdb->to_copy = CIRC_CNT(write_offset, sdb->rd_offset, sdb->buf_size);
>> +}
>> +
>> +static int smb_open(struct inode *inode, struct file *file)
>> +{
>> +	struct smb_drv_data *drvdata = container_of(file->private_data,
>> +			struct smb_drv_data, miscdev);
>> +
>> +	if (local_cmpxchg(&drvdata->reading, 0, 1))
>> +		return -EBUSY;
> 
> The reading flag is set properly but from looking at the code there is nothing
> that prevents a perf session from using the SMB device while reading is
> happening from sysfs.
> 

We add a check in smb_enable_sysfs(). In smb_enable_sysfs(), we check 
the driver->mode:

	/* Don't messup with perf sessions. */
	if (drvdata->mode == CS_MODE_PERF) {
		ret = -EBUSY;
		goto out;
	}

>> +
>> +	smb_update_hw_write_size(drvdata);
>> +	return 0;

[...]

>> +
>> +static int smb_init_data_buffer(struct platform_device *pdev,
>> +				struct smb_data_buffer *sdb)
>> +{
>> +	struct resource *res;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	if (IS_ERR(res)) {
>> +		dev_err(&pdev->dev, "SMB device without data buffer.\n");
>> +		return -EINVAL;
> 
>                  return ret;
> 
got it.
>> +	}
>> +
>> +	sdb->buf_base_phys = res->start;
>> +	sdb->buf_size = resource_size(res);
>> +	if (sdb->buf_size == 0)
>> +		return -EINVAL;
>> +
>> +	sdb->buf_base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (sdb->buf_base == NULL)
>> +		return -ENOMEM;
> 
> Look at the kernel documentation on how to properly use devm_ioremap_resource().

got it
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int smb_set_buffer(struct coresight_device *csdev,
>> +		struct perf_output_handle *handle);
> 
> Remove this forward declaration and move smb_set_buffer() before
> smb_enable_perf().
> 
ok ,will change this, thanks.
>> +
>> +static void smb_enable_hw(struct smb_drv_data *drvdata)
>> +{
>> +	writel(0x1, drvdata->base + SMB_GLOBAL_EN);
>> +}
>> +

[...]

>> +static void *smb_alloc_buffer(struct coresight_device *csdev,
>> +		struct perf_event *event, void **pages,
>> +		int nr_pages, bool overwrite)
>   
> Indentation problems
ok ,will change this, thanks.
> 
>> +{
>> +	struct cs_buffers *buf;
>> +	int node;
>> +
>> +	node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
>> +	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
>> +	if (!buf)
>> +		return NULL;
>> +
>> +	buf->snapshot = overwrite;
>> +	buf->nr_pages = nr_pages;
>> +	buf->data_pages = pages;
>> +
>> +	return buf;
>> +}
>> +
>> +static void smb_free_buffer(void *config)
>> +{
>> +	struct cs_buffers *buf = config;
>> +
>> +	kfree(buf);
>> +}
>> +
>> +static int smb_set_buffer(struct coresight_device *csdev,
>> +		struct perf_output_handle *handle)
> 
> Indentation
ok ,will change this, thanks.
> 
>> +{
>> +	struct cs_buffers *buf = etm_perf_sink_config(handle);
>> +	u32 head;
>> +
>> +	if (!buf)
>> +		return -EINVAL;
>> +
>> +	/* wrap head around to the amount of space we have */
>> +	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
>> +
>> +	/* find the page to write to and offset within that page */
>> +	buf->cur = head / PAGE_SIZE;
>> +	buf->offset = head % PAGE_SIZE;
>> +
>> +	local_set(&buf->data_size, 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
>> +				 struct cs_buffers *buf, unsigned long to_copy)
>> +{
>> +	struct smb_data_buffer *sdb = &drvdata->smb_db;
>> +	char **dst_pages = (char **)buf->data_pages;
>> +	u32 buf_offset = buf->offset;
>> +	u32 cur = buf->cur;
>> +	u32 bytes;
>> +
>> +	while (to_copy > 0) {
>> +		/*
>> +		 * if the read needs to cross the boundary of the data buffer,
>> +		 * copy last datas of the buffer to user
>> +		 */
>> +		if (sdb->rd_offset + PAGE_SIZE - buf_offset > sdb->buf_size)
>> +			bytes = sdb->buf_size - sdb->rd_offset;
>> +		else
>> +			bytes = min(to_copy, PAGE_SIZE - buf_offset);
>> +
>> +		memcpy_fromio(dst_pages[cur] + buf_offset,
>> +		       sdb->buf_base + sdb->rd_offset, bytes);
>> +
>> +		buf_offset += bytes;
>> +		if (buf_offset >= PAGE_SIZE) {
>> +			buf_offset = 0;
>> +			cur++;
>> +			cur %= buf->nr_pages;
>> +		}
>> +		to_copy -= bytes;
>> +		/* ensure memcpy finished before update the read pointer */
>> +		sdb->rd_offset += bytes;
>> +		sdb->rd_offset %= sdb->buf_size;
>> +	}
>> +
>> +	writel(sdb->buf_base_phys + sdb->rd_offset,
>> +	       drvdata->base + SMB_LB_RD_ADDR);
>> +	sdb->to_copy = to_copy;
>> +}
>> +
>> +static unsigned long smb_update_buffer(struct coresight_device *csdev,
>> +		struct perf_output_handle *handle, void *sink_config)
> 
> Indentation
will change this, thanks.
> 
>> +{
>> +	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +	struct smb_data_buffer *sdb = &drvdata->smb_db;
>> +	struct cs_buffers *buf = sink_config;
>> +	u64 to_copy;
>> +
>> +	if (!buf)
>> +		return 0;
>> +
>> +	smb_update_hw_write_size(drvdata);
>> +	to_copy = sdb->to_copy;
>> +	if (to_copy > handle->size) {
>> +		sdb->rd_offset += (to_copy - handle->size);
>> +		sdb->rd_offset %= sdb->buf_size;
>> +		to_copy = handle->size;
>> +		sdb->lost = true;
>> +	}
>> +
>> +	smb_sync_perf_buffer(drvdata, buf, to_copy);
>> +	smb_clear_buf_status(drvdata);
>> +	if (!buf->snapshot && sdb->lost)
>> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +
>> +	return to_copy;
>> +}
>> +
>> +static const struct coresight_ops_sink smb_cs_ops = {
>> +	.enable		= smb_enable,
>> +	.disable	= smb_disable,
>> +	.alloc_buffer	= smb_alloc_buffer,
>> +	.free_buffer	= smb_free_buffer,
>> +	.update_buffer	= smb_update_buffer,
>> +};
>> +
>> +static const struct coresight_ops cs_ops = {
>> +	.sink_ops	= &smb_cs_ops,
>> +};
>> +
>> +static int smb_init_res(struct platform_device *pdev,
>> +			struct smb_drv_data *drvdata)
>> +{
>> +	struct smb_data_buffer *sdb;
>> +	int ret;
>> +
>> +	sdb = &drvdata->smb_db;
>> +	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(drvdata->base)) {
>> +		dev_err(&pdev->dev, "Failed to ioremap resource.\n");
>> +		return PTR_ERR(drvdata->base);
>> +	}
>> +
>> +	ret = smb_init_data_buffer(pdev, sdb);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to init buffer, ret = %d.\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	drvdata->com_mux = devm_platform_ioremap_resource(pdev, 2);
>> +	if (IS_ERR(drvdata->com_mux)) {
>> +		dev_err(&pdev->dev, "Failed to ioremap com_mux.\n");
>> +		return PTR_ERR(drvdata->com_mux);
>> +	}
> 
> What is the com_mux?  I'm assuming it stands for "communication multiplexor" but
> I have no clue what is does because there isn't any comments for it.
> 

com_mux means "communication multiplexor", By default, the data from ETM 
is transmitted through the JTAG interface, com_mux is used to make the 
data flow pass through Message Engine and SMB interface.

                            #############
                            # Coresight #
                              #  ETM  #
                               #######
                                 ###
                                  #
                                  |
                                  *
                     *******************************
                  *** AMBA Advanced Trace Bus (ATB) ***
                     ***************^***************
                           ===============    |
                            === FUNNEL ==<--- |
                               =======
                                  |
                                  *
     ************************************** *******************
  ************************ Message BUS ***************************
     ******************^************************^****************
              |                               |
      @@@@@@@@@@@@@@@@@@                      |   @@@@@@@@@@@@
      @ Message Engine @                      |   @ JTAG COM @
      @@@@@@@@@@@@@@@@@@                      |    @@@@@@@@@@
              |                               |---> @@@@@@@@
              |                                      @@@@@@
           @@@@@@@                                      |
           @ SMB @                                     JTAG
            @@@@@
             @@@
              @
              |
              |
              *
>> +
>> +	return ret;
>> +}
>> +
>> +DEFINE_CORESIGHT_DEVLIST(sink_devs, "sink_smb");
> 
> Move this to the top of the file please.

got it, thanks.
> 
>> +static int smb_register_sink(struct platform_device *pdev,
>> +			     struct smb_drv_data *drvdata)
>> +{
>> +	struct coresight_platform_data *pdata = NULL;
>> +	struct coresight_desc desc = { 0 };
>> +	int ret;
>> +
>> +	pdata = coresight_get_platform_data(&pdev->dev);
>> +	if (IS_ERR(pdata))
>> +		return PTR_ERR(pdata);
>> +
>> +	drvdata->dev->platform_data = pdata;
> 
> I don't see why this is needed.  csdev->dev.parent will have that information.

ok, will drop this next version, thanks.
> 
>> +	desc.type = CORESIGHT_DEV_TYPE_SINK;
>> +	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>> +	desc.ops = &cs_ops;
>> +	desc.pdata = pdata;
>> +	desc.dev = &pdev->dev;
>> +	desc.groups = smb_sink_groups;
>> +	desc.name = coresight_alloc_device_name(&sink_devs, &pdev->dev);
>> +	if (!desc.name) {
>> +		dev_err(&pdev->dev, "Failed to alloc coresight device name.");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	drvdata->csdev = coresight_register(&desc);
>> +	if (IS_ERR(drvdata->csdev))
>> +		return PTR_ERR(drvdata->csdev);
>> +
>> +	drvdata->miscdev.name = desc.name;
>> +	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
>> +	drvdata->miscdev.fops = &smb_fops;
>> +	ret = misc_register(&drvdata->miscdev);
>> +	if (ret) {
>> +		coresight_unregister(drvdata->csdev);
>> +		dev_err(&pdev->dev, "Failed to register misc, ret=%d\n", ret);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void smb_unregister_sink(struct smb_drv_data *drvdata)
>> +{
>> +	misc_deregister(&drvdata->miscdev);
>> +	coresight_unregister(drvdata->csdev);
>> +}
>> +
>> +/*
>> + * Send ultrasoc messge to control hardwares on the tracing path,
>> + * using DSM calls to avoid exposing ultrasoc message format.
>> + */
>> +static int smb_config_inport(struct smb_drv_data *drvdata, bool enable)
>> +{
>> +	struct device *dev = drvdata->dev;
>> +	u32 flag = enable ? 1 : 0;
>> +	union acpi_object *obj;
>> +	guid_t guid;
>> +
>> +	if (guid_parse("82ae1283-7f6a-4cbe-aa06-53e8fb24db18", &guid)) {
>> +		dev_err(dev, "Get GUID failed.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &guid, 0, flag, NULL);
>> +	if (!obj)
>> +		dev_err(dev, "ACPI handle failed!\n");
>> +
>> +	ACPI_FREE(obj);
>> +
>> +	return 0;
>> +}
>> +
>> +static int smb_probe(struct platform_device *pdev)
>> +{
>> +	struct smb_drv_data *drvdata;
>> +	int ret;
>> +
>> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
>> +	if (!drvdata)
>> +		return -ENOMEM;
>> +
>> +	ret = smb_init_res(pdev, drvdata);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Switch commucator mux to ultrasoc communicator, so SMB
> 
> s/commucator/communicator
> 
got it, thanks.
>> +	 * could receive hardware tracing data.
>> +	 */
>> +	writel(US_SELECT_ONCHIP, drvdata->com_mux);
> 
> Same comment as above - I have no clue why this is needed because there is no
> documentation.
> 

By default, the data from ETM is transmitted through the JTAG interface, 
set US_SELECT_ONCHIP to com_mux could make the data flow pass through 
Message Engine and SMB interface.
>> +
>> +	smb_set_default_hw(drvdata);
>> +	spin_lock_init(&drvdata->spinlock);
>> +	drvdata->dev = &pdev->dev;
> 
> As fas as I can tell drvdata::dev is not needed.
> 
yes, I checked the code and find drvdata::dev is not nessasary.
Will drop it, thanks.

>> +	drvdata->pid = -1;
>> +
>> +	ret = smb_register_sink(pdev, drvdata);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to register smb sink.\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = smb_config_inport(drvdata, true);
>> +	if (ret) {
>> +		smb_unregister_sink(drvdata);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, drvdata);
>> +	return 0;
>> +}
>> +
>> +static int smb_remove(struct platform_device *pdev)
>> +{
>> +	struct smb_drv_data *drvdata = platform_get_drvdata(pdev);
>> +	int ret;
>> +
>> +	ret = smb_config_inport(drvdata, false);
>> +	if (ret)
>> +		return ret;
>> +
>> +	smb_unregister_sink(drvdata);
>> +	return 0;
>> +}
>> +
>> +static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
>> +	{"HISI03A1", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
>> +
>> +static struct platform_driver smb_driver = {
>> +	.driver = {
>> +		.name = "ultrasoc,smb",
>> +		.acpi_match_table = ultrasoc_smb_acpi_match,
> 
> Please use ACPI_PTR()
ok, thanks
> 
>> +		.dev_groups = ultrasoc_smb_global_groups,
> 
> Why is this here at all?  From the code in smb_probe() it seems like changing
> the setting done by the driver will prevent the HW from working properly.
> 

We add a sysfs interface for com_mux as users somtimes might want to 
dump some CPU data using JTAG interface. But you are right, set com_mux 
will make HW cannot work, I think I could reset the com_mux to JTAG in 
smb_remove() rather than add a sysfs unterface, thanks.

>> +	},
>> +	.probe = smb_probe,
>> +	.remove = smb_remove,
>> +};
>> +module_platform_driver(smb_driver);
>> +
>> +MODULE_DESCRIPTION("Ultrasoc smb driver");
>> +MODULE_LICENSE("Dual MIT/GPL");
>> +MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
>> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
>> diff --git a/drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.h b/drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.h
>> new file mode 100644
>> index 000000000000..fed086cc66db
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.h
>> @@ -0,0 +1,142 @@
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
> 
> Same comment as above
> 
got it
>> +
>> +#ifndef _ULTRASOC_SMB_H
>> +#define _ULTRASOC_SMB_H
>> +
>> +#include <linux/coresight.h>
>> +#include <linux/list.h>
>> +#include <linux/miscdevice.h>
>> +
>> +#include "../coresight-etm-perf.h"
>> +#include "../coresight-priv.h"
>> +
>> +#define SMB_GLOBAL_CFG		0X0
>> +#define SMB_GLOBAL_EN		0X4
>> +#define SMB_GLOBAL_INT		0X8
>> +#define SMB_LB_CFG_LO		0X40
>> +#define SMB_LB_CFG_HI		0X44
>> +#define SMB_LB_INT_CTRL		0X48
>> +#define SMB_LB_INT_STS		0X4C
>> +#define SMB_LB_BASE_LO		0X50
>> +#define SMB_LB_BASE_HI		0X54
>> +#define SMB_LB_LIMIT		0X58
>> +#define SMB_LB_RD_ADDR		0X5C
>> +#define SMB_LB_WR_ADDR		0X60
>> +#define SMB_LB_PURGE		0X64
>> +
>> +#define SMB_MSG_LC(lc)		((lc & 0x3) << 2)
>> +#define SMB_BST_LEN(len)	(((len - 1) & 0xff) << 4)
>> +/* idle message injection timer period */
>> +#define SMB_IDLE_PRD(period)	(((period - 216) & 0xf) << 12)
>> +#define SMB_MEM_WR(credit, rate) (((credit & 0x3) << 16) | ((rate & 0xf) << 18))
>> +#define SMB_MEM_RD(credit, rate) (((credit & 0x3) << 22) | ((rate & 0xf) << 24))
>> +#define HISI_SMB_GLOBAL_CFG                                                    \
>> +	(SMB_MSG_LC(0) | SMB_IDLE_PRD(231) | SMB_MEM_WR(0x3, 0x0) |            \
>> +	 SMB_MEM_RD(0x3, 0x6) | SMB_BST_LEN(16))
> 
> This is really hard to read...
> 
> #define HISI_SMB_GLOBAL_CFG     (SMB_MSG_LC(0) | SMB_IDLE_PRD(231) | \
>                                   SMB_MEM_WR(0x3, 0x0) | SMB_MEM_RD(0x3, 0x6) | \
>                                   SMB_BST_LEN(16))
got it
> 
>> +#define SMB_INT_ENABLE		BIT(0)
>> +#define SMB_INT_TYPE_PULSE	BIT(1)
>> +#define SMB_INT_POLARITY_HIGH	BIT(2)
>> +#define HISI_SMB_GLB_INT_CFG	(SMB_INT_ENABLE | SMB_INT_TYPE_PULSE |         \
>> +				SMB_INT_POLARITY_HIGH)
> 
> Indentation problem on the second line
> 
got it, thanks.
>> +
>> +/* logic buffer config register low 32b */
>> +#define SMB_BUF_ENABLE			BIT(0)
>> +#define SMB_BUF_SINGLE_END		BIT(1)
>> +#define SMB_BUF_INIT			BIT(8)
>> +#define SMB_BUF_CONTINUOUS		BIT(11)
>> +#define SMB_FLOW_MASK			GENMASK(19, 16)
>> +#define SMB_BUF_CFG_STREAMING						       \
>> +	(SMB_BUF_INIT | SMB_BUF_CONTINUOUS | SMB_FLOW_MASK)
>> +#define SMB_BUF_WRITE_BASE		GENMASK(31, 0)
>> +
>> +/* logic buffer config register high 32b */
>> +#define SMB_MSG_FILTER(lower, upper)	((lower & 0xff) | ((upper & 0xff) << 8))
>> +#define SMB_BUF_INT_ENABLE		BIT(0)
>> +#define SMB_BUF_NOTE_NOT_EMPTY		BIT(8)
>> +#define SMB_BUF_NOTE_BLOCK_AVAIL	BIT(9)
>> +#define SMB_BUF_NOTE_TRIGGERED		BIT(10)
>> +#define SMB_BUF_NOTE_FULL		BIT(11)
>> +#define HISI_SMB_BUF_INT_CFG						\
>> +	(SMB_BUF_INT_ENABLE | SMB_BUF_NOTE_NOT_EMPTY |			\
>> +	   SMB_BUF_NOTE_BLOCK_AVAIL | SMB_BUF_NOTE_TRIGGERED |		\
>> +	    SMB_BUF_NOTE_FULL)
> 
> Same as above
> 
>> +
>> +#define US_SELECT_ONCHIP		0x3
> 
> I can't understand what is happening here without comments
> 
sorry, I'll add some comment to explain this.

>> +struct smb_data_buffer {
>> +	/* memory buffer for hardware write */
>> +	bool lost;
>> +	void __iomem *buf_base;
>> +	u64 buf_base_phys;
>> +	u64 buf_size;
>> +	u64 to_copy;
>> +	u32 rd_offset;
>> +};
>> +
>> +struct smb_drv_data {
>> +	void __iomem *base;
>> +	void __iomem *com_mux;
>> +	struct device *dev;
>> +	struct smb_data_buffer smb_db;
>> +	/* to register ultrasoc smb as a coresight sink device. */
>> +	struct coresight_device	*csdev;
>> +	spinlock_t		spinlock;
>> +	local_t			reading;
>> +	pid_t			pid;
>> +	u32			mode;
>> +	struct miscdevice miscdev;
>> +};
> 
> This needs to be documented the same way tmc_drvdata and other CS specific
> structures are.
> 
got it, I'll read tmc_drvdata and fix this, thanks.

sorry for lacking comment in this patch again, I'll add comments to 
reduce misunderstanding and confusion next time.

Thanks,
Qi
> I will stop here for this revision.  There are other things I wanted to comment
> on but I am running out of time for this set, mostly because (as I pointed out above) I have to guess a lot.
> 
> Thanks,
> Mathieu
> 
>> +
>> +#define SMB_MSG_ALIGH_SIZE 0x400
>> +
>> +static inline struct smb_data_buffer *
>> +	dev_get_smb_data_buffer(struct device *dev)
>> +{
>> +	struct smb_drv_data *drvdata = dev_get_drvdata(dev);
>> +
>> +	if (drvdata)
>> +		return &drvdata->smb_db;
>> +
>> +	return NULL;
>> +}
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
>> +
>> +#endif
>> -- 
>> 2.17.1
>>
> .
> 

