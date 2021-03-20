Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57C0342AA3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 06:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCTFIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 01:08:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:45830 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhCTFIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:08:04 -0400
IronPort-SDR: EEJ6ZsrBNYOkkW6QhE1QppeskQFBHBF9AOzFnPtU405X81CnbXhuFnTRpHMpkyth1EAYcR3XyH
 zz8edD/mtXeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="186670238"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="186670238"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 22:08:04 -0700
IronPort-SDR: ttO7fPQgtAHz7xNb7JP/VBKFIi3NsMY3oW+CR43bd0uM3FYusPVOQmZ+FXlWbRH9HL6AvUbhcR
 Vnplm0fWl3kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="441538462"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2021 22:08:02 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lNTqE-0002MG-9j; Sat, 20 Mar 2021 05:08:02 +0000
Date:   Sat, 20 Mar 2021 13:07:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 68644c505bc74972676d4557b060546d4c6e9326
Message-ID: <6055830a.wkAu/9NsrsdmlgeL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: 68644c505bc74972676d4557b060546d4c6e9326  Merge branch 'locking/urgent'

elapsed time: 970m

configs tested: 128
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
arm                            qcom_defconfig
m68k                       m5249evb_defconfig
powerpc                     pseries_defconfig
powerpc                      ppc64e_defconfig
arm                          badge4_defconfig
arm                           sunxi_defconfig
xtensa                generic_kc705_defconfig
arm                          exynos_defconfig
arm                          lpd270_defconfig
m68k                             allyesconfig
m68k                            q40_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v7_defconfig
sh                        edosk7705_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     tqm8548_defconfig
arm                         at91_dt_defconfig
sh                          r7780mp_defconfig
powerpc                      ppc6xx_defconfig
mips                          rb532_defconfig
openrisc                 simple_smp_defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
powerpc                       eiger_defconfig
sh                           se7750_defconfig
mips                     decstation_defconfig
mips                        qi_lb60_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          landisk_defconfig
parisc                           alldefconfig
arc                      axs103_smp_defconfig
powerpc                      pmac32_defconfig
sh                   rts7751r2dplus_defconfig
arm                    vt8500_v6_v7_defconfig
m68k                           sun3_defconfig
ia64                            zx1_defconfig
powerpc                     skiroot_defconfig
powerpc                     ksi8560_defconfig
sh                     magicpanelr2_defconfig
mips                        workpad_defconfig
arm                         axm55xx_defconfig
arm64                            alldefconfig
arm                        neponset_defconfig
mips                      maltaaprp_defconfig
arm                        clps711x_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                               allmodconfig
parisc                generic-64bit_defconfig
mips                        maltaup_defconfig
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
i386                 randconfig-a001-20210319
i386                 randconfig-a005-20210319
i386                 randconfig-a003-20210319
i386                 randconfig-a002-20210319
i386                 randconfig-a006-20210319
i386                 randconfig-a004-20210319
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
riscv                    nommu_k210_defconfig
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
