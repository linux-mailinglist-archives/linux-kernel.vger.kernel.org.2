Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37BE34B732
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 13:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhC0MUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 08:20:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:26921 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhC0MUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 08:20:21 -0400
IronPort-SDR: uSmxYw9jjkj5Ij5ysERflZ1pRl9IJxQQCy2KUYsmoscdkUiDtzPN2bFWyxBbSGizpBU2B/jcV6
 Ts0bxUsLFD7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="171295926"
X-IronPort-AV: E=Sophos;i="5.81,283,1610438400"; 
   d="gz'50?scan'50,208,50";a="171295926"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 05:20:20 -0700
IronPort-SDR: 3P+JQAcpB8YucFQmPWAwc+dgDJ7EPg2ctljxVAVXkXAL8uWD3xj/sN08ia1ykghi2mdmniOL01
 LAZvmqgEhwlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,283,1610438400"; 
   d="gz'50?scan'50,208,50";a="414847298"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2021 05:20:18 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lQ7vN-0003Su-SJ; Sat, 27 Mar 2021 12:20:17 +0000
Date:   Sat, 27 Mar 2021 20:19:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: /usr/bin/ld: z3fold.c:undefined reference to `atomic64_inc_386'
Message-ID: <202103272020.MY435oTX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0f4498cef9f5cd18d7c6639a2a902ec1edc5be4e
commit: a435b9a14356587cf512ea6473368a579373c74c locking/refcount: Provide __refcount API to obtain the old value
date:   7 months ago
config: um-randconfig-s031-20210327 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-277-gc089cd2d-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a435b9a14356587cf512ea6473368a579373c74c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a435b9a14356587cf512ea6473368a579373c74c
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=um 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: kernel/fork.o: in function `mm_init':
   fork.c:(.text+0xd5c): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/sched/fair.o: in function `update_curr':
   fair.c:(.text+0xccf): undefined reference to `atomic64_add_386'
   /usr/bin/ld: mm/debug.o: in function `dump_mm':
   debug.c:(.text+0x45c): undefined reference to `atomic64_read_386'
   /usr/bin/ld: mm/z3fold.o: in function `z3fold_zpool_total_size':
   z3fold.c:(.text+0x77): undefined reference to `atomic64_read_386'
   /usr/bin/ld: mm/z3fold.o: in function `z3fold_page_putback':
   z3fold.c:(.text+0x76e): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: mm/z3fold.o: in function `compact_single_buddy':
   z3fold.c:(.text+0xd3c): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: mm/z3fold.o: in function `do_compact_page':
   z3fold.c:(.text+0x115f): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: mm/z3fold.o: in function `z3fold_reclaim_page.constprop.0':
   z3fold.c:(.text+0x1531): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: z3fold.c:(.text+0x1568): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: mm/z3fold.o: in function `z3fold_create_pool':
   z3fold.c:(.text+0x1760): undefined reference to `atomic64_set_386'
   /usr/bin/ld: mm/z3fold.o: in function `z3fold_alloc':
   z3fold.c:(.text+0x1c07): undefined reference to `atomic64_dec_386'
>> /usr/bin/ld: z3fold.c:(.text+0x1f1d): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: mm/z3fold.o: in function `z3fold_free':
   z3fold.c:(.text+0x212e): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: z3fold.c:(.text+0x2207): undefined reference to `atomic64_dec_386'
   /usr/bin/ld: fs/inode.o: in function `inode_init_always':
   inode.c:(.text+0x4f8): undefined reference to `atomic64_set_386'
   /usr/bin/ld: fs/inode.o: in function `generic_update_time':
   inode.c:(.text+0x2915): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inode.c:(.text+0x2960): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: fs/inode.o: in function `file_update_time':
   inode.c:(.text+0x359c): undefined reference to `atomic64_read_386'
   /usr/bin/ld: fs/namespace.o: in function `alloc_mnt_ns':
   namespace.c:(.text+0xcae): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: fs/io_uring.o: in function `io_unaccount_mem':
   io_uring.c:(.text+0x59c): undefined reference to `atomic64_sub_386'
   /usr/bin/ld: fs/io_uring.o: in function `io_account_mem':
   io_uring.c:(.text+0x3f2a): undefined reference to `atomic64_add_386'
   /usr/bin/ld: drivers/iio/adc/adi-axi-adc.o: in function `adi_axi_adc_probe':
   adi-axi-adc.c:(.text+0x288): undefined reference to `devm_platform_ioremap_resource'
   /usr/bin/ld: kernel/sched/cputime.o: in function `account_group_user_time':
   cputime.c:(.text+0x8f): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/sched/cputime.o: in function `account_system_index_time':
   cputime.c:(.text+0x2df): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/sched/rt.o: in function `update_curr_rt':
   rt.c:(.text+0xefd): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/sched/deadline.o: in function `update_curr_dl':
   deadline.c:(.text+0x1715): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `proc_sample_cputime_atomic':
   posix-cpu-timers.c:(.text+0x11): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x1d): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x2b): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/time/posix-cpu-timers.o: in function `__update_gt_cputime':
   posix-cpu-timers.c:(.text+0xdc): undefined reference to `atomic64_read_386'
   /usr/bin/ld: posix-cpu-timers.c:(.text+0x105): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_current_read':
   pids.c:(.text+0xd): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_max_show':
   pids.c:(.text+0x2c): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_max_write':
   pids.c:(.text+0x111): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_cancel.constprop.0':
   pids.c:(.text+0x13e): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_css_alloc':
   pids.c:(.text+0x243): undefined reference to `atomic64_set_386'
   /usr/bin/ld: pids.c:(.text+0x253): undefined reference to `atomic64_set_386'
   /usr/bin/ld: pids.c:(.text+0x260): undefined reference to `atomic64_set_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_events_show':
   pids.c:(.text+0x284): undefined reference to `atomic64_read_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_can_attach':
   pids.c:(.text+0x35e): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_cancel_attach':
   pids.c:(.text+0x3be): undefined reference to `atomic64_add_386'
   /usr/bin/ld: kernel/cgroup/pids.o: in function `pids_can_fork':
   pids.c:(.text+0x486): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: pids.c:(.text+0x496): undefined reference to `atomic64_read_386'
   /usr/bin/ld: pids.c:(.text+0x4e4): undefined reference to `atomic64_inc_return_386'
   /usr/bin/ld: kernel/trace/trace_clock.o: in function `trace_clock_counter':
   trace_clock.c:(.text+0x101): undefined reference to `atomic64_add_return_386'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM2'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/misc/altera-stapl/altera-lpt.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
   /usr/bin/ld: drivers/dma-buf/dma-fence.o: in function `dma_fence_context_alloc':
   dma-fence.c:(.text+0x315): undefined reference to `cmpxchg8b_emu'
   collect2: error: ld returned 1 exit status

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vtzGhvizbBRQ85DL
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
6uxox/1THrv9Fy4v11uOhwAA

--vtzGhvizbBRQ85DL--
