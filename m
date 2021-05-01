Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB0B370713
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 13:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhEALwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 07:52:49 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:38119 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhEALws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 07:52:48 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d12 with ME
        id zPrv2400321Fzsu03PrvnW; Sat, 01 May 2021 13:51:57 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 01 May 2021 13:51:57 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, heiko.stuebner@theobroma-systems.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/panel: leadtek: Fix an error handling path
Date:   Sat,  1 May 2021 13:51:54 +0200
Message-Id: <588e8b4519487f6d33419c4b0fa7f8ea1b26cb58.1619869792.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ret' is know to be >=0 a this point. Checking the return value of
'mipi_dsi_dcs_enter_sleep_mode()' was intended instead.

So add the missing assignment.

Fixes: 6ea4383b9214 ("drm/panel: add panel driver for Leadtek LTK050H3146W")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index ed0d5f959037..6044703df1a7 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -450,7 +450,7 @@ static int ltk050h3146w_unprepare(struct drm_panel *panel)
 		return ret;
 	}
 
-	mipi_dsi_dcs_enter_sleep_mode(dsi);
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
 	if (ret < 0) {
 		dev_err(ctx->dev, "failed to enter sleep mode: %d\n", ret);
 		return ret;
-- 
2.30.2

