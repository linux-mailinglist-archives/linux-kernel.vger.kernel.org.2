Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38B630A96A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhBAON6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:13:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231849AbhBAONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612188748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2E0S/Z5gWA3ccqYSTotfrJuoUUJBHoeOURjhC0S/Jk=;
        b=gGSSt9If2vO+t5ejydiQc/7GkBKT+VZmq7iY102/ixbH8cEITinHodF+E68q8zCj9YGYRJ
        Cx2mMDuqKdW33TS0IwOkWP7QgJVcmurLcmjNX+l+Emmk5OkyQai5hdgA6CU6vd0yRhqzPj
        9E/bwm/HA/Dg7HE3guVpS/3U1MBLxoo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-lRv_JJWsOsS2UfQlXfVSug-1; Mon, 01 Feb 2021 09:12:24 -0500
X-MC-Unique: lRv_JJWsOsS2UfQlXfVSug-1
Received: by mail-qv1-f71.google.com with SMTP id k20so11277352qvm.16
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=N2E0S/Z5gWA3ccqYSTotfrJuoUUJBHoeOURjhC0S/Jk=;
        b=FbqHYPUkwZgeDtoQPo4MI3/okRV+4itaGsJnx/5AwYfDPAsaAA14b4ACQjnrLPXpcr
         8nU6LVM3GIcv4JDiYte4gKjkkC2VGNKI2p++thFNDPu6RfCvp8OzMAkDm0OHRwV0DQiy
         /BVtOd5cSobEdNEA9h1YtSimICJF1Eeym2RFjQk0G+iqgsUYbHKw9vMHMc81nCevy2Ug
         k3oCiNm3boxs8wFjUPhIAfVj8tMrAYUu9mwrK+u4Uev5/4cyLxft+0jpV8M4wUDDg5xX
         w5Jgx2PyOULz2sT09RZff7MsHEaxkBhApc0feQzVTa0yfEHiin49yyk0vCjSuV2cnIGW
         gDXg==
X-Gm-Message-State: AOAM530PZtHhhlt7ZZrY+GPtnGaKFUOJ4O+5Q4Dcz02m9DL/hUB4zc+G
        PwCgTwWrKoTVbVBolfdv467qBqtIJFIobrjTa/a4LpKSVnBVis2ojghJa8+PDDFPFkJSF6sHiDC
        PLId5pFoeLI9elPYEbgVdoWD6
X-Received: by 2002:ad4:468c:: with SMTP id bq12mr15285037qvb.11.1612188744313;
        Mon, 01 Feb 2021 06:12:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWcu7QMcVQZmTNtkvnH7tBDsAShHJwxhwlpfixBQHLwHGuCEV7aJwrUjirGWN/Nl9k6PIwtA==
X-Received: by 2002:ad4:468c:: with SMTP id bq12mr15285009qvb.11.1612188744038;
        Mon, 01 Feb 2021 06:12:24 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b17sm484952qkh.57.2021.02.01.06.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 06:12:23 -0800 (PST)
Subject: Re: [PATCH v10 1/2] uio: uio_dfl: add userspace i/o driver for DFL
 bus
To:     Xu Yilun <yilun.xu@intel.com>, gregkh@linuxfoundation.org,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, hao.wu@intel.com
References: <1612157883-18616-1-git-send-email-yilun.xu@intel.com>
 <1612157883-18616-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d100069d-c953-209c-9e74-a336c644887b@redhat.com>
