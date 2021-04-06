Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71BA355D01
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347163AbhDFUhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245480AbhDFUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617741454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHiiDAoRDKlSpF5W2fiqmIZUSD2zT3WhpbrUrOmekT8=;
        b=hip1QzYAFvzeK6yy4OpikIXyWvyJ9NU91Fj1ttO7D664C0hFnoQTVOo+lH8B2uhkc8/JbX
        U+iJUCz66M8rssqK0iPGH8QDR9KY/rtNthfd0YqDHUgi4eZMRC0e07lNI8b28+RfVQkgMi
        mKLvow0UJZDV+j8+aUyWtx69s7NmREs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-nLf0dPkEP_mzf_IBr1vZMg-1; Tue, 06 Apr 2021 16:37:33 -0400
X-MC-Unique: nLf0dPkEP_mzf_IBr1vZMg-1
Received: by mail-qt1-f200.google.com with SMTP id t18so10874620qtw.15
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 13:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SHiiDAoRDKlSpF5W2fiqmIZUSD2zT3WhpbrUrOmekT8=;
        b=IRX80XyyulFLOE3aCsBoH3+xcDxl99BDI5H9ttS+fywmHjKnEYVgu32z9urhHMpFon
         f+iVCzzE1zalFG1HwjZBGao3USBFi+eM5wcwXE/VcQGmSv7UJjMZjRxm6KtDvD1u1Ihn
         W3CEI6iKN/HbfGZ/hdHVG4Ci18xWizTGBDmtP/5Laox3m8op0XvsZ8XrLt31T1eA0x0l
         9Q/xAGcNAUKdnuI4fF/jMLaSKRAevQBDoTR1KoiKeOj/J54W391K+R/UDttyFkmmZ2Z2
         1ioHDHnZP27ZapYtiioxFhf2m3cCP6k850HWy7VDA+60KEkGjDeAeF0a6BUOZEGIesrQ
         jjBQ==
X-Gm-Message-State: AOAM532C5Jie1O2ET7qbNbNrMX6jMH4SsSVSOIpoud+CVJvyjsIKKW31
        dLBw5pg9rvpnpz0QPQGPORzKusj9cbwErqLkHKFcVZ3OJMnHDj5ynPHJ3yjTKSmebHAdp3ncbBW
        PUPSepwlAWoAwtp9r5Xw9G38A
X-Received: by 2002:a37:886:: with SMTP id 128mr32868770qki.430.1617741452686;
        Tue, 06 Apr 2021 13:37:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLZhl4CZ/pjvsSTD4KFAyWmQlrZ0/IFXc0KJjTWwwbI8yN5HySIRFXvGe6WMCCxmPU46vnmQ==
X-Received: by 2002:a37:886:: with SMTP id 128mr32868749qki.430.1617741452457;
        Tue, 06 Apr 2021 13:37:32 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c17sm14751116qtd.71.2021.04.06.13.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 13:37:31 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 18/20] fpga: xrt: DDR calibration platform
 driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-19-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e529c014-f2d5-a0d2-dba9-4325af41c425@redhat.com>
