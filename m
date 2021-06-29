Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBA3B79D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 23:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhF2VY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 17:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbhF2VY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 17:24:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20CAC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:22:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y4so423026pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PuYTu781q0GJ5m9jxNr5Jcfj7URZutCvBQF7+I5FOL0=;
        b=pORx7Nof0AV61iTDRFkHoj5ENNF0KcScz55nCvne3FY93q5A/kXAGVoLIcI+k23SoU
         O2lZQfXbASczpktRVnCqTV2eGsdcpcbIzU4Df82HwDpNORV8psr6CPvvl9FIX140n9xF
         zJEFNuY8WI3jPb4mPW5K3f5QZOk8GH899X7DPaR+BcNwQV3Eqp1YbBYMIEzlSaWeHV5R
         m5wkFulhlXW8elfpYbQKiuxrWmoQ3SkWj2lbPzapf7YQGZ9bpQQiTv7OB1aQbk1tXoWf
         wvBWiMhgIp0UciDeOADfAeLVv+M2u8PEdufXMbIJnc9Tok5CwpemXoUKNXqpgIjUDFJ7
         R//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PuYTu781q0GJ5m9jxNr5Jcfj7URZutCvBQF7+I5FOL0=;
        b=jzqW1wWGGwvvfp5GQ45SrEOZDilEjGPandzoMI57E6GEE2x9gla4ZMQn0rs+dFQCFU
         ex9QdHG3pZAlVCRvsIjIlXb1nLFZ0OMS9tSntQCXpaPiKx8AE1eYJQ6cJZrB8+kvluc0
         u4dNo+fBDKa0ovFRKZm6GBxrOOYRcLwMcUSJn6KXItwZpznNnmoasbORLJJMC3YgnANR
         h/Yfqa/AYNFCH4YC+qaehmFhtYULWOgb31455BdUPkhuVH8e6ZW/p9ibwCpnUruNV/nh
         vkQwKLEh3EbSKKHOpXjiHOkx8VpKixTvH8B1pKptjHkucoBcKqcghO3mtX0mYWenOEkx
         hyRA==
X-Gm-Message-State: AOAM531Mr7LgNZphoQQk/Bx23ZCdQRGhlpVho4+3H1b/vnKoOWkyUhwN
        kzGyGAsJ6jQ7WK2rrhyXrzj/hU7VV4Rtgw==
X-Google-Smtp-Source: ABdhPJz11brZT7+0cEjXGV29otzLpdnmQqMKGt/ODtnVn9d7F2A5OcSba1+xSXN4V8JYLXPMd3aP6w==
X-Received: by 2002:aa7:8509:0:b029:2e5:8cfe:bc17 with SMTP id v9-20020aa785090000b02902e58cfebc17mr32295546pfn.2.1625001747841;
        Tue, 29 Jun 2021 14:22:27 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id lt14sm19707356pjb.47.2021.06.29.14.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 14:22:26 -0700 (PDT)
Date:   Tue, 29 Jun 2021 15:22:24 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        jonathan.zhouwen@huawei.com, f.fangjian@huawei.com,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linuxarm@huawei.com
Subject: Re: [RFC PATCH 3/4] ultrasoc: Add ultrasoc AXI Communicator driver
Message-ID: <20210629212224.GB1238591@p14s>
References: <1623749684-65432-1-git-send-email-liuqi115@huawei.com>
 <1623749684-65432-4-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623749684-65432-4-git-send-email-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 05:34:43PM +0800, Qi Liu wrote:
