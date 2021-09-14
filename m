Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B7840A221
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 02:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbhINAk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 20:40:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:54545 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232693AbhINAk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:40:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221500807"
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="221500807"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 17:39:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="543555735"
Received: from huafangj-mobl1.ccr.corp.intel.com (HELO [10.255.30.154]) ([10.255.30.154])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 17:39:38 -0700
Subject: Re: [kbuild-all] Re:
 include/linux/atomic/atomic-arch-fallback.h:60:32: error: implicit
 declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'?
To:     Mark Rutland <mark.rutland@arm.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <202109120418.8mal64Sj-lkp@intel.com>
 <20210913085724.GA7415@C02TD0UTHF1T.local>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <be9ed2be-c338-cd59-7a5a-804ffa5d3064@intel.com>
Date:   Tue, 14 Sep 2021 08:39:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210913085724.GA7415@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2021 4:57 PM, Mark Rutland wrote:
> On Sun, Sep 12, 2021 at 04:24:21AM +0800, kernel test robot wrote:
>> Hi Mark,
>>
>> FYI, the error/warning still remains.
> 
> As pointed out previously [1,2], this is an existing bug (in that arc
> does not have an implementation of cmpxchg64(), but it's possible to
> select code which uses it in test configurations). My changes to the
> core atomic headers only change the way in which the error manifests,
> and have nothing to do with the underlying problem.
> 
> I thought we were going to stop reporting this [3]?

Hi Mark,

Thanks for the feedback, we only ignored the below one:

   include/linux/atomic-arch-fallback.h:60:32: error: implicit 
declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'? 
[-Werror=implicit-function-declaration]

we'll update the pattern to ignore all.

Best Regards,
Rong Chen

> 
> If we want to "fix" this kernel side, then we either need to:
> 
> * Implement cmpxchg64() for arc
> 
> * Add an ARCH_HAS_CMPXCHG64, and dependencies in kconfig where it is used
> 
> Thanks,
> Mark.
> 
> [1] https://lore.kernel.org/lkml/a38e3284-62ee-4894-0475-2668733c5903@infradead.org/
> [2] https://lore.kernel.org/lkml/20210712143151.GB94622@C02TD0UTHF1T.local/
> [3] https://lore.kernel.org/lkml/717d9f89-078b-1698-46fb-9b3393ecddc4@intel.com/
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   c605c39677b9842b0566013e0cf30bc13e90bdbc
>> commit: e3d18cee258b898017b298b5b93f8134dd62aee3 locking/atomic: centralize generated headers
>> date:   8 weeks ago
>> config: arc-allyesconfig (attached as .config)
>> compiler: arceb-elf-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e3d18cee258b898017b298b5b93f8134dd62aee3
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout e3d18cee258b898017b298b5b93f8134dd62aee3
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from include/linux/atomic.h:80,
>>                      from drivers/iommu/io-pgtable-arm.c:12:
>>     drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
>>>> include/linux/atomic/atomic-arch-fallback.h:60:32: error: implicit declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'? [-Werror=implicit-function-declaration]
>>        60 | #define arch_cmpxchg64_relaxed arch_cmpxchg64
>>           |                                ^~~~~~~~~~~~~~
>>     include/linux/atomic/atomic-instrumented.h:1261:9: note: in expansion of macro 'arch_cmpxchg64_relaxed'
>>      1261 |         arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
>>           |         ^~~~~~~~~~~~~~~~~~~~~~
>>     drivers/iommu/io-pgtable-arm.c:320:15: note: in expansion of macro 'cmpxchg64_relaxed'
>>       320 |         old = cmpxchg64_relaxed(ptep, curr, new);
>>           |               ^~~~~~~~~~~~~~~~~
>>     cc1: some warnings being treated as errors
>>
>>
>> vim +60 include/linux/atomic/atomic-arch-fallback.h
>>
>> 37f8173dd84936 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-01-24  56
>> 37f8173dd84936 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-01-24  57  #ifndef arch_cmpxchg64_relaxed
>> 37f8173dd84936 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-01-24  58  #define arch_cmpxchg64_acquire arch_cmpxchg64
>> 37f8173dd84936 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-01-24  59  #define arch_cmpxchg64_release arch_cmpxchg64
>> 29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29 @60  #define arch_cmpxchg64_relaxed arch_cmpxchg64
>> 37f8173dd84936 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-01-24  61  #else /* arch_cmpxchg64_relaxed */
>> 37f8173dd84936 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-01-24  62
>>
>> :::::: The code at line 60 was first introduced by commit
>> :::::: 29f006fdefe6f88abde973a0b0f20d2704e93fd4 asm-generic/atomic: Add try_cmpxchg() fallbacks
>>
>> :::::: TO: Peter Zijlstra <peterz@infradead.org>
>> :::::: CC: Ingo Molnar <mingo@kernel.org>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
