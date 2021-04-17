Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B5F363153
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhDQRQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 13:16:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:16181 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236568AbhDQRQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 13:16:35 -0400
IronPort-SDR: isE0bWRr7Gh+zUliJrbt8zWS57oe0kAH3faKeUL4g4nSnaQyg6B3b9AZpA/aow22ycXeB0JxO9
 Tl97W0gjEhmg==
X-IronPort-AV: E=McAfee;i="6200,9189,9957"; a="280497669"
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="280497669"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 10:16:08 -0700
IronPort-SDR: JtS5v31T4thn2RlZ6H19Xc3wT6k5gnWj4b+40x15YA01m/JFO3CH6evIRRUoFn9yFkA3O2Kkxc
 n/ZYuGiiKmcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="453737939"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Apr 2021 10:16:06 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXoY9-0000xI-WA; Sat, 17 Apr 2021 17:16:05 +0000
Date:   Sun, 18 Apr 2021 01:15:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING 5730745615064f614a7bb0d15b5915c785fcb3c5
Message-ID: <607b17cd.58vBQpU6Bp6XClug%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: 5730745615064f614a7bb0d15b5915c785fcb3c5  hostap: Fix out-of-bounds warning in prism2_tx_80211()

Warning reports:

https://lore.kernel.org/lkml/202104160817.a5FOA0xa-lkp@intel.com

Warning in current branch:

arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [12, 16] from the object at 'com' is out of the bounds of referenced subobject 'config' with type 'unsigned char' at offset 10 [-Warray-bounds]
arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]
arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]

possible Warning in current branch:

arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [12, 16] from the object at 'com' is out of the bounds of referenced subobject 'config' with type 'unsigned char' at offset 10 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [17, 38] from the object at 'txdesc' is out of the bounds of referenced subobject 'frame_control' with type 'short unsigned int' at offset 14 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [27, 42] from the object at 'buf' is out of the bounds of referenced subobject 'key' with type 'u8[16]' {aka 'unsigned char[16]'} at offset 10 [-Warray-bounds]
drivers/media/pci/ngene/ngene-core.c:388:2: warning: 'memcpy' offset [12, 16] from the object at 'com' is out of the bounds of referenced subobject 'config' with type 'unsigned char' at offset 10 [-Warray-bounds]
include/linux/bitmap.h:249:2: warning: 'memcpy' offset [17, 24] from the object at 'settings' is out of the bounds of referenced subobject 'advertising' with type 'long long unsigned int' at offset 8 [-Warray-bounds]
include/linux/bitmap.h:249:2: warning: 'memcpy' offset [9, 16] from the object at 'settings' is out of the bounds of referenced subobject 'supported' with type 'long long unsigned int' at offset 0 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- alpha-defconfig
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- alpha-randconfig-s031-20210416
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- i386-randconfig-a002-20210416
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- i386-randconfig-a003-20210416
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- i386-randconfig-a016-20210416
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|-- i386-randconfig-c021-20210417
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-buf-is-out-of-the-bounds-of-referenced-subobject-key-with-type-u8-aka-unsigned-char-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|-- ia64-allmodconfig
|   `-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- x86_64-randconfig-a011-20210416
|   |-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|   |-- include-linux-bitmap.h:warning:memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-advertising-with-type-long-long-unsigned-int-at-offset
|   `-- include-linux-bitmap.h:warning:memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-supported-with-type-long-long-unsigned-int-at-offset
`-- x86_64-randconfig-a016-20210416
    `-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset

elapsed time: 721m

configs tested: 96
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                     davinci_all_defconfig
um                               allmodconfig
powerpc                 mpc832x_rdb_defconfig
sh                          sdk7786_defconfig
m68k                         amcore_defconfig
m68k                       bvme6000_defconfig
powerpc                   motionpro_defconfig
powerpc                     powernv_defconfig
sh                             espt_defconfig
m68k                        mvme147_defconfig
sh                           se7780_defconfig
sh                          lboxre2_defconfig
arm                       imx_v4_v5_defconfig
arm                         socfpga_defconfig
sh                ecovec24-romimage_defconfig
powerpc                          allmodconfig
powerpc                    ge_imp3a_defconfig
powerpc                     taishan_defconfig
arm                          iop32x_defconfig
powerpc                        cell_defconfig
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
powerpc                           allnoconfig
i386                 randconfig-a003-20210416
i386                 randconfig-a006-20210416
i386                 randconfig-a001-20210416
i386                 randconfig-a005-20210416
i386                 randconfig-a004-20210416
i386                 randconfig-a002-20210416
x86_64               randconfig-a014-20210416
x86_64               randconfig-a015-20210416
x86_64               randconfig-a011-20210416
x86_64               randconfig-a013-20210416
x86_64               randconfig-a012-20210416
x86_64               randconfig-a016-20210416
i386                 randconfig-a015-20210416
i386                 randconfig-a014-20210416
i386                 randconfig-a013-20210416
i386                 randconfig-a012-20210416
i386                 randconfig-a016-20210416
i386                 randconfig-a011-20210416
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210416
x86_64               randconfig-a002-20210416
x86_64               randconfig-a005-20210416
x86_64               randconfig-a001-20210416
x86_64               randconfig-a006-20210416
x86_64               randconfig-a004-20210416

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
