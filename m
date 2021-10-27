Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79EC43CACF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbhJ0Nk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235710AbhJ0Nk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:40:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF92560C51;
        Wed, 27 Oct 2021 13:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635341882;
        bh=qJlE+rKByLhXWxjO8K8LqV6oWJBIM5IZCXPlGnIR17E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQ0CjDxFPeUX0sLIGqwTPaNTMXs6BXGBvqNoEixrrFJKhrB+7hjmyK8ev+6YVncjf
         Gg1dRy4J8wo19vughwzMLFcRpnZxvqPoXKNi9yl8sycXsWXFx1OKQSu2T09IxzPL42
         pcCbVu6xsb8iop0IUJnNFLSJW/70VPw8xweTz44IAEqbCWINl+KXWEoc6W+GSg2R9l
         OUdk4oqbgUIZBposr/AwUfBt15wYFpY7wmzT8kM7BEp8rXNBzG39rQSDqjEv0MouMC
         UhavlWj8r94/0F5KYJqSOZorXcvXYTDsQGt847ENo4mDfVKkCNUS9XNTgr4O/Lo/QM
         mceSf4ZSHXYpQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mfj7i-0001cL-H5; Wed, 27 Oct 2021 15:37:47 +0200
Date:   Wed, 27 Oct 2021 15:37:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] USB: serial: ch314: use usb_control_msg_recv()
 and usb_control_msg_send()
Message-ID: <YXlWKuuYVeSWXNXR@hovoldconsulting.com>
References: <20211001065720.21330-1-himadrispandya@gmail.com>
 <20211001065720.21330-2-himadrispandya@gmail.com>
 <YXlOSQXdZra5sYbe@hovoldconsulting.com>
 <CAOY-YVmtt4XTet4hU43nfD4pj2W008ab-VRhBMs-One4kpEEug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOY-YVmtt4XTet4hU43nfD4pj2W008ab-VRhBMs-One4kpEEug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 03:28:42PM +0200, Himadri Pandya wrote:
> On Wed, Oct 27, 2021 at 3:04 PM Johan Hovold <johan@kernel.org> wrote:
> > On Fri, Oct 01, 2021 at 08:57:19AM +0200, Himadri Pandya wrote:

> > > @@ -287,23 +277,18 @@ static int ch341_set_handshake(struct usb_device *dev, u8 control)
> > >  static int ch341_get_status(struct usb_device *dev, struct ch341_private *priv)
> > >  {
> > >       const unsigned int size = 2;
> > > -     char *buffer;
> > > +     u8 buffer[2];
> > >       int r;
> > >       unsigned long flags;
> > >
> > > -     buffer = kmalloc(size, GFP_KERNEL);
> > > -     if (!buffer)
> > > -             return -ENOMEM;
> > > -
> > >       r = ch341_control_in(dev, CH341_REQ_READ_REG, 0x0706, 0, buffer, size);
> > > -     if (r < 0)
> > > -             goto out;
> > > +     if (r)
> > > +             return r;
> > >
> > >       spin_lock_irqsave(&priv->lock, flags);
> > >       priv->msr = (~(*buffer)) & CH341_BITS_MODEM_STAT;
> > >       spin_unlock_irqrestore(&priv->lock, flags);
> > >
> > > -out: kfree(buffer);
> > >       return r;
> >
> > This should now be
> >
> >         return 0;
> >
> 
> Yes. The function was returning the negative error value before the
> change. But now it doesn't need to as we are already taking care of it
> in the wrapper.

It has more to do with the fact that we now return early on errors so r
will always be zero here. It's better to be explicit about that.
 
> > >  }
> > >
> > > @@ -312,30 +297,25 @@ out:    kfree(buffer);
> > >  static int ch341_configure(struct usb_device *dev, struct ch341_private *priv)
> > >  {
> > >       const unsigned int size = 2;
> > > -     char *buffer;
> > > +     u8 buffer[2];
> > >       int r;
> > >
> > > -     buffer = kmalloc(size, GFP_KERNEL);
> > > -     if (!buffer)
> > > -             return -ENOMEM;
> > > -
> > >       /* expect two bytes 0x27 0x00 */
> > >       r = ch341_control_in(dev, CH341_REQ_READ_VERSION, 0, 0, buffer, size);
> > > -     if (r < 0)
> > > -             goto out;
> > > +     if (r)
> > > +             return r;
> > >       dev_dbg(&dev->dev, "Chip version: 0x%02x\n", buffer[0]);
> > >
> > >       r = ch341_control_out(dev, CH341_REQ_SERIAL_INIT, 0, 0);
> > > -     if (r < 0)
> > > -             goto out;
> > > +     if (r)
> > > +             return r;
> >
> > Now an unrelated change.
> 
> I think it is a related change because we are removing the out label.

Sorry, I meant that the (r < 0) change was unrelated since you're no
longer touching ch341_control_out(). The return is indeed still needed.
 
> > > @@ -647,23 +611,19 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
> > >       struct ch341_private *priv = usb_get_serial_port_data(port);
> > >       int r;
> > >       uint16_t reg_contents;
> > > -     uint8_t *break_reg;
> > > +     uint8_t break_reg[2];
> > >
> > >       if (priv->quirks & CH341_QUIRK_SIMULATE_BREAK) {
> > >               ch341_simulate_break(tty, break_state);
> > >               return;
> > >       }
> > >
> > > -     break_reg = kmalloc(2, GFP_KERNEL);
> > > -     if (!break_reg)
> > > -             return;
> > > -
> > >       r = ch341_control_in(port->serial->dev, CH341_REQ_READ_REG,
> > >                       ch341_break_reg, 0, break_reg, 2);
> > > -     if (r < 0) {
> > > +     if (r) {
> > >               dev_err(&port->dev, "%s - USB control read error (%d)\n",
> > >                               __func__, r);
> > > -             goto out;
> > > +             return;
> > >       }
> > >       dev_dbg(&port->dev, "%s - initial ch341 break register contents - reg1: %x, reg2: %x\n",
> > >               __func__, break_reg[0], break_reg[1]);
> > > @@ -681,11 +641,9 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
> > >       reg_contents = get_unaligned_le16(break_reg);
> > >       r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
> > >                       ch341_break_reg, reg_contents);
> > > -     if (r < 0)
> > > +     if (r)
> >
> > Now also an unrelated change.
> >
> 
> Maybe I misunderstood your comments on v2. I thought you asked to get
> rid of the out labels in callers.

Yes, but as above I'm referring to the (r < 0) change for
ch341_control_out() which is now unrelated to the rest of the patch.

Johan
