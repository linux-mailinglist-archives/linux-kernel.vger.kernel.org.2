Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B26744A6B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbhKIGTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230011AbhKIGT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:19:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27747611BF;
        Tue,  9 Nov 2021 06:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636438604;
        bh=Pj0w/765nIeUinsdw2x8elro8Twg48Pg8i+XxslDxxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPXNt/UaJM8HsokBr6UYcVV3VdTwHbWw43zmUsMUEk0LkPtFVhluqS9SQEfUS2MjE
         AuftfEYa7KgmveH4dEUY+q956qpISuVkwdsBavto6NkGrEV3K2VEpbxiiiSULhOdBo
         T6Hq33mkcBl0UtQZAi4UCA1VDcpRqFILaCyjdHs0=
Date:   Tue, 9 Nov 2021 07:16:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        philipp.deppenwiese@immu.ne, mauro.lima@eclypsium.com,
        hughsient@gmail.com, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YYoSPjF3M05dR0PX@kroah.com>
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 01:01:30AM +0100, Hans-Gert Dahmen wrote:
> Make the 16MiB long memory-mapped BIOS region of the platform SPI flash
> on X86_64 system available via /sys/kernel/firmware/flash_mmap/bios_region
> for pen-testing, security analysis and malware detection on kernels
> which restrict module loading and/or access to /dev/mem.

That feels like a big security hole we would be opening up for no good
reason.

> It will be used by the open source Converged Security Suite.
> https://github.com/9elements/converged-security-suite

What is the reason for this, and what use is this new interface?

> 
> Signed-off-by: Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
> ---
>  drivers/firmware/Kconfig             |  9 +++
>  drivers/firmware/Makefile            |  1 +
>  drivers/firmware/x86_64_flash_mmap.c | 86 ++++++++++++++++++++++++++++

You forgot to document the new sysfs files in Documentation/ABI/ :(


>  3 files changed, 96 insertions(+)
>  create mode 100644 drivers/firmware/x86_64_flash_mmap.c
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 75cb91055c17..27c2d0b074e0 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -293,6 +293,15 @@ config TURRIS_MOX_RWTM
>  	  other manufacturing data and also utilize the Entropy Bit Generator
>  	  for hardware random number generation.
>  
> +config X86_64_FLASH_MMAP
> +	tristate "Export platform flash memory-mapped BIOS region"
> +	depends on X86_64
> +	help
> +	  Export the memory-mapped BIOS region of the platform SPI flash as
> +	  a read-only sysfs binary attribute on X86_64 systems. The first 16MiB
> +	  will be accessible via /sys/devices/platform/flash_mmap/bios_region
> +	  for security and malware analysis for example.
> +
>  source "drivers/firmware/arm_ffa/Kconfig"
>  source "drivers/firmware/broadcom/Kconfig"
>  source "drivers/firmware/cirrus/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 4e58cb474a68..60dc4ea08705 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
>  obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
>  obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
>  obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
> +obj-$(CONFIG_X86_64_FLASH_MMAP)	+= x86_64_flash_mmap.o
>  
>  obj-y				+= arm_ffa/
>  obj-y				+= arm_scmi/
> diff --git a/drivers/firmware/x86_64_flash_mmap.c b/drivers/firmware/x86_64_flash_mmap.c
> new file mode 100644
> index 000000000000..23d8655d17bb
> --- /dev/null
> +++ b/drivers/firmware/x86_64_flash_mmap.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Export the memory-mapped BIOS region of the platform SPI flash as
> + * a read-only sysfs binary attribute on X86_64 systems.
> + *
> + * Copyright © 2021 immune GmbH
> + */
> +
> +#include <linux/version.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/sysfs.h>
> +#include <linux/platform_device.h>
> +
> +#define FLASH_REGION_START 0xFF000000ULL
> +#define FLASH_REGION_SIZE 0x1000000ULL
> +#define FLASH_REGION_MASK (FLASH_REGION_SIZE - 1)
> +
> +struct platform_device *pdev;
> +
> +static ssize_t bios_region_read(struct file *file, struct kobject *kobj,
> +				struct bin_attribute *bin_attr, char *buffer,
> +				loff_t offset, size_t count)
> +{
> +	resource_size_t pa;
> +	size_t copysize, remapsize;
> +	void __iomem *va;
> +
> +	offset = offset & FLASH_REGION_MASK;
> +	pa = (FLASH_REGION_START + offset) & PAGE_MASK;
> +
> +	if ((offset + count) > FLASH_REGION_SIZE)
> +		copysize = FLASH_REGION_SIZE - offset;
> +	else
> +		copysize = min(count, PAGE_SIZE);
> +
> +	if (((offset & ~PAGE_MASK) + copysize) > PAGE_SIZE)
> +		remapsize = 2 * PAGE_SIZE;
> +	else
> +		remapsize = PAGE_SIZE;
> +
> +	va = ioremap(pa, remapsize);
> +	memcpy_fromio(buffer, va, copysize);
> +	iounmap(va);
> +
> +	return copysize;
> +}
> +
> +static BIN_ATTR_RO(bios_region, FLASH_REGION_SIZE);
> +
> +static struct bin_attribute *flash_mmap_attrs[] = { &bin_attr_bios_region,
> +						    NULL };
> +
> +static const struct attribute_group flash_mmap_group = {
> +	.bin_attrs = flash_mmap_attrs,
> +};
> +
> +static int __init flash_mmap_init(void)
> +{
> +	int ret;
> +
> +	pdev = platform_device_register_simple("flash_mmap", -1, NULL, 0);
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);
> +
> +	ret = sysfs_create_group(&pdev->dev.kobj, &flash_mmap_group);

You just raced with userspace and lost :(

Please set the attribute to the platform driver before you create the
device.

Also, you just bound this driver to ANY platform that it was loaded on,
with no actual detection of the hardware present, which feels like it
could cause big problems on all platforms.  Please, if you really want
to do this, restrict it to hardware that actually has the hardware you
are wanting to access, not all machines in the world.

thanks,

greg k-h
