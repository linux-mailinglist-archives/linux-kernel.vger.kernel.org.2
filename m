Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19943D0C47
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhGUJ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238421AbhGUJO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:14:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E443260FF1;
        Wed, 21 Jul 2021 09:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626861302;
        bh=YOTnqKLnAhWXxLs6iC8djXjjDjyPD25r6MPl+60XL74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4CnHSmgSe4VT82E8hwLOW4niQ7cC5alPI1SapOzY8KB+XdTIDnC0roQCmpD48IJS
         AxPD2fHvm7PRLbRk3Ng9dp3k3hfe7pzSyLMSsmeC+jjziMEklxpwme8JJ3l5JdvGHo
         ui3LG83Kb7CKc9AOO/3m7BLeBCNa7eZjiH1m4zUo=
Date:   Wed, 21 Jul 2021 11:54:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Broadfoot <msbroadf@gmail.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhci_hcd: Always re-enable a USB Port after reset
Message-ID: <YPfu878Y1Og7zwd7@kroah.com>
References: <20210721094922.15642-1-msbroadf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721094922.15642-1-msbroadf@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 07:49:22PM +1000, Michael Broadfoot wrote:
> A (virtual) usb port can getting stuck in a disabled state on reset

How can that happen?

> Always re-enable a usb port regardless of if its addressed or not

Are you sure?  What causes this?

And what do you mean by "not" here?

Please write full sentences.

> 
> Signed-off-by: Michael Broadfoot <msbroadf@gmail.com>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 4ba6bcdaa8e9..cea3781d04e6 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -455,15 +455,12 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  			vhci_hcd->port_status[rhport] &= ~(1 << USB_PORT_FEAT_RESET);
>  			vhci_hcd->re_timeout = 0;
>  
> -			if (vhci_hcd->vdev[rhport].ud.status ==
> -			    VDEV_ST_NOTASSIGNED) {
>  				usbip_dbg_vhci_rh(
>  					" enable rhport %d (status %u)\n",
>  					rhport,
>  					vhci_hcd->vdev[rhport].ud.status);
>  				vhci_hcd->port_status[rhport] |=
>  					USB_PORT_STAT_ENABLE;
> -			}

Coding style is now all messed up, this change isn't ok as-is, sorry.

thanks,

greg k-h
