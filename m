Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB734CD94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhC2KDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:03:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:38205 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhC2KDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:03:23 -0400
IronPort-SDR: dVmbNIdBdhDLZSwX6jq5dqyjORgMy3i3mWIOhm876y18Ghuap19/S4cpUGcMlCp2w9DR0kr2iC
 O4+cRdd5dmlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191615856"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191615856"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 03:03:22 -0700
IronPort-SDR: Kmn006HUAz2OGatQiyV4AxaH5xt7eM8Rdavf8LGdSOce2ltbSa+TnZu7aMUuDiaRd7wDSUdGjj
 ImQM9P00nHaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="417594724"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2021 03:03:20 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lQojw-0004Tg-9O; Mon, 29 Mar 2021 10:03:20 +0000
Date:   Mon, 29 Mar 2021 18:02:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/splitlock] BUILD SUCCESS
 ebca17707e38f2050b188d837bd4646b29a1b0c2
Message-ID: <6061a5bd.cZORSOFiMVdV/AiG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/splitlock
branch HEAD: ebca17707e38f2050b188d837bd4646b29a1b0c2  Documentation/admin-guide: Change doc for split_lock_detect parameter

elapsed time: 726m

configs tested: 147
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
sh                        sh7763rdp_defconfig
arm                         lpc32xx_defconfig
openrisc                  or1klitex_defconfig
sh                          rsk7269_defconfig
arm                           sama5_defconfig
powerpc                     akebono_defconfig
powerpc                    adder875_defconfig
sh                         microdev_defconfig
arm                        multi_v7_defconfig
nds32                            alldefconfig
arc                     haps_hs_smp_defconfig
arm                      footbridge_defconfig
ia64                            zx1_defconfig
m68k                                defconfig
arm                          imote2_defconfig
h8300                       h8s-sim_defconfig
m68k                         apollo_defconfig
mips                        omega2p_defconfig
um                             i386_defconfig
powerpc                     sbc8548_defconfig
xtensa                         virt_defconfig
sh                           se7724_defconfig
sparc                       sparc32_defconfig
sh                           se7619_defconfig
mips                          ath79_defconfig
powerpc                  mpc885_ads_defconfig
arm                       aspeed_g4_defconfig
riscv                    nommu_k210_defconfig
arm                       cns3420vb_defconfig
sh                           sh2007_defconfig
sh                           se7705_defconfig
powerpc                      chrp32_defconfig
powerpc                     rainier_defconfig
powerpc                          g5_defconfig
powerpc                     ppa8548_defconfig
sh                          sdk7786_defconfig
arm                         palmz72_defconfig
mips                        nlm_xlp_defconfig
arm                        mini2440_defconfig
arm                     am200epdkit_defconfig
arm                           tegra_defconfig
mips                      pistachio_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc8560_ads_defconfig
sh                          r7785rp_defconfig
m68k                       bvme6000_defconfig
arm                         axm55xx_defconfig
powerpc                 xes_mpc85xx_defconfig
alpha                               defconfig
powerpc                     pq2fads_defconfig
m68k                            q40_defconfig
arc                           tb10x_defconfig
arm                           h5000_defconfig
arc                      axs103_smp_defconfig
powerpc                      ppc6xx_defconfig
arm                           spitz_defconfig
arm                         s3c2410_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210328
i386                 randconfig-a003-20210328
i386                 randconfig-a001-20210328
i386                 randconfig-a002-20210328
i386                 randconfig-a005-20210328
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a001-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
x86_64               randconfig-a015-20210328
x86_64               randconfig-a012-20210328
x86_64               randconfig-a013-20210328
x86_64               randconfig-a014-20210328
x86_64               randconfig-a016-20210328
x86_64               randconfig-a011-20210328
x86_64               randconfig-a002-20210329
x86_64               randconfig-a003-20210329
x86_64               randconfig-a006-20210329
x86_64               randconfig-a001-20210329
x86_64               randconfig-a005-20210329
x86_64               randconfig-a004-20210329
i386                 randconfig-a014-20210329
i386                 randconfig-a011-20210329
i386                 randconfig-a015-20210329
i386                 randconfig-a016-20210329
i386                 randconfig-a013-20210329
i386                 randconfig-a012-20210329
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
x86_64               randconfig-a002-20210328
x86_64               randconfig-a003-20210328
x86_64               randconfig-a001-20210328
x86_64               randconfig-a006-20210328
x86_64               randconfig-a005-20210328
x86_64               randconfig-a004-20210328

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
