Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0884834FF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhCaL1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:27:54 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:27604 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbhCaL1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:27:38 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 31 Mar 2021 04:27:38 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 31 Mar 2021 04:27:36 -0700
X-QCInternal: smtphost
Received: from kalyant-linux.qualcomm.com ([10.204.66.210])
  by ironmsg01-blr.qualcomm.com with ESMTP; 31 Mar 2021 16:57:04 +0530
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id BE5EA433F; Wed, 31 Mar 2021 04:27:02 -0700 (PDT)
From:   Kalyan Thota <kalyan_t@codeaurora.org>
To:     y@qualcomm.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, mkrishn@codeaurora.org, hywu@google.com,
        mka@google.com, midean@google.com, steev@kali.org
Subject: [v1] drm/msm/disp/dpu1: fix warn stack reported during dpu resume
Date:   Wed, 31 Mar 2021 04:27:00 -0700
Message-Id: <1617190020-7931-1-git-send-email-kalyan_t@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <y>
References: <y>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON was introduced by the below commit to catch runtime resumes
that are getting triggered before icc path was set.

"drm/msm/disp/dpu1: icc path needs to be set before dpu runtime resume"

For the targets where the bw scaling is not enabled, this WARN_ON is
a false alarm. Fix the WARN condition appropriately.

Reported-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  8 +++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h  |  9 +++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 11 ++++++-----
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index cab387f..0071a4d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -294,6 +294,9 @@ static int dpu_kms_parse_data_bus_icc_path(struct dpu_kms *dpu_kms)
 	struct icc_path *path1;
 	struct drm_device *dev = dpu_kms->dev;
 
+	if (!dpu_supports_bw_scaling(dev))
+		return 0;
+
 	path0 = of_icc_get(dev->dev, "mdp0-mem");
 	path1 = of_icc_get(dev->dev, "mdp1-mem");
 
@@ -934,8 +937,7 @@ static int dpu_kms_hw_init(struct msm_kms *kms)
 		DPU_DEBUG("REG_DMA is not defined");
 	}
 
-	if (of_device_is_compatible(dev->dev->of_node, "qcom,sc7180-mdss"))
-		dpu_kms_parse_data_bus_icc_path(dpu_kms);
+	dpu_kms_parse_data_bus_icc_path(dpu_kms);
 
 	pm_runtime_get_sync(&dpu_kms->pdev->dev);
 
@@ -1198,7 +1200,7 @@ static int __maybe_unused dpu_runtime_resume(struct device *dev)
 
 	ddev = dpu_kms->dev;
 
-	WARN_ON(!(dpu_kms->num_paths));
+	WARN_ON((dpu_supports_bw_scaling(ddev) && !dpu_kms->num_paths));
 	/* Min vote of BW is required before turning on AXI clk */
 	for (i = 0; i < dpu_kms->num_paths; i++)
 		icc_set_bw(dpu_kms->path[i], 0, Bps_to_icc(MIN_IB_BW));
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index d6717d6..f7bcc0a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -154,6 +154,15 @@ struct vsync_info {
 
 #define to_dpu_global_state(x) container_of(x, struct dpu_global_state, base)
 
+/**
+ * dpu_supports_bw_scaling: returns true for drivers that support bw scaling.
+ * @dev: Pointer to drm_device structure
+ */
+static inline int dpu_supports_bw_scaling(struct drm_device *dev)
+{
+	return of_device_is_compatible(dev->dev->of_node, "qcom,sc7180-mdss");
+}
+
 /* Global private object state for tracking resources that are shared across
  * multiple kms objects (planes/crtcs/etc).
  */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index cd40788..8cd712c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -41,6 +41,9 @@ static int dpu_mdss_parse_data_bus_icc_path(struct drm_device *dev,
 	struct icc_path *path0 = of_icc_get(dev->dev, "mdp0-mem");
 	struct icc_path *path1 = of_icc_get(dev->dev, "mdp1-mem");
 
+	if (dpu_supports_bw_scaling(dev))
+		return 0;
+
 	if (IS_ERR_OR_NULL(path0))
 		return PTR_ERR_OR_ZERO(path0);
 
@@ -276,11 +279,9 @@ int dpu_mdss_init(struct drm_device *dev)
 
 	DRM_DEBUG("mapped mdss address space @%pK\n", dpu_mdss->mmio);
 
-	if (!of_device_is_compatible(dev->dev->of_node, "qcom,sc7180-mdss")) {
-		ret = dpu_mdss_parse_data_bus_icc_path(dev, dpu_mdss);
-		if (ret)
-			return ret;
-	}
+	ret = dpu_mdss_parse_data_bus_icc_path(dev, dpu_mdss);
+	if (ret)
+		return ret;
 
 	mp = &dpu_mdss->mp;
 	ret = msm_dss_parse_clock(pdev, mp);
-- 
2.7.4

