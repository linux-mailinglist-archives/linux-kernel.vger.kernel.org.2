Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4343188DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhBKK6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:58:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:5167 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230011AbhBKKsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:48:35 -0500
IronPort-SDR: AZS8tJf7lopxhpK8qxJgSghI38cxyueiSPWVUObYD7uLEVlViGEzj7DKlckGp0nztwo2PcGVE1
 a4eeMgcFLB2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="182356426"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="182356426"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 02:47:13 -0800
IronPort-SDR: Xff4PmMxscOyXk5BAnDMl6Vi7FIs/NuldE/+ZU4Jyr8kwk+6gRP9/LZLfGkDowUM76D9MAr+b6
 Ll0fhgjFBEqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="414770415"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2021 02:47:11 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lA9V8-0003ig-Cp; Thu, 11 Feb 2021 10:47:10 +0000
Date:   Thu, 11 Feb 2021 18:46:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/smp] BUILD SUCCESS
 66040b2d5d41f85cb1a752a75260595344c5ec3b
Message-ID: <60250afd.yfEy2LDSkGTl/LpW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/smp
branch HEAD: 66040b2d5d41f85cb1a752a75260595344c5ec3b  smp: Process pending softirqs in flush_smp_call_function_from_idle()

elapsed time: 726m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
sh                          rsk7203_defconfig
mips                      bmips_stb_defconfig
arm                              alldefconfig
sparc                               defconfig
arm                           sama5_defconfig
m68k                        mvme147_defconfig
arm                          badge4_defconfig
sh                        dreamcast_defconfig
riscv                    nommu_virt_defconfig
openrisc                         alldefconfig
arm                         bcm2835_defconfig
powerpc                    klondike_defconfig
mips                          malta_defconfig
powerpc                        cell_defconfig
ia64                             allmodconfig
powerpc                      pasemi_defconfig
sh                         apsh4a3a_defconfig
sh                          rsk7201_defconfig
mips                         tb0219_defconfig
m68k                            q40_defconfig
mips                        qi_lb60_defconfig
arm                           sunxi_defconfig
xtensa                         virt_defconfig
arm                        magician_defconfig
mips                           ip32_defconfig
powerpc                     tqm8540_defconfig
sh                          kfr2r09_defconfig
nios2                         10m50_defconfig
mips                 decstation_r4k_defconfig
arc                        nsimosci_defconfig
powerpc                  mpc885_ads_defconfig
arc                         haps_hs_defconfig
arm                          prima2_defconfig
powerpc                          g5_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          amiga_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     tqm8555_defconfig
mips                        bcm63xx_defconfig
sh                           se7721_defconfig
mips                         tb0287_defconfig
powerpc                    socrates_defconfig
mips                            ar7_defconfig
powerpc                     sbc8548_defconfig
powerpc                          allmodconfig
powerpc                 xes_mpc85xx_defconfig
m68k                        m5407c3_defconfig
powerpc                     ep8248e_defconfig
mips                        omega2p_defconfig
nios2                            alldefconfig
mips                           ip27_defconfig
powerpc                      katmai_defconfig
arm                           tegra_defconfig
xtensa                       common_defconfig
riscv                            alldefconfig
arm                        vexpress_defconfig
m68k                            mac_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
x86_64               randconfig-a016-20210211
x86_64               randconfig-a013-20210211
x86_64               randconfig-a012-20210211
x86_64               randconfig-a015-20210211
x86_64               randconfig-a014-20210211
x86_64               randconfig-a011-20210211
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
i386                 randconfig-a016-20210211
i386                 randconfig-a014-20210211
i386                 randconfig-a012-20210211
i386                 randconfig-a013-20210211
i386                 randconfig-a011-20210211
i386                 randconfig-a015-20210211
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
