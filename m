Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C00319685
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBKXY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBKXYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:24:16 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774A4C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:23:35 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id m2so5038418pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqBCSSFJIhHF6mjcZ7fmqgxUEpSaw4N1jsjJo/ZPjGw=;
        b=TgqgZOqfrY0JD3ysR2WC3kpRZhZiISli54XzZBtMkJk4Z8Baxhn/g8GWeDejPnffaY
         lCknkxQe9p+dh6kzz3HY1yi6dVoZMgbqWx7qP+nQxIP4zIZRO7DrMx8fVNObE23QvZfH
         h7Unn/YIXPKdOqJ9QW2UDN2T5TyvV2At8nNoBQv0dWUSJK9A3KnH+T0KfBHKgDswodLV
         GyWlHRA6eLEX3hkjDwR76Kf9eFQP9QV4hzcHrnAWEhXcrOUrF6LPTtnHlHwsA2t6L55i
         1B7lBjIIXPCQNLiPOFiMbbR3IdpgPTBp6xi6c2mqBbHRwZVIdDwrfBcEPgbWe8JB9+g0
         1i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqBCSSFJIhHF6mjcZ7fmqgxUEpSaw4N1jsjJo/ZPjGw=;
        b=gCijoq1l19bwbbE2Xxk3wtnnslLOLbIpvyL+I2epx5oABuCzWxHpEE4a12GepNlyD1
         TkDlVnHkt13YvrUJmv2urRJ87cLsIWKAUzD2C9YABOUZ3MQKbQHVcqiT3M08JAnJtH4D
         K0qV386e9jJ9qpXZ1KlWEgVQ8q08tD8vrybQv8nxHeQw2E+3h0K7X2F0yQx7l5m+WzMK
         20f3SErOmVm2iMbFefEKftIMD2O4SsaqPmTjk7jHYTzEqZ4PjI7mDd5sb8zgplRK8+ny
         kiFARyu1aXZ/OvXHw2UuzxgJiREFM0k8pMkzE8j0EkIy+IbQCS9DF1SttABpbnAFe54l
         LIGA==
X-Gm-Message-State: AOAM5319svznELQmjSeZS0DK/JFS19M9earthj6A9ibzLAmIj/AZEiXu
        x1Ng6iVQWtnlpBsY4x/A5a8RODEZHNqf
X-Google-Smtp-Source: ABdhPJweNcl4d5RhhucbFAW/OiNgOVlCInhF00rKKs7TlPfX+6u2z+HzwllqmpkaeWOP+X9fO5yOOA==
X-Received: by 2002:a65:6096:: with SMTP id t22mr477353pgu.66.1613085814986;
        Thu, 11 Feb 2021 15:23:34 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id f18sm5893049pjq.53.2021.02.11.15.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:23:34 -0800 (PST)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     michal.simek@xilinx.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH v2] firmware: xilinx: Remove zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
Date:   Fri, 12 Feb 2021 08:23:12 +0900
Message-Id: <20210211232312.2082334-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zynqmp_pm_get_eemi_ops() was removed in commit 4db8180ffe7c: "Firmware: xilinx:
Remove eemi ops for fpga related APIs", but not in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE).
Any driver who want to communicate with PMC using EEMI APIs use the functions provided
for each function.
This removed zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE), and also
modify the documentation for this driver.

Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 v2: Added the comment pointed out by Michal. 

 Documentation/driver-api/xilinx/eemi.rst | 27 +-----------------------
 include/linux/firmware/xlnx-zynqmp.h     |  5 -----
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/Documentation/driver-api/xilinx/eemi.rst b/Documentation/driver-api/xilinx/eemi.rst
index 9dcbc6f18d75df..53416d25d309a8 100644
--- a/Documentation/driver-api/xilinx/eemi.rst
+++ b/Documentation/driver-api/xilinx/eemi.rst
@@ -19,32 +19,7 @@ device to issue or respond to power management requests.
 EEMI ops is a structure containing all eemi APIs supported by Zynq MPSoC.
 The zynqmp-firmware driver maintain all EEMI APIs in zynqmp_eemi_ops
 structure. Any driver who want to communicate with PMC using EEMI APIs
-can call zynqmp_pm_get_eemi_ops().
-
-Example of EEMI ops::
-
-	/* zynqmp-firmware driver maintain all EEMI APIs */
-	struct zynqmp_eemi_ops {
-		int (*get_api_version)(u32 *version);
-		int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
-	};
-
-	static const struct zynqmp_eemi_ops eemi_ops = {
-		.get_api_version = zynqmp_pm_get_api_version,
-		.query_data = zynqmp_pm_query_data,
-	};
-
-Example of EEMI ops usage::
-
-	static const struct zynqmp_eemi_ops *eemi_ops;
-	u32 ret_payload[PAYLOAD_ARG_CNT];
-	int ret;
-
-	eemi_ops = zynqmp_pm_get_eemi_ops();
-	if (IS_ERR(eemi_ops))
-		return PTR_ERR(eemi_ops);
-
-	ret = eemi_ops->query_data(qdata, ret_payload);
+use the functions provided for each function.
 
 IOCTL
 ------
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2a0da841c942f6..4ef77deaf7918c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -355,11 +355,6 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 int zynqmp_pm_set_boot_health_status(u32 value);
 #else
-static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
-{
-	return ERR_PTR(-ENODEV);
-}
-
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
 	return -ENODEV;
-- 
2.30.0

