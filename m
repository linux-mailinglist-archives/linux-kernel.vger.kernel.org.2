Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876923F3991
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhHUIqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 04:46:49 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:44963 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUIqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 04:46:48 -0400
Received: by mail-vs1-f54.google.com with SMTP id s19so7705469vsl.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 01:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=va6Gb7rjmVjoeAGLob0DQSqpDmgniEt7RkRQXhCDyoI=;
        b=DHo26+aia+o4s7voglOOq9LUVeCRavnH+rBsDjNB74H3+6THpFoqIVqrMHeck7FtkK
         KocsfXEcX1Y7hKBKg7vQfC3xq8jS6e/Vsdm/t74SEljt+htoCVYwKVdQ+LrZUKS0lvoO
         B4QH7BrlrnfZktyW8VjfQf7MyMiIaDrOKAiQG7ehfVs0GDER5fFqj6ZIcy8T3KVyv6qM
         ND2vlYkrn2p0rwHAaaK8gj5VAH/M3QTm8C9+y0PV9h0EjXghb3F84nW6kyWaEeDMCxQn
         Mi2BaTvMRo+BpnqdraPRyefuar3aMfMc1Rb3qF4AhO16tni6y5iZ2Ohk7LILL66KLXQX
         WX8A==
X-Gm-Message-State: AOAM530Rs+pYIoL2EmElnSkRRDNKydTCSLaYP/k0i0KUUQk38D8vbTj+
        T+/rG3UwAwfzDESospw2MTRvhOg6Qa1So9i85D4=
X-Google-Smtp-Source: ABdhPJyJnDHU6REESPkSHU757X7kkoYljldvTL1dFT+MZ4zPPeEoq7sGi+icPM3niVYv6/ZEI+llLkKfhaUxdUfOV34=
X-Received: by 2002:a67:5c41:: with SMTP id q62mr19777652vsb.7.1629535568565;
 Sat, 21 Aug 2021 01:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <202108141331.fMjjWaW2-lkp@intel.com>
In-Reply-To: <202108141331.fMjjWaW2-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 21 Aug 2021 10:45:57 +0200
Message-ID: <CAMuHMdXUpk_dLhvcdgs1H6yLPrwXFJz_86dfXpm8PYxNq+DXrQ@mail.gmail.com>
Subject: Re: arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no
 previous prototype for function 'fdt_check_mem_start'
To:     kernel test robot <lkp@intel.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Robot,

On Sat, Aug 14, 2021 at 7:43 AM kernel test robot <lkp@intel.com> wrote:
> FYI, the error/warning still remains.

Yes, and that's fine, as this function is never called from C code,
only from assembler.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dfa377c35d70c31139b1274ec49f87d380996c42
> commit: 0673cb38951215060d7993b43ad3c45cd413c2c3 ARM: 9045/1: uncompress: Validate start of physical memory against passed DTB
> date:   6 months ago
> config: arm-randconfig-r003-20210814 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 62df4df41c939205b2dc0a2a3bfb75b8c1ed74fa)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
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
