Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916CD454483
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 11:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhKQKDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 05:03:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:37359 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235778AbhKQKDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 05:03:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="214637305"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="214637305"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 02:00:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="454589498"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2021 02:00:47 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnHkE-0001VO-Gg; Wed, 17 Nov 2021 10:00:46 +0000
Date:   Wed, 17 Nov 2021 17:59:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 ac5d272a0ad0419f52e08c91953356e32b075af7
Message-ID: <6194d29e.1lHM3aSUx81Iw7Iv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: ac5d272a0ad0419f52e08c91953356e32b075af7  x86/sgx: Fix free page accounting

elapsed time: 721m

configs tested: 187
configs skipped: 70

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211117
i386                 randconfig-c001-20211116
powerpc                 mpc836x_rdk_defconfig
arm                             pxa_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                          r7785rp_defconfig
s390                             allmodconfig
microblaze                      mmu_defconfig
mips                         tb0287_defconfig
sh                   sh7724_generic_defconfig
m68k                       m5249evb_defconfig
arm                        cerfcube_defconfig
powerpc                       eiger_defconfig
s390                       zfcpdump_defconfig
arm                          gemini_defconfig
powerpc                      mgcoge_defconfig
ia64                          tiger_defconfig
m68k                        mvme16x_defconfig
sh                               j2_defconfig
powerpc                     asp8347_defconfig
arm                           viper_defconfig
mips                           ci20_defconfig
mips                     loongson2k_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                         cobalt_defconfig
openrisc                         alldefconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc8272_ads_defconfig
sh                           se7712_defconfig
mips                          rb532_defconfig
arm                          simpad_defconfig
powerpc                      walnut_defconfig
arm                             mxs_defconfig
mips                          ath79_defconfig
powerpc                      makalu_defconfig
mips                   sb1250_swarm_defconfig
i386                             alldefconfig
mips                       capcella_defconfig
powerpc                     tqm8555_defconfig
arm                             ezx_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
arc                          axs103_defconfig
powerpc                         ps3_defconfig
ia64                        generic_defconfig
m68k                          hp300_defconfig
arm                            qcom_defconfig
arm                      tct_hammer_defconfig
arm                        oxnas_v6_defconfig
powerpc                     mpc5200_defconfig
powerpc                   motionpro_defconfig
arm                       aspeed_g5_defconfig
sh                           se7619_defconfig
arm                              alldefconfig
mips                         rt305x_defconfig
powerpc                 mpc832x_mds_defconfig
riscv                             allnoconfig
arm                            mps2_defconfig
xtensa                  cadence_csp_defconfig
arc                         haps_hs_defconfig
sh                        apsh4ad0a_defconfig
alpha                            allyesconfig
arm                         s3c2410_defconfig
arc                     nsimosci_hs_defconfig
nios2                         10m50_defconfig
powerpc                  storcenter_defconfig
xtensa                           alldefconfig
arm                         nhk8815_defconfig
arm                  randconfig-c002-20211117
arm                  randconfig-c002-20211116
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20211117
x86_64               randconfig-a003-20211117
x86_64               randconfig-a002-20211117
x86_64               randconfig-a001-20211117
x86_64               randconfig-a006-20211117
x86_64               randconfig-a004-20211117
i386                 randconfig-a006-20211117
i386                 randconfig-a003-20211117
i386                 randconfig-a005-20211117
i386                 randconfig-a001-20211117
i386                 randconfig-a004-20211117
i386                 randconfig-a002-20211117
x86_64               randconfig-a015-20211116
x86_64               randconfig-a013-20211116
x86_64               randconfig-a012-20211116
x86_64               randconfig-a011-20211116
x86_64               randconfig-a016-20211116
x86_64               randconfig-a014-20211116
i386                 randconfig-a014-20211116
i386                 randconfig-a016-20211116
i386                 randconfig-a012-20211116
i386                 randconfig-a013-20211116
i386                 randconfig-a011-20211116
i386                 randconfig-a015-20211116
arc                  randconfig-r043-20211116
s390                 randconfig-r044-20211116
riscv                randconfig-r042-20211116
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211117
i386                 randconfig-c001-20211117
arm                  randconfig-c002-20211117
riscv                randconfig-c006-20211117
powerpc              randconfig-c003-20211117
s390                 randconfig-c005-20211117
mips                 randconfig-c004-20211117
x86_64               randconfig-c007-20211116
i386                 randconfig-c001-20211116
arm                  randconfig-c002-20211116
riscv                randconfig-c006-20211116
powerpc              randconfig-c003-20211116
s390                 randconfig-c005-20211116
mips                 randconfig-c004-20211116
x86_64               randconfig-a005-20211116
x86_64               randconfig-a003-20211116
x86_64               randconfig-a001-20211116
x86_64               randconfig-a002-20211116
x86_64               randconfig-a006-20211116
x86_64               randconfig-a004-20211116
i386                 randconfig-a006-20211116
i386                 randconfig-a003-20211116
i386                 randconfig-a005-20211116
i386                 randconfig-a001-20211116
i386                 randconfig-a004-20211116
i386                 randconfig-a002-20211116
x86_64               randconfig-a015-20211117
x86_64               randconfig-a013-20211117
x86_64               randconfig-a011-20211117
x86_64               randconfig-a012-20211117
x86_64               randconfig-a016-20211117
x86_64               randconfig-a014-20211117
i386                 randconfig-a014-20211117
i386                 randconfig-a016-20211117
i386                 randconfig-a012-20211117
i386                 randconfig-a013-20211117
i386                 randconfig-a011-20211117
i386                 randconfig-a015-20211117
hexagon              randconfig-r045-20211116
hexagon              randconfig-r041-20211116
hexagon              randconfig-r045-20211117
hexagon              randconfig-r041-20211117
s390                 randconfig-r044-20211117
riscv                randconfig-r042-20211117

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
