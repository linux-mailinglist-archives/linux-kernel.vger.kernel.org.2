Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3209C3B7A96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 01:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhF2XK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 19:10:28 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:28269 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhF2XKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 19:10:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625008077; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4MVe6HXC8G/ylS4AZcL9Y5Wq96e1GHDpzevUWYQSF3g=; b=K6ix0rw6bil2H2IvV/+1Sb9AuhfmO028cQdiq0wsKRRYim7RCpISLlkPh+wQXdZ4tS1p2Drt
 Dfxtgne6us12tg1XvWO2JFkPK8vfe8G9Gst7Dyfc9hSK947hIvbG+Cvm+IuHJvwoGF4KkV54
 AKPbiHA6U6L7zI4RsgLkP2G7HPY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60dba7cdad0600eedef638fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Jun 2021 23:07:57
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 021BDC4338A; Tue, 29 Jun 2021 23:07:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1BCBC433D3;
        Tue, 29 Jun 2021 23:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1BCBC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=khsieh@codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        lyude@redhat.com
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        khsieh@codeaurora.org, rsubbia@codeaurora.org,
        rnayak@codeaurora.org, freedreno@lists.freedesktop.org,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/dp_mst: Fix return code on sideband message failure
Date:   Tue, 29 Jun 2021 16:07:48 -0700
Message-Id: <1625008068-16458-1-git-send-email-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajkumar Subbiah <rsubbia@codeaurora.org>

Commit 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing +
selftests") added some debug code for sideband message tracing. But
it seems to have unintentionally changed the behavior on sideband message
failure. It catches and returns failure only if DRM_UT_DP is enabled.
Otherwise it ignores the error code and returns success. So on an MST
unplug, the caller is unaware that the clear payload message failed and
ends up waiting for 4 seconds for the response. Fixes the issue by
returning the proper error code.

Changes in V2:
-- Revise commit text as review comment
-- add Fixes text

Fixes: 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing + selftests")

Signed-off-by: Rajkumar Subbiah <rsubbia@codeaurora.org>
Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
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

