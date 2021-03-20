Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A85D342C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCTLhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:37:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:35314 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhCTLhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:37:23 -0400
IronPort-SDR: elonyAyXQakfgHiXzEAs7Yuq/Z0PURYCHCgMJ0R1FWNzsrkMJMkaPhTVhTggorlOofvh+ccbs7
 wFzHKrbblLvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="189417985"
X-IronPort-AV: E=Sophos;i="5.81,264,1610438400"; 
   d="scan'208";a="189417985"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2021 04:37:23 -0700
IronPort-SDR: kGfAQY2s2nmGP3osXfB9A1tApJ++aqWed80Sz6Elc5Lca442gKMHmsVrrCtUKtTCFIZrrq8VvL
 TqPXS3Ib7VTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,264,1610438400"; 
   d="scan'208";a="512766747"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2021 04:37:22 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lNZuz-0002Z4-Da; Sat, 20 Mar 2021 11:37:21 +0000
Date:   Sat, 20 Mar 2021 19:36:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 c93a5e20c3c2dabef8ea360a3d3f18c6f68233ab
Message-ID: <6055de4d.d81wl7NXAKzDU4+P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: c93a5e20c3c2dabef8ea360a3d3f18c6f68233ab  genirq/matrix: Prevent allocation counter corruption

elapsed time: 815m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                         tb0287_defconfig
powerpc                     tqm8541_defconfig
arm                         socfpga_defconfig
arc                              alldefconfig
powerpc                  iss476-smp_defconfig
sh                          lboxre2_defconfig
mips                malta_kvm_guest_defconfig
arm                         lubbock_defconfig
arm                          ep93xx_defconfig
sh                            hp6xx_defconfig
arm                  colibri_pxa300_defconfig
arm                            qcom_defconfig
powerpc                     redwood_defconfig
nds32                             allnoconfig
powerpc                   lite5200b_defconfig
powerpc                 canyonlands_defconfig
ia64                             allmodconfig
m68k                            q40_defconfig
arm                   milbeaut_m10v_defconfig
arm                        neponset_defconfig
arm                        multi_v7_defconfig
sh                        edosk7705_defconfig
powerpc                  mpc885_ads_defconfig
arm                         cm_x300_defconfig
powerpc                     pq2fads_defconfig
mips                     loongson1c_defconfig
m68k                           sun3_defconfig
mips                        bcm63xx_defconfig
arm                    vt8500_v6_v7_defconfig
arc                            hsdk_defconfig
arm                           u8500_defconfig
arm                          imote2_defconfig
powerpc                     taishan_defconfig
powerpc                        warp_defconfig
arm                        mvebu_v7_defconfig
xtensa                  audio_kc705_defconfig
m68k                        stmark2_defconfig
arm                       aspeed_g4_defconfig
powerpc                       maple_defconfig
arm                       mainstone_defconfig
sparc64                             defconfig
powerpc                      acadia_defconfig
powerpc                      pmac32_defconfig
sh                           se7750_defconfig
mips                     decstation_defconfig
mips                        qi_lb60_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                            zx1_defconfig
powerpc                     skiroot_defconfig
powerpc                     ksi8560_defconfig
sh                     magicpanelr2_defconfig
powerpc                     tqm5200_defconfig
parisc                              defconfig
powerpc                 linkstation_defconfig
s390                             allmodconfig
arm                       versatile_defconfig
arm                        clps711x_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                               allmodconfig
parisc                generic-64bit_defconfig
mips                        maltaup_defconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
x86_64               randconfig-a011-20210318
x86_64               randconfig-a016-20210318
x86_64               randconfig-a013-20210318
x86_64               randconfig-a015-20210318
x86_64               randconfig-a014-20210318
x86_64               randconfig-a012-20210318
i386                 randconfig-a013-20210318
i386                 randconfig-a016-20210318
i386                 randconfig-a011-20210318
i386                 randconfig-a014-20210318
i386                 randconfig-a015-20210318
i386                 randconfig-a012-20210318
i386                 randconfig-a013-20210319
i386                 randconfig-a016-20210319
i386                 randconfig-a011-20210319
i386                 randconfig-a014-20210319
i386                 randconfig-a015-20210319
i386                 randconfig-a012-20210319
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210318
x86_64               randconfig-a001-20210318
x86_64               randconfig-a005-20210318
x86_64               randconfig-a002-20210318
x86_64               randconfig-a003-20210318
x86_64               randconfig-a004-20210318

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
