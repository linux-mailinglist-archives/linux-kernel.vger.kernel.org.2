Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA94E345AED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhCWJfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:35:02 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:32792 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhCWJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:34:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UT38NNk_1616492094;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UT38NNk_1616492094)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Mar 2021 17:34:55 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tomba@kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v2] drm/omap: dsi: Add missing IRQF_ONESHOT
Date:   Tue, 23 Mar 2021 17:34:53 +0800
Message-Id: <1616492093-68237-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the following coccicheck:
./drivers/gpu/drm/omapdrm/dss/dsi.c:4329:7-27: ERROR: Threaded IRQ with
no primary handler requested without IRQF_ONESHOT

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

Change in v2:
-Modify the fourth parameter, not the first

 drivers/gpu/drm/omapdrm/dss/dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index b31d750..5f1722b 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -4327,7 +4327,8 @@ static int omap_dsi_register_te_irq(struct dsi_data *dsi,
 	irq_set_status_flags(te_irq, IRQ_NOAUTOEN);
 
 	err = request_threaded_irq(te_irq, NULL, omap_dsi_te_irq_handler,
-				   IRQF_TRIGGER_RISING, "TE", dsi);
+				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				   "TE", dsi);
 	if (err) {
 		dev_err(dsi->dev, "request irq failed with %d\n", err);
 		gpiod_put(dsi->te_gpio);
-- 
1.8.3.1

