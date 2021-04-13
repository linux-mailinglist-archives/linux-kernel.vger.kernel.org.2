Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D816F35D685
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 06:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhDMEdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 00:33:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:11962 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhDMEdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 00:33:05 -0400
IronPort-SDR: DHYJ45qomMazsE7vOS6/+AYHeiDLTMFbn/AsAALrJUdmzcp72BqPX0ngjDvwfE3MuuHU2u+sg2
 DkguTIxaUNcA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="255662151"
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="255662151"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 21:32:44 -0700
IronPort-SDR: MPAa1ip/TpnRqcUQmVw20CD/GxhZqAJY/Ht4zo8mHJnYza9HUy1cVxstNZs1ngWgGazH4klXho
 U7KHX1P8dFsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="521453140"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2021 21:32:42 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWAjB-0000p1-Tv; Tue, 13 Apr 2021 04:32:41 +0000
Date:   Tue, 13 Apr 2021 12:32:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING 8f00c4d955f8c343277181b46fac418101c521bf
Message-ID: <60751ed9.6ayblkwNjP5Tysd/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: 8f00c4d955f8c343277181b46fac418101c521bf  ixgbe: Fix out-bounds warning in ixgbe_host_interface_command()

possible Warning in current branch:

arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [18, 23] from the object at 'sig' is out of the bounds of referenced subobject 'daddr' with type 'u8[6]' {aka 'unsigned char[6]'} at offset 11 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [25, 95] from the object at 'sig' is out of the bounds of referenced subobject 'beacon_period' with type 'short unsigned int' at offset 22 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
drivers/iommu/intel/svm.c:1215:4: warning: 'memcpy' offset [25, 32] from the object at 'desc' is out of the bounds of referenced subobject 'qw2' with type 'long long unsigned int' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-c021-20210412
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-sig-is-out-of-the-bounds-of-referenced-subobject-beacon_period-with-type-short-unsigned-int-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-sig-is-out-of-the-bounds-of-referenced-subobject-daddr-with-type-u8-aka-unsigned-char-at-offset
|-- ia64-allmodconfig
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- ia64-allyesconfig
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- parisc-allyesconfig
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- x86_64-randconfig-a016-20210412
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   `-- drivers-iommu-intel-svm.c:warning:memcpy-offset-from-the-object-at-desc-is-out-of-the-bounds-of-referenced-subobject-qw2-with-type-long-long-unsigned-int-at-offset
|-- x86_64-randconfig-c002-20210412
|   `-- drivers-iommu-intel-svm.c:warning:memcpy-offset-from-the-object-at-desc-is-out-of-the-bounds-of-referenced-subobject-qw2-with-type-long-long-unsigned-int-at-offset
|-- x86_64-randconfig-m001-20210412
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
`-- x86_64-randconfig-s022-20210412
    `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset

elapsed time: 720m

configs tested: 97
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
powerpc                      pcm030_defconfig
arm                         mv78xx0_defconfig
arm                          exynos_defconfig
arm                       multi_v4t_defconfig
mips                           ip22_defconfig
arm                  colibri_pxa300_defconfig
powerpc                    ge_imp3a_defconfig
sh                             espt_defconfig
arm                        trizeps4_defconfig
powerpc                     powernv_defconfig
sh                          r7785rp_defconfig
powerpc                      arches_defconfig
powerpc                      makalu_defconfig
arm                            zeus_defconfig
sh                           se7750_defconfig
arm                       omap2plus_defconfig
sh                          rsk7203_defconfig
sh                          urquell_defconfig
arm                          ixp4xx_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210412
i386                 randconfig-a001-20210412
i386                 randconfig-a006-20210412
i386                 randconfig-a005-20210412
i386                 randconfig-a004-20210412
i386                 randconfig-a002-20210412
x86_64               randconfig-a014-20210412
x86_64               randconfig-a015-20210412
x86_64               randconfig-a011-20210412
x86_64               randconfig-a013-20210412
x86_64               randconfig-a012-20210412
x86_64               randconfig-a016-20210412
i386                 randconfig-a015-20210412
i386                 randconfig-a014-20210412
i386                 randconfig-a013-20210412
i386                 randconfig-a012-20210412
i386                 randconfig-a016-20210412
i386                 randconfig-a011-20210412
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
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210412
x86_64               randconfig-a002-20210412
x86_64               randconfig-a001-20210412
x86_64               randconfig-a005-20210412
x86_64               randconfig-a006-20210412
x86_64               randconfig-a004-20210412

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
