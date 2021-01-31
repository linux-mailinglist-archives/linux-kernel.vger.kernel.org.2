Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1E309CF7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhAaOdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhAaObd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 09:31:33 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731F7C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 06:30:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h15so8492429pli.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 06:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzVDaJ1fFycebTAvDz+XG3GL0wDkx80opJiUc7Y73GA=;
        b=nph1gnU+p1YlhYEHYZOEAY5TMqgf7lDjuKRpDI3foQvwW/Ufgxud7XN3oZaWkWr4zc
         k0t3GUUi7xbeyTQBP0ZbYCFhhYL5+PRYRO+HY1CN6OLpeMfjER1i6ZQPgyS5NTZVRtqc
         mvuhvE5IVpBCMFwt7cwbqtTLSFnF6E7yhTbAfR8AgKx6bzb5osI+JViS6JTVbPHHZiVh
         QRlIKbqn++iJYOZ3QBIJPrN3GMh3mQbRHgaxMtHSNUm66i1nm6WukCpqJ7qXP8OtDzWT
         pga7p7ZxpMIY6/srf00UJiVQXsnXqyw82ZN9WLyuUywLUvsRzVgI9piqjhZec78RxXnx
         ZQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzVDaJ1fFycebTAvDz+XG3GL0wDkx80opJiUc7Y73GA=;
        b=ZjDayEsho/R/sMwOqY7qi5loowzyaryvOyVHa8tpP2K+CSHzZVb1365k/C4N2ZWYiY
         lmJie+RwdVonmldwQ3cju/4YcCvOnRbtEs3T3fmuOzOy1XMbK6IOIqqSHwRxkiErJP5E
         AEhUQgxMZcf46JZAwGcgSRYHGwU3koTBG7yv2FvEh9mWKtQkIZPx1N6kgMRDNEG/o6to
         lwj6BBdZYCneSEhMcWjf0U/Wy06Uek7hUjgZFw7Br8wPlqew3Yis/KNAGQLrOoh9g41+
         vRFzV3+BynGcl7DRJURqV+oQ683bEwEmgknjGed9pPhcN4R2tSsiGXybFG9S2JT0c0ZR
         MrrQ==
X-Gm-Message-State: AOAM530UazwiAc70WLL5X4QXB0l1/6HY0NefKQp2UUhxeg1AR7CTgTxg
        w86INg7lxuoUcuR7S/TlWV1/qQjZkRnO
X-Google-Smtp-Source: ABdhPJzmuNuju7oGIdhsBkMpUdnZr+g+bHAgqsSxYoVL3cn4F9d0oHum6qBfPPnToWL/UYM17WCDCA==
X-Received: by 2002:a17:90a:470b:: with SMTP id h11mr12927978pjg.186.1612103445995;
        Sun, 31 Jan 2021 06:30:45 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id w7sm4487174pjv.24.2021.01.31.06.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 06:30:45 -0800 (PST)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     michal.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] firmware: xilinx: Remove zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
Date:   Sun, 31 Jan 2021 23:30:33 +0900
Message-Id: <20210131143033.7441-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zynqmp_pm_get_eemi_ops() was removed in commit 4db8180ffe7c: "Firmware: xilinx:
Remove eemi ops for fpga related APIs", but not in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE).
This removed zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE), and also
modify the documentation for this driver.

Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
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

