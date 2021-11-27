Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C48D45FC19
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 03:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbhK0Ciu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 21:38:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:16524 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347625AbhK0Cgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 21:36:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="216442884"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="216442884"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 18:33:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="457856623"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2021 18:33:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqnWr-0008wd-Vb; Sat, 27 Nov 2021 02:33:29 +0000
Date:   Sat, 27 Nov 2021 10:32:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-4.19.y 565/981]
 arch/xtensa/platforms/xtfpga/include/platform/hardware.h:50:33: error:
 initializer element is not constant
Message-ID: <202111271017.dLo8jJ8p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
head:   1f244a54b39dd02c69f79001b38e2650e96f1ea8
commit: 1c21a8df144f1edb3b6f5f24559825780c227a7d [565/981] xtensa: xtfpga: use CONFIG_USE_OF instead of CONFIG_OF
config: xtensa-randconfig-r001-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271017.dLo8jJ8p-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=1c21a8df144f1edb3b6f5f24559825780c227a7d
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.19.y
        git checkout 1c21a8df144f1edb3b6f5f24559825780c227a7d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10,
                    from arch/xtensa/platforms/xtfpga/setup.c:19:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/xtensa/include/asm/page.h:182:16: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
     182 |         ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
         |                ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/dma-mapping.h:329:9: note: in expansion of macro 'BUG_ON'
     329 |         BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
         |         ^~~~~~
   include/linux/dma-mapping.h:329:16: note: in expansion of macro 'pfn_valid'
     329 |         BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
         |                ^~~~~~~~~
   In file included from arch/xtensa/platforms/xtfpga/setup.c:37:
   arch/xtensa/platforms/xtfpga/setup.c: At top level:
>> arch/xtensa/platforms/xtfpga/include/platform/hardware.h:50:33: error: initializer element is not constant
      50 | #define OETH_REGS_PADDR         (XCHAL_KIO_PADDR + 0x0D030000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:168:26: note: in expansion of macro 'OETH_REGS_PADDR'
     168 |                 .start = OETH_REGS_PADDR,
         |                          ^~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:50:33: note: (near initialization for 'ethoc_res[0].start')
      50 | #define OETH_REGS_PADDR         (XCHAL_KIO_PADDR + 0x0D030000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:168:26: note: in expansion of macro 'OETH_REGS_PADDR'
     168 |                 .start = OETH_REGS_PADDR,
         |                          ^~~~~~~~~~~~~~~
