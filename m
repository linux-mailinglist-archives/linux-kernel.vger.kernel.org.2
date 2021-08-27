Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF233F9839
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244860AbhH0KqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:46:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:29581 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233193AbhH0KqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:46:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="303513952"
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="303513952"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 03:45:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="517268159"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2021 03:45:03 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJZM7-0002Sn-4M; Fri, 27 Aug 2021 10:45:03 +0000
Date:   Fri, 27 Aug 2021 18:44:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 1a519dc7a73c977547d8b5108d98c6e769c89f4b
Message-ID: <6128c201.pqJLs9/WwMJQjm5y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 1a519dc7a73c977547d8b5108d98c6e769c89f4b  PCI/MSI: Skip masking MSI-X on Xen PV

elapsed time: 723m

configs tested: 129
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210827
powerpc              randconfig-c003-20210827
arm                    vt8500_v6_v7_defconfig
xtensa                    xip_kc705_defconfig
mips                     loongson1b_defconfig
powerpc                      ppc64e_defconfig
parisc                generic-32bit_defconfig
arm                          ep93xx_defconfig
arm                         cm_x300_defconfig
mips                           ip27_defconfig
powerpc                 mpc8313_rdb_defconfig
s390                             alldefconfig
sh                           se7206_defconfig
powerpc                      mgcoge_defconfig
mips                             allyesconfig
powerpc                     tqm8555_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc85xx_cds_defconfig
um                           x86_64_defconfig
powerpc                   lite5200b_defconfig
riscv                    nommu_virt_defconfig
arm                         vf610m4_defconfig
arm                          collie_defconfig
m68k                       m5249evb_defconfig
ia64                        generic_defconfig
parisc                              defconfig
sh                           se7712_defconfig
m68k                        m5272c3_defconfig
xtensa                  cadence_csp_defconfig
powerpc                     akebono_defconfig
arm                             ezx_defconfig
sh                             sh03_defconfig
m68k                          atari_defconfig
mips                malta_qemu_32r6_defconfig
mips                        nlm_xlr_defconfig
powerpc                        fsp2_defconfig
m68k                             allmodconfig
sparc                       sparc32_defconfig
arm                        multi_v7_defconfig
arc                          axs101_defconfig
mips                         tb0219_defconfig
nios2                         10m50_defconfig
sh                   secureedge5410_defconfig
powerpc                 canyonlands_defconfig
arm                        oxnas_v6_defconfig
m68k                          amiga_defconfig
mips                        maltaup_defconfig
arm                      footbridge_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                          pxa168_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210827
x86_64               randconfig-a015-20210827
x86_64               randconfig-a016-20210827
x86_64               randconfig-a012-20210827
x86_64               randconfig-a011-20210827
x86_64               randconfig-a013-20210827
i386                 randconfig-a011-20210827
i386                 randconfig-a016-20210827
i386                 randconfig-a012-20210827
i386                 randconfig-a014-20210827
i386                 randconfig-a013-20210827
i386                 randconfig-a015-20210827
arc                  randconfig-r043-20210827
riscv                randconfig-r042-20210827
s390                 randconfig-r044-20210827
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210827
i386                 randconfig-c001-20210827
arm                  randconfig-c002-20210827
riscv                randconfig-c006-20210827
powerpc              randconfig-c003-20210827
x86_64               randconfig-c007-20210827
mips                 randconfig-c004-20210827
x86_64               randconfig-a005-20210827
x86_64               randconfig-a001-20210827
x86_64               randconfig-a006-20210827
x86_64               randconfig-a003-20210827
x86_64               randconfig-a004-20210827
x86_64               randconfig-a002-20210827
i386                 randconfig-a006-20210827
i386                 randconfig-a001-20210827
i386                 randconfig-a002-20210827
i386                 randconfig-a005-20210827
i386                 randconfig-a004-20210827
i386                 randconfig-a003-20210827

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
