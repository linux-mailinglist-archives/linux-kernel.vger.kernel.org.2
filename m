Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FE34195C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhI0OCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234721AbhI0OBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8A7861264;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751198;
        bh=/qes3qyuK4Zs9NhTtUaLSaXgSNnYNTWv6KpdjD/+gB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDhx2dBxKQFLVVa9mAmAUyOTnEhIAUxJDuGuCkDAKLmfKluxAMpiuXOtXebFuSZV/
         aH8j0bp12C4RxpgmDYC94uaQpCLaCJ1a9dtPP3bNPaMlBI2wkH0eZT7ANQnMTfcuhy
         IiCyEiJRHMkWfrCUSIO5U7V2Ws3iNQIy/qpJsd6mlzi6S+YH1gwMtMbgjED6eiF1vV
         s/nnunRaWNbR5SkxERV6blOTo2szpcGNuZmFS+P676Gf9z/w6KKkv6UK/S+2EAshPU
         qgSMgRpzyCPFxIhZunKUfklHrEuUuPJrRUd7P10XntJV3XKGN1gdoKoBmwSilnJePZ
         cmtpslmym6kog==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAi-000AuZ-0U; Mon, 27 Sep 2021 15:59:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] ABI: sysfs-driver-ufs: Add another What for platform drivers
