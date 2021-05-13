Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD8037F1B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhEMDg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:36:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:18268 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhEMDgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:36:19 -0400
IronPort-SDR: etzF3tGjRz5g0lMEz6mKp+jUO3xbwnv7UlubHAyPpnM3JRijcApYSrsAs/A79S2laQ79menUnJ
 XaVyZ24oudVw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="196767223"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="196767223"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 20:35:08 -0700
IronPort-SDR: 6j7fAWOJErAAHI8y0L8lrinMM4kbLkZtco0cJzyyzNx9hcVTqgOUCZ7chgXiHg2yeVw4GHB+I4
 JTZUuP+dMAXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="469740912"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 May 2021 20:35:04 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lh27r-00005U-Rj; Thu, 13 May 2021 03:35:03 +0000
Date:   Thu, 13 May 2021 11:34:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 440e906702410f59ae5397ec9e3b639edb53f80e
Message-ID: <609c9e3c.IDoga+7M8I9it+7w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
branch HEAD: 440e906702410f59ae5397ec9e3b639edb53f80e  perf/x86/intel/uncore: Drop unnecessary NULL checks after container_of()

elapsed time: 1076m

configs tested: 137
configs skipped: 84

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
um                               allmodconfig
sh                          landisk_defconfig
arm                         at91_dt_defconfig
powerpc                     tqm8555_defconfig
powerpc                 mpc836x_mds_defconfig
openrisc                  or1klitex_defconfig
m68k                          amiga_defconfig
mips                           xway_defconfig
sh                           se7712_defconfig
arm                          collie_defconfig
powerpc                     ppa8548_defconfig
powerpc                      obs600_defconfig
mips                     decstation_defconfig
arm                           sunxi_defconfig
powerpc                    sam440ep_defconfig
mips                           jazz_defconfig
powerpc                        warp_defconfig
arm                       mainstone_defconfig
powerpc                 mpc834x_itx_defconfig
mips                           ip27_defconfig
sh                        edosk7760_defconfig
sh                   sh7770_generic_defconfig
sh                          rsk7201_defconfig
arm                       aspeed_g4_defconfig
mips                      malta_kvm_defconfig
parisc                generic-32bit_defconfig
powerpc                     sequoia_defconfig
sh                           se7619_defconfig
mips                        workpad_defconfig
arm                         bcm2835_defconfig
arm                        spear6xx_defconfig
x86_64                           allyesconfig
arc                      axs103_smp_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     asp8347_defconfig
powerpc                     tqm8560_defconfig
arm                          pxa910_defconfig
sh                          rsk7264_defconfig
powerpc                       holly_defconfig
mips                         mpc30x_defconfig
mips                  decstation_64_defconfig
riscv                    nommu_k210_defconfig
ia64                                defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        keystone_defconfig
parisc                           alldefconfig
powerpc                        fsp2_defconfig
m68k                       m5275evb_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc64                           defconfig
arm                          pcm027_defconfig
arm                             rpc_defconfig
arm                         cm_x300_defconfig
mips                           ip28_defconfig
sh                         microdev_defconfig
mips                        bcm47xx_defconfig
arm                           tegra_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         shannon_defconfig
powerpc                    ge_imp3a_defconfig
sh                            titan_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210512
x86_64               randconfig-a004-20210512
x86_64               randconfig-a001-20210512
x86_64               randconfig-a005-20210512
x86_64               randconfig-a002-20210512
x86_64               randconfig-a006-20210512
i386                 randconfig-a003-20210512
i386                 randconfig-a001-20210512
i386                 randconfig-a005-20210512
i386                 randconfig-a004-20210512
i386                 randconfig-a002-20210512
i386                 randconfig-a006-20210512
i386                 randconfig-a016-20210512
i386                 randconfig-a014-20210512
i386                 randconfig-a011-20210512
i386                 randconfig-a015-20210512
i386                 randconfig-a012-20210512
i386                 randconfig-a013-20210512
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210512
x86_64               randconfig-a012-20210512
x86_64               randconfig-a011-20210512
x86_64               randconfig-a013-20210512
x86_64               randconfig-a016-20210512
x86_64               randconfig-a014-20210512

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
