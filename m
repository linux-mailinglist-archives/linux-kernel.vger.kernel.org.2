Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57563372B93
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhEDOFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231270AbhEDOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620137048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bz/BkFEzKDbiiUHKmQk0KfMal+Y8kXEU5J61wg99LZs=;
        b=FkISEHmrlr7eJszGyz6L/pKCQTeDDlEbdkY0TwkSXOQJD7kIbFr0kZLJGx35n9RcO6QDQF
        9hqCPq5ign5mA/tkir+I4H+tvSYTaDz+Hq/LWfTpRC09aOSaDzR4BjOeYwO9iaZIBWKM0G
        rHYousSEm78aZGWqTB9pxVaEiuB+lKw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-4Nj6QsNQPTqMuIZ8NHALAg-1; Tue, 04 May 2021 10:03:22 -0400
X-MC-Unique: 4Nj6QsNQPTqMuIZ8NHALAg-1
Received: by mail-qk1-f198.google.com with SMTP id b3-20020a05620a0cc3b02902e9d5ca06f2so4669151qkj.19
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bz/BkFEzKDbiiUHKmQk0KfMal+Y8kXEU5J61wg99LZs=;
        b=YSxRLvtLiY3Dc4uRf5AH83iuw2iqMFscgpMjfVIBB1B4NEyxmCmlu/L+5J+8fJg74J
         YPptzmdIFmIVJzgA6+gTxIuZ7v1qKNvCCv2YxJBRUo8sXWCL3wB30EoH030AZ70B/3Qr
         1DqZRt2BmIaaSUKfmHtdhkEGCcDkU3sxy+we6T65D8bl83JDtUClfQNxUADEz9FVc+Uo
         AsapVZMs/l0kRB/1dBhXwgp8o5wZqLukjUqvKSGWz98hVjLNvqSg04cQZel5+6OH8KCT
         5NkNn5IA46ZxgcytUkcF0IgJ798VikaUaQBdsQhgBWEhcI0xi79+4HCToKwyy/Ztlg/N
         +vkw==
X-Gm-Message-State: AOAM530CzE9v3mMQSRhELZh4MsoWRFP+wdvG2bs1bwFiMqP27B0u5S8r
        dAAy3IQoJFXPLYGn+dSbmA2QXm+t/+bIZuUkTFSfDRK4fB5A5A8V2aE10VnwNaHS2DO6HAf1F52
        ZcGwpUxWjHT5CPJFaWr4a6zXj
X-Received: by 2002:ac8:7104:: with SMTP id z4mr6143943qto.379.1620137002101;
        Tue, 04 May 2021 07:03:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykiyODZIs0Ud1Rjfp7ZhCcxvdYEGlWvM38PJysFh2RXQCvQxCTt4KNkwpPVMEp1xEIlZlFSA==
X-Received: by 2002:ac8:7104:: with SMTP id z4mr6143924qto.379.1620137001849;
        Tue, 04 May 2021 07:03:21 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 11sm4888213qkk.31.2021.05.04.07.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:03:21 -0700 (PDT)
Subject: Re: [PATCH V5 XRT Alveo 13/20] fpga: xrt: User Clock Subsystem driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
 <20210427205431.23896-14-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <041b113b-a613-fd1e-54f5-3506426c8ff7@redhat.com>
Date:   Tue, 4 May 2021 07:03:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427205431.23896-14-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/21 1:54 PM, Lizhi Hou wrote:
> Add User Clock Subsystem (UCS) driver. UCS is a hardware function
> discovered by walking xclbin metadata. A xrt device node will be
> created for it.  UCS enables/disables the dynamic region clocks.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>

v4 was ok, please add my Reviewed-by line here, under yours.

