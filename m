Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE0B35E79C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348206AbhDMUcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:32:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:10645 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhDMUb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:31:59 -0400
IronPort-SDR: b2pv0dOOG9xYpg8IymfwChjdjlGYAdu16JydsOPYu703X7hOHKsnsMtknuzyY6B6dxs1A3DPq4
 QsNePcCN6zyw==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="192370104"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="192370104"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 13:31:37 -0700
IronPort-SDR: o0boTMZKPQs5iWS2mIv7f5Z+/OnRYxnI46bUTQ/R4h2neza933TRIxRKsBCJOihbCw1X11CXz/
 FhTRJXCtGZ7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="450536469"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2021 13:31:35 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWPh8-0001GZ-Ms; Tue, 13 Apr 2021 20:31:34 +0000
Date:   Wed, 14 Apr 2021 04:30:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 2afefec14c616d9404c9b51f4a4c7e9985936a25
Message-ID: <6075ff6e.Zz1s2U3bJiUXKAuT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 2afefec14c616d9404c9b51f4a4c7e9985936a25  Merge branch 'x86/cleanups'

elapsed time: 727m

configs tested: 161
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
riscv                            allyesconfig
i386                             allyesconfig
h8300                       h8s-sim_defconfig
arc                      axs103_smp_defconfig
powerpc                    socrates_defconfig
powerpc                   lite5200b_defconfig
mips                         cobalt_defconfig
sh                          rsk7269_defconfig
sh                             sh03_defconfig
ia64                                defconfig
openrisc                 simple_smp_defconfig
sh                           se7206_defconfig
s390                             allmodconfig
riscv             nommu_k210_sdcard_defconfig
sh                           se7343_defconfig
arm                       aspeed_g4_defconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
arm                        mvebu_v7_defconfig
mips                          ath79_defconfig
microblaze                          defconfig
arm                       cns3420vb_defconfig
ia64                          tiger_defconfig
arc                        nsim_700_defconfig
sh                          urquell_defconfig
h8300                    h8300h-sim_defconfig
arm                          collie_defconfig
powerpc                      bamboo_defconfig
arm                            xcep_defconfig
powerpc                  iss476-smp_defconfig
sh                               j2_defconfig
arm                            mmp2_defconfig
powerpc                         wii_defconfig
sh                          landisk_defconfig
csky                             alldefconfig
powerpc                     tqm8560_defconfig
arm                       spear13xx_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                           h3600_defconfig
arm                       netwinder_defconfig
arm                              alldefconfig
arm                            zeus_defconfig
openrisc                         alldefconfig
m68k                          atari_defconfig
powerpc                    gamecube_defconfig
arc                     haps_hs_smp_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
arm                     am200epdkit_defconfig
powerpc                     mpc5200_defconfig
h8300                     edosk2674_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7780_defconfig
arm                           corgi_defconfig
mips                        omega2p_defconfig
arm                          ixp4xx_defconfig
powerpc                     tqm8540_defconfig
powerpc                 linkstation_defconfig
powerpc                     pseries_defconfig
arm                           spitz_defconfig
arm                       multi_v4t_defconfig
openrisc                    or1ksim_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc834x_itx_defconfig
sparc64                             defconfig
powerpc                     sequoia_defconfig
powerpc64                        alldefconfig
arm                         bcm2835_defconfig
sh                          rsk7201_defconfig
arc                          axs103_defconfig
sh                           se7750_defconfig
sh                          polaris_defconfig
arm                         socfpga_defconfig
mips                         tb0226_defconfig
arm                          ep93xx_defconfig
m68k                            mac_defconfig
arm                  colibri_pxa270_defconfig
mips                           ci20_defconfig
powerpc                    amigaone_defconfig
powerpc                     powernv_defconfig
powerpc                       ebony_defconfig
sh                        edosk7760_defconfig
arm                           stm32_defconfig
sh                        sh7785lcr_defconfig
powerpc                 canyonlands_defconfig
sh                     magicpanelr2_defconfig
ia64                             allmodconfig
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
x86_64               randconfig-a003-20210413
x86_64               randconfig-a002-20210413
x86_64               randconfig-a001-20210413
x86_64               randconfig-a005-20210413
x86_64               randconfig-a006-20210413
x86_64               randconfig-a004-20210413
i386                 randconfig-a003-20210413
i386                 randconfig-a001-20210413
i386                 randconfig-a006-20210413
i386                 randconfig-a005-20210413
i386                 randconfig-a004-20210413
i386                 randconfig-a002-20210413
i386                 randconfig-a015-20210413
i386                 randconfig-a014-20210413
i386                 randconfig-a013-20210413
i386                 randconfig-a012-20210413
i386                 randconfig-a016-20210413
i386                 randconfig-a011-20210413
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210413
x86_64               randconfig-a015-20210413
x86_64               randconfig-a011-20210413
x86_64               randconfig-a013-20210413
x86_64               randconfig-a012-20210413
x86_64               randconfig-a016-20210413

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
