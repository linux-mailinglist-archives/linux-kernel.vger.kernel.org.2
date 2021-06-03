Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7981F39AEE6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFCXwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:52:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:16840 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhFCXwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:52:13 -0400
IronPort-SDR: klNc5jldgCej8YYynZEZScD/3RA13Ox6M8w4QS4QOTYzzgPBhTkd2ddV6ECJRoiTPwWCPweNnf
 lE8ibfjtaroQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="184553487"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="184553487"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 16:50:27 -0700
IronPort-SDR: vYjGM/DYNPRFTpKNwbm9Mp44KxaRgEm8BbF+FJYq2Xwi1qAD0ZU2XdpLiWa4Cz+4fHNDDzzbtn
 WucS8B7hXF8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="400755826"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2021 16:50:25 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lox6W-0006T0-GE; Thu, 03 Jun 2021 23:50:24 +0000
Date:   Fri, 04 Jun 2021 07:49:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS WITH WARNING
 cbcddaa33d7e11a053cb80a4a635c023b4f8b906
Message-ID: <60b96a93.VJo/Y/h14jP0R5Lb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/cpu
branch HEAD: cbcddaa33d7e11a053cb80a4a635c023b4f8b906  perf/x86/rapl: Use CPUID bit on AMD and Hygon parts

