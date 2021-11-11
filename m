Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581FE44D1BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 06:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhKKFqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 00:46:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:43040 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231954AbhKKFqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 00:46:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="319056164"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="319056164"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 21:43:22 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="492414901"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.108]) ([10.255.28.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 21:43:20 -0800
Subject: Re: [kbuild-all] Re:
 arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no previous
 prototype for 'fdt_check_mem_start'
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
References: <202111100840.gaI6caTo-lkp@intel.com>
 <CAMuHMdUXYv8eSd6FY5JzjZ9bR1sfGT4jgwdj4qvD6heG9ue7Mw@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <b0050723-5ff4-0cea-0607-f7616037e4a3@intel.com>
Date:   Thu, 11 Nov 2021 13:43:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUXYv8eSd6FY5JzjZ9bR1sfGT4jgwdj4qvD6heG9ue7Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2021 5:36 PM, Geert Uytterhoeven wrote:
> Hi Kernel Test Robot,
> 
> On Wed, Nov 10, 2021 at 1:39 AM kernel test robot <lkp@intel.com> wrote:
>> FYI, the error/warning still remains.
> 
> Indeed, and currently there are no plans to fix that.
> Please add it to the ignorelist.

Hi Geert,

Thanks for the feedback, we'll ignore the warning.

Best Regards,
Rong Chen

> 
> Thanks!
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   cb690f5238d71f543f4ce874aa59237cf53a877c
>> commit: 0673cb38951215060d7993b43ad3c45cd413c2c3 ARM: 9045/1: uncompress: Validate start of physical memory against passed DTB
>> date:   9 months ago
>> config: arm-randconfig-r022-20210927 (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0673cb38951215060d7993b43ad3c45cd413c2c3
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 0673cb38951215060d7993b43ad3c45cd413c2c3
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> arch/arm/boot/compressed/fdt_check_mem_start.c:62:10: warning: no previous prototype for 'fdt_check_mem_start' [-Wmissing-prototypes]
>>        62 | uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>>           |          ^~~~~~~~~~~~~~~~~~~
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
