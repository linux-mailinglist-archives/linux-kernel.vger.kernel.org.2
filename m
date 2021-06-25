Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906213B44DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhFYNzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:55:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:29387 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhFYNy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:54:57 -0400
IronPort-SDR: qqy+VWQhRkfLY9fvtTniSx6SgOipaPVnNmABhGqyrf2u2BZ0R7fvGGck2jmrzSfUc7swPydZnD
 3lUPVRJ3DFOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="207489521"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="207489521"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 06:52:01 -0700
IronPort-SDR: zJ8jjHkgffaE9VvGtYOLv9i2Tk48Nh1XO1VzC+VGEYaz6HAiWkz8CBUFhjp9+fQTKc0F0MRglv
 uaM+KxnCzu5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="488190669"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jun 2021 06:51:59 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwmFS-0007BZ-N8; Fri, 25 Jun 2021 13:51:58 +0000
Date:   Fri, 25 Jun 2021 21:51:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.06.22a] BUILD SUCCESS
 14bf352718c90d9097b36bdab8a5d7c1ffcdd802
Message-ID: <60d5df67.VbHnzJpTtImLZmP9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.06.22a
branch HEAD: 14bf352718c90d9097b36bdab8a5d7c1ffcdd802  scftorture: Add RPC-like IPI tests

elapsed time: 726m

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
mips                           ip28_defconfig
powerpc                 mpc832x_mds_defconfig
arm                      pxa255-idp_defconfig
sh                              ul2_defconfig
arm                        neponset_defconfig
sh                           se7721_defconfig
s390                          debug_defconfig
powerpc                    amigaone_defconfig
powerpc                     kmeter1_defconfig
powerpc64                        alldefconfig
sh                          lboxre2_defconfig
powerpc                      tqm8xx_defconfig
ia64                        generic_defconfig
arm                         mv78xx0_defconfig
mips                  maltasmvp_eva_defconfig
arm                        spear6xx_defconfig
sh                             espt_defconfig
mips                        qi_lb60_defconfig
h8300                            alldefconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       m5249evb_defconfig
mips                        omega2p_defconfig
arm                        keystone_defconfig
arm                       multi_v4t_defconfig
arm                           sama5_defconfig
arm                        vexpress_defconfig
arm                        cerfcube_defconfig
arm                           h5000_defconfig
mips                      pistachio_defconfig
arm                          lpd270_defconfig
sh                          rsk7269_defconfig
powerpc                     rainier_defconfig
powerpc                      bamboo_defconfig
sh                   sh7770_generic_defconfig
powerpc                      pasemi_defconfig
sh                     sh7710voipgw_defconfig
um                            kunit_defconfig
sh                        edosk7760_defconfig
powerpc                      katmai_defconfig
arc                        nsimosci_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7751_defconfig
mips                       capcella_defconfig
arm                      footbridge_defconfig
mips                             allmodconfig
powerpc                 mpc8315_rdb_defconfig
sh                        sh7763rdp_defconfig
powerpc                     tqm8555_defconfig
xtensa                  audio_kc705_defconfig
mips                      maltaaprp_defconfig
riscv                            allyesconfig
arm                         bcm2835_defconfig
sh                          sdk7786_defconfig
mips                            gpr_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                   milbeaut_m10v_defconfig
arm                           tegra_defconfig
sh                               alldefconfig
mips                     loongson1c_defconfig
h8300                               defconfig
mips                 decstation_r4k_defconfig
m68k                        stmark2_defconfig
arm                             pxa_defconfig
powerpc                      walnut_defconfig
mips                     cu1000-neo_defconfig
s390                             alldefconfig
xtensa                  cadence_csp_defconfig
x86_64                            allnoconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210625
x86_64               randconfig-a001-20210625
x86_64               randconfig-a005-20210625
x86_64               randconfig-a003-20210625
x86_64               randconfig-a004-20210625
x86_64               randconfig-a006-20210625
i386                 randconfig-a002-20210625
i386                 randconfig-a001-20210625
i386                 randconfig-a003-20210625
i386                 randconfig-a006-20210625
i386                 randconfig-a005-20210625
i386                 randconfig-a004-20210625
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
i386                 randconfig-a011-20210625
i386                 randconfig-a014-20210625
i386                 randconfig-a013-20210625
i386                 randconfig-a015-20210625
i386                 randconfig-a012-20210625
i386                 randconfig-a016-20210625
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-b001-20210625
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
