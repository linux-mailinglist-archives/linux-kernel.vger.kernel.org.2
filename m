Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1B446F51
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 18:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbhKFRXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 13:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhKFRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 13:23:50 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E740C061714
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 10:21:09 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id bl27so17194107oib.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTSLEwZ2lTdgm04aqi8C+KVIKM9ISYcIdJi5xTJQmDQ=;
        b=TM7HT/3kUvCVkyIyxqrla2bPoXwiNaUgVa/rkdmDjclsBlQ+MF4cgYeM/LlxxQn+u+
         Upxm0KHjHAlzeiGcjmD3wX0/bO2011j3SFBKR+42KzRtu3rUHR486mXtat3EwEIQLY5O
         xB5EJZNBvZHyQap3cH0THKAk/lKVH3CLTC/c2HSCGZBqt6vc6Dn//I+0ydBVp/BrFWgv
         8KpLjGyF3Ozozmncwwdp2w9H5NjqlVxTFPofh5Hfo7RiO99fV3XnkB2PN8voK5dB71ik
         jlwRhUwFz+mvHuqzHdqZI64R6e/1wCRhpaOuvqeibUZLnmp+SQ9JSFe6+Mz0OQxOzpUU
         7nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTSLEwZ2lTdgm04aqi8C+KVIKM9ISYcIdJi5xTJQmDQ=;
        b=A9nhombdhNqXhdd93er1C0R8bBE6NQnv4IiditLNxV3TsViNoNQTPHAgoO8qucuC0j
         xkVy7Oa/s+j86PTM5ln4fvnGapqfto8VTEn8e1pOmSJLLOLOrkDzx7gh2Ro3Si+xc4Pb
         UGWtwiFSWb/Lz5qZq1uHzA76U9oqKFla0daT95EX9Jf2OXtjI4FZjSYu0f7IKuX1vZHO
         4+xPkyEbt4P3hW3bJANTCEnxv/HZDMwIphlBDhsRcplAHp5QiKuifeLwVPff1ZX3MglJ
         z7Fyz+2tUJE/wMltamlvyfnc2xTT2SBmYZdLMimr0KRCqFxWkSGMHV/ouJUes7tUY+54
         27HQ==
X-Gm-Message-State: AOAM533YoEbvs5D3R62IsJnZsozNQbJouHWSiuLtlMu9WtUkyXQj5LzF
        OOyAH6jaOtmPZxabAIzth8aIBQ==
X-Google-Smtp-Source: ABdhPJwqV+YJ+7OmqgyefLnoB9WNSGrGUryYUqJWPS8f6XLyzo2xKmxNbd/mkUmHKL02UYGvTeOrxw==
X-Received: by 2002:a05:6808:1897:: with SMTP id bi23mr6223384oib.111.1636219268707;
        Sat, 06 Nov 2021 10:21:08 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 64sm3905304otm.37.2021.11.06.10.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:21:08 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: Drop now unused hpd_high member
Date:   Sat,  6 Nov 2021 10:22:46 -0700
Message-Id: <20211106172246.2597431-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since '8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon
Chipsets")' the hpd_high member of struct dp_usbpd has been write-only.

Let's clean up the code a little bit by removing the writes as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 6 ------
 drivers/gpu/drm/msm/dp/dp_hpd.c     | 2 --
 drivers/gpu/drm/msm/dp/dp_hpd.h     | 2 --
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index aba8aa47ed76..70177c0d6a37 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -522,11 +522,8 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 
 	dp->hpd_state = ST_CONNECT_PENDING;
 
-	hpd->hpd_high = 1;
-
 	ret = dp_display_usbpd_configure_cb(&dp->pdev->dev);
 	if (ret) {	/* link train failed */
-		hpd->hpd_high = 0;
 		dp->hpd_state = ST_DISCONNECTED;
 
 		if (ret == -ECONNRESET) { /* cable unplugged */
@@ -603,7 +600,6 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 		/* triggered by irq_hdp with sink_count = 0 */
 		if (dp->link->sink_count == 0) {
 			dp_ctrl_off_phy(dp->ctrl);
-			hpd->hpd_high = 0;
 			dp->core_initialized = false;
 		}
 		mutex_unlock(&dp->event_mutex);
@@ -627,8 +623,6 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 	/* disable HPD plug interrupts */
 	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, false);
 
-	hpd->hpd_high = 0;
-
 	/*
 	 * We don't need separate work for disconnect as
 	 * connect/attention interrupts are disabled
diff --git a/drivers/gpu/drm/msm/dp/dp_hpd.c b/drivers/gpu/drm/msm/dp/dp_hpd.c
index e1c90fa47411..db98a1d431eb 100644
--- a/drivers/gpu/drm/msm/dp/dp_hpd.c
+++ b/drivers/gpu/drm/msm/dp/dp_hpd.c
@@ -32,8 +32,6 @@ int dp_hpd_connect(struct dp_usbpd *dp_usbpd, bool hpd)
 	hpd_priv = container_of(dp_usbpd, struct dp_hpd_private,
 					dp_usbpd);
 
-	dp_usbpd->hpd_high = hpd;
-
 	if (!hpd_priv->dp_cb || !hpd_priv->dp_cb->configure
 				|| !hpd_priv->dp_cb->disconnect) {
 		pr_err("hpd dp_cb not initialized\n");
diff --git a/drivers/gpu/drm/msm/dp/dp_hpd.h b/drivers/gpu/drm/msm/dp/dp_hpd.h
index 5bc5bb64680f..8feec5aa5027 100644
--- a/drivers/gpu/drm/msm/dp/dp_hpd.h
+++ b/drivers/gpu/drm/msm/dp/dp_hpd.h
@@ -26,7 +26,6 @@ enum plug_orientation {
  * @multi_func: multi-function preferred
  * @usb_config_req: request to switch to usb
  * @exit_dp_mode: request exit from displayport mode
- * @hpd_high: Hot Plug Detect signal is high.
  * @hpd_irq: Change in the status since last message
  * @alt_mode_cfg_done: bool to specify alt mode status
  * @debug_en: bool to specify debug mode
@@ -39,7 +38,6 @@ struct dp_usbpd {
 	bool multi_func;
 	bool usb_config_req;
 	bool exit_dp_mode;
-	bool hpd_high;
 	bool hpd_irq;
 	bool alt_mode_cfg_done;
 	bool debug_en;
-- 
2.33.1

