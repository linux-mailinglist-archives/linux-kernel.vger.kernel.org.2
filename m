Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F1323B36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhBXLVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhBXLVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:21:02 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3898C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DVWwQbXihiKWscFbZpqwExBXp30yZcczSkfaKJZeIuQ=; b=qRFvQzM8PbvVEeRH5JH1r53KO
        nToLM1UPQGpXUOXCA7gGn3VPTIkQLhm7r4U0jkdlvOveyF8cvXBP0icPZdpHy7GqbM3U8cIcb93iM
        mO+icA8WgZftmMfBYpQqZYbawH7i0ZuR+B/Cb1p/gMxL1WAWFq5aqpx9bwcE2VEDmFtAH7YLlG59e
        PUQVxUD/lfA3F5vvOfQj06fi9NSUiNaxUyT++dn90csqGeG7eDx+2a1475eYiVkb21dWkHmSFtEC+
        mMgg9iXZIOOQvEBUXLGzcbpLN9KIQo0g5QITrIromr53gEEkL/1shXVxA0wEX35BW4rDYBPcPc8jv
        XEKpj/EYg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46648)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lEsD5-0008Qf-EN; Wed, 24 Feb 2021 11:20:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lEsD4-0003xN-3D; Wed, 24 Feb 2021 11:20:02 +0000
Date:   Wed, 24 Feb 2021 11:20:02 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     liang wang <liang26812@gmail.com>
Cc:     linux-kernel@vger.kernel.org, penberg@kernel.org,
        geert@linux-m68k.org, rppt@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] [RFC]ARM: ftrace: pause/unpause function graph tracer in
 cpu_suspend()
Message-ID: <20210224112001.GR1463@shell.armlinux.org.uk>
References: <1609738534-14369-1-git-send-email-liang26812@gmail.com>
 <CAG_0j0D9Vhc5F659ZrORLD4vh56MtGK8Zf4V1Ex3nXOjkLL1gg@mail.gmail.com>
 <20210224103944.GQ1463@shell.armlinux.org.uk>
 <CAG_0j0BmczxbsScvJeoe9eC0JAEExvZY2wLfNCK5=bufBRTmvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_0j0BmczxbsScvJeoe9eC0JAEExvZY2wLfNCK5=bufBRTmvA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 07:14:54PM +0800, liang wang wrote:
> Hi Russell,
> 
> On Wed, 24 Feb 2021 at 18:39, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Feb 24, 2021 at 06:35:47PM +0800, liang wang wrote:
> > > Hi,all
> > >
> > > ftrace function_graph tracer always cause kernel panic on my ARM device with
> > > multiple CPUs, I found a solution for the problem on ARM64, refers to
> > > the patch above,
> > > I was wondering why this bugfix on ARM64 hasn't been upstreamed to ARM,
> >
> > Patches get applied to the ARM tree after they've been submitted to
> > the patch system. If they don't get submitted to the patch system,
> > then they get buried and forgotten.
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
> 
> Thanks for replying,
> So I refers to the solution on ARM64 and sent my patch on January as below.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2021-January/628460.html
> 
> But I haven't got any replies on my patch. How can I get my patch reviewed
> and submitted to the patch system?

I don't use ftrace, so I'm not the right person to review it - but it
seems that lots of patches for ARM are left to me to try and review,
despite me not knowing sufficient to know whether it's correct or not.
This isn't sustainable.

> Should I resend a new patch to this maillist?

You can try but I suspect the same thing will happen. The only thing I
can think is if you put it in the patch system and I apply it, if
someone has a problem with it, they'll shout about it soon enough. Not
the best way, but I don't see much other option.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
