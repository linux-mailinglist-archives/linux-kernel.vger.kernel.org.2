Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2C145FD77
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 09:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353014AbhK0IrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 03:47:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:41782 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239311AbhK0IpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 03:45:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="296549573"
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="296549573"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 00:41:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="742704493"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 27 Nov 2021 00:41:44 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqtHE-0009Gx-3k; Sat, 27 Nov 2021 08:41:44 +0000
Date:   Sat, 27 Nov 2021 16:41:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, tglx@linutronix.de,
        arnd@arndb.de, namhyung@kernel.org, peterz@infradead.org,
        alistair23@gmail.com, jolsa@redhat.com, dave@stgolabs.net,
        mingo@redhat.com, dvhart@infradead.org
Subject: Re: [PATCH v3 3/6] uapi: futex: Add a futex syscall
Message-ID: <202111271634.gZ4ePXuJ-lkp@intel.com>
References: <20211126060024.3290177-3-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126060024.3290177-3-alistair.francis@opensource.wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on linux/master soc/for-next linus/master v5.16-rc2 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Alistair-Francis/perf-bench-futex-Add-support-for-32-bit-systems-with-64-bit-time_t/20211126-140752
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 3297481d688a5cc2973ea58bd78e66b8639748b1
config: x86_64-randconfig-a002-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271634.gZ4ePXuJ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e6bfd30ff20551d613ea63d17bc9667179a593de
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Alistair-Francis/perf-bench-futex-Add-support-for-32-bit-systems-with-64-bit-time_t/20211126-140752
        git checkout e6bfd30ff20551d613ea63d17bc9667179a593de
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/futex_syscall.h:30:16: warning: declaration of 'struct timespec' will not be visible outside of this function [-Wvisibility]
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
>> ./usr/include/linux/futex_syscall.h:42:12: error: invalid application of 'sizeof' to an incomplete type 'struct timespec'
           if (sizeof(*timeout) == sizeof(struct __kernel_old_timespec))
                     ^~~~~~~~~~
   ./usr/include/linux/futex_syscall.h:30:16: note: forward declaration of 'struct timespec'
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
>> ./usr/include/linux/futex_syscall.h:43:10: error: implicit declaration of function 'syscall' [-Werror,-Wimplicit-function-declaration]
                   return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
                          ^
>> ./usr/include/linux/futex_syscall.h:45:24: error: incomplete definition of type 'struct timespec'
           if (timeout && timeout->tv_sec == (long)timeout->tv_sec) {
                          ~~~~~~~^
   ./usr/include/linux/futex_syscall.h:30:16: note: forward declaration of 'struct timespec'
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
   ./usr/include/linux/futex_syscall.h:45:49: error: incomplete definition of type 'struct timespec'
           if (timeout && timeout->tv_sec == (long)timeout->tv_sec) {
                                                   ~~~~~~~^
   ./usr/include/linux/futex_syscall.h:30:16: note: forward declaration of 'struct timespec'
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
   ./usr/include/linux/futex_syscall.h:48:44: error: incomplete definition of type 'struct timespec'
                   ts_old.tv_sec = (__kernel_long_t) timeout->tv_sec;
                                                     ~~~~~~~^
   ./usr/include/linux/futex_syscall.h:30:16: note: forward declaration of 'struct timespec'
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
   ./usr/include/linux/futex_syscall.h:49:45: error: incomplete definition of type 'struct timespec'
                   ts_old.tv_nsec = (__kernel_long_t) timeout->tv_nsec;
                                                      ~~~~~~~^
   ./usr/include/linux/futex_syscall.h:30:16: note: forward declaration of 'struct timespec'
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
   ./usr/include/linux/futex_syscall.h:53:46: error: use of undeclared identifier 'NULL'
                   return syscall(__NR_futex, uaddr, op, val, NULL, uaddr2, val3);
                                                              ^
   ./usr/include/linux/futex_syscall.h:82:9: error: implicit declaration of function 'syscall' [-Werror,-Wimplicit-function-declaration]
           return syscall(__NR_futex, uaddr, op, val, nr_requeue, uaddr2, val3);
                  ^
   1 warning and 8 errors generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
