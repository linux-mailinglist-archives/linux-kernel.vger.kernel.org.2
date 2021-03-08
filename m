Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E09330614
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhCHCwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:52:42 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36452 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232404AbhCHCwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:23 -0500
X-UUID: 4ac23502d85d48d78916b05f8e599adc-20210308
X-UUID: 4ac23502d85d48d78916b05f8e599adc-20210308
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1844842506; Mon, 08 Mar 2021 10:52:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:52:19 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:52:19 +0800
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
        Eddie Hung <eddie.hung@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2 07/18] usb: xhci-mtk: add a function to get bandwidth boundary
Date:   Mon, 8 Mar 2021 10:51:56 +0800
Message-ID: <805b3ba66c2f02a52de4440212519aaa58463039.1615170625.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AE290569BFD45F8BDE4A38EAFC32C1306295AB11A61D5806DDCC1B48B578842C2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to simplify unit test.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/host/xhci-mtk-sch.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 9a9685f74940..8fe4481eb43d 100644
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

