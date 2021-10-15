Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C057C42F6D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbhJOPSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 11:18:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35682 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbhJOPSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:18:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6FEF21F45433
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     krzysztof.kozlowski@canonical.com
Cc:     yong.wu@mediatek.com, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] memory: mtk-smi: Use ARRAY_SIZE to define MTK_SMI_CLK_NR_MAX
Date:   Fri, 15 Oct 2021 17:15:57 +0200
Message-Id: <20211015151557.510726-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This definition is tied to the number of SMI common clocks (the array
mtk_smi_common_clks): improve the definition by using the ARRAY_SIZE
macro instead. That will also reduce room for mistakes when updating
the aforementioned array in the future.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/memory/mtk-smi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index b883dcc0bbfa..6331422141e8 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -94,8 +94,6 @@ enum mtk_smi_type {
 	MTK_SMI_GEN2_SUB_COMM,	/* gen2 smi sub common */
 };
 
-#define MTK_SMI_CLK_NR_MAX			4
-
 /* larbs: Require apb/smi clocks while gals is optional. */
 static const char * const mtk_smi_larb_clks[] = {"apb", "smi", "gals"};
 #define MTK_SMI_LARB_REQ_CLK_NR		2
@@ -106,6 +104,7 @@ static const char * const mtk_smi_larb_clks[] = {"apb", "smi", "gals"};
  * sub common: Require apb/smi/gals0 clocks in has_gals case. Otherwise, only apb/smi are required.
  */
 static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1"};
+#define MTK_SMI_CLK_NR_MAX		ARRAY_SIZE(mtk_smi_common_clks)
 #define MTK_SMI_COM_REQ_CLK_NR		2
 #define MTK_SMI_COM_GALS_REQ_CLK_NR	MTK_SMI_CLK_NR_MAX
 #define MTK_SMI_SUB_COM_GALS_REQ_CLK_NR 3
-- 
2.33.0

