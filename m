Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBA338017B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 03:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhENBZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 21:25:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:63105 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231302AbhENBZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 21:25:45 -0400
IronPort-SDR: 46MD5wFWtEAZ1Zpn37cZCohuto61xgL+ratrVINbJbWhyoDzJLzJizMPHlsBxo8d14Lu4Ep3LH
 n6h3gWltJJIA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="179689275"
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="179689275"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 18:24:35 -0700
IronPort-SDR: VrGeCDVf+8PO3z9cudgLaCR6HiqEQQKKgVfxHDVIqMTm9KaNTHcMy0qtDjYraSopMHbWJrgrnq
 O+3hyLjbSNFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="538624916"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2021 18:24:33 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lhMZ7-0000UD-0w; Fri, 14 May 2021 01:24:33 +0000
Date:   Fri, 14 May 2021 09:24:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/nohz] BUILD SUCCESS
 0fdcccfafcffac70b452b3127cc3d981f0117655
Message-ID: <609dd138.Qy7smKVAIVhjX625%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/nohz
branch HEAD: 0fdcccfafcffac70b452b3127cc3d981f0117655  tick/nohz: Call tick_nohz_task_switch() with interrupts disabled

elapsed time: 726m

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
mips                         tb0219_defconfig
ia64                          tiger_defconfig
powerpc                      acadia_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      ep88xc_defconfig
sh                         apsh4a3a_defconfig
m68k                        mvme16x_defconfig
mips                      bmips_stb_defconfig
arm                            mmp2_defconfig
powerpc                   currituck_defconfig
sh                         ap325rxa_defconfig
mips                  maltasmvp_eva_defconfig
mips                           mtx1_defconfig
arm                           u8500_defconfig
powerpc                     taishan_defconfig
mips                        workpad_defconfig
powerpc                 linkstation_defconfig
mips                malta_qemu_32r6_defconfig
um                             i386_defconfig
arm                         lpc32xx_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                              alldefconfig
riscv                    nommu_virt_defconfig
m68k                                defconfig
mips                     decstation_defconfig
riscv                            alldefconfig
sh                          r7785rp_defconfig
sh                        edosk7760_defconfig
mips                       capcella_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v5_defconfig
powerpc                     tqm8540_defconfig
mips                          ath79_defconfig
powerpc                       maple_defconfig
powerpc                  storcenter_defconfig
ia64                             alldefconfig
arm                       mainstone_defconfig
arc                              allyesconfig
powerpc                      mgcoge_defconfig
arm                          exynos_defconfig
powerpc                     ppa8548_defconfig
sh                     magicpanelr2_defconfig
riscv                    nommu_k210_defconfig
powerpc                   lite5200b_defconfig
sh                   sh7770_generic_defconfig
powerpc                    gamecube_defconfig
arm                          simpad_defconfig
powerpc                      ppc44x_defconfig
powerpc                         ps3_defconfig
m68k                        m5307c3_defconfig
m68k                       m5275evb_defconfig
arm                          iop32x_defconfig
powerpc                 mpc8315_rdb_defconfig
h8300                       h8s-sim_defconfig
arm                      tct_hammer_defconfig
sh                          landisk_defconfig
m68k                         amcore_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
um                               alldefconfig
sh                        edosk7705_defconfig
mips                      fuloong2e_defconfig
arm                       cns3420vb_defconfig
powerpc                        fsp2_defconfig
mips                       bmips_be_defconfig
mips                        bcm63xx_defconfig
arm                     davinci_all_defconfig
sh                           sh2007_defconfig
m68k                          hp300_defconfig
arm                      footbridge_defconfig
mips                       rbtx49xx_defconfig
sh                         ecovec24_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7712_defconfig
m68k                       bvme6000_defconfig
mips                      maltaaprp_defconfig
xtensa                  nommu_kc705_defconfig
xtensa                           allyesconfig
powerpc                     sequoia_defconfig
mips                           ip27_defconfig
sh                           se7751_defconfig
arm                       spear13xx_defconfig
arc                          axs103_defconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
arm                        spear6xx_defconfig
m68k                       m5249evb_defconfig
arm                           h5000_defconfig
mips                         tb0287_defconfig
xtensa                generic_kc705_defconfig
arm                        cerfcube_defconfig
mips                 decstation_r4k_defconfig
mips                      malta_kvm_defconfig
arm                       imx_v6_v7_defconfig
arc                            hsdk_defconfig
arm                         lubbock_defconfig
sh                              ul2_defconfig
sh                           se7619_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
mips                           ip22_defconfig
arc                                 defconfig
m68k                           sun3_defconfig
arc                          axs101_defconfig
powerpc                         wii_defconfig
riscv                          rv32_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                          rb532_defconfig
h8300                               defconfig
ia64                             allyesconfig
powerpc                          allyesconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     asp8347_defconfig
powerpc                     ksi8560_defconfig
xtensa                       common_defconfig
arm                           viper_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc85xx_cds_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
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
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a006-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
x86_64               randconfig-a012-20210513
x86_64               randconfig-a015-20210513
x86_64               randconfig-a011-20210513
x86_64               randconfig-a013-20210513
x86_64               randconfig-a016-20210513
x86_64               randconfig-a014-20210513
i386                 randconfig-a016-20210513
i386                 randconfig-a014-20210513
i386                 randconfig-a011-20210513
i386                 randconfig-a015-20210513
i386                 randconfig-a012-20210513
i386                 randconfig-a013-20210513
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
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
