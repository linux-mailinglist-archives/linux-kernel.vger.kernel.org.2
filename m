Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ADC3F52ED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 23:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhHWVmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 17:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhHWVmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:42:00 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0E2C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 14:41:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n5so12853366pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ku8EjWfpl64Nxby0uKN1wfJ3BBvZfw/S8z9qY6NZG/U=;
        b=wdm+jDOnXCqJ48PwMQuU4n7c9CWYIXm2Kebvngg/88WVYGpbiwUbKAlxXkQ0sYXrxP
         oiLcga02EQ7j3Jr5Rpovsk/tKrYAsZddH8rMrFKgl5zgxapwGhqDKRXdcg279itt4Djj
         womrQAlggq9Qnz6AKlnSkBNfFSNgRO+LZ9xsAhKpoUQu8KpVcNH5fa7EySYh4OyTot46
         hhHdoSBPdPv5FuegCQAFez8yJ+Rl3E6O0+YnkI+Un2t2cXXcuE86dg0b7SrgnHnVbMOo
         pp9Sq3a0vrfsBqxIO90bkwhGV0XrWCwiJb++pWg/544+xyMDTjFR0R/TEDhdUAiTgZv7
         oVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ku8EjWfpl64Nxby0uKN1wfJ3BBvZfw/S8z9qY6NZG/U=;
        b=BzHfutMRp1klWE4VEHUcfccdivskLwRJuf2TvGaZKxqkNYlBNCyjD51+ALepVDrOWN
         CU9qbuyBhJpH9HyHCHPJjy4qSi17Z6Np6seu8gRAcqZMVgpv1ZTm4flkl0+CCsF4hfPf
         RHiY+PzL6c/pM7Wvqp6tVR/nA8IQVNJXjvibWv7xHJ2k7U8YFoec5tdhZNGPIUa2Sen4
         VPw3MqQFtBmLTB2kDDwwN6hWFbEVWGDNZblB1Mqf6G/7/Mm0IHkB5A7lTmuT64xCv3Up
         4rj5KDJkFTDAW1VZ1qwQQDnUljv36ekTH3um8RLwbHqliMo6pOrj7RXaDqy6eTOLAr1o
         kXkg==
X-Gm-Message-State: AOAM531ffhCAeBKtN5HgtUdd481dizigo2wgpn0gRlH35GMvd8SaWUQH
        duI4sQXYz5vSFmqaprIZ5qSnjy7lD36TewaW5mpW0g==
X-Google-Smtp-Source: ABdhPJwruXO4hf39WQC31EbNJk9Fm5Wi2YZelxc3kwHFSVm3b5ZPK1M57xiPcvCoDawGSJ1K4Rcv5c7N/NVQtRZKE0w=
X-Received: by 2002:a17:902:6ac6:b0:133:230b:e8bc with SMTP id
 i6-20020a1709026ac600b00133230be8bcmr9605502plt.22.1629754877345; Mon, 23 Aug
 2021 14:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210822230235.10953-1-fmdefrancesco@gmail.com>
 <69bbb80c-2b30-28b9-ad8c-6862a6c3b911@gmail.com> <8275282.m2tVFbhrJk@localhost.localdomain>
