Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187813FE3EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbhIAUWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbhIAUWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:22:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA350C061198
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 13:20:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e1so361517plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DABmu8a7wcOi+LAPS6v0nwHVY/OcrtFrk5J3lvyIla0=;
        b=Os0b+GnEGsF8siu+flMSW4dAYNThKDU3Ww7vE6vKTBh7r6Ux9uPPuEUWDpACEet4TB
         mVp83QdWqU8lPUa+HCK/0vBTS1Kinrh61IFQz72H+1ZnjVa+cEjR1BKLN1/zkW9TObfR
         qMT3e29jfdSpnF+/aK3xNQjTSSsJIXJqhOLNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DABmu8a7wcOi+LAPS6v0nwHVY/OcrtFrk5J3lvyIla0=;
        b=oUEkPlBYsHwKiUjBBPAVdOKo+HDg3zJrTwlRzSzKizGpxGNvd2wCKrSKFGWVgHfdmS
         aCV/uDUU+bBMnh9AdE8bJn+BrsAZRfZh3vnAOEtGJg13XPquiq8hIpP56l+O6e4J8Vi0
         TsxVgw5+DJKDjtxi2sBbfcnFCY87T1pr7BMtDcOeQuISLWc9kWEmAAIRiyeSvHLNWV14
         XnFEDcD5ifLfHmHQeaGN6Z3EE7cKzrmoUu3SXgLv4Fc0PePa2QLeO+mk1733FFAaOHly
         zp5rY5LfPIbNIZfB4IlVHgPsKHFxVxCppsRwMUbiNB5xEDAVU3toe4ccfY3Payud/z9F
         dwVw==
X-Gm-Message-State: AOAM5332LQFA+GNEvGMKRBg7pn2yBSWSSh747VUszNHbmv9BLE60Nv/V
        46atyFdI94g+A1WWFcgvMQLhCg==
X-Google-Smtp-Source: ABdhPJxJ7qKxG2VvHK0KF5F5LrDE/YppzmHXKeC1vqvO9uwXp8XtCRHrGZoq8Mmssft1eXHGjc3fIg==
X-Received: by 2002:a17:90a:5882:: with SMTP id j2mr1100326pji.169.1630527654141;
        Wed, 01 Sep 2021 13:20:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:958b:b561:a735:e774])
        by smtp.gmail.com with ESMTPSA id x15sm321178pfq.31.2021.09.01.13.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:20:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/16] drm/panel-simple-edp: Don't re-read the EDID every time we power off the panel
Date:   Wed,  1 Sep 2021 13:19:33 -0700
Message-Id: <20210901131531.v3.15.Ib810fb3bebd0bd6763e4609e1a6764d06064081e@changeid>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210901201934.1084250-1-dianders@chromium.org>
References: <20210901201934.1084250-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple-panel driver is for panels that are not hot-pluggable at
runtime. Let's keep our cached EDID around until driver unload.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("Don't re-read the EDID every time") moved to eDP only patch.

 drivers/gpu/drm/panel/panel-simple-edp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple-edp.c b/drivers/gpu/drm/panel/panel-simple-edp.c
index 5d58dc25ddf5..90ba146426e4 100644
--- a/drivers/gpu/drm/panel/panel-simple-edp.c
+++ b/drivers/gpu/drm/panel/panel-simple-edp.c
@@ -362,9 +362,6 @@ static int panel_edp_suspend(struct device *dev)
 	regulator_disable(p->supply);
 	p->unprepared_time = ktime_get();
 
-	kfree(p->edid);
-	p->edid = NULL;
-
 	return 0;
 }
 
@@ -758,6 +755,9 @@ static int panel_edp_remove(struct device *dev)
 	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
 		put_device(&panel->ddc->dev);
 
+	kfree(panel->edid);
+	panel->edid = NULL;
+
 	return 0;
 }
 
-- 
2.33.0.259.gc128427fd7-goog

