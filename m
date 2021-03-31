Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7CB34DEE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhC3CzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhC3CyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:54:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9075C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so6937117pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OznxYj+eRPVb4um1OhPEH9Y2bcONmP2iXcQsa3vKzmU=;
        b=UJOk7rBZBFF9I7lwYBJmw01yx2yHeWcw5z0zsYmSrIAxjHV4hx3YLLroFJWN0TA7m2
         kx7hnYCBA3g6fJWfnrNU46vi6abv2rwjis0Lq4iRzRXn4GgWfff5PwW9SbAfzzAZg5oI
         p6jjD0bmPxC/qMblO48yxz/gnwV4iUqORCAwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OznxYj+eRPVb4um1OhPEH9Y2bcONmP2iXcQsa3vKzmU=;
        b=FJNYySl9qXtLgqb7Kcsl3G4muJ6MJPWtGc03obCAKp5OXjY4HhISECqLl6w8phAQyg
         eirOqBFL5YEReLNcRIAcqFZndZZj3Po9W5qtmfp8fhzabxjDoq7EbWGrXa77voloQXSf
         EoJ8CZu1JBvEdNs71vs/H3nETOribhmtSWDUzFMiZiV7+aMvDGa+u7He2ZxtXFuHGZsH
         66SgarsazJs+QgnH9BMFRxl4AJB/OAo4k8QPUb26s0SV1i9LqGjbGemPognP99JHiNxt
         c5zW8wOuV0GvE7cpQB20wpP0D77JmpenvLQwXMni3hSAdYDimuTAGxaVMAkgssFEldap
         auNA==
X-Gm-Message-State: AOAM530/Mlpot4AoJqSm+GCM/mdODr1A3NHKqKJKSMrJxSxWSh22lE7y
        5+bd0zqzEugmUxT9j8Ti0fHCPw==
X-Google-Smtp-Source: ABdhPJwdMyAMlvJ4erQw/GS0vAMriU7o2o3SCbSml2tS9OvV/G56Q2R8aTmlnqks8jfOmrfPN47vwQ==
X-Received: by 2002:a17:902:bd45:b029:e7:1490:9db5 with SMTP id b5-20020a170902bd45b02900e714909db5mr25817051plx.45.1617072861413;
        Mon, 29 Mar 2021 19:54:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f599:1ca7:742d:6b50])
        by smtp.gmail.com with ESMTPSA id t17sm19152706pgk.25.2021.03.29.19.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 19:54:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        robdclark@chromium.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] drm/bridge: ti-sn65dsi86: Read the EDID only if refclk was provided
Date:   Mon, 29 Mar 2021 19:53:43 -0700
Message-Id: <20210329195255.v2.12.I7a8708139ae993f30f51eec7d065a1906c31a4bc@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210330025345.3980086-1-dianders@chromium.org>
References: <20210330025345.3980086-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though I don't have access to any hardware that uses ti-sn65dsi86 and
_doesn't_ provide a "refclk", I believe that we'll have trouble
reading the EDID at bootup in that case. Specifically I believe that
if there's no "refclk" we need the MIPI source clock to be active
before we can successfully read the EDID. My evidence here is that, in
testing, I couldn't read the EDID until I turned on the DPPLL in the
bridge chip and that the DPPLL needs the input clock to be active.

Since this is hard to support, let's punt trying to read the EDID if
there's no "refclk".

I don't believe there are any users of the ti-sn65dsi86 bridge chip
that _don't_ use "refclk". The bridge chip is _very_ inflexible in
that mode. The only time I've seen that mode used was for some really
early prototype hardware that was thrown in the e-waste bin years ago
when we realized how inflexible it was.

Even if someone is using the bridge chip without the "refclk" they're
in no worse shape than they were before the (fairly recent) commit
58074b08c04a ("drm/bridge: ti-sn65dsi86: Read EDID blob over DDC").

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 673c9f1c2d8e..92498900c58d 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -273,6 +273,18 @@ static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
 	bool was_enabled;
 	int num = 0;
 
+	/*
+	 * Don't try to read the EDID if no refclk. In theory it is possible
+	 * to make this work but it's tricky. I believe that we need to get
+	 * our upstream MIPI source to provide a pixel clock before we can
+	 * do AUX transations but we need to be able to read the EDID before
+	 * we've picked a display mode. The bridge is already super limited
+	 * if you try to use it without a refclk so presumably limiting to
+	 * the fixed modes our downstream panel reports is fine.
+	 */
+	if (!pdata->refclk)
+		goto exit;
+
 	/*
 	 * Try to get the EDID first without anything special. There are
 	 * three things that could happen with this call.
@@ -306,6 +318,7 @@ static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
 			return num;
 	}
 
+exit:
 	return drm_panel_get_modes(pdata->panel, connector);
 }
 
-- 
2.31.0.291.g576ba9dcdaf-goog

