Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E285D315F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhBJGfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:35:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:25864 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231922AbhBJGfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:35:03 -0500
IronPort-SDR: G9xcHUUiXZmkWVbnKaHSwpahzAKJRV3GIs630esB0XJ1Rucbu0J2FYp27G3K45dWM8fwOly7Yz
 Gknhq/OPtdJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="201121987"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="201121987"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:34:20 -0800
IronPort-SDR: /JYwczd0UfP7YdI15qZaSu1wjyFUYuqVLRnuLF0pLBop2BsqZ5N9KOM3UAX77T4gkduVR9dAI+
 fF/iAW641Eiw==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="436564642"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:34:16 -0800
Subject: Re: [kbuild-all] Re: [PATCH v12 7/7] kasan: don't run tests in async
 mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <20210208165617.9977-8-vincenzo.frascino@arm.com>
 <202102091438.SIWr9xAZ-lkp@intel.com>
 <c623a7ee-1efa-ecd4-501c-cf31303b2c27@arm.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <aa3c1d8f-c206-0731-6eff-7fe29df35f85@intel.com>
Date:   Wed, 10 Feb 2021 14:33:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c623a7ee-1efa-ecd4-501c-cf31303b2c27@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/21 7:33 PM, Vincenzo Frascino wrote:
>
> On 2/9/21 6:32 AM, kernel test robot wrote:
>> Hi Vincenzo,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on next-20210125]
>> [cannot apply to arm64/for-next/core xlnx/master arm/for-next soc/for-next kvmarm/next linus/master hnaz-linux-mm/master v5.11-rc6 v5.11-rc5 v5.11-rc4 v5.11-rc6]
> The patches are based on linux-next/akpm and since they depend on some patches
> present on that tree, can be applied only on linux-next/akpm and linux-next/master.
>
> The dependency is reported in the cover letter.

Hi Vincenzo,

Thanks for the feedback, we'll take a look.

Best Regards,
Rong Chen

>
> Thanks,
> Vincenzo
>
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Vincenzo-Frascino/arm64-ARMv8-5-A-MTE-Add-async-mode-support/20210209-080907
>> base:    59fa6a163ffabc1bf25c5e0e33899e268a96d3cc
>> config: powerpc64-randconfig-r033-20210209 (attached as .config)
>> compiler: powerpc-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/0day-ci/linux/commit/53907a0b15724b414ddd9201356f92e09571ef90
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Vincenzo-Frascino/arm64-ARMv8-5-A-MTE-Add-async-mode-support/20210209-080907
>>          git checkout 53907a0b15724b414ddd9201356f92e09571ef90
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     powerpc-linux-ld: lib/test_kasan.o: in function `kasan_test_init':
>>     test_kasan.c:(.text+0x849a): undefined reference to `kasan_flag_async'
>>>> powerpc-linux-ld: test_kasan.c:(.text+0x84a2): undefined reference to `kasan_flag_async'
>>     powerpc-linux-ld: test_kasan.c:(.text+0x84e2): undefined reference to `kasan_flag_async'
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>

