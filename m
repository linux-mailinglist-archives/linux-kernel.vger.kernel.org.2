Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324FB402280
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 05:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhIGDgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 23:36:43 -0400
Received: from mx20.baidu.com ([111.202.115.85]:39302 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230133AbhIGDgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 23:36:42 -0400
Received: from BJHW-Mail-Ex12.internal.baidu.com (unknown [10.127.64.35])
        by Forcepoint Email with ESMTPS id C0CA7751C5B3C291EAE1;
        Tue,  7 Sep 2021 11:35:32 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex12.internal.baidu.com (10.127.64.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 11:35:32 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 11:35:32 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomba@kernel.org>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/tidss: Make use of the helper macro SET_RUNTIME_PM_OPS()
Date:   Tue, 7 Sep 2021 11:35:26 +0800
Message-ID: <20210907033526.1612-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex05.internal.baidu.com (10.127.64.15) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex12_2021-09-07 11:35:32:812
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper macro SET_RUNTIME_PM_OPS() instead of the verbose
operators ".runtime_suspend/.runtime_resume", because the
SET_RUNTIME_PM_OPS() is a nice helper macro that could be brought
in to make code a little more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2:	*Remove "#ifdef CONFIG_PM" around around runtime_suspend|resume().
	*Make use of pm_ptr() in the assignment in tidss_platform_driver.

v1 comments link:
	https://www.spinics.net/lists/dri-devel/msg313178.html
 
drivers/gpu/drm/tidss/tidss_drv.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index d620f35688da..4366b5c798e0 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -88,16 +88,11 @@ static int __maybe_unused tidss_resume(struct device *dev)
 	return drm_mode_config_helper_resume(&tidss->ddev);
 }
 
-#ifdef CONFIG_PM
-
 static const struct dev_pm_ops tidss_pm_ops = {
-	.runtime_suspend = tidss_pm_runtime_suspend,
-	.runtime_resume = tidss_pm_runtime_resume,
 	SET_SYSTEM_SLEEP_PM_OPS(tidss_suspend, tidss_resume)
+	SET_RUNTIME_PM_OPS(tidss_pm_runtime_suspend, tidss_pm_runtime_resume, NULL)
 };
 
-#endif /* CONFIG_PM */
-
 /* DRM device Information */
 
 static void tidss_release(struct drm_device *ddev)
@@ -250,9 +245,7 @@ static struct platform_driver tidss_platform_driver = {
 	.shutdown	= tidss_shutdown,
 	.driver		= {
 		.name	= "tidss",
-#ifdef CONFIG_PM
-		.pm	= &tidss_pm_ops,
-#endif
+		.pm	= pm_ptr(&tidss_pm_ops),
 		.of_match_table = tidss_of_table,
 		.suppress_bind_attrs = true,
 	},
-- 
2.25.1

