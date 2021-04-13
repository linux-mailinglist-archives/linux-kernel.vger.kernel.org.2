Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62FE35E761
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348136AbhDMUBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230244AbhDMUBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:01:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EB35613C1;
        Tue, 13 Apr 2021 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618344062;
        bh=2sT+w0Sv9pUexNeNXhozbpIFH4jcdLHmPJgOw3d7Ayk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cd5h+DPQGJK31WYThPVd3s/trs9jGhTe3zvPnaXuvxwZ1sTCrsJr+B4rqD5Q1tWhn
         fNPDtjaL5gcBvPDspQrE9lbp8aluwhwDqk7db73WXxxu0CGta+Tl90YIFz1fU9TdcQ
         Xxecg2P+/2VG08VTijJtbLZs+QvUtzNWh2QoJ+hynzZvUzueW+Bh8WRjkl2zCZBzFd
         R2wtYdBgLYLZrO6bw9VV/xTuLpNiuZiXmXvSBzv113R+VTM7tjVHxcNWgQC5UwtnZS
         jCc6CKexKF3VIuWWyOKfCwALxiysBbIsn5isEjPvYKNvtg2SNfTVLQCg6JM/siyCC+
         OXU7TRMztG9oA==
Date:   Tue, 13 Apr 2021 13:00:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: arch/arm64/kvm/perf.c:58:36: error: implicit declaration of
 function 'perf_num_counters'
Message-ID: <20210413200057.ankb4e26ytgal7ev@archlinux-ax161>
References: <202103262006.nHFq086E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103262006.nHFq086E-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 08:27:13PM +0800, kernel test robot wrote:
> Hi Marc,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   db24726bfefa68c606947a86132591568a06bfb4
> commit: 6b5b368fccd7109b052e45af8ba1464c8d140a49 KVM: arm64: Turn kvm_arm_support_pmu_v3() into a static key
> date:   3 weeks ago
> config: arm64-randconfig-r005-20210326 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project f490a5969bd52c8a48586f134ff8f02ccbb295b3)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6b5b368fccd7109b052e45af8ba1464c8d140a49
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6b5b368fccd7109b052e45af8ba1464c8d140a49
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/arm64/kvm/perf.c:58:36: error: implicit declaration of function 'perf_num_counters' [-Werror,-Wimplicit-function-declaration]
>            if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
>                                              ^
>    1 error generated.
> 
> 
> vim +/perf_num_counters +58 arch/arm64/kvm/perf.c
> 
>     50	
>     51	int kvm_perf_init(void)
>     52	{
>     53		/*
>     54		 * Check if HW_PERF_EVENTS are supported by checking the number of
>     55		 * hardware performance counters. This could ensure the presence of
>     56		 * a physical PMU and CONFIG_PERF_EVENT is selected.
>     57		 */
>   > 58		if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
>     59			static_branch_enable(&kvm_arm_pmu_available);
>     60	
>     61		return perf_register_guest_info_callbacks(&kvm_guest_cbs);
>     62	}
>     63	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

I just ran into this again. It is not a clang specific issue, it
reproduces quite easily with arm64 defconfig minus CONFIG_PERF_EVENTS
and gcc 10.3.0:

arch/arm64/kvm/perf.c: In function 'kvm_perf_init':
arch/arm64/kvm/perf.c:58:36: error: implicit declaration of function
'perf_num_counters'; did you mean 'dec_mm_counter'?
[-Werror=implicit-function-declaration]
   58 |  if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
      |                                    ^~~~~~~~~~~~~~~~~
      |                                    dec_mm_counter
cc1: some warnings being treated as errors

I am not sure what the cleanest solution would be for providing a static
inline version of perf_num_counters() would be, as only arm64 actually
uses it (sh and s390 define it but it does not appear to be used) but it
is only available through CONFIG_ARM_PMU instead of just
CONFIG_PERF_EVENTS like the other two architectures mentioned above.

Cheers,
Nathan
