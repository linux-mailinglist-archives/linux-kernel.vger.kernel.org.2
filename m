Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BA0440563
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 00:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJ2WX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 18:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhJ2WX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:23:57 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11557C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Do7L5x/Jp2vk5w/0hBh1oQ1CeFEeism1jwbxTAib4ds=; b=fC/7EXoX0qn3AdwgeEVSJmsZUQ
        epV3jL3ktl0x9QaArUocyphyoui8Uk2vR4cLJhRWJugb5NFpIlidT8oMtnN6ur5FXSF4RR0aJYZBZ
        hoSqdNgG5p9s4PLojNjPT+C+2KRUYFnnUTDJUZCHx2gxiadLOB24GyRk2vWwSyKB8e9xx4AnwI4gG
        m4qNGzOSj8G9tkNcHligfjMBp/DmEKzDGh73BU77puqR6GWoGLlU3wQwzayRU0lpOHAPHIS4HG1vT
        VeOpryF3pzCIxLnbXcxKLJQ/L1gu0evzqDdfGgCBiQE9e/MTUtXTctNa/cvQqrFNdtH4ut7dA/iiY
        88qbrjrA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55388)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mgaFU-0000kF-GW; Fri, 29 Oct 2021 23:21:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mgaFS-0001wk-Ke; Fri, 29 Oct 2021 23:21:18 +0100
Date:   Fri, 29 Oct 2021 23:21:18 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Julian Braha <julianbraha@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fazilyildiran@gmail.com
Subject: Re: [PATCH] ARM: fix unmet dependency on BITREVERSE for
 HAVE_ARCH_BITREVERSE
Message-ID: <YXxz3gjIUz7Lrmsn@shell.armlinux.org.uk>
References: <20211029203110.8343-1-julianbraha@gmail.com>
 <CAK8P3a1L8x48ZGhFKaMNa0MXCGrouw2EEwe9uo640bnnf=4dOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1L8x48ZGhFKaMNa0MXCGrouw2EEwe9uo640bnnf=4dOA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 12:05:28AM +0200, Arnd Bergmann wrote:
> On Fri, Oct 29, 2021 at 10:31 PM Julian Braha <julianbraha@gmail.com> wrote:
> >
> > When ARM is enabled, and BITREVERSE is disabled,
> > Kbuild gives the following warning:
> >
> > WARNING: unmet direct dependencies detected for HAVE_ARCH_BITREVERSE
> >   Depends on [n]: BITREVERSE [=n]
> >   Selected by [y]:
> >   - ARM [=y] && (CPU_32v7M [=n] || CPU_32v7 [=y]) && !CPU_32v6 [=n]
> >
> > This is because ARM selects HAVE_ARCH_BITREVERSE
> > without selecting BITREVERSE, despite
> > HAVE_ARCH_BITREVERSE depending on BITREVERSE.
> >
> > This unmet dependency bug was found by Kismet,
> > a static analysis tool for Kconfig. Please advise if this
> > is not the appropriate solution.
> >
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> 
> This works, but I think it would be better handled differently:
> 
> The other 'select BITREVERSE' instances are for drivers that use
> bitrever(), not those that provide it.
> 
> We can probably just remove the dependency. Alternatively we could
> change arch/arm/ to
> 
>      select HAVE_ARCH_BITREVERSE if BITREVERSE && ((CPU_32v7M ||
> CPU_32v7) && !CPU_32v6)
> 
> Regardless of what we do here, note that
> 
> a) the 'select' lines in CONFIG_ARM are sorted alphabetically, and
>    should be kept that way
> 
> b) the same probably exists on arch/mips and arch/arm64, whatever we
>    do here should be the same as on the other architectures.

I think HAVE_ARCH_BITREVERSE shouldn't depend on BITREVERSE.
BITREVERSE is set when something wants the bitreverse support.
HAVE_ARCH_BITREVERSE means that the architecture has support for
the bitreverse instructions and the generic code should not be
compiled.

I don't see any reason for HAVE_ARCH_BITREVERSE to depend on
BITREVERSE.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
