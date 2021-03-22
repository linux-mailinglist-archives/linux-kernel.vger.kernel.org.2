Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0AE344679
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCVOCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhCVOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:02:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C716C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:02:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ay2so6629366plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yFiw4jYyVPgKKK9i77Vkg4hTSWnNarff0aeFjf5I2bg=;
        b=FQnXW17jLClsIa0WCco6PtxWqpR+hJ1FFaXzWbR1wwd4gF7f3cF/WbmZhsxFSrKU1+
         7QBqOl6PswpPSu8qPTP5iZoTftcoScwprRC3ZdX1tbFgEC2FBx/lsPVpaEBs2egfV7Zp
         ZHj/sXaZVDEdjK8MZ6AjnDI9lsrKqWaEVZfXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yFiw4jYyVPgKKK9i77Vkg4hTSWnNarff0aeFjf5I2bg=;
        b=edamC0X0zyCnx2vebUdgQ7bdNnk8lvwzw+d0LmATEXVAtOQ+r+2abaAsL4Lr2yJaC7
         FK27aIOrDn9Sko6v4Haxy0i9lwl5RP2Bc3mxKKeSiM19qRboQRZ2q1mxXCmDN40koxMN
         Yef4LPwhaVKYUPnwsyeJmePjH8sOW+bDOnVq4EqZx1fD+3Z3uMxe22fwX/VIa7Lgupxp
         LE/uLj7XMs17CH0hsglos9yqKiUksp6n5lvLd14l6gmwMJ2ajvw4tmVb/QHeURrQ7iqc
         0QoLHa9T8KTXuMtn8WB5ZnjfIM9Yb3rjYIanT/6IK4R1kxdUoM96KY7M6PEacwoYVLaI
         mfwQ==
X-Gm-Message-State: AOAM533CvB7NpOPQLPaIxrdWfeOevFa4dE6VLoJyelYX9ujDmek0pNmJ
        MOnPZlSLqgsH622iv8NZM4M+wg==
X-Google-Smtp-Source: ABdhPJzE58DFBYBPm4FTbLkJ3y9/1Rr71/9oMKSOYfRiW0F09qVn4uXTqXnLF4g7p2OToVoay3/tiA==
X-Received: by 2002:a17:90b:4a4c:: with SMTP id lb12mr13550185pjb.133.1616421740641;
        Mon, 22 Mar 2021 07:02:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a884:15c1:9a30:414f:d84b])
        by smtp.gmail.com with ESMTPSA id gg22sm14112997pjb.20.2021.03.22.07.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:02:20 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 1/4] drm: sun4i: dsi: Use drm_of_find_panel_or_bridge
Date:   Mon, 22 Mar 2021 19:31:49 +0530
Message-Id: <20210322140152.101709-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322140152.101709-1-jagan@amarulasolutions.com>
References: <20210322140152.101709-1-jagan@amarulasolutions.com>
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
Changes for v4, v3:
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

