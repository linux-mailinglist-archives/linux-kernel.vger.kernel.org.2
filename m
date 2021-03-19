Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C98034135C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhCSDJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:09:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:18178 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhCSDJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:09:08 -0400
IronPort-SDR: vcdKww3Sf7j3ACe+SCZp3cWi6kcJyJhAB0dbhvF6WujU0fNjy7ne2VRTa6f8wGlLqSy/HTcY3s
 46eTm1gTnZHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="189907059"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="189907059"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 20:09:08 -0700
IronPort-SDR: 9V8Zj6KycH4PonMKGUOh9HTJmoeA667x5lbFQQKf9t4I7B+BMORToB0gB9K887OcCyA9vJw4TB
 1gbXcLx/xCTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="591708236"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2021 20:09:06 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lN5Va-0001Xk-4G; Fri, 19 Mar 2021 03:09:06 +0000
Date:   Fri, 19 Mar 2021 11:08:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 d9f6e12fb0b7fcded0bac34b8293ec46f80dfc33
Message-ID: <605415af.AgmqmQDk9l8XL8e8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: d9f6e12fb0b7fcded0bac34b8293ec46f80dfc33  x86: Fix various typos in comments

elapsed time: 722m

configs tested: 151
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
i386                             allyesconfig
riscv                            allyesconfig
mips                  maltasmvp_eva_defconfig
sh                               j2_defconfig
mips                       bmips_be_defconfig
arm                          collie_defconfig
arc                          axs101_defconfig
sh                                  defconfig
ia64                        generic_defconfig
m68k                        mvme147_defconfig
riscv                    nommu_k210_defconfig
h8300                    h8300h-sim_defconfig
powerpc                     tqm8560_defconfig
mips                        nlm_xlp_defconfig
arc                                 defconfig
mips                     loongson1b_defconfig
m68k                        m5407c3_defconfig
sh                           se7712_defconfig
m68k                       m5275evb_defconfig
arm                           sunxi_defconfig
xtensa                generic_kc705_defconfig
arm                          exynos_defconfig
arm                          lpd270_defconfig
m68k                             allyesconfig
ia64                             allmodconfig
powerpc                 linkstation_defconfig
xtensa                  audio_kc705_defconfig
mips                        vocore2_defconfig
arm                         at91_dt_defconfig
sh                          r7780mp_defconfig
powerpc                      ppc6xx_defconfig
mips                          rb532_defconfig
openrisc                 simple_smp_defconfig
riscv                          rv32_defconfig
powerpc                    mvme5100_defconfig
arm64                            alldefconfig
ia64                          tiger_defconfig
um                           x86_64_defconfig
m68k                       m5208evb_defconfig
ia64                      gensparse_defconfig
sh                            migor_defconfig
powerpc                     kilauea_defconfig
arm                          moxart_defconfig
powerpc                    klondike_defconfig
sh                     magicpanelr2_defconfig
xtensa                    xip_kc705_defconfig
powerpc                       ebony_defconfig
mips                          ath79_defconfig
sh                     sh7710voipgw_defconfig
s390                                defconfig
mips                      maltaaprp_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                       maple_defconfig
powerpc                    adder875_defconfig
sh                          kfr2r09_defconfig
arm                         lpc32xx_defconfig
s390                             alldefconfig
xtensa                         virt_defconfig
powerpc                 mpc832x_rdb_defconfig
csky                             alldefconfig
sh                   sh7724_generic_defconfig
mips                malta_qemu_32r6_defconfig
sh                           se7721_defconfig
nios2                               defconfig
powerpc                    amigaone_defconfig
arm                        mvebu_v5_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                      makalu_defconfig
powerpc                  mpc885_ads_defconfig
m68k                        m5307c3_defconfig
arm                        shmobile_defconfig
mips                      pic32mzda_defconfig
m68k                       m5249evb_defconfig
um                             i386_defconfig
mips                     cu1830-neo_defconfig
powerpc                     pq2fads_defconfig
arm                          pcm027_defconfig
powerpc                      acadia_defconfig
sh                        edosk7705_defconfig
mips                             allyesconfig
powerpc                     tqm8548_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc8540_ads_defconfig
arm                            hisi_defconfig
mips                        nlm_xlr_defconfig
m68k                                defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
