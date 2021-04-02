Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E282352B73
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbhDBO1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235608AbhDBO1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617373649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlFhstH5ifpKXg1c5LfRAdgsK6/QKPfii7GaU15lKI8=;
        b=ZVNojRt2HYyA2GsI5S1kS0vW5u4uGreht+WFdcGdRin7Y9ex07gdJC/p6t78Xi7m5WfAH/
        b3WjNS40M7bJBh3Qp6eRCosx4OAPP9Nt02uJMJj3yn0+PQXdpBUOC9gyAvWKLdLe1fkks7
        ShmtYisPOjOx4QhIbaWmM2U2kEMa1M4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-xkV_0dHZMe6qgwA7-vsWUQ-1; Fri, 02 Apr 2021 10:27:27 -0400
X-MC-Unique: xkV_0dHZMe6qgwA7-vsWUQ-1
Received: by mail-qv1-f69.google.com with SMTP id e10so5255456qvr.17
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 07:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OlFhstH5ifpKXg1c5LfRAdgsK6/QKPfii7GaU15lKI8=;
        b=SBEpECnumU9TzkwgvcnJbv4pwg6zixK6R8JRiRqgcV8D8wKaa+ytyW+mmVzUS/Yfli
         admpm9JNhXTFwhRauxNvzh//WdWPaMrgm1J58PaAKlBw59H3LxvrP/he4fTz9dKp0L5h
         tUHaADKAxL0jlYjpqu0UT2CD6SGFmfQvWYtm7RH5BNScaKfWOiIs2dIzyuSJiiw+wyQl
         LQMODI5mMk8LpHpQoHZRRgxkycpC6nTwEYYhZxfEX9rpCkm5c8MYOYGp/l9klKEKvlsE
         RwU1ye6YN+BeIRhj2p92YWFmWBF0f5MmQIo10XYeLCTP6MyPLcJQ9/4PfWIcy3fnF99t
         MWmw==
X-Gm-Message-State: AOAM5306vDLAm6sBoGz8sux9XvehSxg1Pg9CszClf47fcQ17zJiEZc6h
        w9UTr7uwUb4ZDT0bCn56jRIrFP19pt6I5YURqN8/3HUyN/ZBf/RS2sOajNPZWsJ4IiUgRsovUWD
        i5ZzmcqSX9s4vngErsSqybgKT
X-Received: by 2002:a0c:f7d1:: with SMTP id f17mr12708621qvo.38.1617373647074;
        Fri, 02 Apr 2021 07:27:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgE/y9eyO+whwfj+xcSQhO6V0McPLXb84KTyhDVqJvR+jXjA1eEha/Wv9JDLpb4rXgTb026A==
X-Received: by 2002:a0c:f7d1:: with SMTP id f17mr12708604qvo.38.1617373646924;
        Fri, 02 Apr 2021 07:27:26 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i17sm7059714qtr.33.2021.04.02.07.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 07:27:26 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 13/20] fpga: xrt: User Clock Subsystem
 platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-14-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a5db6c62-e716-1ea8-ad7a-e5ea5adc5c23@redhat.com>
