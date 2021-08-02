Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD093DE01D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhHBTe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhHBTeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:34:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0372DC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 12:34:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso166959wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rq+ltFtxq6QGLrtVVVbQSe4ITIw9nhfOELXOR4+25M8=;
        b=WDO6Iv1WYEdJv/5NagVRmkCqItY7nRIKa/vbCV+ywo7s4c1NXCgIBpDjaHAJMLqjiZ
         SXgSyoQ6OT7slAXY0kJ7sFa0HqI9xxccDl1hnF1NLNmip2fif7n/j4m6xaK3fmdR7LJu
         FEIhQvJJCW5/GR62rSZadpoN46kdpmiDPq+p+UEpA+Rz6Vh+EWc9MGEXAWOVA7JTPc2G
         JYHRhqJ4X0uM4uNJ6M/IYuG/atMUfx4eABSsiokxxLq/RcS/mH76eird8nuGqu7M7z3Q
         U1XEsuh6ZtnOtc4IrX18OrKhXdvArS+Ask8dWaenDevhtBGUhMqksB9yWxUXFu2l/8gr
         XPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rq+ltFtxq6QGLrtVVVbQSe4ITIw9nhfOELXOR4+25M8=;
        b=bkLPegt8ixmhGtdBKuUvavJLWI64xWxxpIyWUBcLfSwD6UMXAhZ1bg+xhPvaFmMvq5
         Trg8meBFiH7MO3CddaJggPG2cwQW/GPszB44n8zjb6ugEisJsdwuEacdbA+QWaLIzzAS
         ObSMWGfT2Z1zyBLfJznMZOo+NCW0/tp+NIVG79vUG3yX1DhZ+GukU46ru81ZiJJdtxid
         GaX9DEf1Kgd9J9RLTqDghvsHypdi+nTnd6gqYmp6OuY0xh+t26ilaTgjtITgOdPVHzfu
         Q+TtrX+BbaKuNDz0Z8NpxcLPU7JsN1O09F2GySOJ8ap8yeNl+Ml/qLgyhgNqe8cTNJO2
         ratQ==
X-Gm-Message-State: AOAM531G80fWh12Fy3z8fbfN4Pdrc+ApOJJqJVVKOgcr4sbFDxdoiEyq
        QhY/Itxpsp2JPuFTs1ZwawU=
X-Google-Smtp-Source: ABdhPJznJrBr1EuEURDODqCwO/8EN+zkbGJXUmQZlfx/e/94iIMiABsuh7ekN13mEXL1XkPUVWq4og==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr8177620wme.22.1627932854633;
        Mon, 02 Aug 2021 12:34:14 -0700 (PDT)
Received: from pc ([196.235.140.151])
        by smtp.gmail.com with ESMTPSA id o2sm10950571wmq.30.2021.08.02.12.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 12:34:14 -0700 (PDT)
Date:   Mon, 2 Aug 2021 20:34:11 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH v2] bluetooth: bcm203x: update the reference count of udev
Message-ID: <20210802193411.GA1006176@pc>
References: <20210731154102.GA908767@pc>
 <9B2209B6-D371-432B-A3F5-F1CD7C7967A3@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B2209B6-D371-432B-A3F5-F1CD7C7967A3@holtmann.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021 at 08:01:06PM +0200, Marcel Holtmann wrote:
> Hi Salah,
> 
> > Use usb_get_dev() to increment the reference count of the usb device
> > structure in order to avoid releasing the structure while it is still in
> > use. And use usb_put_dev() to decrement the reference count and thus,
> > when it will be equal to 0 the structure will be released.
> > 
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---
> > Change since v1:
> > 	Modification of the description
> > 
> > drivers/bluetooth/bcm203x.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
> > index e667933c3d70..547d35425d70 100644
> > --- a/drivers/bluetooth/bcm203x.c
> > +++ b/drivers/bluetooth/bcm203x.c
> > @@ -166,7 +166,7 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
> > 	if (!data)
> > 		return -ENOMEM;
> > 
> > -	data->udev  = udev;
> > +	data->udev  = usb_get_dev(udev);
> > 	data->state = BCM203X_LOAD_MINIDRV;
> > 
> > 	data->urb = usb_alloc_urb(0, GFP_KERNEL);
> > @@ -244,6 +244,8 @@ static void bcm203x_disconnect(struct usb_interface *intf)
> > 
> > 	usb_set_intfdata(intf, NULL);
> > 
> > +	usb_put_dev(data->udev);
> > +
> > 	usb_free_urb(data->urb);
> > 	kfree(data->fw_data);
> > 	kfree(data->buffer);
> 
> I do not understand this. If this is something broken, then it is broken in
> btusb.c as well and that driver is heavily used by all sorts of devices. So
> we should have seen bug reports about this.
> 
> Regards
> 
> Marcel
> 
Hi Marcel,

The patch is based on the following documentation of usb_get_dev():

[quote]
Each live reference to a device should be refcounted.

Drivers for USB interfaces should normally record such references in their
probe() methods, when they bind to an interface, and release them by calling 
usb_put_dev(), in their disconnect() methods.
[/quote]

Regards

Salah
