Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9131735D7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhDMGPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:15:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:61550 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhDMGOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:14:43 -0400
IronPort-SDR: QU33Gi4BzoExQulcpxGl5KghkuTE1jbCcERag+ODj5U6Jimef59Vww0Adf0PpSyTjm/IbdXmqy
 Upk2lZT6qCHg==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194379564"
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="194379564"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 23:14:22 -0700
IronPort-SDR: pvMzk91KOL0b5qys4+RT0LFrCLhRQmEdbd28n99jBB1+lWvi6gOIKaNwqP/tEAmOMRgodSdnzd
 SwfOvDU4tb7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="611633913"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2021 23:14:20 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWCJV-0000rY-UX; Tue, 13 Apr 2021 06:14:17 +0000
Date:   Tue, 13 Apr 2021 14:14:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 523caed9efbb049339706b124185c9358c1b6477
Message-ID: <607536b6.4evrQhfhDwxJ5ds/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 523caed9efbb049339706b124185c9358c1b6477  x86/sgx: Mark sgx_vepc_vm_ops static

elapsed time: 725m

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
i386                             allyesconfig
riscv                            allyesconfig
nios2                            allyesconfig
sh                         microdev_defconfig
sh                             espt_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           ip32_defconfig
arm                        oxnas_v6_defconfig
h8300                       h8s-sim_defconfig
arc                      axs103_smp_defconfig
powerpc                    socrates_defconfig
powerpc                   lite5200b_defconfig
riscv                             allnoconfig
mips                         cobalt_defconfig
mips                         tb0219_defconfig
mips                           mtx1_defconfig
m68k                       m5249evb_defconfig
mips                          malta_defconfig
arm                          pxa168_defconfig
arc                          axs103_defconfig
openrisc                         alldefconfig
mips                          rm200_defconfig
powerpc                     skiroot_defconfig
arm                            mps2_defconfig
arm                       aspeed_g4_defconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
arm                        mvebu_v7_defconfig
mips                          ath79_defconfig
microblaze                          defconfig
powerpc                      pcm030_defconfig
arm                         mv78xx0_defconfig
arm                          exynos_defconfig
arm                       multi_v4t_defconfig
mips                           ip22_defconfig
ia64                          tiger_defconfig
powerpc                     tqm8555_defconfig
powerpc                     sbc8548_defconfig
arm                         assabet_defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
sh                          urquell_defconfig
powerpc                 linkstation_defconfig
mips                      malta_kvm_defconfig
arm                             rpc_defconfig
powerpc                      ppc64e_defconfig
arm                           sama5_defconfig
sh                        edosk7760_defconfig
sparc64                             defconfig
powerpc                     tqm8548_defconfig
powerpc                        cell_defconfig
sh                          rsk7201_defconfig
sh                   sh7724_generic_defconfig
sh                             sh03_defconfig
arm                         s5pv210_defconfig
powerpc                     tqm8540_defconfig
sh                   rts7751r2dplus_defconfig
mips                      maltaaprp_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7712_defconfig
powerpc                      obs600_defconfig
mips                      bmips_stb_defconfig
sh                           sh2007_defconfig
sh                           se7619_defconfig
arm                          pxa910_defconfig
um                               allmodconfig
arm                            qcom_defconfig
mips                        omega2p_defconfig
arm                            xcep_defconfig
mips                         mpc30x_defconfig
powerpc                     pq2fads_defconfig
sh                           se7751_defconfig
m68k                          amiga_defconfig
arm                         vf610m4_defconfig
arm                         lpc32xx_defconfig
h8300                            alldefconfig
mips                           ip27_defconfig
sh                          r7785rp_defconfig
mips                     loongson1c_defconfig
arm                          iop32x_defconfig
sh                           se7343_defconfig
powerpc                  iss476-smp_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210412
i386                 randconfig-a001-20210412
i386                 randconfig-a006-20210412
i386                 randconfig-a005-20210412
i386                 randconfig-a004-20210412
i386                 randconfig-a002-20210412
i386                 randconfig-a003-20210413
i386                 randconfig-a001-20210413
i386                 randconfig-a006-20210413
i386                 randconfig-a005-20210413
i386                 randconfig-a004-20210413
i386                 randconfig-a002-20210413
x86_64               randconfig-a014-20210412
x86_64               randconfig-a015-20210412
x86_64               randconfig-a011-20210412
x86_64               randconfig-a013-20210412
x86_64               randconfig-a012-20210412
x86_64               randconfig-a016-20210412
i386                 randconfig-a015-20210412
i386                 randconfig-a014-20210412
i386                 randconfig-a013-20210412
i386                 randconfig-a012-20210412
i386                 randconfig-a016-20210412
i386                 randconfig-a011-20210412
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210412
x86_64               randconfig-a002-20210412
x86_64               randconfig-a001-20210412
x86_64               randconfig-a005-20210412
x86_64               randconfig-a006-20210412
x86_64               randconfig-a004-20210412

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
