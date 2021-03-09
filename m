Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727EF331F9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 08:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCIHBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 02:01:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:58147 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhCIHA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 02:00:57 -0500
IronPort-SDR: YwnJyttLlPCuu8EAAo1kV/l+bfN6DCvOsYXnxqov33kY9O1E1O2pa2PaByNZN2qRxaHh/667WD
 sm3YdD/XH7Sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="184812561"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="184812561"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 23:00:56 -0800
IronPort-SDR: 8A55sAj3JBtycf3d/MHF0W2XM8yYdgqk4jT20rk4axuikLs0NvqUVsnL1VQD2SbF6mmvAnshxB
 IGANCVHecstg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="447398685"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2021 23:00:54 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lJWMQ-0001Rg-5w; Tue, 09 Mar 2021 07:00:54 +0000
Date:   Tue, 09 Mar 2021 15:00:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 361316d29e5718c52c92ee4a4d8d6ccb9d5d60a9
Message-ID: <60471cff.93Ij4giA25qy3b6y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 361316d29e5718c52c92ee4a4d8d6ccb9d5d60a9  Merge branch 'efi/urgent'

elapsed time: 720m

configs tested: 155
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
nds32                               defconfig
sh                           se7724_defconfig
mips                         bigsur_defconfig
mips                          ath25_defconfig
m68k                           sun3_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                               alldefconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
mips                        jmr3927_defconfig
arm                            hisi_defconfig
sh                   sh7724_generic_defconfig
sparc                            alldefconfig
mips                           rs90_defconfig
mips                      pistachio_defconfig
sh                           sh2007_defconfig
arm                          pxa3xx_defconfig
m68k                             alldefconfig
arm                          moxart_defconfig
powerpc                  storcenter_defconfig
arm                             ezx_defconfig
mips                       lemote2f_defconfig
h8300                            allyesconfig
powerpc                     tqm8541_defconfig
powerpc                     pq2fads_defconfig
arm                           stm32_defconfig
mips                 decstation_r4k_defconfig
i386                             alldefconfig
arc                                 defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                   lite5200b_defconfig
m68k                         amcore_defconfig
arm                         socfpga_defconfig
arm                          pcm027_defconfig
powerpc                     pseries_defconfig
arm                         s5pv210_defconfig
mips                    maltaup_xpa_defconfig
mips                        vocore2_defconfig
powerpc                    amigaone_defconfig
powerpc                    mvme5100_defconfig
arc                            hsdk_defconfig
arm                        multi_v5_defconfig
sh                              ul2_defconfig
powerpc                 mpc837x_mds_defconfig
arm                          pxa168_defconfig
arm                      jornada720_defconfig
sh                          rsk7203_defconfig
mips                        bcm47xx_defconfig
microblaze                      mmu_defconfig
powerpc                     skiroot_defconfig
arm                            qcom_defconfig
x86_64                           allyesconfig
arm                        realview_defconfig
arm                  colibri_pxa270_defconfig
arc                     nsimosci_hs_defconfig
arm                         nhk8815_defconfig
arc                          axs101_defconfig
powerpc                    ge_imp3a_defconfig
arm                     eseries_pxa_defconfig
mips                           jazz_defconfig
ia64                        generic_defconfig
mips                         tb0226_defconfig
m68k                        mvme16x_defconfig
arm                       aspeed_g5_defconfig
arc                           tb10x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210308
x86_64               randconfig-a001-20210308
x86_64               randconfig-a004-20210308
x86_64               randconfig-a002-20210308
x86_64               randconfig-a005-20210308
x86_64               randconfig-a003-20210308
i386                 randconfig-a005-20210309
i386                 randconfig-a003-20210309
i386                 randconfig-a002-20210309
i386                 randconfig-a006-20210309
i386                 randconfig-a004-20210309
i386                 randconfig-a001-20210309
i386                 randconfig-a005-20210308
i386                 randconfig-a003-20210308
i386                 randconfig-a002-20210308
i386                 randconfig-a006-20210308
i386                 randconfig-a004-20210308
i386                 randconfig-a001-20210308
x86_64               randconfig-a013-20210309
x86_64               randconfig-a016-20210309
x86_64               randconfig-a015-20210309
x86_64               randconfig-a014-20210309
x86_64               randconfig-a011-20210309
x86_64               randconfig-a012-20210309
i386                 randconfig-a016-20210309
i386                 randconfig-a012-20210309
i386                 randconfig-a014-20210309
i386                 randconfig-a013-20210309
i386                 randconfig-a011-20210309
i386                 randconfig-a015-20210309
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210308
x86_64               randconfig-a016-20210308
x86_64               randconfig-a015-20210308
x86_64               randconfig-a014-20210308
x86_64               randconfig-a011-20210308
x86_64               randconfig-a012-20210308
x86_64               randconfig-a006-20210309
x86_64               randconfig-a001-20210309
x86_64               randconfig-a004-20210309
x86_64               randconfig-a002-20210309
x86_64               randconfig-a005-20210309
x86_64               randconfig-a003-20210309

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
