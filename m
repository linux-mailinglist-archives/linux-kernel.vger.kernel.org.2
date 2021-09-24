Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA3D4168F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 02:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbhIXAfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 20:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbhIXAfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:35:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378BDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:34:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id me1so5592966pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GXGQzd3Jce1GxoSPTZ2A43YJGDeYWsQ75s4W02haYwg=;
        b=nHwKrm85EJLFa5o7M8uboJTdffKYHc0HAPbo3aMjs0nIRAAEQp51SzW5Tn2rOV9ahi
         DbLzOsPVZiZFExYUpwFk7ktyoXgqDnjK2flS57f+8nttDDjahC3E5VDqvLS6EHj4OBau
         u7LVZGfmSPr93DyP9F0j+5DYfLwErGThZmnMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXGQzd3Jce1GxoSPTZ2A43YJGDeYWsQ75s4W02haYwg=;
        b=ocryh1W5LtCjGAODich0tN4BKV3wlDOKoo+3TgWAdV2Kfm98vUdC0ERVXuqOoRNRQo
         uoTl7rmBXxlft75jd2MQPirtpRrVEVIZGfUFX+PwkvEKSdMK5fzNAqiQNphpwvRB4uFc
         5nm8beEpZqSznvZuZsTykbq96qoMV6YxcrvaYoCxi9grPK6zP2scUnnqVUNwanFysDaY
         /RfQqeVpZStIWEPaSetss+i8hrmpMZ+0GcCPtYZhCeoqUn/9xpJqOgfE8QO7NA8+Qxx3
         GRDVGe9P7KfAEmS95s/M0f6hoLnziE01avhzDeJqKSOzSdtCpgujpQctEEKK5haT2/95
         c4vQ==
X-Gm-Message-State: AOAM533d+u54tADHVIsmizwJPPkwXvxtudB88zx1wEVoHkNa8ZrEK2O8
        qNosst6HE44zWCIa+dCkr96IsA==
X-Google-Smtp-Source: ABdhPJx1E98jD2DkQdaawUmqRlzLrAbBO7749cZgFl3tEU29OWh4NKQSpueGR38+XSYRfWHElUfPlA==
X-Received: by 2002:a17:90b:1102:: with SMTP id gi2mr8456536pjb.43.1632443646797;
        Thu, 23 Sep 2021 17:34:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:74de:c8b7:3a35:1063])
        by smtp.gmail.com with UTF8SMTPSA id c3sm7465375pgn.76.2021.09.23.17.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 17:34:06 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Heiko Stuebner <heiko@sntech.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/3] drm/panel: kingdisplay-kd097d04: Delete panel on attach() failure
Date:   Thu, 23 Sep 2021 17:33:53 -0700
Message-Id: <20210923173336.1.Icb4d9dbc1817f4e826361a4f1cea7461541668f0@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210924003355.2071543-1-briannorris@chromium.org>
References: <20210924003355.2071543-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we fail to attach (e.g., because 1 of 2 dual-DSI controllers aren't
ready), we leave a dangling drm_panel reference to freed memory. Clean
that up on failure.

Fixes: 2a994cbed6b2 ("drm/panel: Add Kingdisplay KD097D04 panel driver")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 86e4213e8bb1..daccb1fd5fda 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -406,7 +406,13 @@ static int kingdisplay_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	return mipi_dsi_attach(dsi);
+	err = mipi_dsi_attach(dsi);
+	if (err < 0) {
+		kingdisplay_panel_del(kingdisplay);
+		return err;
+	}
+
+	return 0;
 }
 
 static int kingdisplay_panel_remove(struct mipi_dsi_device *dsi)
-- 
2.33.0.685.g46640cef36-goog

