Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F635305C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhDBUlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:41:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:33882 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBUln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:41:43 -0400
IronPort-SDR: 0+wlQejvHzzI24L7ebwXni7unOpSYgrdiPjkL2JI5mK10eiN1z/wzQj4Y5pxCnlppzIq6Vr5J5
 byZiEKDY/I6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="190299712"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="190299712"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 13:41:41 -0700
IronPort-SDR: O/Di1O7re0cq2lPWDpdwUplpELNFHK2mfYKL+5i6kOgRFdQvtt99K9k/+fem1+jbJCpbhWyw3T
 WNuoM6pzzU4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="419802291"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Apr 2021 13:41:37 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSQbo-0007Kr-4e; Fri, 02 Apr 2021 20:41:36 +0000
Date:   Sat, 03 Apr 2021 04:40:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 cface0326a6c2ae5c8f47bd466f07624b3e348a7
Message-ID: <6067814a.9y0XeGoAk819GJHv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: cface0326a6c2ae5c8f47bd466f07624b3e348a7  perf/x86/intel/uncore: Enable IIO stacks to PMON mapping for multi-segment SKX

elapsed time: 725m

configs tested: 218
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
sh                          rsk7203_defconfig
arc                    vdk_hs38_smp_defconfig
mips                       rbtx49xx_defconfig
arm                           h5000_defconfig
powerpc                     powernv_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
powerpc                      ppc40x_defconfig
mips                         tb0226_defconfig
xtensa                generic_kc705_defconfig
sh                            titan_defconfig
arm                      footbridge_defconfig
arm                             ezx_defconfig
arm                        trizeps4_defconfig
arm                             rpc_defconfig
xtensa                       common_defconfig
powerpc                     ksi8560_defconfig
arm                          lpd270_defconfig
arm                       aspeed_g4_defconfig
riscv                    nommu_k210_defconfig
m68k                          amiga_defconfig
alpha                            alldefconfig
arm                           sama5_defconfig
sh                         apsh4a3a_defconfig
arm                           omap1_defconfig
mips                          rm200_defconfig
parisc                generic-64bit_defconfig
powerpc                     mpc83xx_defconfig
ia64                      gensparse_defconfig
powerpc                   bluestone_defconfig
sh                          rsk7264_defconfig
powerpc                      ppc64e_defconfig
powerpc                     tqm8548_defconfig
sh                           se7619_defconfig
mips                      fuloong2e_defconfig
powerpc                     sequoia_defconfig
arm                          ixp4xx_defconfig
arm                          pxa910_defconfig
mips                     cu1830-neo_defconfig
mips                     cu1000-neo_defconfig
mips                             allmodconfig
mips                      pistachio_defconfig
riscv                          rv32_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     redwood_defconfig
parisc                generic-32bit_defconfig
mips                            gpr_defconfig
powerpc                     tqm8540_defconfig
sh                     magicpanelr2_defconfig
ia64                             allmodconfig
m68k                         amcore_defconfig
m68k                       bvme6000_defconfig
arm                       spear13xx_defconfig
powerpc                     ppa8548_defconfig
powerpc                     akebono_defconfig
s390                                defconfig
powerpc                      makalu_defconfig
openrisc                    or1ksim_defconfig
arm                         shannon_defconfig
arm                       omap2plus_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      acadia_defconfig
powerpc                     mpc512x_defconfig
sh                   rts7751r2dplus_defconfig
arm                             pxa_defconfig
mips                        workpad_defconfig
nios2                         10m50_defconfig
arm                          iop32x_defconfig
ia64                             alldefconfig
m68k                          hp300_defconfig
powerpc                 mpc8540_ads_defconfig
arc                        nsim_700_defconfig
arm                         lpc32xx_defconfig
powerpc                     tqm8560_defconfig
powerpc                      tqm8xx_defconfig
mips                           ip27_defconfig
arm                        cerfcube_defconfig
m68k                           sun3_defconfig
powerpc                     tqm5200_defconfig
powerpc                      katmai_defconfig
m68k                        mvme147_defconfig
sh                           sh2007_defconfig
mips                   sb1250_swarm_defconfig
arm                        shmobile_defconfig
m68k                         apollo_defconfig
xtensa                          iss_defconfig
sh                          rsk7201_defconfig
arm                     eseries_pxa_defconfig
arm                     am200epdkit_defconfig
h8300                    h8300h-sim_defconfig
arm                        oxnas_v6_defconfig
sh                          lboxre2_defconfig
mips                        qi_lb60_defconfig
arm                           tegra_defconfig
riscv                               defconfig
mips                        vocore2_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                          malta_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
mips                           gcw0_defconfig
mips                        omega2p_defconfig
arm                         palmz72_defconfig
arm                          pxa168_defconfig
sh                           se7780_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
powerpc                   lite5200b_defconfig
arm                         s5pv210_defconfig
arm                          imote2_defconfig
mips                         tb0219_defconfig
mips                malta_qemu_32r6_defconfig
sh                           se7750_defconfig
powerpc                    ge_imp3a_defconfig
arc                        vdk_hs38_defconfig
powerpc                           allnoconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
mips                       capcella_defconfig
arm                          exynos_defconfig
ia64                             allyesconfig
powerpc                 mpc837x_rdb_defconfig
mips                           ci20_defconfig
powerpc                  iss476-smp_defconfig
arm                         lpc18xx_defconfig
arm                          moxart_defconfig
s390                             allyesconfig
sh                          urquell_defconfig
powerpc                    amigaone_defconfig
sh                             sh03_defconfig
sh                           se7712_defconfig
ia64                                defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210402
x86_64               randconfig-a005-20210402
x86_64               randconfig-a003-20210402
x86_64               randconfig-a001-20210402
x86_64               randconfig-a002-20210402
x86_64               randconfig-a006-20210402
i386                 randconfig-a006-20210402
i386                 randconfig-a003-20210402
i386                 randconfig-a001-20210402
i386                 randconfig-a004-20210402
i386                 randconfig-a005-20210402
i386                 randconfig-a002-20210402
i386                 randconfig-a006-20210401
i386                 randconfig-a003-20210401
i386                 randconfig-a001-20210401
i386                 randconfig-a004-20210401
i386                 randconfig-a002-20210401
i386                 randconfig-a005-20210401
i386                 randconfig-a014-20210402
i386                 randconfig-a016-20210402
i386                 randconfig-a011-20210402
i386                 randconfig-a012-20210402
i386                 randconfig-a013-20210402
i386                 randconfig-a015-20210402
i386                 randconfig-a014-20210401
i386                 randconfig-a011-20210401
i386                 randconfig-a016-20210401
i386                 randconfig-a012-20210401
i386                 randconfig-a013-20210401
i386                 randconfig-a015-20210401
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401
x86_64               randconfig-a014-20210402
x86_64               randconfig-a015-20210402
x86_64               randconfig-a011-20210402
x86_64               randconfig-a013-20210402
x86_64               randconfig-a012-20210402
x86_64               randconfig-a016-20210402

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
