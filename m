Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5445C40AA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhINJIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhINJIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:08:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24B7D60E97;
        Tue, 14 Sep 2021 09:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631610404;
        bh=OnDotOuyZsIWKrlx4LL2rGeBX9pKyXT9dbs5ngQNNEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewsZG7p4S3OsAQ+0UVK6lj2I3cGcHi+oBaeFUQPlIIO5yayr5oh9hoLITDKtmz0NG
         gq2y/AbEiQ6OapsHiTA3lyTGldZY1uPJf7RSsxRK8GtzZn8yw38lm3Xea7e5T8rwLj
         4pv7PZ0RUCBh9du96NAm3sjs2ow1RIQFvi8xkjJg=
Date:   Tue, 14 Sep 2021 11:06:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH misc] misc: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <YUBmIWU6HwIjjeXa@kroah.com>
References: <1630608353-7606-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630608353-7606-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 02:45:53PM -0400, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx families
> of timing and synchronization devices.It will be used by Renesas PTP Clock
> Manager for Linux (pcm4l) software to provide support to GNSS assisted
> partial timing support (APTS) and other networking timing functions.
> 
> Current version provides kernel API's to support the following functions
> -set combomode to enable SYNCE clock support
> -read dpll's state to determine if the dpll is locked to the GNSS channel
> -read dpll's ffo (fractional frequency offset) in ppqt
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/misc/Kconfig      |   9 ++
>  drivers/misc/Makefile     |   2 +
>  drivers/misc/rsmu_cdev.c  | 239 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/misc/rsmu_cdev.h  |  77 +++++++++++++++
>  drivers/misc/rsmu_cm.c    | 164 +++++++++++++++++++++++++++++++
>  drivers/misc/rsmu_sabre.c | 133 ++++++++++++++++++++++++++

If you make this all one .c file, the .h file can go away and it will be
much simpler in the end.  And will get rid of the global symbols.

>  include/uapi/linux/rsmu.h |  66 +++++++++++++
>  7 files changed, 690 insertions(+)
>  create mode 100644 drivers/misc/rsmu_cdev.c
>  create mode 100644 drivers/misc/rsmu_cdev.h
>  create mode 100644 drivers/misc/rsmu_cm.c
>  create mode 100644 drivers/misc/rsmu_sabre.c
>  create mode 100644 include/uapi/linux/rsmu.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 85ba901..6ed5a18 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -469,6 +469,15 @@ config HISI_HIKEY_USB
>  	  switching between the dual-role USB-C port and the USB-A host ports
>  	  using only one USB controller.
>  
> +config RSMU
> +	tristate "Renesas Synchronization Management Unit (SMU)"
> +	help
> +	  This option enables support for the IDT ClockMatrix(TM) and 82P33xxx
> +	  families of timing and synchronization devices. It will be used by
> +	  Renesas PTP Clock Manager for Linux (pcm4l) software to provide support
> +	  for GNSS assisted partial timing support (APTS) and other networking
> +	  timing functions.

No driver name listed?

> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index a086197..bde748d 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -59,3 +59,5 @@ obj-$(CONFIG_UACCE)		+= uacce/
>  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>  obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
> +rsmu-objs			:= rsmu_cdev.o rsmu_cm.o rsmu_sabre.o
> +obj-$(CONFIG_RSMU)		+= rsmu.o

Just one .c file please.

> diff --git a/drivers/misc/rsmu_cdev.c b/drivers/misc/rsmu_cdev.c
> new file mode 100644
> index 0000000..8e856a6
> --- /dev/null
> +++ b/drivers/misc/rsmu_cdev.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0+

Are you sure about "+"?  I have to ask.

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

Are you sure about that date?

