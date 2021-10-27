Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5D343CAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbhJ0Ngx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhJ0Ngw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:36:52 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A293C061570;
        Wed, 27 Oct 2021 06:34:27 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f5so2903411pgc.12;
        Wed, 27 Oct 2021 06:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OimM3+h1Wf5azCbyfr+q/2UfruCcyn297O3W5lL9/Sg=;
        b=qpA/g5kG1aC81EM8OiowtG3/pDD2MZzO/p17CiE8biMvXvsl1DVasYOeD9J7sK0weK
         NIwfBvAUZe7fnxCOMw4qSNPcofIPVxrhGx9ahKzS1lOe8P9snHSw+BevD48ii6EaFnEA
         WHuIyr2SfZ93JrfqJFxcyRqmDrQBBrmp8bXoMAYAwvDL7e59q4PEj9jsCPyVbx3wt4q1
         p3brSeCrcjqkl2ObznUK34M8qrin08YT2Qh9ud1T3xrtkWxzS3coQI97V9w1kqnCqc96
         nwtRRyekMGbBhftV7i5h/ZTQs9maRfYRc4bHz1t+T1SroINRYQFhLTHKd6MJG1F35Ao6
         uanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OimM3+h1Wf5azCbyfr+q/2UfruCcyn297O3W5lL9/Sg=;
        b=dYwlfvFV/FCEfeN0Gr9CO1wFphvvjTpuHD5Jwp/1wt4YW+5v2LTk75XX/fbrbBjgrX
         8a5UfIBucXB+gknCR2rgpKE4Uim6I2Hwc9AFlJEBta5Gg7rp6o1T3V213Su/2aWIgiaL
         LEd/S983aivwd6fDEnmNM1NIeLLJrHxTYsRKyu5WkWxBmEA45xr7sQnXUUf5iRM7Dnqi
         mWfUlzVAvraqcvZY8l76LGiYnUXBrAp42QYQcZ0VPwqq5TNanVAI9qKWU+T+enwhUDI4
         7eVnh2I/gP1t3EPpnPMK3l3uPam3D8E4Ld+UrcDzKQCsg4wL32D6jW0mjefZF3NkBokp
         qEsg==
X-Gm-Message-State: AOAM5307pWiKdBcGgskrI1kS0HvTnaPHzwQWISj0su3R1e3oq2dwRWiv
        8+MzEamDC7DxRsLA39AGBy9W9Xhr6JtjQTOaPj4=
X-Google-Smtp-Source: ABdhPJxgqvNiLC0lESY3PT23uP4K34VYYNfp4WLRWcVZa/naRfeqvHJ/fqiWmoN+mHwNyALnqa4zsBU5yCKSBkWIjSQ=
X-Received: by 2002:a63:3e4b:: with SMTP id l72mr15977292pga.428.1635341666555;
 Wed, 27 Oct 2021 06:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211001065720.21330-1-himadrispandya@gmail.com>
 <20211001065720.21330-3-himadrispandya@gmail.com> <YXlRfsv6L53ZaaA7@hovoldconsulting.com>
