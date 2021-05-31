Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918EF396642
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhEaRCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:02:38 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:39741 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhEaPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:47:04 -0400
Received: by mail-vs1-f49.google.com with SMTP id z19so1625144vsj.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+eGNhUKFUivEnttgXamRIuTy3jKdGsSpmPO5qedOGwY=;
        b=SnXGsZlp0zCS5kmVOtCFGpYkPx0Zd8ofc6gPnTe9EhEeejJYVR1ys4YMfyIEISvQFu
         yoGbXKtUfwkzvS7HB12ry5GzJhrlwD5cwHJR9oHBhPYZZR5hm55ZYi42vnjuKskaYB0B
         qJbldOKp2BhbMXx6M00Fm7Gp03L3YhHbPw01wVIFnqFD17gq1NofT5bxlBpDqar/X0cf
         CuJA5ZC/OvuiiZVdDGO1P+hGhvw0shDQ7gJx8SRUdc6adoZs3TWLWGA5OwhykiqLrUqU
         z1NhG45Ppm5+7uDaRfBawMz+wDx7Wmxj+7ksDW7ukoTfXMG3j6rHwrOYt6LPOuZ4i6yU
         UJCA==
X-Gm-Message-State: AOAM533Qyfvh6U9T9FklVrkAUae2jZZl4eUw0dsg70CyAW1gxWdMzGRG
        lbuEeYfb4OmH+Go2ViRvdwDGXPh5iBOEM1731bc=
X-Google-Smtp-Source: ABdhPJw/zp5/xeKH6bmRlYbI4gAMKQI2Wi/pKTrFJGdSUrh0wwPp+B8BpU8GTYlfzgyvCkHqcGae8ZtMIvYDcJnHrJE=
X-Received: by 2002:a67:3c2:: with SMTP id 185mr14153073vsd.42.1622475923298;
 Mon, 31 May 2021 08:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <202105300736.7wVLvXHr-lkp@intel.com> <a0edf640-ec05-524e-9125-44decba27bbb@infradead.org>
 <CAMuHMdUrG5AWRQ-ypU0NdjFTEttyguMWSCLyvGE0pikdLij2Dw@mail.gmail.com>
 <CAMuHMdW+e8qvKsf4Ub1zNnBgBX6TKGmUKHSDK0jy05H5gmrh+g@mail.gmail.com> <9db68758-1bf0-cec9-4914-ccb8439e2d1f@infradead.org>
In-Reply-To: <9db68758-1bf0-cec9-4914-ccb8439e2d1f@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 31 May 2021 17:45:10 +0200
Message-ID: <CAMuHMdWiPjuf47=SBjNrQNjf4QiwDf6t0kkx_5BdPVoa22zxmw@mail.gmail.com>
Subject: Re: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     David Daney <david.daney@cavium.com>,
        kernel test robot <lkp@intel.com>,
        Andrew Lunn <andrew@lunn.ch>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, May 31, 2021 at 5:12 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 5/31/21 12:32 AM, Geert Uytterhoeven wrote:
> > CC David (original author, asked by driver location change)
> >
> > On Mon, May 31, 2021 at 9:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>
> >> On Mon, May 31, 2021 at 2:05 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>> On 5/29/21 4:25 PM, kernel test robot wrote:
> >>>> First bad commit (maybe != root cause):
> >>>>
> >>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >>>> head:   df8c66c4cfb91f2372d138b9b714f6df6f506966
> >>>> commit: a9770eac511ad82390b9f4a3c1728e078c387ac7 net: mdio: Move MDIO drivers into a new subdirectory
> >>>> date:   9 months ago
> >>>> config: sh-allmodconfig (attached as .config)
> >>>> compiler: sh4-linux-gcc (GCC) 9.3.0
> >>>> reproduce (this is a W=1 build):
> >>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>>>         chmod +x ~/bin/make.cross
> >>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9770eac511ad82390b9f4a3c1728e078c387ac7
> >>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>>>         git fetch --no-tags linus master
> >>>>         git checkout a9770eac511ad82390b9f4a3c1728e078c387ac7
> >>>>         # save the attached .config to linux build tree
> >>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh
> >>>>
> >>>> If you fix the issue, kindly add following tag as appropriate
> >>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>>
> >>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
> >>>>
> >>>>>> ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
> >>>
> >>> Just a comment here.  kernel test robot has reported this issue
> >>> 5 times in 2021 that I know of -- and I could have missed some.
> >>>
> >>> I see that Geert recently (June 2020) reverted the
> >>> EXPORT_SYMBOL(__delay) in arch/sh/lib/delay.c, with this comment:
> >>>
> >>>     __delay() is an internal implementation detail on several architectures.
> >>>     Drivers should not call __delay() directly, as it has non-standardized
> >>>     semantics, or may not even exist.
> >>>     Hence there is no need to export __delay() to modules.
> >>>
> >>>     See also include/asm-generic/delay.h:
> >>>
> >>>         /* Undefined functions to get compile-time errors */
> >>>         ...
> >>>         extern void __delay(unsigned long loops);
> >>>
> >>> However, s/several architectures/all but one architecture: SH/.
> >>> All architectures except for SH provide either an exported function,
> >>> an inline function, or a macro for __delay(). Yeah, they probably
> >>> don't all do the same delay.
> >>
> >> Hence it must not be used by drivers, as it might give the false assumption
> >> of working everywhere.  While drivers/net/mdio/mdio-cavium is
> >> platform-specific, code might be copied in a new driver, less restricted
> >> to a specific platform.
>
> Geert, should all (15) of the other arch EXPORT_SYMBOL(__delay); exports
> be removed?  (in theory?  I'm not planning to remove them.)

It depends.  If they are internal implementation details of an
architecture's mdelay() or udelay() function (i.e. the latter are
static inline functions that may call into out-of-line __delay()
functions), then they should be kept.

I haven't checked all of them, but e.g. on arm64, mdelay() and udelay()
don't call into __delay, so IMHO its export should be removed.

Generic drivers should not use __delay() with a hardcoded value, as
its semantics are not defined (cfr. the undefined function comment
in asm-generic).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
