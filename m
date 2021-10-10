Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B07427E78
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 05:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhJJDFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 23:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhJJDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 23:05:00 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D03C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 20:03:02 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so2855257otl.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 20:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dULes5+aKNO9I+xG1qAGVCL0ir0FJqSn6Fpl0VJVQKg=;
        b=IrfhRy1H3cFzWgH10PhI0r5z0+eWTpL+BooBqTktyj/FHdmNLVj6svwXEIOi7EktUs
         EDv6OFCJ4aLOFipxOt93n0rF4Dr0qPyrhg+F9diminBuXyprOk5oeGxIDrzumXPH3yxw
         CVrpuMzmXQG/P0vPwjS0VLEvizsmVgNZ/IspDoHLADHINn6a7mZYz1bq6OYxiMEC6rL8
         Ts/ZqxS/oPktK1E+Ec7rJQbVS3bWnR1jsBA4FMRkPrLYwKn130U10JHJW7vL0mS3gKH3
         F5v3EdFeHWzSo8N4JMxgGKli6AfGZxwuWG77tVrI6m6Q33neQ/JfS3WvrdZfklUJzVCT
         bqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dULes5+aKNO9I+xG1qAGVCL0ir0FJqSn6Fpl0VJVQKg=;
        b=RUDdKYLBxs65fVzjroYX/WQmdpvsa3FJQFwyUKIrMaZe68FgrC+sz7d7ZLe1j2ZUNK
         DxapBY/thdkHn79NkGlZJbCUeYMA2BhmkcGhR7RYPvr8FJd0zATAbqt41EOeOxSzD4RA
         MW+TrtTexcj1vjmJ4VP6cZ2GX2ZtZFuYB/5qUPi4NjWYIBHHumNuOToLxWjGRpzlJ9nq
         3HqaxG/8m5PhBojOsCScFXVx30J5wyDwzWqg47xtytpIrVLOGMnm3DU1IDIceWkkGasx
         55iasl1wuuOVo3AU5uyU61Nv6Vs+1Vlwo7QAXs+oP42YbDqnJJtWvgCdNbJ+9fE0l0n0
         S0UQ==
X-Gm-Message-State: AOAM530l/6DpUDCOkvXviD6gQo9q6p5NRKo6jkoYJhaz0c4C6oh87tf1
        U7mMtjz7mCN4TYQ2nMUTU9tT2Q==
X-Google-Smtp-Source: ABdhPJyla0z0yyMYy+ZmMtAsDPkpQKZ/s6cNhagJT2URxlyS37YKvJSmjB+MIKrSb4TcY1g//DJkEQ==
X-Received: by 2002:a05:6830:3093:: with SMTP id f19mr2218948ots.97.1633834980511;
        Sat, 09 Oct 2021 20:03:00 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id s22sm894943ois.32.2021.10.09.20.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 20:02:59 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: Use the connector passed to dp_debug_get()
Date:   Sat,  9 Oct 2021 20:04:35 -0700
Message-Id: <20211010030435.4000642-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs code is provided an array of a single drm_connector. Then to
access the connector, the list of all connectors of the DRM device is
traversed and all non-DisplayPort connectors are skipped, to find the
one and only DisplayPort connector.

But as we move to support multiple DisplayPort controllers this will now
find multiple connectors and has no way to distinguish them.

Pass the single connector to dp_debug_get() and use this in the debugfs
functions instead, both to simplify the code and the support the
multiple instances.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_debug.c   | 131 ++++++++++------------------
 drivers/gpu/drm/msm/dp/dp_debug.h   |   2 +-
 drivers/gpu/drm/msm/dp/dp_display.c |   2 +-
 3 files changed, 46 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
