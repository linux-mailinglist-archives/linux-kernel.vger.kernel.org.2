Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE334ADE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCZRuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:50:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:46060 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhCZRtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:49:49 -0400
IronPort-SDR: K25qIEKWPH3cdehKO6qv+IOWzhcKvKTy70fE0pftAlNweqJkxsbb0WE1fT+edxLHD2fHzb4pvt
 UpboTGpZCZCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="170572064"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="170572064"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 10:49:48 -0700
IronPort-SDR: u5gb+bnuonuIdoUFh/2ybbcU6rk0tS1yo2drxXPcUyCKup40lGHWqXL7Q3pI1vL1bKYOHy1Bu/
 t4RVSJgnLBCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="375559597"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Mar 2021 10:49:46 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPqaf-0002uZ-Ph; Fri, 26 Mar 2021 17:49:45 +0000
Date:   Sat, 27 Mar 2021 01:49:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/test] BUILD SUCCESS
 1f6f6bd5180cb7510cad12b105f7428a08ecd8c0
Message-ID: <605e1e8f.QlTkO3qAPH3xogxf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/test
branch HEAD: 1f6f6bd5180cb7510cad12b105f7428a08ecd8c0  Merge branch 'dev.2021.03.24a' into HEAD

i386-tinyconfig vmlinux size:

=========================================================================================================
 TOTAL  TEXT  bitmap_parselist()  kmem_dump_obj()                                                        
=========================================================================================================
  -105  -109                 +81              -84  1f6f6bd5180c Merge branch 'dev.2021.03.24a' into HEAD 
  -105  -109                 +81              -84  db24726bfefa..1f6f6bd5180c (ALL COMMITS)              
=========================================================================================================

elapsed time: 900m

configs tested: 144
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
powerpc                     mpc5200_defconfig
arm                        shmobile_defconfig
powerpc                     ep8248e_defconfig
powerpc                     ksi8560_defconfig
um                               allyesconfig
powerpc                    ge_imp3a_defconfig
powerpc                      cm5200_defconfig
powerpc                         wii_defconfig
arm                      jornada720_defconfig
mips                         tb0287_defconfig
arm                         s3c6400_defconfig
powerpc                     rainier_defconfig
powerpc64                        alldefconfig
arm                          moxart_defconfig
openrisc                            defconfig
sh                         microdev_defconfig
arm                          ixp4xx_defconfig
arm                         bcm2835_defconfig
powerpc                    klondike_defconfig
sh                            shmin_defconfig
mips                            gpr_defconfig
mips                       lemote2f_defconfig
mips                         tb0219_defconfig
sh                          r7780mp_defconfig
arm                             mxs_defconfig
um                             i386_defconfig
powerpc                     tqm8560_defconfig
sh                   rts7751r2dplus_defconfig
m68k                        m5307c3_defconfig
sh                               j2_defconfig
powerpc                      acadia_defconfig
mips                         cobalt_defconfig
powerpc                  iss476-smp_defconfig
h8300                       h8s-sim_defconfig
sh                           se7750_defconfig
arm                           h3600_defconfig
arm                        mvebu_v7_defconfig
openrisc                 simple_smp_defconfig
powerpc                     ppa8548_defconfig
powerpc                      bamboo_defconfig
mips                         mpc30x_defconfig
mips                       rbtx49xx_defconfig
riscv                               defconfig
mips                        nlm_xlp_defconfig
arc                         haps_hs_defconfig
m68k                          multi_defconfig
arm                         palmz72_defconfig
arm                         mv78xx0_defconfig
powerpc                     taishan_defconfig
arm                          iop32x_defconfig
arm                         vf610m4_defconfig
m68k                        mvme147_defconfig
powerpc                      ep88xc_defconfig
powerpc               mpc834x_itxgp_defconfig
h8300                    h8300h-sim_defconfig
ia64                             allmodconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210325
x86_64               randconfig-a003-20210325
x86_64               randconfig-a006-20210325
x86_64               randconfig-a001-20210325
x86_64               randconfig-a005-20210325
x86_64               randconfig-a004-20210325
i386                 randconfig-a003-20210325
i386                 randconfig-a004-20210325
i386                 randconfig-a001-20210325
i386                 randconfig-a002-20210325
i386                 randconfig-a006-20210325
i386                 randconfig-a005-20210325
i386                 randconfig-a004-20210326
i386                 randconfig-a003-20210326
i386                 randconfig-a001-20210326
i386                 randconfig-a002-20210326
i386                 randconfig-a006-20210326
i386                 randconfig-a005-20210326
x86_64               randconfig-a012-20210326
x86_64               randconfig-a015-20210326
x86_64               randconfig-a014-20210326
x86_64               randconfig-a013-20210326
x86_64               randconfig-a016-20210326
x86_64               randconfig-a011-20210326
i386                 randconfig-a014-20210326
i386                 randconfig-a011-20210326
i386                 randconfig-a015-20210326
i386                 randconfig-a016-20210326
i386                 randconfig-a012-20210326
i386                 randconfig-a013-20210326
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210326
x86_64               randconfig-a003-20210326
x86_64               randconfig-a001-20210326
x86_64               randconfig-a006-20210326
x86_64               randconfig-a004-20210326
x86_64               randconfig-a005-20210326

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
