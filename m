Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736B033ED63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhCQJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:48:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:64344 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhCQJsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:48:37 -0400
IronPort-SDR: mtBlkPEhpu9Iw4sQQYI03EJowa3cEZCjSDvzagunI8vogZmI2qyT7zWaNIjhrEdY3NaQbUdzLU
 j9Q9k+YVSdJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="189520501"
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; 
   d="scan'208";a="189520501"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 02:48:36 -0700
IronPort-SDR: 29iKjIxU9ZZUE+Ye8ZBElBvWCtvxHO4s7RBot2TCPd/EmTBO7fvptW4QMym/V6rxn3ZzAH/DS8
 bDQXtejGlR/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; 
   d="scan'208";a="605637540"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Mar 2021 02:48:35 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMSn4-0000cH-M5; Wed, 17 Mar 2021 09:48:34 +0000
Date:   Wed, 17 Mar 2021 17:47:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 de66c932c41f308495ad62bbd8dd6accd05bbb9e
Message-ID: <6051d040.QXxqSWKQesfc6O+B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: de66c932c41f308495ad62bbd8dd6accd05bbb9e  Merge branch 'irq/core'

elapsed time: 1413m

configs tested: 157
configs skipped: 3

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
alpha                            alldefconfig
sh                   secureedge5410_defconfig
arm                        magician_defconfig
xtensa                       common_defconfig
powerpc                        icon_defconfig
powerpc                 mpc837x_rdb_defconfig
s390                       zfcpdump_defconfig
sh                           se7722_defconfig
arm                           h3600_defconfig
mips                          rm200_defconfig
arm                           stm32_defconfig
m68k                       bvme6000_defconfig
arm                         shannon_defconfig
m68k                            q40_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     akebono_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
arm                           u8500_defconfig
xtensa                generic_kc705_defconfig
powerpc                      pasemi_defconfig
arm                            pleb_defconfig
um                             i386_defconfig
mips                       capcella_defconfig
alpha                            allyesconfig
arm                          moxart_defconfig
powerpc                        fsp2_defconfig
mips                        nlm_xlr_defconfig
ia64                             alldefconfig
arm                          imote2_defconfig
arc                          axs103_defconfig
arm                          gemini_defconfig
csky                             alldefconfig
powerpc                       ppc64_defconfig
mips                           ip27_defconfig
sh                          r7785rp_defconfig
arm                         lubbock_defconfig
mips                    maltaup_xpa_defconfig
arm                       spear13xx_defconfig
sh                        edosk7760_defconfig
openrisc                            defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                   bluestone_defconfig
mips                         tb0219_defconfig
powerpc                      ppc6xx_defconfig
arm                         assabet_defconfig
mips                  decstation_64_defconfig
mips                      pistachio_defconfig
powerpc                    sam440ep_defconfig
powerpc                      walnut_defconfig
arm                        vexpress_defconfig
mips                       bmips_be_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     powernv_defconfig
m68k                       m5208evb_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                         tb0287_defconfig
arm                        clps711x_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                          ep93xx_defconfig
powerpc                     mpc512x_defconfig
arm                         orion5x_defconfig
sh                          sdk7780_defconfig
mips                            ar7_defconfig
sh                           se7712_defconfig
powerpc                    amigaone_defconfig
m68k                        m5307c3_defconfig
xtensa                  audio_kc705_defconfig
mips                          rb532_defconfig
arm                       aspeed_g4_defconfig
i386                             alldefconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     pseries_defconfig
arm                        neponset_defconfig
arm                        trizeps4_defconfig
sh                        edosk7705_defconfig
arm                       aspeed_g5_defconfig
arm                            dove_defconfig
arm                  colibri_pxa270_defconfig
arm                       multi_v4t_defconfig
powerpc                    adder875_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
i386                 randconfig-a001-20210316
i386                 randconfig-a005-20210316
i386                 randconfig-a002-20210316
i386                 randconfig-a003-20210316
i386                 randconfig-a004-20210316
i386                 randconfig-a006-20210316
x86_64               randconfig-a011-20210316
x86_64               randconfig-a016-20210316
x86_64               randconfig-a013-20210316
x86_64               randconfig-a014-20210316
x86_64               randconfig-a015-20210316
x86_64               randconfig-a012-20210316
i386                 randconfig-a013-20210316
i386                 randconfig-a016-20210316
i386                 randconfig-a011-20210316
i386                 randconfig-a012-20210316
i386                 randconfig-a015-20210316
i386                 randconfig-a014-20210316
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
x86_64               randconfig-a006-20210316
x86_64               randconfig-a001-20210316
x86_64               randconfig-a005-20210316
x86_64               randconfig-a004-20210316
x86_64               randconfig-a003-20210316
x86_64               randconfig-a002-20210316

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
