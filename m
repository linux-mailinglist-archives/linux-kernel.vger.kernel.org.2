Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B13F6AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 23:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhHXV1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 17:27:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:31444 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbhHXV1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 17:27:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="204602258"
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="204602258"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 14:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="685824524"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2021 14:26:17 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIdw1-0000sU-9q; Tue, 24 Aug 2021 21:26:17 +0000
Date:   Wed, 25 Aug 2021 05:25:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 5b3fd8aa5df0244fc19f2572598dee406bcc6b07
Message-ID: <612563dc.0AvHSQeXBOhIgAKM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 5b3fd8aa5df0244fc19f2572598dee406bcc6b07  x86/kaslr: Have process_mem_region() return a boolean

elapsed time: 722m

configs tested: 169
configs skipped: 77

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210824
sh                           se7722_defconfig
powerpc                    mvme5100_defconfig
powerpc                     ep8248e_defconfig
arm                           viper_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                    adder875_defconfig
powerpc                       ebony_defconfig
arm                            xcep_defconfig
riscv                          rv32_defconfig
sh                          rsk7201_defconfig
openrisc                  or1klitex_defconfig
powerpc                        fsp2_defconfig
arm                          iop32x_defconfig
arm                            dove_defconfig
h8300                               defconfig
powerpc                     ksi8560_defconfig
arm                          simpad_defconfig
arm                          imote2_defconfig
arm                              alldefconfig
riscv                            alldefconfig
sparc64                             defconfig
arc                           tb10x_defconfig
arm                          pxa910_defconfig
sh                           se7750_defconfig
ia64                      gensparse_defconfig
xtensa                  cadence_csp_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7269_defconfig
powerpc                      mgcoge_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc64                        alldefconfig
arm                    vt8500_v6_v7_defconfig
arc                              alldefconfig
arm                         at91_dt_defconfig
powerpc                 mpc8272_ads_defconfig
mips                malta_qemu_32r6_defconfig
mips                        omega2p_defconfig
arm                        cerfcube_defconfig
riscv                    nommu_k210_defconfig
nds32                               defconfig
openrisc                         alldefconfig
sh                           se7712_defconfig
arm                           stm32_defconfig
mips                 decstation_r4k_defconfig
arm                            lart_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
mips                    maltaup_xpa_defconfig
arm                        realview_defconfig
powerpc                      pmac32_defconfig
arm                          moxart_defconfig
mips                      malta_kvm_defconfig
mips                           ip22_defconfig
arm                         cm_x300_defconfig
powerpc                       maple_defconfig
sh                               j2_defconfig
sh                        sh7763rdp_defconfig
i386                                defconfig
arm                          ixp4xx_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 linkstation_defconfig
powerpc64                           defconfig
mips                          ath79_defconfig
arm                          lpd270_defconfig
powerpc                     mpc5200_defconfig
nds32                            alldefconfig
arm                         lpc18xx_defconfig
powerpc                 mpc8313_rdb_defconfig
x86_64                              defconfig
arm                        magician_defconfig
powerpc                   lite5200b_defconfig
arm                             rpc_defconfig
powerpc                     mpc83xx_defconfig
powerpc                     kilauea_defconfig
m68k                          hp300_defconfig
sh                   sh7770_generic_defconfig
powerpc                     stx_gp3_defconfig
arm                         hackkit_defconfig
sh                           se7206_defconfig
arm                      tct_hammer_defconfig
sh                            titan_defconfig
xtensa                  audio_kc705_defconfig
m68k                         apollo_defconfig
sh                          sdk7786_defconfig
sh                           se7721_defconfig
mips                        workpad_defconfig
arm                           corgi_defconfig
mips                   sb1250_swarm_defconfig
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
nios2                            allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210824
x86_64               randconfig-a006-20210824
x86_64               randconfig-a001-20210824
x86_64               randconfig-a003-20210824
x86_64               randconfig-a004-20210824
x86_64               randconfig-a002-20210824
i386                 randconfig-a006-20210824
i386                 randconfig-a001-20210824
i386                 randconfig-a002-20210824
i386                 randconfig-a005-20210824
i386                 randconfig-a003-20210824
i386                 randconfig-a004-20210824
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210824
s390                 randconfig-c005-20210824
arm                  randconfig-c002-20210824
riscv                randconfig-c006-20210824
x86_64               randconfig-c007-20210824
mips                 randconfig-c004-20210824
x86_64               randconfig-a014-20210824
x86_64               randconfig-a015-20210824
x86_64               randconfig-a016-20210824
x86_64               randconfig-a013-20210824
x86_64               randconfig-a012-20210824
x86_64               randconfig-a011-20210824
i386                 randconfig-a011-20210824
i386                 randconfig-a016-20210824
i386                 randconfig-a012-20210824
i386                 randconfig-a014-20210824
i386                 randconfig-a013-20210824
i386                 randconfig-a015-20210824
hexagon              randconfig-r041-20210824
hexagon              randconfig-r045-20210824
riscv                randconfig-r042-20210824
s390                 randconfig-r044-20210824

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
