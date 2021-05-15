Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2573E3814CE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 02:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhEOA7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 20:59:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:45469 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhEOA7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 20:59:38 -0400
IronPort-SDR: wxb/6v+CJiFsUkp90puVWskeOcw42SEbFe5GmFa9+WgZfYNqwGjPGyY0UFBdi+XAVoSel6Azdb
 1eRUUQrw59tw==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="261491811"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="261491811"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 17:58:26 -0700
IronPort-SDR: 2KSJ13jqU/SkRGhGALno8IShOZ8mOXzdR8lPcPmISFbI8XK902xk1rs2o/m89HBw4lzViumAsr
 LkiXDf8NjDLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="431917918"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 May 2021 17:58:25 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lhidM-0000xO-Hi; Sat, 15 May 2021 00:58:24 +0000
Date:   Sat, 15 May 2021 08:57:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 28188cc461f6cf8b7d28de4f6df52014cc1d5e39
Message-ID: <609f1c87.8x4MVG4JhvBlIfhz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 28188cc461f6cf8b7d28de4f6df52014cc1d5e39  x86/cpu: Fix core name for Sapphire Rapids

elapsed time: 725m

configs tested: 151
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc836x_rdk_defconfig
sh                          rsk7264_defconfig
arm                         lpc32xx_defconfig
powerpc                 mpc834x_mds_defconfig
sh                         ecovec24_defconfig
xtensa                  cadence_csp_defconfig
mips                          rm200_defconfig
arm                      pxa255-idp_defconfig
arm                        mini2440_defconfig
powerpc                       eiger_defconfig
powerpc                    socrates_defconfig
parisc                generic-64bit_defconfig
mips                          rb532_defconfig
mips                        nlm_xlr_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
m68k                        m5307c3_defconfig
m68k                       m5275evb_defconfig
arm                          iop32x_defconfig
powerpc                 mpc8315_rdb_defconfig
openrisc                  or1klitex_defconfig
powerpc                    amigaone_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     mpc5200_defconfig
arm                          ixp4xx_defconfig
arm                            mps2_defconfig
ia64                          tiger_defconfig
powerpc                   currituck_defconfig
riscv                               defconfig
arm                       imx_v4_v5_defconfig
powerpc                     tqm5200_defconfig
sh                   sh7770_generic_defconfig
h8300                               defconfig
sh                        sh7785lcr_defconfig
arc                                 defconfig
m68k                       m5249evb_defconfig
m68k                           sun3_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
mips                           ip22_defconfig
arc                          axs101_defconfig
m68k                          hp300_defconfig
powerpc                         wii_defconfig
riscv                          rv32_defconfig
xtensa                  nommu_kc705_defconfig
h8300                       h8s-sim_defconfig
riscv                            alldefconfig
powerpc                     ksi8560_defconfig
arm                          simpad_defconfig
arm                       mainstone_defconfig
openrisc                            defconfig
arm                        mvebu_v5_defconfig
arc                           tb10x_defconfig
sparc64                          alldefconfig
openrisc                    or1ksim_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210514
x86_64               randconfig-a003-20210514
x86_64               randconfig-a001-20210514
x86_64               randconfig-a005-20210514
x86_64               randconfig-a002-20210514
x86_64               randconfig-a006-20210514
i386                 randconfig-a003-20210514
i386                 randconfig-a001-20210514
i386                 randconfig-a004-20210514
i386                 randconfig-a005-20210514
i386                 randconfig-a002-20210514
i386                 randconfig-a006-20210514
x86_64               randconfig-a012-20210515
x86_64               randconfig-a015-20210515
x86_64               randconfig-a011-20210515
x86_64               randconfig-a013-20210515
x86_64               randconfig-a016-20210515
x86_64               randconfig-a014-20210515
i386                 randconfig-a016-20210515
i386                 randconfig-a014-20210515
i386                 randconfig-a011-20210515
i386                 randconfig-a012-20210515
i386                 randconfig-a015-20210515
i386                 randconfig-a013-20210515
i386                 randconfig-a016-20210514
i386                 randconfig-a014-20210514
i386                 randconfig-a011-20210514
i386                 randconfig-a012-20210514
i386                 randconfig-a015-20210514
i386                 randconfig-a013-20210514
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
x86_64               randconfig-a004-20210515
x86_64               randconfig-a003-20210515
x86_64               randconfig-a001-20210515
x86_64               randconfig-a005-20210515
x86_64               randconfig-a002-20210515
x86_64               randconfig-a006-20210515
x86_64               randconfig-a015-20210514
x86_64               randconfig-a012-20210514
x86_64               randconfig-a011-20210514
x86_64               randconfig-a013-20210514
x86_64               randconfig-a016-20210514
x86_64               randconfig-a014-20210514

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
