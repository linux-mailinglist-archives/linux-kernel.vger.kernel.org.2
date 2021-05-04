Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B31372BB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhEDOLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231393AbhEDOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620137419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJrOIA4/NHolwywEb3vjqTZa/OkkUCVbg6DeTy+CeSM=;
        b=gCp2TO3Gs8++NOJS72nM6FJ0v6awmHfufV+C8EEwsWGuVFQQE8PHX1r9K2j6dAGfs2rGsm
        akTRRKCwNJ3dI1/+K7eB2aS++jCkCAuDHBzBYX8PxB/JP/H4UCdndDmudPAgGgWrb5+bmU
        0vrAktuvJQgWZPh6BVxcIRqSYR7bXeQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-yIUIOL7sP5SE4L_es5GDJw-1; Tue, 04 May 2021 10:10:17 -0400
X-MC-Unique: yIUIOL7sP5SE4L_es5GDJw-1
Received: by mail-qt1-f200.google.com with SMTP id h2-20020a05622a1702b02901b9123889b0so3621436qtk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rJrOIA4/NHolwywEb3vjqTZa/OkkUCVbg6DeTy+CeSM=;
        b=f+u9MbJK6SUK/dSLZWTivgwPMRHZpjWxcFHFu9J/pVUy4IA1ys1Ky0EtqBVcaQ2Xx8
         /eI9ADRpi3N7MiUoDyIrYidDErrI4brJ1wmVqnuWPm9Plt3pj9zxP0pA/OGukEiOnpMh
         cYlWMqaKHbPuLSe/NfQXnV+7Fn/ARRb2BmFzMQvsrq5hE/vJR/1Sy1xGmUbfeV6F/l6V
         L+KUaAwA/ZePYSR7YydxBZeWMGORy6/zT10XzI8KZP0WgQQGuFqaU6vc3xCWcjCxw8p8
         YeyULKA0llkwgkaIraSbFdwJ0MM0qpG08c3fhneGwRHaBT2xp3YGMTTiTxmqW1GRUi8A
         nKVg==
X-Gm-Message-State: AOAM532CUBnTyj2n61emvZ+AOLdwI2tQEqgABrNarPBp8y3ixuv5YaGe
        KosIPHKGiNaVpygpSHc5Ps1vRQA9nhYv6a+xhNYUPozOARu2DpXwBizaYmCktFBjlN0rY2cuolr
        uw5TUUAnSXAAkdclD+2aVRRiv
X-Received: by 2002:a05:620a:2912:: with SMTP id m18mr23747978qkp.475.1620137413702;
        Tue, 04 May 2021 07:10:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh0lXKCNGmHGMMKS82rEbstBlRo2wBQbgwVlZctbo5aePU4vvNdblbopVt9ePz5GpTgJxkHQ==
X-Received: by 2002:a05:620a:2912:: with SMTP id m18mr23747916qkp.475.1620137413093;
        Tue, 04 May 2021 07:10:13 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 4sm2489162qtc.40.2021.05.04.07.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:10:12 -0700 (PDT)
Subject: Re: [PATCH V5 XRT Alveo 17/20] fpga: xrt: clock frequency counter
 driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
 <20210427205431.23896-18-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <5c5ce33b-6c19-c0a6-ea32-b741ef0054c6@redhat.com>
Date:   Tue, 4 May 2021 07:10:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427205431.23896-18-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/21 1:54 PM, Lizhi Hou wrote:
> Add clock frequency counter driver. Clock frequency counter is
> a hardware function discovered by walking xclbin metadata. A xrt
> device node will be created for it. Other part of driver can read the
> actual clock frequency through clock frequency counter driver.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>

