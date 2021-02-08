Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE54D31423E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhBHVuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:50:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235516AbhBHVig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612820228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycwoDuRmQSUAa02t2T1lCK2l3ab7oXwofcurbg2I9u0=;
        b=JQ3ahV2Wu1PGEAvTGC7nz14IRpdEu6v7o5O4s+lVeqHcZ+G4aUe5WMfr6Ur9tWoujF35kX
        Z8V1arTRRyCWug2Dm6GaYY6IcGv0QGLcN0CBDTx2TclMBMRCcKTa+7uvR5MVnyILkdtuwy
        FUD1qX08AM5nkZ9PhsLqv9s5Wf6p23Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-3dm7ma22MG2YxpHTUrRrIg-1; Mon, 08 Feb 2021 16:37:07 -0500
X-MC-Unique: 3dm7ma22MG2YxpHTUrRrIg-1
Received: by mail-qv1-f72.google.com with SMTP id ew14so11597150qvb.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 13:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ycwoDuRmQSUAa02t2T1lCK2l3ab7oXwofcurbg2I9u0=;
        b=GeGunXHWiUv83zMR5R2k15vKg+MPRoAB8f3KNmI/I3aQ09qKzx+fitZFF9ig0ZtCO7
         6TRrpluwt/KFpXc4UFbSUU95u05ibQ3GBMyFZcPdYC6ZXUTdTxNYPaCFeO3OVFBq/Swy
         UDjLA+vZKswJhxaVbXUnVHNm/cubzz9nlypKH/4/0HQ7lFLHmrfoSgSpHOfetRi1wrV3
         josz5t1XLfjw7pkLAlK8nyICBDxnDfDDrX04vLim2lWEgN0le+CI4SjJjxcMaElqDfIV
         ONtyZvLxsRB59XK8pmPlgqtNCuGh8uC5DJmfE7trK2yu+fHm1gRF6MvBOVgGVOMvX0QD
         BHLw==
X-Gm-Message-State: AOAM532qz3onmD+3uS8iQMBSw42pUG2nBcfDZCwYXNDkFd7S5P0cP17y
        sWRA5ZyKjjay7MBXUjxkRsG7JsnJXo9V5wVnmeh49NT6uy0ipEUWoTUWFYok1TurKlBscHbotzP
        jigQyFHO5yTi0zGSCIZcLxThG
X-Received: by 2002:a37:5ac6:: with SMTP id o189mr19494966qkb.96.1612820225064;
        Mon, 08 Feb 2021 13:37:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5GchTOU3t6fseJcEECu+jS0BmO8fmB4mOulTf4QlzBCOjAv4JWxEpF8n7UZZEJd6pOsbMtA==
X-Received: by 2002:a37:5ac6:: with SMTP id o189mr19494953qkb.96.1612820224888;
        Mon, 08 Feb 2021 13:37:04 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h8sm10824699qtp.56.2021.02.08.13.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 13:37:04 -0800 (PST)
Subject: Re: [PATCH v9 1/2] uio: uio_dfl: add userspace i/o driver for DFL bus
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1611564563-9665-1-git-send-email-yilun.xu@intel.com>
 <1611564563-9665-2-git-send-email-yilun.xu@intel.com>
 <e9bb1ff8-f630-f1a3-985c-7e51369a733f@redhat.com>
 <YA98/8r+yOCurHAJ@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <03ffff75-31d6-24c5-03bf-190a64ab9627@redhat.com>
Date:   Mon, 8 Feb 2021 13:37:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YA98/8r+yOCurHAJ@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/21 6:22 PM, Moritz Fischer wrote:
> On Mon, Jan 25, 2021 at 11:00:38AM -0800, Tom Rix wrote:
Snip
>>
>>> +	depends on FPGA_DFL
>>> +	help
>>> +	  Generic DFL (Device Feature List) driver for Userspace I/O devices.
>>> +	  It is useful to provide direct access to DFL devices from userspace.
>>> +	  A sample userspace application using this driver is available for
>>> +	  download in a git repository:
>>> +
>>> +	    git clone https://github.com/OPAE/opae-sdk.git
>>> +
>>> +	  If you compile this as a module, it will be called uio_dfl.
> I'm not sure KConfig is the right place for this.

