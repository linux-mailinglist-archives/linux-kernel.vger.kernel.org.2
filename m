Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D984A3F3D7E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 06:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhHVEPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 00:15:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:47788 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhHVEPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 00:15:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10083"; a="204083839"
X-IronPort-AV: E=Sophos;i="5.84,341,1620716400"; 
   d="scan'208";a="204083839"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2021 21:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,341,1620716400"; 
   d="scan'208";a="513484850"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2021 21:14:24 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mHesJ-000WSM-E4; Sun, 22 Aug 2021 04:14:23 +0000
Date:   Sun, 22 Aug 2021 12:14:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 22aa45cb465be474e97666b3f7587ccb06ee411b
Message-ID: <6121cf1d.OTCOZ8ejlUi9T8TX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 22aa45cb465be474e97666b3f7587ccb06ee411b  x86/efi: Restore Firmware IDT before calling ExitBootServices()

elapsed time: 724m

configs tested: 121
configs skipped: 71

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210821
arm                         at91_dt_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                             shx3_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                        mvme16x_defconfig
arm                            xcep_defconfig
sh                           se7780_defconfig
arm                          imote2_defconfig
sh                           se7750_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
powerpc                    mvme5100_defconfig
powerpc                   microwatt_defconfig
arm                           viper_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc834x_itx_defconfig
arm                           stm32_defconfig
powerpc                  storcenter_defconfig
sh                            migor_defconfig
sh                        sh7785lcr_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210822
x86_64               randconfig-a006-20210822
x86_64               randconfig-a001-20210822
x86_64               randconfig-a003-20210822
x86_64               randconfig-a004-20210822
x86_64               randconfig-a002-20210822
i386                 randconfig-a006-20210822
i386                 randconfig-a001-20210822
i386                 randconfig-a002-20210822
i386                 randconfig-a005-20210822
i386                 randconfig-a003-20210822
i386                 randconfig-a004-20210822
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210822
s390                 randconfig-c005-20210822
arm                  randconfig-c002-20210822
riscv                randconfig-c006-20210822
powerpc              randconfig-c003-20210822
x86_64               randconfig-c007-20210822
mips                 randconfig-c004-20210822
x86_64               randconfig-a005-20210821
x86_64               randconfig-a001-20210821
x86_64               randconfig-a006-20210821
x86_64               randconfig-a003-20210821
x86_64               randconfig-a004-20210821
x86_64               randconfig-a002-20210821
i386                 randconfig-a006-20210821
i386                 randconfig-a001-20210821
i386                 randconfig-a002-20210821
i386                 randconfig-a005-20210821
i386                 randconfig-a004-20210821
i386                 randconfig-a003-20210821
x86_64               randconfig-a014-20210822
x86_64               randconfig-a016-20210822
x86_64               randconfig-a015-20210822
x86_64               randconfig-a013-20210822
x86_64               randconfig-a012-20210822
x86_64               randconfig-a011-20210822
i386                 randconfig-a011-20210822
i386                 randconfig-a016-20210822
i386                 randconfig-a012-20210822
i386                 randconfig-a014-20210822
i386                 randconfig-a013-20210822
i386                 randconfig-a015-20210822
hexagon              randconfig-r041-20210822
hexagon              randconfig-r045-20210822
riscv                randconfig-r042-20210822
s390                 randconfig-r044-20210822

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
