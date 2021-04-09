Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B9235A36F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhDIQdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234039AbhDIQdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:33:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC2E76108B;
        Fri,  9 Apr 2021 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985971;
        bh=J2DDW687Yh9w/s5QCJEKFzidf4a8mWv1gjBStkWaumc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eO1GHj/PAkYgSUMYvqZ9HfAeWYz40Yb4cMmhPitKKNLwD6wUqK21GiCascWaS3KmP
         sWCJ4X5MheghBoIzn/S+i+W99LQ2Lnj4p2qawMgjR6t8DxgWyC1mBMgrx+lICeH0OT
         h2uJNhJPmsQ/uO0F3pNnQdsOXbNCo+d/48+FHcW9acJZ3gjCrTclSR/74b9yNzphnj
         y5a4pkGoMkF/Rt3NOTVnFnclnxgYsjv5eOGBR8Py6/mUa6w43OWAAaiTvPrknPXhtL
         ONSGcRLy7cAHIN5OPAUckQRUoYJq8ffhXuuy2awWNxnoM7/SMGriRc0QXkRmBsI/W9
         ktRYUUszn/52w==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUu3s-0005lg-LJ; Fri, 09 Apr 2021 18:32:48 +0200
Date:   Fri, 9 Apr 2021 18:32:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Pho Tran <photranvan0712@gmail.com>, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] USB: serial: cp210x: add gpio-configuration debug
 printk
Message-ID: <YHCBsGuOeCWo0ylc@hovoldconsulting.com>
References: <20210409155216.31867-1-johan@kernel.org>
 <20210409155216.31867-3-johan@kernel.org>
 <CAHp75VdEgDuwrRPFm1BXQXQFSNZzC2qQnBG-DJt+GqLzJ+HwuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdEgDuwrRPFm1BXQXQFSNZzC2qQnBG-DJt+GqLzJ+HwuA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 07:22:26PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 9, 2021 at 6:52 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > Add a debug printk to dump the GPIO configuration stored in EEPROM
> > during probe.
> >
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/usb/serial/cp210x.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> > index ceb3a656a075..ee595d1bea0a 100644
> > --- a/drivers/usb/serial/cp210x.c
> > +++ b/drivers/usb/serial/cp210x.c
> > @@ -1543,10 +1543,16 @@ static int cp210x_gpio_init_valid_mask(struct gpio_chip *gc,
> >  {
> >         struct usb_serial *serial = gpiochip_get_data(gc);
> >         struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> > +       struct device *dev = &serial->interface->dev;
> >         unsigned long altfunc_mask = priv->gpio_altfunc;
> >
> >         bitmap_complement(valid_mask, &altfunc_mask, ngpios);
> >
> > +       if (bitmap_empty(valid_mask, ngpios))
> > +               dev_dbg(dev, "no pin configured for GPIO\n");
> 
> Shouldn't we drop the GPIO device completely in such a case?

I considered it when we first added support for GPIOs to this driver but
decided not to. The reason being that we want to to tell user-space that
the device has gpio capability even if the GPIOs are currently muxed (in
EEPROM) for other functionality.

> Bart, wouldn't it be a good idea for GPIO library to do something like
> this on driver's behalf?

I'd say this is mostly useful for hotpluggable devices with EEPROM
configuration and is probably best handled by the drivers.

> > +       else
> > +               dev_dbg(dev, "GPIO.%*pbl configured for GPIO\n", ngpios,
> > +                               valid_mask);
> 
> A nit-pick:
> I would change GPIO -> pin in the second message in the first occurrence.

"GPIO.n" are the actual pin names from the datasheet (cf. ftdi_sio which
use "CBUSn" here). It's just a debug statement anyway.

Johan
