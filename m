Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6983C435B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 06:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhGLE6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 00:58:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:13679 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhGLE6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:58:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="206908220"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="206908220"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 21:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="648109673"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2021 21:55:59 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m2nz5-000GpG-1T; Mon, 12 Jul 2021 04:55:59 +0000
Date:   Mon, 12 Jul 2021 12:55:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5ee9d54dbe0c9b897ecd090207da14476a3e0814
Message-ID: <60ebcb36.IGl4RPMBHrf74LZh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5ee9d54dbe0c9b897ecd090207da14476a3e0814  Merge branch 'irq/urgent'

elapsed time: 721m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
sh                           se7206_defconfig
mips                      bmips_stb_defconfig
powerpc                         wii_defconfig
arm                         assabet_defconfig
mips                        vocore2_defconfig
nios2                               defconfig
powerpc                 mpc8313_rdb_defconfig
xtensa                          iss_defconfig
sh                           se7343_defconfig
sh                ecovec24-romimage_defconfig
ia64                         bigsur_defconfig
mips                          ath79_defconfig
arm                        spear3xx_defconfig
sh                          lboxre2_defconfig
powerpc                     akebono_defconfig
ia64                                defconfig
m68k                        mvme16x_defconfig
mips                    maltaup_xpa_defconfig
arm                        clps711x_defconfig
powerpc                    klondike_defconfig
arm                           omap1_defconfig
arm                           spitz_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     powernv_defconfig
powerpc                     ep8248e_defconfig
powerpc                      arches_defconfig
powerpc                      cm5200_defconfig
x86_64                            allnoconfig
xtensa                  cadence_csp_defconfig
m68k                       m5208evb_defconfig
powerpc                      walnut_defconfig
sh                   sh7770_generic_defconfig
csky                                defconfig
arm                           viper_defconfig
sh                     magicpanelr2_defconfig
powerpc                   motionpro_defconfig
powerpc                     pq2fads_defconfig
parisc                           alldefconfig
powerpc                   lite5200b_defconfig
mips                          rb532_defconfig
m68k                        mvme147_defconfig
powerpc                     rainier_defconfig
powerpc                     asp8347_defconfig
arm                         lubbock_defconfig
powerpc                     kilauea_defconfig
powerpc                      ppc44x_defconfig
m68k                             allyesconfig
i386                             alldefconfig
powerpc                 mpc8540_ads_defconfig
m68k                         apollo_defconfig
sh                               j2_defconfig
arm                          pcm027_defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                 randconfig-a005-20210712
i386                 randconfig-a004-20210712
i386                 randconfig-a006-20210712
i386                 randconfig-a001-20210712
i386                 randconfig-a002-20210712
i386                 randconfig-a003-20210712
i386                 randconfig-a014-20210711
i386                 randconfig-a015-20210711
i386                 randconfig-a011-20210711
i386                 randconfig-a013-20210711
i386                 randconfig-a012-20210711
i386                 randconfig-a016-20210711
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210712
x86_64               randconfig-b001-20210711
x86_64               randconfig-a005-20210711
x86_64               randconfig-a004-20210711
x86_64               randconfig-a002-20210711
x86_64               randconfig-a003-20210711
x86_64               randconfig-a006-20210711
x86_64               randconfig-a001-20210711
x86_64               randconfig-a013-20210712
x86_64               randconfig-a014-20210712
x86_64               randconfig-a015-20210712
x86_64               randconfig-a012-20210712
x86_64               randconfig-a016-20210712
x86_64               randconfig-a011-20210712

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
