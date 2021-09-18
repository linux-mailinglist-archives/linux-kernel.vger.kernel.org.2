Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A223410784
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 18:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbhIRQGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 12:06:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:26163 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhIRQGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 12:06:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="210042201"
X-IronPort-AV: E=Sophos;i="5.85,304,1624345200"; 
   d="scan'208";a="210042201"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2021 09:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,304,1624345200"; 
   d="scan'208";a="555332916"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Sep 2021 09:04:39 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mRcpS-0004xl-Vr; Sat, 18 Sep 2021 16:04:38 +0000
Date:   Sun, 19 Sep 2021 00:04:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 85784470efa2d5733e86679ba05d310ece81b20f
Message-ID: <61460e0d.4MfDpoEM3uCcm53r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 85784470efa2d5733e86679ba05d310ece81b20f  x86/smp: Remove unnecessary assignment to local var freq_scale

elapsed time: 1192m

configs tested: 103
configs skipped: 165

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20210918
ia64                                defconfig
powerpc                 mpc8313_rdb_defconfig
mips                      pic32mzda_defconfig
sh                          r7785rp_defconfig
powerpc                      ppc6xx_defconfig
arm                          simpad_defconfig
arm                            qcom_defconfig
m68k                        m5307c3_defconfig
m68k                        mvme16x_defconfig
powerpc                        fsp2_defconfig
mips                           ip27_defconfig
arm64                            alldefconfig
mips                           rs90_defconfig
powerpc                      ppc40x_defconfig
powerpc                     tqm8540_defconfig
arm                            zeus_defconfig
powerpc                      tqm8xx_defconfig
arm                        mvebu_v5_defconfig
powerpc                     sequoia_defconfig
arm                        mini2440_defconfig
powerpc                       maple_defconfig
arm                             pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                           tegra_defconfig
sh                           se7780_defconfig
sh                          kfr2r09_defconfig
arm                       multi_v4t_defconfig
mips                          ath79_defconfig
arm                         cm_x300_defconfig
powerpc                    socrates_defconfig
arm                        vexpress_defconfig
powerpc                       eiger_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         cobalt_defconfig
ia64                             allmodconfig
powerpc                 linkstation_defconfig
powerpc                     mpc512x_defconfig
arm                        oxnas_v6_defconfig
x86_64               randconfig-c001-20210918
arm                  randconfig-c002-20210918
ia64                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
x86_64               randconfig-a013-20210918
x86_64               randconfig-a016-20210918
x86_64               randconfig-a012-20210918
x86_64               randconfig-a011-20210918
x86_64               randconfig-a014-20210918
x86_64               randconfig-a015-20210918
i386                 randconfig-a016-20210918
i386                 randconfig-a012-20210918
i386                 randconfig-a011-20210918
i386                 randconfig-a015-20210918
i386                 randconfig-a013-20210918
i386                 randconfig-a014-20210918
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20210918
x86_64               randconfig-c007-20210918
powerpc              randconfig-c003-20210918
mips                 randconfig-c004-20210918
i386                 randconfig-c001-20210918
arm                  randconfig-c002-20210918
s390                 randconfig-c005-20210918
x86_64               randconfig-a002-20210918
x86_64               randconfig-a004-20210918
x86_64               randconfig-a006-20210918
x86_64               randconfig-a003-20210918
x86_64               randconfig-a001-20210918
x86_64               randconfig-a005-20210918
i386                 randconfig-a004-20210918
i386                 randconfig-a005-20210918
i386                 randconfig-a002-20210918
i386                 randconfig-a006-20210918
i386                 randconfig-a001-20210918
i386                 randconfig-a003-20210918
hexagon              randconfig-r045-20210918
hexagon              randconfig-r041-20210918

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
