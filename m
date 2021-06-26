Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0756A3B4C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 04:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFZCqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 22:46:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:23769 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhFZCqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 22:46:55 -0400
IronPort-SDR: GSKjEr6Kl56jThWq38VxMyUvO348Jsu2ZNM61H+9owOwDlsDIi7pggQAzBaG+cCU+CZsmrONw5
 +Y30gb+AvDmA==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="207801539"
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="207801539"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 19:44:27 -0700
IronPort-SDR: 6tm6lKGZmpA1hATQolIQWr6Le25aNV5SPowQGsDKn+ibFqXYhQ7HcltME1G/mFsEAvmu+aUdpJ
 y8oXrcChM0JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="482026546"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jun 2021 19:44:26 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwyIz-0007Wz-AS; Sat, 26 Jun 2021 02:44:25 +0000
Date:   Sat, 26 Jun 2021 10:43:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.06.24a] BUILD SUCCESS
 858991c3d51627e8c0fe04667c862a51e306bb33
Message-ID: <60d69466.RlD9XidRLmxqKsLd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.06.24a
branch HEAD: 858991c3d51627e8c0fe04667c862a51e306bb33  doc: Give XDP as example of non-obvious RCU reader/updater pairing

elapsed time: 730m

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
arm                             pxa_defconfig
sh                          rsk7264_defconfig
sh                             espt_defconfig
powerpc                      ppc64e_defconfig
arm                          simpad_defconfig
mips                  maltasmvp_eva_defconfig
ia64                                defconfig
mips                         db1xxx_defconfig
sh                        apsh4ad0a_defconfig
mips                         tb0226_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      malta_kvm_defconfig
mips                malta_qemu_32r6_defconfig
arm                          ep93xx_defconfig
xtensa                           alldefconfig
mips                        bcm47xx_defconfig
powerpc                     skiroot_defconfig
microblaze                          defconfig
powerpc                 mpc836x_mds_defconfig
sh                          rsk7201_defconfig
s390                          debug_defconfig
powerpc                 mpc832x_mds_defconfig
arc                            hsdk_defconfig
arc                           tb10x_defconfig
ia64                            zx1_defconfig
powerpc                           allnoconfig
powerpc                         ps3_defconfig
powerpc                      mgcoge_defconfig
sh                        sh7785lcr_defconfig
sh                           se7721_defconfig
sh                        edosk7705_defconfig
arm                         bcm2835_defconfig
sh                               j2_defconfig
sh                          r7785rp_defconfig
h8300                            alldefconfig
mips                 decstation_r4k_defconfig
arm                          pxa3xx_defconfig
arm                          moxart_defconfig
arm                           u8500_defconfig
arm                         palmz72_defconfig
powerpc                 mpc834x_mds_defconfig
i386                             alldefconfig
x86_64                              defconfig
arm                             ezx_defconfig
arm                           sunxi_defconfig
powerpc                 mpc834x_itx_defconfig
mips                      fuloong2e_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         s3c6400_defconfig
mips                      pic32mzda_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8560_defconfig
arc                     nsimosci_hs_defconfig
arm                         hackkit_defconfig
mips                     cu1830-neo_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       m5275evb_defconfig
powerpc                     pq2fads_defconfig
arm                         vf610m4_defconfig
m68k                            mac_defconfig
microblaze                      mmu_defconfig
arm                        trizeps4_defconfig
m68k                         amcore_defconfig
sh                           sh2007_defconfig
arm                           viper_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210625
x86_64               randconfig-a001-20210625
x86_64               randconfig-a005-20210625
x86_64               randconfig-a003-20210625
x86_64               randconfig-a004-20210625
x86_64               randconfig-a006-20210625
i386                 randconfig-a002-20210625
i386                 randconfig-a001-20210625
i386                 randconfig-a003-20210625
i386                 randconfig-a006-20210625
i386                 randconfig-a005-20210625
i386                 randconfig-a004-20210625
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210625
i386                 randconfig-a014-20210625
i386                 randconfig-a013-20210625
i386                 randconfig-a015-20210625
i386                 randconfig-a012-20210625
i386                 randconfig-a016-20210625
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210625
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622
x86_64               randconfig-a012-20210625
x86_64               randconfig-a016-20210625
x86_64               randconfig-a015-20210625
x86_64               randconfig-a014-20210625
x86_64               randconfig-a013-20210625
x86_64               randconfig-a011-20210625

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
