Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF785353169
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 01:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhDBXKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 19:10:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:37560 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235604AbhDBXJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 19:09:47 -0400
IronPort-SDR: /cYd5uAVcO8T+ZYS2b3zqANKhZFiXu81PQV9eZD49fCtq2M0Ccc7rpvKKJNHlsxTAzkHEU6m1q
 K7dv6sp8eAVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="172583761"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="172583761"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 16:09:45 -0700
IronPort-SDR: jOHbBa+H3Tq7H3cf2/ytdUIOVUrPV/klf9x0uH8Db0qHAY+7aj6+dLRhcjXseZ3ltd+JgT6K5r
 Cmi1iL3a4ntQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="378236308"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2021 16:09:43 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSSv8-0007Of-9d; Fri, 02 Apr 2021 23:09:42 +0000
Date:   Sat, 03 Apr 2021 07:08:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 b1f480bc0686e65d5413c035bd13af2ea4888784
Message-ID: <6067a3f9.AdAWHUSMGBC4bTEO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: b1f480bc0686e65d5413c035bd13af2ea4888784  Merge branch 'x86/cpu' into WIP.x86/core, to merge the NOP changes & resolve a semantic conflict

elapsed time: 722m

configs tested: 198
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
mips                      fuloong2e_defconfig
powerpc                     sequoia_defconfig
arm                          ixp4xx_defconfig
arm                          pxa910_defconfig
arm                          lpd270_defconfig
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
powerpc                     ksi8560_defconfig
powerpc                     tqm5200_defconfig
powerpc                      katmai_defconfig
m68k                        mvme147_defconfig
sh                           sh2007_defconfig
mips                   sb1250_swarm_defconfig
h8300                       h8s-sim_defconfig
um                                allnoconfig
arm                          badge4_defconfig
mips                      loongson3_defconfig
arc                     nsimosci_hs_defconfig
arm                        shmobile_defconfig
m68k                         apollo_defconfig
xtensa                          iss_defconfig
sh                          rsk7201_defconfig
arm                     eseries_pxa_defconfig
arm                     am200epdkit_defconfig
h8300                    h8300h-sim_defconfig
arm                        oxnas_v6_defconfig
sh                          lboxre2_defconfig
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
powerpc                         wii_defconfig
arm                       multi_v4t_defconfig
sh                        sh7785lcr_defconfig
mips                        qi_lb60_defconfig
arm                           tegra_defconfig
mips                        vocore2_defconfig
s390                                defconfig
powerpc                 mpc8315_rdb_defconfig
sh                 kfr2r09-romimage_defconfig
arm                             rpc_defconfig
sparc64                             defconfig
powerpc                 mpc834x_mds_defconfig
mips                          malta_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
xtensa                       common_defconfig
mips                           gcw0_defconfig
mips                        omega2p_defconfig
arm                         palmz72_defconfig
arm                          pxa168_defconfig
sh                           se7780_defconfig
mips                         tb0219_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc836x_mds_defconfig
sh                           se7750_defconfig
arm                         lpc18xx_defconfig
arm                          moxart_defconfig
s390                             allyesconfig
sh                          urquell_defconfig
sh                             sh03_defconfig
sh                           se7712_defconfig
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
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
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
