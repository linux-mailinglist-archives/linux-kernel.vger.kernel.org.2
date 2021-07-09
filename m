Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B9E3C1F17
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 07:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhGIFxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 01:53:06 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:44913 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhGIFxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 01:53:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UfBeBey_1625809818;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UfBeBey_1625809818)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 09 Jul 2021 13:50:19 +0800
Date:   Fri, 9 Jul 2021 13:50:16 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Gao Xiang <hsiangkao@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Terrell <terrelln@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [linux-stable-rc:linux-5.4.y 7045/7049] mipsel-linux-ld:
 decompress.c:undefined reference to `memmove'
Message-ID: <YOfjmCT6n61Yidvp@B-P7TQMD6M-0146.local>
References: <202107070120.6dOj1kB7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202107070120.6dOj1kB7-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 01:15:28AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> head:   3909e2374335335c9504467caabc906d3f7487e4
> commit: defcc2b5e54a4724fb5733f802edf5dd596018b6 [7045/7049] lib/lz4: explicitly support in-place decompression
> config: mips-randconfig-r036-20210706 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=defcc2b5e54a4724fb5733f802edf5dd596018b6
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc linux-5.4.y
>         git checkout defcc2b5e54a4724fb5733f802edf5dd596018b6
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Which is weird, does the preboot environment miss memmove() on mipsel?
Just a guess, I may look into that myself later...

Thanks,
Gao Xiang

> 
> All errors (new ones prefixed by >>):
> 
>    mipsel-linux-ld: arch/mips/boot/compressed/decompress.o: in function `LZ4_decompress_safe_withSmallPrefix':
>    decompress.c:(.text+0x220): undefined reference to `memmove'
>    mipsel-linux-ld: arch/mips/boot/compressed/decompress.o: in function `LZ4_decompress_fast_extDict':
>    decompress.c:(.text+0x694): undefined reference to `memmove'
> >> mipsel-linux-ld: decompress.c:(.text+0x774): undefined reference to `memmove'
>    mipsel-linux-ld: arch/mips/boot/compressed/decompress.o: in function `LZ4_decompress_safe':
>    decompress.c:(.text+0xb88): undefined reference to `memmove'
>    mipsel-linux-ld: arch/mips/boot/compressed/decompress.o: in function `LZ4_decompress_safe_partial':
>    decompress.c:(.text+0x1078): undefined reference to `memmove'
>    mipsel-linux-ld: arch/mips/boot/compressed/decompress.o:decompress.c:(.text+0x12f8): more undefined references to `memmove' follow
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


