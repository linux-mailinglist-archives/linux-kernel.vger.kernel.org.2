Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D3D3F3F4B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhHVMkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 08:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhHVMkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 08:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1B3361354;
        Sun, 22 Aug 2021 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629635977;
        bh=SAo5Nti0tp5MhCcr04KkCXfnusqunVy+W0Vlz/U2A0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2by95Ad3M5umDNoXNPmwp6YjKH/qUE76NYzN1QH1Ij238Fcn8Y1KGhTJAMLxjG0qy
         dB0UC3aa969OCe4GeShMtJy0WmRGWWllvUkhIt+WLpP78AHSlFQ9oKqH+hirTbR/XQ
         76b3kc93fWyOUZcQUposO1A+X+UaFbgCxqOTXuMM=
Date:   Sun, 22 Aug 2021 14:39:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
Message-ID: <YSJFhmTs74PUyo8b@kroah.com>
References: <cover.1629479152.git.paskripkin@gmail.com>
 <10584649.zhyk0TxWeL@localhost.localdomain>
 <ae27d6a0-dc00-459f-7b36-acf7f4c08d72@gmail.com>
 <2327383.5TodInGmHT@localhost.localdomain>
 <435eea22-da31-1ebc-840c-ee9e42b27265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435eea22-da31-1ebc-840c-ee9e42b27265@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 03:10:56PM +0300, Pavel Skripkin wrote:
> On 8/22/21 1:59 PM, Fabio M. De Francesco wrote:
> > On Sunday, August 22, 2021 12:09:29 PM CEST Pavel Skripkin wrote:
> > > On 8/22/21 12:53 PM, Fabio M. De Francesco wrote:
> > > > On Friday, August 20, 2021 7:07:28 PM CEST Pavel Skripkin wrote:
> > > >> Hi, Greg, Larry and Phillip!
> > > >> >> I noticed, that new staging driver was added like 3 weeks ago
> > > and I
> > decided
> > > >> to look at the code, because drivers in staging directory are
> > > always
> > buggy.
> > > >> >> The first thing I noticed is *no one* was checking read
> > > operations
> > result,
> > > > > but
> > > > >> it can fail and driver may start writing random stack values
> > > into
> > registers.
> > > > > It
> > > > >> can cause driver misbehavior or device misbehavior.
> > > > > After the messages I wrote yesterday, I had some minutes to look
> > > deeper at
> > the
> > > > code that would be changed by these patches.
> > > > > I think that it does not look like that the driver could return
> > > "random
> > stack
> > > > values into registers" and I think this entire series in unnecessary.
> > > > > As far as I understand this driver (though I must admit that I
> > > really
> > don't
> > > > know how to write drivers, and I'm not interested in understanding
> > > - at
> > the
> > > > moment, at least), all the usb_read*() call usbctrl_vendorreq()
> > > and the
> > latter
> > > > *does* proper error checking before returning to the callers the
> > > read
> > data.
> > > > > Please, look at the code copied from usbctrl_vendorreq() and
> > > pasted here
> > (some
> > > > comments are mine):
> > > > > /* start of code */
> > > > static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void
> > > > *pdata, u16 len, u8 requesttype)
> > > > {
> > > > > /* test if everything is OK for transfers and setup the
> > > necessary
> > variables */
> > > > [...]
> > > > > status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > > > >                                           reqtype, value,
> > > > > REALTEK_USB_VENQT_CMD_IDX,
> > > > >                                           pIo_buf, len,
> > > > > RTW_USB_CONTROL_MSG_TIMEOUT);
> > > > >                  if (status == len) {   /*  Success this control
> > > transfer.
> > */
> > > >                  >
> > > rtw_reset_continual_urb_error(dvobjpriv);
> > > >                          if (requesttype == 0x01)
> > > >                          >
> > > memcpy(pdata, pIo_buf,  len); /* pdata
> > > > > receives the read data */
> > > > > 	} else { /*  error cases */
> > > > > [...]
> > > > > }
> > > > /* end of code */
> > > > > So, *I cannot ack this RFC*, unless maintainers say I'm missing
> > > something.
> > > > > Larry, Philip, since you have much more knowledge than me about
> > > r8188eu
> > (and,
> > > > more in general, on device drivers) may you please say what you
> > > think
> > about my
> > > > arguments against this series?
> > > 
> > > Hi, Fabio!
> > > 
> > > Thank you for looking into this, but I still can see the case when pdata
> > > won't be initialized:
> > > 
> > > 
> > > pdata is initialized only in case of successful transfer, i.e len > 0.
> > > It means some data was received (maybe not full length, but anyway). In
> > > case of usb_control_msg() error (for example -ENOMEM) code only does
> > > this code block:
> > > 
> > > if (status < 0) {
> > > 	if (status == (-ESHUTDOWN) || status == -ENODEV) {
> > > 		adapt->bSurpriseRemoved = true;
> > > 	} else {
> > > 		struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
> > > 		haldata->srestpriv.Wifi_Error_Status =
> > USB_VEN_REQ_CMD_FAIL;
> > > 	}
> > > }
> > 
> > It's up to the callers of _rtw_usb*() to check return values and then act
> > accordingly.
> > 
> > It doesn't matter whether or not *pdata is initialized because usb_read*()
> > returns data = 0 if usb_control_msg() has not initialized/changed  its third
> > parameter. Then _rtw_read*() receive 0 or initialized data depending on errors
> > or no errors. Finally _rtw_read*() returns that same value to the callers (via
> > r_val).
> > 
> > So, it's up to the callers to test if (!_rtw_read*()) and then act
> > accordingly. If they get 0 they should know how to handle the errors.
> > 
> 
> Yes, but _rtw_read*() == 0 indicates 2 states:
> 
> 	1. Error on transfer side
> 	2. Actual register value is 0

That's not a good design, it should be fixed.  Note there is the new
usb_control_msg_recv() function which should probably be used instead
here, to prevent this problem from happening.

> > In summation. if anything should be changed, it is the code of the callers of
> > _rtw_read*() if you find out they they don't properly handle the returning
> > values of this function. You should find every place where _rtw_read*() are
> > called and figure out if the returns are properly checked and handled; if not,
> > make some change only there.
> > 
> > Larry, Philip, where are you? Am I missing something?

Relax, there is no need to get jumpy, people do not have to respond
instantly to emails here.  Especially when it is not their job to do so.

greg k-h
