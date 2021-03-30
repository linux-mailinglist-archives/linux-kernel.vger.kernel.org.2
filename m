Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E4534F52B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 01:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhC3Xvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 19:51:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:32854 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhC3XvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 19:51:23 -0400
IronPort-SDR: IUulo97QG3Y8yuYvrTplaJ9FTgL6G0qqIWkIy2CArKgp5CIBmU7t8aTxjizWNmH9zhv2cfDCLK
 vZiT1Gs1XTuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179009612"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179009612"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 16:51:23 -0700
IronPort-SDR: GgJpxoGbYvo7rjLOJVUt0HXX+KMEoTLCUkHQ60cCyzn02gQiDYQcaI4CRSTISTp6DGek+A6c8s
 AJ5he0hqIeLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="516637850"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2021 16:51:21 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRO8m-0005Wy-Fh; Tue, 30 Mar 2021 23:51:20 +0000
Date:   Wed, 31 Mar 2021 07:51:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 883ccef355b910398b99dfaf96d40557479a7e9b
Message-ID: <6063b973.+Mf83iFvHF4hMD+J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 883ccef355b910398b99dfaf96d40557479a7e9b  genirq/irq_sim: Shrink devm_irq_domain_create_sim()

elapsed time: 733m

configs tested: 152
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                       imx_v4_v5_defconfig
arm                       imx_v6_v7_defconfig
sh                              ul2_defconfig
microblaze                      mmu_defconfig
mips                         db1xxx_defconfig
arm                        cerfcube_defconfig
arm                           tegra_defconfig
arm                        neponset_defconfig
sh                          urquell_defconfig
arm                            mmp2_defconfig
powerpc                      bamboo_defconfig
i386                                defconfig
powerpc                 mpc837x_mds_defconfig
arm                          lpd270_defconfig
nios2                            alldefconfig
arm                            qcom_defconfig
arm                            pleb_defconfig
arm                  colibri_pxa270_defconfig
powerpc                        icon_defconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                         virt_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
arm                       omap2plus_defconfig
powerpc                     tqm8541_defconfig
sparc64                             defconfig
mips                        jmr3927_defconfig
parisc                              defconfig
powerpc                 linkstation_defconfig
sh                         apsh4a3a_defconfig
arm                         lubbock_defconfig
arm                      footbridge_defconfig
arm                       mainstone_defconfig
sh                          landisk_defconfig
arm                   milbeaut_m10v_defconfig
m68k                           sun3_defconfig
arm                     davinci_all_defconfig
sh                                  defconfig
powerpc                      ep88xc_defconfig
sh                            hp6xx_defconfig
powerpc                    sam440ep_defconfig
mips                          rm200_defconfig
arm                           u8500_defconfig
arm                        multi_v7_defconfig
sh                          rsk7201_defconfig
powerpc                   motionpro_defconfig
arm                         socfpga_defconfig
mips                malta_qemu_32r6_defconfig
arm                        keystone_defconfig
arm                           h5000_defconfig
arm                            zeus_defconfig
m68k                       m5208evb_defconfig
mips                            ar7_defconfig
arm                       netwinder_defconfig
powerpc                     ksi8560_defconfig
powerpc                     ppa8548_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
arm                        spear6xx_defconfig
arc                         haps_hs_defconfig
mips                          malta_defconfig
powerpc                     pq2fads_defconfig
powerpc                      obs600_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ppc44x_defconfig
mips                     cu1000-neo_defconfig
sparc                       sparc64_defconfig
sh                           se7619_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      arches_defconfig
mips                        qi_lb60_defconfig
riscv                          rv32_defconfig
mips                malta_kvm_guest_defconfig
powerpc                       ebony_defconfig
sh                            migor_defconfig
mips                       lemote2f_defconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
