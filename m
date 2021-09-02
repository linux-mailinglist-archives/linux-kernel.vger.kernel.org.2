Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA883FEA2A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbhIBHpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:45:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:52697 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233626AbhIBHo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:44:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="282726607"
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="282726607"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 00:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="520918518"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2021 00:42:26 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLhMf-0008jo-UI; Thu, 02 Sep 2021 07:42:25 +0000
Date:   Thu, 02 Sep 2021 15:41:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 1f15eb89144fdd4c881ef7181d51e989a732f4f0
Message-ID: <61308033.UHSBbqPTERrtO6Ly%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 1f15eb89144fdd4c881ef7181d51e989a732f4f0  futex: Return error code instead of assigning it without effect

elapsed time: 723m

configs tested: 182
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210831
i386                 randconfig-c001-20210901
powerpc                   bluestone_defconfig
sh                          rsk7269_defconfig
sh                         apsh4a3a_defconfig
sh                               j2_defconfig
xtensa                    smp_lx200_defconfig
ia64                            zx1_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          sdk7786_defconfig
arm                            xcep_defconfig
arm                          ep93xx_defconfig
xtensa                         virt_defconfig
riscv                            alldefconfig
m68k                          sun3x_defconfig
sh                            hp6xx_defconfig
s390                                defconfig
powerpc                    socrates_defconfig
powerpc64                           defconfig
sh                             shx3_defconfig
arm                           sunxi_defconfig
nds32                               defconfig
sh                          r7785rp_defconfig
mips                        vocore2_defconfig
powerpc                 linkstation_defconfig
sparc64                             defconfig
powerpc                     sequoia_defconfig
arm                         lpc18xx_defconfig
x86_64                           alldefconfig
arm                      integrator_defconfig
mips                         tb0287_defconfig
sh                          landisk_defconfig
sh                   sh7724_generic_defconfig
mips                           jazz_defconfig
arc                        nsimosci_defconfig
sh                          lboxre2_defconfig
arm                         cm_x300_defconfig
arm                           corgi_defconfig
powerpc                      acadia_defconfig
arm                          moxart_defconfig
sh                        edosk7760_defconfig
arm                          pxa168_defconfig
sh                        edosk7705_defconfig
mips                   sb1250_swarm_defconfig
arm                         bcm2835_defconfig
arm                        mini2440_defconfig
xtensa                          iss_defconfig
sh                        dreamcast_defconfig
nios2                         3c120_defconfig
sh                          urquell_defconfig
mips                        maltaup_defconfig
arm                          pxa910_defconfig
powerpc                  iss476-smp_defconfig
mips                     decstation_defconfig
arm                           spitz_defconfig
powerpc                     tqm8540_defconfig
mips                            e55_defconfig
arm                            mps2_defconfig
sh                           se7750_defconfig
arm                       aspeed_g5_defconfig
sparc64                          alldefconfig
sh                           sh2007_defconfig
sh                        sh7785lcr_defconfig
arm                     davinci_all_defconfig
powerpc                     tqm5200_defconfig
riscv                    nommu_virt_defconfig
arm                           h5000_defconfig
arc                              alldefconfig
sh                              ul2_defconfig
powerpc                  mpc866_ads_defconfig
arm                           h3600_defconfig
arm                         s5pv210_defconfig
sh                           se7712_defconfig
powerpc                      bamboo_defconfig
ia64                             alldefconfig
powerpc                 mpc837x_rdb_defconfig
mips                           ip28_defconfig
mips                        omega2p_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
powerpc                      pasemi_defconfig
mips                  decstation_64_defconfig
ia64                      gensparse_defconfig
mips                        nlm_xlp_defconfig
arm                          imote2_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210831
x86_64               randconfig-a001-20210831
x86_64               randconfig-a003-20210831
x86_64               randconfig-a002-20210831
x86_64               randconfig-a004-20210831
x86_64               randconfig-a006-20210831
i386                 randconfig-a005-20210831
i386                 randconfig-a002-20210831
i386                 randconfig-a003-20210831
i386                 randconfig-a006-20210831
i386                 randconfig-a004-20210831
i386                 randconfig-a001-20210831
x86_64               randconfig-a016-20210901
x86_64               randconfig-a011-20210901
x86_64               randconfig-a012-20210901
x86_64               randconfig-a015-20210901
x86_64               randconfig-a014-20210901
x86_64               randconfig-a013-20210901
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210901
mips                 randconfig-c004-20210901
x86_64               randconfig-c007-20210901
powerpc              randconfig-c003-20210901
i386                 randconfig-c001-20210901
arm                  randconfig-c002-20210901
riscv                randconfig-c006-20210901
i386                 randconfig-c001-20210831
s390                 randconfig-c005-20210831
riscv                randconfig-c006-20210831
powerpc              randconfig-c003-20210831
mips                 randconfig-c004-20210831
arm                  randconfig-c002-20210831
x86_64               randconfig-c007-20210831
x86_64               randconfig-a014-20210831
x86_64               randconfig-a015-20210831
x86_64               randconfig-a013-20210831
x86_64               randconfig-a016-20210831
x86_64               randconfig-a012-20210831
x86_64               randconfig-a011-20210831
i386                 randconfig-a016-20210831
i386                 randconfig-a011-20210831
i386                 randconfig-a015-20210831
i386                 randconfig-a014-20210831
i386                 randconfig-a012-20210831
i386                 randconfig-a013-20210831
hexagon              randconfig-r045-20210901
hexagon              randconfig-r041-20210901
s390                 randconfig-r044-20210831
hexagon              randconfig-r041-20210831
hexagon              randconfig-r045-20210831
riscv                randconfig-r042-20210831

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