possible Warning in current branch:

Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  111< /* free					( 3*32+29) */
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  111> #define X86_FEATURE_RAPL		( 3*32+29) /* AMD/Hygon RAPL interface */

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-allnoconfig
    |-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-cpufeatures.h-differs-from-latest-version-at-arch-x86-include-asm-cpufeatures.h:define-X86_FEATURE_RAPL-(-)-AMD-Hygon-RAPL-interface
    `-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-cpufeatures.h-differs-from-latest-version-at-arch-x86-include-asm-cpufeatures.h:free-(-)

elapsed time: 3123m

configs tested: 353
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
m68k                          amiga_defconfig
riscv                               defconfig
arm                           sunxi_defconfig
riscv                             allnoconfig
arm                            zeus_defconfig
mips                           ip27_defconfig
powerpc                       ebony_defconfig
arm                            xcep_defconfig
h8300                               defconfig
powerpc                 mpc834x_mds_defconfig
mips                     cu1830-neo_defconfig
powerpc                     pq2fads_defconfig
powerpc                      mgcoge_defconfig
arm                           spitz_defconfig
xtensa                              defconfig
powerpc                 mpc85xx_cds_defconfig
h8300                     edosk2674_defconfig
sparc64                          alldefconfig
arm                     am200epdkit_defconfig
arm                        multi_v5_defconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
arm                         s3c2410_defconfig
microblaze                          defconfig
arc                     nsimosci_hs_defconfig
arm                             mxs_defconfig
parisc                generic-64bit_defconfig
arm                           h5000_defconfig
ia64                      gensparse_defconfig
arm                          pxa168_defconfig
mips                          rm200_defconfig
sh                            titan_defconfig
powerpc                     tqm8548_defconfig
sh                         ap325rxa_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                         apsh4a3a_defconfig
arc                         haps_hs_defconfig
arm                         mv78xx0_defconfig
sh                         ecovec24_defconfig
mips                        workpad_defconfig
arc                     haps_hs_smp_defconfig
arm                           sama5_defconfig
sh                            migor_defconfig
powerpc                     tqm8560_defconfig
arc                                 defconfig
m68k                        mvme16x_defconfig
sh                           se7712_defconfig
powerpc                    amigaone_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
m68k                       m5275evb_defconfig
powerpc                 mpc836x_mds_defconfig
arm                        mini2440_defconfig
nds32                               defconfig
parisc                              defconfig
sh                               j2_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc837x_mds_defconfig
mips                       lemote2f_defconfig
arm                              alldefconfig
arc                        vdk_hs38_defconfig
powerpc                     powernv_defconfig
arm                       cns3420vb_defconfig
mips                        jmr3927_defconfig
sh                           sh2007_defconfig
m68k                        m5407c3_defconfig
x86_64                           alldefconfig
powerpc                      pmac32_defconfig
sh                          lboxre2_defconfig
sh                          polaris_defconfig
sh                          landisk_defconfig
um                           x86_64_defconfig
powerpc                 mpc832x_mds_defconfig
mips                    maltaup_xpa_defconfig
mips                        bcm47xx_defconfig
s390                       zfcpdump_defconfig
arm                         socfpga_defconfig
arm                         bcm2835_defconfig
mips                            ar7_defconfig
powerpc                  storcenter_defconfig
riscv                            allyesconfig
powerpc                      arches_defconfig
powerpc                     rainier_defconfig
m68k                       bvme6000_defconfig
sh                        sh7757lcr_defconfig
xtensa                           allyesconfig
xtensa                generic_kc705_defconfig
sh                          rsk7203_defconfig
powerpc                     ep8248e_defconfig
powerpc                     sequoia_defconfig
arm                         orion5x_defconfig
sh                          r7780mp_defconfig
arm                           h3600_defconfig
arm                            mps2_defconfig
arc                          axs103_defconfig
arm                         vf610m4_defconfig
arm                       multi_v4t_defconfig
mips                           rs90_defconfig
m68k                         amcore_defconfig
arm                        cerfcube_defconfig
powerpc                 canyonlands_defconfig
powerpc64                        alldefconfig
powerpc64                           defconfig
arc                           tb10x_defconfig
arm                             ezx_defconfig
sh                           se7343_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                   sb1250_swarm_defconfig
arm                    vt8500_v6_v7_defconfig
mips                            gpr_defconfig
h8300                       h8s-sim_defconfig
sh                         microdev_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     redwood_defconfig
powerpc                    gamecube_defconfig
mips                      loongson3_defconfig
nios2                         3c120_defconfig
powerpc                      pcm030_defconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
um                                  defconfig
nds32                             allnoconfig
x86_64                            allnoconfig
arc                              alldefconfig
arm                        neponset_defconfig
powerpc                      pasemi_defconfig
m68k                       m5475evb_defconfig
arm                          pcm027_defconfig
arm                         lubbock_defconfig
sh                        sh7785lcr_defconfig
sh                           se7722_defconfig
sh                          kfr2r09_defconfig
arm                  colibri_pxa270_defconfig
mips                            e55_defconfig
h8300                    h8300h-sim_defconfig
m68k                       m5208evb_defconfig
sh                          r7785rp_defconfig
mips                       capcella_defconfig
mips                        nlm_xlp_defconfig
sh                           se7721_defconfig
sh                   secureedge5410_defconfig
um                             i386_defconfig
arm                         s5pv210_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                        cell_defconfig
mips                        bcm63xx_defconfig
mips                        maltaup_defconfig
powerpc                      ppc64e_defconfig
s390                             alldefconfig
arm                       imx_v4_v5_defconfig
sparc                            allyesconfig
powerpc                      katmai_defconfig
nios2                               defconfig
mips                         db1xxx_defconfig
powerpc                     pseries_defconfig
powerpc                      tqm8xx_defconfig
sh                          urquell_defconfig
powerpc                      cm5200_defconfig
sh                            hp6xx_defconfig
um                            kunit_defconfig
i386                             alldefconfig
m68k                                defconfig
arm                      footbridge_defconfig
parisc                generic-32bit_defconfig
openrisc                 simple_smp_defconfig
arc                        nsimosci_defconfig
csky                             alldefconfig
arm                           omap1_defconfig
arm                        vexpress_defconfig
mips                          rb532_defconfig
mips                           ci20_defconfig
mips                           mtx1_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                        warp_defconfig
powerpc                     stx_gp3_defconfig
mips                         cobalt_defconfig
mips                  cavium_octeon_defconfig
arm                         lpc18xx_defconfig
arm                         palmz72_defconfig
sparc                               defconfig
powerpc                         wii_defconfig
mips                      fuloong2e_defconfig
powerpc                      acadia_defconfig
powerpc                         ps3_defconfig
sh                           se7206_defconfig
powerpc                 linkstation_defconfig
riscv             nommu_k210_sdcard_defconfig
sparc                       sparc32_defconfig
sh                        sh7763rdp_defconfig
sh                     sh7710voipgw_defconfig
powerpc                    ge_imp3a_defconfig
openrisc                  or1klitex_defconfig
arc                          axs101_defconfig
powerpc                       maple_defconfig
sparc64                             defconfig
arm                            qcom_defconfig
m68k                            q40_defconfig
h8300                            alldefconfig
mips                         tb0219_defconfig
mips                     loongson2k_defconfig
mips                      pistachio_defconfig
nios2                         10m50_defconfig
powerpc                   currituck_defconfig
mips                         tb0226_defconfig
arm                       aspeed_g4_defconfig
xtensa                  cadence_csp_defconfig
arm                  colibri_pxa300_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         shannon_defconfig
powerpc                     tqm8541_defconfig
mips                       bmips_be_defconfig
arm                          simpad_defconfig
mips                      malta_kvm_defconfig
arm                       versatile_defconfig
mips                          ath25_defconfig
arm                          gemini_defconfig
arm                           stm32_defconfig
arm                          badge4_defconfig
m68k                         apollo_defconfig
sparc                       sparc64_defconfig
m68k                            mac_defconfig
m68k                        mvme147_defconfig
powerpc                     akebono_defconfig
parisc                           alldefconfig
m68k                        m5307c3_defconfig
powerpc                      chrp32_defconfig
powerpc                    adder875_defconfig
m68k                       m5249evb_defconfig
mips                        nlm_xlr_defconfig
arm                       spear13xx_defconfig
arm                        shmobile_defconfig
sh                          sdk7780_defconfig
riscv                    nommu_virt_defconfig
powerpc                     asp8347_defconfig
ia64                         bigsur_defconfig
sh                     magicpanelr2_defconfig
arm                       mainstone_defconfig
arm                       netwinder_defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210602
x86_64               randconfig-a004-20210602
x86_64               randconfig-a003-20210602
x86_64               randconfig-a006-20210602
x86_64               randconfig-a005-20210602
x86_64               randconfig-a001-20210602
i386                 randconfig-a003-20210602
i386                 randconfig-a006-20210602
i386                 randconfig-a004-20210602
i386                 randconfig-a001-20210602
i386                 randconfig-a005-20210602
i386                 randconfig-a002-20210602
i386                 randconfig-a003-20210601
i386                 randconfig-a006-20210601
i386                 randconfig-a004-20210601
i386                 randconfig-a001-20210601
i386                 randconfig-a002-20210601
i386                 randconfig-a005-20210601
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
x86_64               randconfig-a015-20210601
x86_64               randconfig-a011-20210601
x86_64               randconfig-a012-20210601
x86_64               randconfig-a014-20210601
x86_64               randconfig-a016-20210601
x86_64               randconfig-a013-20210601
x86_64               randconfig-a015-20210603
x86_64               randconfig-a011-20210603
x86_64               randconfig-a012-20210603
x86_64               randconfig-a014-20210603
x86_64               randconfig-a016-20210603
x86_64               randconfig-a013-20210603
i386                 randconfig-a015-20210603
i386                 randconfig-a011-20210603
i386                 randconfig-a014-20210603
i386                 randconfig-a012-20210603
i386                 randconfig-a015-20210602
i386                 randconfig-a013-20210602
i386                 randconfig-a016-20210602
i386                 randconfig-a011-20210602
i386                 randconfig-a014-20210602
i386                 randconfig-a012-20210602
i386                 randconfig-a015-20210601
i386                 randconfig-a013-20210601
i386                 randconfig-a011-20210601
i386                 randconfig-a016-20210601
i386                 randconfig-a014-20210601
i386                 randconfig-a012-20210601
i386                 randconfig-a013-20210603
i386                 randconfig-a016-20210603
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210601
x86_64               randconfig-b001-20210602
x86_64               randconfig-b001-20210603
x86_64               randconfig-a002-20210603
x86_64               randconfig-a004-20210603
x86_64               randconfig-a003-20210603
x86_64               randconfig-a006-20210603
x86_64               randconfig-a005-20210603
x86_64               randconfig-a001-20210603
x86_64               randconfig-a002-20210601
x86_64               randconfig-a004-20210601
x86_64               randconfig-a003-20210601
x86_64               randconfig-a006-20210601
x86_64               randconfig-a005-20210601
x86_64               randconfig-a001-20210601
x86_64               randconfig-a015-20210602
x86_64               randconfig-a011-20210602
x86_64               randconfig-a012-20210602
x86_64               randconfig-a014-20210602
x86_64               randconfig-a016-20210602
x86_64               randconfig-a013-20210602

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
