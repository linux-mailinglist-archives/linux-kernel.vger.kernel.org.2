Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C59D32BEC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575809AbhCCRgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:36:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:14596 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381270AbhCCOUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:20:17 -0500
IronPort-SDR: 6bn2ODiGUlqbQAniCuTqZTE5H/QDH4CHO6/bHLZ1L9uBs12VWzDMSCawMhj5GFuseqmuz8WqZa
 H/PucElZzyqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="206888516"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="206888516"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 06:18:42 -0800
IronPort-SDR: NfkQeCsjP2sVjHY9wVMwnwbs0q21vq8tvbtyoZercfEkiV4TZjBRvMf41C7O7ZCP522bPBoxXL
 IuRe/i3t6t2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="373990436"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 03 Mar 2021 06:18:41 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHSKn-0001XT-27; Wed, 03 Mar 2021 14:18:41 +0000
Date:   Wed, 03 Mar 2021 22:17:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/drm/radeon/si_dpm] BUILD SUCCESS
 1f0ec6f175331d2aa83986dfc2e5208ae250b03f
Message-ID: <603f9a8f.aDLrpMFzzSApzVYQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/drm/radeon/si_dpm
branch HEAD: 1f0ec6f175331d2aa83986dfc2e5208ae250b03f  drm/radeon/si_dpm: Replace one-element array with flexible-array in struct SISLANDS_SMC_SWSTATE

elapsed time: 721m

configs tested: 81
configs skipped: 2

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
m68k                        mvme16x_defconfig
arm                       cns3420vb_defconfig
arm                       omap2plus_defconfig
sh                          urquell_defconfig
mips                            ar7_defconfig
mips                          malta_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                            dove_defconfig
s390                       zfcpdump_defconfig
sh                      rts7751r2d1_defconfig
c6x                              alldefconfig
m68k                        m5407c3_defconfig
s390                             alldefconfig
m68k                           sun3_defconfig
sh                          rsk7201_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210302
i386                 randconfig-a003-20210302
i386                 randconfig-a002-20210302
i386                 randconfig-a004-20210302
i386                 randconfig-a006-20210302
i386                 randconfig-a001-20210302
i386                 randconfig-a016-20210303
i386                 randconfig-a012-20210303
i386                 randconfig-a014-20210303
i386                 randconfig-a013-20210303
i386                 randconfig-a011-20210303
i386                 randconfig-a015-20210303
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
