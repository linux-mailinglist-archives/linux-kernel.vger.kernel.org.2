Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F45C3697CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbhDWRBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243331AbhDWRA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:00:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BDBC061343
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:59:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so1511475pjj.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iBUj5kQ7X9fmMOQ4CZ8JChILd2WBNcvTtcV/hSGMVvg=;
        b=FdxPxbY7ijX71QBS18OIzi0n9sM2odFgKMp717noKgZ2ye6GMt0SW1OvPd/Rehb+6h
         +GXiaiJfaAVKyM6/PiiioDTEQZ4BDLR2qq0n2pk5tk2gj07eirFILT0zYteJxyt8L1kS
         wiaJkmwfDd19bvqFN19QAtqryqglfaM4jRHOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBUj5kQ7X9fmMOQ4CZ8JChILd2WBNcvTtcV/hSGMVvg=;
        b=LthN/Ht1ext2X8Qudiz1BrHzM/poeB+uiSmZbDPRIActboopONDn8JpXjyjyChWYr3
         AJb5izSXrJsUIPkvlZadLbAhlv+670oH/6qYnTkmi5lUB0Goggzx9nztIHebXQF3uphs
         PSm74uQyJZM87ESjM3S4FuAq15GY4VFaCUYdB7EsTtGI4UaiSOldt0leXG01s2VVCbKx
         SAuHxr5m7IPFK5IGCobkJycVULs1pQxgo/8P+sniOL0lBAEpCN3RzVk3/gFPMUW/qD78
         cdcSCnGJAjO/z4r0FTS6wCgWeHv9ooXttJc+8JPnmWtWkpHrgPUNMjjCanTndLxX05JE
         s3Qw==
X-Gm-Message-State: AOAM531d46H/cLUcZ+d9ZRNznk4RucBKGBYoPaCMHIU4tnPd/LeFjXKm
        RMkBusGmCQ7AEtwl1qKGeAlJHA==
X-Google-Smtp-Source: ABdhPJxyF0nN/4vsiL7lk43a0I/qpwpmwLXPqQ05NyVO9W3gD4zw+0dRDftgTSkOcNerASpW3ts8Aw==
X-Received: by 2002:a17:90b:2306:: with SMTP id mt6mr5416893pjb.119.1619197191335;
        Fri, 23 Apr 2021 09:59:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6d86:663d:71f8:6a11])
        by smtp.gmail.com with ESMTPSA id v8sm5123607pfm.128.2021.04.23.09.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:59:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/20] drm/panel: panel-simple: Get rid of hacky HPD chicken-and-egg code
Date:   Fri, 23 Apr 2021 09:58:56 -0700
Message-Id: <20210423095743.v5.10.I40eeedc23459d1e3fc96fa6cdad775d88c6e706c@changeid>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423165906.2504169-1-dianders@chromium.org>
References: <20210423165906.2504169-1-dianders@chromium.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

(no changes since v1)

 drivers/gpu/drm/panel/panel-simple.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9746eda6f675..bd208abcbf07 100644
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
2.31.1.498.g6c1eba8ee3d-goog

