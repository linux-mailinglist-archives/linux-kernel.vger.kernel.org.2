Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9539E325524
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhBYSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:07:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233266AbhBYSEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:04:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8788864DE8;
        Thu, 25 Feb 2021 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614276250;
        bh=GDJ9rQByd+aP28IO2x5LLTh9+OBOiVJmh+W7RwWVMlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pkQj7SQfbsgCywxTy3y6+3AkDmjS9OwH6pKdpKa0wKIFjlIcfWXa0PHJSd3um3SwA
         xSfcvOztN1uf2ovTlIhHa+eXHh6TKRe4rOvXg+V2NT3o1Xfi1kSEfTTLTiqQbVuVM3
         y/DSdIx5qcL2ij969kbqw8OXdqZKzQaoJQ/YJOoJIAxX+1efFiICosGDiZObxnQ30X
         WH6MOajC67Q2gqb2B+PT6pApCknmoY1KaWj7TlCKHvTBKJIJ1QlZTLVpsQJqEqcqgm
         YTgrd7dEYYxEd3uJUJ5kiEER8s4ORkLYHJb8r32ns7L7asex8Tj+VVqD1jZFmTYJOV
         lbLcHK1zrDwDg==
Date:   Thu, 25 Feb 2021 19:04:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, patong.mxl@gmail.com,
        linus.walleij@linaro.org, angelo.dureghello@timesys.com
Subject: Re: [PATCH v5 1/3] usb: serial: Add MaxLinear/Exar USB to Serial
 driver
Message-ID: <20210225190405.1f796da8@coco.lan>
In-Reply-To: <20210225185820.0ae38ca6@coco.lan>
References: <20201122170822.21715-1-mani@kernel.org>
        <20201122170822.21715-2-mani@kernel.org>
        <YAlVLOqzx8otPgOg@hovoldconsulting.com>
        <20210126154604.GC29751@thinkpad>
        <YBBCvHvduivta07b@hovoldconsulting.com>
        <20210222161119.0bd70a2b@coco.lan>
        <YDPSGE5vLphfFNJn@hovoldconsulting.com>
        <20210225185820.0ae38ca6@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Feb 2021 18:58:20 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Mon, 22 Feb 2021 16:47:36 +0100
