Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BAE39A270
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhFCNrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFCNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:47:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD81C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pOZ1KTG84jUOwZV4iyoT08ALYRTSycIVbayoyIWOUck=; b=XrVgjPIm3zrW47fILGapTjzAv
        3O/W1kx/TwUDLt6X9dLc49Y/7ll7KNFil833TJX1GSAlD/2QuflP5JRPOqxznYltX9YgAiMzRkvR5
        QRS/9lR+U5Yrl8QjmZ4jZjtRyNkhERKk5cAjPg+DqxFYgAqFKrOHUGmB1CJKhjWhqfSTXLbGtRPEf
        TEz2HsIYQLGtLCsapRK06jYPZrVqzd9M0DSCiNPUUi+S19BcJ9HqxxMybN3wpoHCGwN9/JqoV9bMw
        VW1acw2ZUxk6uToxHYGyu+p8vsBh16FJtRahxxTe+C5eJA9Q81jshXRKDYUSolBDRreubmvLc7FYe
        jrS04zL7A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44674)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lonfG-0002qw-QE; Thu, 03 Jun 2021 14:45:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lonfE-00029t-9E; Thu, 03 Jun 2021 14:45:36 +0100
Date:   Thu, 3 Jun 2021 14:45:36 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stefan Agner <stefan@agner.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] ARM: xen: Register with kernel restart handler
Message-ID: <20210603134536.GT30436@shell.armlinux.org.uk>
References: <20191015145147.1106247-1-thierry.reding@gmail.com>
 <20191015145147.1106247-3-thierry.reding@gmail.com>
 <CAF2Aj3hbW7+pNp+_jnMVL8zeSxAvSbV1ZFZ_4PAUj6J0TxMk7g@mail.gmail.com>
 <20210603131124.GA1040254@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603131124.GA1040254@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 06:11:24AM -0700, Guenter Roeck wrote:
> On Thu, Jun 03, 2021 at 01:43:36PM +0100, Lee Jones wrote:
> > On Tue, 15 Oct 2019 at 15:52, Thierry Reding <thierry.reding@gmail.com>
> > wrote:
> > 
> > > From: Guenter Roeck <linux@roeck-us.net>
> > >
> > > Register with kernel restart handler instead of setting arm_pm_restart
> > > directly.
> > >
> > > Select a high priority of 192 to ensure that default restart handlers
> > > are replaced if Xen is running.
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  arch/arm/xen/enlighten.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > 
> > This patch does appear to be useful.
> > 
> > Is this just being solved in downstream trees at the moment?
> > 
> > It would be nice if we could relinquish people of this burden and get it
> > into Mainline finally.
> > 
> 
> There must have been half a dozen attempts to send this patch series
> upstream. I have tried, and others have tried. Each attempt failed with
> someone else objecting for non-technical reasons (such as "we need more
> reviews") or no reaction at all, and maintainers just don't pick it up.
> 
> So, yes, this patch series can only be found in downstream trees,
> and it seems pointless to submit it yet again.

It has plenty of reviews and acks, so that's not the problem. If you
look back at the 2019 attempt:

1) there was a pull request sent on the 2 October 2019 to the arm soc
   guys to merge a series that quite obviously is outside of their
   remit as it touches mostly ARM core code - it should have been
   sent to me but wasn't, not even as a Cc.

2) I raised that issue, and as I could find no trace of the patches,
   I asked for the to be posted - which they were, eventually, two
   weeks later. It looks like I completely missed the patches amongst
   all the other email I don't bother to read anymore though. In any
   case, the pull request by that time would have been completely
   forgotten about.

And that's where it ended - no apparent follow-ups until now.

*Shrug*.

So in summary, I was expected to notice the patches amongst all the
other email, and then remember that there was a pull request that
wasn't even addressed to me...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
