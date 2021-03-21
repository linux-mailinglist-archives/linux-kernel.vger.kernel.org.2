Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A990343269
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 13:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCUMYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 08:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhCUMYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 08:24:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75DCD6193E;
        Sun, 21 Mar 2021 12:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616329448;
        bh=F6NhSpVdoW4xD9hrDg3OmI2in0AjEwYyN7tOvNFuxh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zGfxj3/Zhf2b+K4d71IUHlB2auJvl453wQtt+gwFP5ptIsceuhDmJmCbzGgCNOvdL
         pVI0UT2zd0TtuMYW7Q+9AZ1uCPOeyQbLjhlsgDtuE6JD60+7XQPwzdEqckWpR1zHvR
         efQxvEqwg82nuOdaIUJlzKcID6UfaI1vFHZakefM=
Date:   Sun, 21 Mar 2021 13:24:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     eli.billauer@gmail.com
Cc:     arnd@arndb.de, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v4 1/2] char: xillybus: Move class-related functions to
 new xillybus_class.c
Message-ID: <YFc65bvAN3/ZNsww@kroah.com>
References: <20210311095033.20956-1-eli.billauer@gmail.com>
 <20210311095033.20956-2-eli.billauer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311095033.20956-2-eli.billauer@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:50:32AM +0200, eli.billauer@gmail.com wrote:
> From: Eli Billauer <eli.billauer@gmail.com>
> 
> This patch is a preparation for adding another related driver, XillyUSB.
> In order to share some code between the existing Xillybus driver and the
> one to be added, some functions are moved to xillybus_class.c
> 
> The header file, xillybus_class.h, is temporarily placed in include/linux/,
> because the new XillyUSB driver is intended as a staging driver for the
> time being.
> 
> Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
> ---
> 
> Notes:
>     Changelog:
>     
>     v4:
>       - Fix error code return value bugs in xillybus_init_chrdev() as detected by
>         Smatch test robot, and reported by Dan Carpenter.
>     
>     This patch did not exist prior to v3.
> 
>  drivers/char/xillybus/Kconfig          |   4 +
>  drivers/char/xillybus/Makefile         |   1 +
>  drivers/char/xillybus/xillybus.h       |  10 +-
>  drivers/char/xillybus/xillybus_class.c | 263 +++++++++++++++++++++++++
>  drivers/char/xillybus/xillybus_core.c  | 181 +++--------------
>  include/linux/xillybus_class.h         |  30 +++
>  6 files changed, 322 insertions(+), 167 deletions(-)
>  create mode 100644 drivers/char/xillybus/xillybus_class.c
>  create mode 100644 include/linux/xillybus_class.h
> 
> diff --git a/drivers/char/xillybus/Kconfig b/drivers/char/xillybus/Kconfig
> index 130dbdce858f..e7800f025249 100644
> --- a/drivers/char/xillybus/Kconfig
> +++ b/drivers/char/xillybus/Kconfig
> @@ -3,10 +3,14 @@
>  # Xillybus devices
>  #
>  
> +config XILLYBUS_CLASS
> +	tristate
> +
>  config XILLYBUS
>  	tristate "Xillybus generic FPGA interface"
>  	depends on PCI || OF
>  	select CRC32
> +	select XILLYBUS_CLASS

depends on, do not select.