Date:   Mon, 27 Sep 2021 15:59:49 +0200
Message-Id: <bc61469964bbcabe38d12aa88f2734d38a8741e5.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current what expressions:
	What:          /sys/bus/platform/drivers/ufshcd/*/...

Doesn't actually match what (some?) platform drivers actually
export. For instance, drivers/scsi/ufs/ufs-hisi.c actually
creates the sysfs struct for ufshcd inside this directory:

	/sys/devices/platform/soc/ff3c0000.ufs

Which has those aliases:

	/sys/devices/virtual/devlink/platform:fff35000.crg_ctrl--platform:ff3c0000.ufs/consumer/
	/sys/bus/platform/drivers/ufshcd-hisi/ff3c0000.ufs/
	/sys/bus/platform/devices/soc/ff3c0000.ufs/
	/sys/bus/platform/devices/ff3c0000.ufs/

So, add another What: for such files that will match the
device ufs entries, e. g.:

	What:          /sys/bus/platform/devices/*.ufs/

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-driver-ufs | 126 +++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index ec3a7149ced5..863cc4897277 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -13,6 +13,7 @@ Description:
 		Interface specification for more details.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/device_type
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/device_type
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the device type. This is one of the UFS
@@ -22,6 +23,7 @@ Description:	This file shows the device type. This is one of the UFS
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/device_class
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/device_class
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the device class. This is one of the UFS
@@ -31,6 +33,7 @@ Description:	This file shows the device class. This is one of the UFS
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/device_sub_class
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/device_sub_class
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the UFS storage subclass. This is one of
@@ -40,6 +43,7 @@ Description:	This file shows the UFS storage subclass. This is one of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/protocol
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/protocol
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the protocol supported by an UFS device.
@@ -50,6 +54,7 @@ Description:	This file shows the protocol supported by an UFS device.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/number_of_luns
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/number_of_luns
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows number of logical units. This is one of
@@ -59,6 +64,7 @@ Description:	This file shows number of logical units. This is one of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/number_of_wluns
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/number_of_wluns
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows number of well known logical units.
@@ -69,6 +75,7 @@ Description:	This file shows number of well known logical units.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/boot_enable
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/boot_enable
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows value that indicates whether the device is
@@ -79,6 +86,7 @@ Description:	This file shows value that indicates whether the device is
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/descriptor_access_enable
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/descriptor_access_enable
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows value that indicates whether the device
@@ -90,6 +98,7 @@ Description:	This file shows value that indicates whether the device
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/initial_power_mode
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/initial_power_mode
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows value that defines the power mode after
@@ -100,6 +109,7 @@ Description:	This file shows value that defines the power mode after
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/high_priority_lun
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/high_priority_lun
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the high priority lun. This is one of
@@ -109,6 +119,7 @@ Description:	This file shows the high priority lun. This is one of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/secure_removal_type
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/secure_removal_type
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the secure removal type. This is one of
@@ -118,6 +129,7 @@ Description:	This file shows the secure removal type. This is one of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/support_security_lun
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/support_security_lun
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether the security lun is supported.
@@ -128,6 +140,7 @@ Description:	This file shows whether the security lun is supported.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/bkops_termination_latency
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/bkops_termination_latency
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the background operations termination
@@ -138,6 +151,7 @@ Description:	This file shows the background operations termination
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/initial_active_icc_level
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/initial_active_icc_level
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the initial active ICC level. This is one
@@ -147,6 +161,7 @@ Description:	This file shows the initial active ICC level. This is one
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/specification_version
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/specification_version
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the specification version. This is one
@@ -156,6 +171,7 @@ Description:	This file shows the specification version. This is one
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/manufacturing_date
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/manufacturing_date
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the manufacturing date in BCD format.
@@ -166,6 +182,7 @@ Description:	This file shows the manufacturing date in BCD format.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/manufacturer_id
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/manufacturer_id
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the manufacturer ID. This is one of the
@@ -175,6 +192,7 @@ Description:	This file shows the manufacturer ID. This is one of the
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/rtt_capability
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/rtt_capability
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum number of outstanding RTTs
@@ -185,6 +203,7 @@ Description:	This file shows the maximum number of outstanding RTTs
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/rtc_update
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/rtc_update
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the frequency and method of the realtime
@@ -195,6 +214,7 @@ Description:	This file shows the frequency and method of the realtime
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/ufs_features
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/ufs_features
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows which features are supported by the device.
@@ -205,6 +225,7 @@ Description:	This file shows which features are supported by the device.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/ffu_timeout
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/ffu_timeout
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the FFU timeout. This is one of the
@@ -214,6 +235,7 @@ Description:	This file shows the FFU timeout. This is one of the
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/queue_depth
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/queue_depth
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the device queue depth. This is one of the
@@ -223,6 +245,7 @@ Description:	This file shows the device queue depth. This is one of the
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/device_version
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/device_version
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the device version. This is one of the
@@ -232,6 +255,7 @@ Description:	This file shows the device version. This is one of the
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/number_of_secure_wpa
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/number_of_secure_wpa
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows number of secure write protect areas
@@ -242,6 +266,7 @@ Description:	This file shows number of secure write protect areas
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/psa_max_data_size
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/psa_max_data_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum amount of data that may be
@@ -253,6 +278,7 @@ Description:	This file shows the maximum amount of data that may be
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/psa_state_timeout
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/psa_state_timeout
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the command maximum timeout for a change
@@ -264,6 +290,7 @@ Description:	This file shows the command maximum timeout for a change
 
 
 What:		/sys/bus/platform/drivers/ufshcd/*/interconnect_descriptor/unipro_version