v4 was ok, please add my Reviewed-by: line

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
>   drivers/fpga/xrt/include/xleaf/clkfreq.h |  21 +++
>   drivers/fpga/xrt/lib/xleaf/clkfreq.c     | 223 +++++++++++++++++++++++
>   2 files changed, 244 insertions(+)
>   create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/clkfreq.h b/drivers/fpga/xrt/include/xleaf/clkfreq.h
> new file mode 100644
> index 000000000000..005441d5df78
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/clkfreq.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Lizhi Hou <Lizhi.Hou@xilinx.com>
> + */
> +
> +#ifndef _XRT_CLKFREQ_H_
> +#define _XRT_CLKFREQ_H_
> +
> +#include "xleaf.h"
> +
> +/*
> + * CLKFREQ driver leaf calls.
> + */
> +enum xrt_clkfreq_leaf_cmd {
> +	XRT_CLKFREQ_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +};
> +
> +#endif	/* _XRT_CLKFREQ_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/clkfreq.c b/drivers/fpga/xrt/lib/xleaf/clkfreq.c
> new file mode 100644
> index 000000000000..3d1f11152375
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/clkfreq.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA Clock Frequency Counter Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/io.h>
> +#include "metadata.h"
> +#include "xleaf.h"
> +#include "xleaf/clkfreq.h"
> +
> +#define CLKFREQ_ERR(clkfreq, fmt, arg...)   \
> +	xrt_err((clkfreq)->xdev, fmt "\n", ##arg)
> +#define CLKFREQ_WARN(clkfreq, fmt, arg...)  \
> +	xrt_warn((clkfreq)->xdev, fmt "\n", ##arg)
> +#define CLKFREQ_INFO(clkfreq, fmt, arg...)  \
> +	xrt_info((clkfreq)->xdev, fmt "\n", ##arg)
> +#define CLKFREQ_DBG(clkfreq, fmt, arg...)   \
> +	xrt_dbg((clkfreq)->xdev, fmt "\n", ##arg)
> +
> +#define XRT_CLKFREQ		"xrt_clkfreq"
> +
> +#define XRT_CLKFREQ_CONTROL_STATUS_MASK		0xffff
> +
> +#define XRT_CLKFREQ_CONTROL_START	0x1
> +#define XRT_CLKFREQ_CONTROL_DONE	0x2
> +#define XRT_CLKFREQ_V5_CLK0_ENABLED	0x10000
> +
> +#define XRT_CLKFREQ_CONTROL_REG		0
> +#define XRT_CLKFREQ_COUNT_REG		0x8
> +#define XRT_CLKFREQ_V5_COUNT_REG	0x10
> +
> +#define XRT_CLKFREQ_READ_RETRIES	10
> +
> +XRT_DEFINE_REGMAP_CONFIG(clkfreq_regmap_config);
> +
> +struct clkfreq {
> +	struct xrt_device	*xdev;
> +	struct regmap		*regmap;
> +	const char		*clkfreq_ep_name;
> +	struct mutex		clkfreq_lock; /* clock counter dev lock */
> +};
> +
> +static int clkfreq_read(struct clkfreq *clkfreq, u32 *freq)
> +{
> +	int times = XRT_CLKFREQ_READ_RETRIES;
> +	u32 status;
> +	int ret;
> +
> +	*freq = 0;
> +	mutex_lock(&clkfreq->clkfreq_lock);
> +	ret = regmap_write(clkfreq->regmap, XRT_CLKFREQ_CONTROL_REG, XRT_CLKFREQ_CONTROL_START);
> +	if (ret) {
> +		CLKFREQ_INFO(clkfreq, "write start to control reg failed %d", ret);
> +		goto failed;
> +	}
> +	while (times != 0) {
> +		ret = regmap_read(clkfreq->regmap, XRT_CLKFREQ_CONTROL_REG, &status);
> +		if (ret) {
> +			CLKFREQ_INFO(clkfreq, "read control reg failed %d", ret);
> +			goto failed;
> +		}
> +		if ((status & XRT_CLKFREQ_CONTROL_STATUS_MASK) == XRT_CLKFREQ_CONTROL_DONE)
> +			break;
> +		mdelay(1);
> +		times--;
> +	};
> +
> +	if (!times) {
> +		ret = -ETIMEDOUT;
> +		goto failed;
> +	}
> +
> +	if (status & XRT_CLKFREQ_V5_CLK0_ENABLED)
> +		ret = regmap_read(clkfreq->regmap, XRT_CLKFREQ_V5_COUNT_REG, freq);
> +	else
> +		ret = regmap_read(clkfreq->regmap, XRT_CLKFREQ_COUNT_REG, freq);
> +	if (ret) {
> +		CLKFREQ_INFO(clkfreq, "read count failed %d", ret);
> +		goto failed;
> +	}
> +
> +	mutex_unlock(&clkfreq->clkfreq_lock);
> +
> +	return 0;
> +
> +failed:
> +	mutex_unlock(&clkfreq->clkfreq_lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t freq_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct clkfreq *clkfreq = xrt_get_drvdata(to_xrt_dev(dev));
> +	ssize_t count;
> +	u32 freq;
> +
> +	if (clkfreq_read(clkfreq, &freq))
> +		return -EINVAL;
> +
> +	count = snprintf(buf, 64, "%u\n", freq);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RO(freq);
> +
> +static struct attribute *clkfreq_attrs[] = {
> +	&dev_attr_freq.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group clkfreq_attr_group = {
> +	.attrs = clkfreq_attrs,
> +};
> +
> +static int
> +xrt_clkfreq_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
> +{
> +	struct clkfreq *clkfreq;
> +	int ret = 0;
> +
> +	clkfreq = xrt_get_drvdata(xdev);
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		/* Does not handle any event. */
> +		break;
> +	case XRT_CLKFREQ_READ:
> +		ret = clkfreq_read(clkfreq, arg);
> +		break;
> +	default:
> +		xrt_err(xdev, "unsupported cmd %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void clkfreq_remove(struct xrt_device *xdev)
> +{
> +	sysfs_remove_group(&xdev->dev.kobj, &clkfreq_attr_group);
> +}
> +
> +static int clkfreq_probe(struct xrt_device *xdev)
> +{
> +	struct clkfreq *clkfreq = NULL;
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +	int ret;
> +
> +	clkfreq = devm_kzalloc(&xdev->dev, sizeof(*clkfreq), GFP_KERNEL);
> +	if (!clkfreq)
> +		return -ENOMEM;
> +
> +	xrt_set_drvdata(xdev, clkfreq);
> +	clkfreq->xdev = xdev;
> +	mutex_init(&clkfreq->clkfreq_lock);
> +
> +	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		ret = -EINVAL;
> +		goto failed;
> +	}
> +	base = devm_ioremap_resource(&xdev->dev, res);
> +	if (IS_ERR(base)) {
> +		ret = PTR_ERR(base);
> +		goto failed;
> +	}
> +
> +	clkfreq->regmap = devm_regmap_init_mmio(&xdev->dev, base, &clkfreq_regmap_config);
> +	if (IS_ERR(clkfreq->regmap)) {
> +		CLKFREQ_ERR(clkfreq, "regmap %pR failed", res);
> +		ret = PTR_ERR(clkfreq->regmap);
> +		goto failed;
> +	}
> +	clkfreq->clkfreq_ep_name = res->name;
> +
> +	ret = sysfs_create_group(&xdev->dev.kobj, &clkfreq_attr_group);
> +	if (ret) {
> +		CLKFREQ_ERR(clkfreq, "create clkfreq attrs failed: %d", ret);
> +		goto failed;
> +	}
> +
> +	CLKFREQ_INFO(clkfreq, "successfully initialized clkfreq subdev");
> +
> +	return 0;
> +
> +failed:
> +	return ret;
> +}
> +
> +static struct xrt_dev_endpoints xrt_clkfreq_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_dev_ep_names[]) {
> +			{ .compat = XRT_MD_COMPAT_CLKFREQ },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_driver xrt_clkfreq_driver = {
> +	.driver = {
> +		.name = XRT_CLKFREQ,
> +	},
> +	.subdev_id = XRT_SUBDEV_CLKFREQ,
> +	.endpoints = xrt_clkfreq_endpoints,
> +	.probe = clkfreq_probe,
> +	.remove = clkfreq_remove,
> +	.leaf_call = xrt_clkfreq_leaf_call,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(clkfreq);

