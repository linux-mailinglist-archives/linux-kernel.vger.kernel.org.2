Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F3318BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhBKNOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:14:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhBKMzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:55:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4631E64E25;
        Thu, 11 Feb 2021 12:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613048078;
        bh=nkl6rIAHz8qXUlaiKZyKfjU2elB0/iokxCpsHrwwkyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqX3QUAQZtGJjabSVB7bTYJkHvz8vAUSYXf8Wts6bo/YdLc3l7ViDHisRJaIri8ZK
         YKujczf6w4rKv6eVG2vLgnnuCgZiW/bM0lQma6z5r2ANEGwojWNvy7d6JovnQEBeHb
         eu4uCYOPe7/1W6jYKLrxCcU3vxq0VfKouJQE16cQ=
Date:   Thu, 11 Feb 2021 13:54:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YCUpDCgz243ARqmW@kroah.com>
References: <1613012611-8489-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613012611-8489-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:03:31PM -0500, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This driver supports 1588 related functions of ClockMatrix(TM)
> and 82P33xxx families of timing and synchronization devices. The
> supported functons are:
> 
> - set combomode
> - get dpll's state
> - get dpll's ffo
> 
> Please note that this driver needs to work with rsmu mfd driver
> to access SMU through I2C/SPI.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/misc/Kconfig      |   7 +
>  drivers/misc/Makefile     |   3 +
>  drivers/misc/rsmu_cdev.c  | 430 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/misc/rsmu_cdev.h  |  75 ++++++++
>  drivers/misc/rsmu_cm.c    | 214 +++++++++++++++++++++++
>  drivers/misc/rsmu_sabre.c | 153 +++++++++++++++++
>  include/uapi/linux/rsmu.h |  61 +++++++
>  7 files changed, 943 insertions(+)
>  create mode 100644 drivers/misc/rsmu_cdev.c
>  create mode 100644 drivers/misc/rsmu_cdev.h
>  create mode 100644 drivers/misc/rsmu_cm.c
>  create mode 100644 drivers/misc/rsmu_sabre.c
>  create mode 100644 include/uapi/linux/rsmu.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index fafa8b0..2ba5070 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -466,6 +466,13 @@ config HISI_HIKEY_USB
>  	  switching between the dual-role USB-C port and the USB-A host ports
>  	  using only one USB controller.
>  
> +config RSMU
> +	tristate "Renesas Synchronization Management Unit (SMU)"
> +	depends on MFD_RSMU_I2C || MFD_RSMU_SPI
> +	help
> +	  This driver provides support for Renesas SMU,
> +	  such as Clockmatrix and 82P33XXX series.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index d23231e..3054c0d 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,3 +57,6 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
>  obj-$(CONFIG_UACCE)		+= uacce/
>  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> +
> +rsmu-objs			:= rsmu_cdev.o rsmu_cm.o rsmu_sabre.o
> +obj-$(CONFIG_RSMU)		+= rsmu.o
> diff --git a/drivers/misc/rsmu_cdev.c b/drivers/misc/rsmu_cdev.c
> new file mode 100644
> index 0000000..35c1f38
> --- /dev/null
> +++ b/drivers/misc/rsmu_cdev.c
> @@ -0,0 +1,430 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx families of
> + * timing and synchronization devices. It exposes a char device interface in
> + * sysfs and supports file operations like  open(), close() and ioctl().

There is no "char device interface in sysfs".
