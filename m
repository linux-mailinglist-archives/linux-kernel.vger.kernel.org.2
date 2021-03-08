Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C257C330608
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhCHCwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:52:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39637 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232395AbhCHCwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:21 -0500
X-UUID: dbc67f445fc24874857ee50e509f2ee5-20210308
X-UUID: dbc67f445fc24874857ee50e509f2ee5-20210308
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 888902602; Mon, 08 Mar 2021 10:52:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:52:16 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:52:15 +0800
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
Subject: [PATCH v2 03/18] usb: xhci-mtk: get the microframe boundary for ESIT
Date:   Mon, 8 Mar 2021 10:51:52 +0800
Message-ID: <49e5a269a47984f3126a70c3fb471b0c2874b8c2.1615170625.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B445CB8B7D900E16797BA90FD85FE6E626EC92059A1501F880C6C6B58FCEE0C82000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tune the boundary for FS/LS ESIT due to CS:
For ISOC out-ep, the controller starts transfer data after
the first SS; for others, the data is already transferred
before the last CS.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: fix typo and use ++/-- suggested by Sergei
---
 drivers/usb/host/xhci-mtk-sch.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 8950d1f10a7f..450fa22b7dc7 100644
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
+			boundary++;
+		else if (boundary > 1) /* normally esit >= 8 for FS/LS */
+			boundary--;
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

