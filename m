Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8F832E43B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhCEJDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:03:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44259 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229747AbhCEJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:03:29 -0500
X-UUID: 43c83aa59ea5411ea7889b21e73aee26-20210305
X-UUID: 43c83aa59ea5411ea7889b21e73aee26-20210305
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1434150454; Fri, 05 Mar 2021 17:03:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Mar 2021 17:03:24 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Mar 2021 17:03:24 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ikjoon Jang <ikjn@chromium.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 14/17] usb: xhci-mtk: remove declaration of xhci_mtk_setup()
Date:   Fri, 5 Mar 2021 17:02:52 +0800
Message-ID: <1614934975-15188-14-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E394FF94E19BE99EEFB4B02F7C35F7A23C8C9D95F848F399261E29230F48E3CA2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move xhci_driver_overrides struct variable after definition
of xhci_mtk_setup(), then we can remove it's declaration.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index fe010cc61f19..fb4e56f6a6c3 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -344,15 +344,6 @@ static void usb_wakeup_set(struct xhci_hcd_mtk *mtk, bool enable)
 		usb_wakeup_ip_sleep_set(mtk, enable);
 }
 
-static int xhci_mtk_setup(struct usb_hcd *hcd);
-static const struct xhci_driver_overrides xhci_mtk_overrides __initconst = {
-	.reset = xhci_mtk_setup,
-	.check_bandwidth = xhci_mtk_check_bandwidth,
-	.reset_bandwidth = xhci_mtk_reset_bandwidth,
-};
-
-static struct hc_driver __read_mostly xhci_mtk_hc_driver;
-
 static int xhci_mtk_ldos_enable(struct xhci_hcd_mtk *mtk)
 {
 	int ret;
@@ -424,6 +415,14 @@ static int xhci_mtk_setup(struct usb_hcd *hcd)
 	return ret;
 }
 
+static const struct xhci_driver_overrides xhci_mtk_overrides __initconst = {
+	.reset = xhci_mtk_setup,
+	.check_bandwidth = xhci_mtk_check_bandwidth,
+	.reset_bandwidth = xhci_mtk_reset_bandwidth,
+};
+
+static struct hc_driver __read_mostly xhci_mtk_hc_driver;
+
 static int xhci_mtk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-- 
2.18.0

