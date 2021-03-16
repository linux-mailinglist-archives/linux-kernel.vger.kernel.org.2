Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB60333CDC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhCPGHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:07:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:20883 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232773AbhCPGHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:07:03 -0400
IronPort-SDR: jWpn1NU5OXHhMUpmJ2U/Se1N8D/sS8wcaeIEY+aqFAra0r65OzYdV+/tJP0grGwn+bsVazppzV
 cEttW6NBKbig==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="250571548"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="250571548"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 23:07:03 -0700
IronPort-SDR: x8PNH/yYHYecSn8Y9TyEB4O1lhXJN53sogkPmizSkIHS9/oJNrxFISlz7vJwRYMFH8Op0OwSaj
 B3JHycfUgJvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="590545374"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2021 23:07:01 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lM2r6-00001L-Ss; Tue, 16 Mar 2021 06:07:00 +0000
Date:   Tue, 16 Mar 2021 14:06:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4aabf1d2f23189cabd453e10473ed5d6cce6bf5f
Message-ID: <60504ada.2Jin/dLtU3HDxQv7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4aabf1d2f23189cabd453e10473ed5d6cce6bf5f  Merge 'x86/cpu' into master

elapsed time: 724m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
h8300                     edosk2674_defconfig
powerpc                    amigaone_defconfig
powerpc                 linkstation_defconfig
m68k                        m5407c3_defconfig
arc                 nsimosci_hs_smp_defconfig
openrisc                 simple_smp_defconfig
arm                       mainstone_defconfig
m68k                        mvme16x_defconfig
arm                         mv78xx0_defconfig
mips                       rbtx49xx_defconfig
h8300                    h8300h-sim_defconfig
h8300                               defconfig
arm                        realview_defconfig
s390                             alldefconfig
powerpc                     stx_gp3_defconfig
mips                malta_kvm_guest_defconfig
sh                         ap325rxa_defconfig
mips                     cu1000-neo_defconfig
mips                           xway_defconfig
arm                       versatile_defconfig
arm                         lpc32xx_defconfig
sh                            shmin_defconfig
mips                           ip32_defconfig
parisc                           alldefconfig
ia64                                defconfig
sh                           se7712_defconfig
arm                         lubbock_defconfig
x86_64                              defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      tqm8xx_defconfig
xtensa                         virt_defconfig
sh                           se7722_defconfig
arm                     eseries_pxa_defconfig
m68k                       bvme6000_defconfig
powerpc                     rainier_defconfig
parisc                generic-32bit_defconfig
arm                        mini2440_defconfig
i386                                defconfig
powerpc                     mpc5200_defconfig
mips                      fuloong2e_defconfig
parisc                generic-64bit_defconfig
arm                            hisi_defconfig
powerpc                 mpc836x_mds_defconfig
mips                         rt305x_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     mpc512x_defconfig
ia64                             alldefconfig
csky                                defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      cm5200_defconfig
arm                            xcep_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                   motionpro_defconfig
arm                           h3600_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          g5_defconfig
arm                         orion5x_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      arches_defconfig
arm                          pcm027_defconfig
xtensa                           alldefconfig
mips                          ath79_defconfig
mips                       lemote2f_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                               tinyconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210315
x86_64               randconfig-a001-20210315
x86_64               randconfig-a005-20210315
x86_64               randconfig-a004-20210315
x86_64               randconfig-a002-20210315
x86_64               randconfig-a003-20210315
i386                 randconfig-a001-20210315
i386                 randconfig-a005-20210315
i386                 randconfig-a003-20210315
i386                 randconfig-a002-20210315
i386                 randconfig-a004-20210315
i386                 randconfig-a006-20210315
i386                 randconfig-a013-20210315
i386                 randconfig-a016-20210315
i386                 randconfig-a011-20210315
i386                 randconfig-a012-20210315
i386                 randconfig-a014-20210315
i386                 randconfig-a015-20210315
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210315
x86_64               randconfig-a016-20210315
x86_64               randconfig-a013-20210315
x86_64               randconfig-a015-20210315
x86_64               randconfig-a014-20210315
x86_64               randconfig-a012-20210315

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
