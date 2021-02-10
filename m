Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2C316A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBJPow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:44:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:52303 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhBJPor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:44:47 -0500
IronPort-SDR: Ff5gfZ/Dr3WkMBUY3nlYLuRhQSIQSy62Ta09C7ITeEq1wVZunhSjnYs2y3oyfzKrFz/XFB02D3
 OZXLTjrowxhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="181319915"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="181319915"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 07:44:05 -0800
IronPort-SDR: A3aTzvqt1ZryjCFFHHwwfu3iJzMsFlwxjY+Nb/+2OSF9rHgQReLB40qHfmNENYUBD3Wef1ZzbP
 0N4ZbHUN/pxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="421091698"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2021 07:44:04 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9ret-00036n-LX; Wed, 10 Feb 2021 15:44:03 +0000
Date:   Wed, 10 Feb 2021 23:43:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/uapi/nfsd/nfsfh] BUILD REGRESSION
 d28670226e028e65b0de5e6744c5df188fc2728b
Message-ID: <6023ff38.jAvQDiADYCDV492O%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/uapi/nfsd/nfsfh
branch HEAD: d28670226e028e65b0de5e6744c5df188fc2728b  UAPI: linux: nfsd: nfsfh.h: Replace one-element array with flexible-array

Error/Warning reports:

https://lore.kernel.org/lkml/202102100518.IyS9JBKB-lkp@intel.com
https://lore.kernel.org/lkml/202102100646.RhG8946d-lkp@intel.com

Error/Warning in current branch:

drivers/media/pci/ngene/ngene-core.c:388:2: warning: 'memcpy' offset [12, 16] from the object at 'com' is out of the bounds of referenced subobject 'config' with type 'unsigned char' at offset 10 [-Warray-bounds]
fs/hpfs/dir.c:163:41: warning: array subscript 1 is above array bounds of 'u8[1]' {aka 'unsigned char[1]'} [-Warray-bounds]

possible Error/Warning in current branch:

arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [17, 24] from the object at 'alloc' is out of the bounds of referenced subobject 'key' with type 'struct bkey' at offset 0 [-Warray-bounds]
arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
arch/powerpc/kernel/signal_32.c:813:2: error: array index 3 is past the end of the array (which contains 1 element) [-Werror,-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: '__builtin_memcpy' offset [3, 64] from the object at 'report' is out of the bounds of referenced subobject 'report' with type 'unsigned char' at offset 1 [-Warray-bounds]
arch/sparc/include/asm/string.h:15:25: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [14, 49] from the object at 'cmd' is out of the bounds of referenced subobject 'ci' with type 'struct iwl_fw_channel_info' at offset 5 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [17, 28] from the object at 'addr' is out of the bounds of referenced subobject 'v4' with type 'struct sockaddr_in' at offset 0 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [25, 26] from the object at 'aux_roc_req' is out of the bounds of referenced subobject 'channel_info' with type 'struct iwl_fw_channel_info' at offset 16 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [9, 256] from the object at 'cmd' is out of the bounds of referenced subobject 'payload' with type 'u8[]' at offset 8 [-Warray-bounds]
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/si_dpm.c:2448:20: warning: array subscript 1 is above array bounds of 'SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]' {aka 'struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]'} [-Warray-bounds]
drivers/gpu/drm/imx/imx-ldb.c:186:8: warning: array subscript -22 is below array bounds of 'struct clk *[4]' [-Warray-bounds]
drivers/ide/ide-acpi.c:332:3: warning: 'memcpy' offset [3, 8] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [6, 10] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 4 [-Warray-bounds]
drivers/message/fusion/mptbase.c:7747:62: warning: array subscript 1 is above array bounds of 'U32[1]' {aka 'unsigned int[1]'} [-Warray-bounds]
drivers/net/wireless/intel/ipw2x00/libipw_rx.c:957:3: warning: 'memcpy' offset [6, 26] from the object at 'param_element' is out of the bounds of referenced subobject 'qui' with type 'u8[3]' {aka 'unsigned char[3]'} at offset 2 [-Warray-bounds]
drivers/net/wireless/intel/ipw2x00/libipw_rx.c:986:3: warning: 'memcpy' offset [6, 9] from the object at 'qos_info_element' is out of the bounds of referenced subobject 'qui' with type 'u8[3]' {aka 'unsigned char[3]'} at offset 2 [-Warray-bounds]
drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:3677:2: warning: 'memcpy' offset [25, 26] from the object at 'aux_roc_req' is out of the bounds of referenced subobject 'channel_info' with type 'struct iwl_fw_channel_info' at offset 16 [-Warray-bounds]
drivers/net/wireless/intel/iwlwifi/mvm/mvm.h:1487:2: warning: 'memcpy' offset [14, 49] from the object at 'cmd' is out of the bounds of referenced subobject 'ci' with type 'struct iwl_fw_channel_info' at offset 5 [-Warray-bounds]
drivers/net/wireless/intel/iwlwifi/mvm/tdls.c:423:2: warning: 'memcpy' offset [14, 85] from the object at 'cmd' is out of the bounds of referenced subobject 'ci' with type 'struct iwl_fw_channel_info' at offset 5 [-Warray-bounds]
drivers/net/wireless/ray_cs.c:585:3: warning: 'memcpy' forming offset [94, 96] is out of the bounds [0, 93] of object 'b4_default_startup_parms' with type 'const UCHAR[93]' {aka 'const unsigned char[93]'} [-Warray-bounds]
drivers/net/wireless/ray_cs.c:603:3: warning: 'memcpy' forming offset [99, 100] is out of the bounds [0, 98] of object 'b5_default_startup_parms' with type 'const UCHAR[98]' {aka 'const unsigned char[98]'} [-Warray-bounds]
drivers/scsi/ufs/ufshcd.c:6677:3: warning: 'memcpy' offset [29, 48] from the object at 'treq' is out of the bounds of referenced subobject 'req_header' with type 'struct utp_upiu_header' at offset 16 [-Warray-bounds]
drivers/scsi/ufs/ufshcd.c:6690:3: warning: 'memcpy' offset [61, 80] from the object at 'treq' is out of the bounds of referenced subobject 'rsp_header' with type 'struct utp_upiu_header' at offset 48 [-Warray-bounds]
drivers/staging/rtl8192e/rtllib_rx.c:1585:3: warning: 'memcpy' offset [6, 26] from the object at 'param_element' is out of the bounds of referenced subobject 'qui' with type 'u8[3]' {aka 'unsigned char[3]'} at offset 2 [-Warray-bounds]
drivers/staging/rtl8192e/rtllib_rx.c:1613:3: warning: 'memcpy' offset [6, 9] from the object at 'qos_info_element' is out of the bounds of referenced subobject 'qui' with type 'u8[3]' {aka 'unsigned char[3]'} at offset 2 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [17, 20] from the object at 'settings' is out of the bounds of referenced subobject 'advertising' with type 'long long unsigned int' at offset 8 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [17, 28] from the object at 'addr' is out of the bounds of referenced subobject 'v4' with type 'struct sockaddr_in' at offset 0 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [49, 84] from the object at 'link_usettings' is out of the bounds of referenced subobject 'base' with type 'struct ethtool_link_settings' at offset 0 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [9, 12] from the object at 'settings' is out of the bounds of referenced subobject 'supported' with type 'long long unsigned int' at offset 0 [-Warray-bounds]
net/smc/smc_llc.c:594:2: warning: 'memcpy' forming offset [49, 60] is out of the bounds [0, 48] of object 'delllc' with type 'struct smc_llc_msg_del_link' [-Warray-bounds]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- alpha-defconfig
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- alpha-randconfig-r024-20210209
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-alloc-is-out-of-the-bounds-of-referenced-subobject-key-with-type-struct-bkey-at-offset
|   |-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- arm-allmodconfig
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- arm-allyesconfig
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- arm-randconfig-s032-20210209
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-net-wireless-ray_cs.c:warning:memcpy-forming-offset-is-out-of-the-bounds-of-object-b4_default_startup_parms-with-type-const-UCHAR-aka-const-unsigned-char
|   |-- drivers-net-wireless-ray_cs.c:warning:memcpy-forming-offset-is-out-of-the-bounds-of-object-b5_default_startup_parms-with-type-const-UCHAR-aka-const-unsigned-char
|   `-- net-smc-smc_llc.c:warning:memcpy-forming-offset-is-out-of-the-bounds-of-object-delllc-with-type-struct-smc_llc_msg_del_link
|-- arm64-allyesconfig
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- h8300-allyesconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- h8300-randconfig-r033-20210209
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- h8300-randconfig-s031-20210209
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-advertising-with-type-long-long-unsigned-int-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-supported-with-type-long-long-unsigned-int-at-offset
|-- i386-randconfig-a002-20210209
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- i386-randconfig-a004-20210209
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- i386-randconfig-a005-20210209
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- i386-randconfig-a006-20210209
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-aux_roc_req-is-out-of-the-bounds-of-referenced-subobject-channel_info-with-type-struct-iwl_fw_channel_info-at-offset
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-ci-with-type-struct-iwl_fw_channel_info-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-payload-with-type-u8-at-offset
|-- i386-randconfig-a011-20210209
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-a014-20210209
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-a015-20210209
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-c001-20210209
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- i386-randconfig-m021-20210209
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- ia64-allmodconfig
|   |-- drivers-ide-ide-acpi.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-net-wireless-intel-ipw2x00-libipw_rx.c:warning:memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- drivers-net-wireless-intel-ipw2x00-libipw_rx.c:warning:memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-mac80211.c:warning:memcpy-offset-from-the-object-at-aux_roc_req-is-out-of-the-bounds-of-referenced-subobject-channel_info-with-type-struct-iwl_fw_channel_info-at
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-mvm.h:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-ci-with-type-struct-iwl_fw_channel_info-at-offset
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-tdls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-ci-with-type-struct-iwl_fw_channel_info-at-offset
|   |-- drivers-staging-rtl8192e-rtllib_rx.c:warning:memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- drivers-staging-rtl8192e-rtllib_rx.c:warning:memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- ia64-allyesconfig
|   |-- drivers-ide-ide-acpi.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-net-wireless-intel-ipw2x00-libipw_rx.c:warning:memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- drivers-net-wireless-intel-ipw2x00-libipw_rx.c:warning:memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- ia64-defconfig
|   `-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|-- ia64-randconfig-r013-20210209
|   `-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- ia64-randconfig-r023-20210209
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   `-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|-- m68k-allmodconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- m68k-allyesconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- m68k-defconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- m68k-randconfig-c004-20210209
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- microblaze-randconfig-r003-20210209
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- nios2-allyesconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- openrisc-randconfig-r001-20210209
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- parisc-randconfig-c003-20210209
|   `-- drivers-gpu-drm-imx-imx-ldb.c:warning:array-subscript-is-below-array-bounds-of-struct-clk
|-- parisc-randconfig-r011-20210209
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   `-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|-- parisc-randconfig-r035-20210209
|   |-- drivers-net-wireless-intel-ipw2x00-libipw_rx.c:warning:memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   `-- drivers-net-wireless-intel-ipw2x00-libipw_rx.c:warning:memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- powerpc-cell_defconfig
|   `-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|-- powerpc-randconfig-r004-20210209
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- powerpc64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-net-wireless-intel-ipw2x00-libipw_rx.c:warning:memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- drivers-net-wireless-intel-ipw2x00-libipw_rx.c:warning:memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-mac80211.c:warning:memcpy-offset-from-the-object-at-aux_roc_req-is-out-of-the-bounds-of-referenced-subobject-channel_info-with-type-struct-iwl_fw_channel_info-at
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-mvm.h:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-ci-with-type-struct-iwl_fw_channel_info-at-offset
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-tdls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-ci-with-type-struct-iwl_fw_channel_info-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   |-- drivers-staging-rtl8192e-rtllib_rx.c:warning:memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- drivers-staging-rtl8192e-rtllib_rx.c:warning:memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-net-wireless-intel-ipw2x00-libipw_rx.c:warning:memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- drivers-net-wireless-intel-ipw2x00-libipw_rx.c:warning:memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-mac80211.c:warning:memcpy-offset-from-the-object-at-aux_roc_req-is-out-of-the-bounds-of-referenced-subobject-channel_info-with-type-struct-iwl_fw_channel_info-at
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-mvm.h:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-ci-with-type-struct-iwl_fw_channel_info-at-offset
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-tdls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-ci-with-type-struct-iwl_fw_channel_info-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   |-- drivers-staging-rtl8192e-rtllib_rx.c:warning:memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   |-- drivers-staging-rtl8192e-rtllib_rx.c:warning:memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- riscv-randconfig-r004-20210209
|   `-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- s390-allmodconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- sh-allmodconfig
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- sparc-allyesconfig
|   |-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- sparc-randconfig-r024-20210209
|   |-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-report-is-out-of-the-bounds-of-referenced-subobject-report-with-type-unsigned-char-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- sparc64-randconfig-r002-20210209
|   `-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- sparc64-randconfig-r021-20210209
|   `-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- sparc64-randconfig-r022-20210209
|   `-- arch-sparc-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-kexec
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   `-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|-- x86_64-randconfig-a001-20210209
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-randconfig-a002-20210209
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-si_dpm.c:warning:array-subscript-is-above-array-bounds-of-SISLANDS_SMC_HW_PERFORMANCE_LEVEL-aka-struct-SISLANDS_SMC_HW_PERFORMANCE_LEVEL
|   `-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- x86_64-randconfig-a003-20210209
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- x86_64-randconfig-a004-20210209
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-randconfig-a005-20210209
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-randconfig-a006-20210209
|   |-- drivers-ide-ide-acpi.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-randconfig-r035-20210209
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- x86_64-randconfig-s021-20210209
|   `-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|-- x86_64-randconfig-s022-20210209
|   |-- drivers-ide-ide-acpi.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char
|-- x86_64-rhel
|   |-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   |-- drivers-staging-rtl8192e-rtllib_rx.c:warning:memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   `-- drivers-staging-rtl8192e-rtllib_rx.c:warning:memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|-- x86_64-rhel-7.6-kselftests
|   |-- drivers-media-pci-ngene-ngene-core.c:warning:memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|   |-- drivers-message-fusion-mptbase.c:warning:array-subscript-is-above-array-bounds-of-U32-aka-unsigned-int
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-mac80211.c:warning:memcpy-offset-from-the-object-at-aux_roc_req-is-out-of-the-bounds-of-referenced-subobject-channel_info-with-type-struct-iwl_fw_channel_info-at
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-mvm.h:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-ci-with-type-struct-iwl_fw_channel_info-at-offset
|   |-- drivers-net-wireless-intel-iwlwifi-mvm-tdls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-ci-with-type-struct-iwl_fw_channel_info-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-req_header-with-type-struct-utp_upiu_header-at-offset
|   |-- drivers-scsi-ufs-ufshcd.c:warning:memcpy-offset-from-the-object-at-treq-is-out-of-the-bounds-of-referenced-subobject-rsp_header-with-type-struct-utp_upiu_header-at-offset
|   |-- drivers-staging-rtl8192e-rtllib_rx.c:warning:memcpy-offset-from-the-object-at-param_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|   `-- drivers-staging-rtl8192e-rtllib_rx.c:warning:memcpy-offset-from-the-object-at-qos_info_element-is-out-of-the-bounds-of-referenced-subobject-qui-with-type-u8-aka-unsigned-char-at-offset
|-- x86_64-rhel-8.3
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
|-- x86_64-rhel-8.3-kbuiltin
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-addr-is-out-of-the-bounds-of-referenced-subobject-v4-with-type-struct-sockaddr_in-at-offset
`-- xtensa-allyesconfig
    `-- fs-hpfs-dir.c:warning:array-subscript-is-above-array-bounds-of-u8-aka-unsigned-char

clang_recent_errors
|-- powerpc-randconfig-r022-20210209
|   `-- arch-powerpc-kernel-signal_32.c:error:array-index-is-past-the-end-of-the-array-(which-contains-element)-Werror-Warray-bounds
`-- powerpc64-randconfig-r016-20210209
    `-- arch-powerpc-kernel-signal_32.c:error:array-index-is-past-the-end-of-the-array-(which-contains-element)-Werror-Warray-bounds

elapsed time: 1147m

configs tested: 95
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                       m5249evb_defconfig
sh                   sh7770_generic_defconfig
mips                         cobalt_defconfig
arc                        nsimosci_defconfig
xtensa                         virt_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         s5pv210_defconfig
arc                        vdk_hs38_defconfig
mips                           rs90_defconfig
powerpc                     sequoia_defconfig
powerpc                     taishan_defconfig
alpha                               defconfig
mips                      maltaaprp_defconfig
arm                       imx_v4_v5_defconfig
arm                     am200epdkit_defconfig
powerpc                        cell_defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
