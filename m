Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DD732E43C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCEJDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:03:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44286 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229750AbhCEJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:03:30 -0500
X-UUID: 2e20b66eb714407682c3ce61bdd49e40-20210305
X-UUID: 2e20b66eb714407682c3ce61bdd49e40-20210305
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 196624933; Fri, 05 Mar 2021 17:03:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Mar 2021 17:03:24 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Mar 2021 17:03:23 +0800
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
Subject: [PATCH 13/17] usb: xhci-mtk: add some schedule error number
Date:   Fri, 5 Mar 2021 17:02:51 +0800
Message-ID: <1614934975-15188-13-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0D830F8F09A60B82A58BC7E99A37A9D0A888F6BAFB3ED3632F38FC2BE88F6B312000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to provide more information about which case
causes bandwidth schedule failure.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 44 ++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index d39545ade9a1..deb918490b71 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -25,6 +25,13 @@
  */
 #define TT_MICROFRAMES_MAX 9
 
+/* schedule error type */
+#define ESCH_SS_Y6		1001
+#define ESCH_SS_OVERLAP		1002
+#define ESCH_CS_OVERFLOW	1003
+#define ESCH_BW_OVERFLOW	1004
+#define ESCH_FIXME		1005
+
 /* mtk scheduler bitmasks */
 #define EP_BPKTS(p)	((p) & 0x7f)
 #define EP_BCSCOUNT(p)	(((p) & 0x7) << 8)
@@ -32,6 +39,24 @@
 #define EP_BOFFSET(p)	((p) & 0x3fff)
 #define EP_BREPEAT(p)	(((p) & 0x7fff) << 16)
 
+static char *sch_error_string(int err_num)
+{
+	switch (err_num) {
+	case ESCH_SS_Y6:
+		return "Can't schedule Start-Split in Y6";
+	case ESCH_SS_OVERLAP:
+		return "Can't find a suitable Start-Split location";
+	case ESCH_CS_OVERFLOW:
+		return "The last Complete-Split is greater than 7";
+	case ESCH_BW_OVERFLOW:
+		return "Bandwidth exceeds the maximum limit";
+	case ESCH_FIXME:
+		return "FIXME, to be resolved";
+	default:
+		return "Unknown";
+	}
+}
+
 static int is_fs_or_ls(enum usb_device_speed speed)
 {
 	return speed == USB_SPEED_FULL || speed == USB_SPEED_LOW;
@@ -412,7 +437,7 @@ static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
 		for (j = 0; j < sch_ep->cs_count; j++) {
 			tmp = tt->fs_bus_bw[base + j] + sch_ep->bw_cost_per_microframe;
 			if (tmp > FS_PAYLOAD_MAX)
-				return -ERANGE;
+				return -ESCH_BW_OVERFLOW;
 		}
 	}
 
@@ -437,11 +462,11 @@ static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 		 * must never schedule Start-Split in Y6
 		 */
 		if (!(start_ss == 7 || last_ss < 6))
-			return -ERANGE;
+			return -ESCH_SS_Y6;
 
 		for (i = 0; i < sch_ep->cs_count; i++)
 			if (test_bit(offset + i, tt->ss_bit_map))
-				return -ERANGE;
+				return -ESCH_SS_OVERLAP;
 
 	} else {
 		u32 cs_count = DIV_ROUND_UP(sch_ep->maxpkt, FS_PAYLOAD_MAX);
@@ -451,14 +476,14 @@ static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 		 * must never schedule Start-Split in Y6
 		 */
 		if (start_ss == 6)
-			return -ERANGE;
+			return -ESCH_SS_Y6;
 
 		/* one uframe for ss + one uframe for idle */
 		start_cs = (start_ss + 2) % 8;
 		last_cs = start_cs + cs_count - 1;
 
 		if (last_cs > 7)
-			return -ERANGE;
+			return -ESCH_CS_OVERFLOW;
 
 		if (sch_ep->ep_type == ISOC_IN_EP)
 			extra_cs_count = (last_cs == 7) ? 1 : 2;
@@ -470,7 +495,7 @@ static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 			cs_count = 7; /* HW limit */
 
 		if (test_bit(offset, tt->ss_bit_map))
-			return -ERANGE;
+			return -ESCH_SS_OVERLAP;
 
 		sch_ep->cs_count = cs_count;
 		/* one for ss, the other for idle */
@@ -562,7 +587,7 @@ static int check_sch_bw(struct mu3h_sch_bw_info *sch_bw,
 	u32 esit_boundary;
 	u32 min_num_budget;
 	u32 min_cs_count;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Search through all possible schedule microframes.
@@ -597,7 +622,7 @@ static int check_sch_bw(struct mu3h_sch_bw_info *sch_bw,
 	bw_boundary = get_bw_boundary(sch_ep->speed);
 	/* check bandwidth */
 	if (min_bw > bw_boundary)
-		return -ERANGE;
+		return ret ? ret : -ESCH_BW_OVERFLOW;
 
 	sch_ep->offset = min_index;
 	sch_ep->cs_count = min_cs_count;
@@ -765,7 +790,8 @@ int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 
 		ret = check_sch_bw(sch_bw, sch_ep);
 		if (ret) {
-			xhci_err(xhci, "Not enough bandwidth!\n");
+			xhci_err(xhci, "Not enough bandwidth! (%s)\n",
+				 sch_error_string(-ret));
 			return -ENOSPC;
 		}
 	}
-- 
2.18.0