> + */
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
> +static DEFINE_IDA(rsmu_cdev_map);
> +
> +static struct rsmu_ops *ops_array[] = {
> +	[0] = &cm_ops,
> +	[1] = &sabre_ops,

0 and 1 don't define much.  Why are they needed?

No NULL at the end of the list?


> +};
> +
> +static int
> +rsmu_set_combomode(struct rsmu_cdev *rsmu, void __user *arg)
> +{
> +	struct rsmu_ops *ops = rsmu->ops;
> +	struct rsmu_combomode mode;
> +	int err;
> +
> +	if (copy_from_user(&mode, arg, sizeof(mode)))
> +		return -EFAULT;
> +
> +	if (ops->set_combomode == NULL)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(rsmu->lock);
> +	err = ops->set_combomode(rsmu, mode.dpll, mode.mode);

No error checking of the userspace values?

> +	mutex_unlock(rsmu->lock);
> +
> +	return err;
> +}
> +
> +static int
> +rsmu_get_dpll_state(struct rsmu_cdev *rsmu, void __user *arg)
> +{
> +	struct rsmu_ops *ops = rsmu->ops;
> +	struct rsmu_get_state state_request;
> +	u8 state;
> +	int err;
> +
> +	if (copy_from_user(&state_request, arg, sizeof(state_request)))
> +		return -EFAULT;
> +
> +	if (ops->get_dpll_state == NULL)
> +		return -EOPNOTSUPP;

No error checking of the userspace values?

> +
> +	mutex_lock(rsmu->lock);
> +	err = ops->get_dpll_state(rsmu, state_request.dpll, &state);
> +	mutex_unlock(rsmu->lock);
> +
> +	state_request.state = state;
> +	if (copy_to_user(arg, &state_request, sizeof(state_request)))
> +		return -EFAULT;
> +
> +	return err;
> +}
> +
> +static int
> +rsmu_get_dpll_ffo(struct rsmu_cdev *rsmu, void __user *arg)
> +{
> +	struct rsmu_ops *ops = rsmu->ops;
> +	struct rsmu_get_ffo ffo_request;
> +	int err;
> +
> +	if (copy_from_user(&ffo_request, arg, sizeof(ffo_request)))
> +		return -EFAULT;
> +
> +	if (ops->get_dpll_ffo == NULL)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(rsmu->lock);
> +	err = ops->get_dpll_ffo(rsmu, ffo_request.dpll, &ffo_request);

Again, no checking of the userspace values?

> +	mutex_unlock(rsmu->lock);
> +
> +	if (copy_to_user(arg, &ffo_request, sizeof(ffo_request)))
> +		return -EFAULT;
> +
> +	return err;
> +}
> +
> +static struct rsmu_cdev *file2rsmu(struct file *file)
> +{
> +	return container_of(file->private_data, struct rsmu_cdev, miscdev);
> +}
> +
> +static long
> +rsmu_ioctl(struct file *fptr, unsigned int cmd, unsigned long data)
> +{
> +	struct rsmu_cdev *rsmu = file2rsmu(fptr);
> +	void __user *arg = (void __user *)data;
> +	int err = 0;
> +
> +	switch (cmd) {
> +	case RSMU_SET_COMBOMODE:
> +		err = rsmu_set_combomode(rsmu, arg);
> +		break;
> +	case RSMU_GET_STATE:
> +		err = rsmu_get_dpll_state(rsmu, arg);
> +		break;
> +	case RSMU_GET_FFO:
> +		err = rsmu_get_dpll_ffo(rsmu, arg);
> +		break;
> +	default:
> +		/* Should not get here */
> +		dev_err(rsmu->dev, "Undefined RSMU IOCTL");

Do not allow userspace to flood the kernel log with messages like this.

> +		err = -EINVAL;

Wrong value.

> +		break;
> +	}
> +
> +	return err;
> +}

What userspace tool is making these ioctl calls?

> +
> +static long rsmu_compat_ioctl(struct file *fptr, unsigned int cmd,
> +			      unsigned long data)
> +{
> +	return rsmu_ioctl(fptr, cmd, data);
> +}
> +

Why is the compat ioctl needed at all?

