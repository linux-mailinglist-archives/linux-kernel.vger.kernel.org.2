Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C8032E42C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhCEJDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:03:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44181 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229711AbhCEJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:03:24 -0500
X-UUID: 5d4811683113423d801f7f83a0b2104f-20210305
X-UUID: 5d4811683113423d801f7f83a0b2104f-20210305
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1793124227; Fri, 05 Mar 2021 17:03:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Mar 2021 17:03:19 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Mar 2021 17:03:18 +0800
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
Subject: [PATCH 07/17] usb: xhci-mtk: add a function to get bandwidth boundary
Date:   Fri, 5 Mar 2021 17:02:45 +0800
Message-ID: <1614934975-15188-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to simplify unit test.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index bef82c1f909d..cb597357f134 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -37,6 +37,25 @@ static int is_fs_or_ls(enum usb_device_speed speed)
 	return speed == USB_SPEED_FULL || speed == USB_SPEED_LOW;
 }
 
+static u32 get_bw_boundary(enum usb_device_speed speed)
+{
+	u32 boundary;
+
+	switch (speed) {
+	case USB_SPEED_SUPER_PLUS:
+		boundary = SSP_BW_BOUNDARY;
+		break;
+	case USB_SPEED_SUPER:
+		boundary = SS_BW_BOUNDARY;
+		break;
+	default:
+		boundary = HS_BW_BOUNDARY;
+		break;
+	}
+
+	return boundary;
+}
+
 /*
 * get the index of bandwidth domains array which @ep belongs to.
 *
@@ -579,13 +598,7 @@ static int check_sch_bw(struct usb_device *udev,
 			break;
 	}
 
-	if (udev->speed == USB_SPEED_SUPER_PLUS)
-		bw_boundary = SSP_BW_BOUNDARY;
-	else if (udev->speed == USB_SPEED_SUPER)
-		bw_boundary = SS_BW_BOUNDARY;
-	else
-		bw_boundary = HS_BW_BOUNDARY;
-
+	bw_boundary = get_bw_boundary(udev->speed);
 	/* check bandwidth */
 	if (min_bw > bw_boundary)
 		return -ERANGE;
-- 
2.18.0