In-Reply-To: <YXlRfsv6L53ZaaA7@hovoldconsulting.com>
From:   Himadri Pandya <himadrispandya@gmail.com>
Date:   Wed, 27 Oct 2021 15:34:15 +0200
Message-ID: <CAOY-YVmHqCCCWn_bF7sMcN=FOWFLAbLPM_ag1CukPCegsh2+mw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] USB: serial: cp210x: use usb_control_msg_recv()
 and usb_control_msg_send()
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 3:18 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Oct 01, 2021 at 08:57:20AM +0200, Himadri Pandya wrote:
> > The new wrapper functions for usb_control_msg() can accept data from
> > stack and treat short reads as error. Hence use the wrappers functions.
> > Please note that because of this change, cp210x_read_reg_block() will no
> > longer log the length of short reads.
> >
> > Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> > ---
> > Changes in v3:
> >  - Rephrase the commit message
> >  - Explicitly mention that short reads don't log length now
> >
> > Changes in v2:
> >  - Drop unrelated style fixes
>
> This looks good now, but I did do some minor style changes described
> below.
>
> > ---
> >  drivers/usb/serial/cp210x.c | 106 ++++++++++--------------------------
> >  1 file changed, 30 insertions(+), 76 deletions(-)
> >
> > diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> > index 189279869a8b..3c3ca46b0b82 100644
> > --- a/drivers/usb/serial/cp210x.c
> > +++ b/drivers/usb/serial/cp210x.c
> > @@ -631,29 +631,19 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
> >  {
> >       struct usb_serial *serial = port->serial;
> >       struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> > -     void *dmabuf;
> >       int result;
> >
> > -     dmabuf = kmalloc(bufsize, GFP_KERNEL);
> > -     if (!dmabuf)
> > -             return -ENOMEM;
> >
> > -     result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
> > -                     req, REQTYPE_INTERFACE_TO_HOST, 0,
> > -                     port_priv->bInterfaceNumber, dmabuf, bufsize,
> > -                     USB_CTRL_GET_TIMEOUT);
> > -     if (result == bufsize) {
> > -             memcpy(buf, dmabuf, bufsize);
> > -             result = 0;
> > -     } else {
> > +     result = usb_control_msg_recv(serial->dev, 0, req,
> > +                                   REQTYPE_INTERFACE_TO_HOST, 0,
> > +                                   port_priv->bInterfaceNumber, buf,
> > +                                   bufsize, USB_CTRL_SET_TIMEOUT,
> > +                                   GFP_KERNEL);
>
> The indentation style of this driver is a bit inconsistent but there's
> no need to change to the open-parenthesis alignment style when you can
> avoid it (it's mostly just "checkpacth.pl --subjective" that insists on
> it).
>
> Indenting continuation lines two tabs is just fine and avoids excessive
> indentation and having to realign arguments when symbol names change.
>

Thanks for clearing this up. I followed the checkpatch suggestion in
v2 and then came back to the original style of the driver in v3.
Feeling the extra spaces to match the indentation wasn't really fun.

> > +     if (result) {
> >               dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
> >                               req, bufsize, result);
> > -             if (result >= 0)
> > -                     result = -EIO;
> >       }
> >
> > -     kfree(dmabuf);
> > -
> >       return result;
>
> I changed this to explicit zero and return an error above instead.

Okay.

>
> > @@ -952,27 +915,18 @@ static int cp210x_get_tx_queue_byte_count(struct usb_serial_port *port,
> >  {
> >       struct usb_serial *serial = port->serial;
> >       struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> > -     struct cp210x_comm_status *sts;
> > +     struct cp210x_comm_status sts;
> >       int result;
> >
> > -     sts = kmalloc(sizeof(*sts), GFP_KERNEL);
> > -     if (!sts)
> > -             return -ENOMEM;
> > -
> > -     result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
> > -                     CP210X_GET_COMM_STATUS, REQTYPE_INTERFACE_TO_HOST,
> > -                     0, port_priv->bInterfaceNumber, sts, sizeof(*sts),
> > -                     USB_CTRL_GET_TIMEOUT);
> > -     if (result == sizeof(*sts)) {
> > -             *count = le32_to_cpu(sts->ulAmountInOutQueue);
> > -             result = 0;
> > -     } else {
> > +     result = usb_control_msg_recv(serial->dev, 0, CP210X_GET_COMM_STATUS,
> > +                                   REQTYPE_INTERFACE_TO_HOST, 0,
> > +                                   port_priv->bInterfaceNumber, &sts,
> > +                                   sizeof(sts), USB_CTRL_GET_TIMEOUT,
> > +                                   GFP_KERNEL);
> > +     if (result == 0)
> > +             *count = le32_to_cpu(sts.ulAmountInOutQueue);
> > +     else
> >               dev_err(&port->dev, "failed to get comm status: %d\n", result);
> > -             if (result >= 0)
> > -                     result = -EIO;
> > -     }
> > -
> > -     kfree(sts);
>
> The above is now also better handled with an explicit error check and
> early return and the doing the *count assignment in the success path.
>

Yes.

> >
> >       return result;
> >  }
>
> Now applied with the above changes. The result is here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next&id=f5cfbecb0a162319464c9408420282d22ed69721
>
> Johan

Thank you.

Regards,
Himadri
