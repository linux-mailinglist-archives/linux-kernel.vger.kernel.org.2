Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B8933E009
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhCPVJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhCPVJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:09:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90916C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:09:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t37so12648105pga.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3nGRIVAZ8p8oH1+FLMCV0ztlq3vh7E/c3Mkltgxfig=;
        b=At7nxtTZi0r6E/hJAVN5l/dmCfxqOqkm3CirquJCcbKRpxNEj0UlA5R04342G4ZGjg
         kj2dlf4h7ZIt8YPErpECIjgVtEWlTsoP7vnhaK1z+6SgXoIUci+gdClvaxnPSRnQ6b0X
         qid///YOVCa2O4AGOuVeqknyZaDXXF+sgX+Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3nGRIVAZ8p8oH1+FLMCV0ztlq3vh7E/c3Mkltgxfig=;
        b=OwgnHNEPiwQMub1eVWx42ofb80mysxfSPDGxsvwZkB5+JQBt8SuD8WwzptidFydhav
         YMgG7fubbqr1ro1SaUqukQMWHIgmWOnGbnsV+vaiWU96oy7ccYZ75l5injurNTUSpkl8
         Y/vBjA4IFri6jl/7XFzl4ehbc2Bl604E6GRzR+RFYS84O65vg4aRf6kCg+Na0B9uFJws
         lo4LgwSRg9Uf8/GzNnjZM1tdSV8/+cTASs2U3SMNYrnNePUTf6Ul9gzTH8h28oPgS1re
         3iyef3ZSocBMW+7iHna0trWzjLkAPzg2bUx7cCCnYJX8o2TSMhYEOtSOJBbhiRcF9o6A
         hEPQ==
X-Gm-Message-State: AOAM531WfApkVqv6EpeeEupbfgPomu1TTzEJQ9QqKfG7aXgm/dBFch8h
        90XiU6jnlg3tCCp8qUvwCXC8rg==
X-Google-Smtp-Source: ABdhPJx+sDl3T3tfWxKBS3KMgRQuF3wDhkFfazknzXEMfmOKK8tHUBXu5QUQSZhXOidpHjnVGnihHA==
X-Received: by 2002:a63:f311:: with SMTP id l17mr1405391pgh.349.1615928942134;
        Tue, 16 Mar 2021 14:09:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:84d6:7fd1:d469:351f])
        by smtp.gmail.com with ESMTPSA id 192sm17358072pfa.122.2021.03.16.14.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:09:01 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     robdclark@chromium.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        eballetbo@gmail.com, Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        drinkcat@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] drm/panel: panel-simple: Add the panel on sc7180-trogdor-pompom
Date:   Tue, 16 Mar 2021 14:08:20 -0700
Message-Id: <20210316140707.RFC.2.Ie81e36b66aadc4afe29eb6ae9126177b811c381e@changeid>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210316140707.RFC.1.I3a21995726282f1e9fcb70da5eb96f19ed96634f@changeid>
References: <20210316140707.RFC.1.I3a21995726282f1e9fcb70da5eb96f19ed96634f@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an entry to simple panel for the timings of a panel that
might be attached to the board sc7180-trogdor-pompom.

As talked about in the previous patch ("dt-bindings: display: simple:
Add the panel on sc7180-trogdor-pompom") any number of panels might be
attached. These panels might have different timings or even different
resolutions.

When we see a pompom panel we'll use some conservative power sequence
timings that can work with any of the panels that will be
attached. All the rest of the details about the panel can be found by
read its EDID.

NOTE: if we wanted to optimize things a bit we could figure out which
of the panels was actually attached and perhaps reduce some of the
timings by a tiny bit if it was a panel that we recognized. I won't
attempt this right now but it could be a nice future optimization,
epsecially getting rid of the 200 ms "enable delay" imposed by the
Starry panel.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
For overall discussion about the idea of defining a generic panel at
the board level, please respond in the bindings patch so we can keep
all discussion in one place.

 drivers/gpu/drm/panel/panel-simple.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4e2dad314c79..c8964efd562b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2205,6 +2205,15 @@ static const struct panel_desc hitachi_tx23d38vm0caa = {
 	},
 };
 
+static const struct panel_desc google_pompom_panel = {
+	.delay = {
+		.hpd_absent_delay = 200,
+		.enable = 200,
+		.unprepare = 500,
+	},
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 static const struct drm_display_mode innolux_at043tn24_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -4265,6 +4274,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "hit,tx23d38vm0caa",
 		.data = &hitachi_tx23d38vm0caa
+	}, {
+		.compatible = "google,pompom-panel",
+		.data = &google_pompom_panel,
 	}, {
 		.compatible = "innolux,at043tn24",
 		.data = &innolux_at043tn24,
-- 
2.31.0.rc2.261.g7f71774620-goog

