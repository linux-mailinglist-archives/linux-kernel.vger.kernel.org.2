Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD64138055F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhENIl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhENIl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:41:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4602FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:40:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l70so8950442pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQD5W//6qmU+fiOo2Heku1L5eiqC6QuwAWjwU59qtmI=;
        b=fOmKA+Y0CyFV2ByMsQ3u0D996/to6XI1BcFSpDr0UsQIsX3fmKDEBwaSV+PeIUcUjk
         rU4c0g2xt8Jo40by7Z8SRvYqcPBjZOPSeuNvfsVjwix0y5QWF1Eslqvj8AhpFn3bsKmA
         Ufhf6E902r6/q4gF2nIbxy+OA+yYVQ9bub0dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQD5W//6qmU+fiOo2Heku1L5eiqC6QuwAWjwU59qtmI=;
        b=jhfNMfmgcDrgLcL9vDs+eD3QT66Ieeymwg0LOAtsFi93dOMn7g7TlBBUrwyUF5gaC7
         VTAfIjA9wWD5d1uLYXowqF13K+nz4rDB1mGnuo11CpklnSYUFqfyk5nFxGcRzYYKrHcb
         oj65FvxTz2lfUb13HoiCS3icJPFSB/SyCFqlbnSBP4OebJO1uUz4iAdpHlo8j7fvQuMK
         N3tGmOpm0CKaqew9fbGZ3hzvQgywf+/JvtQEt/AKkiY2GMO/otaW0VRMr9bzitCVOkd8
         i48gqFMTqh6MN+TOafQFU6aIIxcfdL2YGX8DygEgWqwu8410hwX8684XfK8aR4Cwmqt8
         J3dA==
X-Gm-Message-State: AOAM532Jcx2zpg4GodQp9gSfLtx06v5445qWvdn4A2Ihj7cIY/O2BrXW
        getWDuSUFFSAxIjj7gd/YIaa1HoJ7oRTgQ==
X-Google-Smtp-Source: ABdhPJw/f6yVtndqEXsRSCqmitdwfa9LxhD1IuosqXYqYMkyP9uKMU7QK5ejWV4YqZzKdofZPuWOBQ==
X-Received: by 2002:a62:4e96:0:b029:2c5:3067:90ab with SMTP id c144-20020a624e960000b02902c5306790abmr21762308pfb.38.1620981644891;
        Fri, 14 May 2021 01:40:44 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id oa3sm6811843pjb.1.2021.05.14.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 01:40:44 -0700 (PDT)
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
Subject: [PATCH v4 2/2] drm/bridge: anx7625: add suspend / resume hooks
Date:   Fri, 14 May 2021 16:37:43 +0800
Message-Id: <20210514083804.3594748-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210514083804.3594748-1-pihsun@chromium.org>
References: <20210514083804.3594748-1-pihsun@chromium.org>
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

Changes from v2, v3:
* No change.

---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index b0a53d6a2343..4f5537c9b3d4 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1707,7 +1707,34 @@ static int __maybe_unused anx7625_runtime_pm_resume(struct device *dev)
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
2.31.1.751.gd2f1c929bd-goog

