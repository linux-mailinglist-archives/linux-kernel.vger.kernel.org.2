Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC52438CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 02:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhJYAh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 20:37:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:37639 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhJYAhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 20:37:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="293009101"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="293009101"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 17:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="496548554"
Received: from lkp-server02.sh.intel.com (HELO 74392981b700) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Oct 2021 17:35:31 -0700
Received: from kbuild by 74392981b700 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1menxb-0001Bi-5b; Mon, 25 Oct 2021 00:35:31 +0000
Date:   Mon, 25 Oct 2021 08:35:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 0a30896fc5025e71c350449760b240fba5581b42
Message-ID: <6175fbb8.rYvIDzxGPzmCBWqV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 0a30896fc5025e71c350449760b240fba5581b42  MAINTAINERS: Add Dave Hansen to the x86 maintainer team

elapsed time: 5022m

configs tested: 159
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211021
m68k                         apollo_defconfig
arm                            mmp2_defconfig
arm                         vf610m4_defconfig
powerpc                    gamecube_defconfig
h8300                            alldefconfig
arm                  colibri_pxa300_defconfig
powerpc                   bluestone_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     sequoia_defconfig
arm                        magician_defconfig
xtensa                  cadence_csp_defconfig
mips                           ip28_defconfig
arm                         axm55xx_defconfig
mips                         db1xxx_defconfig
mips                        omega2p_defconfig
arm                            hisi_defconfig
powerpc                     akebono_defconfig
powerpc                      chrp32_defconfig
powerpc                      ppc64e_defconfig
arm                         s3c2410_defconfig
arm                       multi_v4t_defconfig
powerpc                      obs600_defconfig
mips                malta_qemu_32r6_defconfig
mips                        qi_lb60_defconfig
um                                  defconfig
arm                         orion5x_defconfig
sh                          kfr2r09_defconfig
mips                        maltaup_defconfig
arm                       versatile_defconfig
sparc                       sparc32_defconfig
m68k                        stmark2_defconfig
sh                        edosk7705_defconfig
arm                          moxart_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7751_defconfig
mips                          rb532_defconfig
openrisc                 simple_smp_defconfig
arm                     davinci_all_defconfig
arm                        spear6xx_defconfig
m68k                          atari_defconfig
mips                           xway_defconfig
arm                            mps2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211024
x86_64               randconfig-a004-20211024
x86_64               randconfig-a005-20211024
x86_64               randconfig-a006-20211024
x86_64               randconfig-a003-20211024
x86_64               randconfig-a001-20211024
i386                 randconfig-a004-20211022
i386                 randconfig-a003-20211022
i386                 randconfig-a002-20211022
i386                 randconfig-a005-20211022
i386                 randconfig-a006-20211022
i386                 randconfig-a001-20211022
x86_64               randconfig-a013-20211021
x86_64               randconfig-a015-20211021
x86_64               randconfig-a011-20211021
x86_64               randconfig-a014-20211021
x86_64               randconfig-a016-20211021
x86_64               randconfig-a012-20211021
i386                 randconfig-a012-20211021
i386                 randconfig-a013-20211021
i386                 randconfig-a011-20211021
i386                 randconfig-a016-20211021
i386                 randconfig-a015-20211021
i386                 randconfig-a014-20211021
x86_64               randconfig-a002-20211022
x86_64               randconfig-a004-20211022
x86_64               randconfig-a005-20211022
x86_64               randconfig-a001-20211022
x86_64               randconfig-a006-20211022
x86_64               randconfig-a003-20211022
arc                  randconfig-r043-20211021
riscv                randconfig-r042-20211021
s390                 randconfig-r044-20211021
arc                  randconfig-r043-20211022
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20211021
riscv                randconfig-c006-20211021
arm                  randconfig-c002-20211021
x86_64               randconfig-c007-20211021
mips                 randconfig-c004-20211021
s390                 randconfig-c005-20211021
i386                 randconfig-c001-20211021
i386                 randconfig-a004-20211021
i386                 randconfig-a003-20211021
i386                 randconfig-a002-20211021
i386                 randconfig-a005-20211021
i386                 randconfig-a001-20211021
i386                 randconfig-a006-20211021
x86_64               randconfig-a002-20211021
x86_64               randconfig-a004-20211021
x86_64               randconfig-a005-20211021
x86_64               randconfig-a001-20211021
x86_64               randconfig-a006-20211021
x86_64               randconfig-a003-20211021
x86_64               randconfig-a013-20211022
x86_64               randconfig-a015-20211022
x86_64               randconfig-a011-20211022
x86_64               randconfig-a014-20211022
x86_64               randconfig-a016-20211022
x86_64               randconfig-a012-20211022
hexagon              randconfig-r045-20211021
hexagon              randconfig-r041-20211021
riscv                randconfig-r042-20211022
s390                 randconfig-r044-20211022
hexagon              randconfig-r045-20211022
hexagon              randconfig-r041-20211022

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
