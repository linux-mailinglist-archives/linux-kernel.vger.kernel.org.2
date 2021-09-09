Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E78405E85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347173AbhIIVDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347720AbhIIVDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:03:01 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C3AC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 14:01:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e7so1905133plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dq4h7+QxpbiqQXm8FiH1luLdpO9yHnMWiTl8Lza6PBM=;
        b=WLV/YrRrnMKqArMiJdvvON6tMRXjqwpkooltJM59BjEurKmvO2A/Mk3IoxauyUHatY
         YmxnWXCyoIeFRyNkzHacDe1TcqCZIUWLg9WCC0/WiYb/O2lnhyeTNmDTiYNH4fbKZWlB
         dKzmpi66llN8pZtVGaywSgNou5lpbBmFbPxbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dq4h7+QxpbiqQXm8FiH1luLdpO9yHnMWiTl8Lza6PBM=;
        b=YaxLe+gI78JKO1vIg6kR7rePM8LPpSzJKajyp4RfKpFg/Qf8w+/kkRDjNpl/I6FGon
         rjZGXi497+FdiZ5ISDGroHiU1/bKg9ApBkuMV1MAtWUVla8JHAcN6CTvgeNOltYNyM4D
         ZHskijKPSAvSlV00pCgKJR4LLys9qVNazWmD1UvRf7LYXgJPDtEFU9jMK/kVSh6zA5Fm
         PcvIWgTfrzvlnh/uC+6IcLe9/EhN6ilEO/Hvo+2K6oJP+69qSO2m4qcXJmcpSFGWpAyq
         I1AWe0IMJQYqwqvuFE8umYU6+qQTLJHlKDExwwsJJh2TgXJUEw3vdXmscunGyrUGnYpV
         SneA==
X-Gm-Message-State: AOAM5315CnSW5cpFpxTUjHmGfC09fkQGQN+/WRCMnigmtbKEV9F+rxCO
        arHBiAdlmy5zKWj8AvQXTCj9lA==
X-Google-Smtp-Source: ABdhPJyLD/l/Ob7B2ukN9J6bpeSGDZ/UDyih3lCihpbRAGX0gLMqPZNaiVPNl4b6EOwVET+FPysFGg==
X-Received: by 2002:a17:90b:3b47:: with SMTP id ot7mr5674996pjb.172.1631221307302;
        Thu, 09 Sep 2021 14:01:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8da3:b0fb:4261:2c10])
        by smtp.gmail.com with ESMTPSA id l143sm177069pfd.60.2021.09.09.14.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 14:01:46 -0700 (PDT)
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
Subject: [PATCH v4 13/15] drm/panel-edp: Fix "prepare_to_enable" if panel doesn't handle HPD
Date:   Thu,  9 Sep 2021 14:00:29 -0700
Message-Id: <20210909135838.v4.13.Ia8288d36df4b12770af59ae3ff73ef7e08fb4e2e@changeid>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
In-Reply-To: <20210909210032.465570-1-dianders@chromium.org>
References: <20210909210032.465570-1-dianders@chromium.org>
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
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v4:
- panel-simple-edp => panel-edp

Changes in v3:
- Fix "prepare_to_enable" patch new for v3.

 drivers/gpu/drm/panel/panel-edp.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 80a37a4e5750..a83ef9905ea7 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
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
2.33.0.309.g3052b89438-goog

