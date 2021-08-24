Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95543F5580
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 03:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhHXBiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 21:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhHXBiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 21:38:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CF9C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 18:38:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mf2so22366013ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 18:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rW0m7NP7SdsDJpLmFVe1/l0yH+U8eofh9I28j5Km+XQ=;
        b=fSIG3gc+Gg3trhGArfTIm0hgEl0cBbd74gfco3eTWxhiCpexdkn3zRHD9Wy5omvHX6
         cH2V13Tm/eNNZeXFPctdLKcH0yMQxYR7mHieLAr/MTXKKrKFQ7bU6oZpQJLZC8lPJM7R
         ZsnV0Tqq3NeBLRgiJ+3/IQk9Q3k/VMPvy4ZYT6ejk9gpTUhpKsuDqNneQ7PCkWXOuyPa
         I9fVoKcGEzRNjT4cHe83UoqS5ji/2EptPjbu79Nv1nAreBB4yuvl0i1yq79gj+qwXQ/J
         lhgd5rkU0fIClhnSJj0JnAWTltvSloiCH52nmewrbQCvA0oNyz8LMQsYCfDJtSV7uZFc
         I7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rW0m7NP7SdsDJpLmFVe1/l0yH+U8eofh9I28j5Km+XQ=;
        b=hxQEkc/GBNdJ6ZAKeyCOGbzq4uJ43n25M4nOoIEGEelA8Kt5WL+te+VrYzFv44K1Xw
         luflt0v3Ydrg/CLXa2NHGs19IaBw8LDMEWubcE9ikv/VPT8KgLIw5gb4wh+HSljQIs38
         U6ijhlXhLYJKbq1wVULr9qCRZq0t+0/ErbvFwGtymTGyIVdLwmoitQ3X/HuZh6XivLEb
         UFT6b4VbQoATIeOQCXmQ1JF6cX2Mv4YAvRxDwvfrtztmmRoEWmsiXS2dbyrpukzcSppG
         ozIoaFkZToCL43mQq4njIMBIjS242vK8XoKXKgOLUNEDaMVit/e1VVw789PD6Wd0vCMs
         X5sg==
X-Gm-Message-State: AOAM531AZF2wKxft+G9qqfCi0fXfqw+mQLTLRY6R2E/SFw9HHe7K9+cM
        IxQOVrV5zCmBNV0Ia3NY5To=
X-Google-Smtp-Source: ABdhPJxTp9+RwF3Tf+DBbSWrzLnlISO+vgoMYHSS24UKDp4EED0/T5xrqqjlLNk4sJB4BzBuizF3gQ==
X-Received: by 2002:a17:906:165a:: with SMTP id n26mr38963203ejd.236.1629769085446;
        Mon, 23 Aug 2021 18:38:05 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id f30sm2772799ejl.78.2021.08.23.18.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 18:38:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 03:38:03 +0200
Message-ID: <1815496.OexNakQ7IY@localhost.localdomain>
In-Reply-To: <15825589.4VbMHeJK9p@localhost.localdomain>
References: <20210823223751.25104-1-fmdefrancesco@gmail.com> <CAA=Fs0ki91VvBOd2Wd59KqeCN+BmF-eWv+r0sH+e3fUG61Zxsg@mail.gmail.com> <15825589.4VbMHeJK9p@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 2:31:11 AM CEST Fabio M. De Francesco wrote:
> On Tuesday, August 24, 2021 2:08:49 AM CEST Phillip Potter wrote:
> > On Mon, 23 Aug 2021 at 23:38, Fabio M. De Francesco
> > <fmdefrancesco@gmail.com> wrote:
> > >
> > > Replace usb_control_msg() with the new usb_control_msg_recv() and
> > > usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
> > >
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >
> > > Thanks to Pavel Skripkin <paskripkin@gmail.com> for his review of the
> > > RFC patch.
> > >
> > > drivers/staging/r8188eu/hal/usb_ops_linux.c | 25 ++++++++++-----------
> > > 1 file changed, 12 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > index a93d5cfe4635..6f51660b967a 100644
> > > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > @@ -15,9 +15,8 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> > >         struct adapter  *adapt = pintfhdl->padapter;
> > >         struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
> > >         struct usb_device *udev = dvobjpriv->pusbdev;
> > > -       unsigned int pipe;
> > > +       u8 pipe;
> > >         int status = 0;
> > > -       u8 reqtype;
> > >         u8 *pIo_buf;
> > >         int vendorreq_times = 0;
> > >
> > > @@ -44,22 +43,22 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> > >         }
> > >
> > >         while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
> > > -               memset(pIo_buf, 0, len);
> > > -
> > >                 if (requesttype == 0x01) {
> > > -                       pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> > > -                       reqtype =  REALTEK_USB_VENQT_READ;
> > > +                       status = usb_control_msg_recv(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > > +                                                     REALTEK_USB_VENQT_READ, value,
> > > +                                                     REALTEK_USB_VENQT_CMD_IDX,
> > > +                                                     pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
> > > +                                                     GFP_KERNEL);
> > >                 } else {
> > > -                       pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> > > -                       reqtype =  REALTEK_USB_VENQT_WRITE;
> > >                         memcpy(pIo_buf, pdata, len);
> > > +                       status = usb_control_msg_send(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > > +                                                     REALTEK_USB_VENQT_WRITE, value,
> > > +                                                     REALTEK_USB_VENQT_CMD_IDX,
> > > +                                                     pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
> > > +                                                     GFP_KERNEL);
> > >                 }
> > >
> > > -               status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > > -                                        reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> > > -                                        pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
> > > -
> > > -               if (status == len) {   /*  Success this control transfer. */
> > > +               if (!status) {   /*  Success this control transfer. */
> > >                         rtw_reset_continual_urb_error(dvobjpriv);
> > >                         if (requesttype == 0x01)
> > >                                 memcpy(pdata, pIo_buf,  len);
> > > --
> > > 2.32.0
> > >
> > 
> > Dear Fabio,
> > 
> > Thanks for the patch. Sorry, but for some reason with my N10-Nano I
> > can't get a connection at all with this patch applied - it just won't
> > associate with my network. Interface shows up and no OOPS in log, but
> > just disassociates/no IP address/interface down etc. so perhaps
> > semantics differ slightly here somehow? Tried two separate
> > rollbacks/builds/runs just to make sure I wasn't losing my mind :-)
> > 
> > Regards,
> > Phil
> > 
> Dear Philip,
> 
> Thanks for testing. As I wrote in my RFC, I strongly suspected that I was
> not able to correctly understand the semantics of the new API. I'll try to
> read the code anew and try to understand what is wrong here.
> 
> However, I also think that I won't be able to figure it out. Maybe that I 
> have to wait for Greg to give me some hint about what are the errors in
> using usb_control_msg_send/recv() the way I did.
> 
> Anyway, thanks a lot for the time you spent testing.
> 
> Regards,
> 
> Fabio
> 
Dear Philip,

I think that I've inadvertently switched the order by which usb_control_msg_send()
and memcpy() are called. I'm very sorry for not doing my tests, but (as I had said 
before) at the moment I don't have my device with me.

I'm about to send a v2 series.

Thanks very much for testing on my behalf.

Regards,

Fabio



