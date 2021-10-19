Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84311432FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhJSHjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:39:47 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:49933 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229930AbhJSHjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:39:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UssX2l8_1634629050;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UssX2l8_1634629050)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 15:37:31 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     thierry.reding@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drm/panel: remove unneeded semicolon
Date:   Tue, 19 Oct 2021 15:37:26 +0800
Message-Id: <1634629046-116842-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/gpu/drm/panel/panel-novatek-nt35950.c:639:2-3: Unneeded
semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index d42c7af..3821c66 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -636,7 +636,7 @@ static int nt35950_remove(struct mipi_dsi_device *dsi)
 			dev_err(&dsi->dev,
 				"Failed to detach from DSI1 host: %d\n", ret);
 		mipi_dsi_device_unregister(nt->dsi[1]);
-	};
+	}
 
 	drm_panel_remove(&nt->panel);
 
-- 
1.8.3.1

