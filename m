Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBB9377695
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 14:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhEIMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 08:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhEIMXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 08:23:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4208C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ca7Q0yF7MgdSOw+QM60ddq/Bz3TgCD7QmIaDsLYoye8=; b=baGRhoa0Cl8dBfKlARkemcnbm
        EuHScPEJXTY/PD6OubOV386PmkXr98Lq5IdlOGxdCkOw5q80Y58xn4R/HFUDNYRE3yw7LyZej2U/8
        gh5flp8IlvIxAqFPRzKL0rgTf8AAmgp4qbSyP5B2bMOEUBvGgYPROLSmPPYPWXSHlDL3EYv88G2+o
        4hwH3LQM5H6LElTks7L8d3bv/lF+Nruu6UABYU+dqNH9rpL82/pj5Huxnma7o7wwmdtzGfW0JMYJg
        mpGyFXDkiQ0yt5bkPqxbCzqDIZiepNRoYacYCHmmCd9l0vZEVhRpmMcf1MRhkb2oTYPz5xIkZlO/g
        /fgV/HOUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43812)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lfiSC-0007Ed-9e; Sun, 09 May 2021 13:22:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lfiS3-0007cy-Lb; Sun, 09 May 2021 13:22:27 +0100
Date:   Sun, 9 May 2021 13:22:27 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/arm/boot/compressed/decompress.c:50: warning: "memmove"
 redefined
Message-ID: <20210509122227.GH1336@shell.armlinux.org.uk>
References: <202105091112.F5rmd4By-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105091112.F5rmd4By-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe the KASan folk can look into this, it isn't obvious how to fix
this, since XZ needs memcpy/memmove #defined to avoid using its own
version. Having KASan override these with a #define is all very well,
but it makes the behaviour of lib/decompress_unxz.c indeterminant if
we get rid of the definitions the XZ support added.

On Sun, May 09, 2021 at 11:32:17AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b741596468b010af2846b75f5e75a842ce344a6e
> commit: 421015713b306e47af95d4d61cdfbd96d462e4cb ARM: 9017/2: Enable KASan for ARM
> date:   6 months ago
> config: arm-randconfig-r015-20210509 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=421015713b306e47af95d4d61cdfbd96d462e4cb
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 421015713b306e47af95d4d61cdfbd96d462e4cb
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/arm/boot/compressed/decompress.c:50: warning: "memmove" redefined
>       50 | #define memmove memmove
>          | 
>    In file included from arch/arm/boot/compressed/decompress.c:8:
>    arch/arm/include/asm/string.h:59: note: this is the location of the previous definition
>       59 | #define memmove(dst, src, len) __memmove(dst, src, len)
>          | 
>    arch/arm/boot/compressed/decompress.c:51: warning: "memcpy" redefined
>       51 | #define memcpy memcpy
>          | 
>    In file included from arch/arm/boot/compressed/decompress.c:8:
>    arch/arm/include/asm/string.h:58: note: this is the location of the previous definition
>       58 | #define memcpy(dst, src, len) __memcpy(dst, src, len)
>          | 
>    arch/arm/boot/compressed/decompress.c:59:5: warning: no previous prototype for 'do_decompress' [-Wmissing-prototypes]
>       59 | int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
>          |     ^~~~~~~~~~~~~
> 
> 
> vim +/memmove +50 arch/arm/boot/compressed/decompress.c
> 
> 6e8699f7d68589 Albin Tonnerre 2010-04-03  48  
> a7f464f3db93ae Imre Kaloz     2012-01-26  49  #ifdef CONFIG_KERNEL_XZ
> a7f464f3db93ae Imre Kaloz     2012-01-26 @50  #define memmove memmove
> a7f464f3db93ae Imre Kaloz     2012-01-26  51  #define memcpy memcpy
> a7f464f3db93ae Imre Kaloz     2012-01-26  52  #include "../../../../lib/decompress_unxz.c"
> a7f464f3db93ae Imre Kaloz     2012-01-26  53  #endif
> a7f464f3db93ae Imre Kaloz     2012-01-26  54  
> 
> :::::: The code at line 50 was first introduced by commit
> :::::: a7f464f3db93ae5492bee6f6e48939fd8a45fa99 ARM: 7001/2: Wire up support for the XZ decompressor
> 
> :::::: TO: Imre Kaloz <kaloz@openwrt.org>
> :::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
