Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE1D34EA75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhC3Ocx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:32:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:45868 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhC3Ocs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:32:48 -0400
IronPort-SDR: UnHgjtroj+NstLGmD+1FwfWOZ2zIKoX6+hooc8u3hfH5L60N36wocwSFi6Nks8sO6Q7EUka3aZ
 HBfpgj9BSSMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="171187054"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="171187054"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 07:32:48 -0700
IronPort-SDR: PNz67Silma7ofYwvBuWwqD9pcY/4vA4XpjBAnOatd+c5xs5fKr38IF3ZI/CitZR6VXEMupUTUH
 rSwn+P+U/7Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="445171739"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2021 07:32:46 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRFQD-0005K3-PP; Tue, 30 Mar 2021 14:32:45 +0000
Date:   Tue, 30 Mar 2021 22:32:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/wab/hfsplus] BUILD REGRESSION
 2f8c736b120301c5b6bcbddcfa2cb60182b4bc71
Message-ID: <60633677.55GC2bvqL9T7eIMt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wab/hfsplus
branch HEAD: 2f8c736b120301c5b6bcbddcfa2cb60182b4bc71  hfsplus: Fix out-of-bounds warnings in __hfsplus_setxattr

Error/Warning reports:

https://lore.kernel.org/lkml/202103300814.Gl8ZHqZW-lkp@intel.com

Error/Warning in current branch:

include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct DInfo' at offset 48 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct FInfo' at offset 48 [-Warray-bounds]

possible Error/Warning in current branch:

arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct DInfo' at offset 48 [-Warray-bounds]
arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct FInfo' at offset 48 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct DInfo' at offset 48 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct FInfo' at offset 48 [-Warray-bounds]
arch/powerpc/kernel/signal_32.c:813:2: error: array index 3 is past the end of the array (which contains 1 element) [-Werror,-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct DInfo' at offset 48 [-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct FInfo' at offset 48 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [3, 64] from the object at 'report' is out of the bounds of referenced subobject 'report' with type 'unsigned char' at offset 1 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct DInfo' at offset 48 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct FInfo' at offset 48 [-Warray-bounds]
drivers/media/common/siano/smscoreapi.c:1003:24: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/media/platform/qcom/venus/hfi_cmds.c:57:11: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/media/platform/qcom/venus/hfi_msgs.c:246:35: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/media/platform/qcom/venus/hfi_msgs.c:342:62: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
fs/btrfs/disk-io.c:225:34: warning: array subscript 1 is above array bounds of 'struct page *[1]' [-Warray-bounds]
fs/btrfs/struct-funcs.c:101:32: warning: array subscript 1 is above array bounds of 'struct page * const[1]' [-Warray-bounds]
fs/btrfs/struct-funcs.c:80:46: warning: array subscript 1 is above array bounds of 'struct page *[1]' [-Warray-bounds]
fs/hfsplus/xattr.c:298:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct DInfo' at offset 48 [-Warray-bounds]
fs/hfsplus/xattr.c:311:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user' with type 'struct FInfo' at offset 48 [-Warray-bounds]
fs/hpfs/dir.c:163:41: warning: array subscript 1 is above array bounds of 'u8[1]' {aka 'unsigned char[1]'} [-Warray-bounds]
include/uapi/linux/bcache.h:109:32: warning: 'memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- alpha-randconfig-p002-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- arc-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- arm-allmodconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- arm-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- arm64-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- arm64-randconfig-s032-20210330
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|-- h8300-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-a011-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-a015-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-m021-20210330
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-s002-20210330
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-report-is-out-of-the-bounds-of-referenced-subobject-report-with-type-unsigned-char-at-offset
|-- ia64-allmodconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- ia64-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- ia64-randconfig-c023-20210330
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- ia64-randconfig-s031-20210330
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- m68k-allmodconfig
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- m68k-allyesconfig
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- m68k-defconfig
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- m68k-randconfig-m031-20210330
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- microblaze-randconfig-r023-20210330
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- mips-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|-- mips-nlm_xlp_defconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- nds32-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- nds32-randconfig-r035-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- nios2-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- openrisc-randconfig-r021-20210330
|   `-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- parisc-allyesconfig
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   `-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|-- parisc-randconfig-r032-20210330
|   `-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- powerpc-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|-- powerpc-pseries_defconfig
|   |-- fs-btrfs-disk-io.c:warning:array-subscript-is-above-array-bounds-of-struct-page
|   |-- fs-btrfs-struct-funcs.c:warning:array-subscript-is-above-array-bounds-of-struct-page
|   `-- fs-btrfs-struct-funcs.c:warning:array-subscript-is-above-array-bounds-of-struct-page-const
|-- riscv-allmodconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- riscv-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- s390-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- s390-defconfig
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- s390-randconfig-r036-20210330
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- sh-allmodconfig
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- sparc-allyesconfig
|   |-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- um-allmodconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- um-allyesconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-allmodconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-randconfig-a004-20210330
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- x86_64-randconfig-c022-20210330
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- x86_64-randconfig-r005-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-randconfig-r031-20210330
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-DInfo-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user-with-type-struct-FInfo-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-randconfig-s021-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- xtensa-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
`-- xtensa-randconfig-r006-20210330
    |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
    |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
    `-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int

clang_recent_errors
|-- powerpc-randconfig-r011-20210329
|   `-- arch-powerpc-kernel-signal_32.c:error:array-index-is-past-the-end-of-the-array-(which-contains-element)-Werror-Warray-bounds
`-- powerpc-randconfig-r026-20210329
    `-- arch-powerpc-kernel-signal_32.c:error:array-index-is-past-the-end-of-the-array-(which-contains-element)-Werror-Warray-bounds

elapsed time: 724m

configs tested: 115
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                  cavium_octeon_defconfig
nios2                            alldefconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8555_defconfig
mips                         tb0226_defconfig
m68k                       m5208evb_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         vf610m4_defconfig
arm                          lpd270_defconfig
m68k                        stmark2_defconfig
powerpc                      chrp32_defconfig
sh                                  defconfig
arm                            qcom_defconfig
arm                           sama5_defconfig
arc                        nsim_700_defconfig
mips                          ath25_defconfig
arm                           corgi_defconfig
powerpc                     pq2fads_defconfig
ia64                        generic_defconfig
powerpc                  iss476-smp_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                         virt_defconfig
arm                          simpad_defconfig
arm                       imx_v4_v5_defconfig
sh                           se7206_defconfig
sh                        edosk7760_defconfig
powerpc                     pseries_defconfig
mips                           ip22_defconfig
s390                       zfcpdump_defconfig
arm                      tct_hammer_defconfig
x86_64                           alldefconfig
arm                        cerfcube_defconfig
m68k                        mvme147_defconfig
nds32                             allnoconfig
sparc                       sparc64_defconfig
sparc64                          alldefconfig
openrisc                 simple_smp_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                                defconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
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
