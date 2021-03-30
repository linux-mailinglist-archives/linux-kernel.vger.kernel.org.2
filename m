Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABDA34E8B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhC3NP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:15:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:46256 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231986AbhC3NPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:15:45 -0400
IronPort-SDR: s6dKq0fv/5eBib3+joXo9YdXaD0TPXrHcrgOJJZWVMVQo2+Bhm27ahes13VSJkB6LzhsTtWFxr
 rAUH+uGpXspg==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="211977303"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="211977303"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 06:15:44 -0700
IronPort-SDR: 1KEwOzp2i1CSlnasiut7ueLoNydUhX+7PlgzoV3vo97D7nY7UB14VLcthjmvWpGmzsFl3QdDPB
 ZH3SkCiIICIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="516428534"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2021 06:15:43 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lREDe-0005IV-Sn; Tue, 30 Mar 2021 13:15:42 +0000
Date:   Tue, 30 Mar 2021 21:15:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 a51a327f3bcdcb1a37ed9325ad07e1456cd4d426
Message-ID: <60632459.nFcmttpNYty+Lj+X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: a51a327f3bcdcb1a37ed9325ad07e1456cd4d426  locking/rtmutex: Clean up signal handling in __rt_mutex_slowlock()

elapsed time: 1242m

configs tested: 202
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
powerpc                     sequoia_defconfig
powerpc                    gamecube_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                            q40_defconfig
mips                     loongson1c_defconfig
sh                   sh7770_generic_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                            migor_defconfig
mips                         cobalt_defconfig
m68k                       m5208evb_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         vf610m4_defconfig
arm                        cerfcube_defconfig
arm                          lpd270_defconfig
m68k                        stmark2_defconfig
powerpc                      pasemi_defconfig
xtensa                  audio_kc705_defconfig
arm                        magician_defconfig
arm                       spear13xx_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
sh                           sh2007_defconfig
arc                        nsimosci_defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
sh                 kfr2r09-romimage_defconfig
mips                        maltaup_defconfig
arc                     nsimosci_hs_defconfig
mips                   sb1250_swarm_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        mvme16x_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      ppc40x_defconfig
sh                   rts7751r2dplus_defconfig
arc                        vdk_hs38_defconfig
mips                       capcella_defconfig
arm                         lubbock_defconfig
arm                           h5000_defconfig
arm                         orion5x_defconfig
nios2                            alldefconfig
arm                            qcom_defconfig
arm                            pleb_defconfig
arm                  colibri_pxa270_defconfig
powerpc                        icon_defconfig
arm                      tct_hammer_defconfig
powerpc                       holly_defconfig
m68k                            mac_defconfig
powerpc64                        alldefconfig
mips                       lemote2f_defconfig
arm                         shannon_defconfig
powerpc                     akebono_defconfig
arm                         socfpga_defconfig
m68k                          atari_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                             defconfig
arm                       omap2plus_defconfig
arm                          gemini_defconfig
arm                          exynos_defconfig
sh                            shmin_defconfig
sh                        edosk7705_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
arm                        spear6xx_defconfig
arc                         haps_hs_defconfig
mips                          malta_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc834x_itx_defconfig
arm                         s3c6400_defconfig
xtensa                       common_defconfig
arm                         cm_x300_defconfig
arm                      footbridge_defconfig
arm                          iop32x_defconfig
mips                      pistachio_defconfig
s390                       zfcpdump_defconfig
x86_64                           alldefconfig
m68k                        mvme147_defconfig
powerpc                      ppc64e_defconfig
powerpc                      ppc6xx_defconfig
powerpc                         wii_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          collie_defconfig
arm                             pxa_defconfig
alpha                            alldefconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
sh                           se7343_defconfig
arm                           tegra_defconfig
mips                      pic32mzda_defconfig
mips                        jmr3927_defconfig
m68k                       m5275evb_defconfig
mips                        nlm_xlp_defconfig
s390                          debug_defconfig
m68k                       m5249evb_defconfig
arm                       versatile_defconfig
mips                         rt305x_defconfig
sh                           se7712_defconfig
sparc64                          alldefconfig
riscv             nommu_k210_sdcard_defconfig
sh                        sh7785lcr_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a001-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
x86_64               randconfig-a002-20210329
x86_64               randconfig-a003-20210329
x86_64               randconfig-a006-20210329
x86_64               randconfig-a001-20210329
x86_64               randconfig-a005-20210329
i386                 randconfig-a014-20210329
i386                 randconfig-a011-20210329
i386                 randconfig-a015-20210329
i386                 randconfig-a016-20210329
i386                 randconfig-a013-20210329
i386                 randconfig-a012-20210329
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
x86_64               randconfig-a004-20210329
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330
x86_64               randconfig-a015-20210329
x86_64               randconfig-a012-20210329
x86_64               randconfig-a013-20210329
x86_64               randconfig-a014-20210329
x86_64               randconfig-a011-20210329
x86_64               randconfig-a016-20210329

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
