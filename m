Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913EF341687
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 08:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhCSHYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 03:24:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:42322 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234414AbhCSHYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:24:18 -0400
IronPort-SDR: bZFGugJnVK6xtk6tqt5R2RTPJingAHq2BGq/rj865RDNgopyQ6FtqTvOztRrcSo7t/AGntQFJl
 NPg46Q1Xzsxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="186495021"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="186495021"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 00:24:17 -0700
IronPort-SDR: wPjy1rhd6v5oEFu6DGEVo1a6SbfOl39UEevwX1UXoNLUgVbBLR3WOEcTaHlpywY+xGZenb+7uP
 xUj6lisRYyrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="372973650"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2021 00:24:15 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lN9UU-0001ex-91; Fri, 19 Mar 2021 07:24:14 +0000
Date:   Fri, 19 Mar 2021 15:23:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS WITH WARNING
 5b8719504e3adf47646273781591ad439b3c3c7a
Message-ID: <60545177./rjkQbNNP64kGgYp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 5b8719504e3adf47646273781591ad439b3c3c7a  x86/sgx: Add a basic NUMA allocation scheme to sgx_alloc_epc_page()

Warning reports:

https://lore.kernel.org/lkml/202103190514.xH7IrKMe-lkp@intel.com

possible Warning in current branch:

arch/x86/kernel/cpu/sgx/main.c:496:3: warning: variable 'nid' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
arch/x86/kernel/cpu/sgx/main.c:496:7: warning: variable 'nid' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- x86_64-randconfig-a001-20210318
|   `-- arch-x86-kernel-cpu-sgx-main.c:warning:variable-nid-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-a002-20210318
|   `-- arch-x86-kernel-cpu-sgx-main.c:warning:variable-nid-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-a003-20210318
|   `-- arch-x86-kernel-cpu-sgx-main.c:warning:variable-nid-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-a004-20210318
|   `-- arch-x86-kernel-cpu-sgx-main.c:warning:variable-nid-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-r004-20210318
|   `-- arch-x86-kernel-cpu-sgx-main.c:warning:variable-nid-is-used-uninitialized-whenever-if-condition-is-false
`-- x86_64-randconfig-r031-20210318
    `-- arch-x86-kernel-cpu-sgx-main.c:warning:variable-nid-is-used-uninitialized-whenever-if-condition-is-false

elapsed time: 721m

configs tested: 120
configs skipped: 54

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
ia64                             allmodconfig
s390                          debug_defconfig
mips                         bigsur_defconfig
powerpc                         wii_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                            mps2_defconfig
powerpc                 linkstation_defconfig
xtensa                  audio_kc705_defconfig
mips                        vocore2_defconfig
powerpc                    ge_imp3a_defconfig
arm                          exynos_defconfig
powerpc                     tqm8548_defconfig
sh                          urquell_defconfig
arm                        mvebu_v5_defconfig
mips                       capcella_defconfig
powerpc                 mpc834x_mds_defconfig
mips                 decstation_r4k_defconfig
sh                          lboxre2_defconfig
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
mips                          rb532_defconfig
sh                           se7721_defconfig
sh                     magicpanelr2_defconfig
powerpc                    amigaone_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                      makalu_defconfig
arm                          pxa3xx_defconfig
m68k                       m5208evb_defconfig
m68k                       bvme6000_defconfig
powerpc                     kmeter1_defconfig
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