In-Reply-To: <8275282.m2tVFbhrJk@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 22:41:06 +0100
Message-ID: <CAA=Fs0n7zX0WrcsrBzPPxoo6GHGaCruwVb+3LEqwQYASsv34cw@mail.gmail.com>
Subject: Re: [PATCH RFC] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 at 11:47, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On Monday, August 23, 2021 10:11:52 AM CEST Pavel Skripkin wrote:
> > On 8/23/21 2:02 AM, Fabio M. De Francesco wrote:
> > > Replace usb_control_msg() with the new usb_control_msg_recv() and
> > > usb_control_msg_send() API of USB Core.
> > >
> > > This patch is an RFC for different reasons:
> > >
> > > 1) I'm not sure if it is needed: while Greg Kroah-Hartman suggested to
> > > use the new API in a message to a thread that was about a series of patches
> > > submitted by Pavel Skripkin (who decided to not use it), I cannot explain
> > > if and why the driver would benefit from this patch.
> > > 2) I have doubts about the semantic of the API I use here, so I'd like to
> > > know whether or not I'm using them properly.
> > > 3) At the moment I cannot test the driver because I don't have my device
> > > with me.
> > > 4) This patch could probably lead to a slight change in some lines of
> > > Pavel's series (for sure in usb_read*()).
> > >
> > > I'd like to hear from the Maintainers and other interested people if this
> > > patch is worth to be considered and, in this case, if there are suggestions
> > > for the purpose to improve it.
> > >
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >   drivers/staging/r8188eu/hal/usb_ops_linux.c | 19 ++++++++++---------
> > >   1 file changed, 10 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > index 6a0a24acf292..9e290c1cc449 100644
> > > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > @@ -15,7 +15,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> > >     struct adapter  *adapt = pintfhdl->padapter;
> > >     struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
> > >     struct usb_device *udev = dvobjpriv->pusbdev;
> > > -   unsigned int pipe;
> > > +   u8 pipe;
> > >     int status = 0;
> > >     u8 reqtype;
> >
> > I think, we can pass REALTEK_USB_VENQT_{READ,WRITE} directly as
> > requesttype argument and get rid of u8 reqtype. + we can define these
> > macros:
> >
> > #define
> > usbctrl_vendor_read(...)   usbctrl_vendorreq(...,REALTEK_USB_VENQT_READ)
> >
> >
> > #define
> > usbctrl_vendor_write()    usbctrl_vendorreq(...,REALTEK_USB_VENQT_WRITE)
> >
> >
> > This will make code more nice, IMO  :)
>
> Dear Pavel,
>
> I agree in full: nicer and cleaner :)
>
> I'll do that, but please notice that I will also need to change the code of the three
> usb_read*() for calling usbctrl_vendor_read(). Furthermore, "else res = 0;" becomes
> unnecessary. Please take these changes into account when you'll send them again
> as "regular" patches.
>
> > (Sorry for this formatting, my email client disabled "paste without
> > formatting" option)
>
> Actually I don't see any oddities in the format of your message :)
>
> > >     u8 *pIo_buf;
> > > @@ -47,19 +47,20 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> > >             memset(pIo_buf, 0, len);
> > >
> > >             if (requesttype == 0x01) {
> > > -                   pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> > >                     reqtype =  REALTEK_USB_VENQT_READ;
> > > +                   status = usb_control_msg_recv(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > > +                                                 reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> > > +                                                 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
> > > +                                                 GFP_KERNEL);
> > >             } else {
> > > -                   pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> > >                     reqtype =  REALTEK_USB_VENQT_WRITE;
> > > -                   memcpy(pIo_buf, pdata, len);
> >
> > I guess, this memcpy is needed, since we want to send data from pdata
>
> Oh, dear! How could I have missed that? Two alternatives: either because of working
> during bedtime, or I'm definitely losing my mind... :(
>
> >
> > > +                   status = usb_control_msg_send(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > > +                                                 reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> > > +                                                 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
> > > +                                                 GFP_KERNEL);
> > >             }
> > >
> > > -           status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > > -                                    reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> > > -                                    pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
> > > -
> > > -           if (status == len) {   /*  Success this control transfer. */
> > > +           if (!status) {   /*  Success this control transfer. */
> > >                     rtw_reset_continual_urb_error(dvobjpriv);
> > >                     if (requesttype == 0x01)
> > >                             memcpy(pdata, pIo_buf,  len);
> > >
> >
> >
> > With regards,
> > Pavel Skripkin
>
> Thanks for you review, I really appreciate it.
>
> Regards,
>
> Fabio
>
> P.S.: As I wrote, I have not my ASUS N10 Nano with me and I won't have the opportunity
> to test this as well as any other patch until the end of August. I hope to not break anything.
> If somebody has time to test the final patch that I'm going to submit, I'd really appreciate it.
>
>

Dear Fabio,

Code is looking good - happy to test the final patch here by all means.

Regards,
Phil
