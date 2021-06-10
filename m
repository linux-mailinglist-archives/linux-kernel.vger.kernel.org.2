Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1DE3A34D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhFJUbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:31:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:45133 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhFJUbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:31:22 -0400
IronPort-SDR: tJprMLcKTv1VxXZ/57hLuuWJ+BtX39CdyYG86Olg9w5YsWxL2YNJFa7JCI3UnSfdCe52f7+AG/
 wjhPAxSFK6+g==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="203559311"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="203559311"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 13:29:24 -0700
IronPort-SDR: wm9iWjhwg92/WX3vAQ5eCmit3BtbFe7OLCOR84TeM4lSNKC73+m4mRxNSnH2PVQJKscWHeLtGE
 EE8W03eLrF9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="441348978"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 10 Jun 2021 13:29:23 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrRIo-0000GJ-VY; Thu, 10 Jun 2021 20:29:22 +0000
Date:   Fri, 11 Jun 2021 04:28:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 a8383dfb2138742a1bb77b481ada047aededa2ba
Message-ID: <60c275f4.TWTgoSIuX3TsGPXO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: a8383dfb2138742a1bb77b481ada047aededa2ba  x86/nmi_watchdog: Fix old-style NMI watchdog regression on old Intel CPUs

elapsed time: 723m

configs tested: 170
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                                defconfig
arm                       cns3420vb_defconfig
s390                             alldefconfig
sh                            shmin_defconfig
arm                          collie_defconfig
powerpc                  mpc885_ads_defconfig
arm                         lpc18xx_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          pxa910_defconfig
xtensa                  cadence_csp_defconfig
arm                        clps711x_defconfig
sparc                            alldefconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
sh                        edosk7760_defconfig
ia64                          tiger_defconfig
h8300                    h8300h-sim_defconfig
arm                        oxnas_v6_defconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
sparc                       sparc64_defconfig
riscv                             allnoconfig
mips                           jazz_defconfig
arm                          ep93xx_defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                        shmobile_defconfig
arc                         haps_hs_defconfig
ia64                        generic_defconfig
powerpc                         wii_defconfig
mips                        vocore2_defconfig
mips                     cu1830-neo_defconfig
mips                            ar7_defconfig
mips                        maltaup_defconfig
arm                        multi_v5_defconfig
xtensa                           alldefconfig
sh                        sh7785lcr_defconfig
s390                       zfcpdump_defconfig
powerpc                    socrates_defconfig
arm                          badge4_defconfig
arm                  colibri_pxa270_defconfig
xtensa                       common_defconfig
xtensa                    xip_kc705_defconfig
mips                         mpc30x_defconfig
h8300                            alldefconfig
sh                           se7721_defconfig
xtensa                           allyesconfig
um                                  defconfig
mips                      maltaaprp_defconfig
sh                      rts7751r2d1_defconfig
arm                         axm55xx_defconfig
sh                          rsk7264_defconfig
powerpc                      pasemi_defconfig
powerpc                      makalu_defconfig
mips                      fuloong2e_defconfig
um                           x86_64_defconfig
ia64                         bigsur_defconfig
sh                     sh7710voipgw_defconfig
powerpc                    ge_imp3a_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
parisc                           alldefconfig
mips                            gpr_defconfig
nios2                               defconfig
sh                           se7712_defconfig
mips                      pistachio_defconfig
arm                       spear13xx_defconfig
sh                           se7780_defconfig
powerpc                     powernv_defconfig
m68k                       m5475evb_defconfig
powerpc                     ppa8548_defconfig
mips                         db1xxx_defconfig
sh                               j2_defconfig
powerpc                      pmac32_defconfig
powerpc                          allmodconfig
powerpc                     mpc5200_defconfig
arm                         assabet_defconfig
mips                           ip32_defconfig
sh                   rts7751r2dplus_defconfig
mips                           ci20_defconfig
sh                          kfr2r09_defconfig
sh                             espt_defconfig
mips                     loongson1c_defconfig
microblaze                          defconfig
m68k                          multi_defconfig
mips                         rt305x_defconfig
powerpc                      tqm8xx_defconfig
nios2                         3c120_defconfig
powerpc                     tqm8541_defconfig
x86_64                           allyesconfig
arc                            hsdk_defconfig
powerpc                       ppc64_defconfig
arm                        neponset_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                 linkstation_defconfig
powerpc                    mvme5100_defconfig
powerpc                   lite5200b_defconfig
arm                      pxa255-idp_defconfig
powerpc                      ppc44x_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a005-20210610
i386                 randconfig-a003-20210610
x86_64               randconfig-a015-20210610
x86_64               randconfig-a011-20210610
x86_64               randconfig-a012-20210610
x86_64               randconfig-a014-20210610
x86_64               randconfig-a016-20210610
x86_64               randconfig-a013-20210610
i386                 randconfig-a015-20210610
i386                 randconfig-a013-20210610
i386                 randconfig-a016-20210610
i386                 randconfig-a014-20210610
i386                 randconfig-a012-20210610
i386                 randconfig-a011-20210610
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210610
x86_64               randconfig-a001-20210610
x86_64               randconfig-a004-20210610
x86_64               randconfig-a003-20210610
x86_64               randconfig-a006-20210610
x86_64               randconfig-a005-20210610

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
