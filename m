Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70D53A4A20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhFKU3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:29:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:61946 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhFKU3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:29:39 -0400
IronPort-SDR: fGWv/28po4scJKqq95sD2B2d7KGdQKe2CEAs5oL6+xcBob3uSNPamys9JHh9ZXgEA/2SywkukQ
 Loj3BD42HXfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="192715324"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="192715324"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 13:27:38 -0700
IronPort-SDR: vVObm5HnaY+QR9/C8VYk+aj+2TR7N0QGFHdSRALgZK/LORdw75UrBm6+nMeCokW1IxoSux27Wz
 7xWFOizV2n7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="450879359"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2021 13:27:37 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrnkf-0000hV-HT; Fri, 11 Jun 2021 20:27:37 +0000
Date:   Sat, 12 Jun 2021 04:27:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:tip] BUILD SUCCESS 3a1176a9af5a1b7d7a0a40b0975412008eb221c3
Message-ID: <60c3c723.X+QEHxMuTiZ6Pqj9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip
branch HEAD: 3a1176a9af5a1b7d7a0a40b0975412008eb221c3  auto-x86-next: Rename x86/seves to x86/sev

elapsed time: 720m

configs tested: 161
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc836x_rdk_defconfig
arm                         cm_x300_defconfig
arm                         s3c6400_defconfig
mips                           jazz_defconfig
arm                     davinci_all_defconfig
mips                malta_qemu_32r6_defconfig
mips                     cu1000-neo_defconfig
s390                                defconfig
powerpc                  iss476-smp_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      walnut_defconfig
powerpc                     sequoia_defconfig
m68k                        m5272c3_defconfig
xtensa                              defconfig
arm                          moxart_defconfig
powerpc                      bamboo_defconfig
powerpc                      ppc6xx_defconfig
mips                          ath25_defconfig
powerpc                     kmeter1_defconfig
arm                             pxa_defconfig
openrisc                         alldefconfig
sh                          kfr2r09_defconfig
arm                        realview_defconfig
mips                           ip32_defconfig
m68k                        m5307c3_defconfig
powerpc                      acadia_defconfig
sh                     sh7710voipgw_defconfig
arm                          pxa3xx_defconfig
arm64                            alldefconfig
powerpc                      cm5200_defconfig
m68k                            mac_defconfig
arc                     nsimosci_hs_defconfig
arm                      jornada720_defconfig
sh                         ap325rxa_defconfig
powerpc                      ep88xc_defconfig
m68k                       m5475evb_defconfig
powerpc                       ppc64_defconfig
sh                         ecovec24_defconfig
mips                      maltasmvp_defconfig
sh                      rts7751r2d1_defconfig
powerpc64                           defconfig
arm                            hisi_defconfig
ia64                      gensparse_defconfig
sh                           se7721_defconfig
m68k                        m5407c3_defconfig
arm                             mxs_defconfig
arm                            pleb_defconfig
arm                         palmz72_defconfig
sh                          polaris_defconfig
arm                            qcom_defconfig
m68k                       m5249evb_defconfig
sparc                            alldefconfig
arm                           spitz_defconfig
powerpc                     stx_gp3_defconfig
arm                      tct_hammer_defconfig
m68k                          sun3x_defconfig
mips                            gpr_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                generic_kc705_defconfig
arm                        shmobile_defconfig
arm                       imx_v6_v7_defconfig
ia64                          tiger_defconfig
mips                         tb0226_defconfig
arm                           sunxi_defconfig
arm                      footbridge_defconfig
arm                        multi_v7_defconfig
sh                           se7780_defconfig
sh                                  defconfig
sh                          rsk7203_defconfig
mips                      fuloong2e_defconfig
sh                        edosk7760_defconfig
sh                   rts7751r2dplus_defconfig
xtensa                  nommu_kc705_defconfig
mips                        workpad_defconfig
h8300                     edosk2674_defconfig
openrisc                  or1klitex_defconfig
sh                          rsk7269_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     eseries_pxa_defconfig
mips                        bcm47xx_defconfig
mips                  decstation_64_defconfig
arm                      integrator_defconfig
arm                        spear6xx_defconfig
arm                        trizeps4_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210611
x86_64               randconfig-a001-20210611
x86_64               randconfig-a004-20210611
x86_64               randconfig-a003-20210611
x86_64               randconfig-a006-20210611
x86_64               randconfig-a005-20210611
i386                 randconfig-a002-20210611
i386                 randconfig-a006-20210611
i386                 randconfig-a004-20210611
i386                 randconfig-a001-20210611
i386                 randconfig-a005-20210611
i386                 randconfig-a003-20210611
i386                 randconfig-a015-20210611
i386                 randconfig-a013-20210611
i386                 randconfig-a016-20210611
i386                 randconfig-a014-20210611
i386                 randconfig-a012-20210611
i386                 randconfig-a011-20210611
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                      rhel-8.3-kbuiltin
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210611
x86_64               randconfig-a011-20210611
x86_64               randconfig-a012-20210611
x86_64               randconfig-a014-20210611
x86_64               randconfig-a016-20210611
x86_64               randconfig-a013-20210611

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
