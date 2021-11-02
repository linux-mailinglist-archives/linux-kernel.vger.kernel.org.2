Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C52442D89
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhKBMKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:10:51 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51390 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229577AbhKBMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:10:47 -0400
X-UUID: fc93807cb8d54e30a261ce4965f119d4-20211102
X-UUID: fc93807cb8d54e30a261ce4965f119d4-20211102
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 142101394; Tue, 02 Nov 2021 20:08:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 2 Nov 2021 20:08:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 2 Nov 2021 20:08:07 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>
CC:     <matthias.bgg@gmail.com>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH] remoteproc: use %d format string to print return error code
Date:   Tue, 2 Nov 2021 20:08:05 +0800
Message-ID: <20211102120805.27137-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %d format string to print return error code which
make the error message easier to understand.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 502b6604b757..c5cc7f30f06e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -575,7 +575,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 					   dma_get_mask(rproc->dev.parent));
 	if (ret) {
 		dev_warn(dev,
-			 "Failed to set DMA mask %llx. Trying to continue... %x\n",
+			 "Failed to set DMA mask %llx. Trying to continue... %d\n",
 			 dma_get_mask(rproc->dev.parent), ret);
 	}
 
-- 
2.18.0

