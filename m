Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4619326171
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhBZKjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhBZKh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:37:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D28A664ED2;
        Fri, 26 Feb 2021 10:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614335835;
        bh=KezX5t7qHzkeerivTKXTAEwvqB0ifGu59UmlkxxVnj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oL0jyXORBfSNxZvBCNpelPmm2fY22L+cZOVoCAlIXD0sStf984uK/uiDoJUe8Vcrf
         8qX+SsQSq+aLN6g47Fml2jHwsJkVQoa3xgwzcq0i9O+wqdtgxkVI9wNJeSXYq0ZQdQ
         ZMvNuzB53R7w+JNlHFkMyeb/XZjayWoiAR4WnFGQ/LdD1cI32uRfiXYZVdEVZzkpuo
         D2cZUw7v8QTl+b6uZZz+oGnP15yBZjzqBO6Elb5k8ncusfSAc8dN3iu0+jqaLGX8c8
         cpSUCXrO6rpQeoo/bp3n17OAyDDYAe4e4LvW2BA9IqfqCgxRaljxfYXsrmGiKx+bMa
         wAlKgqwrZQ9+g==
Date:   Fri, 26 Feb 2021 11:37:09 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, patong.mxl@gmail.com,
        linus.walleij@linaro.org, angelo.dureghello@timesys.com
Subject: Re: [PATCH v5 1/3] usb: serial: Add MaxLinear/Exar USB to Serial
 driver
Message-ID: <20210226113709.733f6526@coco.lan>
In-Reply-To: <YDjIS1QTVuy11nhA@hovoldconsulting.com>
References: <20201122170822.21715-1-mani@kernel.org>
        <20201122170822.21715-2-mani@kernel.org>
        <YAlVLOqzx8otPgOg@hovoldconsulting.com>
        <20210126154604.GC29751@thinkpad>
        <YBBCvHvduivta07b@hovoldconsulting.com>
        <20210222161119.0bd70a2b@coco.lan>
        <YDPSGE5vLphfFNJn@hovoldconsulting.com>
        <20210225185820.0ae38ca6@coco.lan>
        <20210225190405.1f796da8@coco.lan>
        <YDjIS1QTVuy11nhA@hovoldconsulting.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Feb 2021 11:07:07 +0100
Johan Hovold <johan@kernel.org> escreveu:

