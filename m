Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD45399FAF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFCLWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:22:47 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:55990 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFCLWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:22:46 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jun 2021 07:22:46 EDT
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id D26A0380367;
        Thu,  3 Jun 2021 19:14:57 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/mediatek: remove redundant error log print
Date:   Thu,  3 Jun 2021 04:14:49 -0700
Message-Id: <20210603111455.5963-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUoZQ1YYGklCHk5CGE0fHRlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NU06UTo4NT8TIxQ8Th49PA4r
        Cg9PCSJVSlVKTUlJTEpDQ0JDSElNVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFJSkpJNwY+
X-HM-Tid: 0a79d1955f8cd994kuwsd26a0380367
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning:
drivers/gpu/drm/mediatek/mtk_dsi.c:1074:2-9: line 1074 is
redundant because platform_get_irq() already prints an error.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index ae403c67cbd9..e2e4fc8b1360 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1082,10 +1082,8 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq,
 			       IRQF_TRIGGER_NONE, dev_name(&pdev->dev), dsi);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
+	if (ret)
 		goto err_unregister_host;
-	}
 
 	init_waitqueue_head(&dsi->irq_wait_queue);
 
-- 
2.31.0