+What:		/sys/bus/platform/devices/*.ufs/interconnect_descriptor/unipro_version
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the MIPI UniPro version number in BCD format.
@@ -274,6 +301,7 @@ Description:	This file shows the MIPI UniPro version number in BCD format.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/interconnect_descriptor/mphy_version
+What:		/sys/bus/platform/devices/*.ufs/interconnect_descriptor/mphy_version
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the MIPI M-PHY version number in BCD format.
@@ -285,6 +313,7 @@ Description:	This file shows the MIPI M-PHY version number in BCD format.
 
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/raw_device_capacity
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/raw_device_capacity
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the total memory quantity available to
@@ -296,6 +325,7 @@ Description:	This file shows the total memory quantity available to
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/max_number_of_luns
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/max_number_of_luns
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum number of logical units
@@ -306,6 +336,7 @@ Description:	This file shows the maximum number of logical units
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/segment_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/segment_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the segment size. This is one of the UFS
@@ -315,6 +346,7 @@ Description:	This file shows the segment size. This is one of the UFS
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/allocation_unit_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/allocation_unit_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the allocation unit size. This is one of
@@ -324,6 +356,7 @@ Description:	This file shows the allocation unit size. This is one of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/min_addressable_block_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/min_addressable_block_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the minimum addressable block size. This
@@ -334,6 +367,7 @@ Description:	This file shows the minimum addressable block size. This
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/optimal_read_block_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/optimal_read_block_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the optimal read block size. This is one
@@ -344,6 +378,7 @@ Description:	This file shows the optimal read block size. This is one
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/optimal_write_block_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/optimal_write_block_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the optimal write block size. This is one
@@ -354,6 +389,7 @@ Description:	This file shows the optimal write block size. This is one
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/max_in_buffer_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/max_in_buffer_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum data-in buffer size. This
@@ -364,6 +400,7 @@ Description:	This file shows the maximum data-in buffer size. This
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/max_out_buffer_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/max_out_buffer_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum data-out buffer size. This
@@ -374,6 +411,7 @@ Description:	This file shows the maximum data-out buffer size. This
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/rpmb_rw_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/rpmb_rw_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum number of RPMB frames allowed
@@ -384,6 +422,7 @@ Description:	This file shows the maximum number of RPMB frames allowed
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/dyn_capacity_resource_policy
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/dyn_capacity_resource_policy
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the dynamic capacity resource policy. This
@@ -394,6 +433,7 @@ Description:	This file shows the dynamic capacity resource policy. This
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/data_ordering
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/data_ordering
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows support for out-of-order data transfer.
@@ -404,6 +444,7 @@ Description:	This file shows support for out-of-order data transfer.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/max_number_of_contexts
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/max_number_of_contexts
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows maximum available number of contexts which
@@ -414,6 +455,7 @@ Description:	This file shows maximum available number of contexts which
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/sys_data_tag_unit_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/sys_data_tag_unit_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows system data tag unit size. This is one of
@@ -423,6 +465,7 @@ Description:	This file shows system data tag unit size. This is one of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/sys_data_tag_resource_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/sys_data_tag_resource_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows maximum storage area size allocated by
@@ -434,6 +477,7 @@ Description:	This file shows maximum storage area size allocated by
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/secure_removal_types
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/secure_removal_types
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows supported secure removal types. This is
@@ -444,6 +488,7 @@ Description:	This file shows supported secure removal types. This is
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/memory_types
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/memory_types
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows supported memory types. This is one of
@@ -454,6 +499,7 @@ Description:	This file shows supported memory types. This is one of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/*_memory_max_alloc_units
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/*_memory_max_alloc_units
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum number of allocation units for
@@ -465,6 +511,7 @@ Description:	This file shows the maximum number of allocation units for
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/*_memory_capacity_adjustment_factor
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/*_memory_capacity_adjustment_factor
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the memory capacity adjustment factor for
@@ -477,6 +524,7 @@ Description:	This file shows the memory capacity adjustment factor for
 
 
 What:		/sys/bus/platform/drivers/ufshcd/*/health_descriptor/eol_info
+What:		/sys/bus/platform/devices/*.ufs/health_descriptor/eol_info
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows preend of life information. This is one
@@ -487,6 +535,7 @@ Description:	This file shows preend of life information. This is one
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/health_descriptor/life_time_estimation_a
+What:		/sys/bus/platform/devices/*.ufs/health_descriptor/life_time_estimation_a
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows indication of the device life time
@@ -497,6 +546,7 @@ Description:	This file shows indication of the device life time
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/health_descriptor/life_time_estimation_b
+What:		/sys/bus/platform/devices/*.ufs/health_descriptor/life_time_estimation_b
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows indication of the device life time
@@ -508,6 +558,7 @@ Description:	This file shows indication of the device life time
 
 
 What:		/sys/bus/platform/drivers/ufshcd/*/power_descriptor/active_icc_levels_vcc*
