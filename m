Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16597377D85
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhEJHyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhEJHyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:54:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C609F61432;
        Mon, 10 May 2021 07:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620633211;
        bh=wV3FOLsGdsluxhFslcLsHxy+AdeTNM4HCjlqOyw8ROE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgWERDec1CKd5z258dmNZiTSDmZUd7j+lrmyvoP6wGaPV2+gMFz9VyTlLYsumzKBj
         8e8+MknFuChqV1W9r6u8YkG8oCEk/N5DvsItr20nsQiKDw/2+a9buQkEnRahpFus/V
         o42L843gdqjYEAledknFgiP1cKSp1nHDGhVjy8Y9a0MfFTVRZVUh73Gqd4sc/2CiR1
         9GwG5ugY9lXd3C7zmsu9SZWqGrxI6bZRwjYUqvNVbLuJwvEBgWUMkzmQM3DXfQ9dCO
         xxLatJQWh3K1j4BC6IRuLPQoPixw0YyfYAMvCVXcn+2w5VoCFVbuieYGL764bp9/Nn
         VZs+8GXe7kXWA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lg0jN-0000Hu-Vh; Mon, 10 May 2021 09:53:34 +0200
Date:   Mon, 10 May 2021 09:53:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Frank Zago <frank@zago.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, linux-usb@vger.kernel.org,
        gunar@schorcht.net
Subject: Re: [PATCH v2 2/2] USB: misc: Add driver for the WCH CH341 in
 I2C/GPIO mode
Message-ID: <YJjmfce0WKoFx35z@hovoldconsulting.com>
References: <20210423002852.3904-1-frank@zago.net>
 <20210423002852.3904-2-frank@zago.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423002852.3904-2-frank@zago.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 07:28:52PM -0500, Frank Zago wrote:
> From: frank zago <frank@zago.net>
> 
> The CH341 is a multifunction chip, presenting 3 different USB PID. One
> of these functions is for I2C/SPI/GPIO. This new driver manages I2C
> and GPIO. A future update will manage the SPI part as well.
> 
> The I2C interface can run at 4 different speeds. This driver currently
> only offer 100MHz. Tested with a variety of I2C sensors, and the IIO
> subsystem.
> 
> The GPIO interface offers 8 GPIOs. 6 are read/write, and 2 are
> rea-only. However the SPI interface will use 6 of them, leaving 2
> available GPIOs.
> 
> Signed-off-by: frank zago <frank@zago.net>
> ---
> 
> Changes from v1:
>   - Removed double Signed-off-by
>   - Move Kconfig into the same directory as the driver
> 
>  MAINTAINERS                         |   6 +
>  drivers/usb/misc/Kconfig            |   2 +
>  drivers/usb/misc/Makefile           |   1 +
>  drivers/usb/misc/ch341/Kconfig      |  17 ++
>  drivers/usb/misc/ch341/Makefile     |   3 +
>  drivers/usb/misc/ch341/ch341-core.c |  87 +++++++++
>  drivers/usb/misc/ch341/ch341-gpio.c | 249 ++++++++++++++++++++++++++
>  drivers/usb/misc/ch341/ch341-i2c.c  | 267 ++++++++++++++++++++++++++++
>  drivers/usb/misc/ch341/ch341.h      |  50 ++++++
>  9 files changed, 682 insertions(+)

Not sure about sticking this in usb/misc. We already have an MFD driver
(dln2) for something like this with i2c and spi iirc. The difference
from regular MFDs here is that these modes are mutually exclusive.

If it was just an i2c driver with some pins to toggle, I'd say just add
it to drivers/i2c but that would probably make it harder to reuse code
for the SPI driver.

I'm not really reviewing the rest of the driver, just pointing out a few
more things that stood out below.

> +static void ch341_usb_free_device(struct ch341_device *dev)
> +{
> +	ch341_gpio_remove(dev);
> +	ch341_i2c_remove(dev);

Have you verified that the i2c subsystem can handle a device being
removed like this while in use. That wasn't the case a few years back.

> +
> +	usb_set_intfdata(dev->iface, NULL);
> +	usb_put_dev(dev->usb_dev);
> +
> +	kfree(dev);
> +}
> +
> +static int ch341_usb_probe(struct usb_interface *iface,
> +			   const struct usb_device_id *usb_id)
> +{
> +	struct ch341_device *dev;
> +	int error;
> +
> +	dev = kzalloc(sizeof(struct ch341_device), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->usb_dev = usb_get_dev(interface_to_usbdev(iface));
> +	dev->iface = iface;
> +	mutex_init(&dev->usb_lock);
> +	dev->ep_out = iface->cur_altsetting->endpoint[1].desc.bEndpointAddress;
> +	dev->ep_in = iface->cur_altsetting->endpoint[0].desc.bEndpointAddress;

NULL-deref in case a device lacks the expected endpoints.

> +
> +	usb_set_intfdata(iface, dev);
> +
> +	error = ch341_i2c_init(dev);
> +	if (error) {
> +		ch341_usb_free_device(dev);
> +		return error;
> +	}
> +
> +	error = ch341_gpio_init(dev);
> +	if (error) {
> +		ch341_usb_free_device(dev);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ch341_usb_disconnect(struct usb_interface *usb_if)
> +{
> +	struct ch341_device *dev = usb_get_intfdata(usb_if);
> +
> +	ch341_usb_free_device(dev);
> +}

> +int ch341_gpio_init(struct ch341_device *dev)
> +{
> +	struct gpio_chip *gpio = &dev->gpio;
> +	int result;
> +
> +	gpio->label = "ch341";
> +	gpio->parent = &dev->usb_dev->dev;
> +	gpio->owner = THIS_MODULE;
> +	gpio->get_direction = ch341_gpio_get_direction;
> +	gpio->direction_input = ch341_gpio_direction_input;
> +	gpio->direction_output = ch341_gpio_direction_output;
> +	gpio->get = ch341_gpio_get;
> +	gpio->get_multiple = ch341_gpio_get_multiple;
> +	gpio->set = ch341_gpio_set;
> +	gpio->set_multiple = ch341_gpio_set_multiple;
> +	gpio->dbg_show = ch341_gpio_dbg_show;
> +	gpio->base = -1;
> +	gpio->ngpio = CH341_GPIO_NUM_PINS;
> +	gpio->names = gpio_names;

Last time I checked (a few weeks ago) you could still not set names for
hotpluggable devices of which there could be more than one or you'd get
a warning when plugging a second device in. Not sure if Linus W fixed
that yet.

Johan
