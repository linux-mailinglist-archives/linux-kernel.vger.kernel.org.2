Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E834168FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 02:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbhIXAfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 20:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbhIXAfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:35:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F18C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:34:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 203so7187918pfy.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yEiQvpP90gfZjBo9eARQA/dGO0k9EVx8RLJE4fBEffo=;
        b=iR0mGqFCRUve5BCBSrrRcCdy8Dh8jyvq9GbxxKiMzpchO1ZIxZb+bU3DDa8VjY75qD
         aP79hLfIzswYkIp/Lq5ReRkVdZiGpLFR0q6LI+w1MVPOGcx8B2kVGMmAtwlsIaGLFHtm
         1gM/Mh8A0kxKQFbL1vfPtfs69DXNEF02mUmOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yEiQvpP90gfZjBo9eARQA/dGO0k9EVx8RLJE4fBEffo=;
        b=VaRzJu7VdB/pnvRBPqHF9gFhUc6L5RYl5kZCN6ymrF8VVtq/iaOnBh7VJ91IwS+V2/
         QIvWYPaCHERJ8dlhIjMfeEr4z8JRAy3+DLfmsP8c42G24ZO9+pjOXl86C4HzBAQSLuDa
         4Ci6ZNSF82Sa3JkPJrtf6FctIaCa0ZRimFfj85OaYjNA5NBqgN8BtYXtdTu1u8oCK3Y7
         +8lLXROMyyCSEnPDAIcTyA6TCDO0J9LSzrtwrmZr4kXBCuIQKnY00ImbDaKwoZxBFP75
         8KecNd+7eLkpG3JFMjhnQ/krK06DUy6j/BOd6VyaIBFs5Gsa1e5RJbFkQm/3/mkBOoEk
         QDuw==
X-Gm-Message-State: AOAM533GJLdaJOa/T28vlbO24kBbLylWPjZtiL0mWP45GpKWkBM8CjZ8
        B7zC3YSt3PWP1YXNJEWBSQyo4w==
X-Google-Smtp-Source: ABdhPJwi1hDYHJLiTqVsQKo2Qj1wDbfpdCAQz2Fk7pGYUTkrXOEnn2izG27x7hKRaxz+DtaCR3lmDw==
X-Received: by 2002:a05:6a00:1944:b0:438:d002:6e35 with SMTP id s4-20020a056a00194400b00438d0026e35mr7047397pfk.20.1632443648891;
        Thu, 23 Sep 2021 17:34:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:74de:c8b7:3a35:1063])
        by smtp.gmail.com with UTF8SMTPSA id z17sm6932766pfj.185.2021.09.23.17.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 17:34:08 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Heiko Stuebner <heiko@sntech.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] drm/panel: innolux-p079zca: Delete panel on attach() failure
Date:   Thu, 23 Sep 2021 17:33:54 -0700
Message-Id: <20210923173336.2.I9023cf8811a3abf4964ed84eb681721d8bb489d6@changeid>
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

This problem exists since the driver's introduction, but is especially
relevant after refactored for dual-DSI variants.

Fixes: 14c8f2e9f8ea ("drm/panel: add Innolux P079ZCA panel driver")
Fixes: 7ad4e4636c54 ("drm/panel: p079zca: Refactor panel driver to support multiple panels")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index aea316225391..f194b62e290c 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -484,6 +484,7 @@ static void innolux_panel_del(struct innolux_panel *innolux)
 static int innolux_panel_probe(struct mipi_dsi_device *dsi)
 {
 	const struct panel_desc *desc;
+	struct innolux_panel *innolux;
 	int err;
 
 	desc = of_device_get_match_data(&dsi->dev);
@@ -495,7 +496,14 @@ static int innolux_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	return mipi_dsi_attach(dsi);
+	err = mipi_dsi_attach(dsi);
+	if (err < 0) {
+		innolux = mipi_dsi_get_drvdata(dsi);
+		innolux_panel_del(innolux);
+		return err;
+	}
+
+	return 0;
 }
 
 static int innolux_panel_remove(struct mipi_dsi_device *dsi)
-- 
2.33.0.685.g46640cef36-goog

