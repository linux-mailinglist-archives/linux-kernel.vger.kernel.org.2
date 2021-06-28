Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AC53B67FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhF1R6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:58:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:51559 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234044AbhF1R6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:58:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="208044751"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="208044751"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 10:55:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="625335523"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2021 10:55:54 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lxvUA-0008fk-A0; Mon, 28 Jun 2021 17:55:54 +0000
Date:   Tue, 29 Jun 2021 01:55:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 2d0a9eb23ccfdf11308bec6db0bc007585d919d2
Message-ID: <60da0d1d.KaLixIlYIV6OEkkq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 2d0a9eb23ccfdf11308bec6db0bc007585d919d2  time/kunit: Add missing MODULE_LICENSE()

elapsed time: 720m

configs tested: 169
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7722_defconfig
sh                          landisk_defconfig
mips                      pic32mzda_defconfig
arm                        mvebu_v7_defconfig
arm                       spear13xx_defconfig
xtensa                  cadence_csp_defconfig
arm                    vt8500_v6_v7_defconfig
sh                          rsk7269_defconfig
powerpc                       holly_defconfig
arm                          iop32x_defconfig
powerpc                    sam440ep_defconfig
h8300                       h8s-sim_defconfig
parisc                           alldefconfig
powerpc                 canyonlands_defconfig
m68k                          multi_defconfig
x86_64                              defconfig
arm                            lart_defconfig
arm                       imx_v6_v7_defconfig
arm                          ep93xx_defconfig
arc                              alldefconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     mpc5200_defconfig
powerpc                      ep88xc_defconfig
powerpc                       ppc64_defconfig
sh                          urquell_defconfig
m68k                       m5249evb_defconfig
sh                           se7780_defconfig
arm                         socfpga_defconfig
parisc                generic-64bit_defconfig
arm                             rpc_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      tqm8xx_defconfig
sh                 kfr2r09-romimage_defconfig
arc                    vdk_hs38_smp_defconfig
mips                      maltasmvp_defconfig
arc                     nsimosci_hs_defconfig
mips                            ar7_defconfig
arm                        mvebu_v5_defconfig
arm                       versatile_defconfig
m68k                        m5272c3_defconfig
arm                         cm_x300_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      obs600_defconfig
powerpc                        fsp2_defconfig
arm                         vf610m4_defconfig
powerpc                     stx_gp3_defconfig
sh                          kfr2r09_defconfig
arm                         s5pv210_defconfig
powerpc                     taishan_defconfig
h8300                               defconfig
powerpc                     tqm8541_defconfig
mips                        omega2p_defconfig
microblaze                      mmu_defconfig
m68k                        stmark2_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc8272_ads_defconfig
arm                       cns3420vb_defconfig
mips                       capcella_defconfig
sh                   sh7770_generic_defconfig
openrisc                    or1ksim_defconfig
sh                           se7724_defconfig
arm                        magician_defconfig
sh                             shx3_defconfig
sh                           se7619_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                      rts7751r2d1_defconfig
arc                                 defconfig
riscv                          rv32_defconfig
powerpc                     akebono_defconfig
sh                             espt_defconfig
ia64                      gensparse_defconfig
mips                        bcm63xx_defconfig
mips                         rt305x_defconfig
sh                           sh2007_defconfig
sh                        sh7785lcr_defconfig
arm                        spear3xx_defconfig
powerpc64                           defconfig
mips                         db1xxx_defconfig
powerpc                      bamboo_defconfig
sh                         ecovec24_defconfig
arc                        nsim_700_defconfig
mips                       lemote2f_defconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
h8300                    h8300h-sim_defconfig
mips                        vocore2_defconfig
sh                          polaris_defconfig
mips                      pistachio_defconfig
arm                           h3600_defconfig
s390                             alldefconfig
arm                  colibri_pxa270_defconfig
arm                          lpd270_defconfig
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
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210628
i386                 randconfig-a002-20210628
i386                 randconfig-a003-20210628
i386                 randconfig-a006-20210628
i386                 randconfig-a005-20210628
i386                 randconfig-a004-20210628
x86_64               randconfig-a012-20210628
x86_64               randconfig-a016-20210628
x86_64               randconfig-a015-20210628
x86_64               randconfig-a013-20210628
x86_64               randconfig-a014-20210628
x86_64               randconfig-a011-20210628
i386                 randconfig-a011-20210628
i386                 randconfig-a014-20210628
i386                 randconfig-a013-20210628
i386                 randconfig-a015-20210628
i386                 randconfig-a016-20210628
i386                 randconfig-a012-20210628
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210628
x86_64               randconfig-a002-20210628
x86_64               randconfig-a005-20210628
x86_64               randconfig-a001-20210628
x86_64               randconfig-a003-20210628
x86_64               randconfig-a004-20210628
x86_64               randconfig-a006-20210628

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
