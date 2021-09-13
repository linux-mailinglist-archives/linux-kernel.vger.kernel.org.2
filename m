Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F68C409D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbhIMTkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242843AbhIMTkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:40:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 446036023D;
        Mon, 13 Sep 2021 19:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631561973;
        bh=h+xKNSWKBtW2OXy/RwC+JbsGfR2JUGGxejlJ590TlEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BN9SqLha5BpGmkQnQt59+Evb4pVqvHz0ZyLqF6IHeYaUDUKxKnLPvWtT98fd6UMtA
         1DaPl1kDhLriXQm4mPyRkjma8PEFYfrKFliQb0ChToOGuPCGDZ6LRTKiTNwNraFIDN
         jhHIyIFRXuRHEje+Tk4FvPhtHtoMSriGeJEaHojKtNRZBEGmutV/f5Z+SCEFoFG3Zf
         Xb+/GiFYNkTwaDRaXc+Up+Q644nhFPw7KyMiLnBUYa6W5oFpl5G+IOd8mdPoC1L0mC
         WlQIAaJyMf9fSK3CS6McmDEVX2uMEYnq8fHv3y04ZVoQf7BNMCkbsTCIYvRpTxqR2z
         cryP8OhXD65cA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH 2/3] habanalabs: enable power info via HWMON framework
Date:   Mon, 13 Sep 2021 22:39:25 +0300
Message-Id: <20210913193926.17329-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210913193926.17329-1-ogabbay@kernel.org>
References: <20210913193926.17329-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajaravi Krishna Katta <rkatta@habana.ai>

Add support to retrieve following power info via HWMON:
- instantaneous power value
- highest value since last reset
- reset the highest place holder

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h   |  4 +
 drivers/misc/habanalabs/common/hwmon.c        | 94 +++++++++++++++++++
 .../misc/habanalabs/include/common/cpucp_if.h | 10 ++
 3 files changed, 108 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index bebebcb163ee..f8e23ca18a57 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2956,6 +2956,10 @@ int hl_set_voltage(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
 int hl_set_current(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
+int hl_set_power(struct hl_device *hdev,
+			int sensor_index, u32 attr, long value);
+int hl_get_power(struct hl_device *hdev,
+			int sensor_index, u32 attr, long *value);
 void hw_sob_get(struct hl_hw_sob *hw_sob);
 void hw_sob_put(struct hl_hw_sob *hw_sob);
 void hl_encaps_handle_do_release(struct kref *ref);
diff --git a/drivers/misc/habanalabs/common/hwmon.c b/drivers/misc/habanalabs/common/hwmon.c
index 8f12d99fda09..e33f65be8a00 100644
--- a/drivers/misc/habanalabs/common/hwmon.c
+++ b/drivers/misc/habanalabs/common/hwmon.c
@@ -236,6 +236,23 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		else
 			rc = hl_get_pwm_info(hdev, channel, attr, val);
 		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			cpucp_attr = CPUCP_POWER_INPUT;
+			break;
+		case hwmon_power_input_highest:
+			cpucp_attr = CPUCP_POWER_INPUT_HIGHEST;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (use_cpucp_enum)
+			rc = hl_get_power(hdev, channel, cpucp_attr, val);
+		else
+			rc = hl_get_power(hdev, channel, attr, val);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -316,6 +333,20 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 		else
 			hl_set_current(hdev, channel, attr, val);
 		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_reset_history:
+			cpucp_attr = CPUCP_POWER_RESET_INPUT_HISTORY;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (use_cpucp_enum)
+			hl_set_power(hdev, channel, cpucp_attr, val);
+		else
+			hl_set_power(hdev, channel, attr, val);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -378,6 +409,15 @@ static umode_t hl_is_visible(const void *data, enum hwmon_sensor_types type,
 			return 0644;
 		}
 		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+		case hwmon_power_input_highest:
+			return 0444;
+		case hwmon_power_reset_history:
+			return 0200;
+		}
+		break;
 	default:
 		break;
 	}
@@ -633,6 +673,60 @@ int hl_set_current(struct hl_device *hdev,
 	return rc;
 }
 
+int hl_set_power(struct hl_device *hdev,
+			int sensor_index, u32 attr, long value)
+{
+	struct cpucp_packet pkt;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_POWER_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.sensor_index = __cpu_to_le16(sensor_index);
+	pkt.type = __cpu_to_le16(attr);
+	pkt.value = __cpu_to_le64(value);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+						0, NULL);
+
+	if (rc)
+		dev_err(hdev->dev,
+			"Failed to set power of sensor %d, error %d\n",
+			sensor_index, rc);
+
+	return rc;
+}
+
+int hl_get_power(struct hl_device *hdev,
+			int sensor_index, u32 attr, long *value)
+{
+	struct cpucp_packet pkt;
+	u64 result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_POWER_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.sensor_index = __cpu_to_le16(sensor_index);
+	pkt.type = __cpu_to_le16(attr);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+						0, &result);
+
+	*value = (long) result;
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to get power of sensor %d, error %d\n",
+			sensor_index, rc);
+		*value = 0;
+	}
+
+	return rc;
+}
+
 int hl_hwmon_init(struct hl_device *hdev)
 {
 	struct device *dev = hdev->pdev ? &hdev->pdev->dev : hdev->dev;
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 9ff6a448f0d4..a6fa1cfa38a5 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -598,6 +598,16 @@ enum cpucp_pll_type_attributes {
 	cpucp_pll_pci,
 };
 
+/*
+ * cpucp_power_type aligns with hwmon_power_attributes
+ * defined in Linux kernel hwmon.h file
+ */
+enum cpucp_power_type {
+	CPUCP_POWER_INPUT = 8,
+	CPUCP_POWER_INPUT_HIGHEST = 9,
+	CPUCP_POWER_RESET_INPUT_HISTORY = 11
+};
+
 /*
  * MSI type enumeration table for all ASICs and future SW versions.
  * For future ASIC-LKD compatibility, we can only add new enumerations.
-- 
2.17.1

