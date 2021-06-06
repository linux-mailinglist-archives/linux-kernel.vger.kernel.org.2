Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5965839D16F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhFFU2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 16:28:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:53405 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhFFU2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 16:28:12 -0400
IronPort-SDR: IJ1A6k82fDyHyb2qfrJoATKBp0eRJLMz3I1WMIj7uZvgb5IBPZZvOs/pi2J0zKBxLatz8T6qGd
 Fz323EvtuV9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="290158244"
X-IronPort-AV: E=Sophos;i="5.83,253,1616482800"; 
   d="scan'208";a="290158244"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 13:26:20 -0700
IronPort-SDR: kdeDkmxSfT21G5/iwUkFYCMEnJDM7uX+ujWUXW485b+z+OhrghzlyjSJtT7FfQgHSyBVyhidPU
 i0I/xdb9EKXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,253,1616482800"; 
   d="scan'208";a="447274086"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2021 13:26:18 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lpzLe-00082c-8d; Sun, 06 Jun 2021 20:26:18 +0000
Date:   Mon, 07 Jun 2021 04:25:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d2781acb34c7a82234d2b42d84d4f783415dbbe1
Message-ID: <60bd2f30.rSkvdUYE3dkvvTwY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: d2781acb34c7a82234d2b42d84d4f783415dbbe1  Merge branch 'linus'

elapsed time: 725m

configs tested: 152
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
arm                         shannon_defconfig
arm                           corgi_defconfig
arm                            lart_defconfig
sh                        sh7785lcr_defconfig
powerpc                  storcenter_defconfig
powerpc                     sequoia_defconfig
sh                             shx3_defconfig
powerpc                     kmeter1_defconfig
microblaze                          defconfig
openrisc                 simple_smp_defconfig
powerpc                      chrp32_defconfig
nds32                             allnoconfig
mips                      fuloong2e_defconfig
xtensa                    smp_lx200_defconfig
arm                       netwinder_defconfig
ia64                             allyesconfig
powerpc                      tqm8xx_defconfig
i386                             alldefconfig
powerpc                      obs600_defconfig
ia64                                defconfig
arm                        vexpress_defconfig
powerpc                 mpc834x_itx_defconfig
arm                         socfpga_defconfig
arm64                            alldefconfig
arm                        mvebu_v7_defconfig
mips                      pic32mzda_defconfig
sh                ecovec24-romimage_defconfig
mips                             allmodconfig
powerpc                     stx_gp3_defconfig
m68k                          multi_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      cm5200_defconfig
arc                            hsdk_defconfig
mips                  cavium_octeon_defconfig
arm                           sunxi_defconfig
mips                           ip22_defconfig
mips                      maltaaprp_defconfig
powerpc                     mpc5200_defconfig
arm                         hackkit_defconfig
arm                         at91_dt_defconfig
sh                               allmodconfig
mips                           ip32_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                        omega2p_defconfig
arm                             rpc_defconfig
mips                          malta_defconfig
powerpc                      ppc44x_defconfig
sh                          polaris_defconfig
powerpc                     tqm5200_defconfig
arm                           stm32_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                        multi_v7_defconfig
s390                          debug_defconfig
sh                           se7206_defconfig
alpha                            alldefconfig
mips                        bcm47xx_defconfig
riscv                          rv32_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc832x_mds_defconfig
mips                            gpr_defconfig
m68k                        m5272c3_defconfig
sh                        edosk7705_defconfig
arm                         nhk8815_defconfig
arm                       cns3420vb_defconfig
riscv             nommu_k210_sdcard_defconfig
x86_64                            allnoconfig
riscv                            allyesconfig
ia64                        generic_defconfig
arc                        nsim_700_defconfig
arm                     am200epdkit_defconfig
openrisc                    or1ksim_defconfig
sh                   secureedge5410_defconfig
sh                   sh7770_generic_defconfig
arm                  colibri_pxa270_defconfig
arm                          pxa168_defconfig
sh                           se7751_defconfig
csky                             alldefconfig
arm                        neponset_defconfig
arm                       mainstone_defconfig
arm                         s5pv210_defconfig
powerpc                          allmodconfig
mips                      maltasmvp_defconfig
powerpc                           allnoconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
powerpc                          allyesconfig
x86_64               randconfig-a002-20210606
x86_64               randconfig-a004-20210606
x86_64               randconfig-a003-20210606
x86_64               randconfig-a006-20210606
x86_64               randconfig-a005-20210606
x86_64               randconfig-a001-20210606
i386                 randconfig-a003-20210606
i386                 randconfig-a006-20210606
i386                 randconfig-a004-20210606
i386                 randconfig-a001-20210606
i386                 randconfig-a005-20210606
i386                 randconfig-a002-20210606
i386                 randconfig-a015-20210606
i386                 randconfig-a013-20210606
i386                 randconfig-a016-20210606
i386                 randconfig-a011-20210606
i386                 randconfig-a014-20210606
i386                 randconfig-a012-20210606
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210606
x86_64               randconfig-a015-20210606
x86_64               randconfig-a011-20210606
x86_64               randconfig-a014-20210606
x86_64               randconfig-a012-20210606
x86_64               randconfig-a016-20210606
x86_64               randconfig-a013-20210606

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
