Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC8D3F6BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhHXWR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbhHXWRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:17:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9BCC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:16:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso3373197pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlTyrcytLZKqtMvvZGVThajB/4GbV7rfbTcbICqb4cU=;
        b=xCNQ9dQPpqgF3LA9SzNDo3HTHA9S68pSJGzZln2gjTFbYz4e7KBShtQDjI3+M1+uh0
         YIP8WoJDVAUrCZ+EX6ukfo4slp8FcBLjOKqlL4tMxdlGRdWdRl/CDAeoo/TYc7vw55kA
         xzSsFLRwSva/P+udai0vN7OQHRFNnI49uxVUmbUjoEUPeJvctRCpZHOsQIROmmki2BgV
         scBt9ArNX8MN1gSOf3Cp/e2w4KIor6vcCoTJFr5dswkh+0fukZ5xxQongr+LIi5hBo9u
         hYTM1TD9ulLUk6HQYTiGsSNP4lgVubYSzLlv8Z2uToJLUU3p6//V81laHHCT/wfwQN0O
         +HZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlTyrcytLZKqtMvvZGVThajB/4GbV7rfbTcbICqb4cU=;
        b=t95SPVSuYQQvndmpMtyuGn8Hyx5jfZ4vRqEZnGIt8sv6sPCMRohhrIRYPHAuHI94rp
         5ikQhOp/nP/bEdPxItlGlNGZEXAt6FS6h7U6zbG6IA01ekotXns3Lr66maWgAkrk3BML
         dRLpgYEpAQQa+Pw32MpG2p3zHAAj6fxRIrcLENpPH5riOMt+2/lKlIQpJvxGTWj8EQA6
         /jr6fKTDXQw0dhKDM6yf8VN6CzHBIHr/MWxnVLgSk2dSYKIwf7x++sxOKOE+pUTvcvdO
         qNBRaYF8lJP5Mr6mNIOKwLG6k4AwbX/jvIUgM71lRt19YgmTI2IqsjtMGckoeOAzRUOr
         BQYA==
X-Gm-Message-State: AOAM5320fd1rCZr8oczUvhWd8hL05Vmq7xRas8dUp+QCLZtf1ZhNLFDV
        cnY7GyEker4wvxj7qD+HQJ+BOWVBMKSOvxT/71X9vlRIuVFavQ==
X-Google-Smtp-Source: ABdhPJzRinWHpThsLwNcNHzX5Z+fRQT9GDSjccJng6fFhDhpukrRyTQHvlExTJtpYwcTzIBW3mp24n0sqqLGI9oRFME=
X-Received: by 2002:a17:90a:1f49:: with SMTP id y9mr6761337pjy.225.1629843399889;
 Tue, 24 Aug 2021 15:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210824142823.16845-1-fmdefrancesco@gmail.com>
 <20210824142823.16845-2-fmdefrancesco@gmail.com> <ac4b9c30-fceb-6838-a6d5-b9f03d5a0246@gmail.com>
 <10796100.lKEGA7Tnzb@localhost.localdomain>
In-Reply-To: <10796100.lKEGA7Tnzb@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 24 Aug 2021 23:16:29 +0100
Message-ID: <CAA=Fs0n7kC3RCO=8_Wh=6EWBm+4bbgknLVvi0qVjjkYhi923_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] staging: r8188eu: Use usb_control_msg_recv/send()
 in usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 at 16:24, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On Tuesday, August 24, 2021 4:35:38 PM CEST Pavel Skripkin wrote:
