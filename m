Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB5315C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhBJBrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:47:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:24230 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234693AbhBJACI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:02:08 -0500
IronPort-SDR: n717kM3/BE/gXV13qxCl8iTWL2iIRf18srZOtGnRMcyyYROCtiZ1sgknieSykmkhms2UF0W03e
 qTxBgV6NsUWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="266818709"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="266818709"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:01:25 -0800
IronPort-SDR: POAgc17EsOm1XnBSZiKBOMCCpSp6z1fJePbRbQaGRqa0emG1fS/Hv3Ie4cVazaNIF0xVbdwFgg
 sfOYlA6JNQ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="510135698"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Feb 2021 16:01:24 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9cwd-0002QS-RX; Wed, 10 Feb 2021 00:01:23 +0000
Date:   Wed, 10 Feb 2021 08:01:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 4c7bcb51ae25f79e3733982e5d0cd8ce8640ddfc
Message-ID: <60232241.E4oodv11JWtUY2zc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 4c7bcb51ae25f79e3733982e5d0cd8ce8640ddfc  genirq: Prevent [devm_]irq_alloc_desc from returning irq 0

elapsed time: 721m

configs tested: 168
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                     davinci_all_defconfig
s390                          debug_defconfig
arm                         hackkit_defconfig
powerpc                    socrates_defconfig
sh                           se7721_defconfig
powerpc                      ep88xc_defconfig
x86_64                           alldefconfig
mips                          rb532_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                       m5249evb_defconfig
sh                   sh7770_generic_defconfig
c6x                        evmc6472_defconfig
mips                         cobalt_defconfig
arc                        nsimosci_defconfig
mips                        workpad_defconfig
m68k                             alldefconfig
arm                         lpc18xx_defconfig
powerpc                 linkstation_defconfig
mips                          ath79_defconfig
arm                        trizeps4_defconfig
xtensa                         virt_defconfig
microblaze                          defconfig
powerpc                     ksi8560_defconfig
powerpc                     pseries_defconfig
arm                       spear13xx_defconfig
powerpc                     kmeter1_defconfig
mips                       lemote2f_defconfig
mips                     cu1830-neo_defconfig
arm                        mini2440_defconfig
arm                          ep93xx_defconfig
arm                           sunxi_defconfig
powerpc                      makalu_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8560_ads_defconfig
mips                           rs90_defconfig
arm                         s5pv210_defconfig
powerpc                    amigaone_defconfig
powerpc                          allmodconfig
mips                  decstation_64_defconfig
powerpc                        cell_defconfig
m68k                          multi_defconfig
arc                          axs103_defconfig
arc                              allyesconfig
arm                       versatile_defconfig
powerpc                     stx_gp3_defconfig
sh                        sh7785lcr_defconfig
powerpc                     ep8248e_defconfig
sh                          sdk7786_defconfig
arm                         palmz72_defconfig
m68k                            mac_defconfig
arm                        neponset_defconfig
arm                           sama5_defconfig
sh                        sh7763rdp_defconfig
mips                        bcm47xx_defconfig
openrisc                    or1ksim_defconfig
powerpc                      pasemi_defconfig
arm                             mxs_defconfig
arc                              alldefconfig
c6x                        evmc6474_defconfig
m68k                            q40_defconfig
um                             i386_defconfig
alpha                               defconfig
riscv                    nommu_k210_defconfig
mips                          rm200_defconfig
arm                       aspeed_g5_defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                  audio_kc705_defconfig
arm                            zeus_defconfig
powerpc                     pq2fads_defconfig
mips                            e55_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                       m5475evb_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
arm                          badge4_defconfig
powerpc                     rainier_defconfig
arc                    vdk_hs38_smp_defconfig
sh                           se7343_defconfig
powerpc                     kilauea_defconfig
sh                           se7780_defconfig
arc                            hsdk_defconfig
arm                           omap1_defconfig
arm                           stm32_defconfig
sh                          rsk7201_defconfig
nds32                               defconfig
m68k                             allyesconfig
arm                       imx_v4_v5_defconfig
arm                     am200epdkit_defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         orion5x_defconfig
m68k                        stmark2_defconfig
h8300                     edosk2674_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc40x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
sparc                            allyesconfig
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
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
