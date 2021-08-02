Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362693DE087
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 22:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhHBUQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 16:16:33 -0400
Received: from netrider.rowland.org ([192.131.102.5]:42781 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229729AbhHBUQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:16:31 -0400
Received: (qmail 344224 invoked by uid 1000); 2 Aug 2021 16:16:20 -0400
Date:   Mon, 2 Aug 2021 16:16:20 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH v2] bluetooth: bcm203x: update the reference count of udev
Message-ID: <20210802201620.GA344022@rowland.harvard.edu>
References: <20210731154102.GA908767@pc>
 <9B2209B6-D371-432B-A3F5-F1CD7C7967A3@holtmann.org>
 <20210802193411.GA1006176@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802193411.GA1006176@pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 08:34:11PM +0100, Salah Triki wrote:
> On Sun, Aug 01, 2021 at 08:01:06PM +0200, Marcel Holtmann wrote:
> > Hi Salah,
> > 
> > > Use usb_get_dev() to increment the reference count of the usb device
> > > structure in order to avoid releasing the structure while it is still in
> > > use. And use usb_put_dev() to decrement the reference count and thus,
> > > when it will be equal to 0 the structure will be released.
> > > 
> > > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > > ---
> > > Change since v1:
> > > 	Modification of the description
> > > 
> > > drivers/bluetooth/bcm203x.c | 4 +++-
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
> > > index e667933c3d70..547d35425d70 100644
> > > --- a/drivers/bluetooth/bcm203x.c
> > > +++ b/drivers/bluetooth/bcm203x.c
> > > @@ -166,7 +166,7 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
> > > 	if (!data)
> > > 		return -ENOMEM;
> > > 
> > > -	data->udev  = udev;
> > > +	data->udev  = usb_get_dev(udev);
> > > 	data->state = BCM203X_LOAD_MINIDRV;
> > > 
> > > 	data->urb = usb_alloc_urb(0, GFP_KERNEL);
> > > @@ -244,6 +244,8 @@ static void bcm203x_disconnect(struct usb_interface *intf)
> > > 
> > > 	usb_set_intfdata(intf, NULL);
> > > 
> > > +	usb_put_dev(data->udev);
> > > +
> > > 	usb_free_urb(data->urb);
> > > 	kfree(data->fw_data);
> > > 	kfree(data->buffer);
> > 
> > I do not understand this. If this is something broken, then it is broken in
> > btusb.c as well and that driver is heavily used by all sorts of devices. So
> > we should have seen bug reports about this.
> > 
> > Regards
> > 
> > Marcel
> > 
> Hi Marcel,
> 
> The patch is based on the following documentation of usb_get_dev():
> 
> [quote]
> Each live reference to a device should be refcounted.
> 
> Drivers for USB interfaces should normally record such references in their
> probe() methods, when they bind to an interface, and release them by calling 
> usb_put_dev(), in their disconnect() methods.
> [/quote]

That documentation is incorrect.  It is not necessary for drivers to 
take a reference to the devices they are bound to.  Properly written 
subsystems will guarantee that the driver is unbound from the device 
before the device is released.

To put it another way, if failure to take such a reference leads to an 
invalid memory access then there is a bug in the subsystem, not in the 
driver.

Rather than changing the bcm203x driver, you should consider getting rid 
of the unnecessary advice in the documentation of usb_get_dev.

Alan Stern