More than half of the other configs do this.

ex/

config UIO_MF624
    tristate "Humusoft MF624 DAQ PCI card driver"
    depends on PCI
    help
      Userspace I/O interface for the Humusoft MF624 PCI card.
      A sample userspace application using this driver is available
      (among other MF624 related information and software components)
      for download in a git repository:

        git clone git://rtime.felk.cvut.cz/mf6xx.git

      If you compile this as a module, it will be called uio_mf624.

Tom

>> opae-sdk is pretty large and uncovered in the Documentation/fpga/dfl.rst.
>>
>> Where in opae-sdk is this example ?
>>
>> If you can point me at the example, I will turn it into a selftest.
>>
>> Tom
>>
>>>  endif
>>> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
>>> index c285dd2..f2f416a1 100644
>>> --- a/drivers/uio/Makefile
>>> +++ b/drivers/uio/Makefile
>>> @@ -11,3 +11,4 @@ obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
>>>  obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
>>>  obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
>>>  obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
>>> +obj-$(CONFIG_UIO_DFL)	+= uio_dfl.o
>>> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
>>> new file mode 100644
>>> index 0000000..89c0fc7
>>> --- /dev/null
>>> +++ b/drivers/uio/uio_dfl.c
>>> @@ -0,0 +1,66 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Generic DFL driver for Userspace I/O devicess
>>> + *
>>> + * Copyright (C) 2021 Intel Corporation, Inc.
>>> + */
>>> +#include <linux/dfl.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/module.h>
>>> +#include <linux/uio_driver.h>
>>> +
>>> +#define DRIVER_NAME "uio_dfl"
>>> +
>>> +static int uio_dfl_probe(struct dfl_device *ddev)
>>> +{
>>> +	struct resource *r = &ddev->mmio_res;
>>> +	struct device *dev = &ddev->dev;
>>> +	struct uio_info *uioinfo;
>>> +	struct uio_mem *uiomem;
>>> +	int ret;
>>> +
>>> +	uioinfo = devm_kzalloc(dev, sizeof(struct uio_info), GFP_KERNEL);
>>> +	if (!uioinfo)
>>> +		return -ENOMEM;
>>> +
>>> +	uioinfo->name = DRIVER_NAME;
>>> +	uioinfo->version = "0";
>>> +
>>> +	uiomem = &uioinfo->mem[0];
>>> +	uiomem->memtype = UIO_MEM_PHYS;
>>> +	uiomem->addr = r->start & PAGE_MASK;
>>> +	uiomem->offs = r->start & ~PAGE_MASK;
>>> +	uiomem->size = (uiomem->offs + resource_size(r)
>>> +			+ PAGE_SIZE - 1) & PAGE_MASK;
>>> +	uiomem->name = r->name;
>>> +
>>> +	/* Irq is yet to be supported */
>>> +	uioinfo->irq = UIO_IRQ_NONE;
>>> +
>>> +	ret = devm_uio_register_device(dev, uioinfo);
>>> +	if (ret)
>>> +		dev_err(dev, "unable to register uio device\n");
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +#define FME_FEATURE_ID_ETH_GROUP	0x10
>>> +
>>> +static const struct dfl_device_id uio_dfl_ids[] = {
>>> +	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
>>> +
>>> +static struct dfl_driver uio_dfl_driver = {
>>> +	.drv = {
>>> +		.name = DRIVER_NAME,
>>> +	},
>>> +	.id_table	= uio_dfl_ids,
>>> +	.probe		= uio_dfl_probe,
>>> +};
>>> +module_dfl_driver(uio_dfl_driver);
>>> +
>>> +MODULE_DESCRIPTION("Generic DFL driver for Userspace I/O devices");
>>> +MODULE_AUTHOR("Intel Corporation");
>>> +MODULE_LICENSE("GPL v2");

