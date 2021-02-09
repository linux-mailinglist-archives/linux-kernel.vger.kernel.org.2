Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9458A314E4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBILal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:30:41 -0500
Received: from foss.arm.com ([217.140.110.172]:50036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhBIL3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:29:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C6CEED1;
        Tue,  9 Feb 2021 03:28:57 -0800 (PST)
Received: from [10.37.8.18] (unknown [10.37.8.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B1B93F73B;
        Tue,  9 Feb 2021 03:28:55 -0800 (PST)
Subject: Re: [PATCH v12 3/7] kasan: Add report for async mode
To:     kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     kbuild-all@lists.01.org, Catalin Marinas <catalin.marinas@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20210208165617.9977-4-vincenzo.frascino@arm.com>
 <202102091512.8A2oHgsy-lkp@intel.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <58f30539-69a8-d695-8a7f-75be2bdd31d6@arm.com>
Date:   Tue, 9 Feb 2021 11:32:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202102091512.8A2oHgsy-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 7:39 AM, kernel test robot wrote:
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
> config: x86_64-randconfig-s021-20210209 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-215-g0fb77bb6-dirty
>         # https://github.com/0day-ci/linux/commit/93bd347e4877e3616f7db64f488ebb469718dd68
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Vincenzo-Frascino/arm64-ARMv8-5-A-MTE-Add-async-mode-support/20210209-080907
>         git checkout 93bd347e4877e3616f7db64f488ebb469718dd68
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ld: mm/kasan/report.o: in function `end_report':
>>> mm/kasan/report.c:90: undefined reference to `kasan_flag_async'
>>> ld: mm/kasan/report.c:90: undefined reference to `kasan_flag_async'
> 
> 
> vim +90 mm/kasan/report.c
> 
>     87	
>     88	static void end_report(unsigned long *flags, unsigned long addr)
>     89	{
>   > 90		if (!kasan_flag_async)
>     91			trace_error_report_end(ERROR_DETECTOR_KASAN, addr);
>     92		pr_err("==================================================================\n");
>     93		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>     94		spin_unlock_irqrestore(&report_lock, *flags);
>     95		if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags)) {
>     96			/*
>     97			 * This thread may hit another WARN() in the panic path.
>     98			 * Resetting this prevents additional WARN() from panicking the
>     99			 * system on this thread.  Other threads are blocked by the
>    100			 * panic_mutex in panic().
>    101			 */
>    102			panic_on_warn = 0;
>    103			panic("panic_on_warn set ...\n");
>    104		}
>    105	#ifdef CONFIG_KASAN_HW_TAGS
>    106		if (kasan_flag_panic)
>    107			panic("kasan.fault=panic set ...\n");
>    108	#endif
>    109		kasan_enable_current();
>    110	}
>    111	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Regards,
Vincenzo
