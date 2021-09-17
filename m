Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6866440FC11
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbhIQPUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344232AbhIQPSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:18:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE50960FA0;
        Fri, 17 Sep 2021 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631891846;
        bh=Rha9qS4P7Kw5BUuskxJB40BT1KDucDflV8GV6p8ZoCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLFUy0UpeWKyQu2h/M0Jp4yGKHnVhKUMAhhWTLgG6N2Jx6eQj3B1ZMY0/dFCeaLh+
         1FtGoWXbN1NextHd1sGDFPS1WZjhUYq/5tSAAYdq6roqDgipLbP0PTwgEt609XOSzf
         cngHqTBB5iGNJ8Uy2osiAwZFjKj3faSQ4Aeilk/I=
Date:   Fri, 17 Sep 2021 17:17:23 +0200
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 17/19] staging: r8188eu: shorten calls chain of
 rtw_read{8,16,32}()
Message-ID: <YUSxg6LfUsib1P45@kroah.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
 <20210917071837.10926-18-fmdefrancesco@gmail.com>
 <YUSrIqW5WSYuoa14@kroah.com>
 <0331c99f809449e88e5e5be9311aa5a9@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0331c99f809449e88e5e5be9311aa5a9@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 03:01:27PM +0000, David Laight wrote:
> From: Greg Kroah-Hartman
> > Sent: 17 September 2021 15:50
> ...
> > > +static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
> > > +{
> > > +	struct adapter *adapt = intfhdl->padapter;
> > > +	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
> > > +	struct usb_device *udev = dvobjpriv->pusbdev;
> > > +	int status;
> > > +	u8 *io_buf; /* Pointer to I/O buffer */
> > 
> > As you "know" size is not going to be larger than 4 (hint, you should
> > prboably check it), just use bytes off of the stack here, and you can
> > ignore this buffer entirely.  That will hopefully allow you in the
> > future to get rid of that buffer as odds are it will not be needed
> > anymore.
> 
> Isn't that likely to be the buffer that gets dma'd to/from?
> In which case it can't be on-stack.
> Certainly that is a common problem with usb drivers.

Yes it was a problem, which is why the USB core function called here
does not require that and makes sure to allocate the buffer itself so
that all will be fine.

> Give the size of the urb? structure allocated for each transfer
> adding a bounce buffer area in it for short transfers would
> surely be sane.

USB speeds are slow you will never notice the difference for control
messages.

thanks,

greg k-h
