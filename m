Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A5A37A681
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhEKMYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:24:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:36363 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhEKMYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:24:40 -0400
IronPort-SDR: xmYD0Ym3qk3oEVU5ufMroz+kkWG5j8vLQVmlzT9coHLZb5Kom/PCOdbhREdIBEDJu7Svvk7DoT
 2IR4notjI+OA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186867257"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="186867257"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:23:31 -0700
IronPort-SDR: m+PQ81zOrInK7O7kKzyU58cNzmRHgT4ZsQiRbDDS43QBIKWpCiAzj8PYkK993w1S/b3rgXs9Jl
 dxd8IeMGY4WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="541628883"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 May 2021 05:23:28 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgRQ8-0000h9-1J; Tue, 11 May 2021 12:23:28 +0000
Date:   Tue, 11 May 2021 20:23:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:clocksource] BUILD SUCCESS
 9f5c5a88cedc9051c8f358a16b3c879c79b41393
Message-ID: <609a7726.J6QQ3o9f61VpGvNn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git clocksource
branch HEAD: 9f5c5a88cedc9051c8f358a16b3c879c79b41393  clocksource: Print deviation in nanoseconds for unstable case

elapsed time: 728m

configs tested: 194
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
powerpc                    amigaone_defconfig
nios2                            allyesconfig
mips                      malta_kvm_defconfig
arm                           u8500_defconfig
sh                            hp6xx_defconfig
sh                  sh7785lcr_32bit_defconfig
i386                                defconfig
ia64                      gensparse_defconfig
arm                        neponset_defconfig
arm                         axm55xx_defconfig
m68k                       m5475evb_defconfig
sparc                       sparc64_defconfig
powerpc                   currituck_defconfig
m68k                        mvme147_defconfig
sh                             shx3_defconfig
arm                          gemini_defconfig
arm                          pcm027_defconfig
powerpc                     tqm8540_defconfig
sh                              ul2_defconfig
riscv                          rv32_defconfig
arm                          pxa3xx_defconfig
sh                          kfr2r09_defconfig
m68k                       m5208evb_defconfig
sh                   sh7770_generic_defconfig
arm                              alldefconfig
arm                         hackkit_defconfig
m68k                        m5407c3_defconfig
arm                        multi_v5_defconfig
xtensa                              defconfig
openrisc                    or1ksim_defconfig
powerpc                      mgcoge_defconfig
m68k                         amcore_defconfig
powerpc                     tqm8555_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      ppc40x_defconfig
sh                        sh7757lcr_defconfig
sh                          polaris_defconfig
mips                     loongson1c_defconfig
mips                       capcella_defconfig
arm                           sunxi_defconfig
sh                           se7705_defconfig
arm                       mainstone_defconfig
mips                            ar7_defconfig
powerpc                      bamboo_defconfig
parisc                generic-32bit_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc834x_itx_defconfig
mips                     decstation_defconfig
arm                        magician_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
arc                              alldefconfig
powerpc                     tqm8560_defconfig
nios2                               defconfig
mips                        workpad_defconfig
csky                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     skiroot_defconfig
arm                         cm_x300_defconfig
arm                         socfpga_defconfig
sh                   sh7724_generic_defconfig
arc                        nsim_700_defconfig
arm                         nhk8815_defconfig
i386                             alldefconfig
sh                        sh7763rdp_defconfig
x86_64                            allnoconfig
mips                            gpr_defconfig
arm                         orion5x_defconfig
mips                   sb1250_swarm_defconfig
nios2                         3c120_defconfig
arm                           stm32_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
arm                        multi_v7_defconfig
sh                           se7780_defconfig
arm                          moxart_defconfig
arc                 nsimosci_hs_smp_defconfig
um                             i386_defconfig
xtensa                  audio_kc705_defconfig
arm                         vf610m4_defconfig
powerpc                     pq2fads_defconfig
arm                           sama5_defconfig
powerpc                   lite5200b_defconfig
arc                        vdk_hs38_defconfig
sh                           se7751_defconfig
mips                          rm200_defconfig
powerpc                     pseries_defconfig
arm                          iop32x_defconfig
s390                          debug_defconfig
m68k                        m5307c3_defconfig
powerpc                 linkstation_defconfig
powerpc                      ppc64e_defconfig
arm                       netwinder_defconfig
sh                           sh2007_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm8541_defconfig
sh                          r7785rp_defconfig
mips                        omega2p_defconfig
arm                          imote2_defconfig
arm                      pxa255-idp_defconfig
arm                         assabet_defconfig
powerpc                     kilauea_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                         tb0287_defconfig
m68k                            q40_defconfig
arm                            pleb_defconfig
m68k                           sun3_defconfig
mips                           gcw0_defconfig
sh                        edosk7760_defconfig
mips                      pistachio_defconfig
mips                  decstation_64_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210511
i386                 randconfig-a001-20210511
i386                 randconfig-a005-20210511
i386                 randconfig-a004-20210511
i386                 randconfig-a002-20210511
i386                 randconfig-a006-20210511
x86_64               randconfig-a012-20210511
x86_64               randconfig-a015-20210511
x86_64               randconfig-a011-20210511
x86_64               randconfig-a013-20210511
x86_64               randconfig-a016-20210511
x86_64               randconfig-a014-20210511
i386                 randconfig-a016-20210511
i386                 randconfig-a014-20210511
i386                 randconfig-a011-20210511
i386                 randconfig-a015-20210511
i386                 randconfig-a012-20210511
i386                 randconfig-a013-20210511
x86_64               randconfig-a003-20210510
x86_64               randconfig-a004-20210510
x86_64               randconfig-a001-20210510
x86_64               randconfig-a005-20210510
x86_64               randconfig-a002-20210510
x86_64               randconfig-a006-20210510
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a003-20210511
x86_64               randconfig-a004-20210511
x86_64               randconfig-a001-20210511
x86_64               randconfig-a005-20210511
x86_64               randconfig-a002-20210511
x86_64               randconfig-a006-20210511

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
