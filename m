Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACB63CF7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbhGTJjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 05:39:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:25710 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236678AbhGTJeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:34:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="191489142"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="gz'50?scan'50,208,50";a="191489142"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 03:14:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="gz'50?scan'50,208,50";a="657464863"
Received: from lkp-server02.sh.intel.com (HELO 1b5a72ed9419) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jul 2021 03:14:56 -0700
Received: from kbuild by 1b5a72ed9419 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5mm8-00009v-0U; Tue, 20 Jul 2021 10:14:56 +0000
Date:   Tue, 20 Jul 2021 18:14:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-linux-mm:master 16/150] arch/nds32/include/asm/nds32.h:13:10:
 fatal error: nds32_intrinsic.h: No such file or directory
Message-ID: <202107201803.cvKw7Z8Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/hnaz/linux-mm master
head:   90b6b859af7dc2d09c05d8d89144f55fca94e80c
commit: c1af5351189e92e8d4c666f636b51c0bfe262a27 [16/150] kbuild: decouple build from userspace headers
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/hnaz/linux-mm/commit/c1af5351189e92e8d4c666f636b51c0bfe262a27
        git remote add hnaz-linux-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-linux-mm master
        git checkout c1af5351189e92e8d4c666f636b51c0bfe262a27
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=nds32 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the hnaz-linux-mm/master HEAD 90b6b859af7dc2d09c05d8d89144f55fca94e80c builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/nds32/include/asm/irqflags.h:4,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nds32/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:32,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> arch/nds32/include/asm/nds32.h:13:10: fatal error: nds32_intrinsic.h: No such file or directory
      13 | #include <nds32_intrinsic.h>
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from arch/nds32/include/asm/irqflags.h:4,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nds32/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:32,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> arch/nds32/include/asm/nds32.h:13:10: fatal error: nds32_intrinsic.h: No such file or directory
      13 | #include <nds32_intrinsic.h>
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1209: prepare0] Error 2
   make[1]: Target 'modules_prepare' not remade because of errors.
   make: *** [Makefile:220: __sub-make] Error 2
   make: Target 'modules_prepare' not remade because of errors.
--
   In file included from arch/nds32/include/asm/irqflags.h:4,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nds32/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:32,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> arch/nds32/include/asm/nds32.h:13:10: fatal error: nds32_intrinsic.h: No such file or directory
      13 | #include <nds32_intrinsic.h>
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1209: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:220: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +13 arch/nds32/include/asm/nds32.h

e1d82de681fd79 Greentime Hu 2017-10-24   9  
e1d82de681fd79 Greentime Hu 2017-10-24  10  #ifndef __ASSEMBLY__
e1d82de681fd79 Greentime Hu 2017-10-24  11  #include <linux/init.h>
e1d82de681fd79 Greentime Hu 2017-10-24  12  #include <asm/barrier.h>
e1d82de681fd79 Greentime Hu 2017-10-24 @13  #include <nds32_intrinsic.h>
e1d82de681fd79 Greentime Hu 2017-10-24  14  

:::::: The code at line 13 was first introduced by commit
:::::: e1d82de681fd79e65f86912c7b231d88180ac8a4 nds32: Assembly macros and definitions

:::::: TO: Greentime Hu <greentime@andestech.com>
:::::: CC: Greentime Hu <greentime@andestech.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PEIAKu/WMn1b1Hv9
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--PEIAKu/WMn1b1Hv9--
