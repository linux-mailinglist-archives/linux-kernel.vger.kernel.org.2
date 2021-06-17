Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DAF3ABAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhFQRvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:51:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:3418 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhFQRvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:51:17 -0400
IronPort-SDR: PR4eowUIxBhmg6mz4aa5dKfpIDMTMBcohRyYzBWmyJcjGwVYkgpDsozZdW0yW/6LMmf5SHiZ+a
 5woXnTKqCIGg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193734299"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="193734299"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:49:08 -0700
IronPort-SDR: l2J526+KV2Nu5oSHJRS9Vd2bhlImYOWv3+9cyBEIGnzplGPMb6WfbTrjdr5vo161AF6WvW4r1v
 Co7Kvm0yipaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="452859412"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2021 10:49:07 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltw8Y-0002CK-EA; Thu, 17 Jun 2021 17:49:06 +0000
Date:   Fri, 18 Jun 2021 01:48:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/Warray-bounds] BUILD SUCCESS WITH
 WARNING 9f6e5c27ef7e3d046985438ff82ca238ca1c8aff
Message-ID: <60cb8b02.I1XINpd+AUeF4SMK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/Warray-bounds
branch HEAD: 9f6e5c27ef7e3d046985438ff82ca238ca1c8aff  Makefile: Enable -Warray-bounds

Warning in current branch:

drivers/media/platform/omap3isp/ispstat.c:524:2: warning: 'memcpy' offset [21, 32] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]
include/uapi/linux/bcache.h:109:32: warning: 'memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]

possible Warning in current branch:

arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [13, 256] from the object at 'cmd' is out of the bounds of referenced subobject 'payload' with type 'u8[]' at offset 12 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [14, 19] from the object at 'ht_capie' is out of the bounds of referenced subobject 'rx_mask' with type 'u8[10]' {aka 'unsigned char[10]'} at offset 3 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [17, 38] from the object at 'txdesc' is out of the bounds of referenced subobject 'frame_control' with type 'short unsigned int' at offset 14 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [21, 30] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [25, 28] from the object at 'threshold' is out of the bounds of referenced subobject 'low' with type 'struct iw_quality' at offset 20 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [27, 42] from the object at 'buf' is out of the bounds of referenced subobject 'key' with type 'u8[16]' {aka 'unsigned char[16]'} at offset 10 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [14, 49] from the object at 'cmd' is out of the bounds of referenced subobject 'ci' with type 'struct iwl_fw_channel_info' at offset 5 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [17, 20] from the object at 'settings' is out of the bounds of referenced subobject 'advertising' with type 'long long unsigned int' at offset 8 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [25, 26] from the object at 'aux_roc_req' is out of the bounds of referenced subobject 'channel_info' with type 'struct iwl_fw_channel_info' at offset 16 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [9, 12] from the object at 'settings' is out of the bounds of referenced subobject 'supported' with type 'long long unsigned int' at offset 0 [-Warray-bounds]
drivers/gpu/drm/mga/mga_ioc32.c:70:2: warning: 'memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]
drivers/media/platform/qcom/venus/hfi_cmds.c:58:11: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:3730:13: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:3731:27: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/net/wireless/ath/ath10k/bmi.c:278:3: warning: 'memcpy' offset [13, 256] from the object at 'cmd' is out of the bounds of referenced subobject 'payload' with type 'u8[]' at offset 12 [-Warray-bounds]
drivers/net/wireless/ath/ath10k/bmi.c:412:3: warning: 'memcpy' offset [9, 256] from the object at 'cmd' is out of the bounds of referenced subobject 'payload' with type 'u8[]' at offset 8 [-Warray-bounds]
drivers/net/wireless/intersil/orinoco/hw.c:1014:2: warning: 'memcpy' offset [27, 42] from the object at 'buf' is out of the bounds of referenced subobject 'key' with type 'u8[16]' {aka 'unsigned char[16]'} at offset 10 [-Warray-bounds]
drivers/scsi/aacraid/aachba.c:3965:18: warning: array subscript 1 is above array bounds of 'struct sge_ieee1212[1]' [-Warray-bounds]
drivers/staging/rtl8723bs/core/rtw_mlme.c:2450:2: warning: 'memcpy' offset [14, 19] from the object at 'ht_capie' is out of the bounds of referenced subobject 'rx_mask' with type 'u8[10]' {aka 'unsigned char[10]'} at offset 3 [-Warray-bounds]
fs/hfsplus/xattr.c:300:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
fs/hfsplus/xattr.c:313:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [21, 32] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [25, 28] from the object at 'threshold' is out of the bounds of referenced subobject 'low' with type 'struct iw_quality' at offset 20 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
include/linux/skbuff.h:3723:2: warning: 'memcpy' offset [17, 38] from the object at 'txdesc' is out of the bounds of referenced subobject 'frame_control' with type 'short unsigned int' at offset 14 [-Warray-bounds]
net/wireless/wext-spy.c:178:2: warning: 'memcpy' offset [25, 28] from the object at 'threshold' is out of the bounds of referenced subobject 'low' with type 'struct iw_quality' at offset 20 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allyesconfig
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_common.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|-- arm-allmodconfig
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_common.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|-- arm-allyesconfig
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_common.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|-- arm-randconfig-r026-20210617
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|-- arm64-allyesconfig
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_common.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|-- arm64-defconfig
|   `-- drivers-net-wireless-ath-ath10k-bmi.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-payload-with-type-u8-at-offset
|-- csky-randconfig-r022-20210617
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|   |-- include-linux-skbuff.h:warning:memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|   `-- net-wireless-wext-spy.c:warning:memcpy-offset-from-the-object-at-threshold-is-out-of-the-bounds-of-referenced-subobject-low-with-type-struct-iw_quality-at-offset
|-- i386-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- i386-randconfig-a012-20210617
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- i386-randconfig-a013-20210617
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- i386-randconfig-c001-20210617
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- i386-randconfig-r015-20210617
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-aux_roc_req-is-out-of-the-bounds-of-referenced-subobject-channel_info-with-type-struct-iwl_fw_channel_info-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-ci-with-type-struct-iwl_fw_channel_info-at-offset
|-- i386-randconfig-r016-20210617
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- i386-randconfig-s032-20210617
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-advertising-with-type-long-long-unsigned-int-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-supported-with-type-long-long-unsigned-int-at-offset
|-- m68k-allmodconfig
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-buf-is-out-of-the-bounds-of-referenced-subobject-key-with-type-u8-aka-unsigned-char-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-payload-with-type-u8-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-ht_capie-is-out-of-the-bounds-of-referenced-subobject-rx_mask-with-type-u8-aka-unsigned-char-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-threshold-is-out-of-the-bounds-of-referenced-subobject-low-with-type-struct-iw_quality-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|   `-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- m68k-allyesconfig
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-buf-is-out-of-the-bounds-of-referenced-subobject-key-with-type-u8-aka-unsigned-char-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-payload-with-type-u8-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-ht_capie-is-out-of-the-bounds-of-referenced-subobject-rx_mask-with-type-u8-aka-unsigned-char-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-threshold-is-out-of-the-bounds-of-referenced-subobject-low-with-type-struct-iw_quality-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|   `-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- m68k-defconfig
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- mips-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- mips-randconfig-r014-20210617
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- nds32-allyesconfig
|   |-- drivers-media-platform-omap3isp-ispstat.c:warning:memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-net-wireless-ath-ath10k-bmi.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-payload-with-type-u8-at-offset
|   |-- drivers-net-wireless-intersil-orinoco-hw.c:warning:memcpy-offset-from-the-object-at-buf-is-out-of-the-bounds-of-referenced-subobject-key-with-type-u8-aka-unsigned-char-at-offset
|   |-- drivers-staging-rtl8723bs-core-rtw_mlme.c:warning:memcpy-offset-from-the-object-at-ht_capie-is-out-of-the-bounds-of-referenced-subobject-rx_mask-with-type-u8-aka-unsigned-char-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   |-- fs-hfsplus-xattr.c:warning:memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|   |-- include-linux-skbuff.h:warning:memcpy-offset-from-the-object-at-txdesc-is-out-of-the-bounds-of-referenced-subobject-frame_control-with-type-short-unsigned-int-at-offset
|   |-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   `-- net-wireless-wext-spy.c:warning:memcpy-offset-from-the-object-at-threshold-is-out-of-the-bounds-of-referenced-subobject-low-with-type-struct-iw_quality-at-offset
|-- powerpc64-randconfig-c004-20210617
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_common.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-threshold-is-out-of-the-bounds-of-referenced-subobject-low-with-type-struct-iw_quality-at-offset
|-- s390-randconfig-r032-20210617
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- sh-allmodconfig
|   `-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
`-- x86_64-randconfig-c022-20210617
    `-- drivers-gpu-drm-mga-mga_ioc32.c:warning:memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset

