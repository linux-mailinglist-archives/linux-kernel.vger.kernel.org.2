Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F128F30F12F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhBDKsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbhBDKsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:48:43 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9566FC061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 02:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BXeiae7l+uiV2zg/Ou/pjTEevpYTR1/eunOFBBITs+I=; b=bliQkgzFwbBNiLrEIJtiW4P+E
        Th/uUs2Y7zrd9TEHVqjOsPUGb/k1wMRdbSWLdU7kwaXd8xfTc4TZKg7UmaoGXd1mWBR9JiINhu2ND
        A9MY2WFWQiZ5KntkbN74fZyqOkdi182h0hxNwQgWiptmgaj6mntyEervSg6Io7IZZMC3J/Uw89BCz
        nWENbbk1XtW4J9KDZUU+YsuMoH03UfDiKiAwSdyV/oM85rv2vzT0khXhgePZI/ElITVwuDYpxy71N
        lCbzibEZ1gCIu7y9K9GmStKLzBGSai2Jd6HAM3189Z2tVOngwLp54Qm350+f/KpBt7rUMoCl4BaD4
        rD5N59+iA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39048)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l7cB8-0006SM-2m; Thu, 04 Feb 2021 10:48:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l7cAN-000564-1Y; Thu, 04 Feb 2021 10:47:15 +0000
Date:   Thu, 4 Feb 2021 10:47:15 +0000
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
Message-ID: <20210204104714.GU1463@shell.armlinux.org.uk>
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com>
 <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk>
 <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:27:16AM +0100, Ard Biesheuvel wrote:
> Hi Russell,
> 
> If Guillaume is willing to do the experiment, and it fixes the issue,
> it proves that rk3288 is relying on the flush before the MMU is
> disabled, and so in that case, the fix is trivial, and we can just
> apply it.
> 
> If the experiment fails (which would mean rk3288 does not tolerate the
> cache maintenance being performed after cache off), it is going to be
> hairy, and so it will definitely take more time.
> 
> So in the latter case (or if Guillaume does not get back to us), I
> think reverting my queued fix is the only sane option. But in that
> case, may I suggest that we queue the revert of the original by-VA
> change for v5.12 so it gets lots of coverage in -next, and allows us
> an opportunity to come up with a proper fix in the same timeframe, and
> backport the revert and the subsequent fix as a pair? Otherwise, we'll
> end up in the situation where v5.10.x until today has by-va, v5.10.x-y
> has set/way, and v5.10y+ has by-va again. (I don't think we care about
> anything before that, given that v5.4 predates any of this)

I'm suggesting dropping your fix (9052/1) and reverting
"ARM: decompressor: switch to by-VA cache maintenance for v7 cores"
which gets us to a point where _both_ regressions are fixed.

I'm of the opinion that the by-VA patch was incorrect when it was
merged (it caused a regression), and it's only a performance
improvement. Our attempts so far to fix it are just causing other
regressions. So, I think it is reasonable to revert both back to a
known good point which has worked over a decade. If doing so causes
regressions (which I think is unlikely), then that would be unfortunate
but alas is a price that's worth paying to get back to a known good
point - since then we're not stacking regression fixes on top of other
regression fixes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
