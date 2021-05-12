Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0008037EB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbhELTUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244895AbhELQvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:51:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FEED61006;
        Wed, 12 May 2021 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620837681;
        bh=A7W5HvhFV/XmqD19i6KBg03TIgN9/5FxEMYfpKzj6lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8KLLkvXDVqh/47hKJJeVqQlfBvLQN7rd93Uic3ynUKfQ1vl6B3bnd7ngTyURJZMq
         yTbC8HnY0B0G7gLn0CwdNXlwEzhBNQavV02u1D53cKZcibAmC8FfM9s7A/SDx4hSjw
         MDvT87XDYHas0cM1HL3CZJWiosMvgKW435eu3UIk=
Date:   Wed, 12 May 2021 18:41:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] misc: alcor_pci: fix null-ptr-deref when there is no
 PCI bridge
Message-ID: <YJwFLgvgIXHn8Zch@kroah.com>
References: <YJrFib6BD8JcX3DM@kroah.com>
 <20210511212937.1269191-1-ztong0001@gmail.com>
 <YJt0nI8lG+2juL5S@kroah.com>
 <CAA5qM4A2-RD-cnJrGrsAcRixU0nfX7xFWDkxevDoC4TsBbkh9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4A2-RD-cnJrGrsAcRixU0nfX7xFWDkxevDoC4TsBbkh9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 09:24:55AM -0700, Tong Zhang wrote:
> On Tue, May 11, 2021 at 11:24 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 11, 2021 at 05:29:38PM -0400, Tong Zhang wrote:
> > > Device might be attached to root complex directly. In this case,
> > > bus->self(bridge) will be NULL, so we'd better check before use it
> > >
> > > [    1.246492] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> > > [    1.248731] RIP: 0010:pci_read_config_byte+0x5/0x40
> > > [    1.253998] Call Trace:
> > > [    1.254131]  ? alcor_pci_find_cap_offset.isra.0+0x3a/0x100 [alcor_pci]
> > > [    1.254476]  alcor_pci_probe+0x169/0x2d5 [alcor_pci]
> > >
> > > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > > Co-Developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > > v2: check before calling alcor_pci_find_cap_offset()
> > >
> > >  drivers/misc/cardreader/alcor_pci.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
> > > index cd402c89189e..175c6b06f7aa 100644
> > > --- a/drivers/misc/cardreader/alcor_pci.c
> > > +++ b/drivers/misc/cardreader/alcor_pci.c
> > > @@ -139,6 +139,9 @@ static void alcor_pci_init_check_aspm(struct alcor_pci_priv *priv)
> > >       u32 val32;
> > >
> > >       priv->pdev_cap_off    = alcor_pci_find_cap_offset(priv, priv->pdev);
> > > +
> > > +     if (!priv->parent_pdev)
> > > +             return;
> >
> > That feels wrong, you just prevented all of the remaining logic in this
> > call to not be set up.  Did you test this and did the driver and device
> > still work properly if it hits this check?
> >
> > thanks,
> >
> > greg k-h
> 
> Sorry, probably I misunderstood your previous email. Please correct me
> if I am wrong.
> What I did here is to disable ASPM completely if it is attached to the
> root complex, which is OK since ASPM is optional and we cannot really
> do ASPM on the root complex.
> Also, alcor_pci_init_check_aspm() is responsible for checking the
> device and its parent(bridge) aspm capability offset.
> This function will set priv->parent_cap_off and priv->pdev_cap_off.
> Those two capability offset will be used in alcor_pci_aspm_ctrl() to
> determine whether the PCI link+device supports aspm or not.
> In our case the pdev_cap_off remains 0 when alcor_pci_aspm_ctrl() is
> called and it simply returns.
> So I think it can still work.

Ok, that makes more sense.

Can you document that better and add a comment here, and properly handle
the whitespace and resubmit?

thanks,

greg k-h
