Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCE045A404
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhKWNnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:43:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:60467 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhKWNnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:43:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="321253708"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="321253708"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 05:40:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="456696564"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Nov 2021 05:40:39 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpW2I-0001tx-M1; Tue, 23 Nov 2021 13:40:38 +0000
Date:   Tue, 23 Nov 2021 21:40:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: include/asm-generic/io.h:291:22: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202111232102.j4IfMUMj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   136057256686de39cc3a07c2e39ef6bc43003ff6
commit: 6e1e90ec027509a7e8d4efbd77a65b32b5a8b3ec regmap: mmio: add config option to allow relaxed MMIO accesses
date:   1 year, 1 month ago
config: h8300-randconfig-s031-20211117 (https://download.01.org/0day-ci/archive/20211123/202111232102.j4IfMUMj-lkp@intel.com/config.gz)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e1e90ec027509a7e8d4efbd77a65b32b5a8b3ec
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e1e90ec027509a7e8d4efbd77a65b32b5a8b3ec
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/base/regmap/regmap-mmio.c: note: in included file (through include/linux/io.h):
   arch/h8300/include/asm/io.h:32:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:32:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:38:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/base/regmap/regmap-mmio.c: note: in included file (through arch/h8300/include/asm/io.h, include/linux/io.h):
>> include/asm-generic/io.h:291:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] b @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:291:22: sparse:     expected unsigned short [usertype] b
   include/asm-generic/io.h:291:22: sparse:     got restricted __le16 [usertype]
   drivers/base/regmap/regmap-mmio.c: note: in included file (through include/linux/io.h):
   arch/h8300/include/asm/io.h:38:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:38:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/base/regmap/regmap-mmio.c: note: in included file (through arch/h8300/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] b
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   drivers/base/regmap/regmap-mmio.c: note: in included file (through include/linux/io.h):
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:14:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:14:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/base/regmap/regmap-mmio.c: note: in included file (through arch/h8300/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:259:16: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:259:16: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:259:16: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:259:16: sparse: sparse: cast to restricted __le16
   drivers/base/regmap/regmap-mmio.c: note: in included file (through include/linux/io.h):
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/base/regmap/regmap-mmio.c: note: in included file (through arch/h8300/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   drivers/base/regmap/regmap-mmio.c: note: in included file (through include/linux/io.h):
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression

vim +291 include/asm-generic/io.h

9439eb3ab9d1ec Will Deacon 2013-09-03  286  
9439eb3ab9d1ec Will Deacon 2013-09-03  287  #ifndef writew_relaxed
a71e7c44ffb7ba Sinan Kaya  2018-04-06  288  #define writew_relaxed writew_relaxed
a71e7c44ffb7ba Sinan Kaya  2018-04-06  289  static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
a71e7c44ffb7ba Sinan Kaya  2018-04-06  290  {
a71e7c44ffb7ba Sinan Kaya  2018-04-06 @291  	__raw_writew(cpu_to_le16(value), addr);
a71e7c44ffb7ba Sinan Kaya  2018-04-06  292  }
9439eb3ab9d1ec Will Deacon 2013-09-03  293  #endif
9439eb3ab9d1ec Will Deacon 2013-09-03  294  

:::::: The code at line 291 was first introduced by commit
:::::: a71e7c44ffb7baea0c0795824afc34cc0bc1a301 io: change writeX_relaxed() to remove barriers

:::::: TO: Sinan Kaya <okaya@codeaurora.org>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
