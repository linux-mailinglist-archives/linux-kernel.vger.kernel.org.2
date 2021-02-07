Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B2231244A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 13:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBGM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 07:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhBGM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 07:27:42 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF69C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 04:27:01 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f2so13190833ljp.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 04:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gcz7v6DZPhAi4AtZZ5PbRFe7Gq35BWRB6p1i50/BrZA=;
        b=jLmevEkjGVXuYMVWMer1v0VCl3DyRTM5Z/DiHYKMmeDHns3QNNDRFhKZA8weXn6pAx
         mMO0H4+ukcpAJtp8YN9JRKoQZaS60iiIVrmLl0OqVA5kqsiscAiHuBrIbOnV16hOoTQG
         5ovxrIJbgZJO3yZviwu7fMf6DkRJbZBFPr6OIra2t4ms7EUj/6qEdf9uiJtMCd2Lghva
         z5PrbFZ8/LfhSLSRVmUKpIuhyHuwtbWXah3lyx4tqXeiQHIMsenRlRNdLFQe3jzZHRwQ
         4jJ/OHelETsIJRKwidZhYLWJw8NcAvtS1KjQP4RUEf28l1dSD/huYYxq+sXYreh1DY8s
         qmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gcz7v6DZPhAi4AtZZ5PbRFe7Gq35BWRB6p1i50/BrZA=;
        b=f3y3fVRiTkv/j3J7Nl+PGHlvRJrQZgdeyCC9XZkvuxNM3G0/bP2MCDiMBwkjRq3oLW
         ZWxWwidr9pM1WQgCKrGHQv5ZqKrTyMU5dV7ndrEjzQPK1s1SUVqKRG+tdXDEcj2+UiGd
         +zv82OYfcTQwNFazKQsXvBFrpClYeN/UHjSTvlGfNAx+x/rQiK8e8clQgyxNQw6UizTJ
         WyeohIuHJ6UchjPU2rkrfkh91xoJkJIPnfgeX+6UAd+YwOJr9j1CTHDedAp1WDF+6QlE
         /t4VsGSYvsKP7kq/4WuFSGWIWQMXAkFt4P0sDBhb14S/tgTSrT49XXZ7ZdHPzxSZpQdt
         wFyA==
X-Gm-Message-State: AOAM533DNpI+hvQKwY7V/P7DHSr9sPHmbOH6RI67GGMT/7FrcjyBXqbM
        8+SvebMBbdFGJs91VU2DvnjOb3ruwlAofg==
X-Google-Smtp-Source: ABdhPJxHxfU7OJvqh+vUFm8v8Qux7b14sy9mpIOoVyUK0AJw7fXNoMShQZ8qduFCx1tq2p6eNIPOBg==
X-Received: by 2002:a2e:a48a:: with SMTP id h10mr7836098lji.422.1612700818827;
        Sun, 07 Feb 2021 04:26:58 -0800 (PST)
Received: from raszit-komputer-amd.raszit-server.ovh ([62.122.232.191])
        by smtp.gmail.com with ESMTPSA id b17sm1685427lfa.42.2021.02.07.04.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 04:26:58 -0800 (PST)
From:   Marcin Raszka <djraszit@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcin Raszka <djraszit@gmail.com>
Subject: [PATCH] radeon: added support for 2560x1080 resolution
Date:   Sun,  7 Feb 2021 13:25:51 +0100
Message-Id: <20210207122550.5677-1-djraszit@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering why I can't set the resolution to 2560x1080,
 while in windows 7 I can without a problem. I looked at the radeon driver
 code and found it doesn't support this resolution. So I made some changes. I
 added the hdmi_mhz parameter. In cmdline I set radeon.hdmi_mhz=190 
 Only tested on the Radeon HD 5830

---
 drivers/gpu/drm/radeon/radeon_benchmark.c  |  5 +++--
 drivers/gpu/drm/radeon/radeon_connectors.c | 25 +++++++++++++---------
 drivers/gpu/drm/radeon/radeon_drv.c        |  5 +++++
 drivers/gpu/drm/radeon/radeon_encoders.c   |  6 ++++--
 4 files changed, 27 insertions(+), 14 deletions(-)

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
index 607ad5620bd9..182f1e364cbd 100644
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
+	} common_modes[] = {
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
+	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
 		if (radeon_encoder->devices & (ATOM_DEVICE_TV_SUPPORT)) {
 			if (common_modes[i].w > 1024 ||
 			    common_modes[i].h > 768)
@@ -1491,25 +1494,27 @@ static enum drm_mode_status radeon_dvi_mode_valid(struct drm_connector *connecto
 	    (mode->clock > 135000))
 		return MODE_CLOCK_HIGH;
 
-	if (radeon_connector->use_digital && (mode->clock > 165000)) {
+	if (radeon_connector->use_digital && (mode->clock > (hdmimhz * 1000))) {
 		if ((radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I) ||
 		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
-		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B))
+		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B)){
 			return MODE_OK;
-		else if (ASIC_IS_DCE6(rdev) && drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
+		}else if (ASIC_IS_DCE6(rdev) && drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
 			/* HDMI 1.3+ supports max clock of 340 Mhz */
-			if (mode->clock > 340000)
+			if (mode->clock > 340000){
 				return MODE_CLOCK_HIGH;
-			else
+			}else{
 				return MODE_OK;
+			}
 		} else {
 			return MODE_CLOCK_HIGH;
 		}
 	}
 
 	/* check against the max pixel clock */
-	if ((mode->clock / 10) > rdev->clock.max_pixel_clock)
+	if ((mode->clock / 10) > rdev->clock.max_pixel_clock){
 		return MODE_CLOCK_HIGH;
+	}
 
 	return MODE_OK;
 }
@@ -1809,7 +1814,7 @@ static enum drm_mode_status radeon_dp_mode_valid(struct drm_connector *connector
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

