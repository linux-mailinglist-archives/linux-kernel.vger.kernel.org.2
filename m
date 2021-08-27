Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9556D3F9607
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbhH0IZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244568AbhH0IZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:25:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD34C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:24:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so4315405pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUMawJHmaVN55KeOYmXXMpF4IBtsM0ibJxP9InePT3U=;
        b=Fxz3N2mtWJOZp20H0H62tCm4G/B9tJRiU8nyFNZfIi03dLktL6JeLV2ddV8aeHW1XL
         rcTUerdmA+4w7InZ2c4LDfKKVXup97tUe1oyRvTdSpezfuA9IL6AALY0kkJfYHj4GkHC
         EK2gCHg/OgOTlOL/BxSwrORqv/CDstWDgqQi1ritbdlseNn/OXk0l8eZMjfEVnE3rnQM
         BldzUtyfqgYIwZeWJsTFGa+pKaBf4fJpGQ87mU+pNctj6pcBJUmPKQQ6/wQz990KGYYV
         QM+T3NnjCT3sOzbHkJQ6zTRKbxakaxgSYY0KnxKQDBtW1WOvHULBFzsGh9cC95CY0ef1
         oTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUMawJHmaVN55KeOYmXXMpF4IBtsM0ibJxP9InePT3U=;
        b=W7pQZk7Cg8u36iFGeA/8dXHq9anZC2yOnfxsNNbNBpzTDPNUkdDmMoDRT9iT3J7B9r
         qJliu0ea431JvjLmh9+/U/YHL7G4xAoTJLaBgIuOkIJj7+QvCjQAge2vuLstzEfu/DYi
         ZUbjllMR9Rrnyx12nyy8C2/kf0OOBla4YhuUr56YbVU6/kJ4lijUyHfu+ufCTv6/p2MR
         fgwvMzBr9GtJvlzgLXN1i6Oa828NLNFWMAt+hh7US6PCegM3BbStFegfxQZ47PGeeCoE
         9qtGpyJSHT54YSfS/6DbRdNRT71AxoZ6kLLQ+4B/tYQ4V0p5pFjKewpgcCgzK1d6RNdP
         3sbA==
X-Gm-Message-State: AOAM5310+ByArFEZ8/uq0rQ4NK8aJnbYr8S3inezFGEoun/kwxIXEjjB
        6q9j4gKdV0KW3ydjIFIm3qqXtA==
X-Google-Smtp-Source: ABdhPJyzCDsAtLBRyrr7IK7R5ii+ILlKFQQetonZ4oNTJIEEdsAFGzET5At0VHFtXpVBYWGvRR/itg==
X-Received: by 2002:a17:90a:7642:: with SMTP id s2mr21771104pjl.128.1630052660932;
        Fri, 27 Aug 2021 01:24:20 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id m18sm5391371pjq.32.2021.08.27.01.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:24:20 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v3 1/4] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Fri, 27 Aug 2021 16:24:04 +0800
Message-Id: <20210827082407.101053-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827082407.101053-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210827082407.101053-1-yangcong5@huaqin.corp-partner.google.com>
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