Do for the others I have also ok-ed.

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
>   drivers/fpga/xrt/lib/xleaf/ucs.c | 152 +++++++++++++++++++++++++++++++
>   1 file changed, 152 insertions(+)
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>
> diff --git a/drivers/fpga/xrt/lib/xleaf/ucs.c b/drivers/fpga/xrt/lib/xleaf/ucs.c
> new file mode 100644
> index 000000000000..a7a96ddde44f
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/ucs.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA UCS Driver
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
> +#include "xleaf/clock.h"
> +
> +#define UCS_ERR(ucs, fmt, arg...)   \
> +	xrt_err((ucs)->xdev, fmt "\n", ##arg)
> +#define UCS_WARN(ucs, fmt, arg...)  \
> +	xrt_warn((ucs)->xdev, fmt "\n", ##arg)
> +#define UCS_INFO(ucs, fmt, arg...)  \
> +	xrt_info((ucs)->xdev, fmt "\n", ##arg)
> +#define UCS_DBG(ucs, fmt, arg...)   \
> +	xrt_dbg((ucs)->xdev, fmt "\n", ##arg)
> +
> +#define XRT_UCS		"xrt_ucs"
> +
> +#define XRT_UCS_CHANNEL1_REG			0
> +#define XRT_UCS_CHANNEL2_REG			8
> +
> +#define CLK_MAX_VALUE			6400
> +
> +XRT_DEFINE_REGMAP_CONFIG(ucs_regmap_config);
> +
> +struct xrt_ucs {
> +	struct xrt_device	*xdev;
> +	struct regmap		*regmap;
> +	struct mutex		ucs_lock; /* ucs dev lock */
> +};
> +
> +static void xrt_ucs_event_cb(struct xrt_device *xdev, void *arg)
> +{
> +	struct xrt_event *evt = (struct xrt_event *)arg;
> +	enum xrt_events e = evt->xe_evt;
> +	struct xrt_device *leaf;
> +	enum xrt_subdev_id id;
> +	int instance;
> +
> +	id = evt->xe_subdev.xevt_subdev_id;
> +	instance = evt->xe_subdev.xevt_subdev_instance;
> +
> +	if (e != XRT_EVENT_POST_CREATION) {
> +		xrt_dbg(xdev, "ignored event %d", e);
> +		return;
> +	}
> +
> +	if (id != XRT_SUBDEV_CLOCK)
> +		return;
> +
> +	leaf = xleaf_get_leaf_by_id(xdev, XRT_SUBDEV_CLOCK, instance);
> +	if (!leaf) {
> +		xrt_err(xdev, "does not get clock subdev");
> +		return;
> +	}
> +
> +	xleaf_call(leaf, XRT_CLOCK_VERIFY, NULL);
> +	xleaf_put_leaf(xdev, leaf);
> +}
> +
> +static int ucs_enable(struct xrt_ucs *ucs)
> +{
> +	int ret;
> +
> +	mutex_lock(&ucs->ucs_lock);
> +	ret = regmap_write(ucs->regmap, XRT_UCS_CHANNEL2_REG, 1);
> +	mutex_unlock(&ucs->ucs_lock);
> +
> +	return ret;
> +}
> +
> +static int
> +xrt_ucs_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
> +{
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		xrt_ucs_event_cb(xdev, arg);
> +		break;
> +	default:
> +		xrt_err(xdev, "unsupported cmd %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ucs_probe(struct xrt_device *xdev)
> +{
> +	struct xrt_ucs *ucs = NULL;
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +
> +	ucs = devm_kzalloc(&xdev->dev, sizeof(*ucs), GFP_KERNEL);
> +	if (!ucs)
> +		return -ENOMEM;
> +
> +	xrt_set_drvdata(xdev, ucs);
> +	ucs->xdev = xdev;
> +	mutex_init(&ucs->ucs_lock);
> +
> +	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	base = devm_ioremap_resource(&xdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	ucs->regmap = devm_regmap_init_mmio(&xdev->dev, base, &ucs_regmap_config);
> +	if (IS_ERR(ucs->regmap)) {
> +		UCS_ERR(ucs, "map base %pR failed", res);
> +		return PTR_ERR(ucs->regmap);
> +	}
> +	ucs_enable(ucs);
> +
> +	return 0;
> +}
> +
> +static struct xrt_dev_endpoints xrt_ucs_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_dev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_UCS_CONTROL_STATUS },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_driver xrt_ucs_driver = {
> +	.driver = {
> +		.name = XRT_UCS,
> +	},
> +	.subdev_id = XRT_SUBDEV_UCS,
> +	.endpoints = xrt_ucs_endpoints,
> +	.probe = ucs_probe,
> +	.leaf_call = xrt_ucs_leaf_call,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(ucs);

