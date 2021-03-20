Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E9C342C35
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCTLbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:31:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:32632 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhCTLaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:30:23 -0400
IronPort-SDR: orAbxLITqOXlSqwmbjyFrLv265jae3NEI8Rk0PWSCnyZPvKJRjt/xJfPN8mBzFloHZvera/2eS
 9A9Uv48NbWag==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="254017129"
X-IronPort-AV: E=Sophos;i="5.81,264,1610438400"; 
   d="scan'208";a="254017129"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2021 00:01:11 -0700
IronPort-SDR: ELnEqCh+CfmbNq0pF2iNAzJn195vgSrTFGXeZQGbgQ1F4jPS419JxOmt49gRakzzwTUIPbQ0tc
 57j7+9Z03OYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,264,1610438400"; 
   d="scan'208";a="412512378"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2021 00:01:10 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lNVbh-0002Pt-L6; Sat, 20 Mar 2021 07:01:09 +0000
Date:   Sat, 20 Mar 2021 15:00:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 4284f7acb78bfb0e0c26a2b78e2b2c3d68fccd6f
Message-ID: <60559da7.aucWROKoCl0J/Zpg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 4284f7acb78bfb0e0c26a2b78e2b2c3d68fccd6f  selftests/sgx: Improve error detection and messages

elapsed time: 720m

configs tested: 160
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
mips                         tb0287_defconfig
powerpc                     tqm8541_defconfig
arm                         socfpga_defconfig
arc                              alldefconfig
powerpc                  iss476-smp_defconfig
sh                          lboxre2_defconfig
s390                          debug_defconfig
sh                        sh7763rdp_defconfig
arm                            pleb_defconfig
arm                        vexpress_defconfig
arm                        trizeps4_defconfig
mips                malta_kvm_guest_defconfig
arm                         lubbock_defconfig
arm                          ep93xx_defconfig
sh                            hp6xx_defconfig
arm                  colibri_pxa300_defconfig
arm                            qcom_defconfig
powerpc                     redwood_defconfig
powerpc                   lite5200b_defconfig
powerpc                 canyonlands_defconfig
arm                       aspeed_g4_defconfig
mips                       bmips_be_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7785lcr_defconfig
powerpc                  mpc885_ads_defconfig
arm                         cm_x300_defconfig
powerpc                     pq2fads_defconfig
mips                     loongson1c_defconfig
m68k                           sun3_defconfig
mips                        bcm63xx_defconfig
s390                       zfcpdump_defconfig
powerpc                       eiger_defconfig
powerpc                     tqm8548_defconfig
mips                      pistachio_defconfig
riscv                    nommu_k210_defconfig
sh                      rts7751r2d1_defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
powerpc                     ksi8560_defconfig
powerpc                     taishan_defconfig
powerpc                        warp_defconfig
arm                        mvebu_v7_defconfig
xtensa                  audio_kc705_defconfig
m68k                        stmark2_defconfig
powerpc                       maple_defconfig
arm                       mainstone_defconfig
sparc64                             defconfig
powerpc                      acadia_defconfig
powerpc                      pmac32_defconfig
sh                          landisk_defconfig
parisc                           alldefconfig
arc                      axs103_smp_defconfig
sh                   rts7751r2dplus_defconfig
mips                          ath25_defconfig
powerpc                        cell_defconfig
powerpc                     tqm8560_defconfig
powerpc                     tqm5200_defconfig
powerpc                 linkstation_defconfig
arm                       versatile_defconfig
mips                        workpad_defconfig
arm                         axm55xx_defconfig
arm64                            alldefconfig
arm                        neponset_defconfig
mips                      maltaaprp_defconfig
powerpc                         ps3_defconfig
powerpc                    sam440ep_defconfig
m68k                          atari_defconfig
mips                           xway_defconfig
powerpc                      ppc64e_defconfig
powerpc                     mpc512x_defconfig
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
arc                                 defconfig
h8300                            allyesconfig
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
i386                 randconfig-a013-20210319
i386                 randconfig-a016-20210319
i386                 randconfig-a011-20210319
i386                 randconfig-a014-20210319
i386                 randconfig-a015-20210319
i386                 randconfig-a012-20210319
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
