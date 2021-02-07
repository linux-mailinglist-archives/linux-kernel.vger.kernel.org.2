Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7CB31233E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBGJrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:47:01 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84AC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 01:46:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p21so17478908lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 01:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oG8UuFWzfJqkv2XW5txDA/xJM4YW9culKt5veHh2BgA=;
        b=sHOWZM1Qc9KPAr1TzV1jMVzHdwCPmrB5k+mCyO7q+agSd3JlY7e5aTTUGW7Gwm3Z1P
         rBfiSCHT/GPuEj+GCZUqnksl0KgWwyBEQ2ybUnhersMA+hBCX3ek9+pFGy4nteeyKgSf
         9kd3s/zMFuRRlKH5cfnpMyM06bFpN9VXFxl697QXc5ak3bqjAz0fE4LILY8wJZLNYcti
         R4809ol/FovYU00HjilAVdAK+PcBy2CDC62sVEZBjaRD8KNtasxbzapDvMwBx9Xn5Zqb
         4KqFmLi+c8c4GNtXaFw+XXYyKTSMThvflGSQLvlC/yneDUV4y9H83JVLx9vpO1ahTe0l
         WiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oG8UuFWzfJqkv2XW5txDA/xJM4YW9culKt5veHh2BgA=;
        b=DoAqchCZvKnGj1wPTTNEf2S1r6CPGc557uurOJRU68WvhmDl5Z+l070jFFbVAZegEO
         ++BsQgHEJ431cXUeCoFSgHkvoUOsFSaz/ftOVm74nwjOfYMCHn5qyE6Dp/ictj9t1tHM
         68OGRTpzmOUrFnD0laVm5NhepKoa9yMvcFdGnsRcyOMNxfC4qdoOG3GCDpT2MdW7Af+2
         oKp5u5RmKd1+GvLA/PDajB5rswyDgiiylOv+6PXSdOYZ3Hus2Gk+sC44c3d/TgT/Rbps
         D0WoMqRslfpDK4fKMs7+M+1XBjlorhw0yNiULRHEo8gdJFPCbdJAh81bka6B7yqP7Ur3
         MyEQ==
X-Gm-Message-State: AOAM5323J9pM0a29JDsiiMyZCV8sqEnSXeUm1pidzk6lhNk/Fk3mRB7Y
        ofjC/CLvpPd2p4Xsek3h1NYxSyOV78GSNQ==
X-Google-Smtp-Source: ABdhPJyomqxWODHC6liAtZkADGD6XHGDfpzdft9xpiKNaX0ymEqPvK7j8jjwxEc2LsrUN1OQMlI4gA==
X-Received: by 2002:a05:6512:3601:: with SMTP id f1mr7298315lfs.114.1612691179174;
        Sun, 07 Feb 2021 01:46:19 -0800 (PST)
Received: from raszit-komputer-amd.raszit-server.ovh ([62.122.232.191])
        by smtp.gmail.com with ESMTPSA id 8sm1632811lfq.103.2021.02.07.01.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 01:46:18 -0800 (PST)
From:   Marcin Raszka <djraszit@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcin Raszka <djraszit@gmail.com>
Subject: [PATCH] I was wondering why I can't set the resolution to 2560x1080, while in windows 7 I can without a problem. I looked at the radeon driver code and found it doesn't support this resolution. So I made some changes. I added the hdmi_mhz parameter. In cmdline I set radeon.hdmi_mhz=190 Only tested on the Radeon HD 5830
Date:   Sun,  7 Feb 2021 10:46:04 +0100
Message-Id: <20210207094604.7250-1-djraszit@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/gpu/drm/radeon/radeon_benchmark.c  |  5 ++--
 drivers/gpu/drm/radeon/radeon_connectors.c | 30 ++++++++++++++--------
 drivers/gpu/drm/radeon/radeon_drv.c        |  5 ++++
 drivers/gpu/drm/radeon/radeon_encoders.c   |  6 +++--
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_benchmark.c b/drivers/gpu/drm/radeon/radeon_benchmark.c
index ac9a5ec481c3..c283b6b15925 100644
--- a/drivers/gpu/drm/radeon/radeon_benchmark.c
+++ b/drivers/gpu/drm/radeon/radeon_benchmark.c
@@ -30,7 +30,7 @@
 #define RADEON_BENCHMARK_COPY_DMA  0
 
 #define RADEON_BENCHMARK_ITERATIONS 1024
