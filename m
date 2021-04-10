Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278F535AAEB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 06:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhDJEvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 00:51:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:6253 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhDJEvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 00:51:18 -0400
IronPort-SDR: ucdxtsaGQ4KxPwmwBbs2lqW4DufRRJqBDtU1lZB48GMj1mKG7XMHiM1aL0ZdEMyZoZWeHsehcr
 i8P3ZQKvW3Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="191741937"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="191741937"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 21:51:04 -0700
IronPort-SDR: 3WhN43epngfuF3v9WQ79w9s7X5y+SlCuQy+MjGaBWUanGIkdwwsihZI5soOMJON+wo+8i9bljZ
 KMgcQGqXCsJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="599369412"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Apr 2021 21:51:03 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lV5aI-000HrB-MG; Sat, 10 Apr 2021 04:51:02 +0000
Date:   Sat, 10 Apr 2021 12:50:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 4aed8aa41524a1fc6439171881c2bb7ace197528
Message-ID: <60712e97.F3E4fdVcYYRehDVf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 4aed8aa41524a1fc6439171881c2bb7ace197528  sched/fair: Introduce a CPU capacity comparison helper

elapsed time: 726m

configs tested: 150
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
riscv                            allyesconfig
i386                             allyesconfig
arm64                            alldefconfig
powerpc                      bamboo_defconfig
m68k                       bvme6000_defconfig
mips                      pistachio_defconfig
openrisc                 simple_smp_defconfig
sh                           se7750_defconfig
powerpc                       ebony_defconfig
mips                           xway_defconfig
powerpc                     mpc83xx_defconfig
ia64                      gensparse_defconfig
arm                          simpad_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     pq2fads_defconfig
mips                    maltaup_xpa_defconfig
mips                          ath79_defconfig
m68k                                defconfig
arm                          gemini_defconfig
powerpc                     ep8248e_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    socrates_defconfig
sh                           se7751_defconfig
arm                         s3c6400_defconfig
sh                         apsh4a3a_defconfig
mips                        bcm63xx_defconfig
powerpc                      tqm8xx_defconfig
openrisc                         alldefconfig
arm                            mmp2_defconfig
um                             i386_defconfig
powerpc64                           defconfig
sh                             espt_defconfig
arm                         vf610m4_defconfig
mips                          rb532_defconfig
mips                            gpr_defconfig
arc                     haps_hs_smp_defconfig
arm                             mxs_defconfig
powerpc                      arches_defconfig
sh                        dreamcast_defconfig
mips                        workpad_defconfig
um                                allnoconfig
mips                       bmips_be_defconfig
sh                            shmin_defconfig
arm                        multi_v7_defconfig
riscv                    nommu_k210_defconfig
arc                            hsdk_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        multi_v5_defconfig
h8300                               defconfig
mips                         tb0287_defconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
arm                        spear6xx_defconfig
sh                            titan_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                       m5249evb_defconfig
ia64                            zx1_defconfig
arm                          ixp4xx_defconfig
powerpc                   bluestone_defconfig
mips                      loongson3_defconfig
m68k                          multi_defconfig
arc                          axs101_defconfig
sh                          sdk7780_defconfig
arm                          badge4_defconfig
xtensa                  audio_kc705_defconfig
arm                      jornada720_defconfig
sh                           se7780_defconfig
sh                          lboxre2_defconfig
sh                          r7785rp_defconfig
powerpc                     asp8347_defconfig
powerpc                     sbc8548_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      mgcoge_defconfig
m68k                        m5407c3_defconfig
i386                                defconfig
arm                        vexpress_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210409
i386                 randconfig-a003-20210409
i386                 randconfig-a001-20210409
i386                 randconfig-a004-20210409
i386                 randconfig-a002-20210409
i386                 randconfig-a005-20210409
x86_64               randconfig-a014-20210409
x86_64               randconfig-a015-20210409
x86_64               randconfig-a012-20210409
x86_64               randconfig-a011-20210409
x86_64               randconfig-a013-20210409
x86_64               randconfig-a016-20210409
i386                 randconfig-a014-20210409
i386                 randconfig-a011-20210409
i386                 randconfig-a016-20210409
i386                 randconfig-a012-20210409
i386                 randconfig-a013-20210409
i386                 randconfig-a015-20210409
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210409
x86_64               randconfig-a005-20210409
x86_64               randconfig-a003-20210409
x86_64               randconfig-a001-20210409
x86_64               randconfig-a002-20210409
x86_64               randconfig-a006-20210409

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
