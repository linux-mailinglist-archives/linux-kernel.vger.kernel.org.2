Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9519365A40
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhDTNfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:35:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:50262 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232465AbhDTNfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:35:42 -0400
IronPort-SDR: bILwQ565G30IsTYKyhGk26y3IPyarqPjG69YdfqYjhFKbiqI69pvTGvENBpZ9fSRkjVG8VIkXU
 QaVXXcH955TQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="259461976"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="259461976"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 06:35:08 -0700
IronPort-SDR: lqYtGxNfcxD25tzGygmG1bheEOAeRq+jpj9laQT3kb5GtMzvQi6AmT/7DVGR8tbTdtyxpRtDlz
 wsgCeNPeFcWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="534489584"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2021 06:35:06 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYqWw-0002V7-6E; Tue, 20 Apr 2021 13:35:06 +0000
Date:   Tue, 20 Apr 2021 21:34:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING 2dad8399b273b5a6cc50406b0d621f93c4bc61cc
Message-ID: <607ed863.g3HrLRZSPT8iAC6m%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: 2dad8399b273b5a6cc50406b0d621f93c4bc61cc  media: ngene: Fix out-of-bounds bug in ngene_command_config_free_buf()

Warning reports:

https://lore.kernel.org/lkml/202104160817.a5FOA0xa-lkp@intel.com

Warning in current branch:

arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]
arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]

possible Warning in current branch:

drivers/hid/hid-cp2112.c:333:2: warning: 'memcpy' offset [3, 64] from the object at 'report' is out of the bounds of referenced subobject 'report' with type 'unsigned char' at offset 1 [-Warray-bounds]
drivers/ide/ide-acpi.c:332:3: warning: 'memcpy' offset [3, 8] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
drivers/media/platform/omap3isp/ispstat.c:524:2: warning: 'memcpy' offset [21, 32] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]
drivers/media/platform/omap3isp/ispstat.c:524:2: warning: 'memcpy' offset [25, 32] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]
include/linux/skbuff.h:3723:2: warning: 'memcpy' offset [17, 38] from the object at 'txdesc' is out of the bounds of referenced subobject 'frame_control' with type 'short unsigned int' at offset 14 [-Warray-bounds]
net/wireless/wext-spy.c:178:2: warning: 'memcpy' offset [25, 28] from the object at 'threshold' is out of the bounds of referenced subobject 'low' with type 'struct iw_quality' at offset 20 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- alpha-defconfig
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- csky-randconfig-r031-20210420
|   |-- drivers-media-platform-omap3isp-ispstat.c:warning:memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|   |-- include-linux-skbuff.h:warning:memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|   `-- net-wireless-wext-spy.c:warning:memcpy-offset-from-the-object-at-threshold-is-out-of-the-bounds-of-referenced-subobject-low-with-type-struct-iw_quality-at-offset
|-- ia64-allmodconfig
|   |-- drivers-ide-ide-acpi.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-media-platform-omap3isp-ispstat.c:warning:memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|   |-- include-linux-skbuff.h:warning:memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|   `-- net-wireless-wext-spy.c:warning:memcpy-offset-from-the-object-at-threshold-is-out-of-the-bounds-of-referenced-subobject-low-with-type-struct-iw_quality-at-offset
|-- ia64-randconfig-r032-20210420
|   `-- drivers-ide-ide-acpi.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- nds32-allyesconfig
|   |-- drivers-media-platform-omap3isp-ispstat.c:warning:memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|   |-- include-linux-skbuff.h:warning:memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|   `-- net-wireless-wext-spy.c:warning:memcpy-offset-from-the-object-at-threshold-is-out-of-the-bounds-of-referenced-subobject-low-with-type-struct-iw_quality-at-offset
|-- parisc-randconfig-r011-20210419
|   `-- drivers-hid-hid-cp2112.c:warning:memcpy-offset-from-the-object-at-report-is-out-of-the-bounds-of-referenced-subobject-report-with-type-unsigned-char-at-offset
`-- powerpc-allmodconfig
    `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset

elapsed time: 724m

configs tested: 97
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
powerpc                  mpc866_ads_defconfig
sh                          r7780mp_defconfig
powerpc                       ebony_defconfig
powerpc                     rainier_defconfig
sh                           se7750_defconfig
sh                         apsh4a3a_defconfig
sparc                       sparc32_defconfig
um                               alldefconfig
m68k                        m5272c3_defconfig
arm                         hackkit_defconfig
powerpc                      ep88xc_defconfig
powerpc                     ep8248e_defconfig
xtensa                       common_defconfig
h8300                               defconfig
nios2                         3c120_defconfig
sh                          landisk_defconfig
arm                          pcm027_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          imote2_defconfig
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
x86_64               randconfig-a003-20210419
x86_64               randconfig-a001-20210419
x86_64               randconfig-a005-20210419
x86_64               randconfig-a002-20210419
x86_64               randconfig-a006-20210419
x86_64               randconfig-a004-20210419
i386                 randconfig-a003-20210419
i386                 randconfig-a001-20210419
i386                 randconfig-a006-20210419
i386                 randconfig-a005-20210419
i386                 randconfig-a004-20210419
i386                 randconfig-a002-20210419
i386                 randconfig-a015-20210419
i386                 randconfig-a013-20210419
i386                 randconfig-a014-20210419
i386                 randconfig-a016-20210419
i386                 randconfig-a012-20210419
i386                 randconfig-a011-20210419
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
x86_64               randconfig-a014-20210419
x86_64               randconfig-a015-20210419
x86_64               randconfig-a013-20210419
x86_64               randconfig-a011-20210419
x86_64               randconfig-a012-20210419
x86_64               randconfig-a016-20210419

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
