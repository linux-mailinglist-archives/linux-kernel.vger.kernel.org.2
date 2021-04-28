Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5A36D4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbhD1Jgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhD1Jgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:36:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C684E61428;
        Wed, 28 Apr 2021 09:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619602560;
        bh=jKHfWNZUnTiHEDbmhLO7BahmUmrcCdo6zc8xId/K0nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKPIxjEVESzVXPgrZiZZeISygAew5oqfsSmFLqHs5PSpXroCiOJpLxyIa3qXiS9L8
         mzkOXFfoxBJORC4rYdbRNxa/TfOnXdEdRqk51wltNoq8pNWslwQBJrVGpIq2EuWVq5
         dXQCisRkhIoTT36VZjAIzBSp3QOMAmkrwiOkecXK7ROsUG8t1SPgSj936rtPV1lMXd
         PtcTBDkOOaxmC7pNumxZXiB+DJBQOnuwke16/1u90mSp/QPNP8Yp2Vt8npOYyyw6kv
         JsvRAxoNk2Z7FyJayNDoRHDQVSJYX+aaMtiAJNRnKNuMMYfe1fL8BQeo9FrAOr045Y
         AmRB7xsXd4L/A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lbgc9-0003pz-EV; Wed, 28 Apr 2021 11:36:14 +0200
Date:   Wed, 28 Apr 2021 11:36:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tung Pham <Tung.Pham@silabs.com>
Cc:     Pho Tran <photranvan0712@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Pho Tran <Pho.Tran@silabs.com>
Subject: Re: [PATCH v9] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YIksjb9IjOwSpPgw@hovoldconsulting.com>
References: <20210408103607.2077-1-photranvan0712@gmail.com>
 <YIA8HD0S6C+x5ZC9@hovoldconsulting.com>
 <CO1PR11MB48829DEA0747C1B19278868E81429@CO1PR11MB4882.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48829DEA0747C1B19278868E81429@CO1PR11MB4882.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 09:49:37AM +0000, Tung Pham wrote:
> Dear Johan Hovold.
> Thanks for your review.
> I read you comment and answer you as following:
> 
> On Thu, Apr 08, 2021 at 05:36:07PM +0700, Pho Tran wrote:
> > From: Pho Tran <pho.tran@silabs.com>
> >
> > Similar to other CP210x devices, GPIO interfaces (gpiochip) should be 
> > supported for CP2108.
> 
> > +/*
> > + * Quad Port Config definitions
> > + * Refer to 
> > +https://www.silabs.com/documents/public/application-notes/an978-cp210
> > +x-usb-to-uart-api-specification.pdf
> > + * for more information.
> > + * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 
> > +0x49 bytes
> > + * on a CP2108 chip.
> > + * CP2108 Quad Port State structure(used in Quad Port Config 
> > +structure)  */ struct cp210x_quad_port_state {
> > +     __le16 gpio_mode_PB0;
> > +     __le16 gpio_mode_PB1;
> > +     __le16 gpio_mode_PB2;
> > +     __le16 gpio_mode_PB3;
> > +     __le16 gpio_mode_PB4;
> > +
> > +
> > +     __le16 gpio_lowpower_PB0;
> > +     __le16 gpio_lowpower_PB1;
> > +     __le16 gpio_lowpower_PB2;
> > +     __le16 gpio_lowpower_PB3;
> > +     __le16 gpio_lowpower_PB4;
> > +
> > +     __le16 gpio_latch_PB0;
> > +     __le16 gpio_latch_PB1;
> > +     __le16 gpio_latch_PB2;
> > +     __le16 gpio_latch_PB3;
> > +     __le16 gpio_latch_PB4;
> > +};
> > +
> > +// Cp2108 Quad Port Config structure
> > +struct cp210x_quad_port_config {
> > +     struct cp210x_quad_port_state reset_state;
> > +     struct cp210x_quad_port_state suspend_state;
> > +     u8 ipdelay_IFC[4];
> > +     u8 enhancedfxn_IFC[4];
> > +     u8 enhancedfxn_device;
> > +     u8 extclkfreq[4];
> > +} __packed;
> 
> One more thing; I noticed that the layout of the other port-config
> structures do not match the ones used by your library API, which is
> what the above pdf documents (e.g. they have additional padding).
> 
> Tung Pham: the layout is correct, the document add padding bit to
> align data to 8 or 16 bit, we already use      __le16, so the data is
> aligned to 16 bit.

Not sure I understand what you're saying here.

My point was simply that the layout of the other structures as expected
by the device doesn't match the layout described in you library API
documentation.

It doesn't appear to have anything to do with member alignment, it
just looks like random unused bits in the structures. Take the
single-port config, for example:

	struct cp210x_single_port_config {
		__le16	gpio_mode;
		u8	__pad0[2];
		__le16	reset_state;
		u8	__pad1[4];
		__le16	suspend_state;
		u8	device_cfg;
	} __packed;

You library API has this as:

	typedef struct _PORT_CONFIG
	{
		uint16_t Mode;
		uint16_t Reset_Latch;
		uint16_t Suspend_Latch;
		unsigned char EnhancedFxn;
	} PORT_CONFIG, *PPORT_CONFIG;

which simply doesn't match up (and there's no implicit padding between
members, only after EnhancedFxn).

So my questions again are:

 1) Have you verified that the struct cp210x_quad_port_config above
    actually matches what the device uses?

 2) Do you have any documentation of the structures as expected by the
    device firmware (not your library)?

> Did you verify that the above layout is actually correct? And did you
> try changing the pin functions in EEPROM and make sure that your code
> handles it as expected?
> 
> Tung Pham: we have tested to toggle GPIO pin in normal case, we will
> test the case that the gpio have alternative function in the future.

Great, this could be one way of verifying the above. Please do that and
let me know the result.

That part of the code has already been found broken twice during review
so you really should have tested this before submitting.

> Is there any corresponding document for the actual device protocol?
> Tung Pham:
> You can refer to 
> https://www.silabs.com/documents/public/data-sheets/cp2108-datasheet.pdf
> for understanding the functionality of cp2108.
> And 
> https://www.silabs.com/documents/public/application-notes/AN721.pdf
> for use simplicity software to configure the GPIO pin alternative function of cp2108.

Ok, but those do not document the layout of these structures either
(e.g. cp210x_single_port_config with the __pad0 and __pad1 members).

Johan
