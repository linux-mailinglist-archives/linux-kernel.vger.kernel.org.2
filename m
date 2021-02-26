Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE0F3260FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhBZKKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:10:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhBZKH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:07:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3A7B64EC8;
        Fri, 26 Feb 2021 10:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614334007;
        bh=uqGZSC/PHzNFwaCk1bS7DnKyCBFZztLa7wkzewkwZuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhTKngNLyonN/UEwjQ1Wnopa3/5KEIfjVAhkRESfl9UX/YrXQB1h3sh+OZtC8p/bT
         QrCfTdbejg4DSk7KVFO8EctbfONLrY2lrckXsMjutWKklF7xMf9KBmGUq4t9yAO5mr
         XpyYltpYUC2YbZMe74e7FNpjqexF9j+2Eg/IKnZHrryBd/7vQiVEE+UeAsrxtyoO/T
         o3F9llUDrz8SBXJBUH/J0ZXS07g+q6Goj1HW/xipEiWkbvdvG8Xq9FqqWRDuubqjp4
         89AiZPX50NPG2Q7OWEihcwknCi0LZkDtMO1YlVEqnOnvhNqlSFgAVJI8ZqPux6vIYa
         yHwAA2PxikwVw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lFa1b-0004vR-0i; Fri, 26 Feb 2021 11:07:07 +0100
Date:   Fri, 26 Feb 2021 11:07:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, patong.mxl@gmail.com,
        linus.walleij@linaro.org, angelo.dureghello@timesys.com
Subject: Re: [PATCH v5 1/3] usb: serial: Add MaxLinear/Exar USB to Serial
 driver
Message-ID: <YDjIS1QTVuy11nhA@hovoldconsulting.com>
References: <20201122170822.21715-1-mani@kernel.org>
 <20201122170822.21715-2-mani@kernel.org>
 <YAlVLOqzx8otPgOg@hovoldconsulting.com>
 <20210126154604.GC29751@thinkpad>
 <YBBCvHvduivta07b@hovoldconsulting.com>
 <20210222161119.0bd70a2b@coco.lan>
 <YDPSGE5vLphfFNJn@hovoldconsulting.com>
 <20210225185820.0ae38ca6@coco.lan>
 <20210225190405.1f796da8@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225190405.1f796da8@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:04:05PM +0100, Mauro Carvalho Chehab wrote:
> Em Thu, 25 Feb 2021 18:58:20 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> > While testing the xr_serial (as currently merged), I opted to apply
> > the patches on the top of vanilla Kernel 5.11 - as it sounds too risky
> > to use linux-next so early on a new development cycle :-)
> > 
> > There, I'm getting an OOPS:
> > 
> > 	[   30.261291] BUG: kernel NULL pointer dereference, address: 00000000000000a8
> > 	[   30.261375] #PF: supervisor write access in kernel mode
> > 	[   30.261438] #PF: error_code(0x0002) - not-present page
> > 	[   30.261500] PGD 0 P4D 0 
> > 	[   30.261539] Oops: 0002 [#1] SMP PTI
> > 	[   30.261586] CPU: 2 PID: 686 Comm: kworker/2:3 Not tainted 5.11.0+ #14
> > 	[   30.261666] Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0380.2019.0517.1530 05/17/2019
> > 	[   30.261757] Workqueue: usb_hub_wq hub_event
> > 	[   30.261816] RIP: 0010:mutex_lock+0x1e/0x40

> > 	[   30.262796] Call Trace:
> > 	[   30.262832]  usb_serial_disconnect+0x33/0x140
> > 	[   30.262897]  usb_unbind_interface+0x8c/0x260
> > 	[   30.262957]  device_release_driver_internal+0x103/0x1d0
> > 	[   30.263026]  device_release_driver+0x12/0x20
> > 	[   30.263083]  bus_remove_device+0xe1/0x150
> > 	[   30.263140]  device_del+0x192/0x3f0
> > 	[   30.263188]  ? usb_remove_ep_devs+0x1f/0x30
> > 	[   30.263244]  usb_disable_device+0x95/0x1c0
> > 	[   30.263300]  usb_disconnect+0xc0/0x270
> > 	[   30.263350]  hub_event+0xa2e/0x1620
> > 
> > After adding this hack:
> > 
> > <snip>
> > --- a/drivers/usb/serial/usb-serial.c
> > +++ b/drivers/usb/serial/usb-serial.c
> > @@ -1081,6 +1081,11 @@ static void usb_serial_disconnect(struct usb_interface *interface)
> >         struct usb_serial_port *port;
> >         struct tty_struct *tty;
> >  
> > +       if (!serial) {
> > +               dev_err(dev, "%s: Serial pointer is NULL!!!\n", __func__);
> > +               return;
> > +       }
> > +
> >         usb_serial_console_disconnect(serial);
> >  
> >         mutex_lock(&serial->disc_mutex);
> > </snip>
> > 
> > It works fine:
> > 
> > 	[  283.005625] xr_serial 2-1:1.1: xr_serial converter detected
> > 	[  283.005868] usb 2-1: xr_serial converter now attached to ttyUSB0
> > 	[  283.007284] printk: console [ttyUSB0] enabled
> > 	[  284.444419] usb 2-1: USB disconnect, device number 5
> > 	[  284.444520] xr_serial 2-1:1.0: usb_serial_disconnect: Serial pointer is NULL!!!
> > 	[  284.444894] printk: console [ttyUSB0] disabled
> > 	[  284.445091] xr_serial ttyUSB0: xr_serial converter now disconnected from ttyUSB0
> > 	[  284.445141] xr_disconnect
> > 	[  284.445156] xr_serial 2-1:1.1: device disconnected
> > 
> > I'm not sure if the bug is at xr_serial or if it is inside usb-serial.c.
> > 
> > Any ideas?
> 
> Answering myself, as those devices may have two different interfaces
> (one for control and another one for data), I suspect that the
> driver needs to manually call usb_set_intfdata() after detecting the
> data interface.

Thanks for reporting this.

I'm afraid it's a bit more involved than that; we'd need to add support
to USB-serial core for managing a sibling interface and either one being
disconnected first. This has implications for suspend as well.

I think we should just not claim the control interface for now since it
not currently used by the driver. I'll send a fix.

Johan
