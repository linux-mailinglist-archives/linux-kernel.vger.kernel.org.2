Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825C636163B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 01:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbhDOX3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 19:29:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31759 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236754AbhDOX3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 19:29:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618529337; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=piGppBojtqCVXDMpx0SlbAI0Ep5s6X3/HUnzkiklKDw=; b=gR1CXvg0+LP5+V1OLn218ZHHANNvqkFuBPiR6keaMd+sHryW2yosVEnR84mtfwq/h+bwEezt
 w/c9GUgCKQdWI7OGn5BorBxwwqeT65qdqfrYqrL3O1Q88v7p3ZtWR8dvphUORlxxs3Xhf+7c
 XXUMKA39nX2EPRiz7xTy49Tj+5c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6078cc39a817abd39a506a73 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Apr 2021 23:28:57
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5F581C43464; Thu, 15 Apr 2021 23:28:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B02C6C433CA;
        Thu, 15 Apr 2021 23:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B02C6C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=khsieh@codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        khsieh@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] drm/msm/dp: check main link status before start aux read
Date:   Thu, 15 Apr 2021 16:28:46 -0700
Message-Id: <1618529326-26883-1-git-send-email-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <161852681935.46595.9941294298184495830@swboyd.mtv.corp.google.com>
References: <161852681935.46595.9941294298184495830@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe when the cable is disconnected the DP phy should be shutdown and
some bit in the phy could effectively "cut off" the aux channel and then
NAKs would start coming through here in the DP controller I/O register
space. This patch have DP aux channel read/write to return NAK immediately
if DP controller connection status is in unplugged state.

Changes in V3:
-- check core_initialized before handle irq_hpd
Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
---
 drivers/gpu/drm/msm/dp/dp_aux.c     |  5 +++++
 drivers/gpu/drm/msm/dp/dp_display.c | 14 ++++++++++----
 drivers/gpu/drm/msm/dp/dp_link.c    | 20 +++++++++++++++-----
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 7c22bfe..fae3806 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -343,6 +343,11 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
 
 	mutex_lock(&aux->mutex);
 
+	if (!dp_catalog_link_is_connected(aux->catalog)) {
+		ret = -ETIMEDOUT;
+		goto unlock_exit;
+	}
+
 	aux->native = msg->request & (DP_AUX_NATIVE_WRITE & DP_AUX_NATIVE_READ);
 
 	/* Ignore address only message */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1784e11..db3f45e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -571,7 +571,7 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 		dp->hpd_state = ST_DISCONNECTED;
 
 		if (ret == -ECONNRESET) { /* cable unplugged */
-			dp->core_initialized = false;
+			DRM_ERROR("dongle unplugged = %d\n", ret);
 		}
 
 	} else {
@@ -711,9 +711,15 @@ static int dp_irq_hpd_handle(struct dp_display_private *dp, u32 data)
 		return 0;
 	}
 
-	ret = dp_display_usbpd_attention_cb(&dp->pdev->dev);
-	if (ret == -ECONNRESET) { /* cable unplugged */
-		dp->core_initialized = false;
+	/*
+	 * dp core (ahb/aux clks) must be initialized before
+	 * irq_hpd be handled
+	 */
+	if (dp->core_initialized) {
+		ret = dp_display_usbpd_attention_cb(&dp->pdev->dev);
+		if (ret == -ECONNRESET) { /* cable unplugged */
+			DRM_ERROR("dongle unplugged = %d\n", ret);
+		}
 	}
 
 	mutex_unlock(&dp->event_mutex);
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index be986da..53ecae6 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -737,18 +737,25 @@ static int dp_link_parse_sink_count(struct dp_link *dp_link)
 	return 0;
 }
 
-static void dp_link_parse_sink_status_field(struct dp_link_private *link)
+static int dp_link_parse_sink_status_field(struct dp_link_private *link)
 {
 	int len = 0;
 
 	link->prev_sink_count = link->dp_link.sink_count;
-	dp_link_parse_sink_count(&link->dp_link);
+	len = dp_link_parse_sink_count(&link->dp_link);
+	if (len < 0) {
+		DRM_ERROR("DP parse sink count failed\n");
+		return len;
+	}
 
 	len = drm_dp_dpcd_read_link_status(link->aux,
 		link->link_status);
-	if (len < DP_LINK_STATUS_SIZE)
+	if (len < DP_LINK_STATUS_SIZE) {
 		DRM_ERROR("DP link status read failed\n");
-	dp_link_parse_request(link);
+		return len;
+	}
+
+	return dp_link_parse_request(link);
 }
 
 /**
@@ -1032,7 +1039,10 @@ int dp_link_process_request(struct dp_link *dp_link)
 
 	dp_link_reset_data(link);
 
-	dp_link_parse_sink_status_field(link);
+	ret = dp_link_parse_sink_status_field(link);
+	if (ret) {
+		return ret;
+	}
 
 	if (link->request.test_requested == DP_TEST_LINK_EDID_READ) {
 		dp_link->sink_request |= DP_TEST_LINK_EDID_READ;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

