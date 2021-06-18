Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70293ACBFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhFRNWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhFRNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:22:21 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88313C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OfU5Cc2TKMfWLUf4GRZWyAL3UpUGP7UR7XxGIF7IULA=; b=Ny4Yw8+FiO1zJsBQmDR+73C1H
        5n4vMHWdIIkkjaBXur1bt3gqXM3XGBBVm4Y63dCHOlUCqHGCQC2i5QjfAfKVEAYh7AHQH/N1lqGg6
        sfDGV9vm+aCB+rPtbJDEIzoQeuAjqn/ntJHhGna0TXuxFH7bxvULPU5wX3I9vioppdYpVWfoh0fod
        5/F3b2bSYCOORgD63zEwKHmFuVKP/tUJoTgKuU8ivOQXN01TQZi9QMQZ8GZNsGqGIRc3gk0FT4R8O
        MFBiCa2ufLcqS1pF/KMi1211l5MxlOea2yJbby5Qqeihp/2cp6wCVCtthcTewRNBxgWIX2pYh/EL5
        7IlkQwkPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45128)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1luEPW-0001Tk-Tl; Fri, 18 Jun 2021 14:19:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1luEPQ-0007xo-Fo; Fri, 18 Jun 2021 14:19:44 +0100
Date:   Fri, 18 Jun 2021 14:19:44 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210618131944.GL22278@shell.armlinux.org.uk>
References: <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
 <20210616103446.GC22278@shell.armlinux.org.uk>
 <YMncQv1uT5QyQ84w@hirez.programming.kicks-ass.net>
 <20210616132226.GD22278@shell.armlinux.org.uk>
 <20210616150456.GC22433@arm.com>
 <20210616152326.GG22278@shell.armlinux.org.uk>
 <20210616154529.GD22433@arm.com>
 <20210616160050.GE22433@arm.com>
 <20210616162716.GH22278@shell.armlinux.org.uk>
 <CACRpkdYHoC66K7W6mUMqKfAJkcKeopBnAq8Rq+tLSdLo61jtAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYHoC66K7W6mUMqKfAJkcKeopBnAq8Rq+tLSdLo61jtAQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 02:54:05PM +0200, Linus Walleij wrote:
> On Wed, Jun 16, 2021 at 6:27 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> 
> > Arnd tells me that the current remaining ARM11MPCore users are:
> > - CNS3xxx (where there is some martinal interest in the Gateworks
> >   Laguna platform)
> > - Similar for OXNAS
> > - There used to be the Realview MPCore tile - I haven't turned that on
> >   in ages, and it may be that the 3V cell that backs up the encryption
> >   keys is dead so it may not even boot.
> 
> I have this machine with 4 x ARM11 MPCore, it works like a charm.
> I use it to test exactly this kind of stuff, I know if a kernel works
> on ARM11MPCore it works on anything because of how fragile
> it is.
> 
> > So it seems to come down to a question about CNS3xxx and OXNAS. If
> > these aren't being used, maybe we can drop ARM11MPCore support and
> > the associated platforms?
> >
> > Linus, Krzysztof, Neil, any input?
> 
> I don't especially need to keep the ARM11MPCore machine alive,
> it is just a testchip after all. The Oxnas is another story, that has wide
> deployment and was contributed recently (2016) and has excellent
> support in OpenWrt so I wouldn't really want
> to axe that.

So I suppose the next question is... are these issues (with userland
self-modifying code and kernel module loading) entirely theoretical
or can they be produced on real hardware?

If they can't be produced on real hardware, and we attempt to fix them
how do we know that the fix has worked...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
