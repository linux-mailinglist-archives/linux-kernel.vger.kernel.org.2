Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024EE43CAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbhJ0NbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbhJ0NbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:31:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC2CC061570;
        Wed, 27 Oct 2021 06:28:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f8so1977325plo.12;
        Wed, 27 Oct 2021 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLYiGp1qkMWzNGtJOz8fDAbn1FKixv9ubD1jvCrRtNY=;
        b=fmp4XT347FLlSmRU85yQACLgnvDDSWCPlCXVa3+b7F4S5EN3reBACfAU5kB5etCnIe
         RjLmikBDmTAiTzx+yRNvQISIhpNdxzRMf9BsjBrbVJ0cGyyuZbDnFguG1ezmxT3FHbCD
         LdDw7Hu5Ar3HCpTLlr61Fc02Y5duUtJpEk8PWlW3HD/8kd5a13RXT15uQd41B9Ty8wst
         erLmTCBV5Pc+hixOtwbvnnP81qdu0ztm/gZdf6OCCeJ14MjGf04M0IVTgcoL8POeD/rK
         4P0Vdyu+EHkX9jU7nQCzAFo9wN2NH8xbewJsl7K6gNH9SJejg9DrtMSHjox0BX2FGFls
         xg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLYiGp1qkMWzNGtJOz8fDAbn1FKixv9ubD1jvCrRtNY=;
        b=E5pr9Zja+jNlwu5LqLpK9UmqLzw5+UKDhggN9XLNIIGTyZSvoz9B+Lsq/xKIyEhqy7
         /DX5cUOAROTsiVK8IjWjOAdtRq1m9cSj52FT7dwoNV343LePjOTFrqIaNBL7wT4kC99O
         P87AgJzNdJzaYV4N/Vec5BZouevRILkyo+dhHmAEFYV9SaOXa9MFORvGYZkkMXzV8xUB
         PtjwxqNcssS08eMG5+RzGsAzpBLqWap2GQsO00kapKh3j150UKy/aJAn1/9ShM7BAK+N
         lO1vFxF0CfeIqSXB2VmmVPrcKqaDEvv5fmpwoUuZHP6MhmvhmGujfbPkV8nbGBBrYh2J
         3ksw==
X-Gm-Message-State: AOAM533dRYMH7Ko932pUdoJw1h79vadVHAQyOxzS96Bb9HuvidMWEzXr
        xzE1eERWCXrM4o7RgIFze2LcsPLmUNA8WqiBGKY=
X-Google-Smtp-Source: ABdhPJwdEX9Uv80DYvnKciBlM2tttEiuMYvMllzcetkY3RtDopRj4Kf+zSj+iHI+FsIxIkJLNcVdfZsd+Z6VSDiGibI=
X-Received: by 2002:a17:902:708a:b0:140:e30:a48b with SMTP id
 z10-20020a170902708a00b001400e30a48bmr27821756plk.54.1635341334272; Wed, 27
 Oct 2021 06:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211001065720.21330-1-himadrispandya@gmail.com>
 <20211001065720.21330-2-himadrispandya@gmail.com> <YXlOSQXdZra5sYbe@hovoldconsulting.com>
