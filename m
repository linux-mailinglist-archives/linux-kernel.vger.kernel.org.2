Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488DD3A7C89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhFOK5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:57:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:54257 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhFOK5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:57:48 -0400
IronPort-SDR: NCatwPcsCFMPleCqEqCEGuOLlnoTXETUuj1O/WhQuNfOa/B9KY3nNpqj9iPwRBVcvh2X7bLK+J
 JJKCEXLs68iw==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="185661590"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="185661590"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 03:55:44 -0700
IronPort-SDR: 7iE7Hk59zJOhRSGFBQRDDe59wt2JIxnec2UnQgwNOYhW0rbuye0UN4fP1Uduzvk4fJ1CHlZ/RQ
 i3qquJGvYpFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="451935627"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2021 03:55:43 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lt6jO-0000Nq-CK; Tue, 15 Jun 2021 10:55:42 +0000
Date:   Tue, 15 Jun 2021 18:54:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 65ff382d8732f4668f54f4bfd296355bc89b59d7
Message-ID: <60c886fe.gd5MIN8I/BmycWku%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: 65ff382d8732f4668f54f4bfd296355bc89b59d7  Merge branch 'efi/core'

elapsed time: 2954m

configs tested: 142
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    amigaone_defconfig
mips                      malta_kvm_defconfig
um                             i386_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc64e_defconfig
powerpc                      katmai_defconfig
arc                              allyesconfig
sh                          kfr2r09_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                        spear3xx_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         s3c2410_defconfig
arm                         nhk8815_defconfig
arm                         bcm2835_defconfig
arm                           sama5_defconfig
arm64                            alldefconfig
ia64                          tiger_defconfig
m68k                         amcore_defconfig
microblaze                      mmu_defconfig
powerpc                      chrp32_defconfig
nios2                         10m50_defconfig
arm                           omap1_defconfig
sh                     magicpanelr2_defconfig
arm                             mxs_defconfig
sh                        sh7763rdp_defconfig
sh                          r7785rp_defconfig
arm                            mmp2_defconfig
powerpc                       eiger_defconfig
um                                  defconfig
x86_64                           alldefconfig
powerpc                       ppc64_defconfig
mips                        bcm47xx_defconfig
sh                           se7619_defconfig
powerpc                     ppa8548_defconfig
mips                         bigsur_defconfig
sh                             sh03_defconfig
powerpc                     taishan_defconfig
arm                          ixp4xx_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      walnut_defconfig
m68k                        mvme16x_defconfig
arm                         mv78xx0_defconfig
arm                            dove_defconfig
mips                      maltasmvp_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
powerpc                           allnoconfig
i386                 randconfig-a002-20210613
i386                 randconfig-a006-20210613
i386                 randconfig-a001-20210613
i386                 randconfig-a004-20210613
i386                 randconfig-a005-20210613
i386                 randconfig-a003-20210613
i386                 randconfig-a002-20210614
i386                 randconfig-a006-20210614
i386                 randconfig-a004-20210614
i386                 randconfig-a001-20210614
i386                 randconfig-a005-20210614
i386                 randconfig-a003-20210614
i386                 randconfig-a015-20210613
i386                 randconfig-a013-20210613
i386                 randconfig-a016-20210613
i386                 randconfig-a014-20210613
i386                 randconfig-a012-20210613
i386                 randconfig-a011-20210613
i386                 randconfig-a015-20210614
i386                 randconfig-a013-20210614
i386                 randconfig-a016-20210614
i386                 randconfig-a012-20210614
i386                 randconfig-a014-20210614
i386                 randconfig-a011-20210614
x86_64               randconfig-a002-20210613
x86_64               randconfig-a004-20210613
x86_64               randconfig-a001-20210613
x86_64               randconfig-a003-20210613
x86_64               randconfig-a006-20210613
x86_64               randconfig-a005-20210613
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210614
x86_64               randconfig-b001-20210613
x86_64               randconfig-a001-20210614
x86_64               randconfig-a004-20210614
x86_64               randconfig-a002-20210614
x86_64               randconfig-a003-20210614
x86_64               randconfig-a006-20210614
x86_64               randconfig-a005-20210614
x86_64               randconfig-a015-20210613
x86_64               randconfig-a011-20210613
x86_64               randconfig-a014-20210613
x86_64               randconfig-a012-20210613
x86_64               randconfig-a013-20210613
x86_64               randconfig-a016-20210613

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
