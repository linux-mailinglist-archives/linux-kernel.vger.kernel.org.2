Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0DF392D66
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhE0MCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234621AbhE0MCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:02:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE966613D4;
        Thu, 27 May 2021 12:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622116840;
        bh=Q+HOpI0+tPeOEn4T8vJ8uVaUFnAxGz9pMedcBLfbM7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmOeNzXzPGGA+a390MwulVbMqXesJtsyc0hbicgaFtjvejqKFNE12ox9gw84euRbD
         SGUicyFOlKwCpoUVMjSS5WlGFm/1TN3zQ9OQYKv+UUPJED+ji83wvTNQTl41YZ/gHC
         JA53QrC3Pn2nmUkAgrgCKevzWMTP95x3sqO3M8CQ=
Date:   Thu, 27 May 2021 14:00:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     eli.billauer@gmail.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 2/2] char: xillybus: Add driver for XillyUSB (Xillybus
 variant for USB)
Message-ID: <YK+J5oy1qH6dWAmG@kroah.com>
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

Nit, you should just remove the MODULE_VERSION() stuff, it makes no
sense once it is in the kernel tree to have them as they then mean
nothing.

But that can be an add-on patch, let me review these...