Date:   Mon, 1 Feb 2021 06:12:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612157883-18616-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/31/21 9:38 PM, Xu Yilun wrote:
> This patch supports the DFL drivers be written in userspace. This is
> realized by exposing the userspace I/O device interfaces.
>
> The driver now only binds the ether group feature, which has no irq. So
> the irq support is not implemented yet.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v9: switch to add a uio driver in drivers/uio
> v10: add the source file in MAINTAINERS
>      more descriptive Kconfig header
>      add detailed path for opae uio example
> ---
>  MAINTAINERS           |  1 +
>  drivers/uio/Kconfig   | 17 +++++++++++++
>  drivers/uio/Makefile  |  1 +
>  drivers/uio/uio_dfl.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 85 insertions(+)
>  create mode 100644 drivers/uio/uio_dfl.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 147d1d9..4d01a21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6943,6 +6943,7 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-dfl*
>  F:	Documentation/fpga/dfl.rst
>  F:	drivers/fpga/dfl*
> +F:	drivers/uio/uio_dfl.c
>  F:	include/linux/dfl.h
>  F:	include/uapi/linux/fpga-dfl.h
>  
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 202ee81..5531f3a 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -165,4 +165,21 @@ config UIO_HV_GENERIC
>  	  to network and storage devices from userspace.
>  
>  	  If you compile this as a module, it will be called uio_hv_generic.
> +
> +config UIO_DFL
> +	tristate "Generic driver for DFL (Device Feature List) bus"
> +	depends on FPGA_DFL
> +	help
> +	  Generic DFL (Device Feature List) driver for Userspace I/O devices.
> +	  It is useful to provide direct access to DFL devices from userspace.
> +	  A sample userspace application using this driver is available for
> +	  download in a git repository:
> +
> +	    git clone https://github.com/OPAE/opae-sdk.git
> +
> +	  It could be found at:
> +
> +	    opae-sdk/tools/libopaeuio/

Yes, it is there.  Thanks!

Reviewed-by: Tom Rix <trix@redhat.com>

> +
> +	  If you compile this as a module, it will be called uio_dfl.
>  endif
> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> index c285dd2..f2f416a1 100644
> --- a/drivers/uio/Makefile
> +++ b/drivers/uio/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
>  obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
>  obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
>  obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
> +obj-$(CONFIG_UIO_DFL)	+= uio_dfl.o
> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> new file mode 100644
> index 0000000..89c0fc7
> --- /dev/null
> +++ b/drivers/uio/uio_dfl.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic DFL driver for Userspace I/O devicess
> + *
> + * Copyright (C) 2021 Intel Corporation, Inc.
> + */
> +#include <linux/dfl.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/uio_driver.h>
> +
> +#define DRIVER_NAME "uio_dfl"
> +
> +static int uio_dfl_probe(struct dfl_device *ddev)
> +{
> +	struct resource *r = &ddev->mmio_res;
> +	struct device *dev = &ddev->dev;
> +	struct uio_info *uioinfo;
> +	struct uio_mem *uiomem;
> +	int ret;
> +
> +	uioinfo = devm_kzalloc(dev, sizeof(struct uio_info), GFP_KERNEL);
> +	if (!uioinfo)
> +		return -ENOMEM;
> +
> +	uioinfo->name = DRIVER_NAME;
> +	uioinfo->version = "0";
> +
> +	uiomem = &uioinfo->mem[0];
> +	uiomem->memtype = UIO_MEM_PHYS;
> +	uiomem->addr = r->start & PAGE_MASK;
> +	uiomem->offs = r->start & ~PAGE_MASK;
> +	uiomem->size = (uiomem->offs + resource_size(r)
> +			+ PAGE_SIZE - 1) & PAGE_MASK;
> +	uiomem->name = r->name;
> +
> +	/* Irq is yet to be supported */
> +	uioinfo->irq = UIO_IRQ_NONE;
> +
> +	ret = devm_uio_register_device(dev, uioinfo);
> +	if (ret)
> +		dev_err(dev, "unable to register uio device\n");
> +
> +	return ret;
> +}
> +
> +#define FME_FEATURE_ID_ETH_GROUP	0x10
> +
> +static const struct dfl_device_id uio_dfl_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> +
> +static struct dfl_driver uio_dfl_driver = {
> +	.drv = {
> +		.name = DRIVER_NAME,
> +	},
> +	.id_table	= uio_dfl_ids,
> +	.probe		= uio_dfl_probe,
> +};
> +module_dfl_driver(uio_dfl_driver);
> +
> +MODULE_DESCRIPTION("Generic DFL driver for Userspace I/O devices");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");

