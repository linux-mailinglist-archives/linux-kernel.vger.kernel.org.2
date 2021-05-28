Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F363A39406A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhE1J6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbhE1J57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:57:59 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670A0C061760
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a2uo9vSb+aABBmUmlUH2DE45CphhEqNlicwhzWks7yM=; b=ZjWKoO+erAmoYwbpbAIT3ml63
        wqI1VaOI9eHzxA5U3h6obbE6yhtbM/M4o9Qxwal4K+RghNN/cPy8O31/58pZkg1iO/x+fGCfEUTTg
        OFCKGscvYPWDndPrKrpIGgz/Odt5rrk0tU+e6ywDtgyVSInRyC35bIK/SGqUS82vCUuIXBu1/aqbe
        s0OK7SE2+FvvxXIuaUEWZFAmAGX1+7sHSmv40yl3H9IFoIpi8RCCfK+cvRpVdS+NVli9y8dXdtKVi
        gMfCYfy2VgfrpG/vUMf4xkmmJqiymK3cTAGo8jHpyVcN79PnZWqQbeG3DLvAqZFjBEVqSSCjoyHgs
        h2ZyyI8Zw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44434)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lmZDn-0008DM-RE; Fri, 28 May 2021 10:56:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lmZDi-0004cX-8U; Fri, 28 May 2021 10:55:58 +0100
Date:   Fri, 28 May 2021 10:55:58 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong liu <carver4lio@163.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] ARM: change vmalloc_min to vmalloc_start
Message-ID: <20210528095558.GN30436@shell.armlinux.org.uk>
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
 <CACRpkdbZObW2SXdTUkPrsezjjVU19emts420EN-uhkHWb+4vrA@mail.gmail.com>
 <sons6q6-2630-rr8s-18ns-221454n9472@syhkavp.arg>
 <8q526rs-853n-5q80-r9pn-87sso759r13@syhkavp.arg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8q526rs-853n-5q80-r9pn-87sso759r13@syhkavp.arg>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 06:32:43PM -0400, Nicolas Pitre wrote:
> On Tue, 18 May 2021, Nicolas Pitre wrote:
> 
> > On Wed, 19 May 2021, Linus Walleij wrote:
> > 
> > > On Tue, May 18, 2021 at 2:15 PM Russell King (Oracle)
> > > <rmk+kernel@armlinux.org.uk> wrote:
> > > 
> > > > Change the current vmalloc_min, which is supposed to be the lowest
> > > > address of vmalloc space including the VMALLOC_OFFSET, to vmalloc_start
> > > > which does not include VMALLOC_OFFSET.
> > > >
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > 
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > 
> > > > +static unsigned long __initdata vmalloc_start = VMALLOC_END - (240 << 20);
> > > 
> > > When I first read this it took me some time to figure out what was
> > > going on here, so if you have time, please fold in a comment
> > > with some explanation of that (240 << 20) thing, in some blog
> > > post I described it as "an interesting way to write 0x0f000000"
> > > but I suppose commit 0536bdf33faf chose this way for a
> > > specific reason? (Paging Nico if he can explain it.)
> > 
> > That's an alternative (and deprecated) way to write MB(240).
> 
> And it seems that MB() isn't globally defined either. Oh well.

I could add a patch on the end of the series changing it to 240 * SZ_1M
which will likely be clearer.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
