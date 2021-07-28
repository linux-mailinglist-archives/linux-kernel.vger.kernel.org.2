Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2CB3D9386
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhG1Qqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhG1Qqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:46:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0AC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso4991697pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eEA42JlXQNC4PWoCIFgR+HXz7Rjp4J77j6npFrZR+4=;
        b=Ngg9a/kX+yBwppZxMsfTAwkNrCWuUc1GwnYAZSm8WCvy4KbDgu+V3Kwzhe+aFh4Zgs
         gszehOKA7U54UmQ1aCuJTSlnqKJCBvP5mQi/RYCDt0O3MmrHSaUKXcyAdZaDDTLOywaG
         mKXqA0ZOrTkck0FEWb4p/UgYx6bTwzmj7lnp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eEA42JlXQNC4PWoCIFgR+HXz7Rjp4J77j6npFrZR+4=;
        b=aY5/aVhJMygC7o/5CtSDS4UTQpL0dHgxoGAz2HccdDt2SRv+Xse13M1Q7wSghLWCxe
         v4FCdyxeqGQFfLD0tjAXAKEXzF1+4dK6+bhvzMjs4vWAUu6mY5r1f5zfZke+h2Pngjaq
         QPNyA7Q4RxAe0VmOGAMP8Uqa5kGtYs0LB/PRyBwqCcPlnaof2ELtfwW027UNLRo5METr
         9MNhGtLQWRJKtCaQhxYV/CIeV4LGFjFSIE5ODovgYyjk+mit9QYSBO7xhcvKUjOEkypD
         5gAg9m5YIdIDD2O5vVLkx9CCfnnVKJISVtiiXce6q+kehFcpXpdbrl0vHcbVJMuDhCJj
         jJFQ==
X-Gm-Message-State: AOAM5321OSxoK+yfNo984p6rhDutEyY/8d+cAcroi2Q1Ez2l8lt4Lv0o
        26+/yOYWkdHZx4NmxLVbKEPuqg==
X-Google-Smtp-Source: ABdhPJyxS+v19XYGtTUmlI/PnvqcN5S6DoY5auTi0nO8UXRAUp+H+Ub7crNHZFqYSSrGKv1eT4Hi2Q==
X-Received: by 2002:a65:41c7:: with SMTP id b7mr670981pgq.81.1627490792046;
        Wed, 28 Jul 2021 09:46:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:9f1e:e713:1a5e:89dc])
        by smtp.gmail.com with ESMTPSA id l12sm474075pff.182.2021.07.28.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:46:31 -0700 (PDT)
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
Subject: [PATCH 4/6] Revert "drm/panel-simple: Add Samsung ATNA33XC20"
Date:   Wed, 28 Jul 2021 09:45:55 -0700
Message-Id: <20210728094511.4.Id9f076ec5f35633f8ce931051af268a04c45c075@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210728164557.1882787-1-dianders@chromium.org>
References: <20210728164557.1882787-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 4bfe6c8f7c23b01719671b69fd29b87a35ccd9d6.

This panel's power sequencing really can't be handled properly by
panel-simple because of the special sequencing needed for the EL_ON3
GPIO. The only way it was sorta working in the past was by trying to
jam that signal into the "enable-gpio", but that really wasn't a good
fit. We'll add a custom panel driver for this panel to do it right.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 33 ----------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9b286bd4444f..c8694f7f8e0f 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3621,36 +3621,6 @@ static const struct panel_desc rocktech_rk101ii01d_ct = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
-static const struct drm_display_mode samsung_atna33xc20_mode = {
-	.clock = 138770,
-	.hdisplay = 1920,
-	.hsync_start = 1920 + 48,
-	.hsync_end = 1920 + 48 + 32,
-	.htotal = 1920 + 48 + 32 + 80,
-	.vdisplay = 1080,
-	.vsync_start = 1080 + 8,
-	.vsync_end = 1080 + 8 + 8,
-	.vtotal = 1080 + 8 + 8 + 16,
-	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
-};
-
-static const struct panel_desc samsung_atna33xc20 = {
-	.modes = &samsung_atna33xc20_mode,
-	.num_modes = 1,
-	.bpc = 10,
-	.size = {
-		.width = 294,
-		.height = 165,
-	},
-	.delay = {
-		.disable_to_power_off = 200,
-		.power_to_enable = 400,
-		.hpd_absent_delay = 200,
-		.unprepare = 500,
-	},
-	.connector_type = DRM_MODE_CONNECTOR_eDP,
-};
-
 static const struct drm_display_mode samsung_lsn122dl01_c01_mode = {
 	.clock = 271560,
 	.hdisplay = 2560,
@@ -4657,9 +4627,6 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "rocktech,rk101ii01d-ct",
 		.data = &rocktech_rk101ii01d_ct,
-	}, {
-		.compatible = "samsung,atna33xc20",
-		.data = &samsung_atna33xc20,
 	}, {
 		.compatible = "samsung,lsn122dl01-c01",
 		.data = &samsung_lsn122dl01_c01,
-- 
2.32.0.432.gabb21c7263-goog

