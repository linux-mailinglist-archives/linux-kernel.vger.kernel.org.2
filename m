Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B6B37773F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 17:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhEIPTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 11:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhEIPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 11:19:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6789C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 08:18:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c3so19666034lfs.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2n/1WwJTS3CsHkemEMlwQOIwzDpqt4PBSfYeUOZJbs=;
        b=gHXnKu7AoVw8HAQcszuZVIbiM0KOdy8Bt4l0fv4gb+yw293XqGKvnGXy/6iO/Oc07L
         BWX14NaHxuc/Z5T6DHuE95iHXWKOmQwbsQcxJT7LQ9rJHDcQbJcGQpgZYLKquBl70J/j
         e4hxAyuxjUjYUVsMgr8yHnwqzeCVYQshIiI/WMfFuDbi2unC/1YLqrd2jcxRoW/iAUpF
         B7+jFWLSDDco1umGCVtGJyXoBKX8iP7GiJ+HOYLDGpJMKj9cezxk4GQyNBREWhdN8Tvx
         1ZjPS26zTtxOVMAPKdBXOeykbtFrbAw0z0XayFRROPoW7Dj5pQMTmSyaiinkv17r26A+
         6X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2n/1WwJTS3CsHkemEMlwQOIwzDpqt4PBSfYeUOZJbs=;
        b=F40nosUqm3HqnOm7rzgTCUdg61Nc5zQ+W/S7ZzysS7CF96vuE2hRsJoAA33/xHAFTI
         kHiK0jHqu9wpKWZDsHy3bGM+bTeZ8GL54k+JCGaPIqXDKWqtWZA1Tx78tiO+VuiouBbc
         yYaILAaJkAf3Ym94IYXZcZljMbbbJ9EnyC2EiTScBkT444ptfzCtMkiQsArHwuloI3rD
         +8czgzOm+l6dAyHD4lhP1gASrUZ+JN5zfv7f4v1dLa4+b1dnOmBZz6OW7ijKRteMtvid
         QAwAsNHTyPAEQse5mCc1HVauufpZkxN6827ykYxWHIIG5w1S5tffN7JM7Ria3M3U/FoT
         cRMw==
X-Gm-Message-State: AOAM531matFHT0heKlcOA4S9+nsGZ8kV94iteXch3kBy/jm4aWWv/Mmn
        iSNRmX/gVVkqRZQp6NQBe+N3yBDsQ9oIIAio+ic+kg==
X-Google-Smtp-Source: ABdhPJyU7I7ni98Gix8nWiQccpsnGbFJnHUz46IUjRlDLuApdsX85VgJoM4pIEAveiPbfqQjn4jYQYBubxfYplReQSg=
X-Received: by 2002:a19:6755:: with SMTP id e21mr14308817lfj.29.1620573481273;
 Sun, 09 May 2021 08:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <202105091112.F5rmd4By-lkp@intel.com> <20210509122227.GH1336@shell.armlinux.org.uk>
In-Reply-To: <20210509122227.GH1336@shell.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 9 May 2021 17:17:49 +0200
Message-ID: <CACRpkdaNVg9zgaDN0JG+Z8dMMk+0fdpYHwGMHS-FKUG9MZAb4w@mail.gmail.com>
Subject: Re: arch/arm/boot/compressed/decompress.c:50: warning: "memmove" redefined
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, paging in the KSan mailing list and key people.

Certainly this problem must be the same on all platforms
using an XZ-compressed kernel and not just Arm?

What I wonder is why the other platforms that use
XZ compression don't redefine memmove and
memcpy in their decompress.c clause for XZ?

Can we just delete these two lines?
#define memmove memmove
#define memcpy memcpy

Imre?

I can test some platforms without these defines later
tonight and see what happens.

Yours,
Linus Walleij

On Sun, May 9, 2021 at 2:22 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Maybe the KASan folk can look into this, it isn't obvious how to fix
> this, since XZ needs memcpy/memmove #defined to avoid using its own
> version. Having KASan override these with a #define is all very well,
> but it makes the behaviour of lib/decompress_unxz.c indeterminant if
> we get rid of the definitions the XZ support added.
>
> On Sun, May 09, 2021 at 11:32:17AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   b741596468b010af2846b75f5e75a842ce344a6e
> > commit: 421015713b306e47af95d4d61cdfbd96d462e4cb ARM: 9017/2: Enable KASan for ARM
> > date:   6 months ago
> > config: arm-randconfig-r015-20210509 (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=421015713b306e47af95d4d61cdfbd96d462e4cb
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 421015713b306e47af95d4d61cdfbd96d462e4cb
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=arm
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> arch/arm/boot/compressed/decompress.c:50: warning: "memmove" redefined
> >       50 | #define memmove memmove
> >          |
> >    In file included from arch/arm/boot/compressed/decompress.c:8:
> >    arch/arm/include/asm/string.h:59: note: this is the location of the previous definition
> >       59 | #define memmove(dst, src, len) __memmove(dst, src, len)
> >          |
> >    arch/arm/boot/compressed/decompress.c:51: warning: "memcpy" redefined
> >       51 | #define memcpy memcpy
> >          |
> >    In file included from arch/arm/boot/compressed/decompress.c:8:
> >    arch/arm/include/asm/string.h:58: note: this is the location of the previous definition
> >       58 | #define memcpy(dst, src, len) __memcpy(dst, src, len)
> >          |
> >    arch/arm/boot/compressed/decompress.c:59:5: warning: no previous prototype for 'do_decompress' [-Wmissing-prototypes]
> >       59 | int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
> >          |     ^~~~~~~~~~~~~
> >
> >
> > vim +/memmove +50 arch/arm/boot/compressed/decompress.c
> >
> > 6e8699f7d68589 Albin Tonnerre 2010-04-03  48
> > a7f464f3db93ae Imre Kaloz     2012-01-26  49  #ifdef CONFIG_KERNEL_XZ
> > a7f464f3db93ae Imre Kaloz     2012-01-26 @50  #define memmove memmove
> > a7f464f3db93ae Imre Kaloz     2012-01-26  51  #define memcpy memcpy
> > a7f464f3db93ae Imre Kaloz     2012-01-26  52  #include "../../../../lib/decompress_unxz.c"
> > a7f464f3db93ae Imre Kaloz     2012-01-26  53  #endif
> > a7f464f3db93ae Imre Kaloz     2012-01-26  54
> >
> > :::::: The code at line 50 was first introduced by commit
> > :::::: a7f464f3db93ae5492bee6f6e48939fd8a45fa99 ARM: 7001/2: Wire up support for the XZ decompressor
> >
> > :::::: TO: Imre Kaloz <kaloz@openwrt.org>
> > :::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
