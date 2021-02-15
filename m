Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B556031C034
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhBORMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhBOP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:59:34 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32766C061788
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:58:54 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e9so3962312plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bq8rm8oWtZjG4WT4wHmoCnQ9k2UwzRK8jNwPlujWQIg=;
        b=0p6QMFH76WWGhx0ZKDlf+d6wKYUKSNzl8w7PYaMsrTCMgRZXi9fzSZcaKesq4inmmj
         EGwG0r/7RwW9+N2HunAjM/7PqatxcrKU3IdRy4OzBeNN/3cgqB0ABzwN+UhCE6lvaTah
         GU4PvjpdBZtRGt1Qzmi6pl9Z6Rrbqi7DG83Wf/WUQ4F+R3HAU/zC/XQF08XsS9/xZlfI
         vuOPhuzeDEgySSm/zvAoHbqWxGOV3zsKb6uS2ja3ERDgr25gRO2k9ljiZ8aMLiLuBBX1
         CCOyyMsUa42Umox7kDPu7HDMD+2wDCLXhQA/5vZgHb29WwksTwdY17vA9lQmolnAnzue
         xcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bq8rm8oWtZjG4WT4wHmoCnQ9k2UwzRK8jNwPlujWQIg=;
        b=oCc3Tx4Pk1r7g3jNawISKjqRawb1BDgtKJbQ9MQ6fWwh2MN/VWaWgwDiEDJxuX7kU6
         L3p8+2OIXhqTSe6/vcUJsr97AqASxEw4nycH6OnA3Y4Nrq2szXOAeBDQmOFLAU2lrK3V
         z7i/Gi0RuQ1Mm+5YTh9SMzdnp4lGxA2A4BgZZiPbUmM6umO8N1FcuT2+aH9dNzx8hjf3
         PFvjn3zIUKoLcRuptv3KVlHIkcOjtVbu2R3CWP56pjTCxS0Gy6V7zPrt1jSuOgyK+8Dl
         cgkfeKitWNEdiQfwC62yEoekpExQuYLunXTAJAliNJJR3H2ED8ElBT4DTVSebB8AiuPw
         5dgw==
X-Gm-Message-State: AOAM533Q+wQS2lcgNofnwS/8EzUAAeqyFm8DphXkhVjEFSWh04WzAQr3
        slxpFXTS4YcT0nYtIDDcbmDbgOutCEQ4
X-Google-Smtp-Source: ABdhPJxda0JrWuWRNy8lZns5VXCUvDARjhJmEtBwnw78o/kYKU0vkXzVb9cDgcWpzC0cem7jnCR8hw==
X-Received: by 2002:a17:90a:4e84:: with SMTP id o4mr5453793pjh.117.1613404733728;
        Mon, 15 Feb 2021 07:58:53 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id b25sm19208356pfp.26.2021.02.15.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:58:53 -0800 (PST)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     michal.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH v3] firmware: xilinx: Remove zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
Date:   Tue, 16 Feb 2021 00:58:49 +0900
Message-Id: <20210215155849.2425846-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zynqmp_pm_get_eemi_ops() was removed in commit 4db8180ffe7c: "Firmware: xilinx:
Remove eemi ops for fpga related APIs", but not in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE).
Any driver who want to communicate with PMC using EEMI APIs use the functions provided
for each function
This removed zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE), and also
modify the documentation for this driver.

Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 v3: Update eemi.rst.
 v2: Added the comment pointed out by Michal.  

 Documentation/driver-api/xilinx/eemi.rst | 31 ++----------------------
 include/linux/firmware/xlnx-zynqmp.h     |  5 ----
 2 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/Documentation/driver-api/xilinx/eemi.rst b/Documentation/driver-api/xilinx/eemi.rst
index 9dcbc6f18d75df..579cf9a407ac2f 100644
--- a/Documentation/driver-api/xilinx/eemi.rst
+++ b/Documentation/driver-api/xilinx/eemi.rst
@@ -16,35 +16,8 @@ components running across different processing clusters on a chip or
 device to communicate with a power management controller (PMC) on a
 device to issue or respond to power management requests.
 
-EEMI ops is a structure containing all eemi APIs supported by Zynq MPSoC.
-The zynqmp-firmware driver maintain all EEMI APIs in zynqmp_eemi_ops
-structure. Any driver who want to communicate with PMC using EEMI APIs
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
+Any driver who want to communicate with PMC using EEMI APIs use the
+functions provided for each function.
 
 IOCTL
 ------
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index c8a18da6906e78..70e19ab34ff1ca 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -416,11 +416,6 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value);
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

