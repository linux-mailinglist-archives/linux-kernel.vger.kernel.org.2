Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC603B3CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 08:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhFYG1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 02:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhFYG1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 02:27:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE22C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 23:24:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E80A21F442CC
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     eizan@chromium.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: mediatek: mmsys: Fix missing UFOE component in mt8173 table routing
Date:   Fri, 25 Jun 2021 08:24:48 +0200
Message-Id: <20210625062448.3462177-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFOE (data compression engine) component needs to be enabled to have
the imgtec gpu driver working. If we don't enable it we see a black screen.
Looks like when we switched to use and array for setting the routing
registers in commit 440147639ac7 ("soc: mediatek: mmsys: Use an array for
setting the routing registers") we missed to add this component in the new
routing table, it was present before taht commit, so fix it by adding
this component in the mt8173 routing table.

Fixes: 440147639ac7 ("soc: mediatek: mmsys: Use an array for setting the routing registers")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mtk-mmsys.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index a760a34e6eca..11388961dded 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -209,6 +209,9 @@ static const struct mtk_mmsys_routes mmsys_default_routing_table[] = {
 	}, {
 		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI3,
 		DISP_REG_CONFIG_DSIO_SEL_IN, DSI3_SEL_IN_RDMA2
+	}, {
+		DDP_COMPONENT_UFOE, DDP_COMPONENT_DSI0,
+		DISP_REG_CONFIG_DISP_UFOE_MOUT_EN, UFOE_MOUT_EN_DSI0,
 	}
 };
 
-- 
2.30.2

