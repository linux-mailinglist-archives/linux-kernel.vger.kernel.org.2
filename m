Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690D240D2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 06:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhIPEm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 00:42:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:18752 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhIPEmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 00:42:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="222521961"
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="222521961"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 21:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="452791843"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Sep 2021 21:41:32 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mQjDH-0000jd-N0; Thu, 16 Sep 2021 04:41:31 +0000
Date:   Thu, 16 Sep 2021 12:40:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 81065b35e2486c024c7aa86caed452e1f01a59d4
Message-ID: <6142cac6.VLKBPK8HyzE76eM1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 81065b35e2486c024c7aa86caed452e1f01a59d4  x86/mce: Avoid infinite loop for copy from user recovery

elapsed time: 2643m

configs tested: 236
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210916
i386                 randconfig-c001-20210914
nds32                            alldefconfig
parisc                generic-64bit_defconfig
powerpc                          g5_defconfig
mips                         mpc30x_defconfig
powerpc                      acadia_defconfig
sh                        sh7785lcr_defconfig
sh                   sh7724_generic_defconfig
sh                          kfr2r09_defconfig
sh                     sh7710voipgw_defconfig
mips                 decstation_r4k_defconfig
riscv                            alldefconfig
mips                malta_qemu_32r6_defconfig
arm                        mvebu_v5_defconfig
arm                         vf610m4_defconfig
powerpc                      ppc40x_defconfig
sh                          rsk7201_defconfig
arm                       aspeed_g4_defconfig
sparc                            alldefconfig
mips                          rb532_defconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                    socrates_defconfig
powerpc                      cm5200_defconfig
xtensa                          iss_defconfig
arm                      jornada720_defconfig
sh                         ap325rxa_defconfig
arc                         haps_hs_defconfig
mips                        jmr3927_defconfig
mips                        vocore2_defconfig
powerpc                  iss476-smp_defconfig
powerpc                    amigaone_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 canyonlands_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                           se7705_defconfig
arm                            qcom_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        magician_defconfig
arm                         cm_x300_defconfig
sh                          polaris_defconfig
mips                        omega2p_defconfig
arm                        multi_v5_defconfig
arc                          axs103_defconfig
arm                           corgi_defconfig
m68k                        m5307c3_defconfig
m68k                            mac_defconfig
arm                     eseries_pxa_defconfig
powerpc                     redwood_defconfig
powerpc                      obs600_defconfig
powerpc                      bamboo_defconfig
m68k                       bvme6000_defconfig
arm                           sunxi_defconfig
arm                         axm55xx_defconfig
arm                           sama5_defconfig
arm                          ixp4xx_defconfig
arm                          lpd270_defconfig
ia64                          tiger_defconfig
arm                      pxa255-idp_defconfig
arc                           tb10x_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                  cavium_octeon_defconfig
arm                         s5pv210_defconfig
arm                         assabet_defconfig
mips                      pic32mzda_defconfig
sh                        sh7763rdp_defconfig
arm                        cerfcube_defconfig
ia64                                defconfig
nios2                            allyesconfig
powerpc                    mvme5100_defconfig
arm                       cns3420vb_defconfig
mips                        nlm_xlr_defconfig
arm                         bcm2835_defconfig
powerpc                 linkstation_defconfig
sh                   secureedge5410_defconfig
sh                          r7785rp_defconfig
m68k                       m5275evb_defconfig
arm                           spitz_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                        icon_defconfig
sh                                  defconfig
riscv                    nommu_virt_defconfig
i386                                defconfig
s390                       zfcpdump_defconfig
m68k                       m5249evb_defconfig
powerpc                   lite5200b_defconfig
mips                         cobalt_defconfig
arm                         shannon_defconfig
arm                  colibri_pxa300_defconfig
s390                             alldefconfig
riscv                          rv32_defconfig
x86_64               randconfig-c001-20210914
arm                  randconfig-c002-20210914
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210915
x86_64               randconfig-a003-20210915
x86_64               randconfig-a004-20210915
x86_64               randconfig-a006-20210915
x86_64               randconfig-a005-20210915
x86_64               randconfig-a001-20210915
i386                 randconfig-a004-20210915
i386                 randconfig-a005-20210915
i386                 randconfig-a006-20210915
i386                 randconfig-a002-20210915
i386                 randconfig-a001-20210915
i386                 randconfig-a003-20210915
x86_64               randconfig-a013-20210914
x86_64               randconfig-a016-20210914
x86_64               randconfig-a012-20210914
x86_64               randconfig-a011-20210914
x86_64               randconfig-a014-20210914
x86_64               randconfig-a015-20210914
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
i386                 randconfig-a016-20210914
i386                 randconfig-a015-20210914
i386                 randconfig-a011-20210914
i386                 randconfig-a012-20210914
i386                 randconfig-a013-20210914
i386                 randconfig-a014-20210914
i386                 randconfig-a016-20210916
i386                 randconfig-a015-20210916
i386                 randconfig-a011-20210916
i386                 randconfig-a012-20210916
i386                 randconfig-a013-20210916
i386                 randconfig-a014-20210916
arc                  randconfig-r043-20210915
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210914
x86_64               randconfig-c007-20210914
powerpc              randconfig-c003-20210914
arm                  randconfig-c002-20210914
i386                 randconfig-c001-20210914
s390                 randconfig-c005-20210914
riscv                randconfig-c006-20210916
x86_64               randconfig-c007-20210916
mips                 randconfig-c004-20210916
powerpc              randconfig-c003-20210916
arm                  randconfig-c002-20210916
i386                 randconfig-c001-20210916
s390                 randconfig-c005-20210916
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
i386                 randconfig-a004-20210914
i386                 randconfig-a005-20210914
i386                 randconfig-a006-20210914
i386                 randconfig-a002-20210914
i386                 randconfig-a001-20210914
i386                 randconfig-a003-20210914
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916
x86_64               randconfig-a013-20210915
x86_64               randconfig-a016-20210915
x86_64               randconfig-a012-20210915
x86_64               randconfig-a011-20210915
x86_64               randconfig-a014-20210915
x86_64               randconfig-a015-20210915
x86_64               randconfig-a002-20210914
x86_64               randconfig-a003-20210914
x86_64               randconfig-a004-20210914
x86_64               randconfig-a006-20210914
x86_64               randconfig-a005-20210914
x86_64               randconfig-a001-20210914
i386                 randconfig-a016-20210915
i386                 randconfig-a015-20210915
i386                 randconfig-a011-20210915
i386                 randconfig-a012-20210915
i386                 randconfig-a013-20210915
i386                 randconfig-a014-20210915
hexagon              randconfig-r045-20210914
hexagon              randconfig-r041-20210914
riscv                randconfig-r042-20210915
hexagon              randconfig-r045-20210915
s390                 randconfig-r044-20210915
hexagon              randconfig-r041-20210915

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
