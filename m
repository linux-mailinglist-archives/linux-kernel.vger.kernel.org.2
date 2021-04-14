Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC5535F15E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhDNKQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:16:21 -0400
Received: from foss.arm.com ([217.140.110.172]:54358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232032AbhDNKQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:16:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E88611B3;
        Wed, 14 Apr 2021 03:15:58 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91D153F73B;
        Wed, 14 Apr 2021 03:15:57 -0700 (PDT)
Subject: Re: arch/arm64/kvm/perf.c:58:36: error: implicit declaration of
 function 'perf_num_counters'
To:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <202103262006.nHFq086E-lkp@intel.com>
 <20210413200057.ankb4e26ytgal7ev@archlinux-ax161>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <9bdf177a-8fe2-effc-be88-3b65fe175292@arm.com>
Date:   Wed, 14 Apr 2021 11:16:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210413200057.ankb4e26ytgal7ev@archlinux-ax161>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/13/21 9:00 PM, Nathan Chancellor wrote:
> On Fri, Mar 26, 2021 at 08:27:13PM +0800, kernel test robot wrote:
>> Hi Marc,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   db24726bfefa68c606947a86132591568a06bfb4
>> commit: 6b5b368fccd7109b052e45af8ba1464c8d140a49 KVM: arm64: Turn kvm_arm_support_pmu_v3() into a static key
>> date:   3 weeks ago
>> config: arm64-randconfig-r005-20210326 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project f490a5969bd52c8a48586f134ff8f02ccbb295b3)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install arm64 cross compiling tool for clang build
>>         # apt-get install binutils-aarch64-linux-gnu
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6b5b368fccd7109b052e45af8ba1464c8d140a49
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 6b5b368fccd7109b052e45af8ba1464c8d140a49
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> arch/arm64/kvm/perf.c:58:36: error: implicit declaration of function 'perf_num_counters' [-Werror,-Wimplicit-function-declaration]
>>            if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
>>                                              ^
>>    1 error generated.
>>
>>
>> vim +/perf_num_counters +58 arch/arm64/kvm/perf.c
>>
>>     50	
>>     51	int kvm_perf_init(void)
>>     52	{
>>     53		/*
>>     54		 * Check if HW_PERF_EVENTS are supported by checking the number of
>>     55		 * hardware performance counters. This could ensure the presence of
>>     56		 * a physical PMU and CONFIG_PERF_EVENT is selected.
>>     57		 */
>>   > 58		if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
>>     59			static_branch_enable(&kvm_arm_pmu_available);
>>     60	
>>     61		return perf_register_guest_info_callbacks(&kvm_guest_cbs);
>>     62	}
>>     63	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> I just ran into this again. It is not a clang specific issue, it
> reproduces quite easily with arm64 defconfig minus CONFIG_PERF_EVENTS
> and gcc 10.3.0:
>
> arch/arm64/kvm/perf.c: In function 'kvm_perf_init':
> arch/arm64/kvm/perf.c:58:36: error: implicit declaration of function
> 'perf_num_counters'; did you mean 'dec_mm_counter'?
> [-Werror=implicit-function-declaration]
>    58 |  if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
>       |                                    ^~~~~~~~~~~~~~~~~
>       |                                    dec_mm_counter
> cc1: some warnings being treated as errors

I was also able to reproduce it with gcc 10.2.0. I think the problem is that the
perf_num_counters() declaration is guarded by CONFIG_PERF_EVENTS (in
include/linux/perf_event.h), the implementation is in drivers/perf/arm_pmu.c,
which depends on CONFIG_ARM_PMU, but CONFIG_ARM_PMU=y doesn't select
CONFIG_PERF_EVENTS. So we end up in a situation where we have the implementation
of perf_num_counters(), but no prototype (CONFIG_ARM_PMU=y, CONFIG_PERF_EVENTS is
not set).

Thanks,

Alex

>
> I am not sure what the cleanest solution would be for providing a static
> inline version of perf_num_counters() would be, as only arm64 actually
> uses it (sh and s390 define it but it does not appear to be used) but it
> is only available through CONFIG_ARM_PMU instead of just
> CONFIG_PERF_EVENTS like the other two architectures mentioned above.
>
> Cheers,
> Nathan