In-Reply-To: <YXlOSQXdZra5sYbe@hovoldconsulting.com>
From:   Himadri Pandya <himadrispandya@gmail.com>
Date:   Wed, 27 Oct 2021 15:28:42 +0200
Message-ID: <CAOY-YVmtt4XTet4hU43nfD4pj2W008ab-VRhBMs-One4kpEEug@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] USB: serial: ch314: use usb_control_msg_recv() and usb_control_msg_send()
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 3:04 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Oct 01, 2021 at 08:57:19AM +0200, Himadri Pandya wrote:
> > usb_control_msg_send/recv are new wrapper functions for usb_control_msg()
> > that have proper error checks for short reads. These functions can also
> > accept data buffer on stack. Hence use these functions to simplify error
> > handling for short reads. Short reads will now get reported as
> > -EREMOTEIO with no indication of how short the transfer was.
>
> You're no longer using usb_control_msg_send() so the commit message
> including Subject needs to be updated.
>
> > Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> > ---
> > Changes in v3:
> >  - Rephrase the commit message
> >  - Include a note on not reporting size of the short reads in the commit
> >  - Drop unnecessary changes in ch341_control_out()
> >  - Drop a non-relevant style change
> >  - Remove some more "out" labels
> >  - Remove unnecessary return statement from a void function
> >
> > Changes in v2:
> >  - Fix callers of ch341_control_out() and ch341_control_in()
> >  - Remove label "out"
> >  - Remove an unnecessary assignment statement
> > ---
> >  drivers/usb/serial/ch341.c | 90 ++++++++++----------------------------
> >  1 file changed, 24 insertions(+), 66 deletions(-)
> >
> > diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
> > index 2db917eab799..8aecc1f0dee4 100644
> > --- a/drivers/usb/serial/ch341.c
> > +++ b/drivers/usb/serial/ch341.c
> > @@ -131,23 +131,13 @@ static int ch341_control_in(struct usb_device *dev,
> >       dev_dbg(&dev->dev, "%s - (%02x,%04x,%04x,%u)\n", __func__,
> >               request, value, index, bufsize);
> >
> > -     r = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), request,
> > -                         USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> > -                         value, index, buf, bufsize, DEFAULT_TIMEOUT);
> > -     if (r < (int)bufsize) {
> > -             if (r >= 0) {
> > -                     dev_err(&dev->dev,
> > -                             "short control message received (%d < %u)\n",
> > -                             r, bufsize);
> > -                     r = -EIO;
> > -             }
> > -
> > -             dev_err(&dev->dev, "failed to receive control message: %d\n",
> > -                     r);
> > -             return r;
> > -     }
> > +     r = usb_control_msg_recv(dev, 0, request,
> > +                              USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> > +                              value, index, buf, bufsize, DEFAULT_TIMEOUT, GFP_KERNEL);
>
> Line is now over 80 chars for no good reason.

Sorry, I changed machines and the checkpatch must not be configured
properly in the new set-up.

>
> > +     if (r)
> > +             dev_err(&dev->dev, "failed to receive control message: %d\n", r);
>
> Here too.
>
> >
> > -     return 0;
> > +     return r;
>
> I'd prefer returning the errno in the error path above and keep an
> explicit zero here.
>

Okay.

> >  }
> >
> >  #define CH341_CLKRATE                48000000
> > @@ -287,23 +277,18 @@ static int ch341_set_handshake(struct usb_device *dev, u8 control)
> >  static int ch341_get_status(struct usb_device *dev, struct ch341_private *priv)
> >  {
> >       const unsigned int size = 2;
> > -     char *buffer;
> > +     u8 buffer[2];
> >       int r;
> >       unsigned long flags;
> >
> > -     buffer = kmalloc(size, GFP_KERNEL);
> > -     if (!buffer)
> > -             return -ENOMEM;
> > -
> >       r = ch341_control_in(dev, CH341_REQ_READ_REG, 0x0706, 0, buffer, size);
> > -     if (r < 0)
> > -             goto out;
> > +     if (r)
> > +             return r;
> >
> >       spin_lock_irqsave(&priv->lock, flags);
> >       priv->msr = (~(*buffer)) & CH341_BITS_MODEM_STAT;
> >       spin_unlock_irqrestore(&priv->lock, flags);
> >
> > -out: kfree(buffer);
> >       return r;
>
> This should now be
>
>         return 0;
>

Yes. The function was returning the negative error value before the
change. But now it doesn't need to as we are already taking care of it
in the wrapper.

> >  }
> >
> > @@ -312,30 +297,25 @@ out:    kfree(buffer);
> >  static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
> >  {
> >       const unsigned int size = 2;
> > -     char *buffer;
> > +     u8 buffer[2];
> >       int r;
> >
> > -     buffer = kmalloc(size, GFP_KERNEL);
> > -     if (!buffer)
> > -             return -ENOMEM;
> > -
> >       /* expect two bytes 0x27 0x00 */
> >       r = ch341_control_in(dev, CH341_REQ_READ_VERSION, 0, 0, buffer, size);
> > -     if (r < 0)
> > -             goto out;
> > +     if (r)
> > +             return r;
> >       dev_dbg(&dev->dev, "Chip version: 0x%02x\n", buffer[0]);
> >
> >       r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT, 0, 0);
> > -     if (r < 0)
> > -             goto out;
> > +     if (r)
> > +             return r;
>
> Now an unrelated change.

I think it is a related change because we are removing the out label.

>
> >
> >       r = ch341_set_baudrate_lcr(dev, priv, priv->baud_rate, priv->lcr);
> >       if (r < 0)
> > -             goto out;
> > +             return r;
> >
> >       r = ch341_set_handshake(dev, priv->mcr);
> >
> > -out: kfree(buffer);
> >       return r;
>
> This looks a bit inconsistent now so I'll make this an explicit return
> 0 too.

