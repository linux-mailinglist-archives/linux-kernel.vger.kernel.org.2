Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1635A6D0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbhDITRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:17:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:30407 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234692AbhDITQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:16:53 -0400
IronPort-SDR: oImWjkqm7NCYBbsobkI4zN/KQXojBzMekyhKNqcCPjDqlDKJq3sPVgU7c0pgDR5gjGug/J4qMm
 X8laBT+A1agw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="181355397"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="181355397"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 12:16:39 -0700
IronPort-SDR: nIsxTeUnJf0IHI1M23I9+ZLHZDLhHG3mVTrDRXrJkpl0+XYgMn6UDYm/p+F9/+7JeGlkHin0MN
 eGzViadnxvEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="397582023"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Apr 2021 12:16:38 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUwcP-000HF3-Iw; Fri, 09 Apr 2021 19:16:37 +0000
Date:   Sat, 10 Apr 2021 03:16:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/xfs-fixed] BUILD SUCCESS
 29cccbe7974279cab3786063db20a1146b1c4918
Message-ID: <6070a809.7QaU2ofU9h9VwFeh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/xfs-fixed
branch HEAD: 29cccbe7974279cab3786063db20a1146b1c4918  xfs: Replace one-element arrays with flexible-array members

elapsed time: 724m

configs tested: 153
configs skipped: 3

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
sh                          polaris_defconfig
arc                              allyesconfig
powerpc                     asp8347_defconfig
m68k                          multi_defconfig
openrisc                  or1klitex_defconfig
xtensa                    xip_kc705_defconfig
arm                            hisi_defconfig
powerpc                      pmac32_defconfig
arm                          lpd270_defconfig
nios2                            alldefconfig
m68k                         apollo_defconfig
mips                        omega2p_defconfig
mips                        nlm_xlr_defconfig
powerpc                 mpc8315_rdb_defconfig
nios2                               defconfig
sh                      rts7751r2d1_defconfig
powerpc                   motionpro_defconfig
sh                         ap325rxa_defconfig
powerpc                       eiger_defconfig
mips                         tb0226_defconfig
powerpc                 mpc834x_itx_defconfig
mips                  maltasmvp_eva_defconfig
arm                          ep93xx_defconfig
xtensa                  nommu_kc705_defconfig
sh                          rsk7264_defconfig
sh                           se7751_defconfig
ia64                        generic_defconfig
mips                        vocore2_defconfig
powerpc                           allnoconfig
powerpc                    socrates_defconfig
arm64                            alldefconfig
powerpc                       ppc64_defconfig
arm                          ixp4xx_defconfig
mips                         cobalt_defconfig
powerpc                      chrp32_defconfig
arm                         socfpga_defconfig
arm                            pleb_defconfig
arm                            xcep_defconfig
mips                            e55_defconfig
arm                       versatile_defconfig
sh                          lboxre2_defconfig
arm                         cm_x300_defconfig
m68k                       m5475evb_defconfig
mips                         bigsur_defconfig
mips                      pistachio_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                       m5249evb_defconfig
ia64                            zx1_defconfig
m68k                        m5407c3_defconfig
sh                            titan_defconfig
arm                        oxnas_v6_defconfig
mips                     cu1830-neo_defconfig
arc                 nsimosci_hs_smp_defconfig
arc                        nsim_700_defconfig
arm                       netwinder_defconfig
sh                          kfr2r09_defconfig
parisc                              defconfig
powerpc                     tqm8548_defconfig
mips                          ath79_defconfig
arm                            mps2_defconfig
arm                  colibri_pxa300_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                         amcore_defconfig
ia64                             allyesconfig
microblaze                          defconfig
sh                        sh7785lcr_defconfig
sh                          urquell_defconfig
arc                      axs103_smp_defconfig
powerpc                     taishan_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     ppa8548_defconfig
powerpc                    sam440ep_defconfig
s390                          debug_defconfig
powerpc                     sequoia_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
mips                     loongson1b_defconfig
arm                         mv78xx0_defconfig
arm                       multi_v4t_defconfig
xtensa                  cadence_csp_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
x86_64               randconfig-a004-20210409
x86_64               randconfig-a005-20210409
x86_64               randconfig-a003-20210409
x86_64               randconfig-a001-20210409
x86_64               randconfig-a002-20210409
x86_64               randconfig-a006-20210409

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