Date:   Fri, 2 Apr 2021 07:27:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-14-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/21 10:29 PM, Lizhi Hou wrote:
> Add User Clock Subsystem (UCS) driver. UCS is a hardware function
ok
> discovered by walking xclbin metadata. A platform device node will be
> created for it.  UCS enables/disables the dynamic region clocks.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/fpga/xrt/lib/xleaf/ucs.c | 167 +++++++++++++++++++++++++++++++
ok on removing ucs.h
>  1 file changed, 167 insertions(+)
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>
> diff --git a/drivers/fpga/xrt/lib/xleaf/ucs.c b/drivers/fpga/xrt/lib/xleaf/ucs.c
> new file mode 100644
> index 000000000000..d91ee229e7cb
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/ucs.c
> @@ -0,0 +1,167 @@
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
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/io.h>
> +#include "metadata.h"
> +#include "xleaf.h"
> +#include "xleaf/clock.h"
> +
> +#define UCS_ERR(ucs, fmt, arg...)   \
> +	xrt_err((ucs)->pdev, fmt "\n", ##arg)
> +#define UCS_WARN(ucs, fmt, arg...)  \
> +	xrt_warn((ucs)->pdev, fmt "\n", ##arg)
> +#define UCS_INFO(ucs, fmt, arg...)  \
> +	xrt_info((ucs)->pdev, fmt "\n", ##arg)
> +#define UCS_DBG(ucs, fmt, arg...)   \
> +	xrt_dbg((ucs)->pdev, fmt "\n", ##arg)
> +
> +#define XRT_UCS		"xrt_ucs"
> +
> +#define XRT_UCS_CHANNEL1_REG			0
> +#define XRT_UCS_CHANNEL2_REG			8
> +
> +#define CLK_MAX_VALUE			6400
> +
> +static const struct regmap_config ucs_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x1000,
> +};
> +
> +struct xrt_ucs {
> +	struct platform_device	*pdev;
> +	struct regmap		*regmap;
ok
> +	struct mutex		ucs_lock; /* ucs dev lock */
> +};
> +
> +static void xrt_ucs_event_cb(struct platform_device *pdev, void *arg)
> +{
> +	struct xrt_event *evt = (struct xrt_event *)arg;
> +	enum xrt_events e = evt->xe_evt;
> +	struct platform_device *leaf;
> +	enum xrt_subdev_id id;
> +	int instance;
> +
> +	id = evt->xe_subdev.xevt_subdev_id;
> +	instance = evt->xe_subdev.xevt_subdev_instance;
> +
> +	if (e != XRT_EVENT_POST_CREATION) {
> +		xrt_dbg(pdev, "ignored event %d", e);
> +		return;
> +	}
> +
> +	if (id != XRT_SUBDEV_CLOCK)
> +		return;
ok
> +
> +	leaf = xleaf_get_leaf_by_id(pdev, XRT_SUBDEV_CLOCK, instance);
> +	if (!leaf) {
> +		xrt_err(pdev, "does not get clock subdev");
> +		return;
> +	}
> +
> +	xleaf_call(leaf, XRT_CLOCK_VERIFY, NULL);
> +	xleaf_put_leaf(pdev, leaf);
> +}
ok on removing ucs_check.
> +
> +static int ucs_enable(struct xrt_ucs *ucs)
> +{
> +	int ret;
> +
> +	mutex_lock(&ucs->ucs_lock);
ok
> +	ret = regmap_write(ucs->regmap, XRT_UCS_CHANNEL2_REG, 1);
> +	mutex_unlock(&ucs->ucs_lock);
> +
> +	return ret;
> +}
> +
> +static int
> +xrt_ucs_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)

ok

Looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

> +{
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		xrt_ucs_event_cb(pdev, arg);
> +		break;
> +	default:
> +		xrt_err(pdev, "unsupported cmd %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ucs_probe(struct platform_device *pdev)
> +{
> +	struct xrt_ucs *ucs = NULL;
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +
> +	ucs = devm_kzalloc(&pdev->dev, sizeof(*ucs), GFP_KERNEL);
> +	if (!ucs)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ucs);
> +	ucs->pdev = pdev;
> +	mutex_init(&ucs->ucs_lock);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	ucs->regmap = devm_regmap_init_mmio(&pdev->dev, base, &ucs_regmap_config);
> +	if (IS_ERR(ucs->regmap)) {
> +		UCS_ERR(ucs, "map base %pR failed", res);
> +		return PTR_ERR(ucs->regmap);
> +	}
> +	ucs_enable(ucs);
> +
> +	return 0;
> +}
> +
> +static struct xrt_subdev_endpoints xrt_ucs_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_UCS_CONTROL_STATUS },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_subdev_drvdata xrt_ucs_data = {
> +	.xsd_dev_ops = {
> +		.xsd_leaf_call = xrt_ucs_leaf_call,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_ucs_table[] = {
> +	{ XRT_UCS, (kernel_ulong_t)&xrt_ucs_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_ucs_driver = {
> +	.driver = {
> +		.name = XRT_UCS,
> +	},
> +	.probe = ucs_probe,
> +	.id_table = xrt_ucs_table,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_UCS, ucs);

