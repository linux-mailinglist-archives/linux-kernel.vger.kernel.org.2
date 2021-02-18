Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E17231F2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhBRW57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:57:59 -0500
Received: from smtpcmd0991.aruba.it ([62.149.156.91]:36516 "EHLO
        smtpcmd0991.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhBRW5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:57:22 -0500
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id CsDwlA0uUJFRNCsDwlTfoM; Thu, 18 Feb 2021 23:56:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1613689000; bh=gcK70S0FFOxqIXWnyxiiEzZN/4jx2jpClpkDS0APdYA=;
        h=From:To:Subject:Date:MIME-Version;
        b=MQrmAQZMdhfpcrS4HvFBZ4oH+gF1MQzRu0hiOQgUXToaiEvITUkg+g+DiTHfErKit
         SPzTOgFNoDALGnZtayc5caB7wUa0SaSNpWx7c1nnEnxdyRwU6+IxiqWez7rTKfyQtZ
         wXkn9rEVHqhkSik6qx/hg9BcDWQ033Vf2Skh4LGnRbRrPyfbMcECjDBfo0PheZE5T6
         peNAsqoDfToHz6lNrmilSXzyNLhW2Ke0v8zRQDZb2SeJPuOJPoQ7KV5RkLj8WML+95
         2p7+9O7bQSFfn9trRWAZGW7Z4Iw69ZjN0gcWU5CApbvITCnYKOQ5KFlGUl2k6Rn0oG
         7yc7qSmGifYNg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] drm/panel: simple: add Jenson JT60249-01
Date:   Thu, 18 Feb 2021 23:56:38 +0100
Message-Id: <20210218225639.824094-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDWlyH04O5dwYkBN/neJuyQv4kKg65oGrhs0Tg++fWrZwlTRHyBe8wwWzAbHupDrJLlbV7GCL/SD+0m0p+aH18+mSa2+w3YJlvpr2kcluQfnQntsSdFt
 Ute8+HVgrhspdsSBvMBVF9tERklfkfjGZ0ee2yAY7825BlAw2WunWU21fw/SbEYoQTk7yu4MdAgjyMoR76yvHocLyFYw7NXfW8B9Za8MiQok/0PO7fqM6WBU
 t3qpWbjnlTORPX8/lREvP71Udedw9YslgtFkO5e1bk7n96TqzJsuNrrTHdASjQSZv4wneuAmCDFL4PExMQnEBJGMEX6WfaqQLRHs36iJKX5S1Gtq1v4Mf5hY
 qPvdOzOvxURvGDtO8kPfJBPTlHuKTxnXV1YN1F0rP2fLAremvJ3yWJ1RwLLoeHZ9dD0woMi8y5d2VmYV50LhZfcfzMtwd7dFmtvdoDt6yaPm3VoGPxLaFmcK
 +e+cC3QK5xHQqCtf
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

This patch adds support for Jenson JT60249-01 800x480 5" panel to DRM
simple panel driver.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index f243087ce89b..995a581f8b2b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2444,6 +2444,30 @@ static const struct panel_desc jenson_jt60248_01 = {
 	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
 };
 
+static const struct drm_display_mode jenson_jt60249_01_mode = {
+	.clock = 25000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 8,
+	.hsync_end = 800 + 8 + 4,
+	.htotal = 800 + 8 + 4 + 8,
+	.vdisplay = 480,
+	.vsync_start = 480 + 8,
+	.vsync_end = 480 + 8 + 4,
+	.vtotal = 480 + 8 + 4 + 8,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc jenson_jt60249_01 = {
+	.modes = &jenson_jt60249_01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 108,
+		.height = 65,
+	},
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
+};
+
 static const struct drm_display_mode kingdisplay_kd116n21_30nv_a010_mode = {
 	.clock = 81000,
 	.hdisplay = 1366,
@@ -4216,6 +4240,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "jenson,jt60248-01",
 		.data = &jenson_jt60248_01,
+	}, {
+		.compatible = "jenson,jt60249-01",
+		.data = &jenson_jt60249_01,
 	}, {
 		.compatible = "kingdisplay,kd116n21-30nv-a010",
 		.data = &kingdisplay_kd116n21_30nv_a010,
-- 
2.25.1