> This patch adds driver for ultrasoc AXI Communicator. It includes
> a platform driver to probe AXI Communicator device, a set of
> operations to access the service data, and a service work entry
> which will be called by the standard communicator service.
> 
> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  drivers/hwtracing/ultrasoc/Kconfig            |   9 +
>  drivers/hwtracing/ultrasoc/Makefile           |   3 +
>  drivers/hwtracing/ultrasoc/ultrasoc-axi-com.c | 334 ++++++++++++++++++++++++++
>  drivers/hwtracing/ultrasoc/ultrasoc-axi-com.h |  66 +++++
>  4 files changed, 412 insertions(+)
>  create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-axi-com.c
>  create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-axi-com.h
> 
> diff --git a/drivers/hwtracing/ultrasoc/Kconfig b/drivers/hwtracing/ultrasoc/Kconfig
> index 90a3934..77429f3 100644
> --- a/drivers/hwtracing/ultrasoc/Kconfig
> +++ b/drivers/hwtracing/ultrasoc/Kconfig
> @@ -13,4 +13,13 @@ menuconfig ULTRASOC
>  	  specification and configure the right series of components when a
>  	  trace source gets enabled.
>  
> +if ULTRASOC
> +config ULTRASOC_AXI_COM
> +	tristate "Ultrasoc AXI communicator drivers"
> +	help
> +	  This config enables support for Ultrasoc AXI Bus Communicator
> +	  drivers. The AXI Communicator has upstream and downstream channels,
> +	  the upstream channel is used to transmit user configuration, and
> +	  downstream channel to carry response and trace data to the users.
> +
>  endif
> diff --git a/drivers/hwtracing/ultrasoc/Makefile b/drivers/hwtracing/ultrasoc/Makefile
> index a747171..54711a7b 100644
> --- a/drivers/hwtracing/ultrasoc/Makefile
> +++ b/drivers/hwtracing/ultrasoc/Makefile
> @@ -5,3 +5,6 @@
>  
>  obj-$(CONFIG_ULTRASOC) += ultrasoc-drv.o
>  ultrasoc-drv-objs := ultrasoc.o
> +
> +obj-$(CONFIG_ULTRASOC_AXI_COM) += ultrasoc-axi-com-drv.o
> +ultrasoc-axi-com-drv-objs := ultrasoc-axi-com.o
> diff --git a/drivers/hwtracing/ultrasoc/ultrasoc-axi-com.c b/drivers/hwtracing/ultrasoc/ultrasoc-axi-com.c
> new file mode 100644
> index 0000000..af153dd
> --- /dev/null
> +++ b/drivers/hwtracing/ultrasoc/ultrasoc-axi-com.c
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright (C) 2021 Hisilicon Limited Permission is hereby granted, free of
> + * charge, to any person obtaining a copy of this software and associated
> + * documentation files (the "Software"), to deal in the Software without
> + * restriction, including without limitation the rights to use, copy, modify,
> + * merge, publish, distribute, sublicense, and/or sell copies of the Software,
> + * and to permit persons to whom the Software is furnished to do so, subject
> + * to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> + * IN THE SOFTWARE.
> + *
> + * Code herein communicates with and accesses proprietary hardware which is
> + * licensed intellectual property (IP) belonging to Siemens Digital Industries
> + * Software Ltd.
> + *
> + * Siemens Digital Industries Software Ltd. asserts and reserves all rights to
> + * their intellectual property. This paragraph may not be removed or modified
> + * in any way without permission from Siemens Digital Industries Software Ltd.
> + */
> +#include <linux/acpi.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <asm/unaligned.h>
> +
> +#include "ultrasoc-axi-com.h"
> +
> +static void axi_com_enable_hw(struct axi_com_drv_data *drvdata)
> +{
> +	u32 val;
> +
> +	val = readl(drvdata->base + AXIC_US_CTL);
> +	val |= AXIC_US_CTL_EN;
> +	writel(val, drvdata->base + AXIC_US_CTL);
> +
> +	val = readl(drvdata->base + AXIC_DS_CTL);
> +	val |= AXIC_DS_CTL_EN;
> +	writel(val, drvdata->base + AXIC_DS_CTL);
> +}
> +
> +static void axi_com_disable_hw(struct axi_com_drv_data *drvdata)
> +{
> +	u32 val;
> +
> +	val = readl(drvdata->base + AXIC_US_CTL);
> +	val &= ~AXIC_US_CTL_EN;
> +	writel(val, drvdata->base + AXIC_US_CTL);
> +
> +	val = readl(drvdata->base + AXIC_DS_CTL);
> +	val &= ~AXIC_DS_CTL_EN;
> +	writel(val, drvdata->base + AXIC_DS_CTL);
> +}
> +
> +static inline bool axi_com_us_buf_full(struct axi_com_drv_data *drvdata)
> +{
> +	return readl(drvdata->base + AXIC_US_BUF_STS) & BIT(0);
> +}
> +
> +static inline bool axi_com_ds_buf_full(struct axi_com_drv_data *drvdata)
> +{
> +	return readl(drvdata->base + AXIC_DS_BUF_STS) & BIT(0);
> +}
> +
> +static int axi_com_try_send_msg(struct axi_com_drv_data *drvdata)
> +{
> +	struct msg_descp *msg;
> +	struct list_head *node;
> +	int index = 0;
> +	int unsent;
> +	u32 data;
> +
> +	if (axi_com_us_buf_full(drvdata)) {
> +		dev_err_once(drvdata->dev, "No room for upstream buffer.\n");
> +		return US_SERVICE_IDLE;
> +	}
> +
> +	spin_lock(&drvdata->us_msg_list_lock);
> +	if (list_empty(&drvdata->us_msg_head)) {
> +		spin_unlock(&drvdata->us_msg_list_lock);
> +		return US_SERVICE_IDLE;
> +	}
> +
> +	node = drvdata->us_msg_head.next;
> +	list_del(node);
> +	drvdata->us_msg_cur--;
> +	msg = container_of(node, struct msg_descp, node);
> +	spin_unlock(&drvdata->us_msg_list_lock);
> +
> +	unsent = msg->msg_len;
> +	dev_dbg(drvdata->dev, "Length of send msg: %d.\n", msg->msg_len);
> +	while (unsent > 0) {
> +		data = get_unaligned_le32(&msg->msg_buf[index++]);
> +		writel(data, drvdata->base + AXIC_US_DATA);

Who reads the data that gets written here?

> +		unsent -= AXIC_MSG_LEN_PER_SEND;
> +	}
> +	kfree(msg);
> +
> +	return US_SERVICE_ONWORK;
> +}
> +
> +static int axi_com_try_recv_msg(struct axi_com_drv_data *drvdata)
> +{
> +	struct msg_descp tmp_msg = {0};
> +	struct msg_descp *msg;
> +	bool lost = false;
> +	u32 index = 0;
> +	u32 status, entries, data;
> +
> +	if (!axi_com_ds_buf_full(drvdata))
> +		return US_SERVICE_IDLE;
> +
> +	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
> +	if (!msg) {
> +		/*
> +		 * create local variable tmp_msg to read and clear
> +		 * the downstream message.
> +		 */
> +		msg = &tmp_msg;
> +		lost = true;
> +	}
> +
> +	do {
> +		if (index == USMSG_MAX_IDX) {
> +			dev_warn(drvdata->dev, "Illegal message.\n");
> +			break;
> +		}
> +		data = readl(drvdata->base + AXIC_DS_DATA);

Same thing - who writes the data that gets read here?  

> +		put_unaligned_le32(data, &msg->msg_buf[index++]);
> +		status = readl(drvdata->base + AXIC_DS_RD_STS);
> +		entries = status & GENMASK(7, 4);
> +		msg->msg_len += AXIC_MSG_LEN_PER_REC;
> +	} while (entries != 0);
> +
> +	if (!lost) {
> +		spin_lock(&drvdata->ds_msg_list_lock);
> +		drvdata->ds_msg_cur++;
> +		drvdata->ds_msg_counter++;
> +		list_add_tail(&msg->node, &drvdata->ds_msg_head);
> +		spin_unlock(&drvdata->ds_msg_list_lock);
> +	}
> +
> +	return US_SERVICE_ONWORK;
> +}
> +
> +static int axi_com_work(struct ultrasoc_com *uscom)
> +{
> +	struct axi_com_drv_data *drvdata = ultrasoc_com_get_drvdata(uscom);
> +	int us_ds_flag;
> +
> +	us_ds_flag = axi_com_try_recv_msg(drvdata);
> +	us_ds_flag |= axi_com_try_send_msg(drvdata);

Why does this work has to be done in ultrasoc.c when (as far as I can see) it
could be done as part of this driver using something like
smp_call_function_single()?

> +
> +	return us_ds_flag;
> +}
> +
> +static ssize_t axi_com_show_status(struct ultrasoc_com *uscom, char *buf,
> +				   ssize_t wr_size)
> +{
> +	struct axi_com_drv_data *drvdata = ultrasoc_com_get_drvdata(uscom);
> +
> +	wr_size += sysfs_emit_at(buf, wr_size, "%-20s: %d\n",
> +				 "ds msg list num", drvdata->ds_msg_cur);
> +	wr_size += sysfs_emit_at(buf, wr_size, "%-20s: %d\n",
> +				 "us msg list num", drvdata->us_msg_cur);

Same comment as smb.

> +
> +	return wr_size;
> +}
> +
> +static void axi_com_put_raw_msg(struct ultrasoc_com *uscom, int msg_size,
> +			unsigned long long msg_data)
> +{
> +	struct axi_com_drv_data *drvdata = ultrasoc_com_get_drvdata(uscom);
> +	struct msg_descp *p_msg;
> +
> +	p_msg = kmalloc(sizeof(*p_msg), GFP_KERNEL);
> +	if (!p_msg)
> +		return;
> +
> +	p_msg->msg_len = msg_size;
> +	put_unaligned_le64(msg_data, &p_msg->msg_buf[0]);
> +	spin_lock(&drvdata->us_msg_list_lock);
> +	list_add_tail(&p_msg->node, &drvdata->us_msg_head);
> +	drvdata->us_msg_cur++;
> +	spin_unlock(&drvdata->us_msg_list_lock);
> +
> +	if (uscom->service_status != ULTRASOC_COM_SERVICE_STOPPED)
> +		wake_up_process(uscom->service);
> +	else
> +		dev_warn(uscom->dev, "Com service is not running.\n");
> +}
> +
> +static struct uscom_ops axi_com_ops = {
> +	.com_status = axi_com_show_status,
> +	.put_raw_msg = axi_com_put_raw_msg,
> +};
> +
> +/*
> + * Config hardwares on the tracing path, using DSM calls to avoid exposing
> + * hardware message format.
> + */
> +static int axi_com_config_inport(struct axi_com_drv_data *drvdata, bool enable)
> +{
> +	struct device *dev = drvdata->dev;
> +	u32 flag = enable ? 1 : 0;
> +	union acpi_object *obj;
> +	guid_t guid;
> +
> +	if (guid_parse("82ae1283-7f6a-4cbe-aa06-53e8fb24db18", &guid)) {
> +		dev_err(dev, "Get GUID failed.\n");
> +		return -EINVAL;
> +	}
> +
> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &guid, 0, flag, NULL);
> +	if (!obj)
> +		dev_err(dev, "ACPI handle failed!\n");
> +
> +	ACPI_FREE(obj);
> +
> +	return 0;
> +}
> +
> +static int axi_com_config_com_descp(struct platform_device *pdev,
> +				    struct axi_com_drv_data *drvdata)
> +{
> +	struct device *parent = pdev->dev.parent;
> +	struct ultrasoc_com_descp com_descp = {0};
> +	struct device *dev = &pdev->dev;
> +	struct ultrasoc_com *com;
> +
> +	com_descp.name = pdev->name;
> +	com_descp.com_type = ULTRASOC_COM_TYPE_BOTH;

Both what?  From this I have to guess there is a dual purpose to this specific
type but there is no documentation as to what that can be.  This set is
difficult to review because of the general lack of documention.

> +	com_descp.com_dev = dev;
> +	com_descp.uscom_ops = &axi_com_ops;
> +	com_descp.com_work = axi_com_work;
> +
> +	if (device_property_read_u64(dev, "ultrasoc,default_route",
> +				     &com_descp.default_route_msg)) {
> +		dev_err(dev, "Failed to read default_route!\n");
> +		return -EINVAL;
> +	}
> +
> +	com = ultrasoc_register_com(parent, &com_descp);
> +	if (IS_ERR(com)) {
> +		dev_err(dev, "Failed to register to ultrasoc.\n");
> +		return PTR_ERR(com);
> +	}
> +
> +	/*
> +	 * record the returned com point in drvdata,
> +	 * it will be used to unregister the com
> +	 * from ultrasoc.
> +	 */
> +	drvdata->com = com;
> +	return 0;
> +}
> +
> +static int axi_com_probe(struct platform_device *pdev)
> +{
> +	struct axi_com_drv_data *drvdata;
> +	int ret;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(drvdata->base)) {
> +		dev_err(&pdev->dev, "Failed to ioremap resource.\n");
> +		return PTR_ERR(drvdata->base);
> +	}
> +
> +	drvdata->dev = &pdev->dev;
> +	spin_lock_init(&drvdata->ds_msg_list_lock);
> +	spin_lock_init(&drvdata->us_msg_list_lock);
> +	INIT_LIST_HEAD(&drvdata->us_msg_head);
> +	INIT_LIST_HEAD(&drvdata->ds_msg_head);
> +
> +	axi_com_enable_hw(drvdata);
> +	ret = axi_com_config_inport(drvdata, true);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, drvdata);
> +	return axi_com_config_com_descp(pdev, drvdata);
> +}
> +
> +static int axi_com_remove(struct platform_device *pdev)
> +{
> +	struct axi_com_drv_data *drvdata = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	if (ultrasoc_unregister_com(drvdata->com) == -EBUSY)
> +		return -EBUSY;
> +
> +	ret = axi_com_config_inport(drvdata, false);
> +	if (ret)
> +		return ret;
> +
> +	axi_com_disable_hw(drvdata);
> +	usmsg_list_realse_all(&drvdata->ds_msg_head);
> +	usmsg_list_realse_all(&drvdata->us_msg_head);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id ultrasoc_axi_com_acpi_match[] = {
> +	{"HISI03B1", },
> +	{},
> +};

No need for MODULE_DEVICE_TABLE()?

I am very confused as to what this IP does...  And I'm even more confused as to
why ultrasoc.c is needed at all.  As I pointed out in a previous comment there
is a lot of work to do on this patchset but there is no point in writing more
while questions about the current design choices are pending.

I am done reviewing this set.

Thanks,
Mathieu

> +
> +static struct platform_driver axi_com_driver = {
> +	.driver = {
> +		.name = "ultrasoc,axi-com",
> +		.acpi_match_table = ultrasoc_axi_com_acpi_match,
> +	},
> +	.probe = axi_com_probe,
> +	.remove = axi_com_remove,
> +};
> +module_platform_driver(axi_com_driver);
> +
> +MODULE_DESCRIPTION("Ultrasoc AXI COM driver");
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
> diff --git a/drivers/hwtracing/ultrasoc/ultrasoc-axi-com.h b/drivers/hwtracing/ultrasoc/ultrasoc-axi-com.h
> new file mode 100644
> index 0000000..64bcf83
> --- /dev/null
> +++ b/drivers/hwtracing/ultrasoc/ultrasoc-axi-com.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2021 Hisilicon Limited Permission is hereby granted, free of
> + * charge, to any person obtaining a copy of this software and associated
> + * documentation files (the "Software"), to deal in the Software without
> + * restriction, including without limitation the rights to use, copy, modify,
> + * merge, publish, distribute, sublicense, and/or sell copies of the Software,
> + * and to permit persons to whom the Software is furnished to do so, subject
> + * to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> + * IN THE SOFTWARE.
> + *
> + * Code herein communicates with and accesses proprietary hardware which is
> + * licensed intellectual property (IP) belonging to Siemens Digital Industries
> + * Software Ltd.
> + *
> + * Siemens Digital Industries Software Ltd. asserts and reserves all rights to
> + * their intellectual property. This paragraph may not be removed or modified
> + * in any way without permission from Siemens Digital Industries Software Ltd.
> + */
> +#ifndef ULTRASOC_AXI_COM_H
> +#define ULTRASOC_AXI_COM_H
> +
> +#include "ultrasoc.h"
> +
> +#define AXIC_US_CTL 0X0 /* Upstream general control */
> +#define AXIC_US_DATA 0XC /* Upstream message data */
> +#define AXIC_US_BUF_STS 0X10 /* Upstream buffer status */
> +
> +#define AXIC_DS_CTL 0X80 /* Downstream general contral */
> +#define AXIC_DS_DATA 0X8C /* Downstream message data */
> +#define AXIC_DS_BUF_STS 0X90 /* Downstream buffer status */
> +#define AXIC_DS_RD_STS 0X94 /* Downstream read status */
> +
> +#define AXIC_MSG_LEN_PER_SEND		4
> +#define AXIC_MSG_LEN_PER_REC		4
> +#define AXIC_US_CTL_EN 0x1
> +#define AXIC_DS_CTL_EN 0x1
> +
> +struct axi_com_drv_data {
> +	void __iomem *base;
> +
> +	struct device *dev;
> +	struct ultrasoc_com *com;
> +
> +	u32 ds_msg_counter;
> +
> +	u32 us_msg_cur;
> +	spinlock_t us_msg_list_lock;
> +	struct list_head us_msg_head;
> +
> +	u32 ds_msg_cur;
> +	spinlock_t ds_msg_list_lock;
> +	struct list_head ds_msg_head;
> +};
> +
> +#endif
> -- 
> 2.7.4
> 
