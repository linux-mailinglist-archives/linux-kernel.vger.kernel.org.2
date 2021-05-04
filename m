Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A83372BA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhEDOIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231366AbhEDOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620137244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNCfx2HNg2pamXkBSR6tbIcoHPzUQydwdiuW7zNcmYo=;
        b=RHvnj0zFj+qTn1E8FCyW2edi/YAz9JTZ3+yBJTyHifwc9yl1Jsf1X3Xc3+dAekBciPNJv0
        6C89yoK+Acw2aQs/blJkBSlpzJFrRmnmz+JwLti60Pl08rrhbYh7dtrGMS/ZYc+A3kBjQi
        KRxs1FBBKLyAx8TlsQ6THqpUam3vZm8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-MitHA5wuMyyq0LZOxf9G-w-1; Tue, 04 May 2021 10:07:23 -0400
X-MC-Unique: MitHA5wuMyyq0LZOxf9G-w-1
Received: by mail-qt1-f198.google.com with SMTP id y10-20020a05622a004ab029019d4ad3437cso3621310qtw.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dNCfx2HNg2pamXkBSR6tbIcoHPzUQydwdiuW7zNcmYo=;
        b=abfJBGfh10wRqNpT1ltNhC0R7gWpZLfWXlPYWk1E/3QBpnidOA8i6tnizFqWd6AgVv
         krhKcipl2+W+dNcitIta4yN0KJ3w+CzKufzzIndpbS6k0/g4qVNBT4ytgszmJxN61rqE
         g6zFnk/gYxVG3Bg0U9EjbtSUJdl1vwcsllXPO3pCFj9mfqZMThLeNw1oRyEQ52GTbTjw
         Wt/O1h43/m+S0YmQPDQIIH9JKzfj9umoU1x7w20XJJWWGW+UEcYir6ZP/ccdGK5ZMec2
         VehbjirpwtN9ZOfphwk/YcAVTCwFKcnCtPEhUxDI6qW3CzXG018uxChizGc+m2tKvK7K
         j8QA==
X-Gm-Message-State: AOAM533AwQU6pmA4ROetSyKq41ZIqUKdRE+b5TfZ5yv/zezwe/Rx8nzV
        FYQuThSdfXu5+3BkuAmhoZplE7NdozfzJXoV93jtemaGrj94g76piBTAVoaSgscRTQz8jqTEsPM
        fnwk7H86SsJuVgPcnXkJpRO98
X-Received: by 2002:a05:620a:4081:: with SMTP id f1mr25067318qko.203.1620137242298;
        Tue, 04 May 2021 07:07:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkOaUeX6QvDaunufWH5831ob6qzPhdvrW4FDXzJBlyFzD3+pmZHlkJwzYOb5HgVIxwd/yeRQ==
X-Received: by 2002:a05:620a:4081:: with SMTP id f1mr25067297qko.203.1620137242075;
        Tue, 04 May 2021 07:07:22 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l71sm11055849qke.27.2021.05.04.07.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:07:21 -0700 (PDT)
Subject: Re: [PATCH V5 XRT Alveo 15/20] fpga: xrt: devctl xrt driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
 <20210427205431.23896-16-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ff3d0caa-73d2-5e38-2ff1-52c1e66224a1@redhat.com>
Date:   Tue, 4 May 2021 07:07:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427205431.23896-16-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/21 1:54 PM, Lizhi Hou wrote:
> Add devctl driver. devctl is a type of hardware function which only has
> few registers to read or write. They are discovered by walking firmware
> metadata. A xrt device node will be created for them.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>

