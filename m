Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308DA35A96A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 02:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhDJALf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 20:11:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:33086 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235208AbhDJALd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 20:11:33 -0400
IronPort-SDR: uNhT08YyFgTve2RsOpak7KoFgT6BhCr8EuQPfMtsqOiblVtDjqZ4XFTTyQzlcTW5zjyKI7TXKO
 tizwg8RqCurQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="173950377"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="173950377"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 17:11:20 -0700
IronPort-SDR: JDusDX4tbjF1f/SzvWG1/7L8e31nWX2/D45kxxVOFeLo0R5gKzdQ3X/GPSd6XyCX4tRxfDehWQ
 JUGeDb7Lzh3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="531175118"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Apr 2021 17:11:18 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lV1DX-000HYY-Rc; Sat, 10 Apr 2021 00:11:15 +0000
Date:   Sat, 10 Apr 2021 08:10:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 632a1c209b8773cb0119fe3aada9f1db14fa357c
Message-ID: <6070ed00.to8JPh7ivIRDU7xO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 632a1c209b8773cb0119fe3aada9f1db14fa357c  x86/traps: Correct exc_general_protection() and math_error() return paths

elapsed time: 725m

configs tested: 223
configs skipped: 4

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
sh                          polaris_defconfig
arc                              allyesconfig
powerpc                     asp8347_defconfig
m68k                          multi_defconfig
arm64                            alldefconfig
powerpc                      bamboo_defconfig
m68k                       bvme6000_defconfig
mips                      pistachio_defconfig
openrisc                 simple_smp_defconfig
openrisc                  or1klitex_defconfig
xtensa                    xip_kc705_defconfig
arm                            hisi_defconfig
powerpc                      pmac32_defconfig
arm                          lpd270_defconfig
sh                           se7750_defconfig
powerpc                       ebony_defconfig
mips                           xway_defconfig
powerpc                     mpc83xx_defconfig
ia64                      gensparse_defconfig
arm                          simpad_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     pq2fads_defconfig
mips                    maltaup_xpa_defconfig
ia64                             allyesconfig
mips                          ath79_defconfig
m68k                                defconfig
arm                         shannon_defconfig
powerpc                  mpc866_ads_defconfig
m68k                             alldefconfig
arc                           tb10x_defconfig
sh                           se7722_defconfig
m68k                        m5307c3_defconfig
powerpc                       ppc64_defconfig
arm                          gemini_defconfig
powerpc                     ep8248e_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    socrates_defconfig
sh                           se7751_defconfig
arm                         s3c6400_defconfig
sh                         apsh4a3a_defconfig
mips                        bcm63xx_defconfig
powerpc                      tqm8xx_defconfig
openrisc                         alldefconfig
arm                            mmp2_defconfig
um                             i386_defconfig
powerpc64                           defconfig
sh                             espt_defconfig
arm                         vf610m4_defconfig
mips                          rb532_defconfig
mips                            gpr_defconfig
arc                     haps_hs_smp_defconfig
arm                             mxs_defconfig
powerpc                      arches_defconfig
sh                        dreamcast_defconfig
arm                             rpc_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
microblaze                      mmu_defconfig
sh                                  defconfig
powerpc                 mpc8313_rdb_defconfig
arm                            dove_defconfig
arm                  colibri_pxa270_defconfig
sh                           se7619_defconfig
powerpc                      chrp32_defconfig
arm                         socfpga_defconfig
arm                            pleb_defconfig
arm                            xcep_defconfig
arm                          ep93xx_defconfig
mips                            e55_defconfig
mips                        workpad_defconfig
mips                       bmips_be_defconfig
sh                            shmin_defconfig
arm                        multi_v7_defconfig
arm                       imx_v4_v5_defconfig
mips                           ip27_defconfig
mips                         mpc30x_defconfig
s390                                defconfig
riscv                    nommu_k210_defconfig
arc                            hsdk_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        multi_v5_defconfig
h8300                               defconfig
mips                         tb0287_defconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
arm                        spear6xx_defconfig
sh                            titan_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         cm_x300_defconfig
m68k                       m5475evb_defconfig
mips                         bigsur_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                       m5249evb_defconfig
ia64                            zx1_defconfig
arm                          ixp4xx_defconfig
arm                        shmobile_defconfig
arm                         s3c2410_defconfig
m68k                        stmark2_defconfig
mips                     cu1830-neo_defconfig
arc                 nsimosci_hs_smp_defconfig
arc                        nsim_700_defconfig
arm                       netwinder_defconfig
sh                           se7712_defconfig
mips                        qi_lb60_defconfig
powerpc                     pseries_defconfig
mips                             allyesconfig
powerpc                   bluestone_defconfig
arc                                 defconfig
mips                      loongson3_defconfig
arm                  colibri_pxa300_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                         amcore_defconfig
microblaze                          defconfig
sh                        sh7785lcr_defconfig
arc                          axs101_defconfig
sh                          sdk7780_defconfig
arm                          badge4_defconfig
s390                             allyesconfig
arm                         at91_dt_defconfig
powerpc                 mpc834x_mds_defconfig
arm                             pxa_defconfig
powerpc                      walnut_defconfig
mips                       lemote2f_defconfig
sh                      rts7751r2d1_defconfig
m68k                       m5208evb_defconfig
openrisc                            defconfig
ia64                          tiger_defconfig
sh                   sh7770_generic_defconfig
powerpc                 canyonlands_defconfig
h8300                     edosk2674_defconfig
powerpc                      pasemi_defconfig
powerpc                     ksi8560_defconfig
powerpc                       eiger_defconfig
mips                       rbtx49xx_defconfig
xtensa                  audio_kc705_defconfig
arm                      jornada720_defconfig
sh                           se7780_defconfig
sh                          lboxre2_defconfig
sh                          r7785rp_defconfig
powerpc                     sbc8548_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
mips                     loongson1b_defconfig
arm                         mv78xx0_defconfig
arm                       multi_v4t_defconfig
xtensa                  cadence_csp_defconfig
sh                   secureedge5410_defconfig
arm                       versatile_defconfig
arc                        nsimosci_defconfig
sh                               alldefconfig
arm                          collie_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210409
i386                 randconfig-a003-20210409
i386                 randconfig-a001-20210409
i386                 randconfig-a004-20210409
i386                 randconfig-a002-20210409
i386                 randconfig-a005-20210409
x86_64               randconfig-a014-20210409
x86_64               randconfig-a015-20210409
x86_64               randconfig-a012-20210409
x86_64               randconfig-a011-20210409
x86_64               randconfig-a013-20210409
x86_64               randconfig-a016-20210409
i386                 randconfig-a014-20210409
i386                 randconfig-a011-20210409
i386                 randconfig-a016-20210409
i386                 randconfig-a012-20210409
i386                 randconfig-a013-20210409
i386                 randconfig-a015-20210409
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-a004-20210409
x86_64               randconfig-a005-20210409
x86_64               randconfig-a003-20210409
x86_64               randconfig-a001-20210409
x86_64               randconfig-a002-20210409
x86_64               randconfig-a006-20210409

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
