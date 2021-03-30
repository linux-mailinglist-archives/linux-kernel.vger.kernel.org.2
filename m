Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A535234E79B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhC3Mj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:39:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:47096 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhC3Mjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:39:45 -0400
IronPort-SDR: ZPVFi+iVfWoldhHKNCJet9tIG6jiDz0pI4mgKs3pA7mMxqAXlgQlBEd88efIMrYYtUaoxO+a0A
 uKpPKHKF3QUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="189512601"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="189512601"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 05:39:43 -0700
IronPort-SDR: fcJnKBUbu8Z7EdhLmwVmdw1bwSBXxIAEIQ8ThhZCXODIKqMrrCfDaCFTn+Xb4Buq6IuwobaLQD
 0lhy0dAbB1FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="418154164"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2021 05:39:42 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRDen-0005HU-BH; Tue, 30 Mar 2021 12:39:41 +0000
Date:   Tue, 30 Mar 2021 20:39:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING bca69d7711e6be3ebe0cd8e4551b947fd138045d
Message-ID: <60631bec.4JlHSDFWvS7NqwFE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: bca69d7711e6be3ebe0cd8e4551b947fd138045d  hfsplus/hfsplus_raw.h: Fix out-of-bounds warnings in __hfsplus_setxattr

possible Warning in current branch:

arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [29, 48] from the object at 'treq' is out of the bounds of referenced subobject 'req_header' with type 'struct utp_upiu_header' at offset 16 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [61, 80] from the object at 'treq' is out of the bounds of referenced subobject 'rsp_header' with type 'struct utp_upiu_header' at offset 48 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [17, 38] from the object at 'txdesc' is out of the bounds of referenced subobject 'frame_control' with type 'short unsigned int' at offset 14 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [27, 42] from the object at 'buf' is out of the bounds of referenced subobject 'key' with type 'u8[16]' {aka 'unsigned char[16]'} at offset 10 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
drivers/iommu/intel/svm.c:1202:4: warning: 'memcpy' offset [25, 32] from the object at 'desc' is out of the bounds of referenced subobject 'qw2' with type 'long long unsigned int' at offset 16 [-Warray-bounds]
fs/hfsplus/xattr.c:296:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
fs/hfsplus/xattr.c:309:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
include/linux/bitmap.h:249:2: warning: 'memcpy' offset [17, 24] from the object at 'settings' is out of the bounds of referenced subobject 'advertising' with type 'long long unsigned int' at offset 8 [-Warray-bounds]
include/linux/bitmap.h:249:2: warning: 'memcpy' offset [9, 16] from the object at 'settings' is out of the bounds of referenced subobject 'supported' with type 'long long unsigned int' at offset 0 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [25, 32] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [29, 48] from the object at 'treq' is out of the bounds of referenced subobject 'req_header' with type 'struct utp_upiu_header' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [61, 80] from the object at 'treq' is out of the bounds of referenced subobject 'rsp_header' with type 'struct utp_upiu_header' at offset 48 [-Warray-bounds]
include/linux/fortify-string.h:22:29: warning: '__builtin_memset' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allmodconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-randconfig-a001-20210329
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-randconfig-a011-20210329
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-buf-is-out-of-the-bounds-of-referenced-subobject-key-with-type-u8-aka-unsigned-char-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|-- i386-randconfig-s002-20210329
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
|-- m68k-allmodconfig
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|-- m68k-allyesconfig
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|-- microblaze-randconfig-c004-20210329
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- mips-allmodconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- mips-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- nds32-allyesconfig
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- openrisc-randconfig-r021-20210329
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- parisc-allyesconfig
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- powerpc-allmodconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- powerpc-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- riscv-allmodconfig
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- riscv-allyesconfig
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- riscv-randconfig-r003-20210329
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- x86_64-randconfig-a001-20210329
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|   |-- include-linux-bitmap.h:warning:memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-advertising-with-type-long-long-unsigned-int-at-offset
|   `-- include-linux-bitmap.h:warning:memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-supported-with-type-long-long-unsigned-int-at-offset
|-- x86_64-randconfig-a004-20210329
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- x86_64-randconfig-a005-20210329
|   |-- drivers-iommu-intel-svm.c:warning:memcpy-offset-from-the-object-at-desc-is-out-of-the-bounds-of-referenced-subobject-qw2-with-type-long-long-unsigned-int-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- x86_64-randconfig-c002-20210329
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- x86_64-rhel-8.3
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
`-- x86_64-rhel-8.3-kbuiltin
    |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
    `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset

elapsed time: 911m

configs tested: 93
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
sh                 kfr2r09-romimage_defconfig
mips                        maltaup_defconfig
arc                     nsimosci_hs_defconfig
mips                   sb1250_swarm_defconfig
arc                            hsdk_defconfig
i386                                defconfig
sh                           se7619_defconfig
mips                            e55_defconfig
powerpc                  mpc866_ads_defconfig
sh                           se7206_defconfig
sparc                               defconfig
sh                          r7785rp_defconfig
mips                         rt305x_defconfig
sh                           se7712_defconfig
sparc64                          alldefconfig
riscv             nommu_k210_sdcard_defconfig
sh                        sh7785lcr_defconfig
sh                         ecovec24_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210329
x86_64               randconfig-a003-20210329
x86_64               randconfig-a006-20210329
x86_64               randconfig-a001-20210329
x86_64               randconfig-a005-20210329
x86_64               randconfig-a004-20210329
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a001-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
i386                 randconfig-a014-20210329
i386                 randconfig-a011-20210329
i386                 randconfig-a015-20210329
i386                 randconfig-a016-20210329
i386                 randconfig-a013-20210329
i386                 randconfig-a012-20210329
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