Okay.

>
> >  }
> >
> > @@ -345,39 +325,23 @@ static int ch341_detect_quirks(struct usb_serial_port *port)
> >       struct usb_device *udev = port->serial->dev;
> >       const unsigned int size = 2;
> >       unsigned long quirks = 0;
> > -     char *buffer;
> > +     u8 buffer[2];
> >       int r;
> >
> > -     buffer = kmalloc(size, GFP_KERNEL);
> > -     if (!buffer)
> > -             return -ENOMEM;
> > -
> >       /*
> >        * A subset of CH34x devices does not support all features. The
> >        * prescaler is limited and there is no support for sending a RS232
> >        * break condition. A read failure when trying to set up the latter is
> >        * used to detect these devices.
> >        */
> > -     r = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0), CH341_REQ_READ_REG,
> > -                         USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> > -                         CH341_REG_BREAK, 0, buffer, size, DEFAULT_TIMEOUT);
> > +     r = usb_control_msg_recv(udev, 0, CH341_REQ_READ_REG,
> > +                              USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> > +                              CH341_REG_BREAK, 0, &buffer, size, DEFAULT_TIMEOUT, GFP_KERNEL);
>
> Unnecessarily long line > 80 chars.
>
> >       if (r == -EPIPE) {
> >               dev_info(&port->dev, "break control not supported, using simulated break\n");
> >               quirks = CH341_QUIRK_LIMITED_PRESCALER | CH341_QUIRK_SIMULATE_BREAK;
> > -             r = 0;
>
> Oops, you just broke the driver. :(
>
> This request is used to detect quirky devices and a return value of
> -EPIPE here should not abort probe by returning an error to the caller
> of this function.

Understood. Thanks for catching it.

>
> > -             goto out;
> > -     }
> > -
> > -     if (r != size) {
> > -             if (r >= 0)
> > -                     r = -EIO;
> > +     } else if (r)
>
> And you still need brackets on the else branch.

Yes. Okay.

>
> >               dev_err(&port->dev, "failed to read break control: %d\n", r);
> > -             goto out;
> > -     }
> > -
> > -     r = 0;
> > -out:
> > -     kfree(buffer);
> >
> >       if (quirks) {
> >               dev_dbg(&port->dev, "enabling quirk flags: 0x%02lx\n", quirks);
> > @@ -647,23 +611,19 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
> >       struct ch341_private *priv = usb_get_serial_port_data(port);
> >       int r;
> >       uint16_t reg_contents;
> > -     uint8_t *break_reg;
> > +     uint8_t break_reg[2];
> >
> >       if (priv->quirks & CH341_QUIRK_SIMULATE_BREAK) {
> >               ch341_simulate_break(tty, break_state);
> >               return;
> >       }
> >
> > -     break_reg = kmalloc(2, GFP_KERNEL);
> > -     if (!break_reg)
> > -             return;
> > -
> >       r = ch341_control_in(port->serial->dev, CH341_REQ_READ_REG,
> >                       ch341_break_reg, 0, break_reg, 2);
> > -     if (r < 0) {
> > +     if (r) {
> >               dev_err(&port->dev, "%s - USB control read error (%d)\n",
> >                               __func__, r);
> > -             goto out;
> > +             return;
> >       }
> >       dev_dbg(&port->dev, "%s - initial ch341 break register contents - reg1: %x, reg2: %x\n",
> >               __func__, break_reg[0], break_reg[1]);
> > @@ -681,11 +641,9 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
> >       reg_contents = get_unaligned_le16(break_reg);
> >       r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
> >                       ch341_break_reg, reg_contents);
> > -     if (r < 0)
> > +     if (r)
>
> Now also an unrelated change.
>

Maybe I misunderstood your comments on v2. I thought you asked to get
rid of the out labels in callers.

> >               dev_err(&port->dev, "%s - USB control write error (%d)\n",
> >                               __func__, r);
> > -out:
> > -     kfree(break_reg);
> >  }
> >
> >  static int ch341_tiocmset(struct tty_struct *tty,
>
> I've fixed up the above so we don't have to spend any more time on this.
>

Thank you.

> The result is here
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next&id=74f266455062c158f343bc3aa35ef84b3eb7adf1
>
> Johan

Looks good. Thanks for taking the patch.

Regards,
Himadri
