Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725B53F4732
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhHWJP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:15:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:30340 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhHWJPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:15:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="216787692"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="216787692"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:14:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="525863323"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.47]) ([10.255.29.47])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:14:37 -0700
Subject: Re: [kbuild-all] Re:
 arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no previous
 prototype for function 'fdt_check_mem_start'
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
References: <202108141331.fMjjWaW2-lkp@intel.com>
 <CAMuHMdXUpk_dLhvcdgs1H6yLPrwXFJz_86dfXpm8PYxNq+DXrQ@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <3b5f0086-5589-bb2b-29a7-312cd4a4f559@intel.com>
Date:   Mon, 23 Aug 2021 17:14:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXUpk_dLhvcdgs1H6yLPrwXFJz_86dfXpm8PYxNq+DXrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2021 4:45 PM, Geert Uytterhoeven wrote:
> Dear Robot,
> 
> On Sat, Aug 14, 2021 at 7:43 AM kernel test robot <lkp@intel.com> wrote:
>> FYI, the error/warning still remains.
> 
> Yes, and that's fine, as this function is never called from C code,
> only from assembler.


Hi Geert,

Thanks for the feedback, we'll ignore this warning.

Best Regards,
Rong Chen

> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   dfa377c35d70c31139b1274ec49f87d380996c42
>> commit: 0673cb38951215060d7993b43ad3c45cd413c2c3 ARM: 9045/1: uncompress: Validate start of physical memory against passed DTB
>> date:   6 months ago
>> config: arm-randconfig-r003-20210814 (attached as .config)
>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 62df4df41c939205b2dc0a2a3bfb75b8c1ed74fa)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0673cb38951215060d7993b43ad3c45cd413c2c3
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 0673cb38951215060d7993b43ad3c45cd413c2c3
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no previous prototype for function 'fdt_check_mem_start' [-Wmissing-prototypes]
>>     uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>>              ^
>>     arch/arm/boot/compressed/fdt_check_mem_start.c:62:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>>     uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>>     ^
>>     static
>>     1 warning generated.
>>
>>
>> vim +/fdt_check_mem_start +62 arch/arm/boot/compressed/fdt_check_mem_start.c
>>
>>      46
>>      47  /*
>>      48   * Check the start of physical memory
>>      49   *
>>      50   * Traditionally, the start address of physical memory is obtained by masking
>>      51   * the program counter.  However, this does require that this address is a
>>      52   * multiple of 128 MiB, precluding booting Linux on platforms where this
>>      53   * requirement is not fulfilled.
>>      54   * Hence validate the calculated address against the memory information in the
>>      55   * DTB, and, if out-of-range, replace it by the real start address.
>>      56   * To preserve backwards compatibility (systems reserving a block of memory
>>      57   * at the start of physical memory, kdump, ...), the traditional method is
>>      58   * always used if it yields a valid address.
>>      59   *
>>      60   * Return value: start address of physical memory to use
>>      61   */
>>    > 62  uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> 