+What:		/sys/bus/platform/devices/*.ufs/power_descriptor/active_icc_levels_vcc*
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows maximum VCC, VCCQ and VCCQ2 value for
@@ -519,6 +570,7 @@ Description:	This file shows maximum VCC, VCCQ and VCCQ2 value for
 
 
 What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/manufacturer_name
+What:		/sys/bus/platform/devices/*.ufs/string_descriptors/manufacturer_name
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file contains a device manufacturer name string.
@@ -528,6 +580,7 @@ Description:	This file contains a device manufacturer name string.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/product_name
+What:		/sys/bus/platform/devices/*.ufs/string_descriptors/product_name
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file contains a product name string. The full information
@@ -536,6 +589,7 @@ Description:	This file contains a product name string. The full information
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/oem_id
+What:		/sys/bus/platform/devices/*.ufs/string_descriptors/oem_id
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file contains a OEM ID string. The full information
@@ -544,6 +598,7 @@ Description:	This file contains a OEM ID string. The full information
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/serial_number
+What:		/sys/bus/platform/devices/*.ufs/string_descriptors/serial_number
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file contains a device serial number string. The full
@@ -553,6 +608,7 @@ Description:	This file contains a device serial number string. The full
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/product_revision
+What:		/sys/bus/platform/devices/*.ufs/string_descriptors/product_revision
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file contains a product revision string. The full
@@ -684,6 +740,7 @@ Description:	This file shows the granularity of the LUN. This is one of
 
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/device_init
+What:		/sys/bus/platform/devices/*.ufs/flags/device_init
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the device init status. The full information
@@ -692,6 +749,7 @@ Description:	This file shows the device init status. The full information
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/permanent_wpe
+What:		/sys/bus/platform/devices/*.ufs/flags/permanent_wpe
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether permanent write protection is enabled.
@@ -701,6 +759,7 @@ Description:	This file shows whether permanent write protection is enabled.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/power_on_wpe
+What:		/sys/bus/platform/devices/*.ufs/flags/power_on_wpe
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether write protection is enabled on all
@@ -711,6 +770,7 @@ Description:	This file shows whether write protection is enabled on all
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/bkops_enable
+What:		/sys/bus/platform/devices/*.ufs/flags/bkops_enable
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether the device background operations are
@@ -720,6 +780,7 @@ Description:	This file shows whether the device background operations are
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/life_span_mode_enable
+What:		/sys/bus/platform/devices/*.ufs/flags/life_span_mode_enable
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether the device life span mode is enabled.
@@ -729,6 +790,7 @@ Description:	This file shows whether the device life span mode is enabled.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/phy_resource_removal
+What:		/sys/bus/platform/devices/*.ufs/flags/phy_resource_removal
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether physical resource removal is enable.
@@ -738,6 +800,7 @@ Description:	This file shows whether physical resource removal is enable.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/busy_rtc
+What:		/sys/bus/platform/devices/*.ufs/flags/busy_rtc
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether the device is executing internal
@@ -747,6 +810,7 @@ Description:	This file shows whether the device is executing internal
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/disable_fw_update
+What:		/sys/bus/platform/devices/*.ufs/flags/disable_fw_update
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether the device FW update is permanently
@@ -757,6 +821,7 @@ Description:	This file shows whether the device FW update is permanently
 
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/boot_lun_enabled
+What:		/sys/bus/platform/devices/*.ufs/attributes/boot_lun_enabled
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the boot lun enabled UFS device attribute.
@@ -766,6 +831,7 @@ Description:	This file provides the boot lun enabled UFS device attribute.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/current_power_mode
+What:		/sys/bus/platform/devices/*.ufs/attributes/current_power_mode
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the current power mode UFS device attribute.
@@ -775,6 +841,7 @@ Description:	This file provides the current power mode UFS device attribute.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/active_icc_level
+What:		/sys/bus/platform/devices/*.ufs/attributes/active_icc_level
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the active icc level UFS device attribute.
@@ -784,6 +851,7 @@ Description:	This file provides the active icc level UFS device attribute.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/ooo_data_enabled
+What:		/sys/bus/platform/devices/*.ufs/attributes/ooo_data_enabled
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the out of order data transfer enabled UFS
@@ -793,6 +861,7 @@ Description:	This file provides the out of order data transfer enabled UFS
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/bkops_status
+What:		/sys/bus/platform/devices/*.ufs/attributes/bkops_status
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the background operations status UFS device
@@ -802,6 +871,7 @@ Description:	This file provides the background operations status UFS device
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/purge_status
+What:		/sys/bus/platform/devices/*.ufs/attributes/purge_status
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the purge operation status UFS device
@@ -811,6 +881,7 @@ Description:	This file provides the purge operation status UFS device
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_in_size
+What:		/sys/bus/platform/devices/*.ufs/attributes/max_data_in_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum data size in a DATA IN
@@ -820,6 +891,7 @@ Description:	This file shows the maximum data size in a DATA IN
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_out_size
+What:		/sys/bus/platform/devices/*.ufs/attributes/max_data_out_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum number of bytes that can be
@@ -829,6 +901,7 @@ Description:	This file shows the maximum number of bytes that can be
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/reference_clock_frequency
+What:		/sys/bus/platform/devices/*.ufs/attributes/reference_clock_frequency
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the reference clock frequency UFS device
@@ -838,6 +911,7 @@ Description:	This file provides the reference clock frequency UFS device
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/configuration_descriptor_lock
+What:		/sys/bus/platform/devices/*.ufs/attributes/configuration_descriptor_lock
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether the configuration descriptor is locked.
@@ -845,6 +919,7 @@ Description:	This file shows whether the configuration descriptor is locked.
 		UFS specifications 2.1. The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_number_of_rtt
+What:		/sys/bus/platform/devices/*.ufs/attributes/max_number_of_rtt
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the maximum current number of
@@ -855,6 +930,7 @@ Description:	This file provides the maximum current number of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/exception_event_control
+What:		/sys/bus/platform/devices/*.ufs/attributes/exception_event_control
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the exception event control UFS device
@@ -864,6 +940,7 @@ Description:	This file provides the exception event control UFS device
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/exception_event_status
+What:		/sys/bus/platform/devices/*.ufs/attributes/exception_event_status
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the exception event status UFS device
@@ -873,6 +950,7 @@ Description:	This file provides the exception event status UFS device
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/ffu_status
+What:		/sys/bus/platform/devices/*.ufs/attributes/ffu_status
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the ffu status UFS device attribute.
@@ -882,6 +960,7 @@ Description:	This file provides the ffu status UFS device attribute.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/psa_state
+What:		/sys/bus/platform/devices/*.ufs/attributes/psa_state
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file show the PSA feature status. The full information
@@ -890,6 +969,7 @@ Description:	This file show the PSA feature status. The full information
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/psa_data_size
+What:		/sys/bus/platform/devices/*.ufs/attributes/psa_data_size
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the amount of data that the host plans to
@@ -912,6 +992,7 @@ Description:	This file shows the The amount of physical memory needed
 
 
 What:		/sys/bus/platform/drivers/ufshcd/*/rpm_lvl
