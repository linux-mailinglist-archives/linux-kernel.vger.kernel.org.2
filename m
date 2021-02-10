Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9686316467
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhBJKzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:55:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhBJKwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:52:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6428364E2F;
        Wed, 10 Feb 2021 10:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612954309;
        bh=Y6sCoyxE53CReNPUEbiccEMYwSH7CbdJeBLkyQtM4kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ns6iSXNhiO6JrMRZy7ZlMVQLaPRp1McXSsStX4jQFhFyY/3Rou9ZqtYBi5SaeFPYF
         QWPaiZkmmCIX5zqXPp6/oLk/bITbO77eAC0JY+rhf6ejTYfCkVnlll7Un18DWTc2fQ
         RWg/hwN+Lq7jzqYDbL1VR+Y9nHYiCzLtrfuJBH0Y=
Date:   Wed, 10 Feb 2021 11:51:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hikaru Nishida <hikalium@chromium.org>
Cc:     linux-kernel@vger.kernel.org, suleiman@google.com,
        Alexander Graf <graf@amazon.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH 2/2] drivers/virt: introduce CLOCK_BOOTTIME
 adjustment sysfs interface driver
Message-ID: <YCO6wmsnB/OsNb+R@kroah.com>
References: <20210210103908.1720658-1-hikalium@google.com>
 <20210210193728.RFC.2.I03c0323c1564a18210ec98fb78b3eb728a90c2d2@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210193728.RFC.2.I03c0323c1564a18210ec98fb78b3eb728a90c2d2@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 07:39:08PM +0900, Hikaru Nishida wrote:
> From: Hikaru Nishida <hikalium@chromium.org>
> 
> This adds a sysfs interface /sys/kernel/boottime_adj to enable advancing
> CLOCK_BOOTTIME from the userspace without actual susupend/resume cycles.
> 
> This gives a way to mitigate CLOCK_BOOTTIME divergence between guest
> and host on virtualized environments after suspend/resume cycles on
> the host.
> 
> We observed an issue of a guest application that expects there is a gap
> between CLOCK_BOOTTIME and CLOCK_MONOTONIC after the device is suspended
> to detect whether the device went into suspend or not.
> Since the guest is paused instead of being actually suspended during the
> host's suspension, guest kernel doesn't advance CLOCK_BOOTTIME correctly
> and there is no way to correct that.
> 
> To solve the problem, this change introduces a way to modify a gap
> between those clocks and align the timer behavior to host's one.
> 
> Signed-off-by: Hikaru Nishida <hikalium@chromium.org>
> ---
> 
>  drivers/virt/Kconfig        |  9 ++++++
>  drivers/virt/Makefile       |  1 +
>  drivers/virt/boottime_adj.c | 57 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>  create mode 100644 drivers/virt/boottime_adj.c
> 
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 80c5f9c16ec1..149b4e763e4d 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -13,6 +13,15 @@ menuconfig VIRT_DRIVERS
>  
>  if VIRT_DRIVERS
>  
> +config BOOTTIME_ADJUSTMENT
> +	tristate "CLOCK_BOOTTIME adjustment sysfs interface"
> +	help
> +          The CLOCK_BOOTTIME adjustment sysfs interface driver
> +          provides a sysfs interface ( /sys/kernel/boottime_adj )
> +          to enable adjusting CLOCK_BOOTTIME from the userspace.
> +
> +          If unsure, say N.
> +
>  config FSL_HV_MANAGER
>  	tristate "Freescale hypervisor management driver"
>  	depends on FSL_SOC
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index f28425ce4b39..1bbb476ddba9 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for drivers that support virtualization
>  #
>  
> +obj-$(CONFIG_BOOTTIME_ADJUSTMENT)	+= boottime_adj.o
>  obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
>  obj-y				+= vboxguest/
>  
> diff --git a/drivers/virt/boottime_adj.c b/drivers/virt/boottime_adj.c
> new file mode 100644
> index 000000000000..9cc717d8accc
> --- /dev/null
> +++ b/drivers/virt/boottime_adj.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Do you really mean "or later"?  I have to ask...

> +/*
> + * CLOCK_BOOTTIME Adjustment Interface Driver

No copyright, nice!  Your company lawyers will be having a word with
you... :(

> + */
> +
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/timekeeping.h>
> +
> +static struct kobject *kobj_boottime_adj;
> +
> +/*
> + * Write to /sys/kernel/boottime_adj advances CLOCK_BOOTTIME by given delta.
> + */
> +static ssize_t boottime_adj_write(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf,
> +		size_t count)
> +{
> +	int error;
> +	struct timespec64 delta;
> +
> +	if (sscanf(buf, "%lld %ld", &delta.tv_sec, &delta.tv_nsec) != 2)
> +		return -EINVAL;

sysfs is "one value per file", but as you did not provide documentation
on what this does, I can't tell if you really are following this or not.

> +
> +	error = timekeeping_adjust_boottime(&delta);
> +	if (error)
> +		return error;
> +
> +	pr_info("%s: CLOCK_BOOTTIME has been advanced by %+lld seconds and %+ld nanoseconds\n",
> +			__func__, delta.tv_sec, delta.tv_nsec);

If kernels are working normally, no messages are printed to the log.  Do
not allow userspace to spam things.

> +	return count;
> +}
> +
> +static struct kobj_attribute boottime_adj_attr =
> +__ATTR(boottime_adj, 0200, NULL, boottime_adj_write);

__ATTR_RO() please.

> +
> +static int __init boottime_adj_init(void)
> +{
> +	int error;
> +
> +	error = sysfs_create_file(kernel_kobj, &boottime_adj_attr.attr);
> +	if (error) {
> +		pr_warn("%s: failed to init\n", __func__);

why warn again?

> +		return error;
> +	}
> +	return 0;
> +}
> +
> +static void __exit boottime_adj_cleanup(void)
> +{
> +	kobject_put(kobj_boottime_adj);

You just called put on a kobject you never initialized?????

Are you sure this file has been tested?

odd...

greg k-h
