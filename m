Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C123C34B9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhGJNcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 09:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhGJNcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 09:32:51 -0400
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de [IPv6:2a03:2900:1:1::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C69C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 06:30:05 -0700 (PDT)
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id 3A0F62C503
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 13:24:55 +0000 (UTC)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id 2986F3FD96;
        Sat, 10 Jul 2021 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1625923491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wJMDjXBafhvNxiRagDqsC9dExnn1uVvik0Aoqi/lvZI=;
        b=ruW1qKc5g+v4UdI4glw06pkfB6z/CEmSNZ2fbqGvtkz5r8U2uPBmt2o81uf0x9Qar5Jyoc
        h8npIE7M/MrDu5bN6K18ta6p/uyENMSxDR723doL4+UYGpniOaFqjcxvsEVMVJn14HqK2H
        pYp8a3n0BgMdnU3P4umwQUYF4N05Ml4=
Received: from localhost.localdomain (fttx-pool-217.61.146.228.bambit.de [217.61.146.228])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 429C94005D;
        Sat, 10 Jul 2021 13:24:50 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] soc: mediatek: mmsys: fix HDMI output on mt7623/bananapi-r2
Date:   Sat, 10 Jul 2021 15:24:31 +0200
Message-Id: <20210710132431.265985-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 1f821dd4-763b-4f4a-a1cd-dc3fe34c2e99
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

HDMI output was broken on mt7623/BPI-R2 in 5.13 because function for
special output selection (mtk_mmsys_ddp_sout_sel) was dropped.
This function wrote 3 registers at one time and so it is not compatible
with the array-approach.

I re-added the old function and call this after the default routing table
was applied. This default routing table can still be used as the only
connection handled by mmsys on BPI-R2 is OVL0->RDMA0 and this is already
present in the default routing table

Fixes: 440147639ac7 ("soc: mediatek: mmsys: Use an array for setting the routing registers")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/soc/mediatek/mtk-mmsys.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 080660ef11bf..f91b7fdd417a 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -57,6 +57,25 @@ struct mtk_mmsys {
 	const struct mtk_mmsys_driver_data *data;
 };
 
+static void mtk_mmsys_ddp_sout_sel(struct device *dev,
+				   enum mtk_ddp_comp_id cur,
+				   enum mtk_ddp_comp_id next)
+{
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
+
+	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
+		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
+			       mmsys->regs + DISP_REG_CONFIG_OUT_SEL);
+	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
+		writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
+			       mmsys->regs + DISP_REG_CONFIG_OUT_SEL);
+		writel_relaxed(DSI_SEL_IN_RDMA,
+			       mmsys->regs + DISP_REG_CONFIG_DSI_SEL);
+		writel_relaxed(DPI_SEL_IN_BLS,
+			       mmsys->regs + DISP_REG_CONFIG_DPI_SEL);
+	}
+}
+
 void mtk_mmsys_ddp_connect(struct device *dev,
 			   enum mtk_ddp_comp_id cur,
 			   enum mtk_ddp_comp_id next)
@@ -71,6 +90,8 @@ void mtk_mmsys_ddp_connect(struct device *dev,
 			reg = readl_relaxed(mmsys->regs + routes[i].addr) | routes[i].val;
 			writel_relaxed(reg, mmsys->regs + routes[i].addr);
 		}
+
+	mtk_mmsys_ddp_sout_sel(dev, cur, next);
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
 
-- 
2.25.1

