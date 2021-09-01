Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD43FE3E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbhIAUWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344805AbhIAUV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:21:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC67C0612AF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 13:20:52 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c17so705503pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drQCiqDZz3QYS3F6wYgeFkeCVgRZeHge/OR/7gh4ucU=;
        b=ZkjCA9Rqq7qM3F6MpkAxqoe1GnPj+C8DjLay9BLW60nwl+b5eydGWd98H+ZUQ6GnWo
         P5CF88A+P0aI+uLkpDB7K+fXVtP83oDV02i+4vSasWj8yFlQOlAKnxBzil09YriYsxHs
         /2RWP4FxfljavNhcwP+i8TNLpdkxRfh83pd7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drQCiqDZz3QYS3F6wYgeFkeCVgRZeHge/OR/7gh4ucU=;
        b=N4MvKb1+8mSA99a52n+Arh8caSnr+vk1BGCKyfhgMYC1Ex+3fW3QxfxiWgXnOezhlE
         86YiKY7kppgfo3S6JJKfNj1jLXWWj+lkdOX+J/x/Kkf5LV1n11yAQGPpdkqxuWNK4Ysq
         7U7nKMxNnGajlv5BJMAUp84PUzQSr71Qxb4eHc3+BiyfVrwwrTvjPt5hxMNIzSFZfEEE
         cmAPLDs2+OflTUcx8/bXImgxfzJFr4MEeB7aJ6C8lJezlPknEz4opNTdh1SyJ85dOtVG
         An74EsUFgE0M+svPMJNEf4cosqoFojdCBYHaABKksemyXOXHFK7BXXdYcmOx1XcDjm04
         cu3Q==
X-Gm-Message-State: AOAM532dQU7ZtaTio/yEtpX0oIziqBUjI6vcmxF/fFU6eAEbZlP0EBGL
        wz1+lK2gIApNSqmNj8BGjlxBaA==
X-Google-Smtp-Source: ABdhPJyIUJlWaf223U6cCvd+Cx293tnWnAvUjyvCJh4MGrpo6YsPF9U5wGJWi0dOjOqPewBTkqFVXQ==
X-Received: by 2002:aa7:8a48:0:b0:408:dadb:35cb with SMTP id n8-20020aa78a48000000b00408dadb35cbmr1045184pfa.67.1630527652263;
        Wed, 01 Sep 2021 13:20:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:958b:b561:a735:e774])
        by smtp.gmail.com with ESMTPSA id x15sm321178pfq.31.2021.09.01.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:20:51 -0700 (PDT)
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
Subject: [PATCH v3 14/16] drm/panel-simple-edp: Fix "prepare_to_enable" if panel doesn't handle HPD
Date:   Wed,  1 Sep 2021 13:19:32 -0700
Message-Id: <20210901131531.v3.14.Ia8288d36df4b12770af59ae3ff73ef7e08fb4e2e@changeid>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210901201934.1084250-1-dianders@chromium.org>
References: <20210901201934.1084250-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While cleaning up the descriptions of the delay for eDP panels I
realized that we'd have a bug if any panels need the
"prepare_to_enable" but HPD handling isn't happening in the panel
driver. Let's put in a stopgap to at least make us not violate
timings. This is not perfectly optimal but trying to do better is
hard. At the moment only 2 panels specify this delay and only 30 ms is
at stake. These panels are also currently hooked up with "hpd-gpios"
so effectively this "fix" is just a theoretical fix and won't actually
do anything for any devices currently supported in mainline.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Fix "prepare_to_enable" patch new for v3.

 drivers/gpu/drm/panel/panel-simple-edp.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple-edp.c b/drivers/gpu/drm/panel/panel-simple-edp.c
index 762589ef66c3..5d58dc25ddf5 100644
--- a/drivers/gpu/drm/panel/panel-simple-edp.c
+++ b/drivers/gpu/drm/panel/panel-simple-edp.c
@@ -508,12 +508,32 @@ static int panel_edp_prepare(struct drm_panel *panel)
 static int panel_edp_enable(struct drm_panel *panel)
 {
 	struct panel_edp *p = to_panel_edp(panel);
+	unsigned int delay;
 
 	if (p->enabled)
 		return 0;
 
-	if (p->desc->delay.enable)
-		msleep(p->desc->delay.enable);
+	delay = p->desc->delay.enable;
+
+	/*
+	 * If there is a "prepare_to_enable" delay then that's supposed to be
+	 * the delay from HPD going high until we can turn the backlight on.
+	 * However, we can only count this if HPD is handled by the panel
+	 * driver, not if it goes to a dedicated pin on the controller.
+	 * If we aren't handling the HPD pin ourselves then the best we
+	 * can do is assume that HPD went high immediately before we were
+	 * called (and link training took zero time).
+	 *
+	 * NOTE: if we ever end up in this "if" statement then we're
+	 * guaranteed that the panel_edp_wait() call below will do no delay.
+	 * It already handles that case, though, so we don't need any special
+	 * code for it.
+	 */
+	if (p->desc->delay.prepare_to_enable && !p->hpd_gpio && !p->no_hpd)
+		delay = max(delay, p->desc->delay.prepare_to_enable);
+
+	if (delay)
+		msleep(delay);
 
 	panel_edp_wait(p->prepared_time, p->desc->delay.prepare_to_enable);
 
-- 
2.33.0.259.gc128427fd7-goog

