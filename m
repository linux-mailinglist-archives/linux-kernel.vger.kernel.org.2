Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FE634F838
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 07:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhCaFPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 01:15:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:3763 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhCaFPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 01:15:37 -0400
IronPort-SDR: NwakoFEH2q6+qXlTjbZvPi2xmIiwP5WtFwHOP5RiruU099XFWhctn7r5h2kJ9m3QXAMzKuOV88
 tGBODOikmZEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191396986"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="191396986"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 22:15:36 -0700
IronPort-SDR: CE7LvdSO0SXxqTRBZGSsfgzCsT56LFYuid+Li6LXydSSksA7PKCJkqjQp9cDt42XHwua5wtER8
 CwDaPJiYiQzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="438620920"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2021 22:15:35 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRTCY-0005fm-ND; Wed, 31 Mar 2021 05:15:34 +0000
Date:   Wed, 31 Mar 2021 13:15:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/wab/scsi-ufs] BUILD SUCCESS
 7dc98db8f2c28b0716d5c92b6f1046c9080ecb71
Message-ID: <60640558.lsAxiK6otPwTo9rv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wab/scsi-ufs
branch HEAD: 7dc98db8f2c28b0716d5c92b6f1046c9080ecb71  scsi: ufs: Fix out-of-bounds warnings in ufshcd_exec_raw_upiu_cmd

elapsed time: 730m

configs tested: 118
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
nios2                         3c120_defconfig
xtensa                    xip_kc705_defconfig
openrisc                            defconfig
mips                           rs90_defconfig
arm                         s3c2410_defconfig
sh                          rsk7203_defconfig
powerpc                        warp_defconfig
arm                          iop32x_defconfig
um                            kunit_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          gemini_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                        fsp2_defconfig
arc                              alldefconfig
ia64                      gensparse_defconfig
sh                          sdk7780_defconfig
m68k                          amiga_defconfig
sh                               j2_defconfig
arm                        magician_defconfig
arm                          exynos_defconfig
h8300                               defconfig
arm                  colibri_pxa300_defconfig
powerpc                      katmai_defconfig
mips                             allmodconfig
powerpc                      makalu_defconfig
arm                        multi_v7_defconfig
mips                      fuloong2e_defconfig
arm                       netwinder_defconfig
powerpc                      acadia_defconfig
powerpc                     tqm8560_defconfig
mips                            ar7_defconfig
mips                     cu1000-neo_defconfig
sparc                       sparc64_defconfig
sh                           se7619_defconfig
mips                         rt305x_defconfig
powerpc                   motionpro_defconfig
mips                          rm200_defconfig
sparc64                          alldefconfig
sh                            migor_defconfig
mips                   sb1250_swarm_defconfig
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
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
