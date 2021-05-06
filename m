Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B48374C4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEFAXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:23:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:58014 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhEFAXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:23:41 -0400
IronPort-SDR: VKLFB+kEdHbaPWVvDDanounX6vhEWWgJQyYClsjdQsuW6ai4ssGiqPRruF2NHYI+eSW06LtE86
 UOsnV6hiTnxg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="177895948"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="177895948"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 17:22:44 -0700
IronPort-SDR: sOY/jDRTElK8wD0XtYDgFseGvelpO6VXs4e39tGdrWM4M9EaniWBug73QL8eB4Ca2YXlivV+jF
 xh8CVpGeG+Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="464442359"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2021 17:22:39 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1leRmp-000AEy-53; Thu, 06 May 2021 00:22:39 +0000
Date:   Thu, 06 May 2021 08:22:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 025768a966a3dde8455de46d1f121a51bacb6a77
Message-ID: <609336af.JJcEmNfI7MSV9ziP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 025768a966a3dde8455de46d1f121a51bacb6a77  x86/cpu: Use alternative to generate the TASK_SIZE_MAX constant

elapsed time: 724m

configs tested: 136
configs skipped: 24

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
sparc                       sparc32_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                 simple_smp_defconfig
powerpc                      makalu_defconfig
powerpc                  mpc885_ads_defconfig
sh                           sh2007_defconfig
arm                          pxa168_defconfig
arm                         orion5x_defconfig
sh                          rsk7201_defconfig
powerpc                     tqm8541_defconfig
mips                           gcw0_defconfig
h8300                     edosk2674_defconfig
xtensa                          iss_defconfig
ia64                         bigsur_defconfig
sh                          rsk7203_defconfig
xtensa                  audio_kc705_defconfig
arm                        multi_v5_defconfig
arm                      jornada720_defconfig
arm                              alldefconfig
arm                         cm_x300_defconfig
arm                        vexpress_defconfig
arm                        neponset_defconfig
arm                          imote2_defconfig
powerpc                     mpc5200_defconfig
mips                     loongson1b_defconfig
arm                          iop32x_defconfig
arm                         nhk8815_defconfig
arm                        spear6xx_defconfig
arm                           h3600_defconfig
powerpc                    mvme5100_defconfig
microblaze                          defconfig
powerpc                  mpc866_ads_defconfig
mips                     cu1830-neo_defconfig
powerpc                     rainier_defconfig
sh                        dreamcast_defconfig
sh                     sh7710voipgw_defconfig
arm                       imx_v6_v7_defconfig
sh                   sh7770_generic_defconfig
mips                       rbtx49xx_defconfig
sh                           se7343_defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                             pxa_defconfig
powerpc                      ep88xc_defconfig
sparc                            allyesconfig
powerpc                    sam440ep_defconfig
powerpc                      tqm8xx_defconfig
sh                                  defconfig
arm                       versatile_defconfig
h8300                               defconfig
xtensa                  cadence_csp_defconfig
powerpc                      mgcoge_defconfig
mips                    maltaup_xpa_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                           sunxi_defconfig
mips                        workpad_defconfig
arm64                               defconfig
microblaze                      mmu_defconfig
mips                      maltaaprp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210505
x86_64               randconfig-a003-20210505
x86_64               randconfig-a005-20210505
x86_64               randconfig-a002-20210505
x86_64               randconfig-a006-20210505
x86_64               randconfig-a004-20210505
i386                 randconfig-a003-20210505
i386                 randconfig-a006-20210505
i386                 randconfig-a001-20210505
i386                 randconfig-a005-20210505
i386                 randconfig-a004-20210505
i386                 randconfig-a002-20210505
i386                 randconfig-a015-20210505
i386                 randconfig-a013-20210505
i386                 randconfig-a016-20210505
i386                 randconfig-a014-20210505
i386                 randconfig-a012-20210505
i386                 randconfig-a011-20210505
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210505
x86_64               randconfig-a015-20210505
x86_64               randconfig-a012-20210505
x86_64               randconfig-a013-20210505
x86_64               randconfig-a011-20210505
x86_64               randconfig-a016-20210505

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