>> arch/xtensa/platforms/xtfpga/include/platform/hardware.h:50:33: error: initializer element is not constant
      50 | #define OETH_REGS_PADDR         (XCHAL_KIO_PADDR + 0x0D030000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:169:26: note: in expansion of macro 'OETH_REGS_PADDR'
     169 |                 .end   = OETH_REGS_PADDR + OETH_REGS_SIZE - 1,
         |                          ^~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:50:33: note: (near initialization for 'ethoc_res[0].end')
      50 | #define OETH_REGS_PADDR         (XCHAL_KIO_PADDR + 0x0D030000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:169:26: note: in expansion of macro 'OETH_REGS_PADDR'
     169 |                 .end   = OETH_REGS_PADDR + OETH_REGS_SIZE - 1,
         |                          ^~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:52:33: error: initializer element is not constant
      52 | #define OETH_SRAMBUFF_PADDR     (XCHAL_KIO_PADDR + 0x0D800000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:173:26: note: in expansion of macro 'OETH_SRAMBUFF_PADDR'
     173 |                 .start = OETH_SRAMBUFF_PADDR,
         |                          ^~~~~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:52:33: note: (near initialization for 'ethoc_res[1].start')
      52 | #define OETH_SRAMBUFF_PADDR     (XCHAL_KIO_PADDR + 0x0D800000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:173:26: note: in expansion of macro 'OETH_SRAMBUFF_PADDR'
     173 |                 .start = OETH_SRAMBUFF_PADDR,
         |                          ^~~~~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:52:33: error: initializer element is not constant
      52 | #define OETH_SRAMBUFF_PADDR     (XCHAL_KIO_PADDR + 0x0D800000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:174:26: note: in expansion of macro 'OETH_SRAMBUFF_PADDR'
     174 |                 .end   = OETH_SRAMBUFF_PADDR + OETH_SRAMBUFF_SIZE - 1,
         |                          ^~~~~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:52:33: note: (near initialization for 'ethoc_res[1].end')
      52 | #define OETH_SRAMBUFF_PADDR     (XCHAL_KIO_PADDR + 0x0D800000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:174:26: note: in expansion of macro 'OETH_SRAMBUFF_PADDR'
     174 |                 .end   = OETH_SRAMBUFF_PADDR + OETH_SRAMBUFF_SIZE - 1,
         |                          ^~~~~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:57:33: error: initializer element is not constant
      57 | #define C67X00_PADDR            (XCHAL_KIO_PADDR + 0x0D0D0000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:211:26: note: in expansion of macro 'C67X00_PADDR'
     211 |                 .start = C67X00_PADDR,
         |                          ^~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:57:33: note: (near initialization for 'c67x00_res[0].start')
      57 | #define C67X00_PADDR            (XCHAL_KIO_PADDR + 0x0D0D0000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:211:26: note: in expansion of macro 'C67X00_PADDR'
     211 |                 .start = C67X00_PADDR,
         |                          ^~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:57:33: error: initializer element is not constant
      57 | #define C67X00_PADDR            (XCHAL_KIO_PADDR + 0x0D0D0000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:212:26: note: in expansion of macro 'C67X00_PADDR'
     212 |                 .end   = C67X00_PADDR + C67X00_SIZE - 1,
         |                          ^~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:57:33: note: (near initialization for 'c67x00_res[0].end')
      57 | #define C67X00_PADDR            (XCHAL_KIO_PADDR + 0x0D0D0000)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:212:26: note: in expansion of macro 'C67X00_PADDR'
     212 |                 .end   = C67X00_PADDR + C67X00_SIZE - 1,
         |                          ^~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:37:33: error: initializer element is not constant
      37 | #define DUART16552_PADDR        (XCHAL_KIO_PADDR + 0x0D050020)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:242:19: note: in expansion of macro 'DUART16552_PADDR'
     242 |         .start  = DUART16552_PADDR,
         |                   ^~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:37:33: note: (near initialization for 'serial_resource.start')
      37 | #define DUART16552_PADDR        (XCHAL_KIO_PADDR + 0x0D050020)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:242:19: note: in expansion of macro 'DUART16552_PADDR'
     242 |         .start  = DUART16552_PADDR,
         |                   ^~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:37:33: error: initializer element is not constant
      37 | #define DUART16552_PADDR        (XCHAL_KIO_PADDR + 0x0D050020)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:243:19: note: in expansion of macro 'DUART16552_PADDR'
     243 |         .end    = DUART16552_PADDR + 0x1f,
         |                   ^~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:37:33: note: (near initialization for 'serial_resource.end')
      37 | #define DUART16552_PADDR        (XCHAL_KIO_PADDR + 0x0D050020)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:243:19: note: in expansion of macro 'DUART16552_PADDR'
     243 |         .end    = DUART16552_PADDR + 0x1f,
         |                   ^~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:37:33: error: initializer element is not constant
      37 | #define DUART16552_PADDR        (XCHAL_KIO_PADDR + 0x0D050020)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:249:35: note: in expansion of macro 'DUART16552_PADDR'
     249 |                 .mapbase        = DUART16552_PADDR,
         |                                   ^~~~~~~~~~~~~~~~
   arch/xtensa/platforms/xtfpga/include/platform/hardware.h:37:33: note: (near initialization for 'serial_platform_data[0].mapbase')
      37 | #define DUART16552_PADDR        (XCHAL_KIO_PADDR + 0x0D050020)
         |                                 ^
   arch/xtensa/platforms/xtfpga/setup.c:249:35: note: in expansion of macro 'DUART16552_PADDR'
     249 |                 .mapbase        = DUART16552_PADDR,
         |                                   ^~~~~~~~~~~~~~~~


vim +50 arch/xtensa/platforms/xtfpga/include/platform/hardware.h

0d456bad36d42d1 Max Filippov 2012-11-05  47  
0d456bad36d42d1 Max Filippov 2012-11-05  48  /*  OpenCores Ethernet controller:  */
0d456bad36d42d1 Max Filippov 2012-11-05  49  				/* regs + RX/TX descriptors */
0d456bad36d42d1 Max Filippov 2012-11-05 @50  #define OETH_REGS_PADDR		(XCHAL_KIO_PADDR + 0x0D030000)
0d456bad36d42d1 Max Filippov 2012-11-05  51  #define OETH_REGS_SIZE		0x1000
0d456bad36d42d1 Max Filippov 2012-11-05  52  #define OETH_SRAMBUFF_PADDR	(XCHAL_KIO_PADDR + 0x0D800000)
0d456bad36d42d1 Max Filippov 2012-11-05  53  
0d456bad36d42d1 Max Filippov 2012-11-05  54  				/* 5*rx buffs + 5*tx buffs */
0d456bad36d42d1 Max Filippov 2012-11-05  55  #define OETH_SRAMBUFF_SIZE	(5 * 0x600 + 5 * 0x600)
0d456bad36d42d1 Max Filippov 2012-11-05  56  

:::::: The code at line 50 was first introduced by commit
:::::: 0d456bad36d42d16022be045c8a53ddbb59ee478 xtensa: add support for the XTFPGA boards

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Chris Zankel <chris@zankel.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