elapsed time: 732m

configs tested: 125
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
mips                           ip28_defconfig
m68k                          amiga_defconfig
arc                              alldefconfig
sh                   rts7751r2dplus_defconfig
arm                          collie_defconfig
arm                        multi_v5_defconfig
arm                         orion5x_defconfig
riscv                            allmodconfig
powerpc                 mpc8315_rdb_defconfig
mips                         tb0219_defconfig
mips                      pistachio_defconfig
um                               alldefconfig
powerpc                 mpc836x_mds_defconfig
arc                          axs103_defconfig
h8300                     edosk2674_defconfig
mips                          rm200_defconfig
csky                                defconfig
x86_64                              defconfig
h8300                            alldefconfig
sh                          lboxre2_defconfig
x86_64                           alldefconfig
arm                     am200epdkit_defconfig
powerpc                        cell_defconfig
mips                           ci20_defconfig
m68k                            q40_defconfig
arm                       aspeed_g5_defconfig
m68k                       m5249evb_defconfig
riscv                    nommu_virt_defconfig
arm                          lpd270_defconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
mips                        bcm47xx_defconfig
arm                        clps711x_defconfig
powerpc                     stx_gp3_defconfig
um                                  defconfig
arc                     nsimosci_hs_defconfig
mips                             allmodconfig
powerpc                           allnoconfig
arm                       omap2plus_defconfig
powerpc                      ep88xc_defconfig
sh                         ecovec24_defconfig
arm                        multi_v7_defconfig
arm                          imote2_defconfig
arm                            qcom_defconfig
ia64                            zx1_defconfig
mips                 decstation_r4k_defconfig
powerpc                      makalu_defconfig
sh                   secureedge5410_defconfig
arm                           tegra_defconfig
mips                            gpr_defconfig
arm                          simpad_defconfig
x86_64                            allnoconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210617
x86_64               randconfig-a001-20210617
x86_64               randconfig-a002-20210617
x86_64               randconfig-a003-20210617
x86_64               randconfig-a006-20210617
x86_64               randconfig-a005-20210617
i386                 randconfig-a002-20210617
i386                 randconfig-a006-20210617
i386                 randconfig-a001-20210617
i386                 randconfig-a004-20210617
i386                 randconfig-a005-20210617
i386                 randconfig-a003-20210617
i386                 randconfig-a015-20210617
i386                 randconfig-a013-20210617
i386                 randconfig-a016-20210617
i386                 randconfig-a012-20210617
i386                 randconfig-a014-20210617
i386                 randconfig-a011-20210617
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210617
x86_64               randconfig-a015-20210617
x86_64               randconfig-a011-20210617
x86_64               randconfig-a014-20210617
x86_64               randconfig-a012-20210617
x86_64               randconfig-a013-20210617
x86_64               randconfig-a016-20210617

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
