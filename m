Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74EA3AFB52
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 05:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhFVDMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 23:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhFVDMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 23:12:06 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A31EC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 20:09:50 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v11-20020a9d340b0000b0290455f7b8b1dcso6927081otb.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 20:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJaXR0MvWTLUMUBxm6vEFmtzzq3mthCeXlJRBUTcj0k=;
        b=JjFGC6CPjqlXte5fKt+wg8qPPb7RoF6xEWbQtpUeivEI7CVJIhOD8nkxVDBvUaM3bE
         +9q+NYvGp6FFv84lXRcowgz3f87+O0L4YEbpgiawuezPJs6YAUUvJmNdZ4Iqyz8xycs8
         inTuVW3hN35wrWcnsO7aMGmrh3TDPKPsdU4d3HNrLNa8Nqi4HQWLIGIMdKEAvTsfjjj0
         thubd0GPQmhiHKlwnKgrPau+SpI5HGN3lSsmd0QJ5zBgIxaaZh/2eGFhFILpxp1p5GRk
         PWWwOuGx+NZeDbJO+jv9mA/yZVzFJg4neUMYzCFoafsl3jhHCGIU1kIp9pzkEjuN1oIM
         QspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJaXR0MvWTLUMUBxm6vEFmtzzq3mthCeXlJRBUTcj0k=;
        b=DynO6hbnS+fxAuljp9wBXDmXqRX6Bku4Xmk7WveHgLHn9VbGLu2VTgVpd+Gdz/Bv5q
         fabPhFbkfvF8V7d+9gEedhC9FjYmb3CobSqmKEsGuWTaaWFiTu/TO7Y3eIUhBOVwunSu
         7lQb1kIYCWgcB1Vi1BIJCbD5XpwrhEHS0KUsJaaK5hmBghR55TldhkQcTaExPmT/nUlP
         Q5+7Q99W5lTHR5J2NJ0LEn+PHNuyNfLcKqPy23s9Sm884l5ouIwBcxlxTSddpwrSKzgu
         3QEwVPB9UaxpftnBNJZv9iqjgUmTIuiNe57VVnN+i08zVy2X2L5PhlraUHPsrgEPffMZ
         RLFA==
X-Gm-Message-State: AOAM531FyPKmzF3qCBMoV4Gni8crW24j5ixLH6D67qz2PRv3h6gCm+QZ
        gInHgspb3LeXrRE0rUilVV8z8w==
X-Google-Smtp-Source: ABdhPJwjJhzKb2EkdUdagJpaCej1dmFSqwYlH+F+rbKPdjgh7NJF6+8WPzYwDKKjEZLT4CS07R07kw==
X-Received: by 2002:a9d:6303:: with SMTP id q3mr1126330otk.197.1624331389610;
        Mon, 21 Jun 2021 20:09:49 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d10sm243454oop.3.2021.06.21.20.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:09:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v3 1/2] pwm: Introduce single-PWM of_xlate function
Date:   Mon, 21 Jun 2021 22:09:47 -0500
Message-Id: <20210622030948.966748-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing pxa driver and the upcoming addition of PWM support in the
TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
thereby a need for a of_xlate function with the period as its single
argument.

Introduce a common helper function in the core that can be used as
of_xlate by such drivers and migrate the pxa driver to use this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 drivers/pwm/core.c    | 26 ++++++++++++++++++++++++++
 drivers/pwm/pwm-pxa.c | 16 +---------------
 include/linux/pwm.h   |  2 ++
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a42999f877d2..5e9c876fccc4 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -152,6 +152,32 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 }
 EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
+struct pwm_device *
+of_pwm_single_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	if (pc->of_pwm_n_cells < 1)
+		return ERR_PTR(-EINVAL);
+
+	/* validate that one cell is specified, optionally with flags */
+	if (args->args_count != 1 && args->args_count != 2)
+		return ERR_PTR(-EINVAL);
+
+	pwm = pwm_request_from_chip(pc, 0, NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm->args.period = args->args[0];
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+
+	if (args->args_count == 2 && args->args[2] & PWM_POLARITY_INVERTED)
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
+
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
+
 static void of_pwmchip_add(struct pwm_chip *chip)
 {
 	if (!chip->dev || !chip->dev->of_node)
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index cfb683827d32..8cd82fb54483 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -148,20 +148,6 @@ static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
 	return id ? id->data : NULL;
 }
 
-static struct pwm_device *
-pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
-{
-	struct pwm_device *pwm;
-
-	pwm = pwm_request_from_chip(pc, 0, NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
-	pwm->args.period = args->args[0];
-
-	return pwm;
-}
-
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -187,7 +173,7 @@ static int pwm_probe(struct platform_device *pdev)
 	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
 
 	if (IS_ENABLED(CONFIG_OF)) {
-		pwm->chip.of_xlate = pxa_pwm_of_xlate;
+		pwm->chip.of_xlate = of_pwm_single_xlate;
 		pwm->chip.of_pwm_n_cells = 1;
 	}
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 5a73251d28e3..6aff1fa4fe5d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -411,6 +411,8 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
+struct pwm_device *of_pwm_single_xlate(struct pwm_chip *pc,
+				       const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
 struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
-- 
2.31.0

