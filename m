Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15303F7133
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbhHYIkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:40:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:2457 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238976AbhHYIkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:40:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="217201631"
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="gz'50?scan'50,208,50";a="217201631"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 01:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="gz'50?scan'50,208,50";a="685985126"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2021 01:39:02 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIoR3-0001ap-Ky; Wed, 25 Aug 2021 08:39:01 +0000
Date:   Wed, 25 Aug 2021 16:38:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saleem Abdulrasool <abdulras@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [palmer:for-next 18/18]
 arch/riscv/kernel/vdso/vgettimeofday.c:16:16: error: implicit declaration of
 function '__cvdso_clock_gettime'; did you mean '__vdso_clock_gettime'?
Message-ID: <202108251647.ajvQltYh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Saleem,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git for-next
head:   fde9c59aebafb91caeed816cc510b56f14aa63ae
commit: fde9c59aebafb91caeed816cc510b56f14aa63ae [18/18] riscv: explicitly use symbol offsets for VDSO
config: riscv-nommu_k210_defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?id=fde9c59aebafb91caeed816cc510b56f14aa63ae
        git remote add palmer https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git
        git fetch --no-tags palmer for-next
        git checkout fde9c59aebafb91caeed816cc510b56f14aa63ae
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/vdso/vgettimeofday.c: In function '__vdso_clock_gettime':
>> arch/riscv/kernel/vdso/vgettimeofday.c:16:16: error: implicit declaration of function '__cvdso_clock_gettime'; did you mean '__vdso_clock_gettime'? [-Werror=implicit-function-declaration]
      16 |         return __cvdso_clock_gettime(clock, ts);
         |                ^~~~~~~~~~~~~~~~~~~~~
         |                __vdso_clock_gettime
   arch/riscv/kernel/vdso/vgettimeofday.c: In function '__vdso_gettimeofday':
>> arch/riscv/kernel/vdso/vgettimeofday.c:23:16: error: implicit declaration of function '__cvdso_gettimeofday'; did you mean '__vdso_gettimeofday'? [-Werror=implicit-function-declaration]
      23 |         return __cvdso_gettimeofday(tv, tz);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                __vdso_gettimeofday
   arch/riscv/kernel/vdso/vgettimeofday.c: In function '__vdso_clock_getres':
>> arch/riscv/kernel/vdso/vgettimeofday.c:30:16: error: implicit declaration of function '__cvdso_clock_getres'; did you mean '__vdso_clock_getres'? [-Werror=implicit-function-declaration]
      30 |         return __cvdso_clock_getres(clock_id, res);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                __vdso_clock_getres
   cc1: some warnings being treated as errors
--
   arch/riscv/kernel/vdso/vgettimeofday.c: In function '__vdso_clock_gettime':
>> arch/riscv/kernel/vdso/vgettimeofday.c:16:16: error: implicit declaration of function '__cvdso_clock_gettime'; did you mean '__vdso_clock_gettime'? [-Werror=implicit-function-declaration]
      16 |         return __cvdso_clock_gettime(clock, ts);
         |                ^~~~~~~~~~~~~~~~~~~~~
         |                __vdso_clock_gettime
   arch/riscv/kernel/vdso/vgettimeofday.c: In function '__vdso_gettimeofday':
>> arch/riscv/kernel/vdso/vgettimeofday.c:23:16: error: implicit declaration of function '__cvdso_gettimeofday'; did you mean '__vdso_gettimeofday'? [-Werror=implicit-function-declaration]
      23 |         return __cvdso_gettimeofday(tv, tz);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                __vdso_gettimeofday
   arch/riscv/kernel/vdso/vgettimeofday.c: In function '__vdso_clock_getres':
>> arch/riscv/kernel/vdso/vgettimeofday.c:30:16: error: implicit declaration of function '__cvdso_clock_getres'; did you mean '__vdso_clock_getres'? [-Werror=implicit-function-declaration]
      30 |         return __cvdso_clock_getres(clock_id, res);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                __vdso_clock_getres
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:271: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
   make[2]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
   make[1]: *** [arch/riscv/Makefile:113: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:220: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +16 arch/riscv/kernel/vdso/vgettimeofday.c

ad5d1122b82fbd Vincent Chen 2020-06-09  11  
e93b327dbf3d37 Vincent Chen 2020-06-23  12  extern
e93b327dbf3d37 Vincent Chen 2020-06-23  13  int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
ad5d1122b82fbd Vincent Chen 2020-06-09  14  int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
ad5d1122b82fbd Vincent Chen 2020-06-09  15  {
ad5d1122b82fbd Vincent Chen 2020-06-09 @16  	return __cvdso_clock_gettime(clock, ts);
ad5d1122b82fbd Vincent Chen 2020-06-09  17  }
ad5d1122b82fbd Vincent Chen 2020-06-09  18  
e93b327dbf3d37 Vincent Chen 2020-06-23  19  extern
e93b327dbf3d37 Vincent Chen 2020-06-23  20  int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
ad5d1122b82fbd Vincent Chen 2020-06-09  21  int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
ad5d1122b82fbd Vincent Chen 2020-06-09  22  {
ad5d1122b82fbd Vincent Chen 2020-06-09 @23  	return __cvdso_gettimeofday(tv, tz);
ad5d1122b82fbd Vincent Chen 2020-06-09  24  }
ad5d1122b82fbd Vincent Chen 2020-06-09  25  
e93b327dbf3d37 Vincent Chen 2020-06-23  26  extern
e93b327dbf3d37 Vincent Chen 2020-06-23  27  int __vdso_clock_getres(clockid_t clock_id, struct __kernel_timespec *res);
ad5d1122b82fbd Vincent Chen 2020-06-09  28  int __vdso_clock_getres(clockid_t clock_id, struct __kernel_timespec *res)
ad5d1122b82fbd Vincent Chen 2020-06-09  29  {
ad5d1122b82fbd Vincent Chen 2020-06-09 @30  	return __cvdso_clock_getres(clock_id, res);

:::::: The code at line 16 was first introduced by commit
:::::: ad5d1122b82fbd6a816d1b9d26ee01a6dbc2d757 riscv: use vDSO common flow to reduce the latency of the time-related functions

:::::: TO: Vincent Chen <vincent.chen@sifive.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--RnlQjJ0d97Da+TV1--
