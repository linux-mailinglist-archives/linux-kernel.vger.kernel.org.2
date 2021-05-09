Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB86377791
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 18:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhEIQ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhEIQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 12:26:42 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3303AC061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KRn3B1NtIl+yLDWbQMHjQsRz0WhuDJp2AzBSzKYNPXs=; b=imv9hB2TML0JeBx7j2mQHrO5O
        AYFcyIq8/VbdQSDB+BQ1hpunSQhkNLg2Jw43jXsOW7ESZD0IVP8LPDpwoHKfsYAwXTIxt+jqPsX9n
        /UrPmvtvfWdL/VmruDwTG+BUgYZKdmfcuEdVvyNIuDW/CPEW/2Cs5F66iB08GxQLA8Fxhs7BvuW87
        Dgar8liqt2WxxhWgkB0i31ObqbFhlzEaLKfidGIWQnfYdjOrzJlJc47jPtLB1dLNIHp5ekmoJyS6E
        6WI2rCMdMB06aeowGM8vvPTkfJ4mbAIdAiqtSCVl4UVhbct5v1nWA93Wgkot/cHiD5Qh8txqZ+DN5
        JtSlq0niw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43816)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lfmF0-0007R1-3t; Sun, 09 May 2021 17:25:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lfmEn-0007ky-JK; Sun, 09 May 2021 17:25:01 +0100
Date:   Sun, 9 May 2021 17:25:01 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: arch/arm/boot/compressed/decompress.c:50: warning: "memmove"
 redefined
Message-ID: <20210509162501.GJ1336@shell.armlinux.org.uk>
References: <202105091112.F5rmd4By-lkp@intel.com>
 <20210509122227.GH1336@shell.armlinux.org.uk>
 <CACRpkdaNVg9zgaDN0JG+Z8dMMk+0fdpYHwGMHS-FKUG9MZAb4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaNVg9zgaDN0JG+Z8dMMk+0fdpYHwGMHS-FKUG9MZAb4w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 05:17:49PM +0200, Linus Walleij wrote:
> OK, paging in the KSan mailing list and key people.
> 
> Certainly this problem must be the same on all platforms
> using an XZ-compressed kernel and not just Arm?
> 
> What I wonder is why the other platforms that use
> XZ compression don't redefine memmove and
> memcpy in their decompress.c clause for XZ?
> 
> Can we just delete these two lines?
> #define memmove memmove
> #define memcpy memcpy

We can't. XZ has:

#ifndef memmove
/* Not static to avoid a conflict with the prototype in the Linux
 * headers. */
void *memmove(void *dest, const void *src, size_t size)
{
...
}
#endif

So, if memmove is not defined in the preprocessor, the code will create
its own implementation. memmove() is also defined in
arch/arm/boot/compressed/string.c for use with other decompressors, so
the local version in lib/decompress_unxz.c will conflict and cause a
link time error.

The addition of KASan added this to arch/arm/include/asm/string.h:

#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
#define memcpy(dst, src, len) __memcpy(dst, src, len)
#define memmove(dst, src, len) __memmove(dst, src, len)
#define memset(s, c, n) __memset(s, c, n)

#ifndef __NO_FORTIFY
#define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
#endif

#endif

created a conditional definition of memmove in the preprocessor, which
ultimately caused this problem. lib/decompress_unxz.c wants it defined
in the preprocessor _if_ one has a local implementation (we do.)

Given that KASan should be disabled in the decompressor, maybe the
conditional added by KASan to asm/string.h is insufficient? The
makefile has:

KASAN_SANITIZE          := n

So really we should not be playing _any_ KASan games in the
decompressor code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
