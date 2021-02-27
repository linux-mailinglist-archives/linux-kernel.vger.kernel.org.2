Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D666326C93
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 10:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhB0Jzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 04:55:51 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:33837 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhB0Jzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 04:55:46 -0500
Received: by mail-oi1-f176.google.com with SMTP id w69so12599173oif.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 01:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FtblZAdeGtW05dqBERy4tBfNxSBQQUNZrk6WUT7tes=;
        b=kB8iBrBTwfcgKvXXKbcv8ClQQvEWlFwmvEIBPK6BA4C7NzQ3BxW1Pnuzeo+8X80UpS
         +vHiYmAweM4/Rp9Vvr5p0XKlLFlMxaVZKAC1k06nE4oJWBecq9F5gS3r31sy1HSDl4ig
         G+ZahpANjV2ecJw5Yrdxv7zV41LZiaxEoqNUSjOq/LjHQkh/ElO/xvG2e1g556YThkGP
         QyrUH7lvFlDL6moha7Uh9qf46n08YFfoyXyIdFc4PT7aCjYIxAqUZDf/+OcFvMglRpgL
         eawrA1Wr1Ww77SJRi0SeeWvTCdRyD8rww/ypU8Te/6RIwCDUbiGIr1/KbfDlu2iUVlGU
         jA1w==
X-Gm-Message-State: AOAM531iND6wvdvPhWGrRYvHlIkNCwR4y4U8EkbeYfeI50RfoHZJtRQ9
        f6dV+UQt7z0ASwqKOIN2Qy8Mc6QUd2w6PM64eH8=
X-Google-Smtp-Source: ABdhPJyVDvGOAo5h/1njy2ZWzsN292YK/QBvIUeu6+36GUs4/LNPUA3WOMboZA1/9xQ3xGosYNh4Wmn91631VGY3+zA=
X-Received: by 2002:a05:6808:a0b:: with SMTP id n11mr4995768oij.161.1614419705255;
 Sat, 27 Feb 2021 01:55:05 -0800 (PST)
MIME-Version: 1.0
References: <202102271029.FTsmHEk9-lkp@intel.com>
In-Reply-To: <202102271029.FTsmHEk9-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 27 Feb 2021 10:54:52 +0100
Message-ID: <CAMuHMdVEpQhBTATr876LF7r3r=zEtnS=V8OFL6_0pgNWDWR0hA@mail.gmail.com>
Subject: Re: arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no
 previous prototype for function 'fdt_check_mem_start'
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel Test Robot,

On Sat, Feb 27, 2021 at 3:47 AM kernel test robot <lkp@intel.com> wrote:
> FYI, the error/warning still remains.

My response in
https://lore.kernel.org/linux-arm-kernel/CAMuHMdVmMLvvJ4mAa+y8JCJ2+5Bwu2W=psgn3toC1msTghn=Xg@mail.gmail.com/
is still valid.

>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3fb6d0e00efc958d01c2f109c8453033a2d96796
> commit: 0673cb38951215060d7993b43ad3c45cd413c2c3 ARM: 9045/1: uncompress: Validate start of physical memory against passed DTB
> date:   4 weeks ago
> config: arm-randconfig-r003-20210226 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project b889ef4214bc6dc8880fdd4badc0dcd9a3197753)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0673cb38951215060d7993b43ad3c45cd413c2c3
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 0673cb38951215060d7993b43ad3c45cd413c2c3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no previous prototype for function 'fdt_check_mem_start' [-Wmissing-prototypes]
>    uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>             ^
>    arch/arm/boot/compressed/fdt_check_mem_start.c:62:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>    ^
>    static
>    1 warning generated.
>
>
> vim +/fdt_check_mem_start +62 arch/arm/boot/compressed/fdt_check_mem_start.c
>
>     46
>     47  /*
>     48   * Check the start of physical memory
>     49   *
>     50   * Traditionally, the start address of physical memory is obtained by masking
>     51   * the program counter.  However, this does require that this address is a
>     52   * multiple of 128 MiB, precluding booting Linux on platforms where this
>     53   * requirement is not fulfilled.
>     54   * Hence validate the calculated address against the memory information in the
>     55   * DTB, and, if out-of-range, replace it by the real start address.
>     56   * To preserve backwards compatibility (systems reserving a block of memory
>     57   * at the start of physical memory, kdump, ...), the traditional method is
>     58   * always used if it yields a valid address.
>     59   *
>     60   * Return value: start address of physical memory to use
>     61   */
>   > 62  uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
