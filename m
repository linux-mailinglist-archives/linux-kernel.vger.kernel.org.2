Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D853D0514
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 01:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhGTWba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:31:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:5614 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233607AbhGTWbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:31:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="208224572"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="208224572"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 16:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="469930495"
Received: from lkp-server02.sh.intel.com (HELO 1b5a72ed9419) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2021 16:11:34 -0700
Received: from kbuild by 1b5a72ed9419 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5yth-0000RX-VG; Tue, 20 Jul 2021 23:11:33 +0000
Date:   Wed, 21 Jul 2021 07:11:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 ff5a6a3550cef4a272fee19520a13699343b6a47
Message-ID: <60f75815.yhi2/WbphmMS3S1x%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: ff5a6a3550cef4a272fee19520a13699343b6a47  Merge branch 'timers/urgent' of git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks into timers/urgent

elapsed time: 724m

configs tested: 147
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         cm_x300_defconfig
sh                          rsk7264_defconfig
sh                           se7724_defconfig
powerpc                     ep8248e_defconfig
powerpc                     pseries_defconfig
powerpc                 mpc834x_mds_defconfig
arm                  colibri_pxa300_defconfig
arm                       netwinder_defconfig
powerpc                    gamecube_defconfig
riscv                               defconfig
m68k                           sun3_defconfig
sh                            hp6xx_defconfig
arm                         lpc18xx_defconfig
x86_64                           allyesconfig
powerpc                      acadia_defconfig
mips                      pistachio_defconfig
mips                             allmodconfig
sh                           se7343_defconfig
powerpc                     stx_gp3_defconfig
mips                           ci20_defconfig
powerpc                  storcenter_defconfig
powerpc                     tqm8548_defconfig
arm                        multi_v5_defconfig
mips                          ath25_defconfig
sh                           se7721_defconfig
ia64                             allmodconfig
arm                           corgi_defconfig
powerpc                 linkstation_defconfig
m68k                        m5407c3_defconfig
sh                   secureedge5410_defconfig
powerpc                     sequoia_defconfig
arm                        mvebu_v5_defconfig
arm                         lubbock_defconfig
arm                   milbeaut_m10v_defconfig
um                               alldefconfig
powerpc                  iss476-smp_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
sh                          rsk7203_defconfig
arm                         lpc32xx_defconfig
sh                              ul2_defconfig
sh                          urquell_defconfig
sh                          r7780mp_defconfig
powerpc                     rainier_defconfig
powerpc                         wii_defconfig
sh                          rsk7201_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                               j2_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            mmp2_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
arc                      axs103_smp_defconfig
xtensa                       common_defconfig
powerpc                     kilauea_defconfig
powerpc                   motionpro_defconfig
m68k                          atari_defconfig
sh                ecovec24-romimage_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        trizeps4_defconfig
mips                         tb0287_defconfig
sh                          landisk_defconfig
arm                         socfpga_defconfig
powerpc64                           defconfig
powerpc                      cm5200_defconfig
arm                         palmz72_defconfig
x86_64                            allnoconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210720
x86_64               randconfig-a006-20210720
x86_64               randconfig-a001-20210720
x86_64               randconfig-a005-20210720
x86_64               randconfig-a004-20210720
x86_64               randconfig-a002-20210720
i386                 randconfig-a005-20210720
i386                 randconfig-a003-20210720
i386                 randconfig-a004-20210720
i386                 randconfig-a002-20210720
i386                 randconfig-a001-20210720
i386                 randconfig-a006-20210720
i386                 randconfig-a005-20210719
i386                 randconfig-a004-20210719
i386                 randconfig-a006-20210719
i386                 randconfig-a001-20210719
i386                 randconfig-a003-20210719
i386                 randconfig-a002-20210719
i386                 randconfig-a016-20210720
i386                 randconfig-a013-20210720
i386                 randconfig-a012-20210720
i386                 randconfig-a014-20210720
i386                 randconfig-a011-20210720
i386                 randconfig-a015-20210720
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210720
x86_64               randconfig-a011-20210720
x86_64               randconfig-a016-20210720
x86_64               randconfig-a013-20210720
x86_64               randconfig-a014-20210720
x86_64               randconfig-a012-20210720
x86_64               randconfig-a015-20210720

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
