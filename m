Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364F838A083
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhETJCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhETJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:02:09 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C434CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QxCMxE1n0M4ZbNqcViyD9VUzdesR+E/xXz2vVnw5Oo4=; b=rkJL9VYH4aDBo17PfMVNpMeIY
        Hgfb3zm8SkopgsMf/pdV595J1DXPSaX3H52luHdo+JdTTLz7H2zujErLm0R5b5qENKA90sW3xRG8H
        Bb1LeBSYII74ViGKmBVqmdWXCEOUwqmkX7c/CO+nDxWj32sjua+Nz76K3bBBDrGOr8VHPZzXq012c
        A1TiTTL0PQwJsUjqbgztoYsdtXvkF244frq6GACd328KdKt6vphIlPD9dnee0Et3o5pMUJHD9e6Dr
        gj1W3KVD43WQVcWn2qHEhb1ZgNGWtwFS+9mxXMtfmr8KDomEvtipCgsdLDtZL80zDwsPapoQhDZpa
        v/cD/FC2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44212)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ljeXc-0006jj-My; Thu, 20 May 2021 10:00:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ljeXY-0005KF-LR; Thu, 20 May 2021 10:00:24 +0100
Date:   Thu, 20 May 2021 10:00:24 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM: change vmalloc_min to vmalloc_start
Message-ID: <20210520090024.GB30436@shell.armlinux.org.uk>
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
 <a7ad5c03-025a-4cf8-e4b1-2d150bfe3066@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ad5c03-025a-4cf8-e4b1-2d150bfe3066@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 12:41:10PM +0800, Xu, Yanfei wrote:
> On 5/18/21 8:15 PM, Russell King (Oracle) wrote:
> > -static unsigned long __initdata vmalloc_min =
> > -       VMALLOC_END - (240 << 20) - VMALLOC_OFFSET;
> > +static unsigned long __initdata vmalloc_start = VMALLOC_END - (240 << 20);
> > 
> >   /*
> >    * vmalloc=size forces the vmalloc area to be exactly 'size'
> > @@ -1169,7 +1168,8 @@ void __init adjust_lowmem_bounds(void)
> >           * and may itself be outside the valid range for which phys_addr_t
> >           * and therefore __pa() is defined.
> >           */
> > -       vmalloc_limit = (u64)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
> > +       vmalloc_limit = (u64)vmalloc_start -
> > +                       (PAGE_OFFSET + PHYS_OFFSET + VMALLOC_OFFSET);
> > 
> Here is bug, it should be
> 
>        vmalloc_limit = (u64)vmalloc_start -
>                        (PAGE_OFFSET + VMALLOC_OFFSET) + PHYS_OFFSET;

Yes, you're absolutely right, thanks for catching that!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
