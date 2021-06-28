Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC07A3B6AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 00:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhF1Wex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 18:34:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:5403 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236347AbhF1We3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 18:34:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="205038630"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="205038630"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 15:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="641077018"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2021 15:31:58 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lxznK-0008ku-2F; Mon, 28 Jun 2021 22:31:58 +0000
Date:   Tue, 29 Jun 2021 06:31:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 3d2ce675aba7e2425710e23268579a5d76c7e725
Message-ID: <60da4db2./lh7wcNlIRDk24bX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 3d2ce675aba7e2425710e23268579a5d76c7e725  Merge tag 'irqchip-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 725m

configs tested: 185
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                    vt8500_v6_v7_defconfig
sh                          rsk7269_defconfig
powerpc                       holly_defconfig
arm                          iop32x_defconfig
sh                           se7750_defconfig
powerpc                         wii_defconfig
m68k                        stmark2_defconfig
arm                         palmz72_defconfig
riscv                             allnoconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     mpc5200_defconfig
h8300                       h8s-sim_defconfig
powerpc                      ep88xc_defconfig
mips                            ar7_defconfig
powerpc                       ppc64_defconfig
powerpc                     akebono_defconfig
m68k                       m5249evb_defconfig
powerpc                     sbc8548_defconfig
mips                           ip22_defconfig
sh                          urquell_defconfig
sh                           se7780_defconfig
arm                         socfpga_defconfig
parisc                generic-64bit_defconfig
arm                             rpc_defconfig
powerpc                     mpc83xx_defconfig
arc                          axs101_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                    gamecube_defconfig
arm                           sunxi_defconfig
sh                           se7722_defconfig
sh                 kfr2r09-romimage_defconfig
sh                         apsh4a3a_defconfig
csky                             alldefconfig
arm                          pxa910_defconfig
arm                         cm_x300_defconfig
powerpc                      obs600_defconfig
powerpc                        fsp2_defconfig
arm                         vf610m4_defconfig
powerpc                     stx_gp3_defconfig
mips                           ip27_defconfig
mips                           jazz_defconfig
arm                          pcm027_defconfig
mips                     loongson1c_defconfig
arm                       netwinder_defconfig
arm                        oxnas_v6_defconfig
powerpc                    socrates_defconfig
sh                         ap325rxa_defconfig
m68k                          atari_defconfig
arm                           tegra_defconfig
arm                          ixp4xx_defconfig
sh                              ul2_defconfig
sh                          kfr2r09_defconfig
arm                         s5pv210_defconfig
powerpc                     taishan_defconfig
h8300                               defconfig
sh                      rts7751r2d1_defconfig
powerpc                     tqm8541_defconfig
mips                        omega2p_defconfig
microblaze                      mmu_defconfig
powerpc                     asp8347_defconfig
arm                        mvebu_v5_defconfig
mips                           rs90_defconfig
powerpc                     tqm8548_defconfig
sh                             espt_defconfig
arm                          ep93xx_defconfig
ia64                      gensparse_defconfig
mips                        bcm63xx_defconfig
powerpc64                           defconfig
mips                         db1xxx_defconfig
powerpc                      bamboo_defconfig
sh                           se7619_defconfig
sh                         ecovec24_defconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
h8300                    h8300h-sim_defconfig
mips                        vocore2_defconfig
mips                      maltasmvp_defconfig
powerpc                      chrp32_defconfig
mips                         tb0226_defconfig
h8300                            alldefconfig
arm                         hackkit_defconfig
sh                               allmodconfig
m68k                        m5272c3_defconfig
sh                            hp6xx_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     sequoia_defconfig
mips                          ath79_defconfig
powerpc                     skiroot_defconfig
um                           x86_64_defconfig
nios2                            alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                      loongson3_defconfig
openrisc                            defconfig
powerpc                       eiger_defconfig
x86_64                            allnoconfig
um                                  defconfig
powerpc                      mgcoge_defconfig
mips                       lemote2f_defconfig
powerpc                      ppc44x_defconfig
m68k                        mvme147_defconfig
microblaze                          defconfig
sh                        sh7785lcr_defconfig
arm                        trizeps4_defconfig
nds32                             allnoconfig
powerpc                      ppc64e_defconfig
arm                         assabet_defconfig
arm                           h3600_defconfig
s390                             alldefconfig
arm                  colibri_pxa270_defconfig
arm                          lpd270_defconfig
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
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
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
