Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DA63BF711
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 10:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhGHIuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 04:50:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14038 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhGHIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 04:50:00 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GL8wH3k8HzZp1G;
        Thu,  8 Jul 2021 16:43:59 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 8 Jul 2021 16:47:12 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 8 Jul
 2021 16:47:11 +0800
Subject: Re: [RFC PATCH 4/4] ultrasoc: Add System Memory Buffer driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linuxarm <linuxarm@huawei.com>
CC:     <alexander.shishkin@linux.intel.com>, <suzuki.poulose@arm.com>,
        <jonathan.zhouwen@huawei.com>, <f.fangjian@huawei.com>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>
References: <1623749684-65432-1-git-send-email-liuqi115@huawei.com>
 <1623749684-65432-5-git-send-email-liuqi115@huawei.com>
 <20210629205003.GA1238591@p14s>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <3931b63d-c058-35d0-290d-5b215d0b94c3@huawei.com>
Date:   Thu, 8 Jul 2021 16:47:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210629205003.GA1238591@p14s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mathieu,

Thanks for reviewing this patch.

On 2021/6/30 4:50, Mathieu Poirier wrote:
> Hi Qi,
> 
> On Tue, Jun 15, 2021 at 05:34:44PM +0800, Qi Liu wrote:
>> This patch adds driver for System Memory Buffer. It includes
>> a platform driver for the SMB device.
>>
>> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   drivers/hwtracing/ultrasoc/Kconfig        |   9 +
>>   drivers/hwtracing/ultrasoc/Makefile       |   3 +
>>   drivers/hwtracing/ultrasoc/ultrasoc-smb.c | 663 ++++++++++++++++++++++++++++++
>>   drivers/hwtracing/ultrasoc/ultrasoc-smb.h | 182 ++++++++
>>   4 files changed, 857 insertions(+)
>>   create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-smb.c
>>   create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-smb.h
>>
>> diff --git a/drivers/hwtracing/ultrasoc/Kconfig b/drivers/hwtracing/ultrasoc/Kconfig
>> index 77429f3..8899949 100644
>> --- a/drivers/hwtracing/ultrasoc/Kconfig
>> +++ b/drivers/hwtracing/ultrasoc/Kconfig
>> @@ -22,4 +22,13 @@ config ULTRASOC_AXI_COM
>>   	  the upstream channel is used to transmit user configuration, and
>>   	  downstream channel to carry response and trace data to the users.
>>   
>> +config ULTRASOC_SMB
>> +	tristate "Ultrasoc System memory buffer drivers"
>> +	help
>> +	  This config enables support for Ultrasoc System Memory Buffer
>> +	  drivers. The System Memory Buffer provides a way to buffer and
>> +	  store messages in system memory. It provides a capability to
>> +	  store messages received on its input message interface to an
>> +	  area of system memory.
>> +
>>   endif
>> diff --git a/drivers/hwtracing/ultrasoc/Makefile b/drivers/hwtracing/ultrasoc/Makefile
>> index 54711a7b..b174ca8 100644
>> --- a/drivers/hwtracing/ultrasoc/Makefile
>> +++ b/drivers/hwtracing/ultrasoc/Makefile
>> @@ -8,3 +8,6 @@ ultrasoc-drv-objs := ultrasoc.o
>>   
>>   obj-$(CONFIG_ULTRASOC_AXI_COM) += ultrasoc-axi-com-drv.o
>>   ultrasoc-axi-com-drv-objs := ultrasoc-axi-com.o
>> +

[...]

