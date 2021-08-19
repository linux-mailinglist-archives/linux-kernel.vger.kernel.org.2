Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455043F152F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhHSI3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbhHSI3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:29:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E67C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:29:02 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o2so5189691pgr.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUMawJHmaVN55KeOYmXXMpF4IBtsM0ibJxP9InePT3U=;
        b=QWFOhtwMzuF7438Vz1BNsWXlxPzmpjz1r6/3JOjc/zv9NhlUfdPglonytyatnNG7IL
         vMC6DlMvJA7qkWpy9Yi7P0NLXji5n/K3bxJKUSj98jkbFB1d0DXbSKCyevq4QoNqspjL
         V3m3hFinoxXIfL6gzZbzjhWkUcYksSUolSGGPH8QNQDTk0pvDbFYv+EphVN28SEHBSVu
         PM8Lu8BUxhFNcfa6GZJRQjoxTcPLos49nhNoDdgqycvuMrrHk6IkpCMVK0tAkQlFaMxf
         rLA5VqYxLrxmQeOq1NNkIqEuUgFpki1jJ4gMNk+pSA8x/Y9pSNwOqSL8B1bpwuVcJMIU
         neRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUMawJHmaVN55KeOYmXXMpF4IBtsM0ibJxP9InePT3U=;
        b=PZw/my4raSnoI33RAnqnuKfQ9gIC8U1Ow1e6M3z2qONrZDPlspWxHY+ySelDURIABh
         JBj3EVUKEZWFuxrPYvJTZw3nF49WRqWhHZq0tPc8/OgaxZ1IhA4jocZkRXJhTp3sSbAJ
         oiyjh/gbJxhSLsaviCriSdLQCxdGaCj86WRgvLiiELopkHIELx5YqpIIaofT6glIy8R7
         GlFj2f3/EcVx6Irl1S5jaPCk4fJ0C/raZXNbFcprBqMuLaboNNz0QZyZiaOf4VGnpIfM
         yxU/QHFMewGHG8nw7laEqac8tHnzzrQtAzk4Xp+LF0ELoU7F89qpdwQx9IQSGX3oLZGC
         iZRg==
X-Gm-Message-State: AOAM530IvXByWTKU5QtRC+7uTSOm8mf5uLNK3ZTSxeOCTDI7ZadoGil6
        ROnKT5KKPrYDQ/fhQK96GgehSw==
X-Google-Smtp-Source: ABdhPJwL3No6X6V3kG0udGVqfpgqmycMdBsXxBaj4a+K926Dhs2m61+g8QsSTJBhoYXtf4696zLHnQ==
X-Received: by 2002:a63:4e5a:: with SMTP id o26mr13070494pgl.19.1629361741868;
        Thu, 19 Aug 2021 01:29:01 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id i11sm2347220pfo.29.2021.08.19.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:29:01 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@google.com
Cc:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v1 1/2] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Thu, 19 Aug 2021 16:28:42 +0800
Message-Id: <20210819082843.716986-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819082843.716986-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210819082843.716986-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The auo,b101uan08.3 panel (already supported by this driver) has
a 3.3V rail that needs to be turned on. For previous users of
this panel this voltage was directly output by pmic. On a new
user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
to turn the 3.3V rail on. Add support in the driver for this.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index db9d0b86d542..9a644433629e 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -45,6 +45,7 @@ struct boe_panel {
 	const struct panel_desc *desc;
 
 	enum drm_panel_orientation orientation;
+	struct regulator *pp3300;
 	struct regulator *pp1800;
 	struct regulator *avee;
 	struct regulator *avdd;
@@ -511,6 +512,7 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		gpiod_set_value(boe->enable_gpio, 0);
 		usleep_range(5000, 7000);
 		regulator_disable(boe->pp1800);
+		regulator_disable(boe->pp3300);
 	} else {
 		gpiod_set_value(boe->enable_gpio, 0);
 		usleep_range(500, 1000);
@@ -518,6 +520,7 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		regulator_disable(boe->avdd);
 		usleep_range(5000, 7000);
 		regulator_disable(boe->pp1800);
+		regulator_disable(boe->pp3300);
 	}
 
 	boe->prepared = false;
@@ -536,6 +539,10 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	gpiod_set_value(boe->enable_gpio, 0);
 	usleep_range(1000, 1500);
 
+	ret = regulator_enable(boe->pp3300);
+	if (ret < 0)
+		return ret;
+
 	ret = regulator_enable(boe->pp1800);
 	if (ret < 0)
 		return ret;
@@ -767,6 +774,10 @@ static int boe_panel_add(struct boe_panel *boe)
 	if (IS_ERR(boe->avee))
 		return PTR_ERR(boe->avee);
 
+	boe->pp3300 = devm_regulator_get(dev, "pp3300");
+	if (IS_ERR(boe->pp3300))
+		return PTR_ERR(boe->pp3300);
+
 	boe->pp1800 = devm_regulator_get(dev, "pp1800");
 	if (IS_ERR(boe->pp1800))
 		return PTR_ERR(boe->pp1800);
-- 
2.25.1

