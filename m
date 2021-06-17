Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E8B3AB2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhFQLmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:42:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:23791 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFQLmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:42:45 -0400
IronPort-SDR: pEAAcIBUxnHdJtuDmMT/Bg/iIMZwwTQZbec/BL0si6Wxh/L+tcm1C5avyJ6rp4PNE3utF5RD3a
 SSJ7IwgpiV0Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="227864708"
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="227864708"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 04:40:38 -0700
IronPort-SDR: DIRCzFnnwRSKhe/Xd8OA+OgpjY1EnLeUjmgDjhqTiQUVJAVsWedA1jjNehnXdoqByAYaYg7cib
 MKmI5gNg6XKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="404911362"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2021 04:40:36 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltqNw-00020G-6M; Thu, 17 Jun 2021 11:40:36 +0000
Date:   Thu, 17 Jun 2021 19:40:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 e133f14a2c54041fb25445fcc5ea2c807960d646
Message-ID: <60cb3494.7ltDn7ehkt2PcgW/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: e133f14a2c54041fb25445fcc5ea2c807960d646  torture: Log more kvm-remote.sh information

elapsed time: 729m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        multi_v5_defconfig
arm                         orion5x_defconfig
riscv                            allmodconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      tqm8xx_defconfig
arm                            qcom_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                          malta_defconfig
powerpc                      ppc64e_defconfig
powerpc64                           defconfig
parisc                generic-64bit_defconfig
m68k                       bvme6000_defconfig
arm                            hisi_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
x86_64                           alldefconfig
arm                     am200epdkit_defconfig
powerpc                        cell_defconfig
mips                           ci20_defconfig
i386                             allyesconfig
parisc                generic-32bit_defconfig
arm                   milbeaut_m10v_defconfig
mips                    maltaup_xpa_defconfig
h8300                    h8300h-sim_defconfig
arm                            dove_defconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
mips                        bcm47xx_defconfig
sh                           se7705_defconfig
arm                           corgi_defconfig
sh                             sh03_defconfig
mips                             allmodconfig
xtensa                              defconfig
sparc                       sparc64_defconfig
xtensa                          iss_defconfig
mips                         cobalt_defconfig
mips                           ip22_defconfig
arm                       omap2plus_defconfig
h8300                     edosk2674_defconfig
powerpc                      ep88xc_defconfig
sh                         ecovec24_defconfig
arm                        multi_v7_defconfig
arm                          imote2_defconfig
m68k                        m5307c3_defconfig
sparc                            alldefconfig
arm                          exynos_defconfig
powerpc                 mpc836x_mds_defconfig
sh                   secureedge5410_defconfig
arm                           tegra_defconfig
mips                            gpr_defconfig
arm                          simpad_defconfig
powerpc                    socrates_defconfig
mips                     loongson1b_defconfig
alpha                               defconfig
m68k                        mvme147_defconfig
arm                  colibri_pxa270_defconfig
s390                       zfcpdump_defconfig
openrisc                  or1klitex_defconfig
sh                           se7724_defconfig
mips                          rm200_defconfig
arm                         nhk8815_defconfig
x86_64                            allnoconfig
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
x86_64               randconfig-a004-20210617
x86_64               randconfig-a001-20210617
x86_64               randconfig-a002-20210617
x86_64               randconfig-a003-20210617
x86_64               randconfig-a006-20210617
x86_64               randconfig-a005-20210617
i386                 randconfig-a002-20210617
i386                 randconfig-a006-20210617
i386                 randconfig-a001-20210617
i386                 randconfig-a004-20210617
i386                 randconfig-a005-20210617
i386                 randconfig-a003-20210617
i386                 randconfig-a015-20210617
i386                 randconfig-a013-20210617
i386                 randconfig-a016-20210617
i386                 randconfig-a012-20210617
i386                 randconfig-a014-20210617
i386                 randconfig-a011-20210617
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210617
x86_64               randconfig-a015-20210617
x86_64               randconfig-a011-20210617
x86_64               randconfig-a014-20210617
x86_64               randconfig-a012-20210617
x86_64               randconfig-a013-20210617
x86_64               randconfig-a016-20210617

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