Date:   Tue, 6 Apr 2021 13:37:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-19-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/21 10:29 PM, Lizhi Hou wrote:
> Add DDR calibration driver. DDR calibration is a hardware function
> discovered by walking firmware metadata. A platform device node will
> be created for it. Hardware provides DDR calibration status through
> this function.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +++
>   drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 226 ++++++++++++++++++
ok
>   2 files changed, 254 insertions(+)
>   create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/ddr_calibration.h b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
> new file mode 100644
> index 000000000000..878740c26ca2
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_DDR_CALIBRATION_H_
> +#define _XRT_DDR_CALIBRATION_H_
> +
> +#include "xleaf.h"
> +#include <linux/xrt/xclbin.h>
> +
> +/*
> + * Memory calibration driver leaf calls.
> + */
> +enum xrt_calib_results {
> +	XRT_CALIB_UNKNOWN = 0,
ok
> +	XRT_CALIB_SUCCEEDED,
> +	XRT_CALIB_FAILED,
> +};
> +
> +enum xrt_calib_leaf_cmd {
> +	XRT_CALIB_RESULT = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +};
> +
> +#endif	/* _XRT_DDR_CALIBRATION_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
> new file mode 100644
> index 000000000000..5a9fa82946cb
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA memory calibration driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * memory calibration
> + *
> + * Authors:
> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
> + */
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +#include "xclbin-helper.h"
> +#include "metadata.h"
> +#include "xleaf/ddr_calibration.h"
> +
> +#define XRT_CALIB	"xrt_calib"
> +
> +#define XRT_CALIB_STATUS_REG		0
> +#define XRT_CALIB_READ_RETRIES		20
> +#define XRT_CALIB_READ_INTERVAL		500 /* ms */
> +
> +static const struct regmap_config calib_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x1000,
ok
> +};
> +
> +struct calib_cache {
> +	struct list_head	link;
> +	const char		*ep_name;
> +	char			*data;
> +	u32			data_size;
> +};
> +
> +struct calib {
> +	struct platform_device	*pdev;
> +	struct regmap		*regmap;
> +	struct mutex		lock; /* calibration dev lock */
> +	struct list_head	cache_list;
> +	u32			cache_num;
> +	enum xrt_calib_results	result;
> +};
> +
> +static void __calib_cache_clean_nolock(struct calib *calib)
ok
> +{
> +	struct calib_cache *cache, *temp;
> +
> +	list_for_each_entry_safe(cache, temp, &calib->cache_list, link) {
> +		vfree(cache->data);
> +		list_del(&cache->link);
> +		vfree(cache);
> +	}
> +	calib->cache_num = 0;
> +}
> +
> +static void calib_cache_clean(struct calib *calib)
> +{
> +	mutex_lock(&calib->lock);
> +	__calib_cache_clean_nolock(calib);
> +	mutex_unlock(&calib->lock);
> +}
> +
> +static int calib_calibration(struct calib *calib)
> +{
> +	u32 times = XRT_CALIB_READ_RETRIES;
ok
> +	u32 status;
> +	int ret;
> +
> +	while (times != 0) {
> +		ret = regmap_read(calib->regmap, XRT_CALIB_STATUS_REG, &status);
> +		if (ret) {
> +			xrt_err(calib->pdev, "failed to read status reg %d", ret);
> +			return ret;
> +		}
> +
> +		if (status & BIT(0))
> +			break;
> +		msleep(XRT_CALIB_READ_INTERVAL);

ok

Reviewed-by: Tom Rix <trix@redhat.com>

> +		times--;
> +	}
> +
> +	if (!times) {
> +		xrt_err(calib->pdev,
> +			"MIG calibration timeout after bitstream download");
> +		return -ETIMEDOUT;
> +	}
> +
> +	xrt_info(calib->pdev, "took %dms", (XRT_CALIB_READ_RETRIES - times) *
> +		 XRT_CALIB_READ_INTERVAL);
> +	return 0;
> +}
> +
> +static void xrt_calib_event_cb(struct platform_device *pdev, void *arg)
> +{
> +	struct calib *calib = platform_get_drvdata(pdev);
> +	struct xrt_event *evt = (struct xrt_event *)arg;
> +	enum xrt_events e = evt->xe_evt;
> +	enum xrt_subdev_id id;
> +	int ret;
> +
> +	id = evt->xe_subdev.xevt_subdev_id;
> +
> +	switch (e) {
> +	case XRT_EVENT_POST_CREATION:
> +		if (id == XRT_SUBDEV_UCS) {
> +			ret = calib_calibration(calib);
> +			if (ret)
> +				calib->result = XRT_CALIB_FAILED;
> +			else
> +				calib->result = XRT_CALIB_SUCCEEDED;
> +		}
> +		break;
> +	default:
> +		xrt_dbg(pdev, "ignored event %d", e);
> +		break;
> +	}
> +}
> +
> +static int xrt_calib_remove(struct platform_device *pdev)
> +{
> +	struct calib *calib = platform_get_drvdata(pdev);
> +
> +	calib_cache_clean(calib);
> +
> +	return 0;
> +}
> +
> +static int xrt_calib_probe(struct platform_device *pdev)
> +{
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +	struct calib *calib;
> +	int err = 0;
> +
> +	calib = devm_kzalloc(&pdev->dev, sizeof(*calib), GFP_KERNEL);
> +	if (!calib)
> +		return -ENOMEM;
> +
> +	calib->pdev = pdev;
> +	platform_set_drvdata(pdev, calib);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		err = -EINVAL;
> +		goto failed;
> +	}
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base)) {
> +		err = PTR_ERR(base);
> +		goto failed;
> +	}
> +
> +	calib->regmap = devm_regmap_init_mmio(&pdev->dev, base, &calib_regmap_config);
> +	if (IS_ERR(calib->regmap)) {
> +		xrt_err(pdev, "Map iomem failed");
> +		err = PTR_ERR(calib->regmap);
> +		goto failed;
> +	}
> +
> +	mutex_init(&calib->lock);
> +	INIT_LIST_HEAD(&calib->cache_list);
> +
> +	return 0;
> +
> +failed:
> +	return err;
> +}
> +
> +static int
> +xrt_calib_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	struct calib *calib = platform_get_drvdata(pdev);
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		xrt_calib_event_cb(pdev, arg);
> +		break;
> +	case XRT_CALIB_RESULT: {
> +		enum xrt_calib_results *r = (enum xrt_calib_results *)arg;
> +		*r = calib->result;
> +		break;
> +	}
> +	default:
> +		xrt_err(pdev, "unsupported cmd %d", cmd);
> +		ret = -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static struct xrt_subdev_endpoints xrt_calib_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_DDR_CALIB },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_subdev_drvdata xrt_calib_data = {
> +	.xsd_dev_ops = {
> +		.xsd_leaf_call = xrt_calib_leaf_call,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_calib_table[] = {
> +	{ XRT_CALIB, (kernel_ulong_t)&xrt_calib_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_calib_driver = {
> +	.driver = {
> +		.name = XRT_CALIB,
> +	},
> +	.probe = xrt_calib_probe,
> +	.remove = xrt_calib_remove,
> +	.id_table = xrt_calib_table,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_CALIB, calib);

