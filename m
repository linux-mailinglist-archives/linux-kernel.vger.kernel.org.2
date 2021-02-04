Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B2430F02C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhBDKHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbhBDKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:07:32 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D0C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 02:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4fIcMp4emmQo15EJhirc3ucExtAOR+0m8XuKOdaleBA=; b=k40jkkCW2go8hCISfAUkyXuOq
        z83WuCqPJQh9DY9s7wtxl03n3iUBllvrSrpbclX9zuAKZ4Kdwb0E8eN8fri40EYTsuokI0FcpYi/m
        GaPscHA6u5cDqWriBThX14ONW4qAbDaYFtP0sWdQhkCV2t+sXEODXRZSz/EGwF1Na6bXWv+2QBC6F
        G6gsqacxD9aM5zXb9shfxZMw1+Fi/xB56M7c2ktd6nmrUBLdCeUwphjw6cs0urlZF5rknxIPbSTGJ
        ptY8+/AjtUUGUKMGWQq6WZNe7AoofToYdUrZ5KEmMhP5mi2bHfxdtwISDZo4P/LzYiMi9NPJ8U1Zb
        lS1AhZw4A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39030)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l7bXF-0006Qo-Jt; Thu, 04 Feb 2021 10:06:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l7bWT-00053t-QH; Thu, 04 Feb 2021 10:06:01 +0000
Date:   Thu, 4 Feb 2021 10:06:01 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
Message-ID: <20210204100601.GT1463@shell.armlinux.org.uk>
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com>
 <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:07:58AM +0100, Ard Biesheuvel wrote:
> On Thu, 4 Feb 2021 at 09:43, Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
> >
> > Hi Ard,
> >
> > Please see the bisection report below about a boot failure on
> > rk3288 with next-20210203.  It was also bisected on
> > imx6q-var-dt6customboard with next-20210202.
> >
> > Reports aren't automatically sent to the public while we're
> > trialing new bisection features on kernelci.org but this one
> > looks valid.
> >
> > The kernel is most likely crashing very early on, so there's
> > nothing in the logs.  Please let us know if you need some help
> > with debugging or trying a fix on these platforms.
> >
> 
> Thanks for the report.

Ard,

I want to send my fixes branch today which includes your regression
fix that caused this regression.

As this is proving difficult to fix, I can only drop your fix from
my fixes branch - and given that this seems to be problematical, I'm
tempted to revert the original change at this point which should fix
both of these regressions - and then we have another go at getting rid
of the set/way instructions during the next cycle.

Thoughts?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
