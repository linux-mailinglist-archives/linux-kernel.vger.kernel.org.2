Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB413E843F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhHJUW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:22:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:45214 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhHJUW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:22:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="278733605"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="278733605"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 13:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="506326579"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2021 13:22:00 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mDYG7-000KtW-Gx; Tue, 10 Aug 2021 20:21:59 +0000
Date:   Wed, 11 Aug 2021 04:21:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 195671c13d06a9eb07d137351e27145d83c88b4e
Message-ID: <6112dfbd.aupBhMgSlxLgTCfJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 195671c13d06a9eb07d137351e27145d83c88b4e  rcutorture: Don't cpuhp_remove_state() if cpuhp_setup_state() failed

elapsed time: 5610m

configs tested: 347
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210804
i386                 randconfig-c001-20210805
i386                 randconfig-c001-20210807
h8300                       h8s-sim_defconfig
arm                       mainstone_defconfig
arm                            pleb_defconfig
powerpc                 mpc832x_mds_defconfig
sh                            titan_defconfig
powerpc                           allnoconfig
arm                         cm_x300_defconfig
arm                         axm55xx_defconfig
arm                       cns3420vb_defconfig
powerpc                       ppc64_defconfig
powerpc                          allmodconfig
m68k                        m5272c3_defconfig
arm                       aspeed_g4_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      mgcoge_defconfig
nios2                         10m50_defconfig
powerpc                      walnut_defconfig
arm                            xcep_defconfig
mips                        nlm_xlp_defconfig
sh                           se7721_defconfig
sparc                       sparc64_defconfig
sh                            migor_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                              alldefconfig
powerpc                 mpc832x_rdb_defconfig
nios2                            allyesconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     ep8248e_defconfig
mips                        qi_lb60_defconfig
arm                          exynos_defconfig
mips                           ip27_defconfig
arm                      tct_hammer_defconfig
powerpc                         wii_defconfig
openrisc                    or1ksim_defconfig
arm                         nhk8815_defconfig
mips                malta_qemu_32r6_defconfig
sparc                            alldefconfig
riscv                             allnoconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      obs600_defconfig
m68k                         amcore_defconfig
powerpc                      ppc64e_defconfig
powerpc                   microwatt_defconfig
arm                       aspeed_g5_defconfig
ia64                             allmodconfig
arc                                 defconfig
mips                     loongson1b_defconfig
arm                           sama5_defconfig
sh                     sh7710voipgw_defconfig
arc                    vdk_hs38_smp_defconfig
arc                        nsim_700_defconfig
arm                          imote2_defconfig
h8300                     edosk2674_defconfig
sh                          r7785rp_defconfig
powerpc                     ksi8560_defconfig
sh                        edosk7705_defconfig
xtensa                           allyesconfig
arc                     haps_hs_smp_defconfig
powerpc                        warp_defconfig
arc                              alldefconfig
arm                         socfpga_defconfig
parisc                              defconfig
arm                            dove_defconfig
xtensa                           alldefconfig
m68k                       m5475evb_defconfig
powerpc                      ppc44x_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     tqm5200_defconfig
sh                        sh7763rdp_defconfig
h8300                    h8300h-sim_defconfig
riscv                            allmodconfig
arm                         lpc18xx_defconfig
powerpc                     taishan_defconfig
arm                        keystone_defconfig
x86_64                            allnoconfig
sh                          rsk7264_defconfig
sh                   rts7751r2dplus_defconfig
arm                    vt8500_v6_v7_defconfig
sh                         apsh4a3a_defconfig
sh                          sdk7786_defconfig
arm                          lpd270_defconfig
arc                          axs103_defconfig
mips                           xway_defconfig
mips                    maltaup_xpa_defconfig
arm                         lpc32xx_defconfig
sh                              ul2_defconfig
mips                      maltasmvp_defconfig
riscv                            alldefconfig
mips                        jmr3927_defconfig
m68k                       bvme6000_defconfig
arm                       imx_v6_v7_defconfig
ia64                        generic_defconfig
mips                        bcm47xx_defconfig
powerpc                    klondike_defconfig
i386                                defconfig
sh                           se7343_defconfig
arc                              allyesconfig
powerpc                     mpc5200_defconfig
mips                           mtx1_defconfig
mips                          rb532_defconfig
m68k                            mac_defconfig
powerpc                 mpc836x_mds_defconfig
sh                 kfr2r09-romimage_defconfig
arm                           h3600_defconfig
arm                           omap1_defconfig
arm                       multi_v4t_defconfig
arm                          pxa168_defconfig
m68k                          atari_defconfig
mips                         tb0287_defconfig
arm64                            alldefconfig
arc                            hsdk_defconfig
powerpc                    sam440ep_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
powerpc                     tqm8541_defconfig
mips                       capcella_defconfig
arm                      pxa255-idp_defconfig
sh                          rsk7201_defconfig
mips                           ip28_defconfig
sh                           se7722_defconfig
sh                               j2_defconfig
s390                                defconfig
powerpc                     tqm8555_defconfig
sh                          polaris_defconfig
h8300                            allyesconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
powerpc                     pq2fads_defconfig
mips                        omega2p_defconfig
arm                          collie_defconfig
sh                      rts7751r2d1_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                          badge4_defconfig
powerpc                        cell_defconfig
mips                        vocore2_defconfig
s390                       zfcpdump_defconfig
arm                          moxart_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     mpc83xx_defconfig
sh                          rsk7203_defconfig
xtensa                       common_defconfig
arm                          gemini_defconfig
mips                       bmips_be_defconfig
parisc                           allyesconfig
mips                     loongson2k_defconfig
mips                      fuloong2e_defconfig
powerpc                       maple_defconfig
mips                     cu1000-neo_defconfig
powerpc                     asp8347_defconfig
s390                             alldefconfig
sh                             sh03_defconfig
powerpc                     rainier_defconfig
arm                        realview_defconfig
powerpc                 canyonlands_defconfig
powerpc                      ep88xc_defconfig
powerpc64                           defconfig
m68k                        stmark2_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                        edosk7760_defconfig
arm                           tegra_defconfig
microblaze                          defconfig
sh                           se7724_defconfig
powerpc                      ppc40x_defconfig
m68k                                defconfig
m68k                            q40_defconfig
arc                      axs103_smp_defconfig
mips                      pistachio_defconfig
csky                                defconfig
arm                     am200epdkit_defconfig
arm                      jornada720_defconfig
powerpc                 linkstation_defconfig
mips                             allyesconfig
um                                  defconfig
sh                     magicpanelr2_defconfig
powerpc                  mpc885_ads_defconfig
arm                       spear13xx_defconfig
m68k                       m5249evb_defconfig
sh                          urquell_defconfig
mips                     loongson1c_defconfig
powerpc                       holly_defconfig
xtensa                         virt_defconfig
powerpc                   lite5200b_defconfig
mips                          ath25_defconfig
sh                           sh2007_defconfig
arm                           viper_defconfig
powerpc                          allyesconfig
powerpc                      arches_defconfig
arm                          pcm027_defconfig
xtensa                  audio_kc705_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
x86_64               randconfig-a002-20210805
x86_64               randconfig-a006-20210805
x86_64               randconfig-a004-20210805
x86_64               randconfig-a003-20210805
x86_64               randconfig-a001-20210805
x86_64               randconfig-a005-20210805
i386                 randconfig-a005-20210805
i386                 randconfig-a004-20210805
i386                 randconfig-a002-20210805
i386                 randconfig-a006-20210805
i386                 randconfig-a003-20210805
i386                 randconfig-a001-20210805
i386                 randconfig-a004-20210808
i386                 randconfig-a005-20210808
i386                 randconfig-a006-20210808
i386                 randconfig-a002-20210808
i386                 randconfig-a001-20210808
i386                 randconfig-a003-20210808
i386                 randconfig-a004-20210809
i386                 randconfig-a005-20210809
i386                 randconfig-a006-20210809
i386                 randconfig-a002-20210809
i386                 randconfig-a001-20210809
i386                 randconfig-a003-20210809
i386                 randconfig-a005-20210804
i386                 randconfig-a004-20210804
i386                 randconfig-a002-20210804
i386                 randconfig-a006-20210804
i386                 randconfig-a003-20210804
i386                 randconfig-a001-20210804
i386                 randconfig-a005-20210806
i386                 randconfig-a004-20210806
i386                 randconfig-a002-20210806
i386                 randconfig-a006-20210806
i386                 randconfig-a003-20210806
i386                 randconfig-a001-20210806
x86_64               randconfig-a012-20210804
x86_64               randconfig-a016-20210804
x86_64               randconfig-a011-20210804
x86_64               randconfig-a013-20210804
x86_64               randconfig-a014-20210804
x86_64               randconfig-a015-20210804
x86_64               randconfig-a016-20210808
x86_64               randconfig-a012-20210808
x86_64               randconfig-a013-20210808
x86_64               randconfig-a011-20210808
x86_64               randconfig-a014-20210808
x86_64               randconfig-a015-20210808
x86_64               randconfig-a002-20210809
x86_64               randconfig-a004-20210809
x86_64               randconfig-a006-20210809
x86_64               randconfig-a003-20210809
x86_64               randconfig-a001-20210809
x86_64               randconfig-a005-20210809
i386                 randconfig-a012-20210808
i386                 randconfig-a015-20210808
i386                 randconfig-a011-20210808
i386                 randconfig-a013-20210808
i386                 randconfig-a014-20210808
i386                 randconfig-a016-20210808
i386                 randconfig-a012-20210807
i386                 randconfig-a011-20210807
i386                 randconfig-a015-20210807
i386                 randconfig-a013-20210807
i386                 randconfig-a014-20210807
i386                 randconfig-a016-20210807
i386                 randconfig-a012-20210805
i386                 randconfig-a011-20210805
i386                 randconfig-a015-20210805
i386                 randconfig-a013-20210805
i386                 randconfig-a014-20210805
i386                 randconfig-a016-20210805
i386                 randconfig-a012-20210809
i386                 randconfig-a015-20210809
i386                 randconfig-a011-20210809
i386                 randconfig-a013-20210809
i386                 randconfig-a014-20210809
i386                 randconfig-a016-20210809
i386                 randconfig-a012-20210806
i386                 randconfig-a011-20210806
i386                 randconfig-a015-20210806
i386                 randconfig-a013-20210806
i386                 randconfig-a014-20210806
i386                 randconfig-a016-20210806
i386                 randconfig-a012-20210804
i386                 randconfig-a011-20210804
i386                 randconfig-a015-20210804
i386                 randconfig-a013-20210804
i386                 randconfig-a014-20210804
i386                 randconfig-a016-20210804
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210808
x86_64               randconfig-c001-20210809
x86_64               randconfig-c001-20210805
x86_64               randconfig-c001-20210807
x86_64               randconfig-c001-20210806
x86_64               randconfig-c001-20210804
x86_64               randconfig-a002-20210804
x86_64               randconfig-a006-20210804
x86_64               randconfig-a004-20210804
x86_64               randconfig-a003-20210804
x86_64               randconfig-a001-20210804
x86_64               randconfig-a005-20210804
x86_64               randconfig-a002-20210808
x86_64               randconfig-a004-20210808
x86_64               randconfig-a006-20210808
x86_64               randconfig-a003-20210808
x86_64               randconfig-a001-20210808
x86_64               randconfig-a005-20210808
x86_64               randconfig-a016-20210809
x86_64               randconfig-a012-20210809
x86_64               randconfig-a013-20210809
x86_64               randconfig-a011-20210809
x86_64               randconfig-a014-20210809
x86_64               randconfig-a015-20210809
x86_64               randconfig-a012-20210805
x86_64               randconfig-a016-20210805
x86_64               randconfig-a011-20210805
x86_64               randconfig-a013-20210805
x86_64               randconfig-a014-20210805
x86_64               randconfig-a015-20210805

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
