Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F8E377B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 07:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhEJFcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 01:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhEJFcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 01:32:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C90C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 22:31:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s20so8543725plr.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 22:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s3uZlkdD1HWKgRch2ttjuGoW2tvlVxTNtmyNQyMfx3E=;
        b=FFXr2jSenbxpqxMUI4nePQ7AdoB+B00Bp3IF+EaQmvS7YhIBktmcgcDSkpRCb6wHnJ
         yDpnvfJ5EbJg3BAiMn+epraOwT0GuwRnVlEjSuWVWProC7mcXBcUjeXKRuaZbESOm12a
         d4Cdk0yu5paVLskbeoCwautAqGT23OkKTINjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s3uZlkdD1HWKgRch2ttjuGoW2tvlVxTNtmyNQyMfx3E=;
        b=tXwD8ToZCpfOVKzz/JZuNNc4gXQnvZ9QqeBMbHDxpoaS9fDpmYpze0KMg6/T2dIowE
         swH4B4jxcNSGSClW3PirHFCOHkw6e7sfYGzZLHIleWLu760/jmRbK1XSkuPimuGeGETi
         bwAXvOwvnMyAx7g24QWe9o6D6eD8cAESqYhCn6PzOgNIXxoMWaBShArDvIwNRSwrUUaF
         72PTHv+8aOk93rKrhz8WBoiPhiy4JUOIC7P32yUXgaBezaeH6L7rVBh1Ks8qC9JHhzyM
         yaf+zaEP6nTEUr7rfZeMwx7SgzAemH9eh20yI9SeW6ghdrj19oMjTSTR37RJ+w4pcE4J
         1uhw==
X-Gm-Message-State: AOAM5333B0JEyyRZooi/RPye0Vy16775KuIAkt4RIMXdDEX+GPaS9Qz6
        erLy7AWj+IesmGAkfFd/GUc50Q==
X-Google-Smtp-Source: ABdhPJyClYsefcDI4WYWbIMRt4/1/G6Zslx9GrWyEsEGJiL5t27r81d3t1J/kW4j2r+Kyt/FSZgNJw==
X-Received: by 2002:a17:902:7c94:b029:e6:e1d7:62b7 with SMTP id y20-20020a1709027c94b02900e6e1d762b7mr22651481pll.29.1620624706378;
        Sun, 09 May 2021 22:31:46 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id w2sm10485834pfb.174.2021.05.09.22.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 22:31:45 -0700 (PDT)
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
Subject: [PATCH v3 2/2] drm/bridge: anx7625: add suspend / resume hooks
Date:   Mon, 10 May 2021 13:30:52 +0800
Message-Id: <20210510053125.1595659-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210510053125.1595659-1-pihsun@chromium.org>
References: <20210510053125.1595659-1-pihsun@chromium.org>
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

Changes from v2:
* No change.

---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index e1bf31eafe22..b165ef71e00f 100644
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

