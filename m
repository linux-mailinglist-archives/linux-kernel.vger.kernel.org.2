Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FE5407BF7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 07:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhILF2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 01:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233171AbhILF2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 01:28:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31656610A3;
        Sun, 12 Sep 2021 05:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631424411;
        bh=2y2mdc5NowJsG8D9vmfWPhxUxWEAOlfcnkhHxyBZqyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgUdwM6cyD7t81pBaLNSohozqJ8kYG2BUrhrrBGJSqumzDWuwqNwgnXZ+qYOa2DOE
         EhHGLaRpboljHzO5XS2KXtRwMPFD0uNrEMGB/hA1SD3Fl/VW9kh6/iNaSIGypilbFf
         a/84YKJPiwESX7fbzkJw8LLSom2sKL9wyvqnWMwM26MSkY6JO0HahStm1yMehiZQVq
         9DteX8kgvoLmy5WnUJbIxcExpm5MU/Lre+KVPJz+Y1FKkvNjnYCMQDXS/eNX17uine
         UR/ZM1MxYealnpBGgc1Y5mV8GlhpXLji87OpY81NbXdDrFTKYHc5UuA74tHnb+1IbM
         talwoGew/kcyg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH 2/2] habanalabs: create static map of f/w hwmon enums
Date:   Sun, 12 Sep 2021 08:26:45 +0300
Message-Id: <20210912052645.104082-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210912052645.104082-1-ogabbay@kernel.org>
References: <20210912052645.104082-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajaravi Krishna Katta <rkatta@habana.ai>

Instead of using the Linux kernel HWMON enums definition when
communicating with the firmware, use proprietary HWMON based enums
i.e. map hwmon.h header enum to cpucp_if.h based enum while.

This is needed because the HWMON enums are not forcing backward
compatibility and therefore changes can break compatibility between
newer driver and older firmware.

The driver will check for CPU_BOOT_DEV_STS0_MAP_HWMON_EN bit to
validate if f/w supports cpucp->hwmon enum mapping to support older
firmware where this mapping won't be available.

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/hwmon.c        | 100 ++++++++++++++++--
 .../habanalabs/include/common/hl_boot_if.h    |   6 ++
 2 files changed, 97 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/hwmon.c b/drivers/misc/habanalabs/common/hwmon.c
index 6b421d76b311..8f12d99fda09 100644
--- a/drivers/misc/habanalabs/common/hwmon.c
+++ b/drivers/misc/habanalabs/common/hwmon.c
@@ -113,6 +113,9 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	int rc;
+	u32 cpucp_attr;
+	bool use_cpucp_enum = (hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
+				CPU_BOOT_DEV_STS0_MAP_HWMON_EN) ? true : false;
 
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
@@ -121,65 +124,117 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_input:
+			cpucp_attr = cpucp_temp_input;
+			break;
 		case hwmon_temp_max:
+			cpucp_attr = cpucp_temp_max;
+			break;
 		case hwmon_temp_crit:
+			cpucp_attr = cpucp_temp_crit;
+			break;
 		case hwmon_temp_max_hyst:
+			cpucp_attr = cpucp_temp_max_hyst;
+			break;
 		case hwmon_temp_crit_hyst:
+			cpucp_attr = cpucp_temp_crit_hyst;
+			break;
 		case hwmon_temp_offset:
+			cpucp_attr = cpucp_temp_offset;
+			break;
 		case hwmon_temp_highest:
+			cpucp_attr = cpucp_temp_highest;
 			break;
 		default:
 			return -EINVAL;
 		}
 
-		rc = hl_get_temperature(hdev, channel, attr, val);
+		if (use_cpucp_enum)
+			rc = hl_get_temperature(hdev, channel, cpucp_attr, val);
+		else
+			rc = hl_get_temperature(hdev, channel, attr, val);
 		break;
 	case hwmon_in:
 		switch (attr) {
 		case hwmon_in_input:
+			cpucp_attr = cpucp_in_input;
+			break;
 		case hwmon_in_min:
+			cpucp_attr = cpucp_in_min;
+			break;
 		case hwmon_in_max:
+			cpucp_attr = cpucp_in_max;
+			break;
 		case hwmon_in_highest:
+			cpucp_attr = cpucp_in_highest;
 			break;
 		default:
 			return -EINVAL;
 		}
 
-		rc = hl_get_voltage(hdev, channel, attr, val);
+		if (use_cpucp_enum)
+			rc = hl_get_voltage(hdev, channel, cpucp_attr, val);
+		else
+			rc = hl_get_voltage(hdev, channel, attr, val);
 		break;
 	case hwmon_curr:
 		switch (attr) {
 		case hwmon_curr_input:
+			cpucp_attr = cpucp_curr_input;
+			break;
 		case hwmon_curr_min:
+			cpucp_attr = cpucp_curr_min;
+			break;
 		case hwmon_curr_max:
+			cpucp_attr = cpucp_curr_max;
+			break;
 		case hwmon_curr_highest:
+			cpucp_attr = cpucp_curr_highest;
 			break;
 		default:
 			return -EINVAL;
 		}
 
