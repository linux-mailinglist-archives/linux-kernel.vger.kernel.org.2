Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFF1348E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhCYKbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhCYKbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:31:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EE6461A25;
        Thu, 25 Mar 2021 10:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616668267;
        bh=gihgNnx2OUFDA8cjhLJ9cJkh6zClKQLfuJWEfLdUYMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhDtUeKuorG9Z1Aqfk67Anx8LUrD20TGZYX5SrOXXdeMR8anZd3IVoZe/qN9GBmUg
         2cO5nBUqEntSGpHv62aDFIG/jnQESXgEtkFvEFDo5gLKlS7K2belTEb/rgRv5EgLmJ
         WG2ED2JcENSmWW9Vn3HyAMpGFjWk9wo/phjXBMA8=
Date:   Thu, 25 Mar 2021 11:31:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, yisen.zhuang@huawei.com,
        tanxiaofei@huawei.com, liudongdong3@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] USB:XHCI:Adjust the log level of hub
Message-ID: <YFxmaEtKclXXpBfy@kroah.com>
References: <1616666652-37920-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616666652-37920-1-git-send-email-liulongfang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 06:04:12PM +0800, Longfang Liu wrote:
> When the number of ports of the hub is not between 1 and Maxports,
> it will only exit the registration of the hub on the current controller,
> but it will not affect the function of the controller itself. Its other
> hubs can operate normally, so the log level here can be changed from
> error to information.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/usb/core/hub.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index b1e14be..70294ad 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -1409,13 +1409,11 @@ static int hub_configure(struct usb_hub *hub,
>  		maxchild = min_t(unsigned, maxchild, USB_SS_MAXPORTS);
>  
>  	if (hub->descriptor->bNbrPorts > maxchild) {
> -		message = "hub has too many ports!";
> -		ret = -ENODEV;
> -		goto fail;
> +		dev_info(hub_dev, "hub has too many ports!\n");

Is this an error?  If so, report it as such, not as "information".

> +		return -ENODEV;
>  	} else if (hub->descriptor->bNbrPorts == 0) {
> -		message = "hub doesn't have any ports!";
> -		ret = -ENODEV;
> -		goto fail;
> +		dev_info(hub_dev, "hub doesn't have any ports!\n");

Same here.

What problem are you trying to solve here?

What hub do you have that has no ports, or too many, that you think
should still be able to work properly?

thanks,

greg k-h
