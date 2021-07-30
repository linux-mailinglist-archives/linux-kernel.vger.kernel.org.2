Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C18C3DBC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhG3PrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhG3Pqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:46:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD1C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 08:46:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d1so11588670pll.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwSmr0q+48EViXZc4b851/kYEl2MZkqBSTHsZnuCGcY=;
        b=Wc9iTLv1yDwhUiq6FWBNiGYr5MFcjpXlCNCpQ3PnDblf13m1r884dznPr11ikMX5C1
         n9iaL1HlwkK2Js+t1r07ILEa60uHXYrFIh08FjIyuFQNaM97mN9e1SvYtXflxSSU2lK8
         /kcrUiPpIjJ7Mv5WSdn+VyCX5it4xNVmxHKQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwSmr0q+48EViXZc4b851/kYEl2MZkqBSTHsZnuCGcY=;
        b=lcVge7Dp96JSyHQy/ioPHOW1Uyw2nYVxk+T8aU+FUCWIDphlixk/X7EiV/xo/8CVKs
         NcyNzwOsf4a+eSoNIUCdKKpGsjsEuYMoXUI23zkqT3OoinZEJKEaXUtHz6mMZPs3l2Cm
         psvVwT8GkaS7rihzi0gQG/YsZV1MqRRBHyYaJ1uDsE66dBgOKRN0mwkJ7pxPProKO6VD
         tIolUc6o9sNShdo0ZqC/ND03s9mvZ9bCLcVZY6FcwuBdTlD7xr5jTXccWcOJFBMKKNSB
         DmfrF79eTeR4Ak6kEJa4MJwLkgzh3+NE2BHdTCmSuUeaK5oLqKZUyDyy7wErOAWmB6Fj
         npIg==
X-Gm-Message-State: AOAM53082NAKvvbgL50g87MWm6iz/lCtCUAxvI+f7cQT4lQtwpWFS1tP
        gjHHIRAzZG9O9/FB9Uu1yrAKqg==
X-Google-Smtp-Source: ABdhPJwjl27iD+vmi5M/7UAYGZcp6sUU3Ey9VAipZ2ohmnSSJey59HYr9WFQy6cwWyRdHXbjvtERJQ==
X-Received: by 2002:a63:5a42:: with SMTP id k2mr2947631pgm.301.1627660008493;
        Fri, 30 Jul 2021 08:46:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3424:e0ac:5a92:d061])
        by smtp.gmail.com with ESMTPSA id u188sm3175621pfc.115.2021.07.30.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:46:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     devicetree@vger.kernel.org, steev@kali.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, bjorn.andersson@linaro.org,
        daniel@ffwll.ch, airlied@linux.ie, jernej.skrabec@gmail.com,
        maarten.lankhorst@linux.intel.com, rodrigo.vivi@intel.com,
        sam@ravnborg.org, jonas@kwiboo.se, mripard@kernel.org,
        thierry.reding@gmail.com, lyude@redhat.com,
        linus.walleij@linaro.org, rajeevny@codeaurora.org,
        linux-arm-msm@vger.kernel.org, a.hajda@samsung.com,
        tzimmermann@suse.de, narmstrong@baylibre.com,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] Revert "drm/panel-simple: Support for delays between GPIO & regulator"
Date:   Fri, 30 Jul 2021 08:46:04 -0700
Message-Id: <20210730084534.v2.5.Ie44e3e5b7a926392541d575ca84c56931596513f@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210730154605.2843418-1-dianders@chromium.org>
References: <20210730154605.2843418-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 18a1488bf1e13fc3fc96d7948466b2166067c6c8.

Those delays were added to support the Samsung ATNA33XC20
panel. However, we've moving that to its own panel driver and out of
panel-simple. That means we don't need the ability to specify this
delay.

NOTE: it's unlikely we want to keep this delay "just in case" some
other panel needs it. The enable-gpio and the power supply are really
supposed to be different ways to specify the same thing: the main
enable of the panel. Supporting a delay between them doesn't really
make sense.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/panel/panel-simple.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c8694f7f8e0f..ff8b59471c71 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -132,22 +132,6 @@ struct panel_desc {
 		 */
 		unsigned int prepare_to_enable;
 
-		/**
-		 * @delay.power_to_enable: Time for the power to enable the display on.
-		 *
-		 * The time (in milliseconds) to wait after powering up the display
-		 * before asserting its enable pin.
-		 */
-		unsigned int power_to_enable;
-
-		/**
-		 * @delay.disable_to_power_off: Time for the disable to power the display off.
-		 *
-		 * The time (in milliseconds) to wait before powering off the display
-		 * after deasserting its enable pin.
-		 */
-		unsigned int disable_to_power_off;
-
 		/**
 		 * @delay.enable: Time for the panel to display a valid frame.
 		 *
@@ -363,10 +347,6 @@ static int panel_simple_suspend(struct device *dev)
 	struct panel_simple *p = dev_get_drvdata(dev);
 
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
-
-	if (p->desc->delay.disable_to_power_off)
-		msleep(p->desc->delay.disable_to_power_off);
-
 	regulator_disable(p->supply);
 	p->unprepared_time = ktime_get();
 
@@ -427,9 +407,6 @@ static int panel_simple_prepare_once(struct panel_simple *p)
 		return err;
 	}
 
-	if (p->desc->delay.power_to_enable)
-		msleep(p->desc->delay.power_to_enable);
-
 	gpiod_set_value_cansleep(p->enable_gpio, 1);
 
 	delay = p->desc->delay.prepare;
@@ -803,11 +780,6 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc,
 		break;
 	}
 
-	if (!panel->enable_gpio && desc->delay.disable_to_power_off)
-		dev_warn(dev, "Need a delay after disabling panel GPIO, but a GPIO wasn't provided\n");
-	if (!panel->enable_gpio && desc->delay.power_to_enable)
-		dev_warn(dev, "Need a delay before enabling panel GPIO, but a GPIO wasn't provided\n");
-
 	dev_set_drvdata(dev, panel);
 
 	/*
-- 
2.32.0.554.ge1b32706d8-goog