-		rc = hl_get_current(hdev, channel, attr, val);
+		if (use_cpucp_enum)
+			rc = hl_get_current(hdev, channel, cpucp_attr, val);
+		else
+			rc = hl_get_current(hdev, channel, attr, val);
 		break;
 	case hwmon_fan:
 		switch (attr) {
 		case hwmon_fan_input:
+			cpucp_attr = cpucp_fan_input;
+			break;
 		case hwmon_fan_min:
+			cpucp_attr = cpucp_fan_min;
+			break;
 		case hwmon_fan_max:
+			cpucp_attr = cpucp_fan_max;
 			break;
 		default:
 			return -EINVAL;
 		}
-		rc = hl_get_fan_speed(hdev, channel, attr, val);
+
+		if (use_cpucp_enum)
+			rc = hl_get_fan_speed(hdev, channel, cpucp_attr, val);
+		else
+			rc = hl_get_fan_speed(hdev, channel, attr, val);
 		break;
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
+			cpucp_attr = cpucp_pwm_input;
+			break;
 		case hwmon_pwm_enable:
+			cpucp_attr = cpucp_pwm_enable;
 			break;
 		default:
 			return -EINVAL;
 		}
-		rc = hl_get_pwm_info(hdev, channel, attr, val);
+
+		if (use_cpucp_enum)
+			rc = hl_get_pwm_info(hdev, channel, cpucp_attr, val);
+		else
+			rc = hl_get_pwm_info(hdev, channel, attr, val);
 		break;
 	default:
 		return -EINVAL;
@@ -191,6 +246,9 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long val)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
+	u32 cpucp_attr;
+	bool use_cpucp_enum = (hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
+				CPU_BOOT_DEV_STS0_MAP_HWMON_EN) ? true : false;
 
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
@@ -199,40 +257,64 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_offset:
+			cpucp_attr = cpucp_temp_offset;
+			break;
 		case hwmon_temp_reset_history:
+			cpucp_attr = cpucp_temp_reset_history;
 			break;
 		default:
 			return -EINVAL;
 		}
-		hl_set_temperature(hdev, channel, attr, val);
+
+		if (use_cpucp_enum)
+			hl_set_temperature(hdev, channel, cpucp_attr, val);
+		else
+			hl_set_temperature(hdev, channel, attr, val);
 		break;
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
+			cpucp_attr = cpucp_pwm_input;
+			break;
 		case hwmon_pwm_enable:
+			cpucp_attr = cpucp_pwm_enable;
 			break;
 		default:
 			return -EINVAL;
 		}
-		hl_set_pwm_info(hdev, channel, attr, val);
+
+		if (use_cpucp_enum)
+			hl_set_pwm_info(hdev, channel, cpucp_attr, val);
+		else
+			hl_set_pwm_info(hdev, channel, attr, val);
 		break;
 	case hwmon_in:
 		switch (attr) {
 		case hwmon_in_reset_history:
+			cpucp_attr = cpucp_in_reset_history;
 			break;
 		default:
 			return -EINVAL;
 		}
-		hl_set_voltage(hdev, channel, attr, val);
+
+		if (use_cpucp_enum)
+			hl_set_voltage(hdev, channel, cpucp_attr, val);
+		else
+			hl_set_voltage(hdev, channel, attr, val);
 		break;
 	case hwmon_curr:
 		switch (attr) {
 		case hwmon_curr_reset_history:
+			cpucp_attr = cpucp_curr_reset_history;
 			break;
 		default:
 			return -EINVAL;
 		}
-		hl_set_current(hdev, channel, attr, val);
+
+		if (use_cpucp_enum)
+			hl_set_current(hdev, channel, cpucp_attr, val);
+		else
+			hl_set_current(hdev, channel, attr, val);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 3099653234e4..8837925b5d85 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -252,6 +252,11 @@
  *					where a bit is set if the engine is not idle.
  *					Initialized in: linux
  *
+ * CPU_BOOT_DEV_STS0_MAP_HWMON_EN
+ *					If set, means f/w supports proprietary
+ *					HWMON enum mapping to cpucp enums.
+ *					Initialized in: linux
+ *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
  *					running FW populates the device status
@@ -287,6 +292,7 @@
 #define CPU_BOOT_DEV_STS0_FW_NIC_STAT_XPCS91_EN		(1 << 23)
 #define CPU_BOOT_DEV_STS0_FW_NIC_STAT_EXT_EN		(1 << 24)
 #define CPU_BOOT_DEV_STS0_IS_IDLE_CHECK_EN		(1 << 25)
+#define CPU_BOOT_DEV_STS0_MAP_HWMON_EN			(1 << 26)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 #define CPU_BOOT_DEV_STS1_ENABLED			(1 << 31)
 
-- 
2.17.1