>> +static ssize_t smb_show_status(struct ultrasoc_com *com, char *buf,
>> +			       ssize_t wr_size)
>> +{
>> +	struct smb_drv_data *drvdata;
>> +	u32 value;
>> +
>> +	drvdata = dev_get_drvdata(com->dev);
>> +	value = readl(drvdata->base + SMB_LB_INT_STS);
>> +	wr_size += sysfs_emit_at(buf, wr_size, "%-20s: 0x%08x\n",
>> +				 "interrupt status", value);
>> +	value = readl(drvdata->base + SMB_LB_WR_ADDR);
>> +	wr_size += sysfs_emit_at(buf, wr_size, "%-20s: %#x\n", "write point",
>> +				 value);
>> +	value = readl(drvdata->base + SMB_LB_RD_ADDR);
>> +	wr_size += sysfs_emit_at(buf, wr_size, "%-20s: %#x\n", "read point",
>> +				 value);
> 
> This will not work.  The sysfs interface requires one line per entry.  Please
> look at what other coresight drivers do in that area.

got it, I'll use multi sysfs files to show these information， like this:
static struct attribute *smb_sink_attrs[] = {
	&dev_attr_read_pos.attr,
	&dev_attr_write_pos.attr,
	&dev_attr_buf_status.attr,
	NULL,
};
> 
>> +
>> +	return wr_size;
>> +}
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
>> +	}
>> +
>> +	sdb->buf_base_phys = res->start;
>> +	sdb->buf_size = resource_size(res);
>> +	if (sdb->buf_size == 0)
>> +		return -EINVAL;
>> +
>> +	sdb->buf_base = ioremap_cache(sdb->buf_base_phys, sdb->buf_size);
> 
> Why no using devm_ioremap_resource() ?
will use this, thanks.

> 
>> +	if (sdb->buf_base == NULL)
>> +		return -ENOMEM;
>> +
>> +	sdb->buf_cfg_mode = SMB_BUF_CFG_STREAMING;
> 
> As far as I can tell there is no point in keeping the value of
> SMB_BUF_CFG_STREAMING in the smb_data_buffer since it isn't used for anything
> else other than setting a HW register in smb_set_default_hw().
> 
thanks, will remove this member in struct smb_data_buffer, thanks.

>> +	return 0;
>> +}
>> +

[...]

