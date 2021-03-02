Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8517032A90E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580614AbhCBSFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:05:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:37209 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578621AbhCBP0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:26:10 -0500
IronPort-SDR: xwwTgPqNIGtIcItdHkCbVPABvcWBbLEIZf+ICBb0evkqYAPxBYI+zmIyKxYq6FOOly4u0gk0bJ
 phFQRlXrIQAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="184413558"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="184413558"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:18:40 -0800
IronPort-SDR: skEIL9E3dQJ6buXLwqK1bhkGgbC6hZSNvhnm5oHvLslyt83GOX0RUcekAj91MDAinJLir/ZMRN
 ZWY0sQj19kHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="427525494"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2021 07:18:38 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lH6nG-0000U9-0g; Tue, 02 Mar 2021 15:18:38 +0000
Date:   Tue, 02 Mar 2021 23:18:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/net-fddi-skfp-smt] BUILD SUCCESS WITH
 WARNING 800290b4db3c7818e10af88f757b09b59588241c
Message-ID: <603e5741.xl0IdreUvDN+SaA+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/net-fddi-skfp-smt
branch HEAD: 800290b4db3c7818e10af88f757b09b59588241c  net: fddi: skfp: smt: Replace one-element array with flexible-array member

possible Warning in current branch:

arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
arch/alpha/include/asm/string.h:37:11: warning: '__builtin_memset' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: '__builtin_memcpy' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
arch/sparc/include/asm/string.h:18:29: warning: '__builtin_memset' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
arch/x86/include/asm/string_32.h:228:29: warning: '__builtin_memset' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
drivers/gpu/drm/mga/mga_ioc32.c:70:2: warning: 'memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]
drivers/gpu/drm/radeon/si_dpm.c:2350:20: warning: array subscript 1 is above array bounds of 'SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]' {aka 'struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]'} [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
drivers/media/common/siano/smscoreapi.c:1003:24: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/media/platform/qcom/venus/hfi_cmds.c:57:11: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/media/platform/qcom/venus/hfi_msgs.c:246:35: warning: array subscript 1 is above array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/message/fusion/mptlan.c:759:28: warning: array subscript 1 is above array bounds of 'U32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/scsi/aacraid/aachba.c:3970:18: warning: array subscript 1 is above array bounds of 'struct sge_ieee1212[1]' [-Warray-bounds]
drivers/scsi/mpt3sas/mpt3sas_ctl.c:3257:63: warning: array subscript 24 is above array bounds of 'U16[1]' {aka 'short unsigned int[1]'} [-Warray-bounds]
drivers/staging/rtl8188eu/core/rtw_wlan_util.c:665:65: warning: array subscript 2 is above array bounds of 'u8[1]' {aka 'unsigned char[1]'} [-Warray-bounds]
fs/nfsd/nfsfh.c:191:41: warning: array subscript 1 is above array bounds of '__u32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [25, 28] from the object at 'threshold' is out of the bounds of referenced subobject 'low' with type 'struct iw_quality' at offset 20 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [49, 84] from the object at 'link_usettings' is out of the bounds of referenced subobject 'base' with type 'struct ethtool_link_settings' at offset 0 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
include/linux/fortify-string.h:22:29: warning: '__builtin_memset' offset [19, 32] from the object at 'karg' is out of the bounds of referenced subobject 'buffer_rel_condition' with type 'short unsigned int' at offset 16 [-Warray-bounds]
include/uapi/linux/bcache.h:109:32: warning: 'memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]
net/core/flow_dissector.c:831:3: warning: 'memcpy' offset [33, 48] from the object at 'flow_keys' is out of the bounds of referenced subobject 'ipv6_src' with type '__u32[4]' {aka 'unsigned int[4]'} at offset 16 [-Warray-bounds]
net/sctp/sm_make_chunk.c:3150:4: warning: 'memcpy' offset [17, 28] from the object at 'addr' is out of the bounds of referenced subobject 'v4' with type 'struct sockaddr_in' at offset 0 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- drivers-gpu-drm-radeon-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-message-fusion-mptlan.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|   |-- drivers-scsi-mpt3sas-mpt3sas_ctl.c:warning:array-subscript-is-above-array-bounds-of-U16-aka-short-unsigned-int
|   |-- drivers-staging-rtl8188eu-core-rtw_wlan_util.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- fs-nfsd-nfsfh.c:warning:array-subscript-is-above-array-bounds-of-__u32-aka-unsigned-int
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-radeon-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-message-fusion-mptlan.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|   |-- drivers-staging-rtl8188eu-core-rtw_wlan_util.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- fs-nfsd-nfsfh.c:warning:array-subscript-is-above-array-bounds-of-__u32-aka-unsigned-int
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-radeon-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-message-fusion-mptlan.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|   |-- drivers-staging-rtl8188eu-core-rtw_wlan_util.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- fs-nfsd-nfsfh.c:warning:array-subscript-is-above-array-bounds-of-__u32-aka-unsigned-int
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-radeon-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-message-fusion-mptlan.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|   |-- drivers-staging-rtl8188eu-core-rtw_wlan_util.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- fs-nfsd-nfsfh.c:warning:array-subscript-is-above-array-bounds-of-__u32-aka-unsigned-int
|-- arm-randconfig-r023-20210302
|   `-- net-sctp-sm_make_chunk.c:warning:memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- arm-randconfig-r034-20210301
|   |-- drivers-gpu-drm-radeon-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|   |-- drivers-scsi-mpt3sas-mpt3sas_ctl.c:warning:array-subscript-is-above-array-bounds-of-U16-aka-short-unsigned-int
|   |-- fs-nfsd-nfsfh.c:warning:array-subscript-is-above-array-bounds-of-__u32-aka-unsigned-int
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- h8300-randconfig-p001-20210302
|   `-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|-- i386-randconfig-a004-20210302
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- i386-randconfig-a011-20210302
|   |-- drivers-gpu-drm-radeon-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   `-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|-- i386-randconfig-s001-20210302
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-radeon-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-message-fusion-mptlan.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|   |-- drivers-scsi-mpt3sas-mpt3sas_ctl.c:warning:array-subscript-is-above-array-bounds-of-U16-aka-short-unsigned-int
|   |-- drivers-staging-rtl8188eu-core-rtw_wlan_util.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   |-- fs-nfsd-nfsfh.c:warning:array-subscript-is-above-array-bounds-of-__u32-aka-unsigned-int
|   |-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-sctp-sm_make_chunk.c:warning:memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- mips-allyesconfig
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|-- mips-randconfig-r026-20210302
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-DInfo-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-entry-is-out-of-the-bounds-of-referenced-subobject-user_info-with-type-struct-FInfo-at-offset
|-- parisc-randconfig-r025-20210302
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- include-uapi-linux-bcache.h:warning:memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-allyesconfig
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
|-- powerpc64-allyesconfig
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-threshold-is-out-of-the-bounds-of-referenced-subobject-low-with-type-struct-iw_quality-at-offset
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-radeon-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-message-fusion-mptlan.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|   |-- drivers-staging-rtl8188eu-core-rtw_wlan_util.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- fs-nfsd-nfsfh.c:warning:array-subscript-is-above-array-bounds-of-__u32-aka-unsigned-int
|-- riscv-rv32_defconfig
|   `-- drivers-gpu-drm-radeon-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|-- sh-allmodconfig
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-staging-rtl8188eu-core-rtw_wlan_util.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- fs-nfsd-nfsfh.c:warning:array-subscript-is-above-array-bounds-of-__u32-aka-unsigned-int
|-- sparc-allyesconfig
|   |-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- arch-sparc-include-asm-string.h:warning:__builtin_memset-offset-from-the-object-at-karg-is-out-of-the-bounds-of-referenced-subobject-buffer_rel_condition-with-type-short-unsigned-int-at-offset
|   |-- drivers-gpu-drm-radeon-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-media-common-siano-smscoreapi.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_cmds.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-media-platform-qcom-venus-hfi_msgs.c:warning:array-subscript-is-above-array-bounds-of-u32-aka-unsigned-int
|   |-- drivers-message-fusion-mptlan.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212
|   |-- drivers-scsi-mpt3sas-mpt3sas_ctl.c:warning:array-subscript-is-above-array-bounds-of-U16-aka-short-unsigned-int
|   |-- drivers-staging-rtl8188eu-core-rtw_wlan_util.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- fs-nfsd-nfsfh.c:warning:array-subscript-is-above-array-bounds-of-__u32-aka-unsigned-int
`-- x86_64-randconfig-a001-20210302
    |-- drivers-gpu-drm-mga-mga_ioc32.c:warning:memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
    |-- drivers-gpu-drm-radeon-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
    `-- drivers-scsi-aacraid-aachba.c:warning:array-subscript-is-above-array-bounds-of-struct-sge_ieee1212

elapsed time: 725m

configs tested: 92
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          ep93xx_defconfig
arm                     am200epdkit_defconfig
powerpc                        warp_defconfig
powerpc                     pq2fads_defconfig
arm                        mvebu_v7_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         s3c2410_defconfig
sh                        dreamcast_defconfig
mips                      maltaaprp_defconfig
nios2                         10m50_defconfig
arm                        realview_defconfig
sh                   sh7770_generic_defconfig
arm                         s5pv210_defconfig
openrisc                 simple_smp_defconfig
m68k                        stmark2_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a005-20210302
i386                 randconfig-a003-20210302
i386                 randconfig-a002-20210302
i386                 randconfig-a004-20210302
i386                 randconfig-a006-20210302
i386                 randconfig-a001-20210302
i386                 randconfig-a016-20210302
i386                 randconfig-a012-20210302
i386                 randconfig-a014-20210302
i386                 randconfig-a013-20210302
i386                 randconfig-a011-20210302
i386                 randconfig-a015-20210302
x86_64               randconfig-a006-20210302
x86_64               randconfig-a001-20210302
x86_64               randconfig-a004-20210302
x86_64               randconfig-a002-20210302
x86_64               randconfig-a005-20210302
x86_64               randconfig-a003-20210302
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210302
x86_64               randconfig-a016-20210302
x86_64               randconfig-a015-20210302
x86_64               randconfig-a014-20210302
x86_64               randconfig-a012-20210302
x86_64               randconfig-a011-20210302

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
