Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216AF3534F4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 19:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhDCRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 13:37:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:26544 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236819AbhDCRhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 13:37:53 -0400
IronPort-SDR: o3sh64K7oYz2C7X4+xFOZup//3XTZFU8KjlC11jNxcXN8reDFtqmCyrHI/8SO4oEoNOh8sJ7ER
 vTXCDsW4mOCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9943"; a="172064591"
X-IronPort-AV: E=Sophos;i="5.81,302,1610438400"; 
   d="scan'208";a="172064591"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2021 10:37:50 -0700
IronPort-SDR: I+xy7OTeuBr6AmxtTQHLQxK/n7Kk4K8dV3V40tvFI6HRN4JvNm6UJBwhJ6HNk1fI/KwDbSgKwK
 VX8F7scj38EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,302,1610438400"; 
   d="scan'208";a="417441003"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Apr 2021 10:37:49 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSkDU-0007nS-H5; Sat, 03 Apr 2021 17:37:48 +0000
Date:   Sun, 04 Apr 2021 01:36:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 69f68579fdceac1651a312a71fe11115399369c6
Message-ID: <6068a7b1.giLYzchh0MNbS49v%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 69f68579fdceac1651a312a71fe11115399369c6  rcu: Improve tree.c comments and add code cleanups

elapsed time: 725m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                     powernv_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
powerpc                      ppc40x_defconfig
mips                         tb0226_defconfig
ia64                             allmodconfig
m68k                         amcore_defconfig
m68k                       bvme6000_defconfig
arm                       spear13xx_defconfig
powerpc                     ppa8548_defconfig
sh                             sh03_defconfig
powerpc                          g5_defconfig
powerpc                      katmai_defconfig
arm                        mini2440_defconfig
sh                            migor_defconfig
arm                         socfpga_defconfig
sh                             espt_defconfig
s390                             allmodconfig
xtensa                  nommu_kc705_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          sdk7780_defconfig
powerpc                     ep8248e_defconfig
powerpc                      ppc64e_defconfig
arm                         lpc32xx_defconfig
m68k                        m5272c3_defconfig
h8300                            alldefconfig
sh                           se7712_defconfig
powerpc                     tqm8555_defconfig
arm                         mv78xx0_defconfig
mips                        bcm47xx_defconfig
xtensa                          iss_defconfig
arm                          pxa910_defconfig
powerpc                    sam440ep_defconfig
mips                      bmips_stb_defconfig
arm                             rpc_defconfig
arc                            hsdk_defconfig
mips                        qi_lb60_defconfig
arc                              alldefconfig
powerpc                      ep88xc_defconfig
parisc                generic-32bit_defconfig
mips                         mpc30x_defconfig
sh                           sh2007_defconfig
arm                         hackkit_defconfig
arm                          moxart_defconfig
arm                           stm32_defconfig
sh                            hp6xx_defconfig
mips                           ip22_defconfig
m68k                             alldefconfig
sh                          r7780mp_defconfig
mips                       rbtx49xx_defconfig
m68k                         apollo_defconfig
powerpc                   lite5200b_defconfig
arm                            hisi_defconfig
x86_64                              defconfig
powerpc                        icon_defconfig
sh                   sh7770_generic_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                           h5000_defconfig
riscv                          rv32_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210403
i386                 randconfig-a003-20210403
i386                 randconfig-a001-20210403
i386                 randconfig-a004-20210403
i386                 randconfig-a002-20210403
i386                 randconfig-a005-20210403
x86_64               randconfig-a014-20210403
x86_64               randconfig-a015-20210403
x86_64               randconfig-a011-20210403
x86_64               randconfig-a013-20210403
x86_64               randconfig-a012-20210403
x86_64               randconfig-a016-20210403
i386                 randconfig-a014-20210404
i386                 randconfig-a016-20210404
i386                 randconfig-a011-20210404
i386                 randconfig-a012-20210404
i386                 randconfig-a015-20210404
i386                 randconfig-a013-20210404
i386                 randconfig-a014-20210403
i386                 randconfig-a011-20210403
i386                 randconfig-a016-20210403
i386                 randconfig-a012-20210403
i386                 randconfig-a013-20210403
i386                 randconfig-a015-20210403
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210403
x86_64               randconfig-a005-20210403
x86_64               randconfig-a003-20210403
x86_64               randconfig-a001-20210403
x86_64               randconfig-a002-20210403
x86_64               randconfig-a006-20210403
x86_64               randconfig-a014-20210402
x86_64               randconfig-a015-20210402
x86_64               randconfig-a011-20210402
x86_64               randconfig-a013-20210402
x86_64               randconfig-a012-20210402
x86_64               randconfig-a016-20210402

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
