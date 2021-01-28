Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC0730722E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhA1I7z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Jan 2021 03:59:55 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42593 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhA1I7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:59:52 -0500
X-Originating-IP: 86.210.203.150
Received: from xps13 (lfbn-tou-1-972-150.w86-210.abo.wanadoo.fr [86.210.203.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A1B11FF818;
        Thu, 28 Jan 2021 09:00:33 +0000 (UTC)
Date:   Thu, 28 Jan 2021 10:00:32 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: use refcount to prevent corruption
Message-ID: <20210128100032.5eb542c6@xps13>
In-Reply-To: <f91d7eff1d764ba7b47f023bc0fafacb@intel.com>
References: <20210127200319.662842-1-tomas.winkler@intel.com>
        <9732911.325628.1611780400338.JavaMail.zimbra@nod.at>
        <c8d0f22c5fdf443cb8dda1f996b148d9@intel.com>
        <1776363776.325713.1611782270873.JavaMail.zimbra@nod.at>
        <a6cb6eb10bbb48989d3a9e087951e50e@intel.com>
        <1665542284.336646.1611820031174.JavaMail.zimbra@nod.at>
        <f91d7eff1d764ba7b47f023bc0fafacb@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

"Winkler, Tomas" <tomas.winkler@intel.com> wrote on Thu, 28 Jan 2021
08:53:43 +0000:

> > Tomas,
> > 
> > ----- Ursprüngliche Mail -----  
> > >> >> Can you please explain a little more what devices are involved?
> > >> >> Does it implement _get_device() and _put_device()?  
> > >> > No this is not connected to those handlers of the underlying device
> > >> > and those won't help.
> > >> > I have a spi device provided by MFD framework so it can go away anytime.  
> > >>
> > >> Can it go away physically or just in software?  
> > > Software, but since this is mfd it's basically hotplug. The kernel is
> > > crashing when I simulate hardware failure.  
> > >>
> > >> Usually the pattern is that you make sure in the device driver that
> > >> nobody can orphan the MTD while it is in use.
> > >> e.g. drivers/mtd/ubi/gluebi.c does so. In _get_device() it grabs a
> > >> reference on the underlying UBI volume to make sure it cannot go away
> > >> while the MTD (on top of UBI) is in use.  
> > >
> > > I can try that if it helps, because we are simulating possible lower
> > > level crash.
> > > In an case I believe that the proper refcouting is much more robust
> > > solution, than the current one.
> > > I'd appreciate if someone can review the actual implementation.  
> > 
> > This happens right now, I try to understand why exactly the current way is not
> > good in enough. :-)
> > 
> > Your approach makes sure that the MTD itself does not go away while it has
> > users but how does this help in the case where the underlying MFD just
> > vanishes?
> > The MTD can be in use and the MFD can go away while e.g. mtd_read() or such
> > takes place.  
> 
> Read will fail, but kernel won't crash on access to memory that was freed.

As Richard was saying, we are really open to enhance MTD refcounting.

However, the issue you are facing is, IMHO, not related to MTD but to
MFD. There should be a way to avoid MFD to vanish by taking a reference
of it through mtd->_get_device(). I don't think addressing the case
where MFD vanishes while MTD (as a user) is still active is the
right approach.

Thanks,
Miquèl
