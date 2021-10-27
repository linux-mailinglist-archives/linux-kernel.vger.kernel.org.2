Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA543CB19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbhJ0NuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhJ0NuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:50:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44ACC061570;
        Wed, 27 Oct 2021 06:47:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2125332pjb.3;
        Wed, 27 Oct 2021 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvdNFh7MkxWNhtp7QKNJAhYk/nyXIPZJEIzI2iPA3Mo=;
        b=hcT/4ljv08p+AgUZoVB1ay+S6Xt+MGseUne1f3O4ngEiaZrhIqbfX4moYG5jFqkXv9
         F/06/B7L4fbdJ0SiyZ+2PQ11G3E5aorWeAc+JfcHP3+IvNBCZPg2eR4EOni7TcxLgEl9
         YtoMyeVbADulB8ai8VoEScrx/9RQiGUvHFiJtbeUnoyynUwTmHsMTIm8+E/6WZ2n2xVr
         jePqMLXsubRWU0jf5cqJy7N75SLyISBNKaU2WajiRssnI+Gtf+FK3234n24qMuSkjv9b
         mHNF5vysWAoprbcN33Tk6K2m6Lwcqd4+2ijFkb5gv07y101KUurJ/6Sa9Y3KaZoVt0nj
         ZOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvdNFh7MkxWNhtp7QKNJAhYk/nyXIPZJEIzI2iPA3Mo=;
        b=Ijkx7DJ2GUZWLAnw2cd+g1HVIUNOoQ04pGZi/msI970+sl97sE0IlU7oE+O+s+d7KB
         TUbUxlwnSF1O0Vm4U3D1KgoNrKODZOu9ncutP3AqxMSX3MyAV94y/GgGNJAjlwZgdRC3
         y8oog3mVrrnPSnryYqEIfYD8W5hXgBTFdZB1MC0GBgoGYOUG4jWsRWpyyOwJKc2Ba9H3
         r1WC8P82aNw8JZhhRRc2kfI+dWGguC6ejtFyJphbXaD/qaSSF0qEdIfnO1CByMOh6uVM
         erGhWH1lxMOx9krGHKy9REXKqF2cd2hJyXtOlrvC7ioSX0O1NUhIJcxllALLizmRaUTB
         q+gA==
X-Gm-Message-State: AOAM5338WDP/2ZCKC9C6Cn9Xi+48oxw/C4vyv9/KYD3+3AFsRfCWd3Ht
        dBGoFrJxBtc6FpRyvhDI2QLN6t4amwBUdp79GwE=
X-Google-Smtp-Source: ABdhPJzKP+b5xfi2bkRWraalmmHfFU3KDb80OW/qhpk0kDxI9cT7lEraO56w9PGRbE2w5OWXgLkMyMqEv/7Opy42wII=
X-Received: by 2002:a17:902:6ac4:b0:13f:52e1:8840 with SMTP id
 i4-20020a1709026ac400b0013f52e18840mr28067744plt.15.1635342466407; Wed, 27
 Oct 2021 06:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211001065720.21330-1-himadrispandya@gmail.com>
 <20211001065720.21330-2-himadrispandya@gmail.com> <YXlOSQXdZra5sYbe@hovoldconsulting.com>
 <CAOY-YVmtt4XTet4hU43nfD4pj2W008ab-VRhBMs-One4kpEEug@mail.gmail.com> <YXlWKuuYVeSWXNXR@hovoldconsulting.com>
