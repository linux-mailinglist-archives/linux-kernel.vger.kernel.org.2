Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C9037607A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhEGGjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhEGGjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:39:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B43C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 23:38:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so4832832pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 23:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8n6iEvOkp7JFMHexk5IlQ4+H1eYCStP31Up2Te53h8=;
        b=eYRoMuYrsgXth/nt3aA95A0Ju5CDtmbNodAMrTcTWjzzch30d9zDPj1Pk41pfvPOXh
         bmtynlX9pri0zqwcv0ugGOckny3IyCN907m6hO9ueWM04m7w6KVWE1DDaRR8MgJwB5aP
         tKhot9yqISnmLO9IswFCHRDB/8zufUNFf1ufs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8n6iEvOkp7JFMHexk5IlQ4+H1eYCStP31Up2Te53h8=;
        b=R5e7NT27R2sNcE2ryvI6gZSyWIEfxC+ktgd50SAuCw10z3R43lqI5wCbSLN6WXpXQk
         Ct0mTmv3bRT5YnYpbXz0+84nOuF+kgC6GZpr0LUff2JZ9PuQCTWCDRDzh/3XKvQrZHEV
         V8u7E2so9B3k0/T2yosDixesl6tLPoVIHWdfrUgkEMb6OgfpWua0mTdKNcdTImgsGoBL
         3vCtnLTWeN8/ZSnyqRv2ZmPtDmsTlDlU0eW1ZSLqYv6wNnoiTihCHdT23zBILWd0493O
         fhq+9b5sY7VxJP4aOup1rGc76uFbbkE5IWadAIfTWTL/1bOZUC9g4yAmEgmtFon9IlmL
         H91Q==
X-Gm-Message-State: AOAM530UFfyKHhUxdvxU6lTpcQ+uduyRrBicRGBNgQ96ZudhSzHZuyE1
        tFTh1VJ70TMdEZxKPgbDAbXERg==
X-Google-Smtp-Source: ABdhPJzUkdsAWpxxZdSFoS6HX7Z3ySRUQePju+VXk3kq5Gi68K6cD7mpqAe5LA2qX/M0mQILuEakmw==
X-Received: by 2002:a17:90a:7063:: with SMTP id f90mr21964188pjk.95.1620369485497;
        Thu, 06 May 2021 23:38:05 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id d16sm3713345pgk.34.2021.05.06.23.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 23:38:05 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/bridge: anx7625: add suspend / resume hooks
Date:   Fri,  7 May 2021 14:35:48 +0800
Message-Id: <20210507063620.390280-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210507063620.390280-1-pihsun@chromium.org>
References: <20210507063620.390280-1-pihsun@chromium.org>
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
Change-Id: I62122cc2a4eafdfce4859cbb419edc39875ebe3b
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 0d90cd63fc27..dd23db9bc3d4 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1705,7 +1705,34 @@ static int __maybe_unused anx7625_runtime_pm_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused anx7625_resume(struct device *dev)
+{
+	struct anx7625_data *ctx = dev_get_drvdata(dev);
+
+	if (!ctx->pdata.intp_irq)
+		return 0;
+
+	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev))
+		anx7625_runtime_pm_resume(dev);
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
+	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev))
+		anx7625_runtime_pm_suspend(dev);
+
+	return 0;
+}
+
 static const struct dev_pm_ops anx7625_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(anx7625_suspend, anx7625_resume) \
 	SET_RUNTIME_PM_OPS(anx7625_runtime_pm_suspend, anx7625_runtime_pm_resume, NULL)
 };
 
-- 
2.31.1.607.g51e8a6a459-goog

