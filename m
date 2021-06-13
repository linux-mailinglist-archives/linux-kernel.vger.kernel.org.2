Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3C3A5A61
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhFMUiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:38:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:44221 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231899AbhFMUiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:38:21 -0400
IronPort-SDR: ig4wMhW+rUAa6EcX1qoTLu7Pzne3GNEe5kNYzrHV/xConn23UmuTZuyI94XeCd5qMLm+/4gwle
 /8JhHNZNB7Ag==
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="269587751"
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="269587751"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2021 13:36:17 -0700
IronPort-SDR: Yo1vDNkf/ZkuQ6sp4Iv+l+4iPy0hqZ5T+N+sA/Kpi+PObfdAdjT2saTVCNJ89m9SnPX/dECWPx
 dVBZh6QhrGNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="483884148"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2021 13:36:16 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lsWq9-0001Uv-4r; Sun, 13 Jun 2021 20:36:17 +0000
Date:   Mon, 14 Jun 2021 04:35:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:tmp.tmp2 12/364] include/asm-generic/preempt.h:69:36: error:
 implicit declaration of function 'tif_need_resched'
Message-ID: <202106140453.AbojGdtG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.tmp2
head:   adcceb5eb7aee38e4a9c15bdf599655f0e1b1324
commit: 40962503e2b9bddcef82fba70374b464ee9867b1 [12/364] sched/headers: Move thread_info APIs to <linux/sched/thread_info_api.h>
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=40962503e2b9bddcef82fba70374b464ee9867b1
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip tmp.tmp2
        git checkout 40962503e2b9bddcef82fba70374b464ee9867b1
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./arch/um/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:16,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   include/asm-generic/preempt.h: In function '__preempt_count_dec_and_test':
>> include/asm-generic/preempt.h:69:36: error: implicit declaration of function 'tif_need_resched' [-Werror=implicit-function-declaration]
      69 |  return !--*preempt_count_ptr() && tif_need_resched();
         |                                    ^~~~~~~~~~~~~~~~
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h: At top level:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
       9 | void foo(void)
         |      ^~~
   cc1: some warnings being treated as errors
--
   arch/x86/um/user-offsets.c:18:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      18 | void foo(void)
         |      ^~~
   In file included from ./arch/um/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:16,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   include/asm-generic/preempt.h: In function '__preempt_count_dec_and_test':
>> include/asm-generic/preempt.h:69:36: error: implicit declaration of function 'tif_need_resched' [-Werror=implicit-function-declaration]
      69 |  return !--*preempt_count_ptr() && tif_need_resched();
         |                                    ^~~~~~~~~~~~~~~~
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h: At top level:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
       9 | void foo(void)
         |      ^~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/um/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1232: prepare0] Error 2
   make[1]: Target 'modules_prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'modules_prepare' not remade because of errors.
--
   arch/x86/um/user-offsets.c:18:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      18 | void foo(void)
         |      ^~~
   In file included from ./arch/um/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:16,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   include/asm-generic/preempt.h: In function '__preempt_count_dec_and_test':
>> include/asm-generic/preempt.h:69:36: error: implicit declaration of function 'tif_need_resched' [-Werror=implicit-function-declaration]
      69 |  return !--*preempt_count_ptr() && tif_need_resched();
         |                                    ^~~~~~~~~~~~~~~~
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h: At top level:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
       9 | void foo(void)
         |      ^~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/um/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1232: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/tif_need_resched +69 include/asm-generic/preempt.h

bdb43806589096 Peter Zijlstra 2013-09-10  61  
bdb43806589096 Peter Zijlstra 2013-09-10  62  static __always_inline bool __preempt_count_dec_and_test(void)
bdb43806589096 Peter Zijlstra 2013-09-10  63  {
ba1f14fbe70965 Peter Zijlstra 2013-11-28  64  	/*
ba1f14fbe70965 Peter Zijlstra 2013-11-28  65  	 * Because of load-store architectures cannot do per-cpu atomic
ba1f14fbe70965 Peter Zijlstra 2013-11-28  66  	 * operations; we cannot use PREEMPT_NEED_RESCHED because it might get
ba1f14fbe70965 Peter Zijlstra 2013-11-28  67  	 * lost.
ba1f14fbe70965 Peter Zijlstra 2013-11-28  68  	 */
ba1f14fbe70965 Peter Zijlstra 2013-11-28 @69  	return !--*preempt_count_ptr() && tif_need_resched();
bdb43806589096 Peter Zijlstra 2013-09-10  70  }
bdb43806589096 Peter Zijlstra 2013-09-10  71  

:::::: The code at line 69 was first introduced by commit
:::::: ba1f14fbe70965ae0fb1655a5275a62723f65b77 sched: Remove PREEMPT_NEED_RESCHED from generic code

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vkogqOf2sHV7VnPd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
sC+GAAA=

--vkogqOf2sHV7VnPd--
