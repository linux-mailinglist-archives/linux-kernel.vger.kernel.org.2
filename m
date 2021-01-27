Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB7C305621
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhA0IuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:50:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:26216 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhA0Irp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:47:45 -0500
IronPort-SDR: o2XKfvX519nD2g9oaTiTOw8g8MUA9uh/ARYbbcSiHJLU+c92vLnK9rDLaPRkJOghUtuRZn0GAy
 M7Rm46DrWszA==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="167134756"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="167134756"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 00:46:44 -0800
IronPort-SDR: M1OOinZFSBTwVI4+3ZJhjZPcCHhvEPLMw0LqvMInuxZThwEf+BFSVlNVtcQh9IKrK2uOhsIPX5
 9fggA7L0CfUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="394011932"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2021 00:46:44 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l4gTL-0001TC-PD; Wed, 27 Jan 2021 08:46:43 +0000
Date:   Wed, 27 Jan 2021 16:46:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:for-mingo] BUILD SUCCESS
 5eb0ba4459b72a445b5d595e96d65c9ce3825f62
Message-ID: <60112868.Zh/E29sxS0H7BOkZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
branch HEAD: 5eb0ba4459b72a445b5d595e96d65c9ce3825f62  Merge branch 'clocksource.2021.01.12a' into HEAD

elapsed time: 721m

configs tested: 173
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          landisk_defconfig
powerpc                     redwood_defconfig
m68k                          atari_defconfig
m68k                             allmodconfig
powerpc                     tqm8540_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                        warp_defconfig
powerpc                     tqm8560_defconfig
powerpc                      ppc44x_defconfig
powerpc                      ep88xc_defconfig
sh                          kfr2r09_defconfig
powerpc                    klondike_defconfig
powerpc                    mvme5100_defconfig
mips                           ip22_defconfig
openrisc                    or1ksim_defconfig
arm                        clps711x_defconfig
mips                     decstation_defconfig
powerpc                  storcenter_defconfig
arm                          ep93xx_defconfig
powerpc                         wii_defconfig
sh                           se7780_defconfig
sh                             sh03_defconfig
arm                      footbridge_defconfig
m68k                        m5272c3_defconfig
sh                        edosk7705_defconfig
mips                         tb0287_defconfig
sh                          polaris_defconfig
xtensa                    smp_lx200_defconfig
parisc                generic-32bit_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     kilauea_defconfig
powerpc                     tqm8541_defconfig
arm                            lart_defconfig
openrisc                            defconfig
c6x                         dsk6455_defconfig
powerpc                        cell_defconfig
riscv                            allmodconfig
xtensa                    xip_kc705_defconfig
arm                       imx_v6_v7_defconfig
arm                        realview_defconfig
arm                         vf610m4_defconfig
alpha                               defconfig
mips                           ci20_defconfig
mips                         rt305x_defconfig
mips                  cavium_octeon_defconfig
arm                       netwinder_defconfig
powerpc                      katmai_defconfig
arm                           viper_defconfig
arm                        trizeps4_defconfig
arm                  colibri_pxa300_defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                                 defconfig
powerpc                     taishan_defconfig
arm                            hisi_defconfig
powerpc                    adder875_defconfig
arm                       cns3420vb_defconfig
um                            kunit_defconfig
sh                         ap325rxa_defconfig
sh                           se7751_defconfig
arm                           h5000_defconfig
mips                           ip32_defconfig
microblaze                          defconfig
arc                     nsimosci_hs_defconfig
arm                       aspeed_g4_defconfig
powerpc                     pq2fads_defconfig
powerpc                     powernv_defconfig
arm                          pcm027_defconfig
mips                       capcella_defconfig
arm                             pxa_defconfig
parisc                           alldefconfig
arm                         lubbock_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                        spear6xx_defconfig
powerpc                           allnoconfig
arm                        spear3xx_defconfig
sh                           se7750_defconfig
sh                          rsk7264_defconfig
m68k                          amiga_defconfig
powerpc                     asp8347_defconfig
powerpc                       ppc64_defconfig
arc                         haps_hs_defconfig
mips                        nlm_xlr_defconfig
arm                        neponset_defconfig
arm                        multi_v7_defconfig
arm                            qcom_defconfig
arm                        shmobile_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     pseries_defconfig
arm                          lpd270_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a001-20210126
i386                 randconfig-a002-20210126
i386                 randconfig-a004-20210126
i386                 randconfig-a006-20210126
i386                 randconfig-a003-20210126
i386                 randconfig-a005-20210126
x86_64               randconfig-a012-20210126
x86_64               randconfig-a016-20210126
x86_64               randconfig-a015-20210126
x86_64               randconfig-a011-20210126
x86_64               randconfig-a013-20210126
x86_64               randconfig-a014-20210126
x86_64               randconfig-a003-20210127
x86_64               randconfig-a002-20210127
x86_64               randconfig-a001-20210127
x86_64               randconfig-a005-20210127
x86_64               randconfig-a006-20210127
x86_64               randconfig-a004-20210127
i386                 randconfig-a013-20210126
i386                 randconfig-a011-20210126
i386                 randconfig-a012-20210126
i386                 randconfig-a015-20210126
i386                 randconfig-a014-20210126
i386                 randconfig-a016-20210126
i386                 randconfig-a013-20210127
i386                 randconfig-a011-20210127
i386                 randconfig-a012-20210127
i386                 randconfig-a015-20210127
i386                 randconfig-a014-20210127
i386                 randconfig-a016-20210127
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210126
x86_64               randconfig-a002-20210126
x86_64               randconfig-a001-20210126
x86_64               randconfig-a005-20210126
x86_64               randconfig-a006-20210126
x86_64               randconfig-a004-20210126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
