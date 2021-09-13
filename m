Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BF64085E4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbhIMH4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:56:20 -0400
Received: from mail-vk1-f177.google.com ([209.85.221.177]:37819 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbhIMH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:56:18 -0400
Received: by mail-vk1-f177.google.com with SMTP id s125so1696059vkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saD28hGtMTLmTiCahERWSJjPX528ArL0ordR/X4GN/g=;
        b=LGSA//QXb/ZTrZ2H5iV0qQfWW8cxN1sxttApJb9xe3up4agPevhLqmq2eo+P91KACi
         mWcYBGf/39zb0tnYZY7X90TtI6KdkO/AjJRFLBHxeSEC5T++HM4qaP4LShktfxS7+UKV
         LRFbYKp3C+ztt77NXtwpniequONcr0GqhQDmrnk1e/bkcYHruinx3yok5a9TySbnZBZX
         Yd/jwBCtmlCF/5R6mN+pWmG7k9kzdb+l9uqG4cQqnB0JfrcOT9NIELH9Z9T3cLsFN++Y
         BpQTxKyOrtJSkl7MLcO71BwXxW1L7JNQ41PvkPa+jwZlwmuGkBGO7cYp5xSshfM7h7eZ
         xG7A==
X-Gm-Message-State: AOAM532hweC8g5jxQZCR/KEqjBRozn7qwvKUYRPyoy2Eir5HBK+mzc8s
        0+9X5yjbRy2VY4bRS9tpRN5SqFSn0HG6EG51Mmg=
X-Google-Smtp-Source: ABdhPJy2mTWfhMjUWI4Odi5dy4b8HirYVm5wPy66IKBkh+oBZIvkRXf0PHSRn/te3BKJx1N9xSyj9hg09AqwZfY7v/Q=
X-Received: by 2002:a1f:5e14:: with SMTP id s20mr969361vkb.7.1631519702896;
 Mon, 13 Sep 2021 00:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <202109040635.GB2sRCvY-lkp@intel.com> <6f0aad67-7c3e-95c5-e4b4-d563e180c6ee@infradead.org>
In-Reply-To: <6f0aad67-7c3e-95c5-e4b4-d563e180c6ee@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Sep 2021 09:54:51 +0200
Message-ID: <CAMuHMdWaoXOxC=wqUfC-9UTN+0QedGLqvZCr3rJjYmM2K9SZHQ@mail.gmail.com>
Subject: Re: sound/isa/es1688/es1688_lib.c:384:79: error: 'DMA_AUTOINIT' undeclared
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sat, Sep 11, 2021 at 4:32 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/3/21 3:56 PM, kernel test robot wrote:
> > First bad commit (maybe != root cause):
>
> Any ideas about these build errors?
>
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   7cca308cfdc0725363ac5943dca9dcd49cc1d2d5
> > commit: db87db65c1059f3be04506d122f8ec9b2fa3b05e m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch
> > date:   12 days ago
> > config: m68k-buildonly-randconfig-r001-20210904 (attached as .config)
> > compiler: m68k-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db87db65c1059f3be04506d122f8ec9b2fa3b05e
> >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >          git fetch --no-tags linus master
> >          git checkout db87db65c1059f3be04506d122f8ec9b2fa3b05e
> >          # save the attached .config to linux build tree
> >          mkdir build_dir
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash sound/isa/es1688/ sound/isa/sb/ sound/isa/wss/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >     sound/isa/es1688/es1688_lib.c: In function 'snd_es1688_playback_prepare':
> >>> sound/isa/es1688/es1688_lib.c:384:79: error: 'DMA_AUTOINIT' undeclared (first use in this function)
> >       384 |         snd_dma_program(chip->dma8, runtime->dma_addr, size, DMA_MODE_WRITE | DMA_AUTOINIT);
> >           |                                                                               ^~~~~~~~~~~~
> >     sound/isa/es1688/es1688_lib.c:384:79: note: each undeclared identifier is reported only once for each function it appears in
> >     sound/isa/es1688/es1688_lib.c: In function 'snd_es1688_capture_prepare':
> >     sound/isa/es1688/es1688_lib.c:441:78: error: 'DMA_AUTOINIT' undeclared (first use in this function)
> >       441 |         snd_dma_program(chip->dma8, runtime->dma_addr, size, DMA_MODE_READ | DMA_AUTOINIT);
> >           |                                                                              ^~~~~~~~~~~~
> > --
> >     sound/isa/sb/sb16_main.c: In function 'snd_sb16_playback_prepare':
> >>> sound/isa/sb/sb16_main.c:253:72: error: 'DMA_AUTOINIT' undeclared (first use in this function)
> >       253 |         snd_dma_program(dma, runtime->dma_addr, size, DMA_MODE_WRITE | DMA_AUTOINIT);
> >           |                                                                        ^~~~~~~~~~~~
> >     sound/isa/sb/sb16_main.c:253:72: note: each undeclared identifier is reported only once for each function it appears in
> >     sound/isa/sb/sb16_main.c: In function 'snd_sb16_capture_prepare':
> >     sound/isa/sb/sb16_main.c:322:71: error: 'DMA_AUTOINIT' undeclared (first use in this function)
> >       322 |         snd_dma_program(dma, runtime->dma_addr, size, DMA_MODE_READ | DMA_AUTOINIT);
> >           |                                                                       ^~~~~~~~~~~~
> > --
> >     sound/isa/sb/sb8_main.c: In function 'snd_sb8_playback_prepare':
> >>> sound/isa/sb/sb8_main.c:188:48: error: 'DMA_AUTOINIT' undeclared (first use in this function)
> >       188 |                         size, DMA_MODE_WRITE | DMA_AUTOINIT);
> >           |                                                ^~~~~~~~~~~~
> >     sound/isa/sb/sb8_main.c:188:48: note: each undeclared identifier is reported only once for each function it appears in
> >     sound/isa/sb/sb8_main.c: In function 'snd_sb8_capture_prepare':
> >     sound/isa/sb/sb8_main.c:313:47: error: 'DMA_AUTOINIT' undeclared (first use in this function)
> >       313 |                         size, DMA_MODE_READ | DMA_AUTOINIT);
> >           |                                               ^~~~~~~~~~~~
> > --
> >     sound/isa/wss/wss_lib.c: In function 'snd_wss_playback_prepare':
> >>> sound/isa/wss/wss_lib.c:1004:79: error: 'DMA_AUTOINIT' undeclared (first use in this function)
> >      1004 |         snd_dma_program(chip->dma1, runtime->dma_addr, size, DMA_MODE_WRITE | DMA_AUTOINIT);
> >           |                                                                               ^~~~~~~~~~~~
> >     sound/isa/wss/wss_lib.c:1004:79: note: each undeclared identifier is reported only once for each function it appears in
> >     sound/isa/wss/wss_lib.c: In function 'snd_wss_capture_prepare':
> >     sound/isa/wss/wss_lib.c:1039:78: error: 'DMA_AUTOINIT' undeclared (first use in this function)
> >      1039 |         snd_dma_program(chip->dma2, runtime->dma_addr, size, DMA_MODE_READ | DMA_AUTOINIT);
> >           |                                                                              ^~~~~~~~~~~~
>
> Only a few arches define DMA_AUTOINIT:
>
> $ grep -w DMA_AUTOINIT arch/*/include/asm/dma*.h
> arch/alpha/include/asm/dma.h:#define DMA_AUTOINIT       0x10
> arch/arm/include/asm/dma.h:#define DMA_AUTOINIT  0x10
> arch/mips/include/asm/dma.h:#define DMA_AUTOINIT        0x10
> arch/parisc/include/asm/dma.h:#define DMA_AUTOINIT      0x10
> arch/powerpc/include/asm/dma.h:#define DMA_AUTOINIT             0x10
> arch/sh/include/asm/dma.h:#define DMA_AUTOINIT          0x10
> arch/x86/include/asm/dma.h:#define DMA_AUTOINIT         0x10

So only m68k and sparc lack them?
Of course their dma_set_mode() implementations just ignore that
mode (and many more, for the rudimentary sparc version).

> CONFIG_ISA_DMA_API=y
> but CONFIG_ISA is not set.
> (Yes, this is ColdFire.)
>
> menuconfig SND_ISA
>         bool "ISA sound devices"
>         depends on ISA || COMPILE_TEST
>         depends on ISA_DMA_API
>         default y
>
> I suppose that we could drop the "|| COMPILE_TEST" part.

Or "... || (COMPILE_TEST && !M68K)"?

Sparc doesn't define ISA_DMA_API, so it doesn't suffer.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
