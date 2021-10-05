Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24B64224DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhJELVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhJELVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:21:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0C1961264;
        Tue,  5 Oct 2021 11:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633432796;
        bh=17M1HPK16uexzW8EPqolNIeVZVliQT3SLbG3c7B9frk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRGuUCjxQUJ5OhdshLt7nUS312AgliNWUIPsg4z8251glSD/qFPDg5y6J1B9H+JjH
         b2PmgP9cZzdk1kdl3+KRVZOzNvqHzMzhNl3M72LgM1udql+Bj2D/MuRRSYJJBgkQ6P
         Nb4U6EUqd+J8LdJ73JG5ldszEYzujAS22quGehtU=
Date:   Tue, 5 Oct 2021 13:19:54 +0200
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
Message-ID: <YVw02jUqxaVICKQU@kroah.com>
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

How can a roothub device not have a parent?

I still don't know about this.  What userspace tool is going to do
anything with this information?  What is broken today that this fixes?

thanks,

greg k-h
