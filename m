Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18CC3F7BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhHYRmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhHYRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:42:00 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF21C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:41:14 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id s21-20020a4ae495000000b0028e499b5921so42519oov.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aw3brOwN5Jhb/Bo2iMjArzjo8QBTyjKlASCK9C+nljI=;
        b=Zbqh2TYRlbeza1PVgqnwUwnPY5ZBThR6Pu7f8KwXMLxI1jKdgAjU4VShNA7N6F+1A6
         9woNlyEJkNEbO4j83g8uHJbBdObXFHxhLC07p/OL1NIGbDT/+M4Fqc2V83UeeHJCcF6e
         mSdpPBFsnQBB5wzr2Xu8/zfdVWT+65AbZZo9b15KOyKz1sXIkOgNhAsloB4fDBu4fvic
         lqCtgFt0RHDZNQgWDUO/lE6keA1BpYe6TrOwWOz7ozqlZZDnbEvp1iH3tzvwew61s9Sz
         c9lTmOJRE9UamGyBqrVGf0OOkJU1UodqlTcKA4ospuL4IkDzeQJ9Q9vqopZJwenTCXp2
         1umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aw3brOwN5Jhb/Bo2iMjArzjo8QBTyjKlASCK9C+nljI=;
        b=pYr0wVdqOwM15ePDdysDu8Q/9qGwfw5E1x2KDGymSaTPe3fF39DZY3X5FrI4Xe8+Fm
         CiiImjlBIM+3u+G0RMH9JANfEWLlMBsO5Rqej6HrtaC9w07ZPaLMNp64wzt/2jlyKyYS
         +l+2hIqnnr85IVfp6Z0pFPoRMfYEedlyugzFJ2CPGIjc3nVLHgUE3gZCBJ8w4Z4dT+RA
         EYKo8ayif1oZUeQ3mdIA6tBaUPDkhHDZRG0X11Orj8Cu93YA1Q39Ixeq6R1AQXmms25E
         9C9PnECuNdky+TZIINGgEMENjGAytINdkAk5fBqbPF2+BD2d0rrJ7cZOIIeljuXZE4yx
         8mpQ==
X-Gm-Message-State: AOAM531UlXsvv2oDkKVDmZzvA9T+IWxNMX94T/Gd3i52OHav9UBpSbba
        8J1Uzv0/UQUBm2+FipDn5sY7mO3cF1PMF7DQRhV/dg==
X-Google-Smtp-Source: ABdhPJxH9I9bPEdngAuxbyXKyRGhF1KYknZ/VUngpYVwoqq13ymoj5tUK7FlgPYn1ncuygjgfEJI9+JRgRAJJPyJDek=
X-Received: by 2002:a4a:e907:: with SMTP id z7mr35471221ood.20.1629913273561;
 Wed, 25 Aug 2021 10:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <202108141331.fMjjWaW2-lkp@intel.com> <CAMuHMdXUpk_dLhvcdgs1H6yLPrwXFJz_86dfXpm8PYxNq+DXrQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXUpk_dLhvcdgs1H6yLPrwXFJz_86dfXpm8PYxNq+DXrQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 10:41:03 -0700
Message-ID: <CAKwvOd=HkZPN-0k=QYGx6y4q1ig7=8dQY3d_OU10Qp0N__tZcA@mail.gmail.com>
Subject: Re: arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no
 previous prototype for function 'fdt_check_mem_start'
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 1:46 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Dear Robot,
>
> On Sat, Aug 14, 2021 at 7:43 AM kernel test robot <lkp@intel.com> wrote:
> > FYI, the error/warning still remains.
>
> Yes, and that's fine, as this function is never called from C code,
> only from assembler.

That's fine, then you can add a prototype to the .c source file.  See
what we do for stpcpy: 1e1b6d63d6340.

>
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   dfa377c35d70c31139b1274ec49f87d380996c42
> > commit: 0673cb38951215060d7993b43ad3c45cd413c2c3 ARM: 9045/1: uncompress: Validate start of physical memory against passed DTB
> > date:   6 months ago
> > config: arm-randconfig-r003-20210814 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 62df4df41c939205b2dc0a2a3bfb75b8c1ed74fa)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0673cb38951215060d7993b43ad3c45cd413c2c3
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 0673cb38951215060d7993b43ad3c45cd413c2c3
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no previous prototype for function 'fdt_check_mem_start' [-Wmissing-prototypes]
> >    uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
> >             ^
> >    arch/arm/boot/compressed/fdt_check_mem_start.c:62:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >    uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
> >    ^
> >    static
> >    1 warning generated.
> >
> >
> > vim +/fdt_check_mem_start +62 arch/arm/boot/compressed/fdt_check_mem_start.c
> >
> >     46
> >     47  /*
> >     48   * Check the start of physical memory
> >     49   *
> >     50   * Traditionally, the start address of physical memory is obtained by masking
> >     51   * the program counter.  However, this does require that this address is a
> >     52   * multiple of 128 MiB, precluding booting Linux on platforms where this
> >     53   * requirement is not fulfilled.
> >     54   * Hence validate the calculated address against the memory information in the
> >     55   * DTB, and, if out-of-range, replace it by the real start address.
> >     56   * To preserve backwards compatibility (systems reserving a block of memory
> >     57   * at the start of physical memory, kdump, ...), the traditional method is
> >     58   * always used if it yields a valid address.
> >     59   *
> >     60   * Return value: start address of physical memory to use
> >     61   */
> >   > 62  uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>
>
> --
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAMuHMdXUpk_dLhvcdgs1H6yLPrwXFJz_86dfXpm8PYxNq%2BDXrQ%40mail.gmail.com.



-- 
Thanks,
~Nick Desaulniers
