Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD7B34EB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhC3Oul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232111AbhC3Ou0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:50:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C120361957;
        Tue, 30 Mar 2021 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115825;
        bh=dKA0n4g3xziLV+8mgbudDkF+Vzit/heDizeGNQKRNaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BReq1ll3GdLQXqXtnMfvUv3WfDIo6GT/n1pjFE+sApYaJl6PYD8zr8CYwaUBuY2/p
         44Aap5tgm1vFVOkmrr/PyFtALpAEHUHn9cpIRkNsjXLS60Z/kRsitxSjcFZ5hT955a
         HPPFPUDZHR3Lv2OYZO2whKDm/8zHy+6GWJF4QCVPI6h0PHneY6h8cInIo+Y9F6QGJ7
         uP9AMo8BRPEGYTJZxQpfrGR2a5hK8KsW9Hed4Mssy4o93b96fvAbITjDkNshaxPDfX
         azPu3UMAnD1cVmtdwn39t0WND2qdK2AGHcH4IiaTPg7ljSf9lQAflsm8zorS2rVbnX
         IJWItxfKN0blQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFhf-0002Rw-Gh; Tue, 30 Mar 2021 16:50:47 +0200
Date:   Tue, 30 Mar 2021 16:50:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/7] USB: serial: xr: add support for multi-port
 XR21V141X variants
Message-ID: <YGM6x/xqmTBd69ut@hovoldconsulting.com>
References: <cover.1616571453.git.mchehab+huawei@kernel.org>
 <6ad220aa5ed6062005d44aeb3c02b5d576e12250.1616571453.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad220aa5ed6062005d44aeb3c02b5d576e12250.1616571453.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:41:07AM +0100, Mauro Carvalho Chehab wrote:
> XR21V1412 and XR21V1414 have exactly the same interface, but
> they support multiple 2 and 4 ports, respectively.
> 
> On such devices, the "CDC Union" field shows how they're
> grouped, as can be seen on those lsusb -v outputs:
> 
> 	https://linux-usb.vger.kernel.narkive.com/YaTYwHkM/usb-uart-device-from-exar-co-not-working-with-cdc-acm-but-usbserial
> 	https://jquery.developreference.com/article/22043997/udev+rule+with+bInterfaceNumber+doesn't+work+%5bclosed%5d
> 
> So, for instance, on XR21V1414, (0x04e2:0x1414), the 3rd
> port is:
> 
> 	CDC Union:
> 		bMasterInterface 4
> 		bSlaveInterface 5
> 
> 	CDC Call Management:
> 		bmCapabilities 0x01
> 			call management
> 				bDataInterface 5
> 
> In other words, the control interface is an even number,
> and the data interface is the next odd number.
> 
> The logic to get the proper register for an specific channel
> came from this patch:
> 
> 	https://lore.kernel.org/linux-usb/20180404070634.nhspvmxcjwfgjkcv@advantechmxl-desktop
> 
> Add support for them.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/usb/serial/xr_serial.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
> index 518c4725431a..f161394d9b2d 100644
> --- a/drivers/usb/serial/xr_serial.c
> +++ b/drivers/usb/serial/xr_serial.c
> @@ -145,6 +145,7 @@ static const int xr_hal_table[MAX_XR_MODELS][MAX_XR_HAL_TYPE] = {
>  
>  struct xr_port_private {
>  	enum xr_model model;
> +	unsigned int channel;
>  };
>  
>  static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
> @@ -153,6 +154,14 @@ static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg, u8 val)
>  	struct usb_serial *serial = port->serial;
>  	int ret;
>  
> +	switch (port_priv->model) {
> +	case XR21V141X:
> +		if (port_priv->channel)
> +			reg |= (port_priv->channel - 1) << 8;

reg is u8 so you're simply discarding the channel index here and
effectively only the first port will work as intended after this patch.

> +		break;
> +	default:
> +		return -EINVAL;
> +	};
>  	ret = usb_control_msg(serial->dev,
>  			      usb_sndctrlpipe(serial->dev, 0),
>  			      xr_hal_table[port_priv->model][REQ_SET],
 
>  static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
>  {
> +	struct usb_interface *intf = serial->interface;
> +	struct usb_endpoint_descriptor *data_ep;
>  	struct xr_port_private *port_priv;
> +	int ifnum;
>  
> -	/* Don't bind to control interface */
> -	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
> +	/* Attach only data interfaces */
> +	ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
> +	if (!(ifnum % 2))
>  		return -ENODEV;
>  
>  	port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
>  	if (!port_priv)
>  		return -ENOMEM;
>  
> +	data_ep = &intf->cur_altsetting->endpoint[0].desc;
> +
>  	port_priv->model = id->driver_info;
> +	port_priv->channel = data_ep->bEndpointAddress;

This creative but it seems cleaner to simply use the interface number
of the control interface divided by two. That gives you a zero-based
index which doesn't require the "channel--" added at various places by
the rest of the series.

Johan