In-Reply-To: <YXlWKuuYVeSWXNXR@hovoldconsulting.com>
From:   Himadri Pandya <himadrispandya@gmail.com>
Date:   Wed, 27 Oct 2021 15:47:34 +0200
Message-ID: <CAOY-YVkCt8BojRYc41mZL+gA0gvaKCdaM_hhW6Wo0ZShprcYmw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] USB: serial: ch314: use usb_control_msg_recv() and usb_control_msg_send()
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 3:38 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, Oct 27, 2021 at 03:28:42PM +0200, Himadri Pandya wrote:
> > On Wed, Oct 27, 2021 at 3:04 PM Johan Hovold <johan@kernel.org> wrote:
> > > On Fri, Oct 01, 2021 at 08:57:19AM +0200, Himadri Pandya wrote:
>
> > > > @@ -287,23 +277,18 @@ static int ch341_set_handshake(struct usb_device *dev, u8 control)
> > > >  static int ch341_get_status(struct usb_device *dev, struct ch341_private *priv)
> > > >  {
> > > >       const unsigned int size = 2;
> > > > -     char *buffer;
> > > > +     u8 buffer[2];
> > > >       int r;
> > > >       unsigned long flags;
> > > >
> > > > -     buffer = kmalloc(size, GFP_KERNEL);
> > > > -     if (!buffer)
> > > > -             return -ENOMEM;
> > > > -
> > > >       r = ch341_control_in(dev, CH341_REQ_READ_REG, 0x0706, 0, buffer, size);
> > > > -     if (r < 0)
> > > > -             goto out;
> > > > +     if (r)
> > > > +             return r;
> > > >
> > > >       spin_lock_irqsave(&priv->lock, flags);
> > > >       priv->msr = (~(*buffer)) & CH341_BITS_MODEM_STAT;
> > > >       spin_unlock_irqrestore(&priv->lock, flags);
> > > >
> > > > -out: kfree(buffer);
> > > >       return r;
> > >
> > > This should now be
> > >
> > >         return 0;
> > >
> >
> > Yes. The function was returning the negative error value before the
> > change. But now it doesn't need to as we are already taking care of it
> > in the wrapper.
>
> It has more to do with the fact that we now return early on errors so r
> will always be zero here. It's better to be explicit about that.
>

Okay. Right.

> > > >  }
> > > >
> > > > @@ -312,30 +297,25 @@ out:    kfree(buffer);
> > > >  static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
> > > >  {
> > > >       const unsigned int size = 2;
> > > > -     char *buffer;
> > > > +     u8 buffer[2];
> > > >       int r;
> > > >
> > > > -     buffer = kmalloc(size, GFP_KERNEL);
> > > > -     if (!buffer)
> > > > -             return -ENOMEM;
> > > > -
> > > >       /* expect two bytes 0x27 0x00 */
> > > >       r = ch341_control_in(dev, CH341_REQ_READ_VERSION, 0, 0, buffer, size);
> > > > -     if (r < 0)
> > > > -             goto out;
> > > > +     if (r)
> > > > +             return r;
> > > >       dev_dbg(&dev->dev, "Chip version: 0x%02x\n", buffer[0]);
> > > >
> > > >       r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT, 0, 0);
> > > > -     if (r < 0)
> > > > -             goto out;
> > > > +     if (r)
> > > > +             return r;
> > >
> > > Now an unrelated change.
> >
> > I think it is a related change because we are removing the out label.
>
> Sorry, I meant that the (r < 0) change was unrelated since you're no
> longer touching ch341_control_out(). The return is indeed still needed.
>

Oh, okay. My bad.

> > > > @@ -647,23 +611,19 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
> > > >       struct ch341_private *priv = usb_get_serial_port_data(port);
> > > >       int r;
> > > >       uint16_t reg_contents;
> > > > -     uint8_t *break_reg;
> > > > +     uint8_t break_reg[2];
> > > >
> > > >       if (priv->quirks & CH341_QUIRK_SIMULATE_BREAK) {
> > > >               ch341_simulate_break(tty, break_state);
> > > >               return;
> > > >       }
> > > >
> > > > -     break_reg = kmalloc(2, GFP_KERNEL);
> > > > -     if (!break_reg)
> > > > -             return;
> > > > -
> > > >       r = ch341_control_in(port->serial->dev, CH341_REQ_READ_REG,
> > > >                       ch341_break_reg, 0, break_reg, 2);
> > > > -     if (r < 0) {
> > > > +     if (r) {
> > > >               dev_err(&port->dev, "%s - USB control read error (%d)\n",
> > > >                               __func__, r);
> > > > -             goto out;
> > > > +             return;
> > > >       }
> > > >       dev_dbg(&port->dev, "%s - initial ch341 break register contents - reg1: %x, reg2: %x\n",
> > > >               __func__, break_reg[0], break_reg[1]);
> > > > @@ -681,11 +641,9 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
> > > >       reg_contents = get_unaligned_le16(break_reg);
> > > >       r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
> > > >                       ch341_break_reg, reg_contents);
> > > > -     if (r < 0)
> > > > +     if (r)
> > >
> > > Now also an unrelated change.
> > >
> >
> > Maybe I misunderstood your comments on v2. I thought you asked to get
> > rid of the out labels in callers.
>
> Yes, but as above I'm referring to the (r < 0) change for
> ch341_control_out() which is now unrelated to the rest of the patch.
>
> Johan

Yes, got it.

Thanks,
Himadri
