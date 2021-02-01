Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EB930AC4C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhBAQG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:06:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhBAQGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:06:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E6ED64D7F;
        Mon,  1 Feb 2021 16:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612195569;
        bh=sbVt3w4s2AkOOcnW1zod/LGOmTAFaiiCubsVmm7LWpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LcvVqzSfOFsnKjy2BCLVmc9jrrEF4xPfB6h+gB7sm+YgslGx3x2S9+tLkUYxgIrIY
         UoMTcB99z+FF5EyC2ZEvZ383ABjT0YdOTyjLs2O6xTrkgplNdfOFhE+koBLzRmqnlA
         XtIvtOQWDko7TF3RyfIolnIzFOCWte53HYzmrXy8=
Date:   Mon, 1 Feb 2021 17:06:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     eli.billauer@gmail.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [RESEND PATCH v2] char: xillybus: Add driver for XillyUSB
 (Xillybus variant for USB)
Message-ID: <YBgm7qFk3jRl67vk@kroah.com>
References: <20210201155619.66960-1-eli.billauer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201155619.66960-1-eli.billauer@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 05:56:19PM +0200, eli.billauer@gmail.com wrote:
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
>     v2:
>       - Add comment in Kconfig file, saying XILLYUSB really doesn't depend
>         on XILLYBUS (following comment by Randy Dunlap)
>     
>       - Use SEEK_* predefined constants instead of numbers

As brought up on the other list, this should either:
	- use the same device nodes as the existing xillybus drivers do,
	  as you have the same api
	- just do it all in userspace using libusb.

thanks,

greg k-h
