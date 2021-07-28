Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515AE3D9385
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhG1Qqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhG1Qqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:46:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54325C0617A0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so10996895pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STTl4syxhYiPqJGJCa+c8pqgWqmaNxb9nZtqbCu6WMo=;
        b=QWHU5ALALIEjB1vtvsSgIbBoC2aClYOpIbtSW/QDyYyH+c2F1pfyECpkrN3rmgsm6i
         A0lmVM8zTixkvAkL2P5knid03Yo4AALld7DxGYqcZTvj8BNHj5+Jme9kqrGVpy8DKQyh
         5oI3ir3kL5Qk6DLy5mr6Oj2jIGE141p369RBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STTl4syxhYiPqJGJCa+c8pqgWqmaNxb9nZtqbCu6WMo=;
        b=IlXQk+T8bNOeXIRA0IwzR2Bgz94810QQiFp0eG5P9enLuzdDSQN+0bfpW3X+ZPcVdp
         xOjcbN415vmWOTZTj+b7zc32lvmZNiEyF1HQ2K4LXzhIKxhJ6FO9WpPsNdB8pgSiBL+V
         onpZTz+5yv7yH0GEeTBXoawTYxq3YIqViFLRFKsDtWgnuGY9snpsq5K34y94PUHiwrRa
         xtXJw2FRuTUumfZquzeQ3FlCCpjx/Tk2E6fppze6oKQOGNGAUxXUJstn6KKoCdQKZ5gT
         TkeRUGPs8pjlhtLHc43SnsAECACw+w9DnmYrMR8YnKoZMkO3WwQrvOlS1n64KJGn66pP
         XGQA==
X-Gm-Message-State: AOAM531yElC5ShtDjh4zZqCKkB+fnBXXEw48e1nNSOImLDCClIXRR08q
        r8ywxHq1ACBNahio95Hsn8HYBg==
X-Google-Smtp-Source: ABdhPJxNVqhXZn98YSnXaLQyTmtbqfu8/DRzlEzSAFdrRH1VB3dmQ8nadXOOJcwvq6NRJX5kfsyppA==
X-Received: by 2002:a05:6a00:1582:b029:332:67bf:c196 with SMTP id u2-20020a056a001582b029033267bfc196mr768393pfk.52.1627490793917;
        Wed, 28 Jul 2021 09:46:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:9f1e:e713:1a5e:89dc])
        by smtp.gmail.com with ESMTPSA id l12sm474075pff.182.2021.07.28.09.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:46:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, linux-arm-msm@vger.kernel.org,
        a.hajda@samsung.com, sam@ravnborg.org, airlied@linux.ie,
        bjorn.andersson@linaro.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org, rodrigo.vivi@intel.com,
        jonas@kwiboo.se, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, robert.foss@linaro.org,
        jernej.skrabec@gmail.com, mripard@kernel.org,
        linus.walleij@linaro.org, maarten.lankhorst@linux.intel.com,
        rajeevny@codeaurora.org, lyude@redhat.com,
        thierry.reding@gmail.com, steev@kali.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] Revert "drm/panel-simple: Support for delays between GPIO & regulator"
Date:   Wed, 28 Jul 2021 09:45:56 -0700
Message-Id: <20210728094511.5.Ie44e3e5b7a926392541d575ca84c56931596513f@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210728164557.1882787-1-dianders@chromium.org>
References: <20210728164557.1882787-1-dianders@chromium.org>
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
---

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
2.32.0.432.gabb21c7263-goog

