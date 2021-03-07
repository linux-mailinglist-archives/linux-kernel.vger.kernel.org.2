Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D013303E9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 19:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhCGSY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 13:24:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:8972 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhCGSYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 13:24:06 -0500
IronPort-SDR: bfN6Lygbu7EwX5qdajfFtThZCDcCLV5JRcg8NH3kEyAMBk/+M4F1s6CMbsPpy5wt1qr61H5PoI
 TRs3vRhsMCQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="207675446"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="207675446"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 10:24:06 -0800
IronPort-SDR: O4+VpYZGPfFIqiEwExJkr1JnIQbGtdCfNC23KLgAqjX5xbNoQfjc3K+sze/ZS8sd1oWJkHzdCh
 Z6twaDMBvJ0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="601871923"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Mar 2021 10:24:05 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lIy4S-0000aE-BH; Sun, 07 Mar 2021 18:24:04 +0000
Date:   Mon, 08 Mar 2021 02:23:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 cbe16f35bee6880becca6f20d2ebf6b457148552
Message-ID: <60451a29.8HrKvgCOHIGl7prD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: cbe16f35bee6880becca6f20d2ebf6b457148552  genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()

elapsed time: 957m

configs tested: 148
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      pasemi_defconfig
sh                        sh7763rdp_defconfig
powerpc                          g5_defconfig
xtensa                    smp_lx200_defconfig
csky                             alldefconfig
arm                         orion5x_defconfig
mips                           ip28_defconfig
mips                       capcella_defconfig
arm                        mini2440_defconfig
arm                           spitz_defconfig
arm                          pxa168_defconfig
m68k                             allyesconfig
arm                       aspeed_g4_defconfig
mips                      malta_kvm_defconfig
arm                         lubbock_defconfig
mips                            e55_defconfig
powerpc                      ppc44x_defconfig
powerpc                    ge_imp3a_defconfig
arm                         hackkit_defconfig
arc                 nsimosci_hs_smp_defconfig
arc                         haps_hs_defconfig
powerpc                      arches_defconfig
sh                          rsk7264_defconfig
arm                         bcm2835_defconfig
mips                     decstation_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          pcm027_defconfig
arm                          lpd270_defconfig
riscv                    nommu_k210_defconfig
sparc                            allyesconfig
mips                        maltaup_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                   secureedge5410_defconfig
arm                             rpc_defconfig
xtensa                       common_defconfig
mips                   sb1250_swarm_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     ep8248e_defconfig
powerpc                     sbc8548_defconfig
parisc                generic-32bit_defconfig
powerpc                     tqm8555_defconfig
sh                                  defconfig
sh                           se7722_defconfig
arm                         s5pv210_defconfig
arm                            hisi_defconfig
ia64                         bigsur_defconfig
sh                             espt_defconfig
m68k                          sun3x_defconfig
sparc                       sparc64_defconfig
sh                          r7780mp_defconfig
parisc                generic-64bit_defconfig
powerpc                      bamboo_defconfig
arc                           tb10x_defconfig
ia64                                defconfig
mips                           ci20_defconfig
s390                       zfcpdump_defconfig
mips                     cu1000-neo_defconfig
arm                        keystone_defconfig
sh                           se7705_defconfig
nios2                            alldefconfig
sh                   sh7724_generic_defconfig
xtensa                    xip_kc705_defconfig
m68k                            q40_defconfig
mips                           rs90_defconfig
arm                          pxa3xx_defconfig
arc                      axs103_smp_defconfig
mips                  decstation_64_defconfig
powerpc                     tqm8560_defconfig
microblaze                          defconfig
mips                         tb0287_defconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
mips                       rbtx49xx_defconfig
mips                         tb0219_defconfig
powerpc                     redwood_defconfig
sh                        apsh4ad0a_defconfig
ia64                             allmodconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210307
i386                 randconfig-a003-20210307
i386                 randconfig-a002-20210307
i386                 randconfig-a004-20210307
i386                 randconfig-a006-20210307
i386                 randconfig-a001-20210307
x86_64               randconfig-a013-20210307
x86_64               randconfig-a016-20210307
x86_64               randconfig-a015-20210307
x86_64               randconfig-a014-20210307
x86_64               randconfig-a012-20210307
x86_64               randconfig-a011-20210307
i386                 randconfig-a016-20210307
i386                 randconfig-a012-20210307
i386                 randconfig-a013-20210307
i386                 randconfig-a014-20210307
i386                 randconfig-a011-20210307
i386                 randconfig-a015-20210307
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210307
x86_64               randconfig-a001-20210307
x86_64               randconfig-a004-20210307
x86_64               randconfig-a005-20210307
x86_64               randconfig-a002-20210307
x86_64               randconfig-a003-20210307

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
