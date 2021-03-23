Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3828F345FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhCWNag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhCWNaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:30:11 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7056DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pGWpm+WB3Vg671czxou6SRrOuPgVTllUUjQ5wW0XDIY=; b=f58mUhhF/qAQqij8j0teM/Nme
        pOQH4AkaX50UpZeF9hu8EJI4bnuTM3N6r5NGYdyYAzvweSdbETGA+HFcTlK1trrPELb9cSOVyplt1
        +rZvhzqNYmIkLLIwlJ0Ew9TQZzNERrxVc+AKo0ZYnllUWDpbLPcGjN+VT7djASfmmUMnhrjbLpPXY
        ftmK7pRWaDfzD+iylv8tBqKphoI6qSuJEpwUINAScokczMOjq4hb5wArwN4OP38/mvac40zdOHRIW
        KpiPQiFBGnO44XXWKwjE9geXuv5N7n+wRZgzJW65QlqpFirtjFVncy+8KMdym0ZvVPaN2Jk0OWsVK
        K/WPz5RKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51626)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lOh6k-0007ly-7c; Tue, 23 Mar 2021 13:30:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lOh6j-0004Bx-In; Tue, 23 Mar 2021 13:30:05 +0000
Date:   Tue, 23 Mar 2021 13:30:05 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: delay: avoid clang -Wtautological-constant warning
Message-ID: <20210323133005.GC1463@shell.armlinux.org.uk>
References: <20210323132031.2858996-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323132031.2858996-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 02:20:23PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Passing an 8-bit constant into delay() triggers a warning when building
> with 'make W=1' using clang:
> 
> drivers/clk/actions/owl-pll.c:182:2: error: result of comparison of constant 2000 with expression of type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         udelay(pll_hw->delay);
>         ^~~~~~~~~~~~~~~~~~~~~
> arch/arm/include/asm/delay.h:84:9: note: expanded from macro 'udelay'
>           ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :              \
>            ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~
> arch/arm/mach-omap2/wd_timer.c:89:3: error: result of comparison of constant 2000 with expression of type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>                 udelay(oh->class->sysc->srst_udelay);
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Shut up the warning by adding a cast to a 64-bit number. A cast to 'int'
> would usually be sufficient, but would fail to cause a link-time error
> for large 64-bit constants.

What effect (if any) does this have on code generation when the argument
is not constant?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
