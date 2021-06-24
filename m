Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C634A3B36AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhFXTSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:18:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:20995 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231969AbhFXTSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:18:40 -0400
IronPort-SDR: SPs0YgsOOPbIXLhZ+sDIqo3HJ/5sJuaz82n45+8Z3fpYWZOiOszwhnYmirKKUD7PiTo2Bv14jN
 Fa8wk8peqGMA==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="194684665"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="194684665"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 12:16:20 -0700
IronPort-SDR: /+2e+zt9ruhbi4w6e5W/QK2oA9wFFbVT4m/0buKWJ/QB0DI+NT2enKp8jUpwfpReBFkbtTHhTv
 TsQ7sNONz3Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="407139911"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jun 2021 12:16:19 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwUpm-0006jA-EK; Thu, 24 Jun 2021 19:16:18 +0000
Date:   Fri, 25 Jun 2021 03:16:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 7f049fbdd57f6ea71dc741d903c19c73b2f70950
Message-ID: <60d4d9f7.dp8P/+RzKFT6n2aM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 7f049fbdd57f6ea71dc741d903c19c73b2f70950  perf/x86/intel/lbr: Zero the xstate buffer on allocation

elapsed time: 728m

configs tested: 188
configs skipped: 63

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
sparc64                          alldefconfig
arm                        keystone_defconfig
mips                          ath79_defconfig
sh                          rsk7203_defconfig
sh                        edosk7760_defconfig
um                             i386_defconfig
arm                         lpc32xx_defconfig
arm                          lpd270_defconfig
powerpc                     akebono_defconfig
xtensa                generic_kc705_defconfig
riscv                             allnoconfig
openrisc                    or1ksim_defconfig
arm                             pxa_defconfig
arm                           corgi_defconfig
sparc                            alldefconfig
arm                      pxa255-idp_defconfig
arm                             ezx_defconfig
mips                          ath25_defconfig
mips                       capcella_defconfig
arm                        mini2440_defconfig
arm                            hisi_defconfig
arm                        neponset_defconfig
mips                        bcm63xx_defconfig
arm                       aspeed_g4_defconfig
nds32                             allnoconfig
i386                                defconfig
powerpc                     tqm8540_defconfig
ia64                      gensparse_defconfig
arm                       spear13xx_defconfig
arm                           omap1_defconfig
powerpc                     tqm8555_defconfig
mips                       rbtx49xx_defconfig
mips                   sb1250_swarm_defconfig
powerpc                        fsp2_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                        edosk7705_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     pseries_defconfig
mips                        jmr3927_defconfig
arm                      footbridge_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                        clps711x_defconfig
arm                        multi_v5_defconfig
sh                         microdev_defconfig
parisc                generic-32bit_defconfig
powerpc                    gamecube_defconfig
powerpc                      pasemi_defconfig
arc                      axs103_smp_defconfig
x86_64                              defconfig
microblaze                          defconfig
powerpc                 mpc8540_ads_defconfig
m68k                          amiga_defconfig
powerpc                     sequoia_defconfig
arm                          badge4_defconfig
sh                   rts7751r2dplus_defconfig
arc                          axs103_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7722_defconfig
powerpc                 mpc834x_itx_defconfig
sh                               allmodconfig
powerpc                     ep8248e_defconfig
mips                    maltaup_xpa_defconfig
arm                       multi_v4t_defconfig
um                                  defconfig
riscv                          rv32_defconfig
sh                           se7343_defconfig
powerpc                 mpc834x_mds_defconfig
arm                           sunxi_defconfig
powerpc                       maple_defconfig
arm                          ep93xx_defconfig
riscv                            allmodconfig
powerpc                 mpc836x_mds_defconfig
m68k                       m5249evb_defconfig
mips                        omega2p_defconfig
powerpc                     sbc8548_defconfig
arm                         palmz72_defconfig
m68k                        mvme147_defconfig
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
nds32                               defconfig
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
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
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
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
x86_64               randconfig-a012-20210624
x86_64               randconfig-a016-20210624
x86_64               randconfig-a015-20210624
x86_64               randconfig-a014-20210624
x86_64               randconfig-a013-20210624
x86_64               randconfig-a011-20210624
i386                 randconfig-a011-20210623
i386                 randconfig-a014-20210623
i386                 randconfig-a013-20210623
i386                 randconfig-a015-20210623
i386                 randconfig-a012-20210623
i386                 randconfig-a016-20210623
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
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210624
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
