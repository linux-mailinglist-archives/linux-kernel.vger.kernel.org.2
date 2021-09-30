Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F56041D2B3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 07:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348055AbhI3FcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 01:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347737AbhI3FcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 01:32:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 100D16140F;
        Thu, 30 Sep 2021 05:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632979831;
        bh=sadiBAmx2XKGI77141lruBUtIqdhRPUme9yO+YweVvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdN8+0NQc/wzdGQCGsaJW98+em0Y1LOpof9mjh2aonFYgOJkfKagfpRNCiH17Wkdd
         /DxKeep7+xskwP76wMm6AJrZTNKKZ5prMyAIdplq9DuLxptZwC2+iWN5ZIxAUvfdX6
         ds+GJH5aFSonJib5VBjOiUb19KTNY1ciab0P4Agg=
Date:   Thu, 30 Sep 2021 07:30:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        levinale@google.com, bleung@google.com, rajatxjain@gmail.com,
        jsbarnes@google.com, pmalani@google.com
Subject: Re: [PATCH 1/2] usb: hub: Mark root hubs on removable devices, as
 removable.
Message-ID: <YVVLcvcjOzK6m0yK@kroah.com>
References: <20210929224823.556943-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929224823.556943-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 03:48:22PM -0700, Rajat Jain wrote:
> Currently all usb root hubs are always marked as DEVICE_REMOVABLE_UNKNOWN
> unconditionally. Let us try to help the users to identify the removable
> root hubs, by checking the device on which the root hub sits. If the base
> (parent) device on which the root hub sits, is removable (e.g. on
> thunderbolt docks), then the roothub is also marked as removable.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/usb/core/hub.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 86658a81d284..45d1c81b121d 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2440,8 +2440,16 @@ static void set_usb_port_removable(struct usb_device *udev)
>  
>  	dev_set_removable(&udev->dev, DEVICE_REMOVABLE_UNKNOWN);
>  
> -	if (!hdev)
> +	if (!hdev) {
> +		/*
> +		 * If the root hub sits on a removable device, mark the root hub
> +		 * removable as well. This helps with the USB root hubs sitting
> +		 * on the thunderbolt docks.
> +		 */
> +		if (udev->dev.parent && dev_is_removable(udev->dev.parent))
> +			dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
>  		return;
> +	}

How far "up the chain" are you going to go here?  What if the
thunderbolt device is on a PCI device that can be removed?  What if that
PCI device is on a PCI bus that can be removed?

Is a USB controller on a docking device really "removable"?

The goal here is to say if this device itself is removable in the sense
of "I can yank this out", and a roothub is not that type of device.

What problem are you trying to solve with this series?

thanks,

greg k-h
