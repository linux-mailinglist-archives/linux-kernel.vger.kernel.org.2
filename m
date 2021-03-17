Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A4133FA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhCQVVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:21:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:18725 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231744AbhCQVVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:21:21 -0400
IronPort-SDR: 8uRkeTcQlAvLM6/5RZhSHT4wycFgV0wCh+dojH2mYpksPtfYjvNk0zh0yElrCfzjgkRAtcGyX1
 0d/90EF4lCdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="169464401"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="169464401"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 14:21:21 -0700
IronPort-SDR: nT2EkEM35FlYjo5/4OSyzVF66tLCzQDg0zr9TXgiH2RVqG+1lj+FNQmEiHLPwmQtsaRzYrjRXK
 spjyHi4f3NRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="602394894"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Mar 2021 14:21:19 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMdbT-0000rj-8V; Wed, 17 Mar 2021 21:21:19 +0000
Date:   Thu, 18 Mar 2021 05:20:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING 8217fd584a04958b56dd9c85e0d20ee936d9ccc0
Message-ID: <605272a4.ArqgYQsBa0+fHZ5H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: 8217fd584a04958b56dd9c85e0d20ee936d9ccc0  ixgbe: Fix out-of-bounds warning in ixgbe_host_interface_command()

possible Warning in current branch:

arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [29, 48] from the object at 'treq' is out of the bounds of referenced subobject 'req_header' with type 'struct utp_upiu_header' at offset 16 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [61, 80] from the object at 'treq' is out of the bounds of referenced subobject 'rsp_header' with type 'struct utp_upiu_header' at offset 48 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [21, 32] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]
drivers/gpu/drm/mga/mga_ioc32.c:70:2: warning: 'memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
fs/hfsplus/xattr.c:300:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
fs/hfsplus/xattr.c:313:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [29, 48] from the object at 'treq' is out of the bounds of referenced subobject 'req_header' with type 'struct utp_upiu_header' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [61, 80] from the object at 'treq' is out of the bounds of referenced subobject 'rsp_header' with type 'struct utp_upiu_header' at offset 48 [-Warray-bounds]
include/linux/fortify-string.h:22:29: warning: '__builtin_memset' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-randconfig-s032-20210317
|   `-- drivers-gpu-drm-mga-mga_ioc32.c:warning:memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
|-- i386-allmodconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-randconfig-a002-20210317
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-randconfig-a011-20210317
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|-- i386-randconfig-a013-20210317
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-randconfig-a014-20210317
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|-- i386-randconfig-s002-20210317
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- ia64-allmodconfig
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- ia64-allyesconfig
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- m68k-randconfig-r021-20210317
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|-- mips-allmodconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- mips-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- mips-randconfig-r013-20210317
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- nds32-allyesconfig
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- nds32-randconfig-r036-20210317
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- parisc-allyesconfig
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- parisc-randconfig-r012-20210317
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- powerpc-allmodconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- powerpc-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- riscv-allmodconfig
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- riscv-allyesconfig
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- x86_64-randconfig-a001-20210317
|   |-- drivers-gpu-drm-mga-mga_ioc32.c:warning:memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- x86_64-randconfig-a002-20210317
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- x86_64-rhel-8.3
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
`-- x86_64-rhel-8.3-kbuiltin
    |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
    `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset

elapsed time: 726m

configs tested: 91
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
powerpc                    socrates_defconfig
arc                         haps_hs_defconfig
arm                       spear13xx_defconfig
powerpc                     mpc512x_defconfig
sh                          sdk7786_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc836x_mds_defconfig
arm                        clps711x_defconfig
powerpc                      arches_defconfig
sparc                       sparc32_defconfig
powerpc                     stx_gp3_defconfig
sh                               alldefconfig
sh                           se7724_defconfig
powerpc                  storcenter_defconfig
arm                   milbeaut_m10v_defconfig
mips                          ath79_defconfig
s390                                defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210317
x86_64               randconfig-a001-20210317
x86_64               randconfig-a005-20210317
x86_64               randconfig-a004-20210317
x86_64               randconfig-a003-20210317
x86_64               randconfig-a002-20210317
i386                 randconfig-a001-20210317
i386                 randconfig-a005-20210317
i386                 randconfig-a002-20210317
i386                 randconfig-a003-20210317
i386                 randconfig-a004-20210317
i386                 randconfig-a006-20210317
i386                 randconfig-a013-20210317
i386                 randconfig-a016-20210317
i386                 randconfig-a011-20210317
i386                 randconfig-a012-20210317
i386                 randconfig-a015-20210317
i386                 randconfig-a014-20210317
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210317
x86_64               randconfig-a016-20210317
x86_64               randconfig-a013-20210317
x86_64               randconfig-a014-20210317
x86_64               randconfig-a015-20210317
x86_64               randconfig-a012-20210317

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
