Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3803362B81
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhDPWmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhDPWlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3A5C061763
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j7so10720785pgi.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1zzEPLt2L+BYGWWUtwKGlLBkITyompRv0awY1GtFc2I=;
        b=DQCL5ZFyphxZ1QO/SqxcuHkYpHsOlUFFWpTaJ0eym0do+pBr9pGhfLTwZy2gMZ/uR7
         +MreGHioboXLpIZqUbUB9FCFiX/uQZIqhee9O860dSefs0U2PT+orYOO9IP5DOEkJeHc
         AQGVivLqSsI39MKq2eqThRePW/VGXG2IwwaqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zzEPLt2L+BYGWWUtwKGlLBkITyompRv0awY1GtFc2I=;
        b=cs/E/6JpHyFgm1KS1Kn2c3w5Yq3/3oo/vGrasiDM6lU8tSbalrM5bYEt7POJVfB2e4
         JGCnafXpaU70M8dVrG+15LiMBD4FTcuwY2I1wMLPNVsKYUu4skWnnN7eB0QUwr3U/x5q
         dR7UYwRHYTkDIBlEqC7/nwLXsPAKV6EJZlSdpk+X2d04uBFvNFcpTb+oGy7cY4doa7a0
         vxrBg+N5tasAlD4luJtCYsHFM/DAblpkajX+RaQKYKcL7Q3io9OpaphZiin+9Bo77x3q
         z8RsDfmzakKxxgd3WYAD4+tv+Q26rKOJMlFvjiaBuvyIYmzRsAtEOOXfCIBDzK3wIv4D
         6NyQ==
X-Gm-Message-State: AOAM532/3uANvdH7mZ3UyvF/X1E49Wug6VTODsu3XtayuD/ZHs3c5r8M
        scSRxZvKzHhkT4NXEVRlBV64VA==
X-Google-Smtp-Source: ABdhPJyKtLU8yG3gP39Hbtv2xS0iZITkzY/NeuveTMuhb0Iwbz573n33UsWqv9Cv2jt5y7DXmSYwWQ==
X-Received: by 2002:a65:590a:: with SMTP id f10mr1124558pgu.358.1618612870865;
        Fri, 16 Apr 2021 15:41:10 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:41:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/27] drm/panel: panel-simple: Get rid of hacky HPD chicken-and-egg code
Date:   Fri, 16 Apr 2021 15:39:39 -0700
Message-Id: <20210416153909.v4.16.I40eeedc23459d1e3fc96fa6cdad775d88c6e706c@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I added support for the hpd-gpio to simple-panel in commit
48834e6084f1 ("drm/panel-simple: Support hpd-gpios for delaying
prepare()"), I added a special case to handle a circular dependency I
was running into on the ti-sn65dsi86 bridge chip. On my board the
hpd-gpio is actually provided by the bridge chip. That was causing
some circular dependency problems that I had to work around by getting
the hpd-gpio late.

I've now reorganized the ti-sn65dsi86 bridge chip driver to be a
collection of sub-drivers. Now the GPIO part can probe separately and
that breaks the chain. Let's get rid of the old code to clean things
up.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/panel/panel-simple.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 6b22872b3281..90a17ca79d06 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -366,8 +366,7 @@ static int panel_simple_unprepare(struct drm_panel *panel)
 	return 0;
 }
 
-static int panel_simple_get_hpd_gpio(struct device *dev,
-				     struct panel_simple *p, bool from_probe)
+static int panel_simple_get_hpd_gpio(struct device *dev, struct panel_simple *p)
 {
 	int err;
 
@@ -375,17 +374,10 @@ static int panel_simple_get_hpd_gpio(struct device *dev,
 	if (IS_ERR(p->hpd_gpio)) {
 		err = PTR_ERR(p->hpd_gpio);
 
-		/*
-		 * If we're called from probe we won't consider '-EPROBE_DEFER'
-		 * to be an error--we'll leave the error code in "hpd_gpio".
-		 * When we try to use it we'll try again.  This allows for
-		 * circular dependencies where the component providing the
-		 * hpd gpio needs the panel to init before probing.
-		 */
-		if (err != -EPROBE_DEFER || !from_probe) {
+		if (err != -EPROBE_DEFER)
 			dev_err(dev, "failed to get 'hpd' GPIO: %d\n", err);
-			return err;
-		}
+
+		return err;
 	}
 
 	return 0;
@@ -416,12 +408,6 @@ static int panel_simple_prepare_once(struct panel_simple *p)
 		msleep(delay);
 
 	if (p->hpd_gpio) {
-		if (IS_ERR(p->hpd_gpio)) {
-			err = panel_simple_get_hpd_gpio(dev, p, false);
-			if (err)
-				goto error;
-		}
-
 		if (p->desc->delay.hpd_absent_delay)
 			hpd_wait_us = p->desc->delay.hpd_absent_delay * 1000UL;
 		else
@@ -682,7 +668,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 
 	panel->no_hpd = of_property_read_bool(dev->of_node, "no-hpd");
 	if (!panel->no_hpd) {
-		err = panel_simple_get_hpd_gpio(dev, panel, true);
+		err = panel_simple_get_hpd_gpio(dev, panel);
 		if (err)
 			return err;
 	}
-- 
2.31.1.368.gbe11c130af-goog

