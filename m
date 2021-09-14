Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1566640B932
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhINUYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbhINUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:24:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45993C0613A0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:22:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mi6-20020a17090b4b4600b00199280a31cbso2792124pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzFpNJqBOGrvK8PxTEisk5vASJ81UtyTd+SuH+Jj6C4=;
        b=DLM6eGapNxE2vVc3P4C/IXZ7ewDC2TZAzbBclSO9gAO+g3JjjVDgx9Xk2xGLZmSyPH
         N+5Mhsv+LxHtby729s8U9pukPgT0vbL6ulWqBCO+Bj6l3Ui4h8sOSg11KomCnOBFwOv/
         gTtVKSWGY0KJFBkzwniJNF+9O9yI0QI709x2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzFpNJqBOGrvK8PxTEisk5vASJ81UtyTd+SuH+Jj6C4=;
        b=mKCgMhP5hsloak7xRzArKF1UuqkhYLrQcwy26ur0z6tpy1DpeQ7RYuDAgAzkwl6X4Y
         KQVnDTHV2iLWA59QXwa84xkvUEWm6V+gm3exWmMZfDIlpe9UaghW8N1ml7kWo6GpJHA8
         bA7BlewhMOmBBzYGL1PW8nqeHGTqOA+ZTBU/t4n1qtMWi2ihp6x6QqQmxsHnrWnnpG+J
         wVuOJusfokrXwbEzIVVwRy1LM1YsLt7fQLEvmiiiXpF5yXT4mdDcsELDVRQ3b66787ni
         dNgOP24uDYSobAqC99pg+kTL8GIF0U/l25CkXw5BDRuYiAlF76sKPlaXby1JNuz5l/Nk
         xaBA==
X-Gm-Message-State: AOAM531FtNsY2PKSErSshx0Rn9ALIgvlpblaACdfPupMD5zav6dMVrUc
        vDqXpyZFNGyUNt7en6oCK8zymA==
X-Google-Smtp-Source: ABdhPJy8i/dFscfXlM3GCb7yl0yPY+U0rw+Ib7iozR9Nz10ZdHDtYe4aRkU+gU9znARPbJw7KL2xoQ==
X-Received: by 2002:a17:902:6546:b0:13a:339a:6616 with SMTP id d6-20020a170902654600b0013a339a6616mr16644770pln.34.1631650958848;
        Tue, 14 Sep 2021 13:22:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f38f:9d0f:3eba:f8c4])
        by smtp.gmail.com with ESMTPSA id 141sm12185393pgg.16.2021.09.14.13.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 13:22:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus W <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/15] drm/panel-edp: hpd_reliable shouldn't be subtraced from hpd_absent
Date:   Tue, 14 Sep 2021 13:21:59 -0700
Message-Id: <20210914132020.v5.12.I2522235fca3aa6790ede0bf22a93d79a1f694e6b@changeid>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
In-Reply-To: <20210914202202.1702601-1-dianders@chromium.org>
References: <20210914202202.1702601-1-dianders@chromium.org>
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

(no changes since v4)

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