> > On 8/24/21 5:28 PM, Fabio M. De Francesco wrote:
> > > Replace usb_control_msg() with the new usb_control_msg_recv() and
> > > usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
> > > Remove no more needed variables. Move out of an if-else block
> > > some code that it is no more dependent on status < 0. Remove
> > > redundant code depending on status > 0 or status == len.
> > >
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >
> > > v1->v2: According to suggestions by Christophe JAILLET
> > > <christophe.jaillet@wanadoo.fr>, remove 'pipe' and pass an explicit 0
> > > to the new API. According to suggestions by Pavel Skripkin
> > > <paskripkin@gmail.com>, remove an extra if-else that is no more needed,
> > > since status can be 0 and < 0 and there is no 3rd state, like it was before.
> > > Many thanks to both them and to Phillip Potter <phil@philpotter.co.uk>
> > > who kindly offered his time for the purpose of testing v1.
> > >
> > >
> > >   drivers/staging/r8188eu/hal/usb_ops_linux.c | 45 ++++++++-------------
> > >   1 file changed, 17 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > index a93d5cfe4635..13e925d21e00 100644
> > > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > @@ -15,9 +15,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> > >     struct adapter  *adapt = pintfhdl->padapter;
> > >     struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
> > >     struct usb_device *udev = dvobjpriv->pusbdev;
> > > -   unsigned int pipe;
> > >     int status = 0;
> > > -   u8 reqtype;
> > >     u8 *pIo_buf;
> > >     int vendorreq_times = 0;
> > >
> > > @@ -44,22 +42,22 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> > >     }
> > >
> > >     while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
> > > -           memset(pIo_buf, 0, len);
> > > -
> > >             if (requesttype == 0x01) {
> > > -                   pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> > > -                   reqtype =  REALTEK_USB_VENQT_READ;
> > > +                   status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
> > > +                                                 REALTEK_USB_VENQT_READ, value,
> > > +                                                 REALTEK_USB_VENQT_CMD_IDX, pIo_buf,
> > > +                                                 len, RTW_USB_CONTROL_MSG_TIMEOUT,
> > > +                                                 GFP_KERNEL);
> > >             } else {
> > > -                   pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> > > -                   reqtype =  REALTEK_USB_VENQT_WRITE;
> > >                     memcpy(pIo_buf, pdata, len);
> > > +                   status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
> > > +                                                 REALTEK_USB_VENQT_WRITE, value,
> > > +                                                 REALTEK_USB_VENQT_CMD_IDX, pIo_buf,
> > > +                                                 len, RTW_USB_CONTROL_MSG_TIMEOUT,
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
> > > @@ -68,20 +66,11 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> > >                             value, (requesttype == 0x01) ? "read" : "write",
> > >                             len, status, *(u32 *)pdata, vendorreq_times);
> > >
> > > -                   if (status < 0) {
> > > -                           if (status == (-ESHUTDOWN) || status == -ENODEV) {
> > > -                                   adapt->bSurpriseRemoved = true;
> > > -                           } else {
> > > -                                   struct hal_data_8188e   *haldata = GET_HAL_DATA(adapt);
> > > -                                   haldata->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
> > > -                           }
> > > -                   } else { /*  status != len && status >= 0 */
> > > -                           if (status > 0) {
> > > -                                   if (requesttype == 0x01) {
> > > -                                           /*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
> > > -                                           memcpy(pdata, pIo_buf,  len);
> > > -                                   }
> > > -                           }
> > > +                   if (status == (-ESHUTDOWN) || status == -ENODEV) {
> > > +                           adapt->bSurpriseRemoved = true;
> > > +                   } else {
> > > +                           struct hal_data_8188e   *haldata = GET_HAL_DATA(adapt);
> > > +                           haldata->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
> > >                     }
> > >
> > >                     if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
> > > @@ -92,7 +81,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> > >             }
> > >
> > >             /*  firmware download is checksumed, don't retry */
> > > -           if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
> > > +           if (value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS)
> > >                     break;
> >
> >
> > Shouldn't we break the loop when we have received all data? I think,
> > status == len should be replaced with !status. Correct me if I am wrong.
>
> Yes, correct. I was about to replace status == len with !status when I've
> been interrupted by a phone call and then I forgot to do the work :(
>
> I'll send a v3 this night. Unfortunately now I have to go. While at that
> I'll also try to understand why 2/2 cannot apply. Sigh!
>
> > Other changes look good to me, thanks
>
> Thanks to you, Christophe and Philip for all the help you gave.
>
> Regards,
>
> Fabio
>
> > With regards,
> > Pavel Skripkin
> >
>
>
>
>

Happy to help - might be worth waiting for staging-testing to have
more patches merged in and rebasing after that.

Regards,
Phil
