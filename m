Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D432AA7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836086AbhCBThI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:37:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:46313 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344242AbhCBRPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:15:31 -0500
IronPort-SDR: Zv/yOAd4k4IlILhq3Syj8ZuxVV1q/yTgaN4kQMgb+Hm27grQtu8hGPrUOVbTNooqR8Uc/vLciP
 DJZa9qW/nibw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="248306149"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="gz'50?scan'50,208,50";a="248306149"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 09:13:57 -0800
IronPort-SDR: RPSqsRlyaAB9T7qC99+yvJtZITCSZ72HMaC6NRdAVcOcQbtIwVG5IrkAQ6Vh0Lr7ef+4H0woZm
 9w++IvnzaRyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="gz'50?scan'50,208,50";a="434891194"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2021 09:13:55 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lH8ao-0000Yb-VQ; Tue, 02 Mar 2021 17:13:54 +0000
Date:   Wed, 3 Mar 2021 01:12:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/accessibility/speakup/speakup_dtlk.c:334:28: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <202103030149.sofZ6UCm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Samuel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7a7fd0de4a9804299793e564a555a49c1fc924cb
commit: 2067fd92d75b6d9085a43caf050bca5d88c491b8 staging/speakup: Move out of staging
date:   7 months ago
config: riscv-randconfig-s032-20210301 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-241-geaceeafa-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2067fd92d75b6d9085a43caf050bca5d88c491b8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2067fd92d75b6d9085a43caf050bca5d88c491b8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/accessibility/speakup/speakup_dtlk.c:334:28: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/accessibility/speakup/speakup_dtlk.c:334:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/speakup_dtlk.c:334:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/speakup_dtlk.c:334:28: sparse:     got void *
   drivers/accessibility/speakup/speakup_dtlk.c:341:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/speakup_dtlk.c:341:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/speakup_dtlk.c:341:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/speakup_dtlk.c:341:36: sparse:     got void *
   drivers/accessibility/speakup/speakup_dtlk.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, drivers/accessibility/speakup/spk_types.h, ...):
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:564:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:564:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:564:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:564:16: sparse:     got void *
--
>> drivers/accessibility/speakup/serialio.c:139:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/accessibility/speakup/serialio.c:139:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:139:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:139:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:142:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:142:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:142:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:142:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:144:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/accessibility/speakup/serialio.c:144:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:144:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:144:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:145:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:145:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:145:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:146:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:146:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:146:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:146:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:147:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:147:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:147:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:147:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:148:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:148:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:148:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:148:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:155:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:155:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:155:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:155:16: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:160:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:160:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:160:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:160:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:165:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:165:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:165:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:165:19: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:167:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:167:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:167:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:167:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:87:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:87:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:87:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:87:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:88:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:88:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:88:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:89:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:89:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:89:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:89:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:90:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:90:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:90:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:90:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:93:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:93:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:93:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:93:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:94:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:94:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:94:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:94:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:97:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:97:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:97:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:97:13: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:208:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:208:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:208:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:208:9: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:230:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:230:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:230:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:230:16: sparse:     got void *
   drivers/accessibility/speakup/serialio.c:299:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/accessibility/speakup/serialio.c:299:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/accessibility/speakup/serialio.c:299:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/accessibility/speakup/serialio.c:299:25: sparse:     got void *
   drivers/accessibility/speakup/serialio.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +334 drivers/accessibility/speakup/speakup_dtlk.c

c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  315  
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  316  static int synth_probe(struct spk_synth *synth)
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  317  {
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  318  	unsigned int port_val = 0;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  319  	int i = 0;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  320  	struct synth_settings *sp;
8e69a811068657 drivers/staging/speakup/speakup_dtlk.c Domagoj Trsan 2014-09-09  321  
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  322  	pr_info("Probing for DoubleTalk.\n");
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  323  	if (port_forced) {
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  324  		speakup_info.port_tts = port_forced;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  325  		pr_info("probe forced to %x by kernel command line\n",
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  326  			speakup_info.port_tts);
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  327  		if ((port_forced & 0xf) != 0xf)
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  328  			pr_info("warning: port base should probably end with f\n");
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  329  		if (synth_request_region(speakup_info.port_tts - 1,
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  330  					 SYNTH_IO_EXTENT)) {
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  331  			pr_warn("sorry, port already reserved\n");
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  332  			return -EBUSY;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  333  		}
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07 @334  		port_val = inw(speakup_info.port_tts - 1);
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  335  		synth_lpc = speakup_info.port_tts - 1;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  336  	} else {
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  337  		for (i = 0; synth_portlist[i]; i++) {
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  338  			if (synth_request_region(synth_portlist[i],
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  339  						 SYNTH_IO_EXTENT))
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  340  				continue;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  341  			port_val = inw(synth_portlist[i]) & 0xfbff;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  342  			if (port_val == 0x107f) {
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  343  				synth_lpc = synth_portlist[i];
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  344  				speakup_info.port_tts = synth_lpc + 1;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  345  				break;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  346  			}
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  347  			synth_release_region(synth_portlist[i],
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  348  					     SYNTH_IO_EXTENT);
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  349  		}
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  350  	}
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  351  	port_val &= 0xfbff;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  352  	if (port_val != 0x107f) {
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  353  		pr_info("DoubleTalk PC: not found\n");
7aa4d5c8ffed00 drivers/staging/speakup/speakup_dtlk.c Alan Cox      2014-12-15  354  		if (synth_lpc)
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  355  			synth_release_region(synth_lpc, SYNTH_IO_EXTENT);
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  356  		return -ENODEV;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  357  	}
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  358  	while (inw_p(synth_lpc) != 0x147f)
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  359  		cpu_relax(); /* wait until it's ready */
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  360  	sp = synth_interrogate(synth);
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  361  	pr_info("%s: %03x-%03x, ROM ver %s, s/n %u, driver: %s\n",
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  362  		synth->long_name, synth_lpc, synth_lpc + SYNTH_IO_EXTENT - 1,
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  363  		sp->rom_version, sp->serial_number, synth->version);
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  364  	synth->alive = 1;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  365  	return 0;
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  366  }
c6e3fd22cd5383 drivers/staging/speakup/speakup_dtlk.c William Hubbs 2010-10-07  367  

:::::: The code at line 334 was first introduced by commit
:::::: c6e3fd22cd538365bfeb82997d5b89562e077d42 Staging: add speakup to the staging directory

:::::: TO: William Hubbs <w.d.hubbs@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tKW2IUtsqtDRztdT--