+What:		/sys/bus/platform/devices/*.ufs/rpm_lvl
 Date:		September 2014
 Contact:	Subhash Jadavani <subhashj@codeaurora.org>
 Description:	This entry could be used to set or show the UFS device
@@ -938,6 +1019,7 @@ Description:	This entry could be used to set or show the UFS device
 		==  ====================================================
 
 What:		/sys/bus/platform/drivers/ufshcd/*/rpm_target_dev_state
+What:		/sys/bus/platform/devices/*.ufs/rpm_target_dev_state
 Date:		February 2018
 Contact:	Subhash Jadavani <subhashj@codeaurora.org>
 Description:	This entry shows the target power mode of an UFS device
@@ -946,6 +1028,7 @@ Description:	This entry shows the target power mode of an UFS device
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/rpm_target_link_state
+What:		/sys/bus/platform/devices/*.ufs/rpm_target_link_state
 Date:		February 2018
 Contact:	Subhash Jadavani <subhashj@codeaurora.org>
 Description:	This entry shows the target state of an UFS UIC link
@@ -954,6 +1037,7 @@ Description:	This entry shows the target state of an UFS UIC link
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/spm_lvl
+What:		/sys/bus/platform/devices/*.ufs/spm_lvl
 Date:		September 2014
 Contact:	Subhash Jadavani <subhashj@codeaurora.org>
 Description:	This entry could be used to set or show the UFS device
@@ -980,6 +1064,7 @@ Description:	This entry could be used to set or show the UFS device
 		==  ====================================================
 
 What:		/sys/bus/platform/drivers/ufshcd/*/spm_target_dev_state
