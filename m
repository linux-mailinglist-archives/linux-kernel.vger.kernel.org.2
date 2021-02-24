Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE5323911
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhBXIx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234418AbhBXIwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:52:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05B1E64EBB;
        Wed, 24 Feb 2021 08:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614156699;
        bh=ApfbHB2qC+9W8gkFZzi1EMHLQDNZW7djtBwM2yXucQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gaZC/S8Xdz3Iia9lvr4QZhifs7RPjJe5Il3t0MLfX2Ce2lqboqB3ZFbzlTZOQpf9H
         daBJwxc+amVDJh80ikpZv/dMf/+/c4L+7fAzrrNPYdRf4iTTx6im7nnauu+/VGbFF7
         iFST3spW1WbeXL9ry6DtQXWDfXb/s0kmUbS7hPUpcrQURB8ZtWJI/roq1R5viDLYlK
         e0sZMYdVmhJMoDVuq8PQbg9g53fBGTnO9Y8qOzJu5r4dUzl53OuoQERryCuCqi0zFD
         Nixtnuv4UbCB0r1QUZFptIg/CvJp9i8iAp+vCvmBjNDRvbxbIVjpTQwDrrTMsATSSb
         ZgiEjrx73FcMQ==
Date:   Wed, 24 Feb 2021 09:51:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, patong.mxl@gmail.com,
        linus.walleij@linaro.org, angelo.dureghello@timesys.com
Subject: Re: [PATCH v5 1/3] usb: serial: Add MaxLinear/Exar USB to Serial
 driver
Message-ID: <20210224095133.3b1533fc@coco.lan>
In-Reply-To: <YDPSGE5vLphfFNJn@hovoldconsulting.com>
References: <20201122170822.21715-1-mani@kernel.org>
        <20201122170822.21715-2-mani@kernel.org>
        <YAlVLOqzx8otPgOg@hovoldconsulting.com>
        <20210126154604.GC29751@thinkpad>
        <YBBCvHvduivta07b@hovoldconsulting.com>
        <20210222161119.0bd70a2b@coco.lan>
        <YDPSGE5vLphfFNJn@hovoldconsulting.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 22 Feb 2021 16:47:36 +0100
Johan Hovold <johan@kernel.org> escreveu:

> On Mon, Feb 22, 2021 at 04:27:34PM +0100, Mauro Carvalho Chehab wrote:
> > Hi Johan,
> > 
> > Em Tue, 26 Jan 2021 17:26:36 +0100
> > Johan Hovold <johan@kernel.org> escreveu:
> >   
> > > On Tue, Jan 26, 2021 at 09:16:04PM +0530, Manivannan Sadhasivam wrote:  
> > > > On Thu, Jan 21, 2021 at 11:19:24AM +0100, Johan Hovold wrote:    
> > > > > On Sun, Nov 22, 2020 at 10:38:20PM +0530, Manivannan Sadhasivam wrote:    
> > > > > > Add support for MaxLinear/Exar USB to Serial converters. This driver
> > > > > > only supports XR21V141X series but it can be extended to other series
> > > > > > from Exar as well in future.    
> 
> > I'm now facing an issue with this driver. I have here two different
> > boards with those USB UART from MaxLinear/Exar.
> > 
> > The first one is identical to Mani's one:
> > 	USB_DEVICE(0x04e2, 0x1411)
> > The second one is a different version of it:
> > 	USB_DEVICE(0x04e2, 0x1424)
> > 
> > By looking at the final driver merged at linux-next, it sounds that
> > somewhere during the review of this series, it lost the priv struct,
> > and the xr_probe function. It also lost support for all MaxLinear/Exar
> > devices, except for just one model (04e2:1411).
> > 
> > The original submission:
> > 
> > 	https://lore.kernel.org/linux-usb/20180404070634.nhspvmxcjwfgjkcv@advantechmxl-desktop
> > 
> > And the manufacturer's Linux driver on their website:
> > 
> > 	https://www.maxlinear.com/support/design-tools/software-drivers
> > 
> > Had support for other 12 different models of the MaxLinear/Exar USB
> > UART.   
> 
> IIRC Manivannan only had access to one of these models and his original
> submission (based on the patch you link to above) didn't include support
> for the others. And keeping the type abstraction didn't make sense for
> just one model.
> 
> > Those are grouped into 5 different major types:
> > 
> > 	+	init_xr2280x_reg_map();
> > 	+	init_xr21b142x_reg_map();
> > 	+	init_xr21b1411_reg_map();
> > 	+	init_xr21v141x_reg_map();
> > 	+
> > 	+	if ((xrusb->DeviceProduct & 0xfff0) == 0x1400)
> > 	+		memcpy(&(xrusb->reg_map), &xr2280x_reg_map,
> > 	+			sizeof(struct reg_addr_map));
> > 	+	else if ((xrusb->DeviceProduct & 0xFFF0) == 0x1420)
> > 	+		memcpy(&(xrusb->reg_map), &xr21b142x_reg_map,
> > 	+			sizeof(struct reg_addr_map));
> > 	+	else if (xrusb->DeviceProduct == 0x1411)
> > 	+		memcpy(&(xrusb->reg_map), &xr21b1411_reg_map,
> > 	+			sizeof(struct reg_addr_map));
> > 	+	else if ((xrusb->DeviceProduct & 0xfff0) == 0x1410)
> > 	+		memcpy(&(xrusb->reg_map), &xr21v141x_reg_map,
> > 	+			sizeof(struct reg_addr_map));
> > 	+	else
> > 	+		rv = -1;
> > 
> > Note: Please don't be confused by "reg_map" name. This has nothing
> >       to do with Linux regmap API ;-)
> > 
> > What happens is that different USB IDs have different values for
> > each register. So, for instance, the UART enable register is set to
> > either one of the following values, depending on the value of
> > udev->descriptor.idProduct:
> > 
> > 	xr21b140x_reg_map.uart_enable_addr = 0x00;
> > 	xr21b1411_reg_map.uart_enable_addr = 0xc00;
> > 	xr21v141x_reg_map.uart_enable_addr = 0x03;
> > 	xr21b142x_reg_map.uart_enable_addr = 0x00;
> > 
> > There are other values that depend on the probing time detection,
> > based on other USB descriptors. Those set several fields at the
> > priv data that would allow to properly map the registers.
> > 
> > Also, there are 4 models that support multiple channels. On those,
> > there are one pair of register get/set for each channel.
> > 
> > -
> > 
> > In summary, while supporting just 04e2:1411 there's no need for
> > a private struct, in order to properly support the other models,
> > some autodetection is needed. The best way of doing that is to
> > re-add the .probe method and adding a priv struct.
> > 
> > As I dunno why this was dropped in the first place, I'm wondering
> > if it would be ok to re-introduce them.  
> 
> Sure. It was just not needed if we were only going to support one model.
> 
> > To be clear: my main focus here is just to avoid needing to use 
> > Windows in order to use the serial console of the hardware with
> > the 0x1424 variant ;-)
> > 
> > I can't test the driver with the other hardware, but, IMHO, instead
> > of adding a hack to support 0x1424, the better (but more painful)
> > would be to re-add the auto-detection part and support for the
> > other models.  
> 
> Sounds good to me. 

Great! I'll work on a patch and submit when done.

Thanks!
Mauro
