Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6685405E80
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348404AbhIIVDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347455AbhIIVC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:02:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F6FC061760
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 14:01:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c6so2268984pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8dGrdyGxWMaFFC8T5+qZjp4m1n6wQz4H/V4Sfhcm6g=;
        b=d5KP14iVPJVm8KnMISsXpxsirNH5DgOSlwBbBka2aOh4nbezHQenAoYCoAqZm+2+UC
         6plfKkoW4HIKYyGo/RCjS7ujP6O4Zjq/nEzXWkASQKk36vlbTBs6wgZi5OsT6t/FVzZI
         vUMLgFxrzY0HgORYkvsRpttBI2IsPCnKX0Hew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8dGrdyGxWMaFFC8T5+qZjp4m1n6wQz4H/V4Sfhcm6g=;
        b=LASUIHw8hnNn/P7+U87r4Lg8dQZjr42Zu8ecjLKqct5NfDGaxgu6j1lpO3/i2HJWpD
         2P55Z0HN7ociV6g5CouQfkqb09DSYUNHV6z1Y49ggW73zLYyhpg/qXqgb2bRzS34mxEn
         p4Rt+15JiFwMyMK7G7STAnnM65UT6mq1O1ERZpKB73J59QZ4w5+PaJ0NVunzrgGDJ5WR
         lDtGUpnAKXAG5AhbnLeeNL0/NZt01mpk8Innf8pD+Guw0/4WkJ8gv9Vyt9KvkxQfOxtN
         XMQsR1j3sg7lOrdPfVVoTegwF+M8hKLEmiO2HEDQJfwOf1+pJzohpxdQB+y1JGDMA/xC
         nhKg==
X-Gm-Message-State: AOAM531iQPWQvIGKDU4OWnH0RWPNe8Oz+/vZV3uc9CRch2lMei8LQjrH
        NLCWgMVIxdhJDrOiE703+dOMZg==
X-Google-Smtp-Source: ABdhPJyg1JwIuRc9f0vqMtFtpRyockFC14yDo4EICJy1Nm0JaZCaUVR3jXVGukgD69AiuqkUyrfxNQ==
X-Received: by 2002:a17:90b:380d:: with SMTP id mq13mr5554426pjb.49.1631221305117;
        Thu, 09 Sep 2021 14:01:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8da3:b0fb:4261:2c10])
        by smtp.gmail.com with ESMTPSA id l143sm177069pfd.60.2021.09.09.14.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 14:01:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/15] drm/panel-edp: hpd_reliable shouldn't be subtraced from hpd_absent
Date:   Thu,  9 Sep 2021 14:00:28 -0700
Message-Id: <20210909135838.v4.12.I2522235fca3aa6790ede0bf22a93d79a1f694e6b@changeid>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
In-Reply-To: <20210909210032.465570-1-dianders@chromium.org>
References: <20210909210032.465570-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the delays are named / described with eDP-centric names, it
becomes clear that we should really specify the "hpd_reliable" and
"hpd_absent" separately without taking the other into account. Let's
fix it.

This should be a no-op change and just adjust how we specify
things. The actual delays should be the same before and after for the
one panel that currently species both "hpd_reliable" and "hpd_absent".

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v4:
- panel-simple-edp => panel-edp

 drivers/gpu/drm/panel/panel-edp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 1547e4797594..80a37a4e5750 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -423,7 +423,7 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 
 	delay = p->desc->delay.hpd_reliable;
 	if (p->no_hpd)
-		delay += p->desc->delay.hpd_absent;
+		delay = max(delay, p->desc->delay.hpd_absent);
 	if (delay)
 		msleep(delay);
 
@@ -1039,15 +1039,13 @@ static const struct panel_desc boe_nv133fhm_n61 = {
 		 * spike on the HPD line.  It was explained that this spike
 		 * was until the TCON data download was complete.  On
 		 * one system this was measured at 8 ms.  We'll put 15 ms
-		 * in the prepare delay just to be safe and take it away
-		 * from the hpd_absent (which would otherwise be 200 ms)
-		 * to handle this.  That means:
+		 * in the prepare delay just to be safe.  That means:
 		 * - If HPD isn't hooked up you still have 200 ms delay.
 		 * - If HPD is hooked up we won't try to look at it for the
 		 *   first 15 ms.
 		 */
 		.hpd_reliable = 15,
-		.hpd_absent = 185,
+		.hpd_absent = 200,
 
 		.unprepare = 500,
 	},
-- 
2.33.0.309.g3052b89438-goog

