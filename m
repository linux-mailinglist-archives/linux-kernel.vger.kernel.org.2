Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413F937A043
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhEKHEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhEKHEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:04:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5624616EB;
        Tue, 11 May 2021 07:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620716616;
        bh=IB3pb9y+maLrxdpuRV+w6YTrpg0ZTbK2FjvnZHsu5ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JcUBZbIM/WpwGCkWXs7hyDsONqSUwW+swP8CR6sOj6LoQ3o9pR1wjtuxAaN/WXVzA
         QJzPVvzAxiXNfHJl81Nm85lBzW+gqdiSBgJOTZQpv62+gXQpvWg5zDtkI9qtywVynn
         MR4b5M6czaWbOTaPCWpjU0kmQfU8DHd2yxPjG3BI=
Date:   Tue, 11 May 2021 09:03:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] misc: alcor_pci: fix null-ptr-deref when there is no PCI
 bridge
Message-ID: <YJosRuXcSKiFemC8@kroah.com>
References: <20210426220728.1230340-1-ztong0001@gmail.com>
 <YJlE+Z2VKhamVWaw@kroah.com>
 <CAA5qM4CAdb_Aaay1_gjy_AC48Doxtga0f69E1P36=8vscsR9Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4CAdb_Aaay1_gjy_AC48Doxtga0f69E1P36=8vscsR9Eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 03:20:02PM -0700, Tong Zhang wrote:
> On Mon, May 10, 2021 at 7:36 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Apr 26, 2021 at 06:07:27PM -0400, Tong Zhang wrote:
> > > the PCI bridge might be NULL, so we'd better check before use it
> > >
> > > [    1.246492] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> > > [    1.248731] RIP: 0010:pci_read_config_byte+0x5/0x40
> > > [    1.253998] Call Trace:
> > > [    1.254131]  ? alcor_pci_find_cap_offset.isra.0+0x3a/0x100 [alcor_pci]
> > > [    1.254476]  alcor_pci_probe+0x169/0x2d5 [alcor_pci]
> > >
> > > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > > ---
> > >  drivers/misc/cardreader/alcor_pci.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
> > > index cd402c89189e..1c33453fd5c7 100644
> > > --- a/drivers/misc/cardreader/alcor_pci.c
> > > +++ b/drivers/misc/cardreader/alcor_pci.c
> > > @@ -102,6 +102,9 @@ static int alcor_pci_find_cap_offset(struct alcor_pci_priv *priv,
> > >       u8 val8;
> > >       u32 val32;
> > >
> > > +     if (!pci)
> > > +             return 0;
> > > +
> > >       where = ALCOR_CAP_START_OFFSET;
> > >       pci_read_config_byte(pci, where, &val8);
> > >       if (!val8)
> > > --
> > > 2.25.1
> > >
> >
> > I do not understand, how can pci ever be NULL?  There is only 1 way this
> 
> Hi Greg,
> I think the problem is with
>     priv->parent_pdev = pdev->bus->self
> where bus->self can be NULL. when bus->self is NULL, calling

How can bus->self be NULL?

Did you see this on a real system?  How did you duplicate the error
listed here?

thanks,

greg k-h
