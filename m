Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F003B3827
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhFXUum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:50:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:41769 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhFXUul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:50:41 -0400
IronPort-SDR: l5IDcnqTwx7KDKq6teYdSvaDHCd4NTA4FNYW8f8I6ZCIPqLBYUivAyxiJT5mtFwxnQsJuJXaJ9
 AvVB8Ct8fZVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="271412576"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="271412576"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 13:48:21 -0700
IronPort-SDR: U7wPDP6M3NJtkaX5mdFyOORVNfWHHDQj8ArUxs/mjT0MoyO2mE/KPDgLJEw893UOif4afUvZ1L
 /ue6ZrU3KmFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="487913486"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2021 13:48:20 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwWGp-0006lE-KP; Thu, 24 Jun 2021 20:48:19 +0000
Date:   Fri, 25 Jun 2021 04:48:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 fd2afa70eff057fab57c9e06708b68677b261a0c
Message-ID: <60d4ef83.1toGrAsKvyb131HL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: fd2afa70eff057fab57c9e06708b68677b261a0c  x86/resctrl: Fix kernel-doc in internal.h

elapsed time: 730m

configs tested: 195
configs skipped: 64

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                            defconfig
arm                        mvebu_v5_defconfig
xtensa                          iss_defconfig
parisc                           allyesconfig
mips                        vocore2_defconfig
nds32                               defconfig
mips                           mtx1_defconfig
powerpc                      arches_defconfig
mips                            gpr_defconfig
m68k                        m5272c3_defconfig
microblaze                      mmu_defconfig
arm                             rpc_defconfig
arm                        magician_defconfig
mips                      maltasmvp_defconfig
s390                                defconfig
powerpc                      ppc44x_defconfig
m68k                          atari_defconfig
sh                   secureedge5410_defconfig
arm                              alldefconfig
mips                     decstation_defconfig
arm                       aspeed_g5_defconfig
mips                     loongson1c_defconfig
sh                        dreamcast_defconfig
sh                        sh7785lcr_defconfig
arm                         axm55xx_defconfig
nios2                         10m50_defconfig
powerpc                       holly_defconfig
powerpc                      makalu_defconfig
arc                        nsimosci_defconfig
powerpc                     akebono_defconfig
xtensa                generic_kc705_defconfig
riscv                             allnoconfig
openrisc                    or1ksim_defconfig
mips                        workpad_defconfig
sh                          urquell_defconfig
mips                        omega2p_defconfig
sh                         ecovec24_defconfig
mips                       capcella_defconfig
arm                        mini2440_defconfig
arm                            hisi_defconfig
arm                        neponset_defconfig
mips                        bcm63xx_defconfig
mips                         rt305x_defconfig
sh                           se7206_defconfig
nios2                            alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                malta_qemu_32r6_defconfig
arm                       aspeed_g4_defconfig
powerpc                     tqm8540_defconfig
ia64                      gensparse_defconfig
arm                       spear13xx_defconfig
powerpc                        fsp2_defconfig
powerpc                     tqm8555_defconfig
xtensa                       common_defconfig
powerpc                     stx_gp3_defconfig
xtensa                  cadence_csp_defconfig
um                             i386_defconfig
sparc                            alldefconfig
arm                           omap1_defconfig
mips                       rbtx49xx_defconfig
mips                   sb1250_swarm_defconfig
arm                      pxa255-idp_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                        edosk7705_defconfig
m68k                          hp300_defconfig
powerpc                     ep8248e_defconfig
arm                     am200epdkit_defconfig
m68k                        mvme147_defconfig
arm                  colibri_pxa270_defconfig
sh                        edosk7760_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        clps711x_defconfig
arm                        multi_v5_defconfig
sh                         microdev_defconfig
parisc                generic-32bit_defconfig
powerpc                    gamecube_defconfig
m68k                        m5307c3_defconfig
m68k                         amcore_defconfig
arm                       multi_v4t_defconfig
m68k                          amiga_defconfig
powerpc                     sequoia_defconfig
arm                          badge4_defconfig
sh                   rts7751r2dplus_defconfig
arc                          axs103_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7722_defconfig
powerpc                 mpc834x_itx_defconfig
sh                               allmodconfig
mips                    maltaup_xpa_defconfig
um                                  defconfig
riscv                          rv32_defconfig
sh                           se7343_defconfig
arm                           sunxi_defconfig
mips                           gcw0_defconfig
arc                        vdk_hs38_defconfig
sh                          rsk7203_defconfig
m68k                          sun3x_defconfig
powerpc                       maple_defconfig
arm                           corgi_defconfig
arm                          ep93xx_defconfig
riscv                            allmodconfig
powerpc                 mpc836x_mds_defconfig
s390                          debug_defconfig
powerpc                       ebony_defconfig
m68k                       m5249evb_defconfig
powerpc                     sbc8548_defconfig
arm                         palmz72_defconfig
arm                          ixp4xx_defconfig
arm                          pxa910_defconfig
powerpc                     ppa8548_defconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210623
x86_64               randconfig-a001-20210623
x86_64               randconfig-a005-20210623
x86_64               randconfig-a003-20210623
x86_64               randconfig-a004-20210623
x86_64               randconfig-a006-20210623
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
x86_64               randconfig-a012-20210624
x86_64               randconfig-a016-20210624
x86_64               randconfig-a015-20210624
x86_64               randconfig-a014-20210624
x86_64               randconfig-a013-20210624
x86_64               randconfig-a011-20210624
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-b001-20210624
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
