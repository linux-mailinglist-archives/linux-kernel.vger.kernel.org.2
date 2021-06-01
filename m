Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53625396FF8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhFAJKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:10:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6108 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFAJKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:10:44 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvR954gkWzYnSM;
        Tue,  1 Jun 2021 17:06:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:09:01 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:09:00 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        "Signed-off-by : Wolfram Sang" <wsa@the-dreams.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] video: fbdev: mb862xx: use DEVICE_ATTR_RO macro
Date:   Tue, 1 Jun 2021 17:08:52 +0800
Message-ID: <20210601090852.10531-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR, which makes the
code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index 52755b591c1489f..63721337a37787b 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -542,8 +542,8 @@ static int mb862xxfb_init_fbinfo(struct fb_info *fbi)
 /*
  * show some display controller and cursor registers
  */
-static ssize_t mb862xxfb_show_dispregs(struct device *dev,
-				       struct device_attribute *attr, char *buf)
+static ssize_t dispregs_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
 	struct mb862xxfb_par *par = fbi->par;
@@ -577,7 +577,7 @@ static ssize_t mb862xxfb_show_dispregs(struct device *dev,
 	return ptr - buf;
 }
 
-static DEVICE_ATTR(dispregs, 0444, mb862xxfb_show_dispregs, NULL);
+static DEVICE_ATTR_RO(dispregs);
 
 static irqreturn_t mb862xx_intr(int irq, void *dev_id)
 {
-- 
2.26.0.106.g9fadedd


