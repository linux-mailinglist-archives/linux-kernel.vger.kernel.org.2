Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDB63C88BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhGNQhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhGNQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:37:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB8BC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:34:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g24so1925749pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHfXFlYPkOoEXPCCOLBKjOdjj5fhvAcbLcnpmyX6Rzs=;
        b=kzM/wJxX/ARXMgLYgwtXIUaYeElUlpzngpkjkLSnAFhe6tby3cVK4MyJPwScuo5eW3
         5bH2un75y+GNEXV3PFulv+VgLwmoWP/5K7N2R8Uy3OGANaOfLwgRRK6jvLNqSUXBPpiG
         s9SiyydCO7rx8EwBxrJKhq+cqU3hpS2eCK7Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHfXFlYPkOoEXPCCOLBKjOdjj5fhvAcbLcnpmyX6Rzs=;
        b=oLDeypEdGRei3UTMn73tQN0axYbR5RVAQh0d/UPOn7gSuD66p02EzAZMy0QMMIYaiz
         FBSRNmhnrCLD1GzLhBX8zV8fl4M6pTvcKCH8otbv1UKrzo5F7U5GZv1CvD6iE35a6WU2
         K6I781x4uuS2iuGltsx17YGEPzQMlXMESbh7p605g1cV7u59AO0BO3fvOD/wmZBE+Uqk
         Ad121h4yXOdq/EaM+RCowUfkarvL0k9FhBezLgIQ25cgbETsb2BxRmd3RnQYftohw42r
         FWOGXfNO488mTaHlTAGwcKaihsdt0O1MGwtsvwReHzc+hVT6Xxg6WnU1rSZhfoap8mHI
         a5ew==
X-Gm-Message-State: AOAM531i1PjSQFqpGfPOi3CsLL5gyKrGHB5ddTpRrPz1IuRCoAvNXwxu
        gNPBQ8lFUoRJg1uRaLAldhQY4w==
X-Google-Smtp-Source: ABdhPJzmUrgaB1ssMYupE7CPM/xJFTXlef32hZaN4mLbp6prJuQdZAtJzNFkwHikZe/83e0nrMjQMQ==
X-Received: by 2002:a17:90a:e288:: with SMTP id d8mr10667424pjz.226.1626280453172;
        Wed, 14 Jul 2021 09:34:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:5a9d:ef42:7eb4:5fea])
        by smtp.gmail.com with ESMTPSA id q14sm3257620pff.209.2021.07.14.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 09:34:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rajeev Nandan <rajeevny@codeaurora.org>,
        Lyude Paul <lyude@redhat.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-simple: Power the panel when probing DP AUX backlight
Date:   Wed, 14 Jul 2021 09:33:50 -0700
Message-Id: <20210714093334.1.Idb41f87e5abae4aee0705db7458b0097fc50e7ab@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I tried booting up a device that needed the DP AUX backlight, I
found an error in the logs:
  panel-simple-dp-aux: probe of aux-ti_sn65dsi86.aux.0 failed with error -110

The aux transfers were failing because the panel wasn't powered. Just
like when reading the EDID we need to power the panel when trying to
talk to it. Add the needed pm_runtime calls.

After I do this I can successfully probe the panel and adjust the
backlight on my board.

Fixes: bfd451403d70 ("drm/panel-simple: Support DP AUX backlight")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e0a05f366ce6..9b286bd4444f 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -827,7 +827,10 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc,
 		goto disable_pm_runtime;
 
 	if (!panel->base.backlight && panel->aux) {
+		pm_runtime_get_sync(dev);
 		err = drm_panel_dp_aux_backlight(&panel->base, panel->aux);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
 		if (err)
 			goto disable_pm_runtime;
 	}
-- 
2.32.0.93.g670b81a890-goog

