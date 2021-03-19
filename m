Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E88E3419F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCSK1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:27:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:31528 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhCSK10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:27:26 -0400
IronPort-SDR: ZPF9BIJi1Ft0sg1K19AfukEoSGilfc2kaHbr42JMQNmuRp5x8wIhZvi5lV2+Xa6t0V29129NRC
 0Kb+Ol8M0gZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="176998377"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="176998377"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 03:27:25 -0700
IronPort-SDR: rbPQigoU3PlVbO+ewiwCCh3wZKVMFUPc/7uXWKn96SMnSwHdynogt6aLVeqLALkV9ms0egaD3T
 E/3j/o9kUcvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="389590682"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 19 Mar 2021 03:27:24 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lNCLj-0001l0-NY; Fri, 19 Mar 2021 10:27:23 +0000
Date:   Fri, 19 Mar 2021 18:26:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 f15a0a732aefb46f999c2a8aa8f9f16e71cec5b2
Message-ID: <60547c67.LV3ZdWGiJYWHhzsC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/seves
branch HEAD: f15a0a732aefb46f999c2a8aa8f9f16e71cec5b2  x86/sev-es: Replace open-coded hlt-loops with sev_es_terminate()

possible Warning in current branch:

arch/x86/kernel/sev-es.c:1377 safe_stack_exc_vmm_communication() warn: ignoring unreachable code.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-m001-20210318
    `-- arch-x86-kernel-sev-es.c-safe_stack_exc_vmm_communication()-warn:ignoring-unreachable-code.

elapsed time: 724m

configs tested: 140
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
arc                          axs101_defconfig
sh                                  defconfig
ia64                        generic_defconfig
m68k                        mvme147_defconfig
riscv                    nommu_k210_defconfig
arc                                 defconfig
h8300                    h8300h-sim_defconfig
powerpc                     tqm8560_defconfig
mips                        nlm_xlp_defconfig
mips                     loongson1b_defconfig
m68k                        m5407c3_defconfig
sh                           se7712_defconfig
m68k                       m5275evb_defconfig
arm                           sunxi_defconfig
s390                          debug_defconfig
mips                         bigsur_defconfig
powerpc                         wii_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                            mps2_defconfig
ia64                             allmodconfig
powerpc                  storcenter_defconfig
x86_64                              defconfig
s390                             alldefconfig
arm                            dove_defconfig
mips                            e55_defconfig
xtensa                generic_kc705_defconfig
arm                          exynos_defconfig
arm                          lpd270_defconfig
powerpc                 linkstation_defconfig
xtensa                  audio_kc705_defconfig
mips                        vocore2_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     tqm8548_defconfig
powerpc                    mvme5100_defconfig
arm64                            alldefconfig
ia64                          tiger_defconfig
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
xtensa                         virt_defconfig
powerpc                 mpc832x_rdb_defconfig
csky                             alldefconfig
sh                   sh7724_generic_defconfig
mips                malta_qemu_32r6_defconfig
mips                          rb532_defconfig
sh                           se7721_defconfig
sh                     magicpanelr2_defconfig
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
powerpc                     redwood_defconfig
powerpc                 mpc8540_ads_defconfig
arm                            hisi_defconfig
mips                        nlm_xlr_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
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
