Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057A5460157
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 21:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbhK0UD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 15:03:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:51480 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233783AbhK0UBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 15:01:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="223011278"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="223011278"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 11:58:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="458583075"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Nov 2021 11:58:05 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mr3pk-0009w1-LW; Sat, 27 Nov 2021 19:58:04 +0000
Date:   Sun, 28 Nov 2021 03:57:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous
 prototype for 'ixp4xx_pci_write'
Message-ID: <202111280310.yf3ykspL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
commit: d5d9f7ac58ea1041375a028f143ca5784693ea86 ARM/ixp4xx: Make NEED_MACH_IO_H optional
date:   5 months ago
config: arm-ixp4xx_defconfig (https://download.01.org/0day-ci/archive/20211128/202111280310.yf3ykspL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5d9f7ac58ea1041375a028f143ca5784693ea86
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d5d9f7ac58ea1041375a028f143ca5784693ea86
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/mach-ixp4xx/common-pci.c:94:5: warning: no previous prototype for 'ixp4xx_pci_read_errata' [-Wmissing-prototypes]
      94 | int ixp4xx_pci_read_errata(u32 addr, u32 cmd, u32* data)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-ixp4xx/common-pci.c:121:5: warning: no previous prototype for 'ixp4xx_pci_read_no_errata' [-Wmissing-prototypes]
     121 | int ixp4xx_pci_read_no_errata(u32 addr, u32 cmd, u32* data)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous prototype for 'ixp4xx_pci_write' [-Wmissing-prototypes]
     143 | int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
         |     ^~~~~~~~~~~~~~~~


vim +/ixp4xx_pci_write +143 arch/arm/mach-ixp4xx/common-pci.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  142  
^1da177e4c3f41 Linus Torvalds  2005-04-16 @143  int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
^1da177e4c3f41 Linus Torvalds  2005-04-16  144  {    
^1da177e4c3f41 Linus Torvalds  2005-04-16  145  	unsigned long flags;
^1da177e4c3f41 Linus Torvalds  2005-04-16  146  	int retval = 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  147  
bd31b85960a7fc Thomas Gleixner 2009-07-03  148  	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
^1da177e4c3f41 Linus Torvalds  2005-04-16  149  
^1da177e4c3f41 Linus Torvalds  2005-04-16  150  	*PCI_NP_AD = addr;
^1da177e4c3f41 Linus Torvalds  2005-04-16  151  
^1da177e4c3f41 Linus Torvalds  2005-04-16  152  	/* set up the write */
^1da177e4c3f41 Linus Torvalds  2005-04-16  153  	*PCI_NP_CBE = cmd;
^1da177e4c3f41 Linus Torvalds  2005-04-16  154  
^1da177e4c3f41 Linus Torvalds  2005-04-16  155  	/* execute the write by writing to NP_WDATA */
^1da177e4c3f41 Linus Torvalds  2005-04-16  156  	*PCI_NP_WDATA = data;
^1da177e4c3f41 Linus Torvalds  2005-04-16  157  
^1da177e4c3f41 Linus Torvalds  2005-04-16  158  	if(check_master_abort())
^1da177e4c3f41 Linus Torvalds  2005-04-16  159  		retval = 1;
^1da177e4c3f41 Linus Torvalds  2005-04-16  160  
bd31b85960a7fc Thomas Gleixner 2009-07-03  161  	raw_spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
^1da177e4c3f41 Linus Torvalds  2005-04-16  162  	return retval;
^1da177e4c3f41 Linus Torvalds  2005-04-16  163  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  164  

:::::: The code at line 143 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
