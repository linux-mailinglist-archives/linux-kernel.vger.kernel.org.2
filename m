Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC84319C82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhBLKTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhBLKSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:18:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF7A764D9E;
        Fri, 12 Feb 2021 10:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613125092;
        bh=++TO0FzpWyCcpzyrLlTpDrUGOU9gYPmoQtgnh1Lwg50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mavilDINhCrA2C9pmaR5in8LaI8W4nt/H0G5wDQE+kq4XebTsQ863wI3/TIZEMMoa
         vysuEM7PFIZV6iwXgMDdqLEaGkyDxq8wcYfpZtw2L2g4sI8pFfz05n1YzQomJJsQ5c
         vNhSv9KCKH4lF5R1xGibfJtbJF/iHoqymfS5z70I=
Date:   Fri, 12 Feb 2021 11:18:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH v2 2/3] misc/pvpanic: add PCI driver
Message-ID: <YCZV4ZNgvP0GfjVF@kroah.com>
References: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com>
 <1613121426-15585-3-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613121426-15585-3-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 11:17:05AM +0200, Mihai Carabas wrote:
> Add support for pvpanic PCI device added in qemu [1]. At probe time, obtain the
> address where to read/write pvpanic events and pass it to the generic handling
> code. Will follow the same logic as pvpanic MMIO device driver. At remove time,
> unmap base address and disable PCI device.
> 
> [1] https://github.com/qemu/qemu/commit/9df52f58e76e904fb141b10318362d718f470db2
> 
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  drivers/misc/pvpanic/Kconfig  |  8 +++++++
>  drivers/misc/pvpanic/Makefile |  2 ++
>  drivers/misc/pvpanic/pci.c    | 49 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
>  create mode 100644 drivers/misc/pvpanic/pci.c
> 
> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> index 0dce6ef..ce8b93e 100644
> --- a/drivers/misc/pvpanic/Kconfig
> +++ b/drivers/misc/pvpanic/Kconfig
> @@ -10,3 +10,11 @@ config PVPANIC_MMIO
>  	  This driver provides support for the pvpanic device.  pvpanic is
>  	  a paravirtualized device provided by QEMU; it lets a virtual machine
>  	  (guest) communicate panic events to the host.
> +
> +config PVPANIC_PCI
> +	tristate "pvpanic PCI device support"
> +	depends on PCI && PVPANIC
> +	help
> +	  This driver provides support for the pvpanic device.  pvpanic is
> +	  a paravirtualized device provided by QEMU; it lets a virtual machine
> +	  (guest) communicate panic events to the host.
> diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
> index 9ea3355..1763450 100644
> --- a/drivers/misc/pvpanic/Makefile
> +++ b/drivers/misc/pvpanic/Makefile
> @@ -1,2 +1,4 @@
>  obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
>  pvpanic-mmio-objs := pvpanic-common.o mmio.o
> +obj-$(CONFIG_PVPANIC_PCI)	+= pvpanic-pci.o
> +pvpanic-pci-objs := pvpanic-common.o pci.o

So you now have the pvpanic-common.o file linked into both modules at
the same time?  What happens if they are both loaded?

This feels really broken...

greg k-h
