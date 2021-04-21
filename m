Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE41B366541
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 08:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhDUGQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 02:16:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:29212 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhDUGQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 02:16:12 -0400
IronPort-SDR: mYtxKACcMehIBovN7tV7c4KeFJ0bg9OEQj0eYCj2k17Cv/IsN4qM0DhifJGMf+7kLRKiqglpws
 GZQCxiIgsJGA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195672258"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="195672258"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 23:15:38 -0700
IronPort-SDR: ow3yGyWyze/fnWJ+ygzfDJ75vnragoP4r3U0qlvk+ob6NGcQ9/qFIDYjTjBmVpTKXA1qyraGgb
 FHtsQEIc0ggQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="401379518"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2021 23:15:36 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZ69A-0003Sc-59; Wed, 21 Apr 2021 06:15:36 +0000
Date:   Wed, 21 Apr 2021 14:14:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 5849cdf8c120e3979c57d34be55b92d90a77a47e
Message-ID: <607fc2e0.9Swwvoaxiev31ZUo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 5849cdf8c120e3979c57d34be55b92d90a77a47e  x86/crash: Fix crash_setup_memmap_entries() out-of-bounds access

elapsed time: 721m

configs tested: 132
configs skipped: 70

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
mips                           gcw0_defconfig
sh                           se7724_defconfig
mips                     decstation_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                       maple_defconfig
powerpc                          allyesconfig
ia64                            zx1_defconfig
mips                      maltaaprp_defconfig
nds32                               defconfig
powerpc                     tqm8555_defconfig
powerpc                 mpc834x_mds_defconfig
mips                           ip27_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                             allyesconfig
mips                           rs90_defconfig
sh                            shmin_defconfig
sh                          polaris_defconfig
xtensa                       common_defconfig
mips                  decstation_64_defconfig
sh                           se7619_defconfig
powerpc                 mpc85xx_cds_defconfig
sparc                       sparc64_defconfig
mips                        nlm_xlr_defconfig
powerpc                        cell_defconfig
h8300                       h8s-sim_defconfig
arm                     davinci_all_defconfig
m68k                            q40_defconfig
mips                          malta_defconfig
mips                        bcm47xx_defconfig
mips                      fuloong2e_defconfig
powerpc                 linkstation_defconfig
mips                      pic32mzda_defconfig
arm                         nhk8815_defconfig
mips                         tb0287_defconfig
sh                          rsk7203_defconfig
sh                          landisk_defconfig
powerpc                       eiger_defconfig
mips                         rt305x_defconfig
powerpc                      obs600_defconfig
arm                        spear6xx_defconfig
nios2                            allyesconfig
arm                        keystone_defconfig
sh                              ul2_defconfig
powerpc                      tqm8xx_defconfig
sh                         microdev_defconfig
arm                           spitz_defconfig
m68k                       m5475evb_defconfig
arm                            lart_defconfig
powerpc                 canyonlands_defconfig
powerpc                        icon_defconfig
arm                         lpc18xx_defconfig
sh                             sh03_defconfig
mips                     cu1000-neo_defconfig
powerpc                      arches_defconfig
sh                            migor_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210420
i386                 randconfig-a002-20210420
i386                 randconfig-a001-20210420
i386                 randconfig-a006-20210420
i386                 randconfig-a004-20210420
i386                 randconfig-a003-20210420
x86_64               randconfig-a015-20210420
x86_64               randconfig-a016-20210420
x86_64               randconfig-a011-20210420
x86_64               randconfig-a014-20210420
x86_64               randconfig-a013-20210420
x86_64               randconfig-a012-20210420
i386                 randconfig-a012-20210420
i386                 randconfig-a014-20210420
i386                 randconfig-a011-20210420
i386                 randconfig-a013-20210420
i386                 randconfig-a015-20210420
i386                 randconfig-a016-20210420
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a004-20210420
x86_64               randconfig-a002-20210420
x86_64               randconfig-a001-20210420
x86_64               randconfig-a005-20210420
x86_64               randconfig-a006-20210420
x86_64               randconfig-a003-20210420

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
