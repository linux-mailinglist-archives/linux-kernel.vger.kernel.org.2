Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F043530F4A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbhBDOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbhBDOJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:09:59 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64113C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i1MPwPYOiK9y8hJMDgjpJkrCuHMOJ4Dqv8dooOfnSUU=; b=qRnb09mnJWHdMudVWlQSM+eyL
        BlIiZICfgOsGu7TzHIntTySTyhKwjv98nlDIzg2IDwf44u2rG6klb0mXNBcpI4O2olpa1GFvMJtiI
        Ate7w82p2oWvVUCInNETA+AvLFyBGL+XTTv7SdBnv3i3GJAp/zk+8na+c02Iku12QhfBLFd699LGu
        gvK+YZ9k8MKXJulqj8DXgmXHqiLD6Zakjo204lgBSUUcjroFA6kakm8Sx4UrQWlYAWtA/npdDJbA+
        ZUgSrF9NlNGnMTzKyLF0q5mQPjSkHDrLJN/gwA/Lu613FTuG46ou7wGl/3ixOEB8jdAqSDgNxZAMb
        SB6m2xiIQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39106)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l7fJp-0006cj-Si; Thu, 04 Feb 2021 14:09:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l7fJn-0005EJ-E9; Thu, 04 Feb 2021 14:09:11 +0000
Date:   Thu, 4 Feb 2021 14:09:11 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>, kernelci-results@groups.io
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
Message-ID: <20210204140911.GX1463@shell.armlinux.org.uk>
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com>
 <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk>
 <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <20210204104714.GU1463@shell.armlinux.org.uk>
 <CAMj1kXF6SLXN3HQAG3SyOujX5MPCSrLG-k82iNz=61HjaiEEVw@mail.gmail.com>
 <090003e6f825de1f8460c0e987e14577@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <090003e6f825de1f8460c0e987e14577@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 12:26:44PM +0000, Marc Zyngier wrote:
> I agree. With set/way CMOs, there is no way to reach the PoC if
> it beyond the system cache, leading to an unbootable kernel.
> This is actually pretty well documented in the architecture,
> and it did bite us for the first time on XGene-1, 7 years ago.

That may be, however we still do set/way maintenance to invalidate
the L1 cache as that is required for ARMv7 to place the cache into
a known state, as stated by the architecture reference manual.

Arguably, that should be done by firmware, but when starting
secondary CPUs, there are platforms out there which do not bring
the L1 cache to a defined state. So we are pretty much stuck with
doing set/way operations during CPU initialisation in the main
kernel.

If ARMv8 decides that this is not supportable, then that's a matter
for ARMv8 to address without impacting the requirements of ARMv7.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
