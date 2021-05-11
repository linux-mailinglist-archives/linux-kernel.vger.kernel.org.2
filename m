Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB96437A680
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhEKMYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:24:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:23097 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231442AbhEKMYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:24:37 -0400
IronPort-SDR: I2lD96FD/wWYF5accgUOr6LSjNfrTUUNppSXmXoMUYG3md3EteLlVlEa/oWcA/jFXpoD4ZcKbK
 BAiFHLv1KvdA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199107925"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="199107925"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:23:30 -0700
IronPort-SDR: KKsGvNiL7kblYbkH/YQ1mN1bUwTfSTbRlW+s7/4P5Y1Pjq38YdqAYmt0l/Cly2R+m9l7YugUNn
 x1D697WZ/B7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="609465960"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2021 05:23:28 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgRQ8-0000hC-3v; Tue, 11 May 2021 12:23:28 +0000
Date:   Tue, 11 May 2021 20:22:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:kcsan] BUILD SUCCESS
 84276ad2747ded97568872dadcff8173d0826221
Message-ID: <609a7723.vNWvj7BsesYqAVpe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan
branch HEAD: 84276ad2747ded97568872dadcff8173d0826221  kcsan: Document "value changed" line

elapsed time: 728m

configs tested: 211
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
mips                           gcw0_defconfig
xtensa                         virt_defconfig
sh                          urquell_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8560_ads_defconfig
mips                    maltaup_xpa_defconfig
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
riscv                            alldefconfig
arm                         lpc32xx_defconfig
mips                      maltaaprp_defconfig
sh                     magicpanelr2_defconfig
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
powerpc                      ppc40x_defconfig
sh                        sh7757lcr_defconfig
arm                             mxs_defconfig
parisc                generic-64bit_defconfig
arm                          simpad_defconfig
mips                     decstation_defconfig
arm                            xcep_defconfig
mips                         tb0226_defconfig
sh                           se7705_defconfig
arm                       mainstone_defconfig
mips                            ar7_defconfig
powerpc                      bamboo_defconfig
parisc                generic-32bit_defconfig
arm                        mvebu_v7_defconfig
sh                           se7751_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
sh                           se7712_defconfig
arm                            hisi_defconfig
x86_64                              defconfig
sh                          sdk7780_defconfig
mips                     loongson1c_defconfig
arm                      footbridge_defconfig
h8300                            alldefconfig
nios2                               defconfig
mips                        workpad_defconfig
csky                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     skiroot_defconfig
nios2                         10m50_defconfig
arm                             rpc_defconfig
arc                           tb10x_defconfig
mips                        nlm_xlp_defconfig
powerpc                     ep8248e_defconfig
sh                        sh7763rdp_defconfig
sh                             espt_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         cm_x300_defconfig
arm                         socfpga_defconfig
sh                   sh7724_generic_defconfig
arc                        nsim_700_defconfig
arm                         nhk8815_defconfig
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
sh                          polaris_defconfig
xtensa                    xip_kc705_defconfig
mips                        maltaup_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                         tb0287_defconfig
m68k                            q40_defconfig
arm                            pleb_defconfig
m68k                           sun3_defconfig
sh                        edosk7760_defconfig
mips                      pistachio_defconfig
mips                  decstation_64_defconfig
arm                      jornada720_defconfig
x86_64                            allnoconfig
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
