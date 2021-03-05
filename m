Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CC032E434
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhCEJDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:03:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44144 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229718AbhCEJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:03:24 -0500
X-UUID: 51c3d46dc1bb46ddb1f7f643ceaf82d1-20210305
X-UUID: 51c3d46dc1bb46ddb1f7f643ceaf82d1-20210305
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1792679114; Fri, 05 Mar 2021 17:03:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Mar 2021 17:03:16 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Mar 2021 17:03:15 +0800
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
Subject: [PATCH 03/17] usb: xhci-mtk: get the microframe boundary for ESIT
Date:   Fri, 5 Mar 2021 17:02:41 +0800
Message-ID: <1614934975-15188-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F037F6C908867B89B8E91ED5FD7323317E49810CA8B051728F0C5F89284DE6532000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tune the boundary for FS/LS ESIT due to CS:
For ISOC out-ep, the controller starts transfer data after
the first SS; for others, the data is already transfered
before the last CS.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 8950d1f10a7f..e3b18dfca874 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -513,22 +513,35 @@ static void update_sch_tt(struct usb_device *udev,
 		list_del(&sch_ep->tt_endpoint);
 }
 
+static u32 get_esit_boundary(struct mu3h_sch_ep_info *sch_ep)
+{
+	u32 boundary = sch_ep->esit;
+
+	if (sch_ep->sch_tt) { /* LS/FS with TT */
+		/* tune for CS */
+		if (sch_ep->ep_type != ISOC_OUT_EP)
+			boundary += 1;
+		else if (boundary > 1) /* normally esit >= 8 for FS/LS */
+			boundary -= 1;
+	}
+
+	return boundary;
+}
+
 static int check_sch_bw(struct usb_device *udev,
 	struct mu3h_sch_bw_info *sch_bw, struct mu3h_sch_ep_info *sch_ep)
 {
 	u32 offset;
-	u32 esit;
 	u32 min_bw;
 	u32 min_index;
 	u32 worst_bw;
 	u32 bw_boundary;
+	u32 esit_boundary;
 	u32 min_num_budget;
 	u32 min_cs_count;
 	bool tt_offset_ok = false;
 	int ret;
 
-	esit = sch_ep->esit;
-
 	/*
 	 * Search through all possible schedule microframes.
 	 * and find a microframe where its worst bandwidth is minimum.
@@ -537,7 +550,8 @@ static int check_sch_bw(struct usb_device *udev,
 	min_index = 0;
 	min_cs_count = sch_ep->cs_count;
 	min_num_budget = sch_ep->num_budget_microframes;
-	for (offset = 0; offset < esit; offset++) {
+	esit_boundary = get_esit_boundary(sch_ep);
+	for (offset = 0; offset < sch_ep->esit; offset++) {
 		if (is_fs_or_ls(udev->speed)) {
 			ret = check_sch_tt(udev, sch_ep, offset);
 			if (ret)
@@ -546,7 +560,7 @@ static int check_sch_bw(struct usb_device *udev,
 				tt_offset_ok = true;
 		}
 
-		if ((offset + sch_ep->num_budget_microframes) > sch_ep->esit)
+		if ((offset + sch_ep->num_budget_microframes) > esit_boundary)
 			break;
 
 		worst_bw = get_max_bw(sch_bw, sch_ep, offset);
-- 
2.18.0