+What:		/sys/bus/platform/devices/*.ufs/spm_target_dev_state
 Date:		February 2018
 Contact:	Subhash Jadavani <subhashj@codeaurora.org>
 Description:	This entry shows the target power mode of an UFS device
@@ -988,6 +1073,7 @@ Description:	This entry shows the target power mode of an UFS device
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/spm_target_link_state
+What:		/sys/bus/platform/devices/*.ufs/spm_target_link_state
 Date:		February 2018
 Contact:	Subhash Jadavani <subhashj@codeaurora.org>
 Description:	This entry shows the target state of an UFS UIC link
@@ -996,6 +1082,7 @@ Description:	This entry shows the target state of an UFS UIC link
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/monitor_enable
+What:		/sys/bus/platform/devices/*.ufs/monitor/monitor_enable
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows the status of performance monitor enablement
@@ -1003,6 +1090,7 @@ Description:	This file shows the status of performance monitor enablement
 		is stopped, the performance data collected is also cleared.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/monitor_chunk_size
+What:		/sys/bus/platform/devices/*.ufs/monitor/monitor_chunk_size
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file tells the monitor to focus on requests transferring
@@ -1010,6 +1098,7 @@ Description:	This file tells the monitor to focus on requests transferring
 		It can only be changed when monitor is disabled.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_total_sectors
+What:		/sys/bus/platform/devices/*.ufs/monitor/read_total_sectors
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows how many sectors (in 512 Bytes) have been
@@ -1018,6 +1107,7 @@ Description:	This file shows how many sectors (in 512 Bytes) have been
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_total_busy
+What:		/sys/bus/platform/devices/*.ufs/monitor/read_total_busy
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows how long (in micro seconds) has been spent
@@ -1026,6 +1116,7 @@ Description:	This file shows how long (in micro seconds) has been spent
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_nr_requests
+What:		/sys/bus/platform/devices/*.ufs/monitor/read_nr_requests
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows how many read requests have been sent after
@@ -1034,6 +1125,7 @@ Description:	This file shows how many read requests have been sent after
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_max
+What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_max
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows the maximum latency (in micro seconds) of
@@ -1042,6 +1134,7 @@ Description:	This file shows the maximum latency (in micro seconds) of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_min
+What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_min
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows the minimum latency (in micro seconds) of
@@ -1050,6 +1143,7 @@ Description:	This file shows the minimum latency (in micro seconds) of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_avg
+What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_avg
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows the average latency (in micro seconds) of
@@ -1058,6 +1152,7 @@ Description:	This file shows the average latency (in micro seconds) of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_sum
+What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_sum
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows the total latency (in micro seconds) of
@@ -1066,6 +1161,7 @@ Description:	This file shows the total latency (in micro seconds) of
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_total_sectors
+What:		/sys/bus/platform/devices/*.ufs/monitor/write_total_sectors
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows how many sectors (in 512 Bytes) have been sent
@@ -1074,6 +1170,7 @@ Description:	This file shows how many sectors (in 512 Bytes) have been sent
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_total_busy
+What:		/sys/bus/platform/devices/*.ufs/monitor/write_total_busy
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows how long (in micro seconds) has been spent
@@ -1082,6 +1179,7 @@ Description:	This file shows how long (in micro seconds) has been spent
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_nr_requests
+What:		/sys/bus/platform/devices/*.ufs/monitor/write_nr_requests
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows how many write requests have been sent after
@@ -1090,6 +1188,7 @@ Description:	This file shows how many write requests have been sent after
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_max
+What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_max
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows the maximum latency (in micro seconds) of write
@@ -1098,6 +1197,7 @@ Description:	This file shows the maximum latency (in micro seconds) of write
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_min
+What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_min
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows the minimum latency (in micro seconds) of write
@@ -1106,6 +1206,7 @@ Description:	This file shows the minimum latency (in micro seconds) of write
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_avg
+What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_avg
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows the average latency (in micro seconds) of write
@@ -1114,6 +1215,7 @@ Description:	This file shows the average latency (in micro seconds) of write
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_sum
+What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_sum
 Date:		January 2021
 Contact:	Can Guo <cang@codeaurora.org>
 Description:	This file shows the total latency (in micro seconds) of write
@@ -1122,6 +1224,7 @@ Description:	This file shows the total latency (in micro seconds) of write
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_presv_us_en
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_presv_us_en
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows if preserve user-space was configured
@@ -1129,6 +1232,7 @@ Description:	This entry shows if preserve user-space was configured
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_shared_alloc_units
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_shared_alloc_units
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows the shared allocated units of WB buffer
@@ -1136,6 +1240,7 @@ Description:	This entry shows the shared allocated units of WB buffer
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_type
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_type
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows the configured WB type.
@@ -1144,6 +1249,7 @@ Description:	This entry shows the configured WB type.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_buff_cap_adj
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_buff_cap_adj
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows the total user-space decrease in shared
@@ -1154,6 +1260,7 @@ Description:	This entry shows the total user-space decrease in shared
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_max_alloc_units
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_max_alloc_units
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows the Maximum total WriteBooster Buffer size
@@ -1162,6 +1269,7 @@ Description:	This entry shows the Maximum total WriteBooster Buffer size
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_max_wb_luns
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_max_wb_luns
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows the maximum number of luns that can support
@@ -1170,6 +1278,7 @@ Description:	This entry shows the maximum number of luns that can support
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_sup_red_type
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_sup_red_type
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	The supportability of user space reduction mode
@@ -1184,6 +1293,7 @@ Description:	The supportability of user space reduction mode
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_sup_wb_type
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_sup_wb_type
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	The supportability of WriteBooster Buffer type.
@@ -1198,6 +1308,7 @@ Description:	The supportability of WriteBooster Buffer type.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/wb_enable
+What:		/sys/bus/platform/devices/*.ufs/flags/wb_enable
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows the status of WriteBooster.
@@ -1210,6 +1321,7 @@ Description:	This entry shows the status of WriteBooster.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/wb_flush_en
+What:		/sys/bus/platform/devices/*.ufs/flags/wb_flush_en
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows if flush is enabled.
@@ -1222,6 +1334,7 @@ Description:	This entry shows if flush is enabled.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/wb_flush_during_h8
+What:		/sys/bus/platform/devices/*.ufs/flags/wb_flush_during_h8
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	Flush WriteBooster Buffer during hibernate state.
@@ -1236,6 +1349,7 @@ Description:	Flush WriteBooster Buffer during hibernate state.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_avail_buf
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_avail_buf
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows the amount of unused WriteBooster buffer
@@ -1244,6 +1358,7 @@ Description:	This entry shows the amount of unused WriteBooster buffer
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_cur_buf
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_cur_buf
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows the amount of unused current buffer.
@@ -1251,6 +1366,7 @@ Description:	This entry shows the amount of unused current buffer.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_flush_status
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_flush_status
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows the flush operation status.
@@ -1267,6 +1383,7 @@ Description:	This entry shows the flush operation status.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_life_time_est
+What:		/sys/bus/platform/devices/*.ufs/attributes/wb_life_time_est
 Date:		June 2020
 Contact:	Asutosh Das <asutoshd@codeaurora.org>
 Description:	This entry shows an indication of the WriteBooster Buffer
@@ -1289,6 +1406,7 @@ Description:	This entry shows the configured size of WriteBooster buffer.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/wb_on
+What:		/sys/bus/platform/devices/*.ufs/wb_on
 Date:		January 2021
 Contact:	Bean Huo <beanhuo@micron.com>
 Description:	This node is used to set or display whether UFS WriteBooster is
@@ -1300,6 +1418,7 @@ Description:	This node is used to set or display whether UFS WriteBooster is
 		disable/enable WriteBooster through this sysfs node.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/hpb_version
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/hpb_version
 Date:		June 2021
 Contact:	Daejun Park <daejun7.park@samsung.com>
 Description:	This entry shows the HPB specification version.
@@ -1310,6 +1429,7 @@ Description:	This entry shows the HPB specification version.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/hpb_control
+What:		/sys/bus/platform/devices/*.ufs/device_descriptor/hpb_control
 Date:		June 2021
 Contact:	Daejun Park <daejun7.park@samsung.com>
 Description:	This entry shows an indication of the HPB control mode.
@@ -1319,6 +1439,7 @@ Description:	This entry shows an indication of the HPB control mode.
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_region_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/hpb_region_size
 Date:		June 2021
 Contact:	Daejun Park <daejun7.park@samsung.com>
 Description:	This entry shows the bHPBRegionSize which can be calculated
@@ -1328,6 +1449,7 @@ Description:	This entry shows the bHPBRegionSize which can be calculated
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_number_lu
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/hpb_number_lu
 Date:		June 2021
 Contact:	Daejun Park <daejun7.park@samsung.com>
 Description:	This entry shows the maximum number of HPB LU supported	by
@@ -1338,6 +1460,7 @@ Description:	This entry shows the maximum number of HPB LU supported	by
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_subregion_size
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/hpb_subregion_size
 Date:		June 2021
 Contact:	Daejun Park <daejun7.park@samsung.com>
 Description:	This entry shows the bHPBSubRegionSize, which can be
@@ -1349,6 +1472,7 @@ Description:	This entry shows the bHPBSubRegionSize, which can be
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_max_active_regions
+What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/hpb_max_active_regions
 Date:		June 2021
 Contact:	Daejun Park <daejun7.park@samsung.com>
 Description:	This entry shows the maximum number of active HPB regions that
@@ -1434,6 +1558,7 @@ Description:	This entry shows the requeue timeout threshold for write buffer
 		this entry.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_size_hpb_single_cmd
+What:		/sys/bus/platform/devices/*.ufs/attributes/max_data_size_hpb_single_cmd
 Date:		June 2021
 Contact:	Daejun Park <daejun7.park@samsung.com>
 Description:	This entry shows the maximum HPB data size for using a single HPB
@@ -1450,6 +1575,7 @@ Description:	This entry shows the maximum HPB data size for using a single HPB
 		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/hpb_enable
+What:		/sys/bus/platform/devices/*.ufs/flags/hpb_enable
 Date:		June 2021
 Contact:	Daejun Park <daejun7.park@samsung.com>
 Description:	This entry shows the status of HPB.
-- 
2.31.1

