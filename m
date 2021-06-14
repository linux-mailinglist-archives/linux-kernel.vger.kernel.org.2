Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0161A3A671C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhFNMxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233772AbhFNMxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:53:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49CC4613B2;
        Mon, 14 Jun 2021 12:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623675074;
        bh=njlUunA9JxxaofCQJ7997dIHqZAoYKtnhb+4/+uVnzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bs41XM180/4al0TBSIpCvlbucS0w086GvLAa81CCPA17rouj+XXTJoEsoUPXaPN8s
         Q3z1gCJgMz+Hwog2xwV8vxtt3zzdkeyXy9gBdsSVEEbCJ3eAyWiQCqzoPLRwgjtL1g
         baL9MPGABWIEl8VjWHUI54w3T8gkz/uqFW6Gl4fZrKPBn2P9CSbRobhiBqfI6wrjPr
         M2875WxjtsvuKhxwN6jA63OEfh8CwKi0YqEFKCIlIKtv4R/Kkkwj01icFFc+0TzTNs
         FyDTal8aKcVKeClBLPNKmmfFNOJrQBky4gs7Qzh/aIypiSmCIZTloPqZWyItac/QyQ
         jln5S01VjGpdQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 7/9] habanalabs: added open_stats info ioctl
Date:   Mon, 14 Jun 2021 15:50:58 +0300
Message-Id: <20210614125100.17627-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614125100.17627-1-ogabbay@kernel.org>
References: <20210614125100.17627-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

In a system with multiple ASICs, there is a need to provide monitoring
tools with information on how long a device was opened and how many
times a device was opened.

Therefore, we add a new opcode to the INFO ioctl to provide that
information.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       |  3 +++
 drivers/misc/habanalabs/common/habanalabs.h   |  8 +++++++
 .../misc/habanalabs/common/habanalabs_drv.c   |  3 +++
 .../misc/habanalabs/common/habanalabs_ioctl.c | 21 +++++++++++++++++++
 include/uapi/misc/habanalabs.h                | 12 +++++++++++
 5 files changed, 47 insertions(+)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index e56f5170e338..37ce38d9a1a7 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -132,6 +132,9 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 		dev_warn(hdev->dev,
 			"Device is still in use because there are live CS and/or memory mappings\n");
 
+	hdev->last_open_session_duration_jif =
+		jiffies - hdev->last_successful_open_jif;
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 244fbf209d34..6c9a81c2cfe7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2137,6 +2137,11 @@ struct hl_mmu_funcs {
  *                          the error will be ignored by the driver during
  *                          device initialization. Mainly used to debug and
  *                          workaround firmware bugs
+ * @last_successful_open_jif: timestamp (jiffies) of the last successful
+ *                            device open.
+ * @last_open_session_duration_jif: duration (jiffies) of the last device open
+ *                                  session.
+ * @open_counter: number of successful device open operations.
  * @in_reset: is device in reset flow.
  * @curr_pll_profile: current PLL profile.
  * @card_type: Various ASICs have several card types. This indicates the card
@@ -2259,6 +2264,9 @@ struct hl_device {
 	u64				max_power;
 	u64				clock_gating_mask;
 	u64				boot_error_status_mask;
+	u64				last_successful_open_jif;
+	u64				last_open_session_duration_jif;
+	u64				open_counter;
 	atomic_t			in_reset;
 	enum hl_pll_frequency		curr_pll_profile;
 	enum cpucp_card_types		card_type;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 4d377a39df13..4194cda2d04c 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -187,6 +187,9 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	hl_debugfs_add_file(hpriv);
 
+	hdev->open_counter++;
+	hdev->last_successful_open_jif = jiffies;
+
 	return 0;
 
 out_err:
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 6604d30246e6..f4dda7b4acdd 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -460,6 +460,24 @@ static int power_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 		min((size_t) max_size, sizeof(power_info))) ? -EFAULT : 0;
 }
 
+static int open_stats_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	u32 max_size = args->return_size;
+	struct hl_open_stats_info open_stats_info = {0};
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	open_stats_info.last_open_period_ms = jiffies64_to_msecs(
+		hdev->last_open_session_duration_jif);
+	open_stats_info.open_counter = hdev->open_counter;
+
+	return copy_to_user(out, &open_stats_info,
+		min((size_t) max_size, sizeof(open_stats_info))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -543,6 +561,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_POWER:
 		return power_info(hpriv, args);
 
+	case HL_INFO_OPEN_STATS:
+		return open_stats_info(hpriv, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index a47485a8d411..a47a731e4527 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -313,6 +313,7 @@ enum hl_device_status {
  * HL_INFO_SYNC_MANAGER  - Retrieve sync manager info per dcore
  * HL_INFO_TOTAL_ENERGY  - Retrieve total energy consumption
  * HL_INFO_PLL_FREQUENCY - Retrieve PLL frequency
+ * HL_INFO_OPEN_STATS    - Retrieve info regarding recent device open calls
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
@@ -331,6 +332,7 @@ enum hl_device_status {
 #define HL_INFO_TOTAL_ENERGY		15
 #define HL_INFO_PLL_FREQUENCY		16
 #define HL_INFO_POWER			17
+#define HL_INFO_OPEN_STATS		18
 
 #define HL_INFO_VERSION_MAX_LEN	128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
@@ -444,6 +446,16 @@ struct hl_pll_frequency_info {
 	__u16 output[HL_PLL_NUM_OUTPUTS];
 };
 
+/**
+ * struct hl_open_stats_info - device open statistics information
+ * @open_counter: ever growing counter, increased on each successful dev open
+ * @last_open_period_ms: duration (ms) device was open last time
+ */
+struct hl_open_stats_info {
+	__u64 open_counter;
+	__u64 last_open_period_ms;
+};
+
 /**
  * struct hl_power_info - power information
  * @power: power consumption
-- 
2.25.1

