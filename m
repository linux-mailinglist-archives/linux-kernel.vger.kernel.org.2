Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA453B7918
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 22:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbhF2UL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:11:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60169 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232636AbhF2ULx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:11:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624997366; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Dhc0W9vUgT2dL4RFtAFw6gqKf7r7LCHzbli6TwXb/Gc=; b=BtEhHC4GC8cYA9veENdtzNIVXHbX30lxyQTsFUnmcL+kgjCpeABSKStLOs1H9zVZlA7DTp0I
 e6TiwwjejhZ16b3PlSSJHTmUZnNWEMYDp5yzsTPd5oV4vY+UB4UUox6KtvW0SbhTX+xm9NS5
 YMZSNjYY8ma5RQRvo2/duN0wEPs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60db7de7ec0b18a745bfd4ec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Jun 2021 20:09:11
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0534C4360C; Tue, 29 Jun 2021 20:09:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8D04C433F1;
        Tue, 29 Jun 2021 20:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8D04C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=khsieh@codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        khsieh@codeaurora.org, rsubbia@codeaurora.org,
        rnayak@codeaurora.org, freedreno@lists.freedesktop.org,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp_mst: Fix return code on sideband message failure
Date:   Tue, 29 Jun 2021 13:08:56 -0700
Message-Id: <1624997336-2245-1-git-send-email-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajkumar Subbiah <rsubbia@codeaurora.org>

The commit 2f015ec6eab69301fdcf54d397810d72362d7223 added some debug
code for sideband message tracing. But it seems to have unintentionally
changed the behavior on sideband message failure. It catches and returns
failure only if DRM_UT_DP is enabled. Otherwise it ignores the error code
and returns success. So on an MST unplug, the caller is unaware that the
clear payload message failed and ends up waiting for 4 seconds for the
response.

This change fixes the issue by returning the proper error code.

Change-Id: I2887b7ca21355fe84a7968f7619d5e8199cbb0c6
Signed-off-by: Rajkumar Subbiah <rsubbia@codeaurora.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 1590144..8d97430 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2887,11 +2887,13 @@ static int process_single_tx_qlock(struct drm_dp_mst_topology_mgr *mgr,
 	idx += tosend + 1;
 
 	ret = drm_dp_send_sideband_msg(mgr, up, chunk, idx);
-	if (unlikely(ret) && drm_debug_enabled(DRM_UT_DP)) {
-		struct drm_printer p = drm_debug_printer(DBG_PREFIX);
+	if (unlikely(ret)) {
+		if (drm_debug_enabled(DRM_UT_DP)) {
+			struct drm_printer p = drm_debug_printer(DBG_PREFIX);
 
-		drm_printf(&p, "sideband msg failed to send\n");
-		drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
+			drm_printf(&p, "sideband msg failed to send\n");
+			drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
+		}
 		return ret;
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

