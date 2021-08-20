Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA183F3744
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbhHTXWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 19:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbhHTXWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:22:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45CAC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 16:22:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l11so6836525plk.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 16:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2pzolqc815RjMI9YhMzA6Tlcrcb+M0ye/v6UQI/kAg=;
        b=D0Hus8QLYhoe/UI2jm1sRI0wXMZweQjO5TQA/lKbb2BjDI73hBG+vBYRkeVymw1PfN
         OkRbLm3/u/spR/U8KnxqsKscPSA055gJ2XyldkDuRSj2vjkx3r9mdxS/kwxvlYuj0QO4
         1LNfNF4FqNfff0idQi0mU9ER37CvLJ2oXAp/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2pzolqc815RjMI9YhMzA6Tlcrcb+M0ye/v6UQI/kAg=;
        b=Z6OQowjgWiiiVM4S2PRA5X0t+Grovy40bnN/meLi4PaPtY/uGpDcMPap2kfQkA1BKo
         UfeRrEZoEdWwFTckoxI1/wBGzMfFaSuXyUps6Up3P6sV/tR4s35WtmQq0yZb1+d6SLjP
         aV5/eQtveRM462ruw58AysJMsoyHxrWvIHVFW5WU3733WYuQ0P0f62MfuTv7PBSDv0u5
         T385J26iKhSXX+ThDV70uc25XUOg15VAV5WXjVOXkxNvFidEnKoPB07QuEcYKJrYsh3q
         ZiYAzghYC6/615HzQlnacGzoPXQrTn3weGw+1qeaAoz1MamHRyuCCbRKFVN2hgDkoDel
         6PLA==
X-Gm-Message-State: AOAM530LNE6GZuZgjyH2chD8iYAQuWdftx+/t/UUU/+FOxbO9HdaAfAM
        7jHBGnpSy7JeInKaZz2uAU72/744waXC1A==
X-Google-Smtp-Source: ABdhPJx7uVadvYtdEXuuDf6IIWadfqlD0ERILqDaKs4tcK+Pnpc5LDC/MAAhWIyc2Uv2zOFT+jzVGQ==
X-Received: by 2002:a17:90a:f98d:: with SMTP id cq13mr7209752pjb.211.1629501728882;
        Fri, 20 Aug 2021 16:22:08 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:3c8e:4054:efb0:e39f])
        by smtp.gmail.com with ESMTPSA id gl12sm12579496pjb.40.2021.08.20.16.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 16:22:08 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
X-Google-Original-From: Philip Chen <philipchen@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Philip Chen <philipchen@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: parade-ps8640: Reorg the macros
Date:   Fri, 20 Aug 2021 16:22:03 -0700
Message-Id: <20210820162201.1.I8ead7431357409f2526e5739ec5bc3ddfd242243@changeid>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philip Chen <philipchen@chromium.org>

Reorg the macros as follows:
(1) Group the registers on the same page together.
(2) Group the register and its bit operation together while indenting
the macros of the bit operation with one space.

Also fix a misnomer for the number of mipi data lanes.

Signed-off-by: Philip Chen <philipchen@chromium.org>
Signed-off-by: Philip Chen <philipchen@google.com>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 7bd0affa057a..685e9c38b2db 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -18,16 +18,18 @@
 #include <drm/drm_print.h>
 
 #define PAGE2_GPIO_H		0xa7
-#define PS_GPIO9		BIT(1)
+#define  PS_GPIO9		BIT(1)
 #define PAGE2_I2C_BYPASS	0xea
-#define I2C_BYPASS_EN		0xd0
+#define  I2C_BYPASS_EN		0xd0
 #define PAGE2_MCS_EN		0xf3
-#define MCS_EN			BIT(0)
+#define  MCS_EN			BIT(0)
+
 #define PAGE3_SET_ADD		0xfe
-#define VDO_CTL_ADD		0x13
-#define VDO_DIS			0x18
-#define VDO_EN			0x1c
-#define DP_NUM_LANES		4
+#define  VDO_CTL_ADD		0x13
+#define  VDO_DIS		0x18
+#define  VDO_EN			0x1c
+
+#define NUM_MIPI_LANES		4
 
 /*
  * PS8640 uses multiple addresses:
@@ -254,7 +256,7 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
 			  MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->lanes = DP_NUM_LANES;
+	dsi->lanes = NUM_MIPI_LANES;
 	ret = mipi_dsi_attach(dsi);
 	if (ret)
 		goto err_dsi_attach;
-- 
2.33.0.rc2.250.ged5fa647cd-goog

