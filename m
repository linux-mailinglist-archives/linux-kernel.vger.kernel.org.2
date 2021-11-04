Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B8445334
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhKDMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:43:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:13270 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDMn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:43:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231943230"
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="gz'50?scan'50,208,50";a="231943230"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 05:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="gz'50?scan'50,208,50";a="667887050"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2021 05:40:47 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mic2w-0006O6-A5; Thu, 04 Nov 2021 12:40:46 +0000
Date:   Thu, 4 Nov 2021 20:40:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202111042021.H5cYtXSd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ddb58cb0ecae8e8b6181d736a87667cc9ab8389
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   1 year, 2 months ago
config: sh-randconfig-s032-20211104 (attached as .config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     got unsigned int
>> arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     got unsigned int
--
   fs/orangefs/file.c:118:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int open_for_write @@     got restricted fmode_t @@
   fs/orangefs/file.c:118:32: sparse:     expected int open_for_write
   fs/orangefs/file.c:118:32: sparse:     got restricted fmode_t
   fs/orangefs/file.c:119:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected int open_for_read @@     got restricted fmode_t @@
   fs/orangefs/file.c:119:31: sparse:     expected int open_for_read
   fs/orangefs/file.c:119:31: sparse:     got restricted fmode_t
   fs/orangefs/file.c:424:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/orangefs/file.c:424:21: sparse:     expected int const *__gu_addr
   fs/orangefs/file.c:424:21: sparse:     got int [noderef] __user *
>> fs/orangefs/file.c:424:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/orangefs/file.c:424:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/orangefs/file.c:424:21: sparse:     got int const *__gu_addr

vim +23 arch/sh/kernel/cpu/sh3/clock-sh7712.c

c3aa92afd0a6c2 Andrew Murray 2008-01-08  20  
c3aa92afd0a6c2 Andrew Murray 2008-01-08  21  static void master_clk_init(struct clk *clk)
c3aa92afd0a6c2 Andrew Murray 2008-01-08  22  {
9d56dd3b083a3b Paul Mundt    2010-01-26 @23  	int frqcr = __raw_readw(FRQCR);
c3aa92afd0a6c2 Andrew Murray 2008-01-08  24  	int idx = (frqcr & 0x0300) >> 8;
c3aa92afd0a6c2 Andrew Murray 2008-01-08  25  
c3aa92afd0a6c2 Andrew Murray 2008-01-08  26  	clk->rate *= multipliers[idx];
c3aa92afd0a6c2 Andrew Murray 2008-01-08  27  }
c3aa92afd0a6c2 Andrew Murray 2008-01-08  28  

:::::: The code at line 23 was first introduced by commit
:::::: 9d56dd3b083a3bec56e9da35ce07baca81030b03 sh: Mass ctrl_in/outX to __raw_read/writeX conversion.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--EVF5PPMfhYS0aIcm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
7O5j/gMwahh5dToBAA==

--EVF5PPMfhYS0aIcm--
