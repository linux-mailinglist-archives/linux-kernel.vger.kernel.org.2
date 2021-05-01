Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F9B370786
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhEAORS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 10:17:18 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:44003 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhEAORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 10:17:17 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d06 with ME
        id zSGP2400S21Fzsu03SGQKS; Sat, 01 May 2021 16:16:25 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 01 May 2021 16:16:25 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, heiko.stuebner@theobroma-systems.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/panel: xinpeng: Fix an error handling path
Date:   Sat,  1 May 2021 16:16:22 +0200
Message-Id: <6e3a8cb3956fe94f1259c13053fddb378e7d0d82.1619878508.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ret' is know to be >=0 a this point. Checking the return value of
'mipi_dsi_dcs_enter_sleep_mode()' was intended instead.

So add the missing assignment.

Fixes: d1479d028af2 ("drm/panel: add panel driver for Xinpeng XPP055C272 panels")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
index 55172d63a922..4e51303153af 100644
--- a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
+++ b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
@@ -151,7 +151,7 @@ static int xpp055c272_unprepare(struct drm_panel *panel)
 	if (ret < 0)
 		dev_err(ctx->dev, "failed to set display off: %d\n", ret);
 
-	mipi_dsi_dcs_enter_sleep_mode(dsi);
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
 	if (ret < 0) {
 		dev_err(ctx->dev, "failed to enter sleep mode: %d\n", ret);
 		return ret;
-- 
2.30.2

