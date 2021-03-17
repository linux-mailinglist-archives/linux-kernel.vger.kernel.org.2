Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7033E6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCQCLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:11:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13971 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhCQCLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:11:35 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F0YWN0WkXzrXbG;
        Wed, 17 Mar 2021 10:09:36 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 10:11:23 +0800
Subject: Re: [PATCH] mm: Move mem_init_print_info() into mm_init()
To:     kernel test robot <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Richard Henderson" <rth@twiddle.net>, Guo Ren <guoren@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jonas Bonn <jonas@southpole.se>
References: <20210316142637.92193-1-wangkefeng.wang@huawei.com>
 <202103170114.Lj9LzUvl-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <8642c3ec-dd71-d947-9512-2d5e545204d0@huawei.com>
Date:   Wed, 17 Mar 2021 10:11:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <202103170114.Lj9LzUvl-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please use v2, sorry for the wrong version.

On 2021/3/17 2:01, kernel test robot wrote:
> Hi Kefeng,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/x86/mm]
> [also build test ERROR on linus/master v5.12-rc3 next-20210316]
> [cannot apply to hnaz-linux-mm/master sparc/master sparc-next/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Kefeng-Wang/mm-Move-mem_init_print_info-into-mm_init/20210316-222501
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a500fc918f7b8dc3dff2e6c74f3e73e856c18248
> config: riscv-randconfig-r031-20210316 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 50c7504a93fdb90c26870db8c8ea7add895c7725)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install riscv cross compiling tool for clang build
>          # apt-get install binutils-riscv64-linux-gnu
>          # https://github.com/0day-ci/linux/commit/0b2c07917fb7f9f87f0e2ecac3a3985155778856
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Kefeng-Wang/mm-Move-mem_init_print_info-into-mm_init/20210316-222501
>          git checkout 0b2c07917fb7f9f87f0e2ecac3a3985155778856
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     mm/page_alloc.c:3600:15: warning: no previous prototype for function 'should_fail_alloc_page' [-Wmissing-prototypes]
>     noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
>                   ^
>     mm/page_alloc.c:3600:10: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
>              ^
>              static
>>> mm/page_alloc.c:7744:3: error: use of undeclared identifier 'str'
>                     str ? ", " : "", str ? str : "");
>                     ^
>     mm/page_alloc.c:7744:20: error: use of undeclared identifier 'str'
>                     str ? ", " : "", str ? str : "");
>                                      ^
>     mm/page_alloc.c:7744:26: error: use of undeclared identifier 'str'
>                     str ? ", " : "", str ? str : "");
>                                            ^
>     1 warning and 3 errors generated.
>
>
> vim +/str +7744 mm/page_alloc.c
>
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03  7729
> 756a025f000919 Joe Perches 2016-03-17  7730  	pr_info("Memory: %luK/%luK available (%luK kernel code, %luK rwdata, %luK rodata, %luK init, %luK bss, %luK reserved, %luK cma-reserved"
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03  7731  #ifdef	CONFIG_HIGHMEM
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03  7732  		", %luK highmem"
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03  7733  #endif
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03  7734  		"%s%s)\n",
> 756a025f000919 Joe Perches 2016-03-17  7735  		nr_free_pages() << (PAGE_SHIFT - 10),
> 756a025f000919 Joe Perches 2016-03-17  7736  		physpages << (PAGE_SHIFT - 10),
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03  7737  		codesize >> 10, datasize >> 10, rosize >> 10,
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03  7738  		(init_data_size + init_code_size) >> 10, bss_size >> 10,
> ca79b0c211af63 Arun KS     2018-12-28  7739  		(physpages - totalram_pages() - totalcma_pages) << (PAGE_SHIFT - 10),
> e48322abb061d7 Pintu Kumar 2014-12-18  7740  		totalcma_pages << (PAGE_SHIFT - 10),
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03  7741  #ifdef	CONFIG_HIGHMEM
> ca79b0c211af63 Arun KS     2018-12-28  7742  		totalhigh_pages() << (PAGE_SHIFT - 10),
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03  7743  #endif
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03 @7744  		str ? ", " : "", str ? str : "");
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03  7745  }
> 7ee3d4e8cd5605 Jiang Liu   2013-07-03  7746
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
