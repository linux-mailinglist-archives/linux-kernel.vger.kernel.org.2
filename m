Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD8F395615
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhEaHbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:31:24 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:41821 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhEaHbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:31:21 -0400
Received: by mail-ua1-f43.google.com with SMTP id g34so6105132uah.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQgr0jrwgMpVFAUZB3RLApwYyR9lZ6m4vn7BuOs8BZE=;
        b=foZ3P+eSYeAbVkJGSKhvokeBbgSffqJQ1pImRAQ56atei4V8CibA8PEZvKUhJh1ZCY
         4efUU7VizPhCRLSC7wHRYJvUQX24NWGnnZBCIUK/rU2IgIoIGHDjjTLyEF32QNdlcwH9
         N5a9sawMePW1yO/9I3GUx62W+Qk8Aze8XXVuGvWSAFzHUT93WQQBfrRC98M8v9qWKytu
         ADhf9tFDnkpS6e4mCvKLTGCelHHMRQwymccNSJZa9ieb3UErF4zZ2Nn5HQ63o5Nf4bOk
         DCbNnvY8CwOpYd1yx0HStG1qGq8xxK65y5UFwLKD2Oyajhi0G8L8ag2mhhhVbEAlN9ci
         2vdw==
X-Gm-Message-State: AOAM531i+lZj1L8cF39kpNQFdq/nNyxun7WM0kJowbfJSmLGt+/yhdKL
        s3Qu66N1GQwBvExcqvDpkXg2Js5/nDtEi3mPlvU=
X-Google-Smtp-Source: ABdhPJzLJYWhG27oKneqs3Qk+mw0Nr3I9SV46h/6fgKlrCNP+dDs3Nps9fDqEdHA/isrTAdrT8qge5HFZqyujLafn2Y=
X-Received: by 2002:ab0:26d8:: with SMTP id b24mr3257446uap.58.1622446179288;
 Mon, 31 May 2021 00:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <202105300736.7wVLvXHr-lkp@intel.com> <a0edf640-ec05-524e-9125-44decba27bbb@infradead.org>
In-Reply-To: <a0edf640-ec05-524e-9125-44decba27bbb@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 31 May 2021 09:29:27 +0200
Message-ID: <CAMuHMdUrG5AWRQ-ypU0NdjFTEttyguMWSCLyvGE0pikdLij2Dw@mail.gmail.com>
Subject: Re: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Andrew Lunn <andrew@lunn.ch>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 2:05 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 5/29/21 4:25 PM, kernel test robot wrote:
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   df8c66c4cfb91f2372d138b9b714f6df6f506966
> > commit: a9770eac511ad82390b9f4a3c1728e078c387ac7 net: mdio: Move MDIO drivers into a new subdirectory
> > date:   9 months ago
> > config: sh-allmodconfig (attached as .config)
> > compiler: sh4-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9770eac511ad82390b9f4a3c1728e078c387ac7
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout a9770eac511ad82390b9f4a3c1728e078c387ac7
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> >>> ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
>
> Just a comment here.  kernel test robot has reported this issue
> 5 times in 2021 that I know of -- and I could have missed some.
>
> I see that Geert recently (June 2020) reverted the
> EXPORT_SYMBOL(__delay) in arch/sh/lib/delay.c, with this comment:
>
>     __delay() is an internal implementation detail on several architectures.
>     Drivers should not call __delay() directly, as it has non-standardized
>     semantics, or may not even exist.
>     Hence there is no need to export __delay() to modules.
>
>     See also include/asm-generic/delay.h:
>
>         /* Undefined functions to get compile-time errors */
>         ...
>         extern void __delay(unsigned long loops);
>
> However, s/several architectures/all but one architecture: SH/.
> All architectures except for SH provide either an exported function,
> an inline function, or a macro for __delay(). Yeah, they probably
> don't all do the same delay.

Hence it must not be used by drivers, as it might give the false assumption
of working everywhere.  While drivers/net/mdio/mdio-cavium is
platform-specific, code might be copied in a new driver, less restricted
to a specific platform.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