-#define RADEON_BENCHMARK_COMMON_MODES_N 17
+#define RADEON_BENCHMARK_COMMON_MODES_N 18
 
 static int radeon_benchmark_do_move(struct radeon_device *rdev, unsigned size,
 				    uint64_t saddr, uint64_t daddr,
@@ -184,7 +184,8 @@ void radeon_benchmark(struct radeon_device *rdev, int test_number)
 		1680 * 1050 * 4,
 		1600 * 1200 * 4,
 		1920 * 1080 * 4,
-		1920 * 1200 * 4
+		1920 * 1200 * 4,
+		2560 * 1080 * 4
 	};
 
 	switch (test_number) {
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 607ad5620bd9..37927222f5b3 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -37,6 +37,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
 
+extern int hdmimhz;
+
 static int radeon_dp_handle_hpd(struct drm_connector *connector)
 {
 	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
@@ -503,7 +505,7 @@ static void radeon_add_common_modes(struct drm_encoder *encoder, struct drm_conn
 	struct mode_size {
 		int w;
 		int h;
-	} common_modes[17] = {
+	} common_modes[18] = {
 		{ 640,  480},
 		{ 720,  480},
 		{ 800,  600},
@@ -520,10 +522,11 @@ static void radeon_add_common_modes(struct drm_encoder *encoder, struct drm_conn
 		{1680, 1050},
 		{1600, 1200},
 		{1920, 1080},
-		{1920, 1200}
+		{1920, 1200},
+		{2560, 1080}
 	};
 
-	for (i = 0; i < 17; i++) {
+	for (i = 0; i < 18; i++) {
 		if (radeon_encoder->devices & (ATOM_DEVICE_TV_SUPPORT)) {
 			if (common_modes[i].w > 1024 ||
 			    common_modes[i].h > 768)
@@ -1491,25 +1494,32 @@ static enum drm_mode_status radeon_dvi_mode_valid(struct drm_connector *connecto
 	    (mode->clock > 135000))
 		return MODE_CLOCK_HIGH;
 
-	if (radeon_connector->use_digital && (mode->clock > 165000)) {
+	if (radeon_connector->use_digital && (mode->clock > (hdmimhz * 1000))) {
 		if ((radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I) ||
 		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
-		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B))
+		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B)){
+			printk("MODE_CLOCK_HIHG0 %d", hdmimhz);
 			return MODE_OK;
-		else if (ASIC_IS_DCE6(rdev) && drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
+		}else if (ASIC_IS_DCE6(rdev) && drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
 			/* HDMI 1.3+ supports max clock of 340 Mhz */
-			if (mode->clock > 340000)
+			if (mode->clock > 340000){
+				printk("MODE_CLOCK_HIHG1 %d", hdmimhz);
 				return MODE_CLOCK_HIGH;
-			else
+			}else{
+				printk("MODE_OK1");
 				return MODE_OK;
+			}
 		} else {
+			printk("MODE_CLOCK_HIHG2 %d", hdmimhz);
 			return MODE_CLOCK_HIGH;
 		}
 	}
 
 	/* check against the max pixel clock */
-	if ((mode->clock / 10) > rdev->clock.max_pixel_clock)
+	if ((mode->clock / 10) > rdev->clock.max_pixel_clock){
+		printk("MODE_CLOCK_HIHG3 %d", hdmimhz);
 		return MODE_CLOCK_HIGH;
+	}
 
 	return MODE_OK;
 }
@@ -1809,7 +1819,7 @@ static enum drm_mode_status radeon_dp_mode_valid(struct drm_connector *connector
 				if (mode->clock > 340000)
 					return MODE_CLOCK_HIGH;
 			} else {
-				if (mode->clock > 165000)
+				if (mode->clock > (hdmimhz * 1000))
 					return MODE_CLOCK_HIGH;
 			}
 		}
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index e45d7344ac2b..fce8f9ab8018 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -281,6 +281,11 @@ int radeon_cik_support = 1;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
 module_param_named(cik_support, radeon_cik_support, int, 0444);
 
+int hdmimhz = 165;
+MODULE_PARM_DESC(hdmi_mhz, "set HDMI max frequency, default is 165");
+module_param_named(hdmi_mhz, hdmimhz, int, 0444);
+
+
 static struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/radeon/radeon_encoders.c
index 46549d5179ee..6b805bcd5726 100644
--- a/drivers/gpu/drm/radeon/radeon_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_encoders.c
@@ -35,6 +35,8 @@
 #include "radeon_legacy_encoders.h"
 #include "atom.h"
 
+extern int hdmimhz;
+
 static uint32_t radeon_encoder_clones(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
@@ -389,7 +391,7 @@ bool radeon_dig_monitor_is_duallink(struct drm_encoder *encoder,
 				else
 					return false;
 			} else {
-				if (pixel_clock > 165000)
+				if (pixel_clock > (hdmimhz * 1000))
 					return true;
 				else
 					return false;
@@ -414,7 +416,7 @@ bool radeon_dig_monitor_is_duallink(struct drm_encoder *encoder,
 				else
 					return false;
 			} else {
-				if (pixel_clock > 165000)
+				if (pixel_clock > (hdmimhz * 1000))
 					return true;
 				else
 					return false;
-- 
2.30.0

