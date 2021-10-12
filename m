Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A9542A119
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhJLJcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:32:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:52623 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232657AbhJLJcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:32:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="287967489"
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="287967489"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 02:30:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="441155315"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Oct 2021 02:30:21 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1maE72-0003IM-OM; Tue, 12 Oct 2021 09:30:20 +0000
Date:   Tue, 12 Oct 2021 17:29:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 711885906b5c2df90746a51f4cd674f1ab9fbb1d
Message-ID: <61655596.VPe7ME05HW1EdVZQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 711885906b5c2df90746a51f4cd674f1ab9fbb1d  x86/Kconfig: Do not enable AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT automatically

elapsed time: 914m

configs tested: 166
configs skipped: 69

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
i386                 randconfig-c001-20211012
i386                 randconfig-c001-20211011
sh                           se7705_defconfig
m68k                             alldefconfig
sh                              ul2_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      obs600_defconfig
powerpc                    gamecube_defconfig
mips                       bmips_be_defconfig
sh                           se7619_defconfig
arm                            mps2_defconfig
arm                           tegra_defconfig
mips                       lemote2f_defconfig
xtensa                  cadence_csp_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc834x_itx_defconfig
mips                          rm200_defconfig
powerpc                       holly_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         hackkit_defconfig
m68k                          amiga_defconfig
um                               alldefconfig
sh                        sh7785lcr_defconfig
mips                        vocore2_defconfig
powerpc                   microwatt_defconfig
mips                           ci20_defconfig
openrisc                    or1ksim_defconfig
powerpc                      pasemi_defconfig
arm                         s3c6400_defconfig
arm                            lart_defconfig
m68k                            mac_defconfig
mips                      loongson3_defconfig
arm                          moxart_defconfig
mips                malta_qemu_32r6_defconfig
sh                          sdk7786_defconfig
csky                             alldefconfig
mips                          ath25_defconfig
mips                        maltaup_defconfig
parisc                generic-32bit_defconfig
microblaze                          defconfig
mips                           ip22_defconfig
powerpc                   bluestone_defconfig
arm                           sama5_defconfig
arc                        nsim_700_defconfig
mips                         tb0226_defconfig
sh                     magicpanelr2_defconfig
mips                  cavium_octeon_defconfig
mips                           gcw0_defconfig
powerpc                     pseries_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      cm5200_defconfig
m68k                        m5272c3_defconfig
xtensa                    xip_kc705_defconfig
powerpc                 linkstation_defconfig
arc                         haps_hs_defconfig
m68k                       m5249evb_defconfig
sh                          rsk7203_defconfig
mips                      fuloong2e_defconfig
powerpc                      ppc64e_defconfig
xtensa                           alldefconfig
powerpc                           allnoconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       m5208evb_defconfig
ia64                         bigsur_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      tqm8xx_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            mmp2_defconfig
arm                        mvebu_v5_defconfig
powerpc                        fsp2_defconfig
um                                  defconfig
arm                         shannon_defconfig
arm                        magician_defconfig
arm                          simpad_defconfig
riscv                    nommu_k210_defconfig
m68k                            q40_defconfig
mips                         mpc30x_defconfig
powerpc                      ppc44x_defconfig
mips                        qi_lb60_defconfig
arm                           omap1_defconfig
m68k                           sun3_defconfig
arm                  randconfig-c002-20211011
x86_64               randconfig-c001-20211011
arm                  randconfig-c002-20211012
x86_64               randconfig-c001-20211012
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
arc                              allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
arm                  randconfig-c002-20211012
mips                 randconfig-c004-20211012
i386                 randconfig-c001-20211012
s390                 randconfig-c005-20211012
x86_64               randconfig-c007-20211012
powerpc              randconfig-c003-20211012
riscv                randconfig-c006-20211012
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
