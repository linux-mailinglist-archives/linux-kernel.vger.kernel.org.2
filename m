Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88820308915
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 13:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhA2MUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 07:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhA2MME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 07:12:04 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA87C08ECAB;
        Fri, 29 Jan 2021 02:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YFmf9BN+skUEyMw7b9mve+y8RvKINlPUjAkMO4cHHOg=; b=pWkZru0FYhgHwQd1+Rg+II9rl
        j5tucLHDGxxWB/Vp8pn9UiySSZgiGKVB5ywfLSv5jlad7stPzD0Jl+1+Qp1HsMkBuPBmC/r03fw3A
        awf4qTcQIQ+Z4rAwqgmVeWPOD8ndIzdDBS9GRCS/iDrl5Kqy5VvGjFBQK+pAEvZv2pMf7OvZuQpr/
        Ol9M0JHSHyIiVRjLQ0B/SWwXsNRpsXfFoSEGGjJLN2TYtpWwJ+u9Xjd40+30T9CeH54NwmWOXP3qx
        swNuM/TYGEuv3T0gLlvwvao2fgN517drTUSkbf/V+gFy1MrFJDO/fsXM56rlbZgEeH3jLoQpV+9Ui
        tBxDtrbbg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54182)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l5R5z-0000uJ-AX; Fri, 29 Jan 2021 10:33:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l5R5w-0006on-Rd; Fri, 29 Jan 2021 10:33:40 +0000
Date:   Fri, 29 Jan 2021 10:33:40 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] ARM: Add support for Hisilicon Kunpeng L3 cache
 controller
Message-ID: <20210129103340.GW1551@shell.armlinux.org.uk>
References: <20210116032740.873-1-thunder.leizhen@huawei.com>
 <20210116032740.873-5-thunder.leizhen@huawei.com>
 <CAK8P3a1OqUn5A4F4hT4K=bzQwJuifVFZkvFoK6NMg+m9FjoKzw@mail.gmail.com>
 <20dac713-25b7-cddf-cc42-69a834487c71@huawei.com>
 <CAK8P3a3Hj0Hyc8mVdGYhB7AEuHCYbhGxHnhNk1xWonEmxZOxRw@mail.gmail.com>
 <CAK8P3a1j+mr3bCp2uCuuYzW0ygjTmGv9vELuNy7v-iQ=WoDMOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1j+mr3bCp2uCuuYzW0ygjTmGv9vELuNy7v-iQ=WoDMOw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 11:26:38AM +0100, Arnd Bergmann wrote:
> Another clarification, as there are actually two independent
> points here:
> 
> * if you can completely remove the readl() above and just write a
>   hardcoded value into the register, or perhaps read the original
>   value once at boot time, that is probably a win because it
>   avoids one of the barriers in the beginning. The datasheet should
>   tell you if there are any bits in the register that have to be
>   preserved
> 
> * Regarding the _relaxed() accessors, it's a lot harder to know
>   whether that is safe, as you first have to show, in particular in case
>   any of the accesses stop being guarded by the spinlock in that
>   case, and whether there may be a case where you have to
>   serialize the memory access against accesses that are still in the
>   store queue or prefetched.
> 
> Whether this matters at all depends mostly on the type of devices
> you are driving on your SoC. If you have any high-speed network
> interfaces that are unable to do cache coherent DMA, any extra
> instruction here may impact the number of packets you can transfer,
> but if all your high-speed devices are connected to a coherent
> interconnect, I would just go with the obvious approach and use
> the safe MMIO accessors everywhere.

For L2 cache code, I would say the opposite, actually, because it is
all too easy to get into a deadlock otherwise.

If you implement the sync callback, that will be called from every
non-relaxed accessor, which means if you need to take some kind of
lock in the sync callback and elsewhere in the L2 cache code, you will
definitely deadlock.

It is safer to put explicit barriers where it is necessary.

Also remember that the barrier in readl() etc is _after_ the read, not
before, and the barrier in writel() is _before_ the write, not after.
The point is to ensure that DMA memory accesses are properly ordered
with the IO-accessing instructions.

So, using readl_relaxed() with a read-modify-write is entirely sensible
provided you do not access DMA memory inbetween.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
