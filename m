Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E180539B2C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 08:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFDGoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 02:44:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:65401 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFDGoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 02:44:54 -0400
IronPort-SDR: ePt2ZVNp4KIhzTQyCemZqacx8cMSCGgRH1DyCtTs8/9WunSjG4Y+oX5m5wBhllTu1vl4F7ETtK
 udyaThhNIRpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="183917567"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="183917567"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 23:43:08 -0700
IronPort-SDR: 9rH7U0oTLBGq+wo684RCzxD+pXK4suc8nREO/suFN6MUbEQnx13QPiTJ84cOS+wrgyTfOu0aJi
 CbSqEs5ztleA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="480533126"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Jun 2021 23:43:06 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lp3Xu-0006jd-8g; Fri, 04 Jun 2021 06:43:06 +0000
Date:   Fri, 04 Jun 2021 14:42:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 40cd0aae5957ec175b73dc17dce6079d33fa74f6
Message-ID: <60b9cb72.PqNp5EAWb7NpT2ZW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 40cd0aae5957ec175b73dc17dce6079d33fa74f6  x86/mce: Include a MCi_MISC value in faked mce logs

elapsed time: 9508m

configs tested: 413
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                          axs101_defconfig
powerpc64                           defconfig
powerpc                    klondike_defconfig
arm                          badge4_defconfig
arm                           viper_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     powernv_defconfig
mips                        omega2p_defconfig
mips                        maltaup_defconfig
arm                           stm32_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         s5pv210_defconfig
xtensa                          iss_defconfig
m68k                        m5272c3_defconfig
mips                      loongson3_defconfig
h8300                       h8s-sim_defconfig
powerpc                 linkstation_defconfig
sh                          sdk7786_defconfig
powerpc                  storcenter_defconfig
powerpc                      pasemi_defconfig
powerpc                     rainier_defconfig
powerpc                   currituck_defconfig
m68k                           sun3_defconfig
ia64                             allmodconfig
sh                          rsk7203_defconfig
powerpc                    adder875_defconfig
h8300                               defconfig
arm                          collie_defconfig
m68k                        m5307c3_defconfig
s390                             allyesconfig
arm                         vf610m4_defconfig
mips                           ip22_defconfig
powerpc                 mpc836x_mds_defconfig
arm                       cns3420vb_defconfig
arc                        vdk_hs38_defconfig
arc                            hsdk_defconfig
s390                             allmodconfig
arm                        vexpress_defconfig
arm                         cm_x300_defconfig
sh                          urquell_defconfig
mips                malta_qemu_32r6_defconfig
arm                       netwinder_defconfig
arm                        mvebu_v7_defconfig
powerpc                    gamecube_defconfig
arm                         at91_dt_defconfig
arm                      footbridge_defconfig
arm                          exynos_defconfig
powerpc                      ppc40x_defconfig
arm                           sunxi_defconfig
arm                            qcom_defconfig
m68k                          sun3x_defconfig
sh                            shmin_defconfig
mips                 decstation_r4k_defconfig
nds32                            alldefconfig
mips                           ip27_defconfig
arc                      axs103_smp_defconfig
sparc                       sparc64_defconfig
arm                         assabet_defconfig
powerpc                        cell_defconfig
openrisc                  or1klitex_defconfig
mips                         bigsur_defconfig
mips                          rm200_defconfig
powerpc                    ge_imp3a_defconfig
arm                         s3c6400_defconfig
arm                        cerfcube_defconfig
microblaze                      mmu_defconfig
powerpc                      ppc44x_defconfig
powerpc                          allyesconfig
m68k                            q40_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                          atari_defconfig
m68k                       m5275evb_defconfig
m68k                        mvme147_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                            allyesconfig
arm                      pxa255-idp_defconfig
sh                         ecovec24_defconfig
sh                        sh7763rdp_defconfig
sh                   secureedge5410_defconfig
arm                             ezx_defconfig
sh                            hp6xx_defconfig
sh                 kfr2r09-romimage_defconfig
alpha                            alldefconfig
sh                           se7751_defconfig
mips                           xway_defconfig
sh                           se7705_defconfig
nios2                         3c120_defconfig
sh                          rsk7264_defconfig
s390                                defconfig
arm                          pxa3xx_defconfig
arm                       mainstone_defconfig
mips                          malta_defconfig
powerpc                     tqm8540_defconfig
sh                            migor_defconfig
arm                         orion5x_defconfig
arc                     haps_hs_smp_defconfig
mips                           ip32_defconfig
sh                     sh7710voipgw_defconfig
mips                        vocore2_defconfig
sh                           se7780_defconfig
mips                            ar7_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      chrp32_defconfig
powerpc                  mpc866_ads_defconfig
arm                         bcm2835_defconfig
powerpc                      mgcoge_defconfig
arm                            pleb_defconfig
powerpc                     ep8248e_defconfig
riscv                    nommu_virt_defconfig
sh                             espt_defconfig
mips                       bmips_be_defconfig
ia64                             allyesconfig
arm                      integrator_defconfig
s390                          debug_defconfig
sh                           se7206_defconfig
nds32                             allnoconfig
i386                                defconfig
mips                     loongson1c_defconfig
parisc                generic-32bit_defconfig
sh                          rsk7201_defconfig
sh                     magicpanelr2_defconfig
arm                        spear3xx_defconfig
mips                      bmips_stb_defconfig
m68k                         amcore_defconfig
mips                          rb532_defconfig
openrisc                 simple_smp_defconfig
openrisc                            defconfig
sh                           se7619_defconfig
mips                        nlm_xlp_defconfig
arm                          imote2_defconfig
sh                           se7750_defconfig
powerpc                     tqm8541_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                           se7712_defconfig
m68k                       bvme6000_defconfig
arm                          lpd270_defconfig
nios2                         10m50_defconfig
sh                   sh7770_generic_defconfig
arm                         lpc32xx_defconfig
s390                       zfcpdump_defconfig
powerpc                      tqm8xx_defconfig
powerpc                    socrates_defconfig
arm                           spitz_defconfig
mips                    maltaup_xpa_defconfig
um                           x86_64_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                            zx1_defconfig
nios2                            alldefconfig
arm                          ep93xx_defconfig
xtensa                  audio_kc705_defconfig
riscv                               defconfig
ia64                                defconfig
arm                          pcm027_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                             pxa_defconfig
mips                  cavium_octeon_defconfig
nds32                               defconfig
s390                             alldefconfig
m68k                             allmodconfig
powerpc                       holly_defconfig
powerpc                     tqm8555_defconfig
arm                        neponset_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          r7780mp_defconfig
arm                         nhk8815_defconfig
mips                        bcm47xx_defconfig
mips                           mtx1_defconfig
powerpc                     sbc8548_defconfig
arm                     am200epdkit_defconfig
powerpc                     ksi8560_defconfig
m68k                             alldefconfig
arm                             rpc_defconfig
mips                          ath79_defconfig
m68k                        stmark2_defconfig
arm                  colibri_pxa270_defconfig
m68k                         apollo_defconfig
m68k                       m5249evb_defconfig
sh                        dreamcast_defconfig
um                            kunit_defconfig
mips                           ip28_defconfig
m68k                       m5475evb_defconfig
arm                         palmz72_defconfig
sh                               alldefconfig
sh                          sdk7780_defconfig
arm                       aspeed_g5_defconfig
sh                               j2_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        realview_defconfig
mips                      pistachio_defconfig
arm                            mmp2_defconfig
arm                    vt8500_v6_v7_defconfig
mips                        workpad_defconfig
sh                               allmodconfig
arm                        mini2440_defconfig
mips                            e55_defconfig
m68k                        mvme16x_defconfig
mips                            gpr_defconfig
mips                   sb1250_swarm_defconfig
arm                         lpc18xx_defconfig
arm                        shmobile_defconfig
powerpc                       ebony_defconfig
mips                         db1xxx_defconfig
arm                            mps2_defconfig
sh                           se7721_defconfig
arm                  colibri_pxa300_defconfig
m68k                          hp300_defconfig
xtensa                    smp_lx200_defconfig
arc                     nsimosci_hs_defconfig
sparc64                          alldefconfig
sh                        sh7757lcr_defconfig
arm                     eseries_pxa_defconfig
mips                         mpc30x_defconfig
sh                           se7343_defconfig
powerpc                           allnoconfig
sh                           sh2007_defconfig
sh                          lboxre2_defconfig
arm                          moxart_defconfig
mips                       capcella_defconfig
nios2                               defconfig
powerpc                     mpc5200_defconfig
m68k                          amiga_defconfig
ia64                             alldefconfig
powerpc                       ppc64_defconfig
arm                          iop32x_defconfig
arc                              alldefconfig
mips                        nlm_xlr_defconfig
mips                           gcw0_defconfig
openrisc                    or1ksim_defconfig
arm                        clps711x_defconfig
sh                         apsh4a3a_defconfig
arm                          pxa910_defconfig
mips                      maltaaprp_defconfig
arm                          gemini_defconfig
powerpc                     tqm5200_defconfig
powerpc                 canyonlands_defconfig
microblaze                          defconfig
sh                          rsk7269_defconfig
nios2                            allyesconfig
arm64                            alldefconfig
riscv             nommu_k210_sdcard_defconfig
mips                       rbtx49xx_defconfig
powerpc                      walnut_defconfig
arm                        spear6xx_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                        qi_lb60_defconfig
mips                        jmr3927_defconfig
mips                          ath25_defconfig
powerpc                        fsp2_defconfig
arm                        keystone_defconfig
powerpc                     kilauea_defconfig
mips                           rs90_defconfig
mips                     loongson1b_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        oxnas_v6_defconfig
sh                        edosk7705_defconfig
arm                           sama5_defconfig
arc                         haps_hs_defconfig
arm                           h3600_defconfig
powerpc                          allmodconfig
xtensa                         virt_defconfig
mips                     loongson2k_defconfig
powerpc                          g5_defconfig
x86_64                            allnoconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
x86_64               randconfig-a006-20210531
x86_64               randconfig-a003-20210531
x86_64               randconfig-a005-20210531
x86_64               randconfig-a004-20210531
x86_64               randconfig-a002-20210531
x86_64               randconfig-a001-20210531
x86_64               randconfig-a005-20210526
x86_64               randconfig-a001-20210526
x86_64               randconfig-a006-20210526
x86_64               randconfig-a003-20210526
x86_64               randconfig-a004-20210526
x86_64               randconfig-a002-20210526
x86_64               randconfig-a001-20210528
x86_64               randconfig-a006-20210528
x86_64               randconfig-a005-20210528
x86_64               randconfig-a003-20210528
x86_64               randconfig-a004-20210528
x86_64               randconfig-a002-20210528
i386                 randconfig-a001-20210528
i386                 randconfig-a005-20210528
i386                 randconfig-a002-20210528
i386                 randconfig-a006-20210528
i386                 randconfig-a004-20210528
i386                 randconfig-a003-20210528
i386                 randconfig-a002-20210531
i386                 randconfig-a001-20210531
i386                 randconfig-a005-20210531
i386                 randconfig-a006-20210531
i386                 randconfig-a004-20210531
i386                 randconfig-a003-20210531
i386                 randconfig-a001-20210529
i386                 randconfig-a005-20210529
i386                 randconfig-a002-20210529
i386                 randconfig-a006-20210529
i386                 randconfig-a003-20210529
i386                 randconfig-a004-20210529
i386                 randconfig-a001-20210526
i386                 randconfig-a002-20210526
i386                 randconfig-a005-20210526
i386                 randconfig-a004-20210526
i386                 randconfig-a003-20210526
i386                 randconfig-a006-20210526
i386                 randconfig-a002-20210530
i386                 randconfig-a001-20210530
i386                 randconfig-a005-20210530
i386                 randconfig-a006-20210530
i386                 randconfig-a004-20210530
i386                 randconfig-a003-20210530
i386                 randconfig-a003-20210601
i386                 randconfig-a006-20210601
i386                 randconfig-a004-20210601
i386                 randconfig-a001-20210601
i386                 randconfig-a002-20210601
i386                 randconfig-a005-20210601
x86_64               randconfig-a013-20210529
x86_64               randconfig-a014-20210529
x86_64               randconfig-a012-20210529
x86_64               randconfig-a016-20210529
x86_64               randconfig-a015-20210529
x86_64               randconfig-a011-20210529
i386                 randconfig-a016-20210529
i386                 randconfig-a011-20210529
i386                 randconfig-a015-20210529
i386                 randconfig-a012-20210529
i386                 randconfig-a014-20210529
i386                 randconfig-a013-20210529
i386                 randconfig-a016-20210528
i386                 randconfig-a011-20210528
i386                 randconfig-a015-20210528
i386                 randconfig-a012-20210528
i386                 randconfig-a014-20210528
i386                 randconfig-a013-20210528
i386                 randconfig-a016-20210531
i386                 randconfig-a015-20210531
i386                 randconfig-a013-20210531
i386                 randconfig-a012-20210531
i386                 randconfig-a014-20210531
i386                 randconfig-a011-20210531
i386                 randconfig-a015-20210601
i386                 randconfig-a013-20210601
i386                 randconfig-a011-20210601
i386                 randconfig-a016-20210601
i386                 randconfig-a014-20210601
i386                 randconfig-a012-20210601
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210531
x86_64               randconfig-b001-20210528
x86_64               randconfig-b001-20210529
x86_64               randconfig-b001-20210527
x86_64               randconfig-b001-20210530
x86_64               randconfig-a013-20210528
x86_64               randconfig-a014-20210528
x86_64               randconfig-a012-20210528
x86_64               randconfig-a016-20210528
x86_64               randconfig-a015-20210528
x86_64               randconfig-a011-20210528
x86_64               randconfig-a014-20210531
x86_64               randconfig-a012-20210531
x86_64               randconfig-a013-20210531
x86_64               randconfig-a016-20210531
x86_64               randconfig-a015-20210531
x86_64               randconfig-a011-20210531
x86_64               randconfig-a013-20210526
x86_64               randconfig-a012-20210526
x86_64               randconfig-a014-20210526
x86_64               randconfig-a016-20210526
x86_64               randconfig-a015-20210526
x86_64               randconfig-a011-20210526
x86_64               randconfig-a006-20210529
x86_64               randconfig-a001-20210529
x86_64               randconfig-a005-20210529
x86_64               randconfig-a003-20210529
x86_64               randconfig-a004-20210529
x86_64               randconfig-a002-20210529

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
