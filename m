Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E01438DDAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 01:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhEWXLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 19:11:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:2585 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231980AbhEWXLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 19:11:20 -0400
IronPort-SDR: 5/Mcnj40q7Y8qhPW8btGCLcuv5Ffc4g4KWaCPnVe607/fX8rGjfynwoEZesWXgsE5FahmcpneJ
 IHL/1D2Pdz+A==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="181456656"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="181456656"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 16:09:52 -0700
IronPort-SDR: +Kb++Tg+/mjZQxK5jJHwloA1fukmoT4kCCjny+t2IGrPj/mAaZBYAzqnXZXDT9T6bnFTlgYCQY
 rTMj6snp0JuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="475540459"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 May 2021 16:09:51 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lkxEE-000102-Vd; Sun, 23 May 2021 23:09:50 +0000
Date:   Mon, 24 May 2021 07:09:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5bb6f82b078c92e1e1f19502e90d6e951d5e01c2
Message-ID: <60aae090.o8ym5h2re1jeIfMB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5bb6f82b078c92e1e1f19502e90d6e951d5e01c2  Merge branch 'efi/core'

elapsed time: 724m

configs tested: 188
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                               j2_defconfig
arm                            pleb_defconfig
arm                         lubbock_defconfig
arm                        mvebu_v7_defconfig
sh                           se7619_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      mgcoge_defconfig
ia64                        generic_defconfig
arm                         s5pv210_defconfig
arm                          pxa168_defconfig
powerpc                  iss476-smp_defconfig
h8300                            allyesconfig
powerpc                      chrp32_defconfig
arm                         hackkit_defconfig
openrisc                            defconfig
openrisc                 simple_smp_defconfig
powerpc                     tqm8541_defconfig
xtensa                         virt_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                            lart_defconfig
sh                         microdev_defconfig
mips                       capcella_defconfig
arm                          lpd270_defconfig
powerpc                      ppc64e_defconfig
riscv                    nommu_virt_defconfig
sh                            shmin_defconfig
xtensa                           alldefconfig
mips                      loongson3_defconfig
arm                         orion5x_defconfig
arc                          axs101_defconfig
riscv                    nommu_k210_defconfig
arm                           stm32_defconfig
powerpc                       ppc64_defconfig
arm                           h5000_defconfig
sh                              ul2_defconfig
nios2                         3c120_defconfig
mips                     loongson2k_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc836x_mds_defconfig
sh                          urquell_defconfig
sparc64                             defconfig
mips                          rb532_defconfig
mips                           ip27_defconfig
sh                          kfr2r09_defconfig
mips                malta_qemu_32r6_defconfig
arm64                            alldefconfig
sh                                  defconfig
m68k                       m5475evb_defconfig
arm                        spear6xx_defconfig
um                             i386_defconfig
xtensa                              defconfig
sh                        edosk7705_defconfig
sh                          landisk_defconfig
arm                      footbridge_defconfig
xtensa                       common_defconfig
arm                          collie_defconfig
sh                          rsk7201_defconfig
arm                      pxa255-idp_defconfig
m68k                            mac_defconfig
powerpc                          allmodconfig
m68k                        m5272c3_defconfig
sh                           se7206_defconfig
mips                          rm200_defconfig
arm                        oxnas_v6_defconfig
arm                       cns3420vb_defconfig
m68k                          sun3x_defconfig
arm                           viper_defconfig
powerpc                 mpc8560_ads_defconfig
sh                           sh2007_defconfig
um                            kunit_defconfig
arc                         haps_hs_defconfig
mips                     loongson1c_defconfig
sh                   sh7770_generic_defconfig
mips                        vocore2_defconfig
arm                         nhk8815_defconfig
powerpc                      pasemi_defconfig
powerpc                      obs600_defconfig
mips                 decstation_r4k_defconfig
arc                     haps_hs_smp_defconfig
x86_64                           alldefconfig
arm                         vf610m4_defconfig
h8300                               defconfig
powerpc                     akebono_defconfig
riscv                          rv32_defconfig
sh                        sh7757lcr_defconfig
h8300                     edosk2674_defconfig
powerpc                      pcm030_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                          atari_defconfig
powerpc                      katmai_defconfig
sh                     sh7710voipgw_defconfig
sh                          rsk7203_defconfig
ia64                          tiger_defconfig
mips                          ath25_defconfig
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
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210524
x86_64               randconfig-a001-20210524
x86_64               randconfig-a006-20210524
x86_64               randconfig-a003-20210524
x86_64               randconfig-a004-20210524
x86_64               randconfig-a002-20210524
i386                 randconfig-a001-20210523
i386                 randconfig-a005-20210523
i386                 randconfig-a002-20210523
i386                 randconfig-a003-20210523
i386                 randconfig-a004-20210523
i386                 randconfig-a006-20210523
i386                 randconfig-a001-20210524
i386                 randconfig-a002-20210524
i386                 randconfig-a005-20210524
i386                 randconfig-a006-20210524
i386                 randconfig-a004-20210524
i386                 randconfig-a003-20210524
x86_64               randconfig-a013-20210523
x86_64               randconfig-a014-20210523
x86_64               randconfig-a012-20210523
x86_64               randconfig-a016-20210523
x86_64               randconfig-a015-20210523
x86_64               randconfig-a011-20210523
i386                 randconfig-a016-20210523
i386                 randconfig-a011-20210523
i386                 randconfig-a015-20210523
i386                 randconfig-a012-20210523
i386                 randconfig-a014-20210523
i386                 randconfig-a013-20210523
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210523
x86_64               randconfig-b001-20210524
x86_64               randconfig-a006-20210523
x86_64               randconfig-a001-20210523
x86_64               randconfig-a005-20210523
x86_64               randconfig-a003-20210523
x86_64               randconfig-a004-20210523
x86_64               randconfig-a002-20210523
x86_64               randconfig-a013-20210524
x86_64               randconfig-a012-20210524
x86_64               randconfig-a014-20210524
x86_64               randconfig-a016-20210524
x86_64               randconfig-a015-20210524
x86_64               randconfig-a011-20210524

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
