Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1134FB83
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhCaI0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:26:22 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:8416 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232406AbhCaIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:25:52 -0400
X-UUID: d7c51d1593e244d6964a671c36a08903-20210331
X-UUID: d7c51d1593e244d6964a671c36a08903-20210331
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1993034478; Wed, 31 Mar 2021 16:25:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 31 Mar 2021 16:25:46 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 31 Mar 2021 16:25:45 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH next 2/2] usb: xhci-mtk: fix oops when unbind driver
Date:   Wed, 31 Mar 2021 16:25:42 +0800
Message-ID: <1617179142-2681-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1617179142-2681-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1617179142-2681-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 614E4DE8A8471C2F373F0B87E228EECE78C7633A0599EF5262D0A24C1DDFC49F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The oops happens when unbind driver through sysfs as following,
because xhci_mtk_drop_ep() try to drop the endpoint of root hub
which is not added by xhci_add_endpoint() and the virtual device
is not allocated, in fact also needn't drop it, so should skip it.

Call trace:
 xhci_mtk_drop_ep+0x1b8/0x298
 usb_hcd_alloc_bandwidth+0x1d8/0x380
 usb_disable_device_endpoints+0x8c/0xe0
 usb_disable_device+0x128/0x168
 usb_disconnect+0xbc/0x2c8
 usb_remove_hcd+0xd8/0x210
 xhci_mtk_remove+0x98/0x108
 platform_remove+0x28/0x60
 device_release_driver_internal+0x110/0x1e8
 device_driver_detach+0x18/0x28
 unbind_store+0xd4/0x108
 drv_attr_store+0x24/0x38

Fixes: 14295a150050 ("usb: xhci-mtk: support to build xhci-mtk-hcd.ko")
Reported-by: Eddie Hung <eddie.hung@mediatek.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 7ac76ae28998..8b90da5a6ed1 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -872,6 +872,8 @@ int xhci_mtk_drop_ep(struct usb_hcd *hcd, struct usb_device *udev,
 	if (ret)
 		return ret;
 
-	drop_ep_quirk(hcd, udev, ep);
+	if (ep->hcpriv)
+		drop_ep_quirk(hcd, udev, ep);
+
 	return 0;
 }
-- 
2.18.0

