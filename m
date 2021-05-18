Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A763387AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349782AbhEROH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:07:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:2698 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244785AbhEROH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:07:28 -0400
IronPort-SDR: 558/4rrIXlwN4s2NzFreMK3wFCQAuxtdWDUwQHQ3aUBpqKa/eVUe6h/2e35huTDxZGksrr76Yx
 cNsvOTjL+LHA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="198767614"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="198767614"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 07:06:09 -0700
IronPort-SDR: Vt+sJki3Auh60l00axS5+f7TEP8al1RhJnPDsxY8NUd0I6ODtTtZBz+KjdG3MbBYwV+SalX464
 6wwmH++crwUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="541984121"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2021 07:06:08 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lj0MK-0002D8-4Y; Tue, 18 May 2021 14:06:08 +0000
Date:   Tue, 18 May 2021 22:05:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/kspp] BUILD SUCCESS
 135436a7d2cdd505aacc142f7f57e388b23ba73e
Message-ID: <60a3c995.W2GbyIOuSX8iZNJ9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: 135436a7d2cdd505aacc142f7f57e388b23ba73e  xfrm: Fix fall-through warnings for Clang

elapsed time: 720m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
xtensa                         virt_defconfig
powerpc                     powernv_defconfig
arm                           omap1_defconfig
sh                           se7619_defconfig
powerpc                      ppc44x_defconfig
sh                     magicpanelr2_defconfig
um                           x86_64_defconfig
powerpc                     pseries_defconfig
powerpc                     taishan_defconfig
arm                          pxa910_defconfig
arm                          ixp4xx_defconfig
m68k                        stmark2_defconfig
sh                          urquell_defconfig
powerpc                      arches_defconfig
mips                    maltaup_xpa_defconfig
sh                             shx3_defconfig
powerpc                        cell_defconfig
mips                     decstation_defconfig
mips                       lemote2f_defconfig
sh                          rsk7201_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                      fuloong2e_defconfig
powerpc                     tqm5200_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210518
i386                 randconfig-a001-20210518
i386                 randconfig-a005-20210518
i386                 randconfig-a004-20210518
i386                 randconfig-a002-20210518
i386                 randconfig-a006-20210518
i386                 randconfig-a014-20210518
i386                 randconfig-a016-20210518
i386                 randconfig-a011-20210518
i386                 randconfig-a015-20210518
i386                 randconfig-a012-20210518
i386                 randconfig-a013-20210518
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-b001-20210518
x86_64               randconfig-a004-20210517
x86_64               randconfig-a003-20210517
x86_64               randconfig-a001-20210517
x86_64               randconfig-a005-20210517
x86_64               randconfig-a002-20210517
x86_64               randconfig-a006-20210517
x86_64               randconfig-a015-20210518
x86_64               randconfig-a012-20210518
x86_64               randconfig-a013-20210518
x86_64               randconfig-a011-20210518
x86_64               randconfig-a016-20210518
x86_64               randconfig-a014-20210518

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
