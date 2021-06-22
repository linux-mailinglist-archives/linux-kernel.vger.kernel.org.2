Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514343B0E02
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhFVUFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232464AbhFVUE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:04:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3F38610C7;
        Tue, 22 Jun 2021 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624392162;
        bh=SADSsM6/5WWzDsf6APOGLt/MFLIdzRSL0X+8VgpWjY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C90yKoSSE/rr1iZWF/nKHvkykktrRPno0LrEyW8Whzf32OeVVco9RnblFUSsd0CFJ
         qnBGg+P/oada7nq88xVA6OUgqlXemn2fJ2hdnN+7pbByLvCMjaD4tzWImACNuo/N7Z
         V6DWZ4xe1fC8pUmgFS8m/WBqyM5VRDJ8nJ2ZI5Yw=
Date:   Tue, 22 Jun 2021 22:02:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        philipp.deppenwiese@immu.ne
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YNJB4HoRa6qWgOJC@kroah.com>
References: <20210622142334.14883-1-hans-gert.dahmen@immu.ne>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210622142334.14883-1-hans-gert.dahmen@immu.ne>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 04:23:34PM +0200, Hans-Gert Dahmen wrote:
> Make the 16MiB long memory-mapped BIOS region of the platform SPI flash
> on X86_64 system available via /sys/kernel/firmware/flash_mmap/bios_region
> for pen-testing, security analysis and malware detection on kernels
> which restrict module loading and/or access to /dev/mem.
> 
> It will be used by the open source Converged Security Suite.
> https://github.com/9elements/converged-security-suite
> 
> Signed-off-by: Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
> ---
>  drivers/firmware/Kconfig             |  9 ++++
>  drivers/firmware/Makefile            |  1 +
>  drivers/firmware/x86_64_flash_mmap.c | 65 ++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
>  create mode 100644 drivers/firmware/x86_64_flash_mmap.c
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index db0ea2d2d75a..bd77ca2b4fa6 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -296,6 +296,15 @@ config TURRIS_MOX_RWTM
>  	  other manufacturing data and also utilize the Entropy Bit Generator
>  	  for hardware random number generation.
>  
> +config X86_64_FLASH_MMAP
> +	tristate "Export platform flash memory-mapped BIOS region"
> +	depends on X86_64
> +	help
> +	  Export the memory-mapped BIOS region of the platform SPI flash as
> +	  a read-only sysfs binary attribute on X86_64 systems. The first 16MiB
> +	  will be accessible via /sys/kernel/firmware/flash_mmap/bios_region
> +	  for security and malware analysis for example.

Module name information here?

Can this be auto-loaded based on hardware-specific values somewhere?
Otherwise it just looks like if this module loads, it will "always
work"?

And why would you want to map the bios into userspace?

What bios, UEFI?

And you need a Documentation/ABI/ update for new sysfs files.


> +
>  source "drivers/firmware/broadcom/Kconfig"
>  source "drivers/firmware/google/Kconfig"
>  source "drivers/firmware/efi/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 5e013b6a3692..eb7483c5a2ac 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>  obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
>  obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
>  obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
> +obj-$(CONFIG_X86_64_FLASH_MMAP)	+= x86_64_flash_mmap.o
>  
>  obj-y				+= arm_scmi/
>  obj-y				+= broadcom/
> diff --git a/drivers/firmware/x86_64_flash_mmap.c b/drivers/firmware/x86_64_flash_mmap.c
> new file mode 100644
> index 000000000000..f9d871a8b516
> --- /dev/null
> +++ b/drivers/firmware/x86_64_flash_mmap.c
> @@ -0,0 +1,65 @@
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
> +#include <linux/kobject.h>
> +
> +#define FLASH_REGION_START 0xFF000000ULL
> +#define FLASH_REGION_SIZE 0x1000000ULL

Where do these values come from?

> +#define FLASH_REGION_MASK (FLASH_REGION_SIZE - 1)
> +
> +struct kobject *kobj_ref;

Only 1?  Not per-hardware-device?

> +
> +static ssize_t bios_region_read(struct file *file, struct kobject *kobj,
> +				struct bin_attribute *bin_attr, char *buffer,
> +				loff_t offset, size_t count)
> +{
> +	resource_size_t pa = FLASH_REGION_START + (offset & FLASH_REGION_MASK);
> +	void __iomem *va = ioremap(pa, PAGE_SIZE);

Why PAGE_SIZE?

> +
> +	memcpy_fromio(buffer, va, PAGE_SIZE);
> +	iounmap(va);
> +
> +	return min(count, PAGE_SIZE);
> +}
> +
> +BIN_ATTR_RO(bios_region, FLASH_REGION_SIZE);
> +
> +static int __init flash_mmap_init(void)
> +{
> +	int ret = 0;
> +
> +	kobj_ref = kobject_create_and_add("flash_mmap", firmware_kobj);
> +	ret = sysfs_create_bin_file(kobj_ref, &bin_attr_bios_region);

You just raced with userspace and lost :(

Please make a sysfs attribute part of a default "group" for a kobject.
But as you are using a "raw" kobject here, that feels really wrong to
me.  Isn't this some sort of platform device really?  Why not go that
way, why tie this to the firmware subsystem?

> +	if (ret) {
> +		pr_err("sysfs_create_bin_file failed\n");
> +		goto error;
> +	}
> +
> +	return ret;

So this just "always works"?  That feels VERY dangerous.

As this is a x86 thing, you should also cc: the x86 maintainers.

thanks,

greg k-h
