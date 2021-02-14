Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C431B24E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 20:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhBNTmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 14:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhBNTmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:42:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB14C061788
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id q72so2489574pjq.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRxs/aOjY1GsbWu/T3aB0+EANdf6JlXR2K+G27uoYio=;
        b=lR/8/4IFFoTMpCeL7fiEaAelu4F/iUPDfjwLukR0qPIqJVMN0UQICGWjJdI/ISNDZ0
         mwO0IcLS/PQ+cfrs3T+K0QEgmQjPMAacO0StWVDksWF7BGvK+kfP5qYZBPNnWn/45Joj
         zSfCKXtsvHFxb7rfHwyUBpOYvVvHxXjqv01dY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRxs/aOjY1GsbWu/T3aB0+EANdf6JlXR2K+G27uoYio=;
        b=J1EVxir8wPjrKoPcYmW8VJAUiafVcLrIWgZzKwbt5PrDh23Yx6h7MpFn9iJU8fjWzn
         GngpR0JJYZgJN50K5yIaqL1m1GyUHdtaJkOP348vQDT5bBoKmMOTWZJ246c9P92VuJOp
         9DrJWizkMR9T1mYogTM+hCOYNB3UysR4KIfMIuuGiZJnayXpsanBiKUq4I5F9VnARoBZ
         XwQWA8KAuWig6pO1FjIqzXDaOuJRe8OI8tqAUg/qpInsudwl1u0ElM5KJPlkfObWn619
         j1BiKOnSUf0dEjG241Y0jAuLPW1WEONG5aMFmMkc6yV7856jk1/2ivcKQz/kyuS8tWuP
         CAFw==
X-Gm-Message-State: AOAM531qeHwJZelv0jCJGX4QIkYcbrgqTExBvgRklav6fvM28jQzNbu2
        sdgZjWfv3d1rhsop3G44rymCyw==
X-Google-Smtp-Source: ABdhPJx7aJtbIv9KAW+oJiidaq/ehl3ZHXkulFd2VYinMmQZVn+HjeAEbrtWl9HLM99JJZ6vYfsw2g==
X-Received: by 2002:a17:902:7c83:b029:e2:b157:e25c with SMTP id y3-20020a1709027c83b02900e2b157e25cmr12216978pll.32.1613331695308;
        Sun, 14 Feb 2021 11:41:35 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([45.249.78.214])
        by smtp.gmail.com with ESMTPSA id 125sm15129247pfu.7.2021.02.14.11.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 11:41:34 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 4/7] drm: sun4i: dsi: Separate code for bridge pre_enable
Date:   Mon, 15 Feb 2021 01:10:59 +0530
Message-Id: <20210214194102.126146-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210214194102.126146-1-jagan@amarulasolutions.com>
References: <20210214194102.126146-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing driver has an enablement code for initializing
clock, reset, PHY, DSI timings, and finally switching to HS
mode.

Move the clock, reset. PHY and DSI timings code into bridge
pre_enable and keep HS mode switch in enable.

As the driver supports fully enabled bridge functionalities,
this new enablement code separation will help to initialize
the host and slave bridge pre_enable, enable functions properly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- new patch

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 6f3c5330a468..3cdc14daf25c 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -714,7 +714,7 @@ static int sun6i_dsi_start(struct sun6i_dsi *dsi,
 	return 0;
 }
 
-static void sun6i_dsi_bridge_enable(struct drm_bridge *bridge)
+static void sun6i_dsi_bridge_pre_enable(struct drm_bridge *bridge)
 {
 	struct drm_display_mode *mode = &bridge->encoder->crtc->state->adjusted_mode;
 	struct sun6i_dsi *dsi = bridge_to_sun6i_dsi(bridge);
@@ -775,6 +775,11 @@ static void sun6i_dsi_bridge_enable(struct drm_bridge *bridge)
 
 	if (dsi->panel_bridge)
 		dsi->panel_bridge->funcs->pre_enable(dsi->panel_bridge);
+}
+
+static void sun6i_dsi_bridge_enable(struct drm_bridge *bridge)
+{
+	struct sun6i_dsi *dsi = bridge_to_sun6i_dsi(bridge);
 
 	/*
 	 * FIXME: This should be moved after the switch to HS mode.
@@ -883,6 +888,7 @@ static int sun6i_dsi_bridge_attach(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs sun6i_dsi_bridge_funcs = {
+	.pre_enable	= sun6i_dsi_bridge_pre_enable,
 	.enable		= sun6i_dsi_bridge_enable,
 	.disable	= sun6i_dsi_bridge_disable,
 	.attach		= sun6i_dsi_bridge_attach,
-- 
2.25.1

