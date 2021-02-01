Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7CC30A9B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhBAO0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhBAO0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:26:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7143964DDE;
        Mon,  1 Feb 2021 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612189555;
        bh=QQqIk1jrL834oNJT0Ge0l4qRW+ufXIGBw4d9FnRSEdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQ9Ktf9+0vr8htx8QoqqdorkeVexnx5/TLccE9me/oeOkQK9BeIZ9EP0wJ2O+6RQm
         G9FJCrm/hB5+XDmipgt6eNSJ28iQyfUQ6+5DapHI208X7RxkvHwVIGo3WEftzWwk2v
         UPd2n6Vx4URUxkdDLsgOLK2YqWI3SEFK6FbAq4Vo=
Date:   Mon, 1 Feb 2021 15:25:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     eli.billauer@gmail.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] char: xillybus: Add driver for XillyUSB (Xillybus
 variant for USB)
Message-ID: <YBgPcX0J5m0bkhuA@kroah.com>
References: <20210201141651.62853-1-eli.billauer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201141651.62853-1-eli.billauer@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 04:16:51PM +0200, eli.billauer@gmail.com wrote:
> From: Eli Billauer <eli.billauer@gmail.com>
> 
> The XillyUSB driver is the USB variant for the Xillybus FPGA IP core.
> Even though it presents a nearly identical API on the FPGA and host,
> it's almost a complete rewrite of the driver: The framework for exchanging
> data on a USB bus is fundamentally different from doing the same with a
> PCIe interface, which leaves very little in common between the existing
> driver and the new one for XillyUSB.

As this has nothing to do with the existing XillyBus code, and you
aren't doing anything "fancy" with the character device nodes, why does
this need to be a kernel driver at all?  Why can't you just use libusb
and talk to the device directly from userspace with no kernel driver
needed?

And always cc: linux-usb@vger.kernel.org when submitting a USB driver so
that the developers there can review it.

thanks,

greg k-h
