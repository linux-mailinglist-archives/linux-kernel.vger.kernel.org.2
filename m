Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7ADE341211
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhCSBYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:24:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:12494 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232167AbhCSBYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:24:05 -0400
IronPort-SDR: aiUb92IdyJLQURE45uHmjISECydIed686abDG0opLsYE4OwfkBr3nt3DhiC1duhNOmPTEzJ4rw
 HlNdCX0lc86Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="176935339"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="176935339"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 18:24:04 -0700
IronPort-SDR: 5FNsu6K8sQ4fcvzEARxqFgHSSI0i1alqJyx2HLfX0MdaXiuhcrpD4hJIOLjteHN+g2CZKV1l4R
 Pd5VmWgyeQ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="606412452"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2021 18:24:03 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lN3ru-0001Vl-Pt; Fri, 19 Mar 2021 01:24:02 +0000
Date:   Fri, 19 Mar 2021 09:23:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 7aacb8c62f621e9f6f1b5f11bb19eb37ddbf00e2
Message-ID: <6053fcfb.iBwzTQst898NdoY+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 7aacb8c62f621e9f6f1b5f11bb19eb37ddbf00e2  sched: Fix various typos

elapsed time: 723m

configs tested: 148
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
mips                        workpad_defconfig
arm                         hackkit_defconfig
arm                         lpc18xx_defconfig
powerpc                      pcm030_defconfig
powerpc                     taishan_defconfig
powerpc                    socrates_defconfig
h8300                    h8300h-sim_defconfig
mips                  decstation_64_defconfig
arm                         nhk8815_defconfig
sh                                  defconfig
mips                     loongson1b_defconfig
m68k                        m5407c3_defconfig
sh                           se7712_defconfig
m68k                       m5275evb_defconfig
arm                           sunxi_defconfig
xtensa                    xip_kc705_defconfig
sh                         apsh4a3a_defconfig
s390                             alldefconfig
powerpc                     stx_gp3_defconfig
powerpc                     skiroot_defconfig
arm                            qcom_defconfig
m68k                       m5249evb_defconfig
powerpc                     pseries_defconfig
powerpc                      ppc64e_defconfig
arm                          badge4_defconfig
ia64                             allmodconfig
powerpc                 linkstation_defconfig
xtensa                  audio_kc705_defconfig
mips                        vocore2_defconfig
mips                  maltasmvp_eva_defconfig
mips                     decstation_defconfig
arm                          exynos_defconfig
mips                            gpr_defconfig
arm                       multi_v4t_defconfig
powerpc                    mvme5100_defconfig
arm64                            alldefconfig
ia64                          tiger_defconfig
arm                          moxart_defconfig
powerpc                    klondike_defconfig
sh                            migor_defconfig
riscv                          rv32_defconfig
sh                     magicpanelr2_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   lite5200b_defconfig
csky                             alldefconfig
powerpc                      acadia_defconfig
sh                   sh7724_generic_defconfig
mips                malta_qemu_32r6_defconfig
mips                          rb532_defconfig
sh                           se7721_defconfig
nios2                               defconfig
powerpc                    amigaone_defconfig
arm                        mvebu_v5_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                      makalu_defconfig
arm                          pxa3xx_defconfig
m68k                       m5208evb_defconfig
m68k                       bvme6000_defconfig
powerpc                     kmeter1_defconfig
sh                             sh03_defconfig
sh                               j2_defconfig
mips                        jmr3927_defconfig
arm                         assabet_defconfig
powerpc                 xes_mpc85xx_defconfig
nios2                            allyesconfig
arc                           tb10x_defconfig
powerpc                       eiger_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc8540_ads_defconfig
arm                            hisi_defconfig
mips                        nlm_xlr_defconfig
m68k                                defconfig
sh                         ap325rxa_defconfig
um                            kunit_defconfig
arm                          simpad_defconfig
sh                        edosk7705_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
x86_64               randconfig-a011-20210318
x86_64               randconfig-a016-20210318
x86_64               randconfig-a013-20210318
x86_64               randconfig-a015-20210318
x86_64               randconfig-a014-20210318
x86_64               randconfig-a012-20210318
i386                 randconfig-a013-20210318
i386                 randconfig-a016-20210318
i386                 randconfig-a011-20210318
i386                 randconfig-a014-20210318
i386                 randconfig-a015-20210318
i386                 randconfig-a012-20210318
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210318
x86_64               randconfig-a001-20210318
x86_64               randconfig-a005-20210318
x86_64               randconfig-a002-20210318
x86_64               randconfig-a003-20210318
x86_64               randconfig-a004-20210318

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
