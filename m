Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45C3491A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhCYMM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:12:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:41292 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhCYMMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:12:09 -0400
IronPort-SDR: RXUxpukH+b4Z456wpFHYNOkV2k4rLWiW31x/BTRDNSqwZCFM0wXzmKACdLuqXB1Iz07Cpo4KdP
 yVIe6Wl3v3dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="276040306"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="276040306"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 05:12:07 -0700
IronPort-SDR: ZxwVCG1uoHms8soWKTf6ok2WU9VESkuxzC1DuT5XRH99cMHW/7NyZWnwAUzPLaf3GcNxlcVzg6
 VTc3N5kfvoTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="409343554"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2021 05:12:06 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPOqL-0001vd-6m; Thu, 25 Mar 2021 12:12:05 +0000
Date:   Thu, 25 Mar 2021 20:11:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING 43ff065895846889c64db05e97e9ba3977561790
Message-ID: <605c7df2.YolWKwU4ccu0AuDU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: 43ff065895846889c64db05e97e9ba3977561790  SCSI: fusion : mpi_ioc.h: Replace one-element array with flexible-array member

possible Warning in current branch:

arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [29, 48] from the object at 'treq' is out of the bounds of referenced subobject 'req_header' with type 'struct utp_upiu_header' at offset 16 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [3, 64] from the object at 'report' is out of the bounds of referenced subobject 'report' with type 'unsigned char' at offset 1 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [61, 80] from the object at 'treq' is out of the bounds of referenced subobject 'rsp_header' with type 'struct utp_upiu_header' at offset 48 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [13, 256] from the object at 'cmd' is out of the bounds of referenced subobject 'payload' with type 'u8[]' at offset 12 [-Warray-bounds]
drivers/gpu/drm/mga/mga_ioc32.c:70:2: warning: 'memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
fs/hfsplus/xattr.c:300:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
fs/hfsplus/xattr.c:313:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
include/linux/bitmap.h:249:2: warning: 'memcpy' offset [17, 24] from the object at 'settings' is out of the bounds of referenced subobject 'advertising' with type 'long long unsigned int' at offset 8 [-Warray-bounds]
include/linux/bitmap.h:249:2: warning: 'memcpy' offset [9, 16] from the object at 'settings' is out of the bounds of referenced subobject 'supported' with type 'long long unsigned int' at offset 0 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [21, 32] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]
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
|-- i386-randconfig-a003-20210325
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-randconfig-a015-20210325
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-payload-with-type-u8-at-offset
|-- i386-randconfig-c003-20210325
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-randconfig-c004-20210325
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
|-- m68k-randconfig-m031-20210325
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-report-is-out-of-the-bounds-of-referenced-subobject-report-with-type-unsigned-char-at-offset
|-- mips-allmodconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- mips-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- mips-randconfig-r013-20210325
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- nds32-allyesconfig
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- parisc-allyesconfig
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- powerpc-allmodconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- powerpc-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- powerpc64-randconfig-r036-20210325
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- riscv-allmodconfig
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- riscv-allyesconfig
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- riscv-randconfig-c004-20210325
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- x86_64-randconfig-a002-20210325
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- include-linux-bitmap.h:warning:memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-advertising-with-type-long-long-unsigned-int-at-offset
|   `-- include-linux-bitmap.h:warning:memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-supported-with-type-long-long-unsigned-int-at-offset
|-- x86_64-randconfig-a003-20210325
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- x86_64-randconfig-a006-20210325
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- x86_64-randconfig-s022-20210325
|   |-- drivers-gpu-drm-mga-mga_ioc32.c:warning:memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- x86_64-rhel-8.3
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- x86_64-rhel-8.3-kbuiltin
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
`-- x86_64-rhel-8.3-kselftests
    |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
    `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset

elapsed time: 720m

configs tested: 96
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
m68k                       m5275evb_defconfig
arm                         mv78xx0_defconfig
xtensa                              defconfig
powerpc                     mpc5200_defconfig
powerpc                 linkstation_defconfig
mips                          rb532_defconfig
xtensa                          iss_defconfig
m68k                          hp300_defconfig
mips                     cu1000-neo_defconfig
m68k                         amcore_defconfig
powerpc                  storcenter_defconfig
arm                           h3600_defconfig
powerpc                        fsp2_defconfig
arm                         lubbock_defconfig
mips                          ath25_defconfig
arc                          axs103_defconfig
mips                        bcm47xx_defconfig
arm                        neponset_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc834x_itx_defconfig
arc                         haps_hs_defconfig
powerpc                     rainier_defconfig
arm                        mvebu_v7_defconfig
arm                         assabet_defconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
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
i386                 randconfig-a003-20210325
i386                 randconfig-a004-20210325
i386                 randconfig-a001-20210325
i386                 randconfig-a002-20210325
i386                 randconfig-a006-20210325
i386                 randconfig-a005-20210325
i386                 randconfig-a014-20210325
i386                 randconfig-a011-20210325
i386                 randconfig-a015-20210325
i386                 randconfig-a016-20210325
i386                 randconfig-a013-20210325
i386                 randconfig-a012-20210325
x86_64               randconfig-a002-20210325
x86_64               randconfig-a003-20210325
x86_64               randconfig-a006-20210325
x86_64               randconfig-a001-20210325
x86_64               randconfig-a005-20210325
x86_64               randconfig-a004-20210325
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin

clang tested configs:
x86_64               randconfig-a012-20210325
x86_64               randconfig-a015-20210325

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
