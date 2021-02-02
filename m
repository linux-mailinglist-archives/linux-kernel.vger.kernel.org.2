Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3FD30CA63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhBBSrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:47:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:53894 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233262AbhBBSmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:42:11 -0500
IronPort-SDR: 1nd0+c5K6AS7pUP2URVkP0nR4DQbBFeXQggnC52Npa01lt5KlyNdLdBUvUviqxqpXBGct5rerI
 pBRt0ty1pTZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160075420"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="160075420"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:41:25 -0800
IronPort-SDR: gH/wmJbSWMK9Inrog7NMAnf+hVP5aqrZBC4+Jp2UKpjc98a/s+C43cOd9ry/Bkr1NnwMBvTMM4
 9cQ9a+vEqKPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="356417985"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2021 10:41:23 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l70c6-0009b7-Gg; Tue, 02 Feb 2021 18:41:22 +0000
Date:   Wed, 03 Feb 2021 02:41:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 8e6a68bd0202c10d30298fd5aaf11ffeacbac197
Message-ID: <60199cbd.HMVy89j4rhZE2E2G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 8e6a68bd0202c10d30298fd5aaf11ffeacbac197  torture: Allow 1G of memory for torture.sh kvfree testing

elapsed time: 730m

configs tested: 159
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                malta_kvm_guest_defconfig
nios2                         3c120_defconfig
arm                            xcep_defconfig
sh                             shx3_defconfig
sh                        dreamcast_defconfig
m68k                       m5208evb_defconfig
mips                      pic32mzda_defconfig
powerpc                    klondike_defconfig
m68k                         amcore_defconfig
powerpc                      ppc64e_defconfig
arc                        vdk_hs38_defconfig
powerpc                          g5_defconfig
arm                          iop32x_defconfig
powerpc                   currituck_defconfig
riscv                          rv32_defconfig
arm                             pxa_defconfig
powerpc                      acadia_defconfig
m68k                        m5272c3_defconfig
arm                        neponset_defconfig
m68k                         apollo_defconfig
csky                                defconfig
c6x                        evmc6472_defconfig
um                            kunit_defconfig
sh                          rsk7203_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                          amiga_defconfig
arm                       versatile_defconfig
powerpc                        fsp2_defconfig
m68k                          sun3x_defconfig
nios2                               defconfig
openrisc                    or1ksim_defconfig
m68k                          hp300_defconfig
powerpc                    mvme5100_defconfig
xtensa                           allyesconfig
arm                          gemini_defconfig
arc                        nsim_700_defconfig
arm                         palmz72_defconfig
mips                  decstation_64_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     powernv_defconfig
mips                          rb532_defconfig
powerpc                     tqm8540_defconfig
powerpc                         ps3_defconfig
sh                          kfr2r09_defconfig
nios2                         10m50_defconfig
arm                      pxa255-idp_defconfig
arm                        mini2440_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      tqm8xx_defconfig
m68k                            q40_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc64                        alldefconfig
sh                     magicpanelr2_defconfig
arm                       aspeed_g4_defconfig
sh                           se7712_defconfig
um                             i386_defconfig
arm                          pxa910_defconfig
arm                           h3600_defconfig
arm                            pleb_defconfig
mips                        maltaup_defconfig
arm                           tegra_defconfig
mips                 decstation_r4k_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        keystone_defconfig
sh                           sh2007_defconfig
sh                          lboxre2_defconfig
powerpc                     mpc5200_defconfig
mips                            e55_defconfig
sh                            migor_defconfig
sh                ecovec24-romimage_defconfig
powerpc                          allmodconfig
powerpc                 mpc837x_mds_defconfig
arm                            mps2_defconfig
mips                        bcm63xx_defconfig
powerpc                    socrates_defconfig
arm                         s3c6400_defconfig
ia64                          tiger_defconfig
mips                         mpc30x_defconfig
powerpc                      pmac32_defconfig
mips                       lemote2f_defconfig
s390                       zfcpdump_defconfig
alpha                            alldefconfig
mips                        omega2p_defconfig
mips                      bmips_stb_defconfig
xtensa                  audio_kc705_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      ppc40x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210202
i386                 randconfig-a005-20210202
i386                 randconfig-a003-20210202
i386                 randconfig-a006-20210202
i386                 randconfig-a002-20210202
i386                 randconfig-a004-20210202
x86_64               randconfig-a013-20210202
x86_64               randconfig-a014-20210202
x86_64               randconfig-a015-20210202
x86_64               randconfig-a016-20210202
x86_64               randconfig-a011-20210202
x86_64               randconfig-a012-20210202
i386                 randconfig-a013-20210202
i386                 randconfig-a016-20210202
i386                 randconfig-a014-20210202
i386                 randconfig-a012-20210202
i386                 randconfig-a015-20210202
i386                 randconfig-a011-20210202
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210202
x86_64               randconfig-a001-20210202
x86_64               randconfig-a005-20210202
x86_64               randconfig-a002-20210202
x86_64               randconfig-a004-20210202
x86_64               randconfig-a003-20210202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