index af709d93bb9f..da4323556ef3 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.c
+++ b/drivers/gpu/drm/msm/dp/dp_debug.c
@@ -24,7 +24,7 @@ struct dp_debug_private {
 	struct dp_usbpd *usbpd;
 	struct dp_link *link;
 	struct dp_panel *panel;
-	struct drm_connector **connector;
+	struct drm_connector *connector;
 	struct device *dev;
 	struct drm_device *drm_dev;
 
@@ -97,59 +97,35 @@ DEFINE_SHOW_ATTRIBUTE(dp_debug);
 
 static int dp_test_data_show(struct seq_file *m, void *data)
 {
-	struct drm_device *dev;
-	struct dp_debug_private *debug;
-	struct drm_connector *connector;
-	struct drm_connector_list_iter conn_iter;
+	const struct dp_debug_private *debug = m->private;
+	const struct drm_connector *connector = debug->connector;
 	u32 bpc;
 
-	debug = m->private;
-	dev = debug->drm_dev;
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-
-		if (connector->connector_type !=
-			DRM_MODE_CONNECTOR_DisplayPort)
-			continue;
-
-		if (connector->status == connector_status_connected) {
-			bpc = debug->link->test_video.test_bit_depth;
-			seq_printf(m, "hdisplay: %d\n",
-					debug->link->test_video.test_h_width);
-			seq_printf(m, "vdisplay: %d\n",
-					debug->link->test_video.test_v_height);
-			seq_printf(m, "bpc: %u\n",
-					dp_link_bit_depth_to_bpc(bpc));
-		} else
-			seq_puts(m, "0");
+	if (connector->status == connector_status_connected) {
+		bpc = debug->link->test_video.test_bit_depth;
+		seq_printf(m, "hdisplay: %d\n",
+				debug->link->test_video.test_h_width);
+		seq_printf(m, "vdisplay: %d\n",
+				debug->link->test_video.test_v_height);
+		seq_printf(m, "bpc: %u\n",
+				dp_link_bit_depth_to_bpc(bpc));
+	} else {
+		seq_puts(m, "0");
 	}
 
-	drm_connector_list_iter_end(&conn_iter);
-
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(dp_test_data);
 
 static int dp_test_type_show(struct seq_file *m, void *data)
 {
-	struct dp_debug_private *debug = m->private;
-	struct drm_device *dev = debug->drm_dev;
-	struct drm_connector *connector;
-	struct drm_connector_list_iter conn_iter;
-
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-
-		if (connector->connector_type !=
-			DRM_MODE_CONNECTOR_DisplayPort)
-			continue;
+	const struct dp_debug_private *debug = m->private;
+	const struct drm_connector *connector = debug->connector;
 
-		if (connector->status == connector_status_connected)
-			seq_printf(m, "%02x", DP_TEST_LINK_VIDEO_PATTERN);
-		else
-			seq_puts(m, "0");
-	}
-	drm_connector_list_iter_end(&conn_iter);
+	if (connector->status == connector_status_connected)
+		seq_printf(m, "%02x", DP_TEST_LINK_VIDEO_PATTERN);
+	else
+		seq_puts(m, "0");
 
 	return 0;
 }
@@ -161,14 +137,12 @@ static ssize_t dp_test_active_write(struct file *file,
 {
 	char *input_buffer;
 	int status = 0;
-	struct dp_debug_private *debug;
-	struct drm_device *dev;
-	struct drm_connector *connector;
-	struct drm_connector_list_iter conn_iter;
+	const struct dp_debug_private *debug;
+	const struct drm_connector *connector;
 	int val = 0;
 
 	debug = ((struct seq_file *)file->private_data)->private;
-	dev = debug->drm_dev;
+	connector = debug->connector;
 
 	if (len == 0)
 		return 0;
@@ -179,30 +153,22 @@ static ssize_t dp_test_active_write(struct file *file,
 
 	DRM_DEBUG_DRIVER("Copied %d bytes from user\n", (unsigned int)len);
 
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-		if (connector->connector_type !=
-			DRM_MODE_CONNECTOR_DisplayPort)
-			continue;
-
-		if (connector->status == connector_status_connected) {
-			status = kstrtoint(input_buffer, 10, &val);
-			if (status < 0)
-				break;
-			DRM_DEBUG_DRIVER("Got %d for test active\n", val);
-			/* To prevent erroneous activation of the compliance
-			 * testing code, only accept an actual value of 1 here
-			 */
-			if (val == 1)
-				debug->panel->video_test = true;
-			else
-				debug->panel->video_test = false;
+	if (connector->status == connector_status_connected) {
+		status = kstrtoint(input_buffer, 10, &val);
+		if (status < 0) {
+			kfree(input_buffer);
+			return status;
 		}
+		DRM_DEBUG_DRIVER("Got %d for test active\n", val);
+		/* To prevent erroneous activation of the compliance
+		 * testing code, only accept an actual value of 1 here
+		 */
+		if (val == 1)
+			debug->panel->video_test = true;
+		else
+			debug->panel->video_test = false;
 	}
-	drm_connector_list_iter_end(&conn_iter);
 	kfree(input_buffer);
-	if (status < 0)
-		return status;
 
 	*offp += len;
 	return len;
@@ -211,25 +177,16 @@ static ssize_t dp_test_active_write(struct file *file,
 static int dp_test_active_show(struct seq_file *m, void *data)
 {
 	struct dp_debug_private *debug = m->private;
-	struct drm_device *dev = debug->drm_dev;
-	struct drm_connector *connector;
-	struct drm_connector_list_iter conn_iter;
-
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-		if (connector->connector_type !=
-			DRM_MODE_CONNECTOR_DisplayPort)
-			continue;
-
-		if (connector->status == connector_status_connected) {
-			if (debug->panel->video_test)
-				seq_puts(m, "1");
-			else
-				seq_puts(m, "0");
-		} else
+	struct drm_connector *connector = debug->connector;
+
+	if (connector->status == connector_status_connected) {
+		if (debug->panel->video_test)
+			seq_puts(m, "1");
+		else
 			seq_puts(m, "0");
+	} else {
+		seq_puts(m, "0");
 	}
-	drm_connector_list_iter_end(&conn_iter);
 
 	return 0;
 }
@@ -278,7 +235,7 @@ static int dp_debug_init(struct dp_debug *dp_debug, struct drm_minor *minor)
 
 struct dp_debug *dp_debug_get(struct device *dev, struct dp_panel *panel,
 		struct dp_usbpd *usbpd, struct dp_link *link,
-		struct drm_connector **connector, struct drm_minor *minor)
+		struct drm_connector *connector, struct drm_minor *minor)
 {
 	int rc = 0;
 	struct dp_debug_private *debug;
diff --git a/drivers/gpu/drm/msm/dp/dp_debug.h b/drivers/gpu/drm/msm/dp/dp_debug.h
index 7eaedfbb149c..3f90acfffc5a 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.h
+++ b/drivers/gpu/drm/msm/dp/dp_debug.h
@@ -43,7 +43,7 @@ struct dp_debug {
  */
 struct dp_debug *dp_debug_get(struct device *dev, struct dp_panel *panel,
 		struct dp_usbpd *usbpd, struct dp_link *link,
-		struct drm_connector **connector,
+		struct drm_connector *connector,
 		struct drm_minor *minor);
 
 /**
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1708b7cdc1b3..41a6f58916e6 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1464,7 +1464,7 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
 	dev = &dp->pdev->dev;
 
 	dp->debug = dp_debug_get(dev, dp->panel, dp->usbpd,
-					dp->link, &dp->dp_display.connector,
+					dp->link, dp->dp_display.connector,
 					minor);
 	if (IS_ERR(dp->debug)) {
 		rc = PTR_ERR(dp->debug);
-- 
2.29.2