> On Thu, Feb 25, 2021 at 07:04:05PM +0100, Mauro Carvalho Chehab wrote:
> > Em Thu, 25 Feb 2021 18:58:20 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:  
> 
> > > While testing the xr_serial (as currently merged), I opted to apply
> > > the patches on the top of vanilla Kernel 5.11 - as it sounds too risky
> > > to use linux-next so early on a new development cycle :-)
> > > 
> > > There, I'm getting an OOPS:
> > > 
> > > 	[   30.261291] BUG: kernel NULL pointer dereference, address: 00000000000000a8
> > > 	[   30.261375] #PF: supervisor write access in kernel mode
> > > 	[   30.261438] #PF: error_code(0x0002) - not-present page
> > > 	[   30.261500] PGD 0 P4D 0 
> > > 	[   30.261539] Oops: 0002 [#1] SMP PTI
> > > 	[   30.261586] CPU: 2 PID: 686 Comm: kworker/2:3 Not tainted 5.11.0+ #14
> > > 	[   30.261666] Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0380.2019.0517.1530 05/17/2019
> > > 	[   30.261757] Workqueue: usb_hub_wq hub_event
> > > 	[   30.261816] RIP: 0010:mutex_lock+0x1e/0x40  
> 
> > > 	[   30.262796] Call Trace:
> > > 	[   30.262832]  usb_serial_disconnect+0x33/0x140
> > > 	[   30.262897]  usb_unbind_interface+0x8c/0x260
> > > 	[   30.262957]  device_release_driver_internal+0x103/0x1d0
> > > 	[   30.263026]  device_release_driver+0x12/0x20
> > > 	[   30.263083]  bus_remove_device+0xe1/0x150
> > > 	[   30.263140]  device_del+0x192/0x3f0
> > > 	[   30.263188]  ? usb_remove_ep_devs+0x1f/0x30
> > > 	[   30.263244]  usb_disable_device+0x95/0x1c0
> > > 	[   30.263300]  usb_disconnect+0xc0/0x270
> > > 	[   30.263350]  hub_event+0xa2e/0x1620
> > > 
> > > After adding this hack:
> > > 
> > > <snip>
> > > --- a/drivers/usb/serial/usb-serial.c
> > > +++ b/drivers/usb/serial/usb-serial.c
> > > @@ -1081,6 +1081,11 @@ static void usb_serial_disconnect(struct usb_interface *interface)
> > >         struct usb_serial_port *port;
> > >         struct tty_struct *tty;
> > >  
> > > +       if (!serial) {
> > > +               dev_err(dev, "%s: Serial pointer is NULL!!!\n", __func__);
> > > +               return;
> > > +       }
> > > +
> > >         usb_serial_console_disconnect(serial);
> > >  
> > >         mutex_lock(&serial->disc_mutex);
> > > </snip>
> > > 
> > > It works fine:
> > > 
> > > 	[  283.005625] xr_serial 2-1:1.1: xr_serial converter detected
> > > 	[  283.005868] usb 2-1: xr_serial converter now attached to ttyUSB0
> > > 	[  283.007284] printk: console [ttyUSB0] enabled
> > > 	[  284.444419] usb 2-1: USB disconnect, device number 5
> > > 	[  284.444520] xr_serial 2-1:1.0: usb_serial_disconnect: Serial pointer is NULL!!!
> > > 	[  284.444894] printk: console [ttyUSB0] disabled
> > > 	[  284.445091] xr_serial ttyUSB0: xr_serial converter now disconnected from ttyUSB0
> > > 	[  284.445141] xr_disconnect
> > > 	[  284.445156] xr_serial 2-1:1.1: device disconnected
> > > 
> > > I'm not sure if the bug is at xr_serial or if it is inside usb-serial.c.
> > > 
> > > Any ideas?  
> > 
> > Answering myself, as those devices may have two different interfaces
> > (one for control and another one for data), I suspect that the
> > driver needs to manually call usb_set_intfdata() after detecting the
> > data interface.  
> 
> Thanks for reporting this.
> 
> I'm afraid it's a bit more involved than that; we'd need to add support
> to USB-serial core for managing a sibling interface and either one being
> disconnected first. This has implications for suspend as well.
> 
> I think we should just not claim the control interface for now since it
> not currently used by the driver. I'll send a fix.

Thanks!

Yeah, I had a similar patch, moving out from 
usb_driver_release_interface(), as it ends calling the serial
disconnect method.

Btw, for other xr_serial models, the driver will need to use
the control interface, as it is used to do things like
setting up the number of bits, stop bits and parity.

I'm still working on the patch.

There, I'm using usb_get_intf() in order to avoid use-after-free
at disconnect time, but I'm pretty sure something else is needed
due to PM.

FYI, that's the probe/disconnect part of the changeset. It works
fine with both XR21B1424 and XR21V1410 models.

I'm not sure if the probing part will work for the other ones. The
original driver does something a lot more complex, parsing the
CDC union tables that are present only at the control interfaces.

Adding support for parsing it, while keeping using usb-serial
as-is would be very difficult.

Perhaps the right solution would be to let usb-serial parse the
CDC union structs, for the drivers that would need that.

Maybe we could add a new probe_cdc ops (or something similar)
that would enable some logic there for it to work with separate
data and control interfaces.

Thanks,
Mauro

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 483d07dee19d..679ac10be963 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -545,39 +878,70 @@ static void xr_close(struct usb_serial_port *port)
 
 static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
 {
-	struct usb_driver *driver = serial->type->usb_driver;
-	struct usb_interface *control_interface;
-	int ret;
-
-	/* Don't bind to control interface */
-	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
+	struct usb_interface *intf = serial->interface;
+	struct usb_endpoint_descriptor *data_ep;
+	struct usb_device *udev = serial->dev;
+	struct xr_port_private *port_priv;
+	struct usb_interface *ctrl_intf;
+	int ifnum, ctrl_ifnum;
+
+	/* Attach only data interfaces */
+	ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+	if (!(ifnum % 2))
 		return -ENODEV;
 
-	/* But claim the control interface during data interface probe */
-	control_interface = usb_ifnum_to_if(serial->dev, 0);
-	if (!control_interface)
-		return -ENODEV;
+	/* Control interfaces are the even numbers */
+	ctrl_ifnum = ifnum - ifnum % 2;
 
-	ret = usb_driver_claim_interface(driver, control_interface, NULL);
-	if (ret) {
-		dev_err(&serial->interface->dev, "Failed to claim control interface\n");
-		return ret;
-	}
+	port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
+	if (!port_priv)
+		return -ENOMEM;
+
+	data_ep = &intf->cur_altsetting->endpoint[0].desc;
+	ctrl_intf = usb_ifnum_to_if(udev, ctrl_ifnum);
+
+	port_priv->data_if = intf;
+	port_priv->control_if = usb_get_intf(ctrl_intf);
+	port_priv->model = id->driver_info;
+	port_priv->channel = data_ep->bEndpointAddress;
+
+	usb_set_serial_data(serial, port_priv);
+
+	dev_info(&intf->dev, "port %d registered: control if: %d, data if: %d\n",
+		 ifnum / 2, ctrl_ifnum, ifnum);
 
 	return 0;
 }
 
 static void xr_disconnect(struct usb_serial *serial)
 {
+	struct xr_port_private *port_priv = usb_get_serial_data(serial);
 	struct usb_driver *driver = serial->type->usb_driver;
-	struct usb_interface *control_interface;
 
-	control_interface = usb_ifnum_to_if(serial->dev, 0);
-	usb_driver_release_interface(driver, control_interface);
+	usb_put_intf(port_priv->control_if);
+
+	usb_driver_release_interface(driver, port_priv->data_if);
 }
 
 static const struct usb_device_id id_table[] = {
-	{ USB_DEVICE(0x04e2, 0x1410) }, /* XR21V141X */
+	{ USB_DEVICE(0x04e2, 0x1400), .driver_info = XR2280X},
+	{ USB_DEVICE(0x04e2, 0x1401), .driver_info = XR2280X},
+	{ USB_DEVICE(0x04e2, 0x1402), .driver_info = XR2280X},
+	{ USB_DEVICE(0x04e2, 0x1403), .driver_info = XR2280X},
+
+	{ USB_DEVICE(0x04e2, 0x1410), .driver_info = XR21V141X},
+	{ USB_DEVICE(0x04e2, 0x1411), .driver_info = XR21B1411},
+	{ USB_DEVICE(0x04e2, 0x1412), .driver_info = XR21V141X},
+	{ USB_DEVICE(0x04e2, 0x1414), .driver_info = XR21V141X},
+
+	{ USB_DEVICE(0x04e2, 0x1420), .driver_info = XR21B142X},
+#if 0
+	/* FIXME: this one has just control interface! */
+	{ USB_DEVICE(0x04e2, 0x1421), .driver_info = XR21B1421},
+#endif
+	{ USB_DEVICE(0x04e2, 0x1422), .driver_info = XR21B142X},
+	{ USB_DEVICE(0x04e2, 0x1424), .driver_info = XR21B142X},
+
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, id_table);




