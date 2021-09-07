Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCBE402369
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 08:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhIGG0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 02:26:10 -0400
Received: from mx21.baidu.com ([220.181.3.85]:54148 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232523AbhIGGZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:25:03 -0400
Received: from BJHW-Mail-Ex09.internal.baidu.com (unknown [10.127.64.32])
        by Forcepoint Email with ESMTPS id CAB4E2C3067860A9672F;
        Tue,  7 Sep 2021 14:23:55 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex09.internal.baidu.com (10.127.64.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 14:23:55 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 14:23:55 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: panel: tl070wsh30: Add a single error handling block at the end of the function.
Date:   Tue, 7 Sep 2021 14:23:48 +0800
Message-ID: <20210907062349.1879-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex30.internal.baidu.com (172.31.51.24) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex09_2021-09-07 14:23:55:818
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single error handling block at the end of the function could
be brought in to make code a little more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index 820731be7147..5e54ef4b3a9c 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -59,8 +59,7 @@ static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
 	err = mipi_dsi_dcs_exit_sleep_mode(tdo_tl070wsh30->link);
 	if (err < 0) {
 		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
-		regulator_disable(tdo_tl070wsh30->supply);
-		return err;
+		goto err_disable_reg;
 	}
 
 	msleep(200);
@@ -68,8 +67,7 @@ static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
 	err = mipi_dsi_dcs_set_display_on(tdo_tl070wsh30->link);
 	if (err < 0) {
 		dev_err(panel->dev, "failed to set display on: %d\n", err);
-		regulator_disable(tdo_tl070wsh30->supply);
-		return err;
+		goto err_disable_reg;
 	}
 
 	msleep(20);
@@ -77,6 +75,9 @@ static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
 	tdo_tl070wsh30->prepared = true;
 
 	return 0;
+err_disable_reg:
+	regulator_disable(tdo_tl070wsh30->supply);
+	return err;
 }
 
 static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
-- 
2.25.1

