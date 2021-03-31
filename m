Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251B634FDFC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbhCaKXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:23:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:11506 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhCaKXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:23:15 -0400
IronPort-SDR: hY9L/JklEIOhduOY5tnGhYbhJ2PbAjU/vcjSl9iamXlHTHCNsfX6lMBmwVuJ1Ux32I8feFY+ye
 vs43jpYfSFlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="192001020"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="192001020"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 03:23:14 -0700
IronPort-SDR: bC+KVBoS52Juqx5R1W7wQFLKdXiSaNjA2aDVZoCPNJ/razK/3G9G+JXOqh93Uc9XfzRs14SATh
 lDyUo7kdkRTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="438721437"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Mar 2021 03:23:13 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRY0G-0005q1-7C; Wed, 31 Mar 2021 10:23:12 +0000
Date:   Wed, 31 Mar 2021 18:22:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING a7eacffc61cc1af1ebdb61e1736a8e6e08674eb8
Message-ID: <60644d53.pWyZJ+sY+1JDfBoF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: a7eacffc61cc1af1ebdb61e1736a8e6e08674eb8  hpfs: Replace one-element array with flexible-array member

possible Warning in current branch:

arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [3, 64] from the object at 'report' is out of the bounds of referenced subobject 'report' with type 'unsigned char' at offset 1 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [6, 26] from the object at 'param_element' is out of the bounds of referenced subobject 'qui' with type 'u8[3]' {aka 'unsigned char[3]'} at offset 2 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [6, 9] from the object at 'qos_info_element' is out of the bounds of referenced subobject 'qui' with type 'u8[3]' {aka 'unsigned char[3]'} at offset 2 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-a002-20210330
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|-- i386-randconfig-s002-20210330
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-report-is-out-of-the-bounds-of-referenced-subobject-report-with-type-unsigned-char-at-offset
|-- ia64-allmodconfig
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- ia64-allyesconfig
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- ia64-randconfig-c024-20210330
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- ia64-randconfig-r016-20210330
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- parisc-allyesconfig
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- powerpc-allyesconfig
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
|-- x86_64-randconfig-a005-20210330
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- x86_64-randconfig-c004-20210330
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
`-- x86_64-randconfig-c022-20210330
    `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset

elapsed time: 723m

configs tested: 98
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
nios2                         3c120_defconfig
xtensa                    xip_kc705_defconfig
openrisc                            defconfig
mips                           rs90_defconfig
arm                         s3c2410_defconfig
sh                          sdk7780_defconfig
m68k                          amiga_defconfig
sh                               j2_defconfig
arm                        magician_defconfig
arm                          exynos_defconfig
h8300                               defconfig
powerpc                     pq2fads_defconfig
powerpc                      obs600_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ppc44x_defconfig
mips                           xway_defconfig
powerpc                        fsp2_defconfig
powerpc                       ppc64_defconfig
arm                          iop32x_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
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
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
