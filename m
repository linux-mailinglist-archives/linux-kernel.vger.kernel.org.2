Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207B736F563
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 07:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhD3FjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 01:39:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:36530 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhD3FjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 01:39:20 -0400
IronPort-SDR: nV8UR7FJUzEL1Dl/ki2X1y+tvyC0kZ3sl1fJ8rABt7rUToPSniHu4+hU9/C7lwARIBMJqNCYNv
 NLdhA9+uff4w==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177358451"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="177358451"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 22:38:32 -0700
IronPort-SDR: msy/FuCR5VF5ovvLSU/Hz4x1bzvBQGV0Gb2AP4dXFo6vh1DZTQjSKotF8puF9WUWIhSwcEnIzp
 x0aQjF0ZERuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="426316625"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Apr 2021 22:38:30 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lcLrC-00080D-2y; Fri, 30 Apr 2021 05:38:30 +0000
Date:   Fri, 30 Apr 2021 13:38:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/Warray-bounds] BUILD SUCCESS
 5701d11321a650d1100ae0d352a16e83b926de97
Message-ID: <608b97c1.573nj3MlSM73h2gI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/Warray-bounds
branch HEAD: 5701d11321a650d1100ae0d352a16e83b926de97  scsi: aacraid: Replace one-element array with flexible-array member

elapsed time: 725m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                           omap1_defconfig
arm                        mvebu_v7_defconfig
arm                         mv78xx0_defconfig
arc                        nsimosci_defconfig
arm                             pxa_defconfig
sh                          rsk7203_defconfig
arm                      tct_hammer_defconfig
arc                            hsdk_defconfig
arm                           sunxi_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                            q40_defconfig
arc                              alldefconfig
m68k                        m5272c3_defconfig
openrisc                 simple_smp_defconfig
powerpc                     ppa8548_defconfig
arc                          axs103_defconfig
mips                           gcw0_defconfig
sh                          kfr2r09_defconfig
arm                          pxa168_defconfig
sh                   rts7751r2dplus_defconfig
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
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210429
i386                 randconfig-a002-20210429
i386                 randconfig-a001-20210429
i386                 randconfig-a006-20210429
i386                 randconfig-a003-20210429
i386                 randconfig-a004-20210429
i386                 randconfig-a012-20210429
i386                 randconfig-a014-20210429
i386                 randconfig-a013-20210429
i386                 randconfig-a011-20210429
i386                 randconfig-a015-20210429
i386                 randconfig-a016-20210429
x86_64               randconfig-a004-20210429
x86_64               randconfig-a002-20210429
x86_64               randconfig-a005-20210429
x86_64               randconfig-a006-20210429
x86_64               randconfig-a001-20210429
x86_64               randconfig-a003-20210429
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210429
x86_64               randconfig-a016-20210429
x86_64               randconfig-a011-20210429
x86_64               randconfig-a014-20210429
x86_64               randconfig-a013-20210429
x86_64               randconfig-a012-20210429

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
