Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89643F82D4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 09:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbhHZHDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 03:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238773AbhHZHDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 03:03:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00774610CB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 07:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629961356;
        bh=hm6kNzovuJBc4NOoyMxTM0MA56iTAkmH3ojwLqZQi58=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Boj0nZqwI/tu26cJFpSP0bpbpEd+bZThlEIxWMKiifD5/svFw9SzFjSOVpawIAieo
         NofoBzldZdTbFVdDPxIe5xdi97aAmP5LSJ95SoBMzh2mo0pXuC/ty8FONb7xFp48Xs
         Ocy5FPf0fRvZQ8IcmaRRPOA7bEMMhC0+kmKfVBp595n5pAeukOTFaF8RlkH2vT6dus
         bD3BINzQEx7xf8P5TBn8TyXUnOJ/uDnWOtIAfdCB+/8y0Eh6Sl1HyX8hXYqczFmpZL
         d8HDVtsNaC6ZPIq6R6tibDzk+Lurt3vB32pn7XYkCAPc+4HxQifqrYJa5lOSf3agwj
         eqbGRYBUgkcQw==
Received: by mail-ot1-f42.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so2258718otf.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 00:02:35 -0700 (PDT)
X-Gm-Message-State: AOAM532EqeB8bkBi5no9kH7uQVIOMcAU7+Sga8jrxCFmK9Gf9homJdRi
        wLqw17yC/VIUcRWww6g9D/tQiUSrACkar0Bn/8s=
X-Google-Smtp-Source: ABdhPJxFHkJaw/BqRMnRcuJ8xKGIJ933xxc2USQqOizbUsVZ5fjEqduH7g50gkaDq8IYW7FL39es428P1vvaRYTF6Jc=
X-Received: by 2002:a05:6830:124b:: with SMTP id s11mr1945378otp.90.1629961355206;
 Thu, 26 Aug 2021 00:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <202108141331.fMjjWaW2-lkp@intel.com> <CAMuHMdXUpk_dLhvcdgs1H6yLPrwXFJz_86dfXpm8PYxNq+DXrQ@mail.gmail.com>
 <CAKwvOd=HkZPN-0k=QYGx6y4q1ig7=8dQY3d_OU10Qp0N__tZcA@mail.gmail.com>
In-Reply-To: <CAKwvOd=HkZPN-0k=QYGx6y4q1ig7=8dQY3d_OU10Qp0N__tZcA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 26 Aug 2021 09:02:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHOC+REy57zXeWzz3P032bD_GvO6JHn=SSWuCXLc0rasA@mail.gmail.com>
Message-ID: <CAMj1kXHOC+REy57zXeWzz3P032bD_GvO6JHn=SSWuCXLc0rasA@mail.gmail.com>
Subject: Re: arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no
 previous prototype for function 'fdt_check_mem_start'
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 at 19:41, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sat, Aug 21, 2021 at 1:46 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Dear Robot,
> >
> > On Sat, Aug 14, 2021 at 7:43 AM kernel test robot <lkp@intel.com> wrote:
> > > FYI, the error/warning still remains.
> >
> > Yes, and that's fine, as this function is never called from C code,
> > only from assembler.
>
> That's fine, then you can add a prototype to the .c source file.  See
> what we do for stpcpy: 1e1b6d63d6340.
>

We should use 'asmlinkage' for this - we should add it to the
definition of this function, and we should teach the tooling that
'asmlinkage' functions don't need a prototype.

> >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   dfa377c35d70c31139b1274ec49f87d380996c42
> > > commit: 0673cb38951215060d7993b43ad3c45cd413c2c3 ARM: 9045/1: uncompress: Validate start of physical memory against passed DTB
> > > date:   6 months ago
> > > config: arm-randconfig-r003-20210814 (attached as .config)
> > > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 62df4df41c939205b2dc0a2a3bfb75b8c1ed74fa)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0673cb38951215060d7993b43ad3c45cd413c2c3
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 0673cb38951215060d7993b43ad3c45cd413c2c3
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no previous prototype for function 'fdt_check_mem_start' [-Wmissing-prototypes]
> > >    uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
> > >             ^
> > >    arch/arm/boot/compressed/fdt_check_mem_start.c:62:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > >    uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
> > >    ^
> > >    static
> > >    1 warning generated.
> > >
> > >
> > > vim +/fdt_check_mem_start +62 arch/arm/boot/compressed/fdt_check_mem_start.c
> > >
> > >     46
> > >     47  /*
> > >     48   * Check the start of physical memory
> > >     49   *
> > >     50   * Traditionally, the start address of physical memory is obtained by masking
> > >     51   * the program counter.  However, this does require that this address is a
> > >     52   * multiple of 128 MiB, precluding booting Linux on platforms where this
> > >     53   * requirement is not fulfilled.
> > >     54   * Hence validate the calculated address against the memory information in the
> > >     55   * DTB, and, if out-of-range, replace it by the real start address.
> > >     56   * To preserve backwards compatibility (systems reserving a block of memory
> > >     57   * at the start of physical memory, kdump, ...), the traditional method is
> > >     58   * always used if it yields a valid address.
> > >     59   *
> > >     60   * Return value: start address of physical memory to use
> > >     61   */
> > >   > 62  uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> >
> >
> > --
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAMuHMdXUpk_dLhvcdgs1H6yLPrwXFJz_86dfXpm8PYxNq%2BDXrQ%40mail.gmail.com.
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
