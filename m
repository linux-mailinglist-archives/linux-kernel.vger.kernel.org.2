Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13641330237
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 15:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhCGOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 09:50:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:21459 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhCGOtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 09:49:55 -0500
IronPort-SDR: xKq1fsMwc49uIlUpHk41gkzNNIhlTCf9Oil0cuHted0OTH+z5QYOX2iwJyhs8pU+KJCDYwsuQx
 DFC481ZIFjqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="272925069"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="272925069"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:49:55 -0800
IronPort-SDR: +Zt26Rn6+/fRmhZH6LR/FeergpdBUPickgSEE2aLHDreGeWajKFI1JjzFj8WFtwpB1nsfLc5ns
 GGQy9JEtm9iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="369162617"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2021 06:49:53 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lIujB-0000UJ-27; Sun, 07 Mar 2021 14:49:53 +0000
Date:   Sun, 07 Mar 2021 22:49:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING 4cea190810e6547ea1a145d8841a22bf1aab44db
Message-ID: <6044e7e9.wSF1G/A7ASI6s7N9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: 4cea190810e6547ea1a145d8841a22bf1aab44db  scsi: aacraid: Replace one-element array with flexible-array member

possible Warning in current branch:

arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [3, 64] from the object at 'report' is out of the bounds of referenced subobject 'report' with type 'unsigned char' at offset 1 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [21, 32] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-a015-20210307
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-report-is-out-of-the-bounds-of-referenced-subobject-report-with-type-unsigned-char-at-offset
`-- mips-allyesconfig
    `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset

elapsed time: 750m

configs tested: 96
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      pasemi_defconfig
sh                        sh7763rdp_defconfig
powerpc                          g5_defconfig
xtensa                    smp_lx200_defconfig
csky                             alldefconfig
arm                         orion5x_defconfig
powerpc                    ge_imp3a_defconfig
arm                         hackkit_defconfig
arc                 nsimosci_hs_smp_defconfig
arc                         haps_hs_defconfig
powerpc                      arches_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     ep8248e_defconfig
powerpc                     sbc8548_defconfig
parisc                generic-32bit_defconfig
powerpc                     tqm8555_defconfig
mips                         tb0287_defconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
arc                      axs103_smp_defconfig
mips                       rbtx49xx_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210307
i386                 randconfig-a003-20210307
i386                 randconfig-a002-20210307
i386                 randconfig-a004-20210307
i386                 randconfig-a006-20210307
i386                 randconfig-a001-20210307
x86_64               randconfig-a013-20210307
x86_64               randconfig-a016-20210307
x86_64               randconfig-a015-20210307
x86_64               randconfig-a014-20210307
x86_64               randconfig-a012-20210307
x86_64               randconfig-a011-20210307
i386                 randconfig-a016-20210307
i386                 randconfig-a012-20210307
i386                 randconfig-a013-20210307
i386                 randconfig-a014-20210307
i386                 randconfig-a011-20210307
i386                 randconfig-a015-20210307
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

clang tested configs:
x86_64               randconfig-a006-20210307
x86_64               randconfig-a001-20210307
x86_64               randconfig-a004-20210307
x86_64               randconfig-a005-20210307
x86_64               randconfig-a002-20210307
x86_64               randconfig-a003-20210307

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
