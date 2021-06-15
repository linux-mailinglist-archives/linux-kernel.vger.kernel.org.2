Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7D3A8C42
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhFOXMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:12:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:40925 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFOXMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:12:03 -0400
IronPort-SDR: LJXbWeXxn62n0uRndfJyzl0vD0WDI5j3z5Kk9fFz4KbstEC7Y3wNRmaiKlmwdW1cCJh5Uus8aE
 1NOSPllY5T/A==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="193201923"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="193201923"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 16:09:58 -0700
IronPort-SDR: 6wz0HwKpfFbmWBVtbb+tRgJ3JoS0cT2G/Cdj1MDWqcc705r8Mzg4CSGMq4OivTbBwtrolvKcer
 TTvfguHh9XQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="484646732"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2021 16:09:56 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltIBv-0000gu-Vb; Tue, 15 Jun 2021 23:09:55 +0000
Date:   Wed, 16 Jun 2021 07:09:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 07570cef5e5c3fcec40f82a9075abb4c1da63319
Message-ID: <60c9333a.JrGdqtJVArnHc77V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 07570cef5e5c3fcec40f82a9075abb4c1da63319  x86/sev: Propagate #GP if getting linear instruction address failed

elapsed time: 722m

configs tested: 171
configs skipped: 69

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      chrp32_defconfig
powerpc                  mpc866_ads_defconfig
mips                     cu1000-neo_defconfig
ia64                        generic_defconfig
arm                       versatile_defconfig
arm                         lpc32xx_defconfig
arm                         socfpga_defconfig
powerpc                     sbc8548_defconfig
arm                  colibri_pxa270_defconfig
m68k                        stmark2_defconfig
powerpc                        icon_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                   bluestone_defconfig
sh                          r7785rp_defconfig
sh                        sh7785lcr_defconfig
m68k                          hp300_defconfig
ia64                                defconfig
powerpc                     tqm8560_defconfig
mips                        vocore2_defconfig
mips                         cobalt_defconfig
mips                        bcm63xx_defconfig
powerpc                     ep8248e_defconfig
powerpc                        cell_defconfig
powerpc                     mpc512x_defconfig
mips                      maltaaprp_defconfig
h8300                            allyesconfig
mips                  cavium_octeon_defconfig
um                           x86_64_defconfig
arm                          pcm027_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         s3c2410_defconfig
arm                         nhk8815_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
arm                        multi_v7_defconfig
arm                            lart_defconfig
sh                          sdk7786_defconfig
xtensa                    smp_lx200_defconfig
arm                          collie_defconfig
powerpc                 mpc85xx_cds_defconfig
nds32                               defconfig
powerpc                          g5_defconfig
arm                            hisi_defconfig
xtensa                          iss_defconfig
powerpc                     kmeter1_defconfig
mips                      fuloong2e_defconfig
arm                      tct_hammer_defconfig
m68k                       m5249evb_defconfig
arm                   milbeaut_m10v_defconfig
sh                            shmin_defconfig
m68k                        m5307c3_defconfig
arm                       aspeed_g5_defconfig
mips                      bmips_stb_defconfig
powerpc                        fsp2_defconfig
ia64                             alldefconfig
i386                                defconfig
sparc                       sparc32_defconfig
powerpc64                        alldefconfig
mips                 decstation_r4k_defconfig
powerpc                   lite5200b_defconfig
arm                        neponset_defconfig
mips                           ip27_defconfig
m68k                        mvme16x_defconfig
arm                           omap1_defconfig
mips                             allmodconfig
arm                         palmz72_defconfig
arc                     nsimosci_hs_defconfig
arm                            zeus_defconfig
m68k                          atari_defconfig
arm                        mvebu_v5_defconfig
ia64                            zx1_defconfig
powerpc                     ksi8560_defconfig
h8300                       h8s-sim_defconfig
x86_64                           allyesconfig
arm                           u8500_defconfig
powerpc                       holly_defconfig
parisc                           alldefconfig
sh                             espt_defconfig
arm                      pxa255-idp_defconfig
csky                                defconfig
m68k                       m5275evb_defconfig
arm                        keystone_defconfig
powerpc                mpc7448_hpc2_defconfig
s390                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                        warp_defconfig
powerpc                      ppc44x_defconfig
powerpc                     mpc5200_defconfig
m68k                             alldefconfig
sh                        dreamcast_defconfig
arm                         hackkit_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      katmai_defconfig
arm                           viper_defconfig
s390                          debug_defconfig
sparc                       sparc64_defconfig
riscv                          rv32_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210615
x86_64               randconfig-a004-20210615
x86_64               randconfig-a002-20210615
x86_64               randconfig-a003-20210615
x86_64               randconfig-a006-20210615
x86_64               randconfig-a005-20210615
i386                 randconfig-a002-20210615
i386                 randconfig-a006-20210615
i386                 randconfig-a004-20210615
i386                 randconfig-a001-20210615
i386                 randconfig-a005-20210615
i386                 randconfig-a003-20210615
i386                 randconfig-a015-20210615
i386                 randconfig-a013-20210615
i386                 randconfig-a016-20210615
i386                 randconfig-a012-20210615
i386                 randconfig-a014-20210615
i386                 randconfig-a011-20210615
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                            kunit_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210615
x86_64               randconfig-a015-20210615
x86_64               randconfig-a011-20210615
x86_64               randconfig-a012-20210615
x86_64               randconfig-a014-20210615
x86_64               randconfig-a016-20210615
x86_64               randconfig-a013-20210615

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
