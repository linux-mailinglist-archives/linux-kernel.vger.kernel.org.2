Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35657345847
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhCWHEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:04:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52807 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230081AbhCWHDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:03:41 -0400
X-UUID: 5915a65f03f1420ba25d8def557bfab2-20210323
X-UUID: 5915a65f03f1420ba25d8def557bfab2-20210323
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2122046747; Tue, 23 Mar 2021 15:03:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Mar 2021 15:03:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 15:03:14 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2 08/13] usb: xhci-mtk: drop CONFIG_OF
Date:   Tue, 23 Mar 2021 15:02:50 +0800
Message-ID: <1616482975-17841-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only the devices created by the OF core
via the DT table, so the table should be always used.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/host/xhci-mtk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 24342112cd1d..832c5b8bb8a8 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -689,14 +689,12 @@ static const struct dev_pm_ops xhci_mtk_pm_ops = {
 };
 #define DEV_PM_OPS IS_ENABLED(CONFIG_PM) ? &xhci_mtk_pm_ops : NULL
 
-#ifdef CONFIG_OF
 static const struct of_device_id mtk_xhci_of_match[] = {
 	{ .compatible = "mediatek,mt8173-xhci"},
 	{ .compatible = "mediatek,mtk-xhci"},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_xhci_of_match);
-#endif
 
 static struct platform_driver mtk_xhci_driver = {
 	.probe	= xhci_mtk_probe,
@@ -704,7 +702,7 @@ static struct platform_driver mtk_xhci_driver = {
 	.driver	= {
 		.name = "xhci-mtk",
 		.pm = DEV_PM_OPS,
-		.of_match_table = of_match_ptr(mtk_xhci_of_match),
+		.of_match_table = mtk_xhci_of_match,
 	},
 };
 MODULE_ALIAS("platform:xhci-mtk");
-- 
2.18.0

