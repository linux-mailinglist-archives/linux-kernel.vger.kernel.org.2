Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555743D30E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhGVXmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 19:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhGVXlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 19:41:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872BEC06179A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:22:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a20so1447740plm.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWScQ3RoXdLdJS9t+RJN8kdgO9NRWYfVw++Ppk8gyUQ=;
        b=XqCcX4qSfe4fNA6xqHdCXE7WfptpmrsuVLTgFjOiMco81rVjYmUxtJip9IGSAumy3g
         PY/iX0k4asGRdW1+C7Odrq6m1900W/I8qEao9ifYHDajtZ6v8UJqceHNZnyoQApRRfJL
         AlchELWMfPx3fYJN1EkRqZPAOr9sTG5BTSjCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWScQ3RoXdLdJS9t+RJN8kdgO9NRWYfVw++Ppk8gyUQ=;
        b=lxcQ2lb4SMX69BlyspnRgBflPTVEk6A+0ND08rR1+gr/rEvfnRRPuUQMoWYO1CzjTo
         Htu8shM/M6ODC53FhuLzklMKuW0DbWIIgl7Sl1PMEo7JROWSx20snbxKb9T8Cw8yun+e
         WbwBZHh95diiTRnqPX+1I9CBt0I3CAP3LWaf1olAkPYwXwdqtvx4FcBDquQhNvBmWhdF
         o1zoiclM3VP+39XpF9c/0GFjgL1QMsVayjz5CCl0n7X3RiemjRbMgyvdCR39Vrb+HfXF
         dCJzQuq/KqzVjHkWktdTe3McVVpAJ+02uVQydGwWybCQl6+6jFRiVU2dPR2zMff/yvOh
         d2+Q==
X-Gm-Message-State: AOAM532zieyjTVQ7KwIaYQrR5Pfq+OfBDsqgo053tBbxpqEmmZDVWxV3
        h0UtkylnWW5qbAhX6y7YVPasIg==
X-Google-Smtp-Source: ABdhPJwHpj2aZr9pdn1A/6Wx4oICGJjmdyIfL+SVJ2uAcEvkUKah5a3ORUThg/UpxLy0oPpE5BTJDA==
X-Received: by 2002:a17:90a:6c61:: with SMTP id x88mr11582187pjj.122.1626999734119;
        Thu, 22 Jul 2021 17:22:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:5e70:6a49:67b5:2b7e])
        by smtp.gmail.com with ESMTPSA id iy13sm4072377pjb.28.2021.07.22.17.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 17:22:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/8] drm/panel-simple: Don't re-read the EDID every time we power off the panel
Date:   Thu, 22 Jul 2021 17:21:42 -0700
Message-Id: <20210722172104.RFC.4.Ib810fb3bebd0bd6763e4609e1a6764d06064081e@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210723002146.1962910-1-dianders@chromium.org>
References: <20210723002146.1962910-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple-panel driver is for panels that are not hot-pluggable at
runtime. Let's keep our cached EDID around until driver unload.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9b286bd4444f..bcdc84b20827 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -370,9 +370,6 @@ static int panel_simple_suspend(struct device *dev)
 	regulator_disable(p->supply);
 	p->unprepared_time = ktime_get();
 
-	kfree(p->edid);
-	p->edid = NULL;
-
 	return 0;
 }
 
@@ -862,6 +859,9 @@ static int panel_simple_remove(struct device *dev)
 	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
 		put_device(&panel->ddc->dev);
 
+	kfree(panel->edid);
+	panel->edid = NULL;
+
 	return 0;
 }
 
-- 
2.32.0.432.gabb21c7263-goog

