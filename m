Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249E030DE92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhBCPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234535AbhBCPpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:45:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C06FE64E41;
        Wed,  3 Feb 2021 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612367102;
        bh=Kvu33qKzqe5FNDc9FlCFlRbXF4BqR859cnK7VKCkWiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+I3GRdbyUuvqlL+yxntqhilgRG9W7s8iC65GhJMw+ys69kDBCjUcGWb2D4LHGzy/
         Ll50u5loRgU6SV3jQrqKYDcOICBtPdDbQoc3prmpu24iCvhmT+gBSl+qJ7GQFa4iRD
         EkhmMi/r++Kjwf/vsw4iVlJANqSSsRMBSaRwXqoo=
Date:   Wed, 3 Feb 2021 16:44:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        andriy.shevchenko@linux.intel.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH 2/2] misc/pvpanic: add pci driver
Message-ID: <YBrE+3Ntt//GqJG4@kroah.com>
References: <1612363439-26656-1-git-send-email-mihai.carabas@oracle.com>
 <1612363439-26656-3-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612363439-26656-3-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 04:43:59PM +0200, Mihai Carabas wrote:
> Add pvpanic pci device driver support.
> 
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  drivers/misc/pvpanic/Kconfig       | 16 ++++++++++-
>  drivers/misc/pvpanic/Makefile      |  7 +++++
>  drivers/misc/pvpanic/pvpanic-pci.c | 54 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
> 
> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> index 12bb017..4a96e8d 100644
> --- a/drivers/misc/pvpanic/Kconfig
> +++ b/drivers/misc/pvpanic/Kconfig
> @@ -1,6 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# pvpanic device
> +#
> +
>  config PVPANIC
>  	bool "pvpanic device support"
> -	depends on PVPANIC_MMIO
> +	depends on (PVPANIC_MMIO || PVPANIC_PCI)
>  	help
>  	  This option enable generic code for pvpanic device driver logic.
>  
> @@ -12,3 +17,12 @@ config PVPANIC_MMIO
>  	  This driver provides support for the pvpanic device.  pvpanic is
>  	  a paravirtualized device provided by QEMU; it lets a virtual machine
>  	  (guest) communicate panic events to the host.
> +
> +config PVPANIC_PCI
> +	tristate "pvpanic pci device support"
> +	depends on PCI
> +	select PVPANIC
> +	help
> +	  This driver provides support for the pvpanic device.  pvpanic is
> +	  a paravirtualized device provided by QEMU; it lets a virtual machine
> +	  (guest) communicate panic events to the host.
> diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
> index d08379b..fe57d1f 100644
> --- a/drivers/misc/pvpanic/Makefile
> +++ b/drivers/misc/pvpanic/Makefile
> @@ -1,2 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for pvpanic device.
> +#
> +
> +
>  obj-$(CONFIG_PVPANIC)		+= pvpanic.o
>  obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
> +obj-$(CONFIG_PVPANIC_PCI)	+= pvpanic-pci.o
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
> new file mode 100644
> index 00000000..1d25d11
> --- /dev/null
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  pvpanic pci driver.
> + *
> + *  Copyright (C) 2021 Oracle.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +#include "pvpanic.h"
> +
> +#define PCI_VENDOR_ID_REDHAT             0x1b36
> +#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
> +
> +static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC),},
> +	{}
> +};
> +
> +static int pvpanic_pci_probe(struct pci_dev *pdev,
> +			     const struct pci_device_id *ent)
> +{
> +	int ret;
> +	struct resource res;
> +	void __iomem *base;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	base = pci_iomap(pdev, 0, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	pvpanic_probe(base);
> +
> +	return 0;
> +}
> +
> +static void pvpanic_pci_remove(struct pci_dev *pdev)
> +{
> +	pvpanic_remove();

So no real device here?  That feels really wrong, you can't have a
single global instance anymore :(

thanks,

greg k-h
