Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB1831B24B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 20:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhBNTmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 14:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhBNTmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:42:03 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4ECC061756
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cv23so2477205pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WI1iyrnvhWaNG/MvFsahwpBXf2DTPnogdw12xoDU1G0=;
        b=EVG43J4/EO4+pGlO0g6kGGmKnxCMV3wq1NjNbFjH7MFbJIqAUh55QKyHyORwlFS1QQ
         A/JhHhwLujRXfD3v9erPMAy2OZw7EQ942OvjnvGGBD8XS31lM1THGlcSgzh7mi3R96Lm
         DnZ6I6nmeBuaUaOMGAA7101hvQTmV6ogOlTzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WI1iyrnvhWaNG/MvFsahwpBXf2DTPnogdw12xoDU1G0=;
        b=CoGR69nuKbqeliP+n8+R8786Ir9w4PdPyEjQ9g1WwgNNgNAZYPu6qfCXKCm7QOGw7x
         R9iOie7ry1LMa2PH8UQwGtNWQb7ZGxoKnmu0nirIgu8Wins55OjrVY7upg2A+0k5uzON
         i/guXSFI9Njcw4Nt4CrpUHkyUry5XFtcEbX6mgFUkX+ijAVLYwTIUo2a34FCnm0znocS
         mf2KwiVUVvRrIyTcSRGyzmj6B7hdzpNuhZoXAaFJrqzCW8ps+JzpY6h27xBb66wJa1wW
         wmPiOQc1W27YbndrmKfD/UsoiiDZPpxmW72VY6OkqeU1dZuE93sPKnvHeUYh1nZXr/uQ
         t+sA==
X-Gm-Message-State: AOAM530SGcMDt+v2mJFCFP1jznmOvA/x/QI+blT00SrQ/qNP/dJhaZeQ
        7cIIWQabs1a2+dShB3eylgY2kQ==
X-Google-Smtp-Source: ABdhPJzOmjjDGQgqnxXklOvSXjd4BguDUqqil0xk86snbbpR/yGMkUu7WGUp4pAFWbPilT+STILTGw==
X-Received: by 2002:a17:90a:7e94:: with SMTP id j20mr12988495pjl.8.1613331682653;
        Sun, 14 Feb 2021 11:41:22 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([45.249.78.214])
        by smtp.gmail.com with ESMTPSA id 125sm15129247pfu.7.2021.02.14.11.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 11:41:22 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 1/7] drm: sun4i: dsi: Use drm_of_find_panel_or_bridge
Date:   Mon, 15 Feb 2021 01:10:56 +0530
Message-Id: <20210214194102.126146-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210214194102.126146-1-jagan@amarulasolutions.com>
References: <20210214194102.126146-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace of_drm_find_panel with drm_of_find_panel_or_bridge
for finding panel, this indeed help to find the bridge if
bridge support added.

Added NULL in bridge argument, same will replace with bridge
parameter once bridge supported.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 4f5efcace68e..2e9e7b2d4145 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -21,6 +21,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -963,10 +964,14 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
 			    struct mipi_dsi_device *device)
 {
 	struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
-	struct drm_panel *panel = of_drm_find_panel(device->dev.of_node);
+	struct drm_panel *panel;
+	int ret;
+
+	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 0, 0,
+					  &panel, NULL);
+	if (ret)
+		return ret;
 
-	if (IS_ERR(panel))
-		return PTR_ERR(panel);
 	if (!dsi->drm || !dsi->drm->registered)
 		return -EPROBE_DEFER;
 
-- 
2.25.1

