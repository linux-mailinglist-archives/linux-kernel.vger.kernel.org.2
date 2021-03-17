Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F56533EA86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCQH2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:28:00 -0400
Received: from m12-18.163.com ([220.181.12.18]:53569 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhCQH1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Qtn8+
        btActA3yRVKwroBj6KrwpUMXfwBi44efCfGx7E=; b=AW7OmkXfKVD5lCEZK0jEk
        aUYV5AVWOBO5yWCYFbVQfGID6u6Wezs9wtBXZJ1zTdhvPPMBUY2fDXOiWZ3uhSLu
        U/2HiuI1dtfj0LzLPqLsynt8rHctVK7F2LoMMxr4Cj+YEvvC/GSxTPkkMK/aDUy9
        uhgdbJDdoJ0IYnB+NjEBCc=
Received: from COOL-20200911ZP.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowABXXgLBrlFgqQUIZQ--.44099S2;
        Wed, 17 Mar 2021 15:25:01 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     airlied@linux.ie, daniel@ffwll.ch, matthias.bgg@gmail.com,
        chunkuang.hu@kernel.org, p.zabel@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tangchunyou@yulong.com
Subject: [PATCH] the print is redundant because platform_get_irq()
Date:   Wed, 17 Mar 2021 15:24:43 +0800
Message-Id: <20210317072443.286-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowABXXgLBrlFgqQUIZQ--.44099S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyfXw43XryDWryfCFy7trb_yoW3CFX_Ca
        1kZrnruFWFvr98Zr1ayr13Ary2vFs09r40qF98ta4Svr9xCryUXr9F9rnIvF4kWa97ZFyD
        X3s5WFyF9rnIkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0RBTUUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiZQ1YUV8ZNQWSjAAAsJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangchunyou <tangchunyou@yulong.com>

already prints an error.

Signed-off-by: tangchunyou <tangchunyou@yulong.com>
---
 drivers/gpu/drm/mediatek/mtk_cec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index cb29b64..332a4df 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -208,10 +208,8 @@ static int mtk_cec_probe(struct platform_device *pdev)
 	}
 
 	cec->irq = platform_get_irq(pdev, 0);
-	if (cec->irq < 0) {
-		dev_err(dev, "Failed to get cec irq: %d\n", cec->irq);
+	if (cec->irq < 0)
 		return cec->irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, cec->irq, NULL,
 					mtk_cec_htplg_isr_thread,
-- 
1.9.1


