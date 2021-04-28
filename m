Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D9136E063
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbhD1Ugy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240918AbhD1Ugx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:36:53 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F95C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N46qIDDB//FKEj5ob7JbwI/v4UKtFfgB2WDEtzbpCyk=; b=RjpXmBw4BtQtxN+0+85vmam1j
        qgg+hbHaqLzGXeKvuBdCQoYSgtqLXwwoo+embXOa9mvAkHI8tyKxJsNZBuX/VzekAtqhIMcN6uDsg
        JA1NPNWFWBNjP59CEGEN/3WtC1fM2XaojMX3euRxMhgdbkZKA4OvAhTxK8crtgj4vyIks8ilCk0pI
        q3fGgBNJTEpbp32jzavl8PltOY/nSkTgbNmvLNJ/jBgfEQ9GFJgmBQoqJMW4028HtE2w0net/HylD
        lXsIqzS6JaF/J0275kEMEefUsZJZTF7iQGx/Nsvk48JfidLgB1f5JhRTTQJMGEVXM87D5PUqwez6l
        MtR2dnTFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52836)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lbqug-0003wG-Vb; Wed, 28 Apr 2021 21:36:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lbqud-0005oQ-8x; Wed, 28 Apr 2021 21:35:59 +0100
Date:   Wed, 28 Apr 2021 21:35:59 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>, Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 168/190] Revert "net: marvell: fix a missing check of
 acpi_match_device"
Message-ID: <20210428203559.GX1463@shell.armlinux.org.uk>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-169-gregkh@linuxfoundation.org>
 <YIglHlva+jlFmItZ@kroah.com>
 <20210428105004.GA21092@shell.armlinux.org.uk>
 <CAKdAkRRw9RVCpasnB7hzAjW7gKQOuud-YWXgj281zrO0ri=AyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRRw9RVCpasnB7hzAjW7gKQOuud-YWXgj281zrO0ri=AyQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 12:50:16PM -0700, Dmitry Torokhov wrote:
> On Wed, Apr 28, 2021 at 6:47 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Apr 27, 2021 at 04:52:14PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Apr 21, 2021 at 03:00:43PM +0200, Greg Kroah-Hartman wrote:
> > > > This reverts commit 92ee77d148bf06d8c52664be4d1b862583fd5c0e.
> > > >
> > > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > > faith" to try to test the kernel community's ability to review "known
> > > > malicious" changes.  The result of these submissions can be found in a
> > > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > >
> > > > Because of this, all submissions from this group must be reverted from
> > > > the kernel tree and will need to be re-reviewed again to determine if
> > > > they actually are a valid fix.  Until that work is complete, remove this
> > > > change to ensure that no problems are being introduced into the
> > > > codebase.
> > > >
> > > > Cc: Kangjie Lu <kjlu@umn.edu>
> > > > Cc: David S. Miller <davem@davemloft.net>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > > index 1767c60056c5..f1a70b37227f 100644
> > > > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > > @@ -7328,8 +7328,6 @@ static int mvpp2_probe(struct platform_device *pdev)
> > > >     if (has_acpi_companion(&pdev->dev)) {
> > > >             acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
> > > >                                         &pdev->dev);
> > > > -           if (!acpi_id)
> > > > -                   return -EINVAL;
> > > >             priv->hw_version = (unsigned long)acpi_id->driver_data;
> > > >     } else {
> > > >             priv->hw_version =
> > > > --
> > > > 2.31.1
> > > >
> > >
> > > The original commit here looks correct, so I'll drop this revert.
> >
> > Agreed, the original patch looks fine to me and the revert is
> > unnecessary.
> 
> I wonder how useful these kinds of patches/checks are. If we are
> dealing with ACPI platform device we must have matched on ACPI node
> before getting into the probe, so we would match here as well. The
> exception would be someone playing with "driver_override" device
> attribute, but that someone must be root as therefore have many
> options of shooting themselves into foot. So I guess the question is:
> do we need to bloat the code with such checks?

It's probably way too late now to think about it (due to the quantity
of drivers) but in many cases, it seems there's a pattern. On probe,
re-lookup the matching ID to fetch the data pointer, and store it in
some way. Had we known that such a pattern would be common, it probably
would have been a good idea to provide a "match_data" member inside
struct device, which the bus probe code can set appropriately from the
match tables. That would also have the benefit of elimianting any
patches such as this, and likely would reduce bloat too.

As I say, likely way too late for that idea now though.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
