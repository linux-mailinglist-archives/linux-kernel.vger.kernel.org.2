Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BB53B4113
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFYKEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:04:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:28503 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhFYKEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:04:12 -0400
IronPort-SDR: 8k6PCAwLpXE2BoTmWEXLtr/Vxf/W66SqzA8ff7GWOSs8BZpyw2GAbfDbaYTdTbjzk5SHgq12lB
 vaB4n8Ml25+A==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="207462551"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="207462551"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 03:01:50 -0700
IronPort-SDR: JvrgUNDYZviD6dpAFiafhi5p4yF0YYlYg9QdZBQvPaPzYtVSsl9v9lFhdsSQKckYAFgqx5rXHh
 fRJhNqvU4kqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="557660553"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2021 03:01:49 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwiei-00074f-E2; Fri, 25 Jun 2021 10:01:48 +0000
Date:   Fri, 25 Jun 2021 18:00:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 276010551664f73b6f1616dde471d6f0d63a73ba
Message-ID: <60d5a957.eYUl3tpT1Inh6N2H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 276010551664f73b6f1616dde471d6f0d63a73ba  time: Improve performance of time64_to_tm()

elapsed time: 1405m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                               defconfig
mips                           mtx1_defconfig
powerpc                      arches_defconfig
mips                            gpr_defconfig
m68k                        m5272c3_defconfig
microblaze                      mmu_defconfig
arm                             rpc_defconfig
arm                        magician_defconfig
mips                      maltasmvp_defconfig
s390                                defconfig
powerpc                      ppc44x_defconfig
m68k                          atari_defconfig
sh                   secureedge5410_defconfig
arm                              alldefconfig
mips                  maltasmvp_eva_defconfig
arm                        spear6xx_defconfig
sh                             espt_defconfig
mips                        qi_lb60_defconfig
h8300                            alldefconfig
powerpc                     akebono_defconfig
xtensa                generic_kc705_defconfig
riscv                             allnoconfig
openrisc                    or1ksim_defconfig
ia64                             allmodconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     pseries_defconfig
mips                        jmr3927_defconfig
arm                      footbridge_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                     davinci_all_defconfig
nios2                         10m50_defconfig
powerpc                      ppc64e_defconfig
m68k                           sun3_defconfig
powerpc                     ppa8548_defconfig
arm                        clps711x_defconfig
arm                        multi_v5_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7751_defconfig
mips                       capcella_defconfig
h8300                            allyesconfig
arm                        mvebu_v5_defconfig
arm                          exynos_defconfig
xtensa                              defconfig
powerpc                 mpc8540_ads_defconfig
m68k                          amiga_defconfig
powerpc                     sequoia_defconfig
arm                          badge4_defconfig
sh                   rts7751r2dplus_defconfig
arc                          axs103_defconfig
sh                           se7343_defconfig
powerpc                 mpc834x_mds_defconfig
arm                           sunxi_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                   milbeaut_m10v_defconfig
arm                           tegra_defconfig
powerpc                           allnoconfig
powerpc                       maple_defconfig
arm                           corgi_defconfig
arm                       aspeed_g5_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc836x_mds_defconfig
s390                          debug_defconfig
powerpc                       ebony_defconfig
powerpc                       holly_defconfig
m68k                       m5249evb_defconfig
mips                        omega2p_defconfig
x86_64                            allnoconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210623
x86_64               randconfig-a001-20210623
x86_64               randconfig-a005-20210623
x86_64               randconfig-a003-20210623
x86_64               randconfig-a004-20210623
x86_64               randconfig-a006-20210623
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
i386                 randconfig-a002-20210623
i386                 randconfig-a001-20210623
i386                 randconfig-a003-20210623
i386                 randconfig-a006-20210623
i386                 randconfig-a005-20210623
i386                 randconfig-a004-20210623
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210623
i386                 randconfig-a014-20210623
i386                 randconfig-a013-20210623
i386                 randconfig-a015-20210623
i386                 randconfig-a012-20210623
i386                 randconfig-a016-20210623
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests
x86_64                      rhel-8.3-kbuiltin

clang tested configs:
x86_64               randconfig-b001-20210624
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
