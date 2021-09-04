Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D71C400A9F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350933AbhIDJiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 05:38:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:32659 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234915AbhIDJiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 05:38:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="241895200"
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="241895200"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2021 02:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="692795349"
Received: from lkp-server01.sh.intel.com (HELO 2115029a3e5c) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Sep 2021 02:36:55 -0700
Received: from kbuild by 2115029a3e5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mMS6Z-0001O3-5e; Sat, 04 Sep 2021 09:36:55 +0000
Date:   Sat, 04 Sep 2021 17:36:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 d66e3edee7af87fe212df611ab9846b987a5070f
Message-ID: <61333e32.vvUoD1nhmOfb7Gxo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: d66e3edee7af87fe212df611ab9846b987a5070f  futex: Remove unused variable 'vpid' in futex_proxy_trylock_atomic()

elapsed time: 725m

configs tested: 119
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210904
sh                           se7343_defconfig
um                               alldefconfig
powerpc                     kilauea_defconfig
mips                        workpad_defconfig
sh                   sh7770_generic_defconfig
arm                         s5pv210_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                  colibri_pxa270_defconfig
arm                          simpad_defconfig
h8300                     edosk2674_defconfig
powerpc                      pasemi_defconfig
s390                             allmodconfig
powerpc                     mpc83xx_defconfig
powerpc                      makalu_defconfig
arm                        clps711x_defconfig
um                                  defconfig
m68k                             allyesconfig
mips                         rt305x_defconfig
mips                        maltaup_defconfig
arm                           viper_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                      pxa255-idp_defconfig
ia64                         bigsur_defconfig
nds32                            alldefconfig
powerpc                          g5_defconfig
arm                         lubbock_defconfig
h8300                    h8300h-sim_defconfig
openrisc                 simple_smp_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            lart_defconfig
sh                         ecovec24_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7264_defconfig
powerpc                     tqm5200_defconfig
mips                    maltaup_xpa_defconfig
xtensa                       common_defconfig
arm                  randconfig-c002-20210904
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
x86_64               randconfig-a006-20210904
x86_64               randconfig-a004-20210904
x86_64               randconfig-a003-20210904
x86_64               randconfig-a005-20210904
x86_64               randconfig-a001-20210904
x86_64               randconfig-a002-20210904
i386                 randconfig-a005-20210904
i386                 randconfig-a004-20210904
i386                 randconfig-a006-20210904
i386                 randconfig-a002-20210904
i386                 randconfig-a003-20210904
i386                 randconfig-a001-20210904
arc                  randconfig-r043-20210904
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
s390                 randconfig-c005-20210904
mips                 randconfig-c004-20210904
powerpc              randconfig-c003-20210904
x86_64               randconfig-c007-20210904
i386                 randconfig-c001-20210904
arm                  randconfig-c002-20210904
riscv                randconfig-c006-20210904
x86_64               randconfig-a011-20210904
x86_64               randconfig-a016-20210904
x86_64               randconfig-a012-20210904
x86_64               randconfig-a015-20210904
x86_64               randconfig-a014-20210904
x86_64               randconfig-a013-20210904
i386                 randconfig-a012-20210904
i386                 randconfig-a015-20210904
i386                 randconfig-a011-20210904
i386                 randconfig-a013-20210904
i386                 randconfig-a014-20210904
i386                 randconfig-a016-20210904

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
