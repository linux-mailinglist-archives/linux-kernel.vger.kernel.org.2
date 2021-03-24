Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91E53477F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhCXMM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:12:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:57820 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhCXMMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:12:45 -0400
IronPort-SDR: Fav/IRH1i+9CFtOxGub1HlYIzWBNP5tryRpS3q4RHKzsNU/10E3FNbyLtUToND4u+6q5Uk2Lii
 KQ74ANKA+uhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="275803553"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="275803553"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 05:12:43 -0700
IronPort-SDR: DBBZgWZPjBD/4VAZEu5YhVxlUSCg/WDIChKalsXQxTY3KKJ3FWWDvZJZP7hx/QNSrNJatDLkGK
 Fnb4ScGR9LNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="452569304"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2021 05:12:38 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lP2NJ-0001DQ-Hk; Wed, 24 Mar 2021 12:12:37 +0000
Date:   Wed, 24 Mar 2021 20:11:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING 5d3f70f94229a766343a736bcfd026f8126ccb2f
Message-ID: <605b2c82.zNElZc/ctFOkBGz4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: 5d3f70f94229a766343a736bcfd026f8126ccb2f  UAPI: nfsfh.h: Replace one-element array with flexible-array member

possible Warning in current branch:

arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [29, 48] from the object at 'treq' is out of the bounds of referenced subobject 'req_header' with type 'struct utp_upiu_header' at offset 16 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [61, 80] from the object at 'treq' is out of the bounds of referenced subobject 'rsp_header' with type 'struct utp_upiu_header' at offset 48 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [13, 256] from the object at 'cmd' is out of the bounds of referenced subobject 'payload' with type 'u8[]' at offset 12 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [18, 23] from the object at 'sig' is out of the bounds of referenced subobject 'daddr' with type 'u8[6]' {aka 'unsigned char[6]'} at offset 11 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [27, 42] from the object at 'buf' is out of the bounds of referenced subobject 'key' with type 'u8[16]' {aka 'unsigned char[16]'} at offset 10 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [29, 39] from the object at 'req' is out of the bounds of referenced subobject 'unused_0' with type 'unsigned char' at offset 27 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [39, 108] from the object at 'sig' is out of the bounds of referenced subobject 'beacon_period' with type 'short unsigned int' at offset 36 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [5, 15] from the object at 'cos2bw' is out of the bounds of referenced subobject 'queue_id' with type 'unsigned char' at offset 3 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [6, 26] from the object at 'param_element' is out of the bounds of referenced subobject 'qui' with type 'u8[3]' {aka 'unsigned char[3]'} at offset 2 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [6, 9] from the object at 'qos_info_element' is out of the bounds of referenced subobject 'qui' with type 'u8[3]' {aka 'unsigned char[3]'} at offset 2 [-Warray-bounds]
drivers/gpu/drm/mga/mga_ioc32.c:70:2: warning: 'memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
drivers/iommu/intel/svm.c:1202:4: warning: 'memcpy' offset [25, 32] from the object at 'desc' is out of the bounds of referenced subobject 'qw2' with type 'long long unsigned int' at offset 16 [-Warray-bounds]
fs/hfsplus/xattr.c:300:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
fs/hfsplus/xattr.c:313:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
include/linux/bitmap.h:249:2: warning: 'memcpy' offset [17, 24] from the object at 'settings' is out of the bounds of referenced subobject 'advertising' with type 'long long unsigned int' at offset 8 [-Warray-bounds]
include/linux/bitmap.h:249:2: warning: 'memcpy' offset [9, 16] from the object at 'settings' is out of the bounds of referenced subobject 'supported' with type 'long long unsigned int' at offset 0 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [21, 32] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [29, 48] from the object at 'treq' is out of the bounds of referenced subobject 'req_header' with type 'struct utp_upiu_header' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [61, 80] from the object at 'treq' is out of the bounds of referenced subobject 'rsp_header' with type 'struct utp_upiu_header' at offset 48 [-Warray-bounds]
include/linux/fortify-string.h:22:29: warning: '__builtin_memset' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-randconfig-r005-20210323
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- i386-allmodconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-randconfig-a003-20210324
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-buf-is-out-of-the-bounds-of-referenced-subobject-key-with-type-u8-aka-unsigned-char-at-offset
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-sig-is-out-of-the-bounds-of-referenced-subobject-beacon_period-with-type-short-unsigned-int-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-sig-is-out-of-the-bounds-of-referenced-subobject-daddr-with-type-u8-aka-unsigned-char-at-offset
|-- i386-randconfig-a004-20210324
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-cos2bw-is-out-of-the-bounds-of-referenced-subobject-queue_id-with-type-unsigned-char-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-req-is-out-of-the-bounds-of-referenced-subobject-unused_0-with-type-unsigned-char-at-offset
|-- i386-randconfig-c024-20210323
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- i386-randconfig-s002-20210323
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-payload-with-type-u8-at-offset
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
|-- mips-allmodconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- mips-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- nds32-allyesconfig
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- parisc-randconfig-r012-20210324
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- powerpc-allmodconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
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
|-- x86_64-randconfig-a001-20210323
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- x86_64-randconfig-c002-20210323
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- x86_64-randconfig-c022-20210323
|   |-- drivers-iommu-intel-svm.c:warning:memcpy-offset-from-the-object-at-desc-is-out-of-the-bounds-of-referenced-subobject-qw2-with-type-long-long-unsigned-int-at-offset
|   |-- include-linux-bitmap.h:warning:memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-advertising-with-type-long-long-unsigned-int-at-offset
|   `-- include-linux-bitmap.h:warning:memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-supported-with-type-long-long-unsigned-int-at-offset
`-- x86_64-randconfig-m001-20210323
    |-- drivers-gpu-drm-mga-mga_ioc32.c:warning:memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
    |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
    |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
    `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset

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
riscv                            allyesconfig
powerpc                     redwood_defconfig
mips                            ar7_defconfig
m68k                            mac_defconfig
arm                          imote2_defconfig
powerpc                    socrates_defconfig
arm                       imx_v6_v7_defconfig
arm                        neponset_defconfig
sh                            hp6xx_defconfig
arm                         orion5x_defconfig
arm                         lpc18xx_defconfig
sh                ecovec24-romimage_defconfig
mips                           rs90_defconfig
mips                       capcella_defconfig
sh                        sh7785lcr_defconfig
sh                           se7721_defconfig
arm                  colibri_pxa300_defconfig
mips                           jazz_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7619_defconfig
m68k                        stmark2_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210323
x86_64               randconfig-a003-20210323
x86_64               randconfig-a006-20210323
x86_64               randconfig-a001-20210323
x86_64               randconfig-a004-20210323
x86_64               randconfig-a005-20210323
i386                 randconfig-a004-20210324
i386                 randconfig-a003-20210324
i386                 randconfig-a001-20210324
i386                 randconfig-a002-20210324
i386                 randconfig-a006-20210324
i386                 randconfig-a005-20210324
i386                 randconfig-a014-20210323
i386                 randconfig-a011-20210323
i386                 randconfig-a015-20210323
i386                 randconfig-a016-20210323
i386                 randconfig-a012-20210323
i386                 randconfig-a013-20210323
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
x86_64               randconfig-a012-20210323
x86_64               randconfig-a015-20210323
x86_64               randconfig-a013-20210323
x86_64               randconfig-a014-20210323
x86_64               randconfig-a011-20210323
x86_64               randconfig-a016-20210323

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
