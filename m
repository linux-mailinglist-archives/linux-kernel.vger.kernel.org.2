Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C682339CA6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 08:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhCMHsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 02:48:39 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:34722 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhCMHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 02:48:08 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id C002F40011C;
        Sat, 13 Mar 2021 15:48:06 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] gpu: drm: mediatek: delete redundant printing of return value
Date:   Sat, 13 Mar 2021 15:48:02 +0800
Message-Id: <1615621683-2122-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHRpOGh8dGElDGRlJVkpNSk5NSUpNQ0xKQ0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6Ixw5Lz8POVELLR0KCSMd
        MEoKCTdVSlVKTUpOTUlKTUNMTk9NVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFJS0hNNwY+
X-HM-Tid: 0a782a8e873ed991kuwsc002f40011c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() has already checked and printed the return value, 
the printing here is nothing special, it is not necessary at all.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index b05f900..0ac4962
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -751,10 +751,8 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	}
 
 	dpi->irq = platform_get_irq(pdev, 0);
-	if (dpi->irq <= 0) {
-		dev_err(dev, "Failed to get irq: %d\n", dpi->irq);
+	if (dpi->irq <= 0)
 		return -EINVAL;
-	}
 
 	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
 					  NULL, &dpi->next_bridge);
-- 
2.7.4

