Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5121357375
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354946AbhDGRsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348347AbhDGRsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:48:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBDA561242;
        Wed,  7 Apr 2021 17:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617817670;
        bh=NiZxEUk/B+44bpEG6g8jL+LXg/Sic2IARShT9jBXL20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Sss1GJzUG9AGGEPQA/8pgR1UVW5Jiduo6BU5LarLV7TFbPH8XN/TrDrtCr8Xr6vn
         bDiYQIW3TmnpnXKC2iqOJfXQeAOyV6lKWiwNx8MS5HUuErOqLZtf+VmbBXpj8Tjs6X
         MKA+q6XWwBw75GEBtoDrcQuNo5jWHGEAahg7ZowE=
Date:   Wed, 7 Apr 2021 19:47:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YG3wRJnootNdV0cc@kroah.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:33:35PM -0400, min.li.xe@renesas.com wrote:
> --- /dev/null
> +++ b/drivers/misc/rsmu_cdev.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0+

Do you really meen "+" here?  (sorry, have to ask.)

> +/*
> + * This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx families
> + * of timing and synchronization devices. It will be used by Renesas PTP Clock
> + * Manager for Linux (pcm4l) software to provide support to GNSS assisted
> + * partial timing support (APTS) and other networking timing functions.
> + *
> + * Please note it must work with Renesas MFD driver to access device through
> + * I2C/SPI.
> + *
> + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

You should not need this as it's a driver, so you should only use the
dev_dbg() family of print message functions, no need for pr_*() calls.

> +
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/mfd/rsmu.h>
> +#include <uapi/linux/rsmu.h>
> +#include "rsmu_cdev.h"
> +
> +#define DRIVER_NAME	"rsmu"

KBUILD_MODNAME instead?  But you really only need this in one place, so
no need for it at all, just use KBUILD_MODNAME here:

> +static struct platform_driver rsmu_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,

Right there.

> +	},
> +	.probe = rsmu_probe,
> +	.remove =  rsmu_remove,
> +	.id_table = rsmu_id_table,
> +};
> +
> +static int __init rsmu_init(void)
> +{
> +	int err;
> +
> +	err = platform_driver_register(&rsmu_driver);
> +	if (err < 0)
> +		pr_err("Unabled to register %s platform driver", DRIVER_NAME);
> +
> +	return err;
> +}
> +
> +static void __exit rsmu_exit(void)
> +{
> +	platform_driver_unregister(&rsmu_driver);
> +}
> +
> +module_init(rsmu_init);
> +module_exit(rsmu_exit);

module_platform_driver() instead?

thanks,

greg k-h
