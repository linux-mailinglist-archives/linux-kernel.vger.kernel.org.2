Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63B6430323
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbhJPPAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbhJPPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 11:00:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFCCC061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 07:58:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i12so31698900wrb.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSa9+WE8uuYD4JU3BD/0wd8AvNRsedQex6FUgygWjvY=;
        b=LtadyATr+g5QlTR+qzQ3TE6Q85hkpwUYta2LyN3dCMl3Y1A9eBB0CgksInni0YBDWc
         I/5oLDCdPag+bT3G1lHDS/DZbF53XiC8musArvvHZaFT/tt+b3GaSKYIYn+Yk7xuFSBg
         tUUGDDUgFz6X6ZbNsPmztYPpZK5zPdcZa/neo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSa9+WE8uuYD4JU3BD/0wd8AvNRsedQex6FUgygWjvY=;
        b=Uz+AI01N7PatLGDXufvcvyA8y5cO/yISz65r4206zdkZ0ezXfcgOQEKOIRYYk6AcGS
         ZcaMn5fB4j1UMLlmrgqWxGEfO1l+QfS8jsmxx7yetpPzfAWJLsQVqaqgdUovPNm8oko0
         Hjfec1GvR48Fm/WyxhYE9dpkSuoZY2DZKn/FYOFfvnJ/V5QYK8Cfz/ETVjCJQ34omuf4
         BscQUVkuGYoIRv0WX4/Nw8nFda8rX8Xr1lgoTKTrYMQvuBy0CiaXg6+GqZ+J1Mi6qHlH
         n1U23M6BjaI1MTcm91+ArXpRLy6KG10yNaWopueVdtV/2FceHcU8ncUhLwKlXLkjlS2l
         e64g==
X-Gm-Message-State: AOAM530Czm0yfjjk7P7GJifkx/mIekxGwDeR0GeF6pwlHQDMW9HPvMnB
        igILWy2tMNIEf9DVu83rBkoLkA==
X-Google-Smtp-Source: ABdhPJzEAIKuzDuIKng6I7M/PjObEzk15w7bde3iUEfDUKwxJ+AM3kzuR29wmivJLGrnd9Ywwk9ysg==
X-Received: by 2002:a05:6000:1884:: with SMTP id a4mr22632113wri.356.1634396309420;
        Sat, 16 Oct 2021 07:58:29 -0700 (PDT)
Received: from panicking.amarulasolutions.com (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id l10sm7998393wms.31.2021.10.16.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 07:58:28 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: ilitek-ili9881c: Avoid unbalance prepare/unprepare
Date:   Sat, 16 Oct 2021 16:58:27 +0200
Message-Id: <20211016145827.586870-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the panel driver check the fact that their prepare/unprepare
call was already called. It's not an ideal solution but fix
for now the problem on ili9881c

[ 9862.283296] ------------[ cut here ]------------
[ 9862.288490] unbalanced disables for vcc3v3_lcd
[ 9862.293555] WARNING: CPU: 0 PID: 1 at drivers/regulator/core.c:2851
_regulator_disable+0xd4/0x190

from:

[ 9862.038619]  drm_panel_unprepare+0x2c/0x4c
[ 9862.043212]  panel_bridge_post_disable+0x18/0x24
[ 9862.048390]  dw_mipi_dsi_bridge_post_disable+0x3c/0xf0
[ 9862.054153]  drm_atomic_bridge_chain_post_disable+0x8c/0xd0

and:

[ 9862.183103]  drm_panel_unprepare+0x2c/0x4c
[ 9862.187695]  panel_bridge_post_disable+0x18/0x24
[ 9862.192872]  drm_atomic_bridge_chain_post_disable+0x8c/0xd0
[ 9862.199117]  disable_outputs+0x120/0x31c

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 103a16018975..f75eecb0e65c 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -52,6 +52,8 @@ struct ili9881c {
 
 	struct regulator	*power;
 	struct gpio_desc	*reset;
+
+	bool			prepared;
 };
 
 #define ILI9881C_SWITCH_PAGE_INSTR(_page)	\
@@ -707,6 +709,10 @@ static int ili9881c_prepare(struct drm_panel *panel)
 	unsigned int i;
 	int ret;
 
+	/* Preparing when already prepared is a no-op */
+	if (ctx->prepared)
+		return 0;
+
 	/* Power the panel */
 	ret = regulator_enable(ctx->power);
 	if (ret)
@@ -745,6 +751,8 @@ static int ili9881c_prepare(struct drm_panel *panel)
 	if (ret)
 		return ret;
 
+	ctx->prepared = true;
+
 	return 0;
 }
 
@@ -770,10 +778,16 @@ static int ili9881c_unprepare(struct drm_panel *panel)
 {
 	struct ili9881c *ctx = panel_to_ili9881c(panel);
 
+	/* Unpreparing when already unprepared is a no-op */
+	if (!ctx->prepared)
+		return 0;
+
 	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
 	regulator_disable(ctx->power);
 	gpiod_set_value(ctx->reset, 1);
 
+	ctx->prepared = false;
+
 	return 0;
 }
 
-- 
2.25.1

