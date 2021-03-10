Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EBD334B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhCJWHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:07:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:30913 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233077AbhCJWGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:06:38 -0500
IronPort-SDR: giG5A3nnUZTr2WOMnVeLLVjbexlemS2cHdWSA1bj5ASUjjoOu1J7LL+/JzeHpA7t2PN7Mcbgdo
 enaVtZiucrEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="187936102"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="187936102"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:06:37 -0800
IronPort-SDR: ODSjEq3vixKPnCX5oeHCmtTwoyko+CIxWFmxuspHSfcueZYhRr9pEfstVz4sisHF54COI83lZ+
 GHYs3ZfsUCbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="603275939"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2021 14:06:36 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lK6yS-0000PN-33; Wed, 10 Mar 2021 22:06:36 +0000
Date:   Thu, 11 Mar 2021 06:05:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 4817a52b306136c8b2b2271d8770401441e4cf79
Message-ID: <604942b5.sWTS4QX1wbRqSOmk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/urgent
branch HEAD: 4817a52b306136c8b2b2271d8770401441e4cf79  seqlock,lockdep: Fix seqcount_latch_init()

elapsed time: 727m

configs tested: 173
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         db1xxx_defconfig
powerpc                     tqm8540_defconfig
powerpc                      ppc44x_defconfig
sparc                            allyesconfig
mips                         tb0287_defconfig
mips                     cu1830-neo_defconfig
powerpc                 mpc8540_ads_defconfig
mips                           jazz_defconfig
sh                          r7785rp_defconfig
m68k                          hp300_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc40x_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     pq2fads_defconfig
powerpc                      obs600_defconfig
powerpc                       holly_defconfig
powerpc                     kmeter1_defconfig
riscv                          rv32_defconfig
sh                          landisk_defconfig
sh                          rsk7264_defconfig
sh                          r7780mp_defconfig
m68k                        mvme16x_defconfig
powerpc                    mvme5100_defconfig
arm                             pxa_defconfig
powerpc                     tqm8541_defconfig
sh                          polaris_defconfig
powerpc                      ep88xc_defconfig
mips                       rbtx49xx_defconfig
powerpc                     mpc512x_defconfig
sh                   sh7770_generic_defconfig
arm                             ezx_defconfig
powerpc                       eiger_defconfig
ia64                            zx1_defconfig
ia64                             allmodconfig
i386                                defconfig
sh                                  defconfig
powerpc                 mpc832x_rdb_defconfig
arm                       cns3420vb_defconfig
m68k                       m5275evb_defconfig
h8300                               defconfig
mips                        bcm63xx_defconfig
mips                  maltasmvp_eva_defconfig
h8300                    h8300h-sim_defconfig
mips                            gpr_defconfig
powerpc64                        alldefconfig
sh                          urquell_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                       bvme6000_defconfig
x86_64                              defconfig
arm                        spear3xx_defconfig
microblaze                          defconfig
powerpc                 mpc836x_mds_defconfig
sh                          lboxre2_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    ge_imp3a_defconfig
arm                         hackkit_defconfig
mips                     loongson1b_defconfig
h8300                            alldefconfig
arm                       omap2plus_defconfig
arm                      tct_hammer_defconfig
arm                         lubbock_defconfig
arm                            hisi_defconfig
mips                           ip32_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                            ar7_defconfig
powerpc                     asp8347_defconfig
powerpc                         wii_defconfig
arm                       versatile_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         s3c2410_defconfig
mips                          ath79_defconfig
riscv                               defconfig
arm                            xcep_defconfig
arc                           tb10x_defconfig
arm                          ep93xx_defconfig
powerpc                     stx_gp3_defconfig
arm                          pxa910_defconfig
powerpc                        icon_defconfig
m68k                        m5307c3_defconfig
powerpc                     tqm5200_defconfig
xtensa                          iss_defconfig
sh                         ap325rxa_defconfig
arm                        multi_v5_defconfig
m68k                        m5272c3_defconfig
m68k                             allyesconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
sparc                               defconfig
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210308
x86_64               randconfig-a001-20210308
x86_64               randconfig-a004-20210308
x86_64               randconfig-a002-20210308
x86_64               randconfig-a005-20210308
x86_64               randconfig-a003-20210308
i386                 randconfig-a005-20210309
i386                 randconfig-a003-20210309
i386                 randconfig-a002-20210309
i386                 randconfig-a006-20210309
i386                 randconfig-a004-20210309
i386                 randconfig-a001-20210309
x86_64               randconfig-a013-20210309
x86_64               randconfig-a016-20210309
x86_64               randconfig-a015-20210309
x86_64               randconfig-a014-20210309
x86_64               randconfig-a011-20210309
x86_64               randconfig-a012-20210309
x86_64               randconfig-a011-20210310
x86_64               randconfig-a016-20210310
x86_64               randconfig-a013-20210310
x86_64               randconfig-a015-20210310
x86_64               randconfig-a014-20210310
x86_64               randconfig-a012-20210310
i386                 randconfig-a016-20210309
i386                 randconfig-a012-20210309
i386                 randconfig-a014-20210309
i386                 randconfig-a013-20210309
i386                 randconfig-a011-20210309
i386                 randconfig-a015-20210309
i386                 randconfig-a016-20210308
i386                 randconfig-a012-20210308
i386                 randconfig-a014-20210308
i386                 randconfig-a013-20210308
i386                 randconfig-a011-20210308
i386                 randconfig-a015-20210308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210308
x86_64               randconfig-a016-20210308
x86_64               randconfig-a015-20210308
x86_64               randconfig-a014-20210308
x86_64               randconfig-a011-20210308
x86_64               randconfig-a012-20210308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
