Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374A0362C7E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 02:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhDQAxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 20:53:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:43385 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhDQAxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:53:32 -0400
IronPort-SDR: NxOWjHwbihbEs1QPNohWs7Wrrj+yk6JniUUvxBB0co3Umr7PqOED08COB/0fZbfg4zaaqAc+/2
 OhCodyaGiszw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="175243141"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="175243141"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 17:53:06 -0700
IronPort-SDR: /4DHOglhUsSTmggLzj2ToB5JMaFPTlQSh3r8wlDe6IkgJz/f0MUFZyajAnmyUSpvl/XMT6JdSC
 QgUaV0RQdM+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="522865098"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2021 17:53:05 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXZCq-0000bd-BS; Sat, 17 Apr 2021 00:53:04 +0000
Date:   Sat, 17 Apr 2021 08:52:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING f26f5c4b90b01bfc415b38f9246b0a36d63b9aaa
Message-ID: <607a3159.lkAOQWABMw/UZrSl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: f26f5c4b90b01bfc415b38f9246b0a36d63b9aaa  sctp: Fix out-of-bounds warning in sctp_process_asconf_param()

Warning reports:

https://lore.kernel.org/lkml/202104160817.a5FOA0xa-lkp@intel.com

Warning in current branch:

arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [12, 16] from the object at 'com' is out of the bounds of referenced subobject 'config' with type 'unsigned char' at offset 10 [-Warray-bounds]
arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]
arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]

possible Warning in current branch:

arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [12, 16] from the object at 'com' is out of the bounds of referenced subobject 'config' with type 'unsigned char' at offset 10 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [17, 38] from the object at 'txdesc' is out of the bounds of referenced subobject 'frame_control' with type 'short unsigned int' at offset 14 [-Warray-bounds]
include/linux/bitmap.h:249:2: warning: 'memcpy' offset [17, 24] from the object at 'settings' is out of the bounds of referenced subobject 'advertising' with type 'long long unsigned int' at offset 8 [-Warray-bounds]
include/linux/bitmap.h:249:2: warning: 'memcpy' offset [9, 16] from the object at 'settings' is out of the bounds of referenced subobject 'supported' with type 'long long unsigned int' at offset 0 [-Warray-bounds]
include/linux/unaligned/le_byteshift.h:14:17: warning: array subscript 1 is outside array bounds of 'unsigned char[1]' [-Warray-bounds]
include/linux/unaligned/le_byteshift.h:14:29: warning: intermediate array offset 2 is outside array bounds of 'unsigned char' [-Warray-bounds]

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
|-- alpha-randconfig-r013-20210416
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- i386-randconfig-a002-20210416
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- i386-randconfig-a003-20210416
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- i386-randconfig-a016-20210416
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|-- mips-randconfig-c003-20210416
|   |-- include-linux-unaligned-le_byteshift.h:warning:array-subscript-is-outside-array-bounds-of-unsigned-char
|   `-- include-linux-unaligned-le_byteshift.h:warning:intermediate-array-offset-is-outside-array-bounds-of-unsigned-char
`-- x86_64-randconfig-a011-20210416
    |-- include-linux-bitmap.h:warning:memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-advertising-with-type-long-long-unsigned-int-at-offset
    `-- include-linux-bitmap.h:warning:memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-supported-with-type-long-long-unsigned-int-at-offset

elapsed time: 725m

configs tested: 113
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
mips                       capcella_defconfig
sh                        edosk7705_defconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        magician_defconfig
xtensa                       common_defconfig
sh                     magicpanelr2_defconfig
powerpc                         ps3_defconfig
arm                          pcm027_defconfig
sparc64                             defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                           xway_defconfig
arc                        nsim_700_defconfig
arm                           h5000_defconfig
arm                         orion5x_defconfig
sh                           se7751_defconfig
mips                      bmips_stb_defconfig
mips                           ci20_defconfig
arm                        multi_v7_defconfig
arm                      jornada720_defconfig
sh                           se7750_defconfig
sh                             sh03_defconfig
m68k                        mvme16x_defconfig
parisc                generic-64bit_defconfig
mips                      loongson3_defconfig
arm                            qcom_defconfig
powerpc                      mgcoge_defconfig
powerpc                    klondike_defconfig
mips                          rm200_defconfig
sh                         microdev_defconfig
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
x86_64               randconfig-a003-20210416
x86_64               randconfig-a002-20210416
x86_64               randconfig-a005-20210416
x86_64               randconfig-a001-20210416
x86_64               randconfig-a006-20210416
x86_64               randconfig-a004-20210416

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
