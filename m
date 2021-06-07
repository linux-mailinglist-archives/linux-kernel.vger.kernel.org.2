Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A71A39E4EE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhFGRJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:09:23 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:36370 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhFGRJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:09:20 -0400
Received: by mail-pf1-f176.google.com with SMTP id c12so13593708pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmqJKJaio2UDvF9xWIYCt9beN4jtSVXClXFJ93Ass0A=;
        b=MJdW8d4EwaL+R83An/5pzeXye/1/jXAwqOAFbdqpc35JCNHPRpC52nlqeRia99DSPi
         mmTVuQicx/skRC356CF6cLgaKYvKhfeR3yxrai8kYSBhBkbtQqzwg5RCwaiuduMr1z2y
         3UKADJKUlio1j791HLEQwcaE2ianIo07Ciliw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmqJKJaio2UDvF9xWIYCt9beN4jtSVXClXFJ93Ass0A=;
        b=i83w21TCMqtA4o+eIcoLOrt0isCA6uvqWJmGS+PcTaDxsN3uKoG1KGYkrkeHoC10Uf
         u460tpC2J6l+gjm5iPUoV/RbH1S2PSVzxQ5joRT+iSghpGUr28Ny0n6ajqxRj9eoQX9f
         LuRDQYvUehlSkE4tbCk9NltxI6E1q30ccJUD2o1bjTTL5RYvHm8a+2ywk65Pt5Cedm/g
         oKZdOyRZ4SPagRuF+LOL4y6In0OsmvqvafjvTc3w8YAdZcPLCN2sMfbsY5f1dcw4wa2O
         S7Uo5NYgt7XTiGuDGhCbEJ7zKy+VDHJtCpvnairkexC5cM4W1akNvJ5VfFmidvfVTiaR
         ZdjA==
X-Gm-Message-State: AOAM531fmE6EodeJOV7cyixijVnfz/U9VJE7wz3i2c5hDRwIWfwV+Qpy
        YxA5HRDCClK0kFcCvgkrYm5JTw==
X-Google-Smtp-Source: ABdhPJxWm5zAogtb/40ohfpKI3yOwMuv5/+I42ZxgoktT3GJWrGbX9nIiWib55xdRXhF5wGOpNebrg==
X-Received: by 2002:aa7:9537:0:b029:2ea:2312:d2cb with SMTP id c23-20020aa795370000b02902ea2312d2cbmr17629610pfp.27.1623085589204;
        Mon, 07 Jun 2021 10:06:29 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f656:ffce:6348:a42a])
        by smtp.gmail.com with ESMTPSA id fs24sm12897639pjb.6.2021.06.07.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:06:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Linus W <linus.walleij@linaro.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 10/11] drm/bridge: ti-sn65dsi86: Improve probe errors with dev_err_probe()
Date:   Mon,  7 Jun 2021 10:05:54 -0700
Message-Id: <20210607100234.v9.10.I24bba069e63b1eea84443eef0c8535fd032a6311@changeid>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
In-Reply-To: <20210607170555.4006050-1-dianders@chromium.org>
References: <20210607170555.4006050-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I was testing to make sure that the DEFER path worked well with my
patch series, I got tired of seeing this scary message in my logs just
because the panel needed to defer:
  [drm:ti_sn_bridge_probe] *ERROR* could not find any panel node

Let's use dev_err_probe() which nicely quiets this error and also
simplifies the code a tiny bit. We'll also update other places in the
file which can use dev_err_probe().

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v9:
- ("Improve probe errors") patch new for v9.

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 31 +++++++++++----------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index b544cbce7fdd..5d712c8c3c3b 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1305,10 +1305,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 	int ret;
 
 	ret = drm_of_find_panel_or_bridge(np, 1, 0, &pdata->panel, NULL);
-	if (ret) {
-		DRM_ERROR("could not find any panel node\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&adev->dev, ret,
+				     "could not find any panel node\n");
 
 	ti_sn_bridge_parse_lanes(pdata, np);
 
@@ -1456,27 +1455,23 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
 
 	pdata->regmap = devm_regmap_init_i2c(client,
 					     &ti_sn65dsi86_regmap_config);
-	if (IS_ERR(pdata->regmap)) {
-		DRM_ERROR("regmap i2c init failed\n");
-		return PTR_ERR(pdata->regmap);
-	}
+	if (IS_ERR(pdata->regmap))
+		return dev_err_probe(dev, PTR_ERR(pdata->regmap),
+				     "regmap i2c init failed\n");
 
 	pdata->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
-	if (IS_ERR(pdata->enable_gpio)) {
-		DRM_ERROR("failed to get enable gpio from DT\n");
-		ret = PTR_ERR(pdata->enable_gpio);
-		return ret;
-	}
+	if (IS_ERR(pdata->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(pdata->enable_gpio),
+				     "failed to get enable gpio from DT\n");
 
 	ret = ti_sn65dsi86_parse_regulators(pdata);
-	if (ret) {
-		DRM_ERROR("failed to parse regulators\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to parse regulators\n");
 
 	pdata->refclk = devm_clk_get_optional(dev, "refclk");
 	if (IS_ERR(pdata->refclk))
-		return PTR_ERR(pdata->refclk);
+		return dev_err_probe(dev, PTR_ERR(pdata->refclk),
+				     "failed to get reference clock\n");
 
 	pm_runtime_enable(dev);
 	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_runtime_disable, dev);
-- 
2.32.0.rc1.229.g3e70b5a671-goog

