Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80941314E4F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBILhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:37:02 -0500
Received: from foss.arm.com ([217.140.110.172]:50078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhBILaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:30:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F23106F;
        Tue,  9 Feb 2021 03:29:22 -0800 (PST)
Received: from [10.37.8.18] (unknown [10.37.8.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 458CD3F73B;
        Tue,  9 Feb 2021 03:29:21 -0800 (PST)
Subject: Re: [PATCH v12 7/7] kasan: don't run tests in async mode
To:     kernel test robot <lkp@intel.com>,
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
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c623a7ee-1efa-ecd4-501c-cf31303b2c27@arm.com>
Date:   Tue, 9 Feb 2021 11:33:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202102091438.SIWr9xAZ-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/21 6:32 AM, kernel test robot wrote:
> Hi Vincenzo,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on next-20210125]
> [cannot apply to arm64/for-next/core xlnx/master arm/for-next soc/for-next kvmarm/next linus/master hnaz-linux-mm/master v5.11-rc6 v5.11-rc5 v5.11-rc4 v5.11-rc6]

The patches are based on linux-next/akpm and since they depend on some patches
present on that tree, can be applied only on linux-next/akpm and linux-next/master.

The dependency is reported in the cover letter.

Thanks,
Vincenzo

> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Vincenzo-Frascino/arm64-ARMv8-5-A-MTE-Add-async-mode-support/20210209-080907
> base:    59fa6a163ffabc1bf25c5e0e33899e268a96d3cc
> config: powerpc64-randconfig-r033-20210209 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/53907a0b15724b414ddd9201356f92e09571ef90
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Vincenzo-Frascino/arm64-ARMv8-5-A-MTE-Add-async-mode-support/20210209-080907
>         git checkout 53907a0b15724b414ddd9201356f92e09571ef90
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    powerpc-linux-ld: lib/test_kasan.o: in function `kasan_test_init':
>    test_kasan.c:(.text+0x849a): undefined reference to `kasan_flag_async'
>>> powerpc-linux-ld: test_kasan.c:(.text+0x84a2): undefined reference to `kasan_flag_async'
>    powerpc-linux-ld: test_kasan.c:(.text+0x84e2): undefined reference to `kasan_flag_async'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

-- 
Regards,
Vincenzo
