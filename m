Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8626939F04B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhFHIBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:01:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49528 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231286AbhFHIAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:00:14 -0400
X-UUID: 0ed1e004e9ca4d0e9f524ae7a8f9b04f-20210608
X-UUID: 0ed1e004e9ca4d0e9f524ae7a8f9b04f-20210608
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 404231016; Tue, 08 Jun 2021 15:58:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:58:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:58:16 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yuwen Ng <yuwen.ng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 23/23] usb: mtu3: use clock bulk to get clocks
Date:   Tue, 8 Jun 2021 15:57:49 +0800
Message-ID: <1623139069-8173-24-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clock bulk helpers to get/enable/disable clocks, meanwhile
make sys_ck optional, then will be easier to handle clocks.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h      | 12 ++---
 drivers/usb/mtu3/mtu3_plat.c | 86 ++++++------------------------------
 2 files changed, 18 insertions(+), 80 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index ad063fec7f17..022bbdc54e68 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -10,6 +10,7 @@
 #ifndef __MTU3_H__
 #define __MTU3_H__
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dmapool.h>
 #include <linux/extcon.h>
@@ -89,6 +90,8 @@ struct mtu3_request;
  */
 #define EP0_RESPONSE_BUF  6
 
+#define BULK_CLKS_CNT	4
+
 /* device operated link and speed got from DEVICE_CONF register */
 enum mtu3_speed {
 	MTU3_SPEED_INACTIVE = 0,
@@ -221,10 +224,6 @@ struct otg_switch_mtk {
  * @mac_base: register base address of device MAC, exclude xHCI's
  * @ippc_base: register base address of IP Power and Clock interface (IPPC)
  * @vusb33: usb3.3V shared by device/host IP
- * @sys_clk: system clock of mtu3, shared by device/host IP
- * @ref_clk: reference clock
- * @mcu_clk: mcu_bus_ck clock for AHB bus etc
- * @dma_clk: dma_bus_ck clock for AXI bus etc
  * @dr_mode: works in which mode:
  *		host only, device only or dual-role mode
  * @u2_ports: number of usb2.0 host ports
@@ -250,10 +249,7 @@ struct ssusb_mtk {
 	int wakeup_irq;
 	/* common power & clock */
 	struct regulator *vusb33;
-	struct clk *sys_clk;
-	struct clk *ref_clk;
-	struct clk *mcu_clk;
-	struct clk *dma_clk;
+	struct clk_bulk_data clks[BULK_CLKS_CNT];
 	/* otg */
 	struct otg_switch_mtk otg_switch;
 	enum usb_dr_mode dr_mode;
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 0beae0c8e2d6..57a71af8e151 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -5,7 +5,6 @@
  * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
  */
 
-#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -125,54 +124,6 @@ static void ssusb_phy_power_off(struct ssusb_mtk *ssusb)
 		phy_power_off(ssusb->phys[i]);
 }
 
-static int ssusb_clks_enable(struct ssusb_mtk *ssusb)
-{
-	int ret;
-
-	ret = clk_prepare_enable(ssusb->sys_clk);
-	if (ret) {
-		dev_err(ssusb->dev, "failed to enable sys_clk\n");
-		goto sys_clk_err;
-	}
-
-	ret = clk_prepare_enable(ssusb->ref_clk);
-	if (ret) {
-		dev_err(ssusb->dev, "failed to enable ref_clk\n");
-		goto ref_clk_err;
-	}
-
-	ret = clk_prepare_enable(ssusb->mcu_clk);
-	if (ret) {
-		dev_err(ssusb->dev, "failed to enable mcu_clk\n");
-		goto mcu_clk_err;
-	}
-
-	ret = clk_prepare_enable(ssusb->dma_clk);
-	if (ret) {
-		dev_err(ssusb->dev, "failed to enable dma_clk\n");
-		goto dma_clk_err;
-	}
-
-	return 0;
-
-dma_clk_err:
-	clk_disable_unprepare(ssusb->mcu_clk);
-mcu_clk_err:
-	clk_disable_unprepare(ssusb->ref_clk);
-ref_clk_err:
-	clk_disable_unprepare(ssusb->sys_clk);
-sys_clk_err:
-	return ret;
-}
-
-static void ssusb_clks_disable(struct ssusb_mtk *ssusb)
-{
-	clk_disable_unprepare(ssusb->dma_clk);
-	clk_disable_unprepare(ssusb->mcu_clk);
-	clk_disable_unprepare(ssusb->ref_clk);
-	clk_disable_unprepare(ssusb->sys_clk);
-}
-
 static int ssusb_rscs_init(struct ssusb_mtk *ssusb)
 {
 	int ret = 0;
@@ -183,7 +134,7 @@ static int ssusb_rscs_init(struct ssusb_mtk *ssusb)
 		goto vusb33_err;
 	}
 
-	ret = ssusb_clks_enable(ssusb);
+	ret = clk_bulk_prepare_enable(BULK_CLKS_CNT, ssusb->clks);
 	if (ret)
 		goto clks_err;
 
@@ -204,7 +155,7 @@ static int ssusb_rscs_init(struct ssusb_mtk *ssusb)
 phy_err:
 	ssusb_phy_exit(ssusb);
 phy_init_err:
-	ssusb_clks_disable(ssusb);
+	clk_bulk_disable_unprepare(BULK_CLKS_CNT, ssusb->clks);
 clks_err:
 	regulator_disable(ssusb->vusb33);
 vusb33_err:
@@ -213,7 +164,7 @@ static int ssusb_rscs_init(struct ssusb_mtk *ssusb)
 
 static void ssusb_rscs_exit(struct ssusb_mtk *ssusb)
 {
-	ssusb_clks_disable(ssusb);
+	clk_bulk_disable_unprepare(BULK_CLKS_CNT, ssusb->clks);
 	regulator_disable(ssusb->vusb33);
 	ssusb_phy_power_off(ssusb);
 	ssusb_phy_exit(ssusb);
@@ -239,6 +190,7 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+	struct clk_bulk_data *clks = ssusb->clks;
 	struct device *dev = &pdev->dev;
 	int i;
 	int ret;
@@ -249,23 +201,13 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 		return PTR_ERR(ssusb->vusb33);
 	}
 
-	ssusb->sys_clk = devm_clk_get(dev, "sys_ck");
-	if (IS_ERR(ssusb->sys_clk)) {
-		dev_err(dev, "failed to get sys clock\n");
-		return PTR_ERR(ssusb->sys_clk);
-	}
-
-	ssusb->ref_clk = devm_clk_get_optional(dev, "ref_ck");
-	if (IS_ERR(ssusb->ref_clk))
-		return PTR_ERR(ssusb->ref_clk);
-
-	ssusb->mcu_clk = devm_clk_get_optional(dev, "mcu_ck");
-	if (IS_ERR(ssusb->mcu_clk))
-		return PTR_ERR(ssusb->mcu_clk);
-
-	ssusb->dma_clk = devm_clk_get_optional(dev, "dma_ck");
-	if (IS_ERR(ssusb->dma_clk))
-		return PTR_ERR(ssusb->dma_clk);
+	clks[0].id = "sys_ck";
+	clks[1].id = "ref_ck";
+	clks[2].id = "mcu_ck";
+	clks[3].id = "dma_ck";
+	ret = devm_clk_bulk_get_optional(dev, BULK_CLKS_CNT, clks);
+	if (ret)
+		return ret;
 
 	ssusb->num_phys = of_count_phandle_with_args(node,
 			"phys", "#phy-cells");
@@ -558,7 +500,7 @@ static int mtu3_suspend_common(struct device *dev, pm_message_t msg)
 		goto sleep_err;
 
 	ssusb_phy_power_off(ssusb);
-	ssusb_clks_disable(ssusb);
+	clk_bulk_disable_unprepare(BULK_CLKS_CNT, ssusb->clks);
 	ssusb_wakeup_set(ssusb, true);
 
 sleep_err:
@@ -575,7 +517,7 @@ static int mtu3_resume_common(struct device *dev, pm_message_t msg)
 	dev_dbg(dev, "%s\n", __func__);
 
 	ssusb_wakeup_set(ssusb, false);
-	ret = ssusb_clks_enable(ssusb);
+	ret = clk_bulk_prepare_enable(BULK_CLKS_CNT, ssusb->clks);
 	if (ret)
 		goto clks_err;
 
@@ -586,7 +528,7 @@ static int mtu3_resume_common(struct device *dev, pm_message_t msg)
 	return resume_ip_and_ports(ssusb, msg);
 
 phy_err:
-	ssusb_clks_disable(ssusb);
+	clk_bulk_disable_unprepare(BULK_CLKS_CNT, ssusb->clks);
 clks_err:
 	return ret;
 }
-- 
2.18.0

