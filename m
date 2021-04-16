Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8445A361C93
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbhDPIzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:55:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:63836 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240562AbhDPIzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:55:54 -0400
IronPort-SDR: T3AjV9mmB4rzmUjk68eUTDDhdfLyILcH/FzsLUsJPzbkmXqqWE5cr4t3l1JZ5ekDlGJE2ucplp
 UfGiWzl84G5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194570226"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="194570226"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 01:55:30 -0700
IronPort-SDR: 1/Vrjxs/9+T2MNuV4uJvj3nIE72XgvhvFuWWNiGLyBO0X33+1J/4SFdxQU+69b2E+ZVUhMZRFO
 rkqE0uMP9TkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461908717"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Apr 2021 01:55:28 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXKG7-000012-RR; Fri, 16 Apr 2021 08:55:27 +0000
Date:   Fri, 16 Apr 2021 16:54:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING 8bd0f043b3e94069930bec5cb3fbb5c857748c80
Message-ID: <607950d0.wVonYUbwFvEE1zt+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: 8bd0f043b3e94069930bec5cb3fbb5c857748c80  HID: cp2112: Fix out-of-bounds warning

Warning reports:

https://lore.kernel.org/lkml/202104160817.a5FOA0xa-lkp@intel.com
https://lore.kernel.org/lkml/202104160847.Bc8WPzVe-lkp@intel.com

Warning in current branch:

arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [12, 16] from the object at 'com' is out of the bounds of referenced subobject 'config' with type 'unsigned char' at offset 10 [-Warray-bounds]
arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]
arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
net/sctp/sm_make_chunk.c:3150:4: warning: 'memcpy' offset [17, 28] from the object at 'addr' is out of the bounds of referenced subobject 'v4' with type 'struct sockaddr_in' at offset 0 [-Warray-bounds]

possible Warning in current branch:

arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [12, 16] from the object at 'com' is out of the bounds of referenced subobject 'config' with type 'unsigned char' at offset 10 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [17, 38] from the object at 'txdesc' is out of the bounds of referenced subobject 'frame_control' with type 'short unsigned int' at offset 14 [-Warray-bounds]
drivers/gpu/drm/mga/mga_ioc32.c:70:2: warning: 'memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]

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
|-- alpha-randconfig-r013-20210415
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- i386-randconfig-a002-20210415
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- i386-randconfig-a012-20210415
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|-- ia64-allmodconfig
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   `-- net-sctp-sm_make_chunk.c:warning:memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- ia64-allyesconfig
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- ia64-randconfig-s031-20210415
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- nds32-allmodconfig
|   `-- net-sctp-sm_make_chunk.c:warning:memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- nds32-allyesconfig
|   `-- net-sctp-sm_make_chunk.c:warning:memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- parisc-allyesconfig
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   `-- net-sctp-sm_make_chunk.c:warning:memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- parisc-randconfig-r013-20210415
|   `-- net-sctp-sm_make_chunk.c:warning:memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- parisc-randconfig-r016-20210415
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   `-- net-sctp-sm_make_chunk.c:warning:memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- parisc-randconfig-r023-20210415
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- powerpc-allmodconfig
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
|-- riscv-randconfig-r003-20210415
|   `-- net-sctp-sm_make_chunk.c:warning:memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- s390-defconfig
|   `-- net-sctp-sm_make_chunk.c:warning:memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- x86_64-randconfig-a005-20210415
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
`-- x86_64-randconfig-c002-20210415
    |-- drivers-gpu-drm-mga-mga_ioc32.c:warning:memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
    `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset

elapsed time: 722m

configs tested: 93
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
powerpc                 mpc8272_ads_defconfig
arm                      tct_hammer_defconfig
mips                           jazz_defconfig
arm                   milbeaut_m10v_defconfig
arm                          pxa3xx_defconfig
powerpc                       holly_defconfig
um                               alldefconfig
sh                        apsh4ad0a_defconfig
arm                        mvebu_v7_defconfig
arm                           h3600_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
powerpc                      ppc64e_defconfig
arc                           tb10x_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210415
x86_64               randconfig-a002-20210415
x86_64               randconfig-a005-20210415
x86_64               randconfig-a001-20210415
x86_64               randconfig-a006-20210415
x86_64               randconfig-a004-20210415
i386                 randconfig-a003-20210415
i386                 randconfig-a006-20210415
i386                 randconfig-a001-20210415
i386                 randconfig-a005-20210415
i386                 randconfig-a004-20210415
i386                 randconfig-a002-20210415
i386                 randconfig-a015-20210415
i386                 randconfig-a014-20210415
i386                 randconfig-a013-20210415
i386                 randconfig-a012-20210415
i386                 randconfig-a016-20210415
i386                 randconfig-a011-20210415
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
x86_64               randconfig-a014-20210415
x86_64               randconfig-a015-20210415
x86_64               randconfig-a011-20210415
x86_64               randconfig-a013-20210415
x86_64               randconfig-a012-20210415
x86_64               randconfig-a016-20210415

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
