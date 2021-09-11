Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47364074A3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 04:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhIKCeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 22:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbhIKCeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 22:34:03 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E50C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 19:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=LvgjFnvaHCW6e+/2qo8AvrJ+Zd1IYJxI9EKUaDqiSdc=; b=ozGmUHjLIxus9U0vb1Ts9eKABU
        Db9ePkBaArPio2pTyGisIvAJCy/PTwX+2U7o5MGHbchKfkz1KLVsJHyKgOHyJjNDAr1FopF+9f39h
        +k0lolh2MPeFQR3uTS5Kae6WJIffEtEJBdvN5OwvMzlilfN4i4UJtJ6bqw1+z+Bj0DZhQkolYW239
        b4oK2K0VAQito3BeNSTM2L1yJ4/cXpwlhvQ7LC/n8UfBYlUXqyV8GPXDLT6R/857eaSdvvt9xVruW
        wGjXyojxGCWLKuY2jPL+DgpE1PwJszR2PG9jrqYU7/0csNeWTMXZbh3/BlwgSxtZkZojqI8BPuN/Y
        ARhV8n7g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOsoy-00E9Ux-L6; Sat, 11 Sep 2021 02:32:48 +0000
Subject: Re: sound/isa/es1688/es1688_lib.c:384:79: error: 'DMA_AUTOINIT'
 undeclared
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <202109040635.GB2sRCvY-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6f0aad67-7c3e-95c5-e4b4-d563e180c6ee@infradead.org>
Date:   Fri, 10 Sep 2021 19:32:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202109040635.GB2sRCvY-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 3:56 PM, kernel test robot wrote:
> Hi Arnd,
> 
> First bad commit (maybe != root cause):

Hi Geert, Greg, Arnd,

Any ideas about these build errors?

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7cca308cfdc0725363ac5943dca9dcd49cc1d2d5
> commit: db87db65c1059f3be04506d122f8ec9b2fa3b05e m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch
> date:   12 days ago
> config: m68k-buildonly-randconfig-r001-20210904 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db87db65c1059f3be04506d122f8ec9b2fa3b05e
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout db87db65c1059f3be04506d122f8ec9b2fa3b05e
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash sound/isa/es1688/ sound/isa/sb/ sound/isa/wss/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     sound/isa/es1688/es1688_lib.c: In function 'snd_es1688_playback_prepare':
>>> sound/isa/es1688/es1688_lib.c:384:79: error: 'DMA_AUTOINIT' undeclared (first use in this function)
>       384 |         snd_dma_program(chip->dma8, runtime->dma_addr, size, DMA_MODE_WRITE | DMA_AUTOINIT);
>           |                                                                               ^~~~~~~~~~~~
>     sound/isa/es1688/es1688_lib.c:384:79: note: each undeclared identifier is reported only once for each function it appears in
>     sound/isa/es1688/es1688_lib.c: In function 'snd_es1688_capture_prepare':
>     sound/isa/es1688/es1688_lib.c:441:78: error: 'DMA_AUTOINIT' undeclared (first use in this function)
>       441 |         snd_dma_program(chip->dma8, runtime->dma_addr, size, DMA_MODE_READ | DMA_AUTOINIT);
>           |                                                                              ^~~~~~~~~~~~
> --
>     sound/isa/sb/sb16_main.c: In function 'snd_sb16_playback_prepare':
>>> sound/isa/sb/sb16_main.c:253:72: error: 'DMA_AUTOINIT' undeclared (first use in this function)
>       253 |         snd_dma_program(dma, runtime->dma_addr, size, DMA_MODE_WRITE | DMA_AUTOINIT);
>           |                                                                        ^~~~~~~~~~~~
>     sound/isa/sb/sb16_main.c:253:72: note: each undeclared identifier is reported only once for each function it appears in
>     sound/isa/sb/sb16_main.c: In function 'snd_sb16_capture_prepare':
>     sound/isa/sb/sb16_main.c:322:71: error: 'DMA_AUTOINIT' undeclared (first use in this function)
>       322 |         snd_dma_program(dma, runtime->dma_addr, size, DMA_MODE_READ | DMA_AUTOINIT);
>           |                                                                       ^~~~~~~~~~~~
> --
>     sound/isa/sb/sb8_main.c: In function 'snd_sb8_playback_prepare':
>>> sound/isa/sb/sb8_main.c:188:48: error: 'DMA_AUTOINIT' undeclared (first use in this function)
>       188 |                         size, DMA_MODE_WRITE | DMA_AUTOINIT);
>           |                                                ^~~~~~~~~~~~
>     sound/isa/sb/sb8_main.c:188:48: note: each undeclared identifier is reported only once for each function it appears in
>     sound/isa/sb/sb8_main.c: In function 'snd_sb8_capture_prepare':
>     sound/isa/sb/sb8_main.c:313:47: error: 'DMA_AUTOINIT' undeclared (first use in this function)
>       313 |                         size, DMA_MODE_READ | DMA_AUTOINIT);
>           |                                               ^~~~~~~~~~~~
> --
>     sound/isa/wss/wss_lib.c: In function 'snd_wss_playback_prepare':
>>> sound/isa/wss/wss_lib.c:1004:79: error: 'DMA_AUTOINIT' undeclared (first use in this function)
>      1004 |         snd_dma_program(chip->dma1, runtime->dma_addr, size, DMA_MODE_WRITE | DMA_AUTOINIT);
>           |                                                                               ^~~~~~~~~~~~
>     sound/isa/wss/wss_lib.c:1004:79: note: each undeclared identifier is reported only once for each function it appears in
>     sound/isa/wss/wss_lib.c: In function 'snd_wss_capture_prepare':
>     sound/isa/wss/wss_lib.c:1039:78: error: 'DMA_AUTOINIT' undeclared (first use in this function)
>      1039 |         snd_dma_program(chip->dma2, runtime->dma_addr, size, DMA_MODE_READ | DMA_AUTOINIT);
>           |                                                                              ^~~~~~~~~~~~

Only a few arches define DMA_AUTOINIT:

$ grep -w DMA_AUTOINIT arch/*/include/asm/dma*.h
arch/alpha/include/asm/dma.h:#define DMA_AUTOINIT	0x10
arch/arm/include/asm/dma.h:#define DMA_AUTOINIT	 0x10
arch/mips/include/asm/dma.h:#define DMA_AUTOINIT	0x10
arch/parisc/include/asm/dma.h:#define DMA_AUTOINIT	0x10
arch/powerpc/include/asm/dma.h:#define DMA_AUTOINIT		0x10
arch/sh/include/asm/dma.h:#define DMA_AUTOINIT		0x10
arch/x86/include/asm/dma.h:#define DMA_AUTOINIT		0x10


CONFIG_ISA_DMA_API=y
but CONFIG_ISA is not set.
(Yes, this is ColdFire.)

menuconfig SND_ISA
	bool "ISA sound devices"
	depends on ISA || COMPILE_TEST
	depends on ISA_DMA_API
	default y

I suppose that we could drop the "|| COMPILE_TEST" part.


thanks.
-- 
~Randy

