Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD863760A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhEGGqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEGGqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:46:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D92BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 23:45:04 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 10so7078022pfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 23:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIHsTVDwZUKi4vi9k4Fpg3xBhTApyQbvyQyxMFkYsrc=;
        b=d26LaPUx1V8G2u7iyjzwa6TD1uOLQsla+3gprsco0Qyf0YBATrj5upfNiSOVcng0zP
         +d2U08lRYunyyfDMfxyrKeYw6mAqshqthlNtnJqYgDW560vrbIHS648WVoXydxzG7iQa
         oquS939ukdR+NePaDVsSeFD+cX7vfMYSfPkow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIHsTVDwZUKi4vi9k4Fpg3xBhTApyQbvyQyxMFkYsrc=;
        b=uWxJ3FxF5Wdmqr5M+6Mr+lPZnXwuHQKCA0tzqd1VWlvw7x2pOsKCz04PFHfwswEfWC
         PXIfJs/9E/gRLvNYzqpwnF5jyy0xEpKvKk2VduSTPSYW+bngRwuEPWdzUcItjixA2tfh
         lZLkr8bRxACYX9/GxhrpsMq3DK4zD/tM31jKsyswAAt4xn0ndXPiPWLh+YBZBSjhmcdh
         4pd30assiapp2zO2F5MNLtvlbek4YXyll5WfIqIcdxxLo8GGKmKW/G6+cf11tBYlr0I9
         HeQp1UyYAkkqWdkRhgdsGUrpU2cSoDsFJVybiOVi/sZsqAQGjAj1roLAPcSQSfmJ1Jlg
         wunA==
X-Gm-Message-State: AOAM5311k07wRGyrXG0yLA2f+OytxEn1nhALsydz2h0H12PUAV009ssX
        6J6LDPd3ZJdyi3WhDsaLgXxlkw==
X-Google-Smtp-Source: ABdhPJycX+BcyuPk4GD4/gY//WkAgZYjPSW5XZIGBAf04Qda+DAqmhB3QeZIjpvaSsmpzE+RnbJMbg==
X-Received: by 2002:a62:8fd2:0:b029:28e:8c64:52a4 with SMTP id n201-20020a628fd20000b029028e8c6452a4mr8840625pfd.3.1620369903634;
        Thu, 06 May 2021 23:45:03 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id n27sm3931629pfv.142.2021.05.06.23.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 23:45:03 -0700 (PDT)
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
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/bridge: anx7625: add suspend / resume hooks
Date:   Fri,  7 May 2021 14:44:28 +0800
Message-Id: <20210507064444.402829-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210507064444.402829-1-pihsun@chromium.org>
References: <20210507064444.402829-1-pihsun@chromium.org>
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
 drivers/gpu/drm/bridge/analogix/anx7625.c | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index f56f8cf1f3bd..176d395c1a9f 100644
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
+	SET_SYSTEM_SLEEP_PM_OPS(anx7625_suspend, anx7625_resume)
 	SET_RUNTIME_PM_OPS(anx7625_runtime_pm_suspend,
 			   anx7625_runtime_pm_resume, NULL)
 };
-- 
2.31.1.607.g51e8a6a459-goog

