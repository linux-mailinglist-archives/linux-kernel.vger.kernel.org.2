Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF6C3F5417
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 02:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhHXAcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 20:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhHXAb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 20:31:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAF4C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 17:31:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id q3so28936813edt.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 17:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIW9L2n1ivUlfIL3lYB15Yrtja2TqjEFlSSIpd7VPvw=;
        b=hianhd/LUv/POV4xgSdmMOur40KVx3Em74ssfv3zIe3y6FOGC/AE1MIyGHeOQqH4w+
         454VSWYotbMV+I6o0XuRNhEeMgwjREgy9X9wF6jsqdukvcCvBJatSac5icKezks+6fPl
         rdmoMJxrH9HyvVw06k0wB8pckD3J9qEGsqqQ0THH9jE+5BUbXFiWkJcBvI4Ct73FK1OW
         8nwpb8nzndW+a1yYvfrEdTIH6q/6UueGV7h/bWaiXj7tdIdBuvaxlXDsGWzJkBTDJ7Va
         gcJxK3OYEEjFCuD6l5OVC52Q3FYivNPguqJb9f0F7u3Hgbx/cZlx3f3sH2Mi8KSk+pjk
         EdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIW9L2n1ivUlfIL3lYB15Yrtja2TqjEFlSSIpd7VPvw=;
        b=hc5pKI2aEJQ2HG2xCY/jVvFgtoKgKvi+AGsZuuxNFByNsI18cctj/g162bpZNfIWNa
         Q4iXLIww1GpLlACI9i4fCivRL8WBEcEEO0ICl/KVqpq+RYbcwtteK7Y5dEjQmxpxanzw
         HPdghwNhqNnj4ep77xeQ3SITY5O35xystQmqwq0FiZXnVev4Bu/+6IRwBXHR+U1nIGuf
         QfXwaLNBsWI4vs/92j5jKDmdGWfWBcM3ehuU57ZBXTj5oFtXonTVp/WWS+QWji1EHfzF
         Aem77mfJexCcTmVOJQDDjmkYQh2wzXRKpIbnh/ugfUgnv7kLCol/y5YdxRGVatAW8ueg
         2FFg==
X-Gm-Message-State: AOAM533Llurj1ovMY00sdUGrc8yhMWuBVTCX4u0KY2MuLGBBQfVm9WBM
        dhj9G3/164nfhjVd0AednMU=
X-Google-Smtp-Source: ABdhPJx2JWA2mxKysqL8CCbDjngrhDTAfGnuUVGmAOm6eAWjcmnfI+JeXvR3yhQ2g0lI291ov63BRg==
X-Received: by 2002:aa7:db82:: with SMTP id u2mr41153658edt.299.1629765073274;
        Mon, 23 Aug 2021 17:31:13 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id m15sm10366972eds.92.2021.08.23.17.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 17:31:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 02:31:11 +0200
Message-ID: <15825589.4VbMHeJK9p@localhost.localdomain>
In-Reply-To: <CAA=Fs0ki91VvBOd2Wd59KqeCN+BmF-eWv+r0sH+e3fUG61Zxsg@mail.gmail.com>
References: <20210823223751.25104-1-fmdefrancesco@gmail.com> <20210823223751.25104-2-fmdefrancesco@gmail.com> <CAA=Fs0ki91VvBOd2Wd59KqeCN+BmF-eWv+r0sH+e3fUG61Zxsg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 2:08:49 AM CEST Phillip Potter wrote:
> On Mon, 23 Aug 2021 at 23:38, Fabio M. De Francesco
> <fmdefrancesco@gmail.com> wrote:
> >
> > Replace usb_control_msg() with the new usb_control_msg_recv() and
> > usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
> >
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >
> > Thanks to Pavel Skripkin <paskripkin@gmail.com> for his review of the
> > RFC patch.
> >
> > drivers/staging/r8188eu/hal/usb_ops_linux.c | 25 ++++++++++-----------
> > 1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > index a93d5cfe4635..6f51660b967a 100644
> > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > @@ -15,9 +15,8 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> >         struct adapter  *adapt = pintfhdl->padapter;
> >         struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
> >         struct usb_device *udev = dvobjpriv->pusbdev;
> > -       unsigned int pipe;
> > +       u8 pipe;
> >         int status = 0;
> > -       u8 reqtype;
> >         u8 *pIo_buf;
> >         int vendorreq_times = 0;
> >
> > @@ -44,22 +43,22 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> >         }
> >
> >         while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
> > -               memset(pIo_buf, 0, len);
> > -
> >                 if (requesttype == 0x01) {
> > -                       pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> > -                       reqtype =  REALTEK_USB_VENQT_READ;
> > +                       status = usb_control_msg_recv(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > +                                                     REALTEK_USB_VENQT_READ, value,
> > +                                                     REALTEK_USB_VENQT_CMD_IDX,
> > +                                                     pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
> > +                                                     GFP_KERNEL);
> >                 } else {
> > -                       pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> > -                       reqtype =  REALTEK_USB_VENQT_WRITE;
> >                         memcpy(pIo_buf, pdata, len);
> > +                       status = usb_control_msg_send(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > +                                                     REALTEK_USB_VENQT_WRITE, value,
> > +                                                     REALTEK_USB_VENQT_CMD_IDX,
> > +                                                     pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
> > +                                                     GFP_KERNEL);
> >                 }
> >
> > -               status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > -                                        reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> > -                                        pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
> > -
> > -               if (status == len) {   /*  Success this control transfer. */
> > +               if (!status) {   /*  Success this control transfer. */
> >                         rtw_reset_continual_urb_error(dvobjpriv);
> >                         if (requesttype == 0x01)
> >                                 memcpy(pdata, pIo_buf,  len);
> > --
> > 2.32.0
> >
> 
> Dear Fabio,
> 
> Thanks for the patch. Sorry, but for some reason with my N10-Nano I
> can't get a connection at all with this patch applied - it just won't
> associate with my network. Interface shows up and no OOPS in log, but
> just disassociates/no IP address/interface down etc. so perhaps
> semantics differ slightly here somehow? Tried two separate
> rollbacks/builds/runs just to make sure I wasn't losing my mind :-)
> 
> Regards,
> Phil
> 
Dear Philip,

Thanks for testing. As I wrote in my RFC, I strongly suspected that I was
not able to correctly understand the semantics of the new API. I'll try to
read the code anew and try to understand what is wrong here.

However, I also think that I won't be able to figure it out. Maybe that I 
have to wait for Greg to give me some hint about what are the errors in
using usb_control_msg_send/recv() the way I did.

Anyway, thanks a lot for the time you spent testing.

Regards,

Fabio