v4 was also ok, please add my Reviwed-by line

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
>   drivers/fpga/xrt/include/xleaf/devctl.h |  40 ++++++
>   drivers/fpga/xrt/lib/xleaf/devctl.c     | 169 ++++++++++++++++++++++++
>   2 files changed, 209 insertions(+)
>   create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/devctl.h b/drivers/fpga/xrt/include/xleaf/devctl.h
> new file mode 100644
> index 000000000000..b97f3b6d9326
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/devctl.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Lizhi Hou <Lizhi.Hou@xilinx.com>
> + */
> +
> +#ifndef _XRT_DEVCTL_H_
> +#define _XRT_DEVCTL_H_
> +
> +#include "xleaf.h"
> +
> +/*
> + * DEVCTL driver leaf calls.
> + */
> +enum xrt_devctl_leaf_cmd {
> +	XRT_DEVCTL_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +};
> +
> +enum xrt_devctl_id {
> +	XRT_DEVCTL_ROM_UUID = 0,
> +	XRT_DEVCTL_DDR_CALIB,
> +	XRT_DEVCTL_GOLDEN_VER,
> +	XRT_DEVCTL_MAX
> +};
> +
> +struct xrt_devctl_rw {
> +	u32	xdr_id;
> +	void	*xdr_buf;
> +	u32	xdr_len;
> +	u32	xdr_offset;
> +};
> +
> +struct xrt_devctl_intf_uuid {
> +	u32	uuid_num;
> +	uuid_t	*uuids;
> +};
> +
> +#endif	/* _XRT_DEVCTL_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/devctl.c b/drivers/fpga/xrt/lib/xleaf/devctl.c
> new file mode 100644
> index 000000000000..fb2122be7e56
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/devctl.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA devctl Driver
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
> +#include "xleaf/devctl.h"
> +
> +#define XRT_DEVCTL "xrt_devctl"
> +
> +struct xrt_name_id {
> +	char *ep_name;
> +	int id;
> +};
> +
> +static struct xrt_name_id name_id[XRT_DEVCTL_MAX] = {
> +	{ XRT_MD_NODE_BLP_ROM, XRT_DEVCTL_ROM_UUID },
> +	{ XRT_MD_NODE_GOLDEN_VER, XRT_DEVCTL_GOLDEN_VER },
> +};
> +
> +XRT_DEFINE_REGMAP_CONFIG(devctl_regmap_config);
> +
> +struct xrt_devctl {
> +	struct xrt_device	*xdev;
> +	struct regmap		*regmap[XRT_DEVCTL_MAX];
> +	ulong			sizes[XRT_DEVCTL_MAX];
> +};
> +
> +static int xrt_devctl_name2id(struct xrt_devctl *devctl, const char *name)
> +{
> +	int i;
> +
> +	for (i = 0; i < XRT_DEVCTL_MAX && name_id[i].ep_name; i++) {
> +		if (!strncmp(name_id[i].ep_name, name, strlen(name_id[i].ep_name) + 1))
> +			return name_id[i].id;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int
> +xrt_devctl_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
> +{
> +	struct xrt_devctl *devctl;
> +	int ret = 0;
> +
> +	devctl = xrt_get_drvdata(xdev);
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		/* Does not handle any event. */
> +		break;
> +	case XRT_DEVCTL_READ: {
> +		struct xrt_devctl_rw *rw_arg = arg;
> +
> +		if (rw_arg->xdr_len & 0x3) {
> +			xrt_err(xdev, "invalid len %d", rw_arg->xdr_len);
> +			return -EINVAL;
> +		}
> +
> +		if (rw_arg->xdr_id >= XRT_DEVCTL_MAX) {
> +			xrt_err(xdev, "invalid id %d", rw_arg->xdr_id);
> +			return -EINVAL;
> +		}
> +
> +		if (!devctl->regmap[rw_arg->xdr_id]) {
> +			xrt_err(xdev, "io not found, id %d",
> +				rw_arg->xdr_id);
> +			return -EINVAL;
> +		}
> +
> +		ret = regmap_bulk_read(devctl->regmap[rw_arg->xdr_id], rw_arg->xdr_offset,
> +				       rw_arg->xdr_buf,
> +				       rw_arg->xdr_len / devctl_regmap_config.reg_stride);
> +		break;
> +	}
> +	default:
> +		xrt_err(xdev, "unsupported cmd %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int xrt_devctl_probe(struct xrt_device *xdev)
> +{
> +	struct xrt_devctl *devctl = NULL;
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +	int i, id, ret = 0;
> +
> +	devctl = devm_kzalloc(&xdev->dev, sizeof(*devctl), GFP_KERNEL);
> +	if (!devctl)
> +		return -ENOMEM;
> +
> +	devctl->xdev = xdev;
> +	xrt_set_drvdata(xdev, devctl);
> +
> +	xrt_info(xdev, "probing...");
> +	for (i = 0, res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
> +	    res;
> +	    res = xrt_get_resource(xdev, IORESOURCE_MEM, ++i)) {
> +		struct regmap_config config = devctl_regmap_config;
> +
> +		id = xrt_devctl_name2id(devctl, res->name);
> +		if (id < 0) {
> +			xrt_err(xdev, "ep %s not found", res->name);
> +			continue;
> +		}
> +		base = devm_ioremap_resource(&xdev->dev, res);
> +		if (IS_ERR(base)) {
> +			ret = PTR_ERR(base);
> +			break;
> +		}
> +		config.max_register = res->end - res->start + 1;
> +		devctl->regmap[id] = devm_regmap_init_mmio(&xdev->dev, base, &config);
> +		if (IS_ERR(devctl->regmap[id])) {
> +			xrt_err(xdev, "map base failed %pR", res);
> +			ret = PTR_ERR(devctl->regmap[id]);
> +			break;
> +		}
> +		devctl->sizes[id] = res->end - res->start + 1;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct xrt_dev_endpoints xrt_devctl_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_dev_ep_names[]) {
> +			/* add name if ep is in same partition */
> +			{ .ep_name = XRT_MD_NODE_BLP_ROM },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{
> +		.xse_names = (struct xrt_dev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_GOLDEN_VER },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	/* adding ep bundle generates devctl device instance */
> +	{ 0 },
> +};
> +
> +static struct xrt_driver xrt_devctl_driver = {
> +	.driver = {
> +		.name = XRT_DEVCTL,
> +	},
> +	.subdev_id = XRT_SUBDEV_DEVCTL,
> +	.endpoints = xrt_devctl_endpoints,
> +	.probe = xrt_devctl_probe,
> +	.leaf_call = xrt_devctl_leaf_call,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(devctl);