> Johan Hovold <johan@kernel.org> escreveu:
> 
> > On Mon, Feb 22, 2021 at 04:27:34PM +0100, Mauro Carvalho Chehab wrote:
> > > Hi Johan,
> > > 
> > > Em Tue, 26 Jan 2021 17:26:36 +0100
> > > Johan Hovold <johan@kernel.org> escreveu:
> > >   
> > > > On Tue, Jan 26, 2021 at 09:16:04PM +0530, Manivannan Sadhasivam wrote:  
> > > > > On Thu, Jan 21, 2021 at 11:19:24AM +0100, Johan Hovold wrote:    
> > > > > > On Sun, Nov 22, 2020 at 10:38:20PM +0530, Manivannan Sadhasivam wrote:    
> > > > > > > Add support for MaxLinear/Exar USB to Serial converters. This driver
> > > > > > > only supports XR21V141X series but it can be extended to other series
> > > > > > > from Exar as well in future.    
> > 
> > > I'm now facing an issue with this driver. I have here two different
> > > boards with those USB UART from MaxLinear/Exar.
> > > 
> > > The first one is identical to Mani's one:
> > > 	USB_DEVICE(0x04e2, 0x1411)
> > > The second one is a different version of it:
> > > 	USB_DEVICE(0x04e2, 0x1424)
> > > 
> > > By looking at the final driver merged at linux-next, it sounds that
> > > somewhere during the review of this series, it lost the priv struct,
> > > and the xr_probe function. It also lost support for all MaxLinear/Exar
> > > devices, except for just one model (04e2:1411).
> > > 
> > > The original submission:
> > > 
> > > 	https://lore.kernel.org/linux-usb/20180404070634.nhspvmxcjwfgjkcv@advantechmxl-desktop
> > > 
> > > And the manufacturer's Linux driver on their website:
> > > 
> > > 	https://www.maxlinear.com/support/design-tools/software-drivers
> > > 
> > > Had support for other 12 different models of the MaxLinear/Exar USB
> > > UART.   
> > 
> > IIRC Manivannan only had access to one of these models and his original
> > submission (based on the patch you link to above) didn't include support
> > for the others. And keeping the type abstraction didn't make sense for
> > just one model.
> > 
> > > Those are grouped into 5 different major types:
> > > 
> > > 	+	init_xr2280x_reg_map();
> > > 	+	init_xr21b142x_reg_map();
> > > 	+	init_xr21b1411_reg_map();
> > > 	+	init_xr21v141x_reg_map();
> > > 	+
> > > 	+	if ((xrusb->DeviceProduct & 0xfff0) == 0x1400)
> > > 	+		memcpy(&(xrusb->reg_map), &xr2280x_reg_map,
> > > 	+			sizeof(struct reg_addr_map));
> > > 	+	else if ((xrusb->DeviceProduct & 0xFFF0) == 0x1420)
> > > 	+		memcpy(&(xrusb->reg_map), &xr21b142x_reg_map,
> > > 	+			sizeof(struct reg_addr_map));
> > > 	+	else if (xrusb->DeviceProduct == 0x1411)
> > > 	+		memcpy(&(xrusb->reg_map), &xr21b1411_reg_map,
> > > 	+			sizeof(struct reg_addr_map));
> > > 	+	else if ((xrusb->DeviceProduct & 0xfff0) == 0x1410)
> > > 	+		memcpy(&(xrusb->reg_map), &xr21v141x_reg_map,
> > > 	+			sizeof(struct reg_addr_map));
> > > 	+	else
> > > 	+		rv = -1;
> > > 
> > > Note: Please don't be confused by "reg_map" name. This has nothing
> > >       to do with Linux regmap API ;-)
> > > 
> > > What happens is that different USB IDs have different values for
> > > each register. So, for instance, the UART enable register is set to
> > > either one of the following values, depending on the value of
> > > udev->descriptor.idProduct:
> > > 
> > > 	xr21b140x_reg_map.uart_enable_addr = 0x00;
> > > 	xr21b1411_reg_map.uart_enable_addr = 0xc00;
> > > 	xr21v141x_reg_map.uart_enable_addr = 0x03;
> > > 	xr21b142x_reg_map.uart_enable_addr = 0x00;
> > > 
> > > There are other values that depend on the probing time detection,
> > > based on other USB descriptors. Those set several fields at the
> > > priv data that would allow to properly map the registers.
> > > 
> > > Also, there are 4 models that support multiple channels. On those,
> > > there are one pair of register get/set for each channel.
> > > 
> > > -
> > > 
> > > In summary, while supporting just 04e2:1411 there's no need for
> > > a private struct, in order to properly support the other models,
> > > some autodetection is needed. The best way of doing that is to
> > > re-add the .probe method and adding a priv struct.
> > > 
> > > As I dunno why this was dropped in the first place, I'm wondering
> > > if it would be ok to re-introduce them.  
> > 
> > Sure. It was just not needed if we were only going to support one model.
> > 
> > > To be clear: my main focus here is just to avoid needing to use 
> > > Windows in order to use the serial console of the hardware with
> > > the 0x1424 variant ;-)
> > > 
> > > I can't test the driver with the other hardware, but, IMHO, instead
> > > of adding a hack to support 0x1424, the better (but more painful)
> > > would be to re-add the auto-detection part and support for the
> > > other models.  
> > 
> > Sounds good to me. 
> 
> While testing the xr_serial (as currently merged), I opted to apply
> the patches on the top of vanilla Kernel 5.11 - as it sounds too risky
> to use linux-next so early on a new development cycle :-)
> 
> There, I'm getting an OOPS:
> 
> 	[   30.261291] BUG: kernel NULL pointer dereference, address: 00000000000000a8
> 	[   30.261375] #PF: supervisor write access in kernel mode
> 	[   30.261438] #PF: error_code(0x0002) - not-present page
> 	[   30.261500] PGD 0 P4D 0 
> 	[   30.261539] Oops: 0002 [#1] SMP PTI
> 	[   30.261586] CPU: 2 PID: 686 Comm: kworker/2:3 Not tainted 5.11.0+ #14
> 	[   30.261666] Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0380.2019.0517.1530 05/17/2019
> 	[   30.261757] Workqueue: usb_hub_wq hub_event
> 	[   30.261816] RIP: 0010:mutex_lock+0x1e/0x40
> 	[   30.261875] Code: c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 fc e8 8d dd ff ff 31 c0 65 48 8b 14 25 c0 7b 01 00 <f0> 49 0f b1 14 24 75 04 41 5c 5d c3 4c 89 e7 e8 ae ff ff ff 41 5c
> 	[   30.262076] RSP: 0018:ffffb937c0767b70 EFLAGS: 00010246
> 	[   30.262140] RAX: 0000000000000000 RBX: ffff95e71ef75430 RCX: 0000000000000027
> 	[   30.262223] RDX: ffff95e70597b000 RSI: 00000000ffffdfff RDI: 00000000000000a8
> 	[   30.262305] RBP: ffffb937c0767b78 R08: ffff95ea76d18ac0 R09: ffffb937c0767948
> 	[   30.262387] R10: 0000000000000001 R11: 0000000000000001 R12: 00000000000000a8
> 	[   30.262469] R13: 0000000000000000 R14: ffff95e71ef75400 R15: 0000000000000000
> 	[   30.262551] FS:  0000000000000000(0000) GS:ffff95ea76d00000(0000) knlGS:0000000000000000
> 	[   30.262645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[   30.262713] CR2: 00000000000000a8 CR3: 000000042be0a002 CR4: 00000000003706e0
> 	[   30.262796] Call Trace:
> 	[   30.262832]  usb_serial_disconnect+0x33/0x140
> 	[   30.262897]  usb_unbind_interface+0x8c/0x260
> 	[   30.262957]  device_release_driver_internal+0x103/0x1d0
> 	[   30.263026]  device_release_driver+0x12/0x20
> 	[   30.263083]  bus_remove_device+0xe1/0x150
> 	[   30.263140]  device_del+0x192/0x3f0
> 	[   30.263188]  ? usb_remove_ep_devs+0x1f/0x30
> 	[   30.263244]  usb_disable_device+0x95/0x1c0
> 	[   30.263300]  usb_disconnect+0xc0/0x270
> 	[   30.263350]  hub_event+0xa2e/0x1620
> 
> After adding this hack:
> 
> <snip>
> --- a/drivers/usb/serial/usb-serial.c
> +++ b/drivers/usb/serial/usb-serial.c
> @@ -1081,6 +1081,11 @@ static void usb_serial_disconnect(struct usb_interface *interface)
>         struct usb_serial_port *port;
>         struct tty_struct *tty;
>  
> +       if (!serial) {
> +               dev_err(dev, "%s: Serial pointer is NULL!!!\n", __func__);
> +               return;
> +       }
> +
>         usb_serial_console_disconnect(serial);
>  
>         mutex_lock(&serial->disc_mutex);
> </snip>
> 
> It works fine:
> 
> 	[  283.005625] xr_serial 2-1:1.1: xr_serial converter detected
> 	[  283.005868] usb 2-1: xr_serial converter now attached to ttyUSB0
> 	[  283.007284] printk: console [ttyUSB0] enabled
> 	[  284.444419] usb 2-1: USB disconnect, device number 5
> 	[  284.444520] xr_serial 2-1:1.0: usb_serial_disconnect: Serial pointer is NULL!!!
> 	[  284.444894] printk: console [ttyUSB0] disabled
> 	[  284.445091] xr_serial ttyUSB0: xr_serial converter now disconnected from ttyUSB0
> 	[  284.445141] xr_disconnect
> 	[  284.445156] xr_serial 2-1:1.1: device disconnected
> 
> I'm not sure if the bug is at xr_serial or if it is inside usb-serial.c.
> 
> Any ideas?

Answering myself, as those devices may have two different interfaces
(one for control and another one for data), I suspect that the
driver needs to manually call usb_set_intfdata() after detecting the
data interface.

Thanks,
Mauro
