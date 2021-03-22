Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADC5343C17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCVIvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:51:24 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:58039 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229761AbhCVIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:51:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UStxBnE_1616403076;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UStxBnE_1616403076)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Mar 2021 16:51:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tomba@kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] drm/omap: dsi: Add missing IRQF_ONESHOT
Date:   Mon, 22 Mar 2021 16:51:10 +0800
Message-Id: <1616403070-35776-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the following coccicheck:
./drivers/gpu/drm/omapdrm/dss/dsi.c:4329:7-27: ERROR: Threaded IRQ with
no primary handler requested without IRQF_ONESHOT

Make sure threaded IRQs without a primary handler are always request
with IRQF_ONESHOT

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index b31d750..844cb0b 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -4326,7 +4326,7 @@ static int omap_dsi_register_te_irq(struct dsi_data *dsi,
 
 	irq_set_status_flags(te_irq, IRQ_NOAUTOEN);
 
-	err = request_threaded_irq(te_irq, NULL, omap_dsi_te_irq_handler,
+	err = request_threaded_irq(te_irq | IRQF_ONESHOT, NULL, omap_dsi_te_irq_handler,
 				   IRQF_TRIGGER_RISING, "TE", dsi);
 	if (err) {
 		dev_err(dsi->dev, "request irq failed with %d\n", err);
-- 
1.8.3.1