>> +static int smb_config_com_descp(struct platform_device *pdev,
>> +				struct smb_drv_data *drvdata)
>> +{
>> +	struct device *parent = pdev->dev.parent;
>> +	struct ultrasoc_com_descp com_descp = {0};
>> +	struct device *dev = &pdev->dev;
>> +	struct ultrasoc_com *com;
>> +
>> +	com_descp.name = pdev->name;
>> +	com_descp.com_type = ULTRASOC_COM_TYPE_DOWN;
>> +	com_descp.com_dev = dev;
>> +	com_descp.uscom_ops = &smb_ops;
>> +	com = ultrasoc_register_com(parent, &com_descp);
> 
> Why is this needed?  As far as I can see this device does not need to
> register with the ultrasoc core.
> 
yes, you are right.

At the beginning we use the ultrasoc core to adapt multiple hardware 
devices and support more capabilities. But after discussing with 
Siemens, we are allowed to only upstream the axi-com and smb driver.

So the software architecture seems unreasonable now, I'll refactor it in 
next version, thanks.

> To me the very first thing do to about this patchset is to move this in
> drivers/hwtracing/coresight/.  That will dissociate this code completely from
> the ultrasoc core (more on that later) and avoid duplications as pointed out by
> Suzuki.
> 
> There are several things to address with this patch but there is no point in
> elaborating further until the above hasn't been done.
> 
Got it, will move the driver next time, thanks.

Qi
>> +	if (IS_ERR(com)) {
>> +		dev_err(dev, "Failed to register smb com.\n");
>> +		return PTR_ERR(com);
>> +	}
>> +
>> +	drvdata->com = com;
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
>> +	smb_set_default_hw(drvdata);
>> +	spin_lock_init(&drvdata->spinlock);
>> +	drvdata->dev = &pdev->dev;
>> +	drvdata->pid = -1;
>> +
>> +	ret = smb_config_com_descp(pdev, drvdata);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = smb_register_sink(pdev, drvdata);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to register smb sink.\n");
>> +		ultrasoc_unregister_com(drvdata->com);
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
>> +
>> +	smb_unregister_sink(drvdata);
>> +	ultrasoc_unregister_com(drvdata->com);
>> +	smb_release_data_buffer(drvdata);
>> +	return 0;
>> +}
>> +
>> +static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
>> +	{"HISI03A1", },
>> +	{},
>> +};
>> +
>> +static struct platform_driver smb_driver = {
>> +	.driver = {
>> +		.name = "ultrasoc,smb",
>> +		.acpi_match_table = ultrasoc_smb_acpi_match,
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
>> diff --git a/drivers/hwtracing/ultrasoc/ultrasoc-smb.h b/drivers/hwtracing/ultrasoc/ultrasoc-smb.h
>> new file mode 100644
>> index 0000000..e37d510
>> --- /dev/null
>> +++ b/drivers/hwtracing/ultrasoc/ultrasoc-smb.h
>> @@ -0,0 +1,182 @@
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
>> +
>> +#ifndef _ULTRASOC_SMB_H
>> +#define _ULTRASOC_SMB_H
>> +
>> +#include <linux/coresight.h>
>> +#include <linux/list.h>
>> +#include <linux/miscdevice.h>
>> +
>> +#include "ultrasoc.h"
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
>> +
>> +#define SMB_INT_ENABLE		BIT(0)
>> +#define SMB_INT_TYPE_PULSE	BIT(1)
>> +#define SMB_INT_POLARITY_HIGH	BIT(2)
>> +#define HISI_SMB_GLB_INT_CFG	(SMB_INT_ENABLE | SMB_INT_TYPE_PULSE |         \
>> +				SMB_INT_POLARITY_HIGH)
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
>> +
>> +struct smb_data_buffer {
>> +	/* memory buffer for hardware write */
>> +	u32 buf_cfg_mode;
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
>> +	struct device *dev;
>> +	struct ultrasoc_com *com;
>> +	struct smb_data_buffer smb_db;
>> +	/* to register ultrasoc smb as a coresight sink device. */
>> +	struct coresight_device	*csdev;
>> +	spinlock_t		spinlock;
>> +	local_t			reading;
>> +	pid_t			pid;
>> +	u32			mode;
>> +	struct miscdevice miscdev;
>> +};
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
>> +/*
>> + * Coresight doesn't export the following
>> + * structures(cs_mode,cs_buffers,etm_event_data),
>> + * so we redefine a copy here.
>> + */
>> +enum cs_mode {
>> +	CS_MODE_DISABLED,
>> +	CS_MODE_SYSFS,
>> +	CS_MODE_PERF,
>> +};
>> +
>> +struct cs_buffers {
>> +	unsigned int		cur;
>> +	unsigned int		nr_pages;
>> +	unsigned long		offset;
>> +	local_t			data_size;
>> +	bool			snapshot;
>> +	void			**data_pages;
>> +};
>> +
>> +struct etm_event_data {
>> +	struct work_struct work;
>> +	cpumask_t mask;
>> +	void *snk_config;
>> +	struct list_head * __percpu *path;
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_CORESIGHT)
>> +int etm_perf_symlink(struct coresight_device *csdev, bool link);
>> +int etm_perf_add_symlink_sink(struct coresight_device *csdev);
>> +void etm_perf_del_symlink_sink(struct coresight_device *csdev);
>> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
>> +{
>> +	struct etm_event_data *data = perf_get_aux(handle);
>> +
>> +	if (data)
>> +		return data->snk_config;
>> +	return NULL;
>> +}
>> +#else
>> +static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
>> +{ return -EINVAL; }
>> +int etm_perf_add_symlink_sink(struct coresight_device *csdev)
>> +{ return -EINVAL; }
>> +void etm_perf_del_symlink_sink(struct coresight_device *csdev) {}
>> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
>> +{
>> +	return NULL;
>> +}
>> +
>> +#endif /* CONFIG_CORESIGHT */
>> +
>> +#endif
>> -- 
>> 2.7.4
>>
> .
> 

