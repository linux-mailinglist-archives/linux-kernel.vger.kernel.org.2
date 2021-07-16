Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF93CB5F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbhGPKZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbhGPKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:25:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E44C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:22:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i94so11477620wri.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RH8cJpfI22EW3WzQFW97y0L55bfdGZoYafA5iYEI+Gs=;
        b=xSyYife0tK8Wfn1AeIqVivedOLa58eDWnp2XZ/NO8MbdLNwDv2h5WY/icWPtYUorEv
         THnhvCJFfY7DbION+eaZnVdlFIo738ELu3z8hK8jH9RXCWUgYR+QwdMIBb8qsBjl3AID
         dYx6WsO6/rcNYAtbvNOFWhUB4TLof2I2fLpplYd6Z2pMjhgEBipZ1gVN6l435fPoOyTy
         OfLIyNn28MNMJJOT343A8thpGAzWkTSshp8RvfD3OK+6la4NtmUSs9JbNjDY9uBlRcqo
         wowE1Y6vWw9i+wu7Iohh1HamHfw3xUnGcc6srf/d+35Zhht1z42oazBl3f3f3voecOar
         Vbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RH8cJpfI22EW3WzQFW97y0L55bfdGZoYafA5iYEI+Gs=;
        b=Fg3gYf9pPy/SQeGBqiL2qoM1PR/FGtQKmWZ81qrbKvpITWm3lCEDQ+Zj3veCxwpXKZ
         jr3MsPJ3bC5KVRm2spOylU2E9pDpI9RMoqFHXw72Ph45c+VX0ENOd9dNb/VvcLiFY/o2
         AH1n2YrthR0SMtbylcJZkxeHH/qf4ntOF40U9nWbK5CoPN2+dWmvSaeq45eynCPSZSF7
         dwM4w30ydnYCkXsyGuB/TtDpD+ItkcEGeEJrONPI4hEc5gH/RoOfxXPPVa0fmGpL9ZLi
         exQFRfqa9yBK/Qjy1sw+v+a1H/Mov3wld+z+CrtLz7rUTFWiJ3Vdb5Qqp5jnWqmqnr4N
         8z1g==
X-Gm-Message-State: AOAM530xsfrMHj2XQoT/gJMBmA2WicIdyN9v1yFLs1H/qq2EGk3u2XuD
        VB4nVRWLtz8RcpPIYG19otMaiQ==
X-Google-Smtp-Source: ABdhPJxkdjbtScSNsWZzVR5VWqcv2L/5BW51zAQpb8zHod1cXpcF3Ss+cnsGhFs2Bqw+BOUK9cyoNA==
X-Received: by 2002:adf:e107:: with SMTP id t7mr11391576wrz.165.1626430958309;
        Fri, 16 Jul 2021 03:22:38 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g15sm7421796wmh.44.2021.07.16.03.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:22:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] slimbus: ngd: set correct device for pm
Date:   Fri, 16 Jul 2021 11:21:22 +0100
Message-Id: <20210716102123.26861-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210716102123.26861-1-srinivas.kandagatla@linaro.org>
References: <20210716102123.26861-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason we ended up using wrong device in some places for pm_runtime calls.
Fix this so that NGG driver can do runtime pm correctly.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index c054e83ab636..f3ee8e036372 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -618,7 +618,7 @@ static void qcom_slim_ngd_rx(struct qcom_slim_ngd_ctrl *ctrl, u8 *buf)
 		(mc == SLIM_USR_MC_GENERIC_ACK &&
 		 mt == SLIM_MSG_MT_SRC_REFERRED_USER)) {
 		slim_msg_response(&ctrl->ctrl, &buf[4], buf[3], len - 4);
-		pm_runtime_mark_last_busy(ctrl->dev);
+		pm_runtime_mark_last_busy(ctrl->ctrl.dev);
 	}
 }
 
@@ -1257,13 +1257,14 @@ static int qcom_slim_ngd_enable(struct qcom_slim_ngd_ctrl *ctrl, bool enable)
 		}
 		/* controller state should be in sync with framework state */
 		complete(&ctrl->qmi.qmi_comp);
-		if (!pm_runtime_enabled(ctrl->dev) ||
-				!pm_runtime_suspended(ctrl->dev))
-			qcom_slim_ngd_runtime_resume(ctrl->dev);
+		if (!pm_runtime_enabled(ctrl->ctrl.dev) ||
+			 !pm_runtime_suspended(ctrl->ctrl.dev))
+			qcom_slim_ngd_runtime_resume(ctrl->ctrl.dev);
 		else
-			pm_runtime_resume(ctrl->dev);
-		pm_runtime_mark_last_busy(ctrl->dev);
-		pm_runtime_put(ctrl->dev);
+			pm_runtime_resume(ctrl->ctrl.dev);
+
+		pm_runtime_mark_last_busy(ctrl->ctrl.dev);
+		pm_runtime_put(ctrl->ctrl.dev);
 
 		ret = slim_register_controller(&ctrl->ctrl);
 		if (ret) {
@@ -1389,7 +1390,7 @@ static int qcom_slim_ngd_ssr_pdr_notify(struct qcom_slim_ngd_ctrl *ctrl,
 		/* Make sure the last dma xfer is finished */
 		mutex_lock(&ctrl->tx_lock);
 		if (ctrl->state != QCOM_SLIM_NGD_CTRL_DOWN) {
-			pm_runtime_get_noresume(ctrl->dev);
+			pm_runtime_get_noresume(ctrl->ctrl.dev);
 			ctrl->state = QCOM_SLIM_NGD_CTRL_DOWN;
 			qcom_slim_ngd_down(ctrl);
 			qcom_slim_ngd_exit_dma(ctrl);
-- 
2.21.0

