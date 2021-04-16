Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7B5361A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhDPGtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:49:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53092 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235140AbhDPGtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:49:07 -0400
X-UUID: db5ba41aa28e4a7994f35392fcd6179c-20210416
X-UUID: db5ba41aa28e4a7994f35392fcd6179c-20210416
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1631980096; Fri, 16 Apr 2021 14:48:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Apr 2021 14:48:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Apr 2021 14:48:31 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [next PATCH] usb: xhci-mtk: remove bus status check
Date:   Fri, 16 Apr 2021 14:48:26 +0800
Message-ID: <1618555706-6810-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2F30F745CAD38CD33E7450348FE77EDF66EBF882B5AE109122F72EB4A79340A42000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM will take care of the status of child device, so no need
check each port anymore.

Suggested-by: Ikjoon Jang <ikjn@chromium.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 43 ++-----------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index d4c455eecb8d..1fdeb315a124 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -654,42 +654,6 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
 	return ret;
 }
 
-static int check_rhub_status(struct xhci_hcd *xhci, struct xhci_hub *rhub)
-{
-	u32 suspended_ports;
-	u32 status;
-	int num_ports;
-	int i;
-
-	num_ports = rhub->num_ports;
-	suspended_ports = rhub->bus_state.suspended_ports;
-	for (i = 0; i < num_ports; i++) {
-		if (!(suspended_ports & BIT(i))) {
-			status = readl(rhub->ports[i]->addr);
-			if (status & PORT_CONNECT)
-				return -EBUSY;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * check the bus whether it could suspend or not
- * the bus will suspend if the downstream ports are already suspended,
- * or no devices connected.
- */
-static int check_bus_status(struct xhci_hcd *xhci)
-{
-	int ret;
-
-	ret = check_rhub_status(xhci, &xhci->usb3_rhub);
-	if (ret)
-		return ret;
-
-	return check_rhub_status(xhci, &xhci->usb2_rhub);
-}
-
 static int __maybe_unused xhci_mtk_runtime_suspend(struct device *dev)
 {
 	struct xhci_hcd_mtk  *mtk = dev_get_drvdata(dev);
@@ -699,11 +663,8 @@ static int __maybe_unused xhci_mtk_runtime_suspend(struct device *dev)
 	if (xhci->xhc_state)
 		return -ESHUTDOWN;
 
-	if (device_may_wakeup(dev)) {
-		ret = check_bus_status(xhci);
-		if (!ret)
-			ret = xhci_mtk_suspend(dev);
-	}
+	if (device_may_wakeup(dev))
+		ret = xhci_mtk_suspend(dev);
 
 	/* -EBUSY: let PM automatically reschedule another autosuspend */
 	return ret ? -EBUSY : 0;
-- 
2.18.0

