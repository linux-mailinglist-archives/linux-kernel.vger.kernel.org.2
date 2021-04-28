Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2BC36D5F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbhD1Ku7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbhD1Ku6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:50:58 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFF3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FsOesThNMr4yk10eEC63BERDOpugcl0kVMhDawnNGNY=; b=UX6tBxzBWz6TAmmRdEpTPtbnw
        lv0NngGc1zUYQ1xVrOP3ynSXo5Zfeyc6qLw0z7wp1JwjgMpkW9b08K2KkJM0gI70enGGqC8Gl9SNT
        qK7pAPGTbSupaPQTwEhdElCNh5b4a1SQUV3htUzoa1oJTv3pNq6ZqH156jZyEvHAVuQa/QlpjKRqL
        HmaR9ymW75eKagRUEZxrR/uak2HW2i6botohp1fy57dCjKDoJ0EhYXXCo2A38Is7SfuH/6U7t4j+h
        5U0gLBzzff+y2DGOFiVbtuftI3frnZMtMxOp58Svq9ypgs/byxkLAucmRLPp/jk/jask7iJSIPMRh
        HjVdQL+uw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52822)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lbhlj-00036W-30; Wed, 28 Apr 2021 11:50:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lbhlh-0005UN-AL; Wed, 28 Apr 2021 11:50:09 +0100
Date:   Wed, 28 Apr 2021 11:50:09 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 168/190] Revert "net: marvell: fix a missing check of
 acpi_match_device"
Message-ID: <20210428105004.GA21092@shell.armlinux.org.uk>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-169-gregkh@linuxfoundation.org>
 <YIglHlva+jlFmItZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIglHlva+jlFmItZ@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 04:52:14PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 03:00:43PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 92ee77d148bf06d8c52664be4d1b862583fd5c0e.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > index 1767c60056c5..f1a70b37227f 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > @@ -7328,8 +7328,6 @@ static int mvpp2_probe(struct platform_device *pdev)
> >  	if (has_acpi_companion(&pdev->dev)) {
> >  		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
> >  					    &pdev->dev);
> > -		if (!acpi_id)
> > -			return -EINVAL;
> >  		priv->hw_version = (unsigned long)acpi_id->driver_data;
> >  	} else {
> >  		priv->hw_version =
> > -- 
> > 2.31.1
> > 
> 
> The original commit here looks correct, so I'll drop this revert.

Agreed, the original patch looks fine to me and the revert is
unnecessary.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
