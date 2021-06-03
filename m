Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99AE39A295
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFCN6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhFCN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:58:04 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4937C061756
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XK3DFn9y/2od50dk7I+LHJEP9FSKMGbVHidYY/mOhCo=; b=xprqpCHTxD4AFtP40AB4yDQ6M
        4fmL2P8SYggR0FTO1HD8xm8mjprALaXMbyWOKBBKguQQipxUtcZVUxEc3+yQMzet6PDedTOYDgTPe
        RvRg5rAlnkHLbE5yFDdvUq31s2AQqZyVs9NtLe3IZE/HW8K/QVfOV1nnPM7yI8pjkZtqjCj5YQsEQ
        bMO17VEtK7BJuJuibHG1zMEMAL1rC3KvjFtzXUWewT/EevCHVtMbJ+ShJlf0nZOTdzmvoiTKWT+Lz
        dIqybL8sKw9B5ydb5o9NY/pz4U9/8LuGUs6sQP2OlcIYKH+837YIgRiEFfX9Ks3aPtMuIchQy+QRa
        08qb+TUfA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44676)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lonpR-0002t9-Pi; Thu, 03 Jun 2021 14:56:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lonpQ-0002AL-WD; Thu, 03 Jun 2021 14:56:09 +0100
Date:   Thu, 3 Jun 2021 14:56:08 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stefan Agner <stefan@agner.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 2/6] ARM: xen: Register with kernel restart handler
Message-ID: <20210603135608.GU30436@shell.armlinux.org.uk>
References: <20191015145147.1106247-1-thierry.reding@gmail.com>
 <20191015145147.1106247-3-thierry.reding@gmail.com>
 <CAF2Aj3hbW7+pNp+_jnMVL8zeSxAvSbV1ZFZ_4PAUj6J0TxMk7g@mail.gmail.com>
 <20210603131124.GA1040254@roeck-us.net>
 <20210603133840.GB2435141@dell>
 <7a1cf301-ba99-1e01-c43e-53b53f4d3e04@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a1cf301-ba99-1e01-c43e-53b53f4d3e04@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 09:48:59AM -0400, Boris Ostrovsky wrote:
> On 6/3/21 9:38 AM, Lee Jones wrote:
> > On Thu, 03 Jun 2021, Guenter Roeck wrote:
> >
> >> On Thu, Jun 03, 2021 at 01:43:36PM +0100, Lee Jones wrote:
> >>> On Tue, 15 Oct 2019 at 15:52, Thierry Reding <thierry.reding@gmail.com>
> >>> wrote:
> >>>
> >>>> From: Guenter Roeck <linux@roeck-us.net>
> >>>>
> >>>> Register with kernel restart handler instead of setting arm_pm_restart
> >>>> directly.
> >>>>
> >>>> Select a high priority of 192 to ensure that default restart handlers
> >>>> are replaced if Xen is running.
> >>>>
> >>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>>> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> >>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >>>> ---
> >>>>  arch/arm/xen/enlighten.c | 12 ++++++++++--
> >>>>  1 file changed, 10 insertions(+), 2 deletions(-)
> >>>>
> >>> This patch does appear to be useful.
> >>>
> >>> Is this just being solved in downstream trees at the moment?
> >>>
> >>> It would be nice if we could relinquish people of this burden and get it
> >>> into Mainline finally.
> >>>
> >> There must have been half a dozen attempts to send this patch series
> >> upstream. I have tried, and others have tried. Each attempt failed with
> >> someone else objecting for non-technical reasons (such as "we need more
> >> reviews") or no reaction at all, and maintainers just don't pick it up.
> > Looking at the *-by tag list above, I think we have enough quality
> > reviews to take this forward.
> >
> >> So, yes, this patch series can only be found in downstream trees,
> >> and it seems pointless to submit it yet again.
> > IMHO, it's unfair to burden multiple downstream trees with this purely
> > due to poor or nervy maintainership.  Functionality as broadly useful
> > as this should be merged and maintained in Mainline.
> >
> > OOI, who is blocking?  As I see it, we have 2 of the key maintainers
> > in the *-by list.  With those on-board, it's difficult to envisage
> > what the problem is.
> 
> 
> Stefano (who is ARM Xen maintainer) left Citrix a while ago. He is at sstabellini@kernel.org (which I added to the CC line).

Stefano already reviewed this patch, which is part of a larger series
that primarily touches 32-bit ARM code, but also touches 64-bit ARM
code as well.

As I said in my previous reply, I don't see that there's any problem
with getting these patches merged had the usual processes been
followed - either ending up in the patch system, or the pull request
being sent to me directly.

Sadly, the pull request was sent to the arm-soc people excluding me,
I happened to notice it and requested to see the patches that were
being asked to be pulled (since I probably couldn't find them)...
and it then took two further weeks before the patches were posted,
which I then missed amongst all the other email.

It's a process failure and unfortunate timing rather than anything
malicious.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
