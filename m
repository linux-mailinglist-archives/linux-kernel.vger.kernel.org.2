Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0112934E497
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhC3JmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:42:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:26082 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbhC3Jlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:41:46 -0400
IronPort-SDR: FePyl33dqP/nF9hcE6xA1oi6z+V0sqoFhr347gyhU22sro+zgvOxb3UHJco8LIkRA9kAPoJO+U
 Wl6QVjGiFrMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="171749031"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="171749031"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 02:41:28 -0700
IronPort-SDR: b/04sUIUzoD795bypNPMeHdEHkcs5eN0TUBYZGqXKjBxXbyPCyT4HztlWlpdOSbni7KLPRFhCn
 olBRlTFAUu3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="393549309"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2021 02:41:27 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRAsI-0005CL-E1; Tue, 30 Mar 2021 09:41:26 +0000
Date:   Tue, 30 Mar 2021 17:40:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS WITH WARNING
 e6d46eded43dacf6370a7ae70f927ef4692cfcab
Message-ID: <6062f21d.Ko/A0X0h3rHxrLYT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: e6d46eded43dacf6370a7ae70f927ef4692cfcab  genirq/irq_sim: Shrink devm_irq_domain_create_sim()

possible Warning in current branch:

kernel/irq/irq_sim.c:246 devm_irq_domain_create_sim() warn: passing zero to 'ERR_PTR'

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-m031-20210329
|   `-- kernel-irq-irq_sim.c-devm_irq_domain_create_sim()-warn:passing-zero-to-ERR_PTR
|-- x86_64-randconfig-m001-20210328
|   `-- kernel-irq-irq_sim.c-devm_irq_domain_create_sim()-warn:passing-zero-to-ERR_PTR
`-- x86_64-randconfig-m001-20210329
    `-- kernel-irq-irq_sim.c-devm_irq_domain_create_sim()-warn:passing-zero-to-ERR_PTR

elapsed time: 1199m

configs tested: 184
configs skipped: 2

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
arm64                            alldefconfig
xtensa                              defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      pcm030_defconfig
powerpc                    socrates_defconfig
mips                       lemote2f_defconfig
powerpc                      ppc44x_defconfig
powerpc                     sequoia_defconfig
powerpc                    gamecube_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                            hsdk_defconfig
sh                            hp6xx_defconfig
powerpc                      makalu_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       versatile_defconfig
arm                         mv78xx0_defconfig
mips                  maltasmvp_eva_defconfig
m68k                            mac_defconfig
sh                                  defconfig
m68k                          atari_defconfig
arm                      pxa255-idp_defconfig
arm                          iop32x_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                       m5208evb_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         vf610m4_defconfig
arm                        cerfcube_defconfig
arm                          lpd270_defconfig
m68k                        stmark2_defconfig
powerpc                    sam440ep_defconfig
powerpc                  storcenter_defconfig
parisc                           allyesconfig
arm                          simpad_defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
sh                 kfr2r09-romimage_defconfig
mips                        maltaup_defconfig
arc                     nsimosci_hs_defconfig
mips                   sb1250_swarm_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                       ebony_defconfig
sh                            titan_defconfig
sparc64                             defconfig
powerpc                 mpc834x_itx_defconfig
mips                         tb0219_defconfig
mips                            ar7_defconfig
arm                     am200epdkit_defconfig
arm                          pxa910_defconfig
arm                          collie_defconfig
m68k                       m5475evb_defconfig
sparc                            allyesconfig
sh                ecovec24-romimage_defconfig
arm                        vexpress_defconfig
sh                         ecovec24_defconfig
powerpc                      chrp32_defconfig
arm                            qcom_defconfig
arm                           sama5_defconfig
arc                        nsim_700_defconfig
mips                          ath25_defconfig
xtensa                generic_kc705_defconfig
arm                         lpc18xx_defconfig
powerpc                     rainier_defconfig
powerpc                   motionpro_defconfig
mips                           gcw0_defconfig
arm                          gemini_defconfig
powerpc                     ppa8548_defconfig
mips                         cobalt_defconfig
arm                      tct_hammer_defconfig
powerpc                       holly_defconfig
powerpc64                        alldefconfig
arm                  colibri_pxa300_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7724_defconfig
m68k                        m5407c3_defconfig
arm                          pcm027_defconfig
mips                           rs90_defconfig
powerpc                      ppc40x_defconfig
sh                        dreamcast_defconfig
arm                          pxa3xx_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          kfr2r09_defconfig
arm                        neponset_defconfig
powerpc                     mpc5200_defconfig
powerpc                  mpc885_ads_defconfig
mips                     loongson1b_defconfig
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
arm                         assabet_defconfig
sh                               alldefconfig
arm                         s3c6400_defconfig
xtensa                       common_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         cm_x300_defconfig
arm                             pxa_defconfig
nios2                            alldefconfig
powerpc                         ps3_defconfig
arm                       mainstone_defconfig
arm                           omap1_defconfig
riscv                    nommu_virt_defconfig
mips                      pic32mzda_defconfig
mips                        jmr3927_defconfig
m68k                       m5275evb_defconfig
mips                        nlm_xlp_defconfig
sh                           se7206_defconfig
mips                     cu1830-neo_defconfig
nios2                         10m50_defconfig
sh                            shmin_defconfig
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
s390                                defconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210329
x86_64               randconfig-a003-20210329
x86_64               randconfig-a006-20210329
x86_64               randconfig-a001-20210329
x86_64               randconfig-a005-20210329
x86_64               randconfig-a004-20210329
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a001-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
i386                 randconfig-a011-20210329
i386                 randconfig-a016-20210329
i386                 randconfig-a013-20210329
i386                 randconfig-a012-20210329
i386                 randconfig-a014-20210329
i386                 randconfig-a015-20210329
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a015-20210329
x86_64               randconfig-a012-20210329
x86_64               randconfig-a013-20210329
x86_64               randconfig-a014-20210329
x86_64               randconfig-a011-20210329
x86_64               randconfig-a016-20210329

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
