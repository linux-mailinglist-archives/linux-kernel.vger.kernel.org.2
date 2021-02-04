Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684A830F52B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbhBDOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbhBDOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:37:08 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AD7C061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dIUX1UJ9YE8lpmLnWwpq590HsZ3ByZbducXK2xflJPo=; b=DFmzaMfMbNUxXMVfJoBXvnYA8
        zx+VDWMGRqNLZ00I0o3iGn1gszJLI/MKXQcsFIuJWYwMp+UURWWjxjogzu9Xd6jswfTZiMFoYtx+x
        HwEvrvlpk2i5N1qP7pEjK100u28wf6ILGcLd8CmsoXEMlGc+TJsPT+zs8SJ9MtkbC8TawmDOMeNHi
        IciPNoLXDNBGlg+r90Hhjd9I6WX6zBNASV/IrWjgYNi/3Tdyf85QEnPA6v8gHDxQuNLdzEITc5ROT
        NGN7XVyo0x6P9DsNLwBAJEk4R1xmie0cu+buRF05aPFPgU+MR5FvzLmlOof7o17lj+7b+C+ESF0p2
        sKAvTfUrQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39118)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l7fk3-0006eK-Hy; Thu, 04 Feb 2021 14:36:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l7fk2-0005Ej-Cd; Thu, 04 Feb 2021 14:36:18 +0000
Date:   Thu, 4 Feb 2021 14:36:18 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>, kernelci-results@groups.io
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
Message-ID: <20210204143618.GY1463@shell.armlinux.org.uk>
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com>
 <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk>
 <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <20210204104714.GU1463@shell.armlinux.org.uk>
 <CAMj1kXF6SLXN3HQAG3SyOujX5MPCSrLG-k82iNz=61HjaiEEVw@mail.gmail.com>
 <090003e6f825de1f8460c0e987e14577@kernel.org>
 <20210204140911.GX1463@shell.armlinux.org.uk>
 <CAMj1kXHf0dNvsrfct6rCxi_yHXcQCqjwJoMa_TD0Fh6xo2zeZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHf0dNvsrfct6rCxi_yHXcQCqjwJoMa_TD0Fh6xo2zeZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 03:25:20PM +0100, Ard Biesheuvel wrote:
> Pushing contents of the cache hierarchy to main memory is *not* a
> valid use of set/way ops, and so there is no point in pretending that
> set/way ops will produce the same results as by-VA ops. Only the by-VA
> ops give the architectural guarantees that we rely on for correctness.

... yet we /were/ doing that, and it worked fine for 13 years - from
1st June 2007 until the by-VA merge into mainline on the 3rd April
2020.

You may be right that it wasn't the most correct way, but it worked
for those 13 years without issue, and it's only recently that it's
become a problem, and trying to "fix" that introduced a regression,
and fixing that regression has caused another regression... and I
what I'm wondering is how many more regression fixing cycles it's
going to take - how many regression fixes on top of other regression
fixes are we going to end up seeing here.

The fact is, we never properly understood why your patch caused the
regression I was seeing. If we don't understand it, then we can never
say that we've fixed the problem properly. That is highlighted by the
fact that fixing the regression I was seeing has caused another
regression.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
