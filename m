Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA5A35D4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbhDMBhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:37:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:24195 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238964AbhDMBhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:37:42 -0400
IronPort-SDR: kVQYRXTPl0CZumWq7PLkMYp9lis5YJdrYZg9riG1ojdfMJNL44XA2x2Tg6UGByojqvri9GSHXV
 HDRAix6qTCww==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="174413742"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="174413742"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 18:37:22 -0700
IronPort-SDR: 2PuPirryjBwR0mIFvmOX/5lOEAlpTYnH9YRoUUaM+wDmQ7tokfcDTXFP2FxZLDWETLVmjwxBUl
 wvibQumxnk4g==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="460398098"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 18:37:19 -0700
Subject: Re: [kbuild-all] Re: arch/csky/mm/tcm.c:9:2: error: #error "You
 should define ITCM_RAM_BASE"
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Julian Braha <julianbraha@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Guo Ren <guoren@kernel.org>
References: <202104111227.ArabakLc-lkp@intel.com>
 <3c581465-2b66-934c-28a2-a5328de4fa35@infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <1f764916-77ea-9bb1-81d0-2f90ed621ff6@intel.com>
Date:   Tue, 13 Apr 2021 09:36:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3c581465-2b66-934c-28a2-a5328de4fa35@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/21 1:42 PM, Randy Dunlap wrote:
> On 4/10/21 9:43 PM, kernel test robot wrote:
>> Hi Julian,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   52e44129fba5cfc4e351fdb5e45849afc74d9a53
>> commit: 7d37cb2c912dc5c25ffac784a4f9b98c06c6bd08 lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
>> date:   31 hours ago
>> config: csky-randconfig-c003-20210411 (attached as .config)
>> compiler: csky-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d37cb2c912dc5c25ffac784a4f9b98c06c6bd08
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 7d37cb2c912dc5c25ffac784a4f9b98c06c6bd08
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=csky
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> arch/csky/mm/tcm.c:9:2: error: #error "You should define ITCM_RAM_BASE"
>>         9 | #error "You should define ITCM_RAM_BASE"
>>           |  ^~~~~
>>     arch/csky/mm/tcm.c:109:7: warning: no previous prototype for 'tcm_alloc' [-Wmissing-prototypes]
>>       109 | void *tcm_alloc(size_t len)
>>           |       ^~~~~~~~~
>>     arch/csky/mm/tcm.c:124:6: warning: no previous prototype for 'tcm_free' [-Wmissing-prototypes]
>>       124 | void tcm_free(void *addr, size_t len)
>>           |      ^~~~~~~~
>>
>> Kconfig warnings: (for reference only)
>>     WARNING: unmet direct dependencies detected for LOCKDEP
>>     Depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && (FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>>     Selected by
>>     - LOCK_STAT && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>>     - DEBUG_LOCK_ALLOC && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>>
>>
>> vim +9 arch/csky/mm/tcm.c
>>
>> f525bb2c9e7cf1 Guo Ren 2019-11-27   7
>> f525bb2c9e7cf1 Guo Ren 2019-11-27   8  #if (CONFIG_ITCM_RAM_BASE == 0xffffffff)
>> f525bb2c9e7cf1 Guo Ren 2019-11-27  @9  #error "You should define ITCM_RAM_BASE"
>> f525bb2c9e7cf1 Guo Ren 2019-11-27  10  #endif
>> f525bb2c9e7cf1 Guo Ren 2019-11-27  11
>>
>> :::::: The code at line 9 was first introduced by commit
>> :::::: f525bb2c9e7cf1e3c43ab57704c9e1c836d30b34 csky: Tightly-Coupled Memory or Sram support
>>
>> :::::: TO: Guo Ren <guoren@linux.alibaba.com>
>> :::::: CC: Guo Ren <guoren@linux.alibaba.com>
>
> Hi ktr/lkp,
>
> Do you have the ability to modify a (rand)config file before doing
> a build?
> To fix this kconfig problem, you can use:
>
> ./scripts/config --set-val ITCM_RAM_BASE 0xe0000000
> or
> ./scripts/config --file csky-randconfig-c003-20210411 --set-val ITCM_RAM_BASE 0xe0000000
> if you want to modify some file other than ".config".
>
> (0xe000000 is an arbitrary value here -- just cannot be 0xffffffff.)
>
> Then run "make oldconfig" and "make all" or however you normally build a kernel.
>
> It looks like the Kconfig file's ITCM_RAM_BASE parameter is expected to be
> set/modified by the user. The default value of 0xffffffff is invalid.
>

Hi Randy,

Thanks for the advice, we'll modify the config files for arch csky.

Best Regards,
Rong Chen
