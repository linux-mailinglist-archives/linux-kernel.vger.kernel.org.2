Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794A9343059
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 00:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhCTXlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 19:41:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:27671 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhCTXky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 19:40:54 -0400
IronPort-SDR: ZBsOYaYUEsYAJ0vjhYfE7sQkY2c2WgW0cibWXE5Mz/r2hOpR1Lv8K0Sehy9y7StFN5Cpawb5ye
 ReZSQG4InJew==
X-IronPort-AV: E=McAfee;i="6000,8403,9929"; a="177217357"
X-IronPort-AV: E=Sophos;i="5.81,265,1610438400"; 
   d="scan'208";a="177217357"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2021 16:40:53 -0700
IronPort-SDR: /L0oo5zcI+UAwOUyw9PrElbj6mrRR7nH1qn5i+6+YfdzvycBCoGJSsq8AMMLbxjLIqwOmf7Y5G
 3Fg2xJRVDS/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,265,1610438400"; 
   d="scan'208";a="407287046"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Mar 2021 16:40:52 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lNlD9-0002q1-SU; Sat, 20 Mar 2021 23:40:51 +0000
Date:   Sun, 21 Mar 2021 07:40:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 2b7cc48df95a36ecb6dfec219ae1e1f1148e6dac
Message-ID: <605687dd.8yp2ISjrYBBhZwfw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 2b7cc48df95a36ecb6dfec219ae1e1f1148e6dac  Merge branch 'efi/urgent'

elapsed time: 725m

configs tested: 163
configs skipped: 2

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
sh                           se7722_defconfig
sh                           se7724_defconfig
arm                            pleb_defconfig
xtensa                    smp_lx200_defconfig
sparc64                          alldefconfig
mips                  decstation_64_defconfig
sh                          rsk7203_defconfig
sh                          kfr2r09_defconfig
arc                            hsdk_defconfig
mips                       rbtx49xx_defconfig
powerpc                     stx_gp3_defconfig
sh                   rts7751r2dplus_defconfig
arm                       aspeed_g4_defconfig
arm                        clps711x_defconfig
mips                       bmips_be_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7785lcr_defconfig
m68k                            q40_defconfig
arm                   milbeaut_m10v_defconfig
arm                        neponset_defconfig
arm                        multi_v7_defconfig
sh                        edosk7705_defconfig
riscv                    nommu_k210_defconfig
m68k                        mvme16x_defconfig
mips                          malta_defconfig
sparc                       sparc64_defconfig
s390                                defconfig
sh                      rts7751r2d1_defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                           sama5_defconfig
powerpc                    klondike_defconfig
sh                          lboxre2_defconfig
powerpc                       maple_defconfig
arm                       mainstone_defconfig
sparc64                             defconfig
powerpc                      acadia_defconfig
powerpc                      pmac32_defconfig
arm                          iop32x_defconfig
mips                        bcm47xx_defconfig
sh                             shx3_defconfig
sparc                               defconfig
powerpc                   lite5200b_defconfig
mips                          ath25_defconfig
powerpc                        cell_defconfig
powerpc                     tqm8560_defconfig
arm                    vt8500_v6_v7_defconfig
m68k                           sun3_defconfig
ia64                            zx1_defconfig
powerpc                     skiroot_defconfig
sh                     magicpanelr2_defconfig
openrisc                         alldefconfig
arm                          collie_defconfig
powerpc                      makalu_defconfig
m68k                          multi_defconfig
mips                        workpad_defconfig
arm                         axm55xx_defconfig
arm64                            alldefconfig
mips                      maltaaprp_defconfig
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
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210321
i386                 randconfig-a004-20210321
i386                 randconfig-a001-20210321
i386                 randconfig-a002-20210321
i386                 randconfig-a006-20210321
i386                 randconfig-a005-20210321
i386                 randconfig-a004-20210320
i386                 randconfig-a003-20210320
i386                 randconfig-a001-20210320
i386                 randconfig-a002-20210320
i386                 randconfig-a006-20210320
i386                 randconfig-a005-20210320
x86_64               randconfig-a002-20210321
x86_64               randconfig-a003-20210321
x86_64               randconfig-a006-20210321
x86_64               randconfig-a001-20210321
x86_64               randconfig-a005-20210321
x86_64               randconfig-a004-20210321
x86_64               randconfig-a012-20210320
x86_64               randconfig-a015-20210320
x86_64               randconfig-a013-20210320
x86_64               randconfig-a014-20210320
x86_64               randconfig-a016-20210320
x86_64               randconfig-a011-20210320
i386                 randconfig-a014-20210320
i386                 randconfig-a011-20210320
i386                 randconfig-a015-20210320
i386                 randconfig-a016-20210320
i386                 randconfig-a013-20210320
i386                 randconfig-a012-20210320
i386                 randconfig-a014-20210321
i386                 randconfig-a011-20210321
i386                 randconfig-a015-20210321
i386                 randconfig-a016-20210321
i386                 randconfig-a013-20210321
i386                 randconfig-a012-20210321
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210320
x86_64               randconfig-a003-20210320
x86_64               randconfig-a001-20210320
x86_64               randconfig-a006-20210320
x86_64               randconfig-a005-20210320
x86_64               randconfig-a004-20210320
x86_64               randconfig-a006-20210318
x86_64               randconfig-a001-20210318
x86_64               randconfig-a005-20210318
x86_64               randconfig-a002-20210318
x86_64               randconfig-a003-20210318
x86_64               randconfig-a004-20210318
x86_64               randconfig-a012-20210321
x86_64               randconfig-a015-20210321
x86_64               randconfig-a013-20210321
x86_64               randconfig-a014-20210321
x86_64               randconfig-a011-20210321
x86_64               randconfig-a016-20210321

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
