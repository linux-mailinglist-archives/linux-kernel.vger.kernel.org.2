Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF27392DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhE0MNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235200AbhE0MNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:13:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8894611F0;
        Thu, 27 May 2021 12:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622117530;
        bh=kumG9+t+p+D528C6vzISFLbgUjrhcTt72egFrQcs0os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RcT7cuLN4QrsyH+8S/+erdGOOI+DpBgmcKC9AlrwIW/ARG9EY1Gq4BY4rl1k7xzSK
         wkywzXWr2pOmNw9sR85K3CA7NLh8KazvGcZieSysMNKbUOzbBig10d3UD51l5GM5qB
         4LzFknh5Be6XSukKscjPJzVKujOvACfOBROiDisc=
Date:   Thu, 27 May 2021 14:12:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     eli.billauer@gmail.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 2/2] char: xillybus: Add driver for XillyUSB (Xillybus
 variant for USB)
Message-ID: <YK+Mlw0Tn7eGFPI2@kroah.com>
References: <20210526100311.56327-1-eli.billauer@gmail.com>
 <20210526100311.56327-3-eli.billauer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526100311.56327-3-eli.billauer@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 01:03:11PM +0300, eli.billauer@gmail.com wrote:
> From: Eli Billauer <eli.billauer@gmail.com>
> 
> The XillyUSB driver is the USB variant for the Xillybus FPGA IP core.
> Even though it presents a nearly identical API on the FPGA and host,
> it's almost a complete rewrite of the driver: The framework for exchanging
> data on a USB bus is fundamentally different from doing the same with a
> PCIe interface, which leaves very little in common between the existing
> driver and the new one for XillyUSB.
> 
> Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
> ---
> 
> Notes:
>     Changelog:
>     
>     v5:
>       - Move xillyusb.c back from staging to char/xillybus/
>       - Turn previously lockless FIFO into one relying on a lock
>       - Set driver's soft_unbind flag, so that the device is notified when the
>         driver is unloaded + due changes for killing URBs as required
>       - Some refactoring of locks for better granularity
>       - Avoid using pr_err and pr_warn, replace with dev_* counterparts
>       - Bump MODULE_VERSION to 1.1
>       - Remove module_params
>       - Fix a few minor bugs regarding error handling flow
>       - Various coding style fixes and comment clarifications
>     
>     v4:
>       (No changes)
>     
>     v3:
>       - Move to staging
>       - Rely on xillybus_class for device file operations
>       - Fix no return value bug in xillyusb_discovery()
>       - Add module parameters for URB buffer size and count
>     
>     v2:
>       - Add comment in Kconfig file, saying XILLYUSB really doesn't depend
>         on XILLYBUS (following comment by Randy Dunlap)
>       - Use SEEK_* predefined constants instead of numbers
> 
>  drivers/char/xillybus/Kconfig    |   14 +
>  drivers/char/xillybus/Makefile   |    1 +
>  drivers/char/xillybus/xillyusb.c | 2260 ++++++++++++++++++++++++++++++
>  3 files changed, 2275 insertions(+)
>  create mode 100644 drivers/char/xillybus/xillyusb.c
> 
> diff --git a/drivers/char/xillybus/Kconfig b/drivers/char/xillybus/Kconfig
> index 7cc4d719ec4f..a8036dad437e 100644
> --- a/drivers/char/xillybus/Kconfig
> +++ b/drivers/char/xillybus/Kconfig
> @@ -36,3 +36,17 @@ config XILLYBUS_OF
>  	  system, say M. The module will be called xillybus_of.
>  
>  endif # if XILLYBUS
> +
> +# XILLYUSB doesn't depend on XILLYBUS
> +
> +config XILLYUSB
> +	tristate "XillyUSB: Xillybus generic FPGA interface for USB"
> +	depends on USB
> +	select CRC32
> +	select XILLYBUS_CLASS
> +	help
> +	  XillyUSB is the Xillybus variant which uses USB for communicating
> +	  with the FPGA.
> +
> +	  Set to M if you want Xillybus to use USB for communicating with
> +	  the FPGA. The module will be called xillyusb.
> diff --git a/drivers/char/xillybus/Makefile b/drivers/char/xillybus/Makefile
> index 591615264591..16f31d03209d 100644
> --- a/drivers/char/xillybus/Makefile
> +++ b/drivers/char/xillybus/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_XILLYBUS_CLASS)	+= xillybus_class.o
>  obj-$(CONFIG_XILLYBUS)		+= xillybus_core.o
>  obj-$(CONFIG_XILLYBUS_PCIE)	+= xillybus_pcie.o
>  obj-$(CONFIG_XILLYBUS_OF)	+= xillybus_of.o
> +obj-$(CONFIG_XILLYUSB)		+= xillyusb.o

This doesn't quite work.

Even if I have not selected CONFIG_XILLYBUS I get asked aboug
CONFIG_XILLYUSB.  And if I say 'm' to CONFIG_XILLYUSB, nothing gets
built.

So I'll take this now, but you need to send a follow-up patch to fix
these dependencies up to work correctly.

thanks,

greg k-h
