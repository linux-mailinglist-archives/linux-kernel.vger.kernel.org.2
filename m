Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831F8382474
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbhEQGhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbhEQGh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:37:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FA9C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 23:36:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b21so2586158plz.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Tg/RgH3lp5a6IJvwx2oVZOXwmXN1gNn/tsf5GPtb30=;
        b=MVc5tdGuSSUGmOzbRzu21NtT/fVffglYdp2tHOwdLEDQEOl37jDtoulN8H0ED38KMq
         LTXzbhVAf4v4A70E7+h6V+hP6ckzhj23OQ+7/wUX0FM009eDjwgF6VqmZywn/uJeM0LL
         zauYn3zpV5igIJ9RmdyJOYHF0+MfLMsB5kQaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Tg/RgH3lp5a6IJvwx2oVZOXwmXN1gNn/tsf5GPtb30=;
        b=EE5ChAAzlf6QuW92ZLc/NpBJb9NU4d+xzLTgvq9LvN8KTQZbsq0Ee46K4WCdL3PCC3
         k9f1GRvTGGH67SVhOA/nr2T3kHYmdePGaMBnKU2GhcDHcUzWV6wTsB6PRlWKSUVnLZ7t
         LWJT0OOR7eeBTzSPC740UmKV3PAGFwTf15Pent0T5g6i+nQhosA/2TAJlZ9AK5edJ+NB
         O1ufP2jMVdtqYtUvZ248S6QFMwbCtdBksw8XPWAXJYu42LIIQJYq5O9WsW+iWseXeIHJ
         QhR1tg2MLRv1hl/SD9a6RwPYkNGfa7m3CLI5PgQHZol7f9O1C49FojMgrmRhDCdwYmmo
         OT+w==
X-Gm-Message-State: AOAM5307AEaPIM45M4e2I1x0antIhEMPFEdSnUQkD6EmZBkO7frGOpZ8
        qh5s5GqKFK9hnzFf4tMUrRDCWg==
X-Google-Smtp-Source: ABdhPJy9094BrnHnEUXn71wH1HENbeF/VCLgouqXsZoavo6R53U59pCdxn2vVifSvk0jvhwwVUNn9g==
X-Received: by 2002:a17:90a:f18e:: with SMTP id bv14mr18728495pjb.234.1621233370562;
        Sun, 16 May 2021 23:36:10 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id js6sm13287612pjb.0.2021.05.16.23.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 23:36:10 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/2] drm/bridge: anx7625: add suspend / resume hooks
Date:   Mon, 17 May 2021 14:35:29 +0800
Message-Id: <20210517063553.554955-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210517063553.554955-1-pihsun@chromium.org>
References: <20210517063553.554955-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend / resume hooks for anx7625 driver, that power off the device
on suspend and power on the device on resume if it was previously
powered.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---

Changes in v5:
* Disable irq and flush workqueue in suspend hook, so the irq handler
  won't be run during suspend.

Changes in v3, v4:
* No change.

---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index e1bf31eafe22..8fb76ca66e5b 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1705,7 +1705,39 @@ static int __maybe_unused anx7625_runtime_pm_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused anx7625_resume(struct device *dev)
+{
+	struct anx7625_data *ctx = dev_get_drvdata(dev);
+
+	if (!ctx->pdata.intp_irq)
+		return 0;
+
+	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
+		enable_irq(ctx->pdata.intp_irq);
+		anx7625_runtime_pm_resume(dev);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused anx7625_suspend(struct device *dev)
+{
+	struct anx7625_data *ctx = dev_get_drvdata(dev);
+
+	if (!ctx->pdata.intp_irq)
+		return 0;
+
+	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
+		anx7625_runtime_pm_suspend(dev);
+		disable_irq(ctx->pdata.intp_irq);
+		flush_workqueue(ctx->workqueue);
+	}
+
+	return 0;
+}
+
 static const struct dev_pm_ops anx7625_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(anx7625_suspend, anx7625_resume)
 	SET_RUNTIME_PM_OPS(anx7625_runtime_pm_suspend,
 			   anx7625_runtime_pm_resume, NULL)
 };
-- 
2.31.1.751.gd2f1c929bd-goog