> +static const struct file_operations rsmu_fops = {
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = rsmu_ioctl,
> +	.compat_ioctl =	rsmu_compat_ioctl,
> +};
> +
> +static int rsmu_init_ops(struct rsmu_cdev *rsmu)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ops_array); i++)
> +		if (ops_array[i]->type == rsmu->type)
> +			break;
> +
> +	if (i == ARRAY_SIZE(ops_array))
> +		return -EINVAL;
> +
> +	rsmu->ops = ops_array[i];
> +	return 0;
> +}
> +
> +static int
> +rsmu_probe(struct platform_device *pdev)
> +{
> +	struct rsmu_ddata *ddata = dev_get_drvdata(pdev->dev.parent);
> +	struct rsmu_cdev *rsmu;
> +	int err;
> +
> +	rsmu = devm_kzalloc(&pdev->dev, sizeof(*rsmu), GFP_KERNEL);
> +	if (!rsmu)
> +		return -ENOMEM;
> +
> +	/* Save driver private data */
> +	platform_set_drvdata(pdev, rsmu);
> +
> +	rsmu->dev = &pdev->dev;
> +	rsmu->mfd = pdev->dev.parent;
> +	rsmu->type = ddata->type;
> +	rsmu->lock = &ddata->lock;
> +	rsmu->regmap = ddata->regmap;
> +	rsmu->index = ida_simple_get(&rsmu_cdev_map, 0, MINORMASK + 1, GFP_KERNEL);
> +	if (rsmu->index < 0) {
> +		dev_err(rsmu->dev, "Unable to get index %d\n", rsmu->index);
> +		return rsmu->index;
> +	}
> +	snprintf(rsmu->name, sizeof(rsmu->name), "rsmu%d", rsmu->index);
> +
> +	err = rsmu_init_ops(rsmu);
> +	if (err) {
> +		dev_err(rsmu->dev, "Unknown SMU type %d", rsmu->type);
> +		ida_simple_remove(&rsmu_cdev_map, rsmu->index);
> +		return err;
> +	}
> +
> +	/* Initialize and register the miscdev */
> +	rsmu->miscdev.minor = MISC_DYNAMIC_MINOR;
> +	rsmu->miscdev.fops = &rsmu_fops;
> +	rsmu->miscdev.name = rsmu->name;
> +	err = misc_register(&rsmu->miscdev);
> +	if (err) {
> +		dev_err(rsmu->dev, "Unable to register device\n");
> +		ida_simple_remove(&rsmu_cdev_map, rsmu->index);
> +		return -ENODEV;
> +	}
> +
> +	dev_info(rsmu->dev, "Probe %s successful\n", rsmu->name);

When drivers work, they are totally quiet.  Please remove.

> +	return 0;
> +}
> +
> +static int
> +rsmu_remove(struct platform_device *pdev)
> +{
> +	struct rsmu_cdev *rsmu = platform_get_drvdata(pdev);
> +
> +	misc_deregister(&rsmu->miscdev);
> +	ida_simple_remove(&rsmu_cdev_map, rsmu->index);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id rsmu_id_table[] = {
> +	{ "8a3400x-cdev", RSMU_CM},
> +	{ "82p33x1x-cdev", RSMU_SABRE},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, rsmu_id_table);
> +
> +static struct platform_driver rsmu_driver = {
> +	.driver = {
> +		.name = "rsmu-cdev",
> +	},
> +	.probe = rsmu_probe,
> +	.remove =  rsmu_remove,
> +	.id_table = rsmu_id_table,
> +};
> +
> +module_platform_driver(rsmu_driver);
> +
> +MODULE_DESCRIPTION("Renesas SMU character device driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/misc/rsmu_cdev.h b/drivers/misc/rsmu_cdev.h
> new file mode 100644
> index 0000000..d67f71a
> --- /dev/null
> +++ b/drivers/misc/rsmu_cdev.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * This driver is developed for the IDT ClockMatrix(TM) of
> + * timing and synchronization devices.
> + *
> + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
> + */
> +#ifndef __LINUX_RSMU_CDEV_H
> +#define __LINUX_RSMU_CDEV_H
> +
> +#include <linux/miscdevice.h>
> +#include <linux/regmap.h>
> +
> +struct rsmu_ops;
> +
> +/**
> + * struct rsmu_cdev - Driver data for RSMU character device
> + * @name: rsmu device name as rsmu[index]
> + * @dev: pointer to device
> + * @mfd: pointer to MFD device
> + * @miscdev: character device handle
> + * @regmap: I2C/SPI regmap handle
> + * @lock: mutex to protect operations from being interrupted
> + * @type: rsmu device type, passed through platform data
> + * @ops: rsmu device methods
> + * @index: rsmu device index
> + */
> +struct rsmu_cdev {
> +	char name[16];
> +	struct device *dev;

What device is this pointing to?

> +	struct device *mfd;

What is this for?

> +	struct miscdevice miscdev;
> +	struct regmap *regmap;
> +	struct mutex *lock;
> +	enum rsmu_type type;
> +	struct rsmu_ops *ops;
> +	int index;
> +};
> +
> +/* Get dpll ffo (fractional frequency offset) in ppqt*/

Need a space at the end of your comment string.

> +struct rsmu_get_ffo {
> +	__u8 dpll;
> +	__s64 ffo;
> +};
> +d
> +/*
> + * RSMU IOCTL List
> + */
> +#define RSMU_MAGIC '?'

Where did you get this value from?

Where did you reserve it?

> +
> +/**
> + * @Description

What is this format?  It is not kernel-doc :(

> + * ioctl to set SMU combo mode.Combo mode provides physical layer frequency
> + * support from the Ethernet Equipment Clock to the PTP clock
> + *
> + * @Parameters

Same here and elsewhere in this file.

thanks,

greg k-h
