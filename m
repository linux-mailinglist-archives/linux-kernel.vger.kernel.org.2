Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD47B34F74B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhCaDQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:16:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:9630 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233455AbhCaDPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:15:37 -0400
IronPort-SDR: efWbpwD3N4R0MI7HWG4NzE494Kg/2sCxQFq03jMGksfImDKHTETt4t3fDLuXFgDYE19wPS8Im0
 1WToQjSj7KlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179036138"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179036138"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 20:15:31 -0700
IronPort-SDR: h2X8FDEZDg90c/VbPKLBEIkHr78DZxjMSNXkL28JPQi5h5o1oz8S1g72XIm/v+gFlriXWo6lOm
 weSpLSCEjFbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="455292412"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2021 20:15:29 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRRKL-0005db-0K; Wed, 31 Mar 2021 03:15:29 +0000
Date:   Wed, 31 Mar 2021 11:15:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/wab/hfsplus] BUILD SUCCESS WITH WARNING b69572fd04db9429ffd9a7cd766103759cee2056
Message-ID: <6063e934.XZHfvUgRacSC2Alu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wab/hfsplus
branch HEAD: b69572fd04db9429ffd9a7cd766103759cee2056  hfsplus: Fix out-of-bounds warnings in __hfsplus_setxattr

possible Warning in current branch:

arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [3, 64] from the object at 'report' is out of the bounds of referenced subobject 'report' with type 'unsigned char' at offset 1 [-Warray-bounds]
drivers/media/common/siano/smscoreapi.c:1003:24: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/media/platform/qcom/venus/hfi_cmds.c:57:11: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/media/platform/qcom/venus/hfi_msgs.c:246:35: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/media/platform/qcom/venus/hfi_msgs.c:342:62: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
fs/btrfs/disk-io.c:225:34: warning: array subscript 1 is above array bounds of 'struct page *[1]' [-Warray-bounds]
fs/btrfs/struct-funcs.c:101:32: warning: array subscript 1 is above array bounds of 'struct page * const[1]' [-Warray-bounds]
fs/btrfs/struct-funcs.c:80:46: warning: array subscript 1 is above array bounds of 'struct page *[1]' [-Warray-bounds]
fs/hpfs/dir.c:163:41: warning: array subscript 1 is above array bounds of 'u8[1]' {aka 'unsigned char[1]'} [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [25, 32] from the object at 'desc' is out of the bounds of referenced subobject 'qw2' with type 'long long unsigned int' at offset 16 [-Warray-bounds]
include/uapi/linux/bcache.h:109:32: warning: 'memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- alpha-allyesconfig
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
|-- h8300-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- h8300-randconfig-c023-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-allmodconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-a001-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-a003-20210330
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-a004-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-a011-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-a012-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-a015-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-a016-20210330
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-m021-20210330
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-s002-20210330
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-report-is-out-of-the-bounds-of-referenced-subobject-report-with-type-unsigned-char-at-offset
|-- ia64-allmodconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- ia64-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- nds32-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- nds32-randconfig-c024-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- nds32-randconfig-r014-20210330
|   `-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- nios2-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- nios2-randconfig-m031-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- nios2-randconfig-r006-20210330
|   `-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- openrisc-randconfig-r003-20210330
|   `-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- parisc-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- parisc-randconfig-c003-20210330
|   `-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- powerpc-allmodconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- powerpc-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- powerpc-ppc64_defconfig
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
|-- s390-allmodconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- s390-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- s390-defconfig
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- sh-allmodconfig
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- sparc-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- sparc-randconfig-r016-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- sparc64-randconfig-s031-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- um-allmodconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- um-allyesconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-allmodconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-allyesconfig
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-randconfig-a002-20210330
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-randconfig-a004-20210330
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- x86_64-randconfig-c022-20210330
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|-- x86_64-randconfig-m001-20210330
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- x86_64-randconfig-s022-20210330
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-desc-is-out-of-the-bounds-of-referenced-subobject-qw2-with-type-long-long-unsigned-int-at-offset
`-- xtensa-allyesconfig
    |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
    |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
    |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
    `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char

elapsed time: 727m

configs tested: 105
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                           gcw0_defconfig
powerpc                        warp_defconfig
powerpc                     kmeter1_defconfig
mips                           ip22_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                         virt_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
arm                          gemini_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                        fsp2_defconfig
arc                              alldefconfig
ia64                      gensparse_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      arches_defconfig
mips                        qi_lb60_defconfig
riscv                          rv32_defconfig
sh                          sdk7786_defconfig
powerpc                         wii_defconfig
ia64                            zx1_defconfig
m68k                        stmark2_defconfig
mips                   sb1250_swarm_defconfig
mips                           xway_defconfig
powerpc                       ppc64_defconfig
arm                          iop32x_defconfig
mips                        bcm47xx_defconfig
powerpc                      ppc44x_defconfig
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
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
