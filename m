Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9135B27D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 10:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhDKIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 04:50:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:17782 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKIuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 04:50:05 -0400
IronPort-SDR: 27LY78PJHRdw8rpe/7TSGST+i1pvL/3qBsmPLGz1AC4q/azDKF0m7PeznRON0v7COS88UPzw7s
 5faodzXSikEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="181530571"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="gz'50?scan'50,208,50";a="181530571"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 01:49:48 -0700
IronPort-SDR: QQXVmp8pxDuACU1ZZWWEUqYSxZiH4eKDLBMSsxZ7810K+7X2kJdLak/JOcDlWHbol71Bj+J9We
 WuugvAZKsuSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="gz'50?scan'50,208,50";a="423364430"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Apr 2021 01:49:46 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVVmr-000Ito-K1; Sun, 11 Apr 2021 08:49:45 +0000
Date:   Sun, 11 Apr 2021 16:49:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/accessibility/speakup/speakup_dtlk.c:334:28: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <202104111657.MtQS22KL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Samuel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52e44129fba5cfc4e351fdb5e45849afc74d9a53
commit: 2067fd92d75b6d9085a43caf050bca5d88c491b8 staging/speakup: Move out of staging
date:   9 months ago
config: riscv-randconfig-s032-20210411 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-279-g6d5d9b42-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2067fd92d75b6d9085a43caf050bca5d88c491b8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2067fd92d75b6d9085a43caf050bca5d88c491b8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
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

--bp/iNruPH9dso1Pn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--bp/iNruPH9dso1Pn--
