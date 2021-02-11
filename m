Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49036318477
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 06:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhBKFHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 00:07:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:55022 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhBKFHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:07:02 -0500
IronPort-SDR: jXiuGZ+880MrrmVl1Wk46Cj4g2xtYTvWam38RViCLeIQjl4CYQzWBuMkwePdnWraPF06EDGNTE
 fpOMJVGPkd8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161944238"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="161944238"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 21:06:21 -0800
IronPort-SDR: se1U/ziyJXxaoJElrXDhqKg30WjZpu6jfzbhHGZjM31bN2roxtwVp/sU1y5/7lSsNQcEAL5zZ7
 3bLvuXje85nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="421327152"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2021 21:06:20 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lA4BG-0003Wb-Q1; Thu, 11 Feb 2021 05:06:18 +0000
Date:   Thu, 11 Feb 2021 13:05:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.02.01a] BUILD SUCCESS
 52a8ca059c5eca36698a33cb16a373a6a1ed8978
Message-ID: <6024bb31.Dn13GaaYKRwnHicP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.02.01a
branch HEAD: 52a8ca059c5eca36698a33cb16a373a6a1ed8978  fixup! torture: Provide bare-metal modprobe-based advice

elapsed time: 724m

configs tested: 118
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           sama5_defconfig
m68k                        mvme147_defconfig
sh                        dreamcast_defconfig
sh                                  defconfig
powerpc                     powernv_defconfig
arm                         palmz72_defconfig
mips                       bmips_be_defconfig
mips                        bcm47xx_defconfig
openrisc                    or1ksim_defconfig
openrisc                  or1klitex_defconfig
powerpc                      obs600_defconfig
m68k                       m5249evb_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                        nsimosci_defconfig
mips                         tb0219_defconfig
m68k                            q40_defconfig
mips                        qi_lb60_defconfig
arm                           sunxi_defconfig
xtensa                         virt_defconfig
arm                        magician_defconfig
mips                           ip32_defconfig
powerpc                     tqm8540_defconfig
powerpc                  mpc885_ads_defconfig
arc                         haps_hs_defconfig
arm                          prima2_defconfig
powerpc                          g5_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        realview_defconfig
arm                          badge4_defconfig
mips                         tb0287_defconfig
powerpc                    socrates_defconfig
mips                            ar7_defconfig
powerpc                     sbc8548_defconfig
powerpc                     tqm8555_defconfig
powerpc                          allmodconfig
arm                             pxa_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7751_defconfig
powerpc                     sequoia_defconfig
ia64                         bigsur_defconfig
ia64                      gensparse_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
