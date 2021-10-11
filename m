Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93484297F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhJKUKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:10:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:61949 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231926AbhJKUKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:10:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="227246829"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="227246829"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 13:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="480016870"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Oct 2021 13:08:44 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ma1bG-0002fd-Of; Mon, 11 Oct 2021 20:08:42 +0000
Date:   Tue, 12 Oct 2021 04:08:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 3ab37cc4d1e3889ddbb44d62a4741754689f6184
Message-ID: <616499a5.N6Byp6GgLvcc4wSz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 3ab37cc4d1e3889ddbb44d62a4741754689f6184  Merge branch 'x86/urgent' into x86/fpu, to resolve conflict

elapsed time: 727m

configs tested: 201
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211011
sh                           se7206_defconfig
powerpc                      pcm030_defconfig
sh                        edosk7760_defconfig
m68k                                defconfig
sh                           se7705_defconfig
m68k                             alldefconfig
sh                              ul2_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    amigaone_defconfig
arm                       aspeed_g5_defconfig
arc                            hsdk_defconfig
sparc                       sparc64_defconfig
s390                                defconfig
xtensa                  cadence_csp_defconfig
i386                             allyesconfig
mips                       capcella_defconfig
m68k                           sun3_defconfig
sh                     sh7710voipgw_defconfig
arc                      axs103_smp_defconfig
mips                          rm200_defconfig
arm                       cns3420vb_defconfig
arm                         orion5x_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
arm                        realview_defconfig
arm                        multi_v5_defconfig
riscv                               defconfig
sh                     magicpanelr2_defconfig
powerpc                     tqm8541_defconfig
mips                     cu1830-neo_defconfig
arm                            lart_defconfig
riscv                            alldefconfig
powerpc                     tqm8555_defconfig
powerpc                       eiger_defconfig
mips                  maltasmvp_eva_defconfig
powerpc64                           defconfig
powerpc                     taishan_defconfig
powerpc                     mpc83xx_defconfig
openrisc                    or1ksim_defconfig
powerpc                     akebono_defconfig
sh                         microdev_defconfig
powerpc                     kilauea_defconfig
arm                         at91_dt_defconfig
arm                             mxs_defconfig
mips                    maltaup_xpa_defconfig
mips                        maltaup_defconfig
parisc                generic-32bit_defconfig
microblaze                          defconfig
sh                        sh7785lcr_defconfig
mips                           ip22_defconfig
arm                          ep93xx_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                       mainstone_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      ppc6xx_defconfig
arm                        cerfcube_defconfig
mips                           ci20_defconfig
mips                  cavium_octeon_defconfig
mips                           gcw0_defconfig
powerpc                   bluestone_defconfig
powerpc                     pseries_defconfig
mips                      maltasmvp_defconfig
sh                                  defconfig
sh                          r7785rp_defconfig
arm                         lubbock_defconfig
xtensa                           alldefconfig
powerpc                      ppc44x_defconfig
xtensa                    xip_kc705_defconfig
powerpc                 linkstation_defconfig
arc                         haps_hs_defconfig
m68k                       m5249evb_defconfig
mips                        vocore2_defconfig
mips                         tb0287_defconfig
mips                        workpad_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     asp8347_defconfig
arm                        mini2440_defconfig
h8300                            alldefconfig
powerpc                       ebony_defconfig
arm                        keystone_defconfig
arm                          iop32x_defconfig
mips                            e55_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         cm_x300_defconfig
sh                           se7751_defconfig
arm                         vf610m4_defconfig
m68k                        m5272c3_defconfig
mips                          ath79_defconfig
powerpc                    sam440ep_defconfig
m68k                         apollo_defconfig
mips                           xway_defconfig
openrisc                 simple_smp_defconfig
arm                     am200epdkit_defconfig
powerpc                    gamecube_defconfig
arm                      integrator_defconfig
arm                            mps2_defconfig
arm                     davinci_all_defconfig
sh                          sdk7780_defconfig
powerpc                   microwatt_defconfig
powerpc                     mpc512x_defconfig
sh                        sh7757lcr_defconfig
nds32                            alldefconfig
sh                      rts7751r2d1_defconfig
ia64                        generic_defconfig
xtensa                    smp_lx200_defconfig
m68k                        m5407c3_defconfig
arm                         assabet_defconfig
arm                        neponset_defconfig
sh                         ecovec24_defconfig
arm                          moxart_defconfig
m68k                        m5307c3_defconfig
mips                            gpr_defconfig
arm                  randconfig-c002-20211011
x86_64               randconfig-c001-20211011
arm                  randconfig-c002-20211012
i386                 randconfig-c001-20211012
x86_64               randconfig-c001-20211012
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20211011
x86_64               randconfig-a012-20211011
x86_64               randconfig-a016-20211011
x86_64               randconfig-a014-20211011
x86_64               randconfig-a013-20211011
x86_64               randconfig-a011-20211011
i386                 randconfig-a016-20211011
i386                 randconfig-a014-20211011
i386                 randconfig-a011-20211011
i386                 randconfig-a015-20211011
i386                 randconfig-a012-20211011
i386                 randconfig-a013-20211011
arc                  randconfig-r043-20211011
s390                 randconfig-r044-20211011
riscv                randconfig-r042-20211011
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211011
mips                 randconfig-c004-20211011
i386                 randconfig-c001-20211011
s390                 randconfig-c005-20211011
x86_64               randconfig-c007-20211011
powerpc              randconfig-c003-20211011
riscv                randconfig-c006-20211011
x86_64               randconfig-a004-20211011
x86_64               randconfig-a006-20211011
x86_64               randconfig-a001-20211011
x86_64               randconfig-a005-20211011
x86_64               randconfig-a002-20211011
x86_64               randconfig-a003-20211011
i386                 randconfig-a001-20211011
i386                 randconfig-a003-20211011
i386                 randconfig-a004-20211011
i386                 randconfig-a005-20211011
i386                 randconfig-a002-20211011
i386                 randconfig-a006-20211011
hexagon              randconfig-r041-20211011
hexagon              randconfig-r045-20211011

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
