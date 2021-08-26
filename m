Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53893F80B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 04:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbhHZCxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 22:53:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33614 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238044AbhHZCxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 22:53:16 -0400
X-UUID: 71d7077333214b0397bed79c36547107-20210826
X-UUID: 71d7077333214b0397bed79c36547107-20210826
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1557332125; Thu, 26 Aug 2021 10:52:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 Aug 2021 10:52:00 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 26 Aug 2021 10:52:00 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Yaqii wu <yaqii.wu@mediatek.com>
Subject: [PATCH next v2 4/6] usb: xhci-mtk: add a member of num_esit
Date:   Thu, 26 Aug 2021 10:51:42 +0800
Message-ID: <20210826025144.51992-4-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
References: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a member num_esit to save the number of esit, then no need
caculate it in some functions.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: new patch, move from another series
---
 drivers/usb/host/xhci-mtk-sch.c | 20 +++++++-------------
 drivers/usb/host/xhci-mtk.h     |  2 ++
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 83abd28269ca..54c521524bfc 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -297,6 +297,7 @@ static void setup_sch_info(struct xhci_ep_ctx *ep_ctx,
 		 CTX_TO_MAX_ESIT_PAYLOAD(le32_to_cpu(ep_ctx->tx_info));
 
 	sch_ep->esit = get_esit(ep_ctx);
+	sch_ep->num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
 	sch_ep->ep_type = ep_type;
 	sch_ep->maxpkt = maxpkt;
 	sch_ep->offset = 0;
@@ -401,14 +402,12 @@ static void setup_sch_info(struct xhci_ep_ctx *ep_ctx,
 static u32 get_max_bw(struct mu3h_sch_bw_info *sch_bw,
 	struct mu3h_sch_ep_info *sch_ep, u32 offset)
 {
-	u32 num_esit;
 	u32 max_bw = 0;
 	u32 bw;
 	int i;
 	int j;
 
-	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
-	for (i = 0; i < num_esit; i++) {
+	for (i = 0; i < sch_ep->num_esit; i++) {
 		u32 base = offset + i * sch_ep->esit;
 
 		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
@@ -424,13 +423,11 @@ static u32 get_max_bw(struct mu3h_sch_bw_info *sch_bw,
 static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
 	struct mu3h_sch_ep_info *sch_ep, bool used)
 {
-	u32 num_esit;
 	u32 base;
 	int i;
 	int j;
 
-	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
-	for (i = 0; i < num_esit; i++) {
+	for (i = 0; i < sch_ep->num_esit; i++) {
 		base = sch_ep->offset + i * sch_ep->esit;
 		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
 			if (used)
@@ -446,12 +443,11 @@ static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
 static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
 {
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
-	u32 num_esit, tmp;
+	u32 tmp;
 	int base;
 	int i, j;
 
-	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
-	for (i = 0; i < num_esit; i++) {
+	for (i = 0; i < sch_ep->num_esit; i++) {
 		base = offset + i * sch_ep->esit;
 
 		/*
@@ -533,12 +529,10 @@ static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 {
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
-	u32 base, num_esit;
+	u32 base;
 	int i, j;
 
-	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
-
-	for (i = 0; i < num_esit; i++) {
+	for (i = 0; i < sch_ep->num_esit; i++) {
 		base = sch_ep->offset + i * sch_ep->esit;
 
 		for (j = 0; j < sch_ep->num_budget_microframes; j++)
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index ace432356c41..eb05aaf6edbe 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -50,6 +50,7 @@ struct mu3h_sch_bw_info {
  * struct mu3h_sch_ep_info: schedule information for endpoint
  *
  * @esit: unit is 125us, equal to 2 << Interval field in ep-context
+ * @num_esit: number of @esit in a period
  * @num_budget_microframes: number of continuous uframes
  *		(@repeat==1) scheduled within the interval
  * @bw_cost_per_microframe: bandwidth cost per microframe
@@ -79,6 +80,7 @@ struct mu3h_sch_bw_info {
  */
 struct mu3h_sch_ep_info {
 	u32 esit;
+	u32 num_esit;
 	u32 num_budget_microframes;
 	u32 bw_cost_per_microframe;
 	struct list_head endpoint;
-- 
2.18.0

