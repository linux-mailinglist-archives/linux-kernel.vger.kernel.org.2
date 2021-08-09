Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6653E41ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhHII7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhHII7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:59:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B354C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 01:59:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f3so5004636plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e2YfVJNsD7tSa0DmDvC8fipGN+DYdFYlSD/tL7RdSIE=;
        b=C/SmVNW2ZCRLnOWyxVeL4sBFQNI+egZ7gbiy1I+m0AIzH1nt214EI7M6YK4ZVSu4nL
         F6aMbbIFcbj3ulhQrGkdXcf2KxkndrFa3FMiOFjU67KsHl/6EM2w3FRvMUbh8QgXBhVF
         RNpsaYvHN6vkQzM8nF+7MrkuOUFeIb4zYpdnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e2YfVJNsD7tSa0DmDvC8fipGN+DYdFYlSD/tL7RdSIE=;
        b=Qt/aBBY1STOPJoVPULnvaCt4FMWAN8rfpHe9xQSsL3rx1TquWMRoSat6DqJeBkjPqg
         YAKfQeAdvBI6MI81xjnvHBJiKBXeMNmtF57y49O1gewaRuyjEaeiBG8pQor0APCTA613
         wMCCuB5EVKz5HXDJEE31oVSvRAEuP4/UOf9hBoh05rfA8Bhk3HPb8JFsHWK08uA+TVLg
         11hueCZp8rc+PV0gBpogu4ygCc6HVhnmGdRrxG4et3ScKWBn3cRG6jJne/vtpr9gPuhk
         xE6iH5sltmgSjmZuxs9FDeYG7wy45jgli/AbH08WoneCrhnvPcNwFPc8QOqmzY70sQtg
         M/Gg==
X-Gm-Message-State: AOAM533P6xAVN1dOuQr5DC/qanzUkHZnZeG5qDSc+6OaYLPIN8MGrcN/
        qPfnjzzht08X1v6eKSS1q2E4BA==
X-Google-Smtp-Source: ABdhPJyWLjSHc2jPiGig7zY7HFES8/9xyJkzj+mTO6cEDqBHvYO6PRUQjaEle/2RGiDRrkif0znAqA==
X-Received: by 2002:a65:688f:: with SMTP id e15mr116767pgt.119.1628499574493;
        Mon, 09 Aug 2021 01:59:34 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:2397:5afb:dd55:fa42])
        by smtp.gmail.com with ESMTPSA id z15sm19932179pfn.90.2021.08.09.01.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 01:59:34 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-usb@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [RFC PATCH] usb: xhci-mtk: handle bandwidth table rollover
Date:   Mon,  9 Aug 2021 16:59:29 +0800
Message-Id: <20210809165904.RFC.1.I5165a4a8da5cac23c9928b1ec3c3a1a7383b7c23@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci-mtk has 64 slots for periodic bandwidth calculations and each
slot represents byte budgets on a microframe. When an endpoint's
allocation sits on the boundary of the table, byte budgets' slot
should be rolled over but the current implementation doesn't.

This patch applies a 6 bits mask to the microframe index to handle
its rollover 64 slots and prevent out-of-bounds array access.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

 drivers/usb/host/xhci-mtk-sch.c | 79 +++++++++------------------------
 drivers/usb/host/xhci-mtk.h     |  1 +
 2 files changed, 23 insertions(+), 57 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 46cbf5d54f4f..ef16cd124343 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -411,18 +411,13 @@ static void setup_sch_info(struct xhci_ep_ctx *ep_ctx,
 static u32 get_max_bw(struct mu3h_sch_bw_info *sch_bw,
 	struct mu3h_sch_ep_info *sch_ep, u32 offset)
 {
-	u32 num_esit;
-	u32 max_bw = 0;
-	u32 bw;
-	int i;
-	int j;
-
-	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
-	for (i = 0; i < num_esit; i++) {
-		u32 base = offset + i * sch_ep->esit;
+	u32 bw, max_bw = 0;
+	int i, j, idx;
 
+	for (i = 0; i < XHCI_MTK_MAX_ESIT; i += sch_ep->esit) {
 		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
-			bw = sch_bw->bus_bw[base + j] +
+			idx = XHCI_MTK_BW_IDX(i + offset + j);
+			bw = sch_bw->bus_bw[idx] +
 					sch_ep->bw_budget_table[j];
 			if (bw > max_bw)
 				max_bw = bw;
@@ -434,20 +429,16 @@ static u32 get_max_bw(struct mu3h_sch_bw_info *sch_bw,
 static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
 	struct mu3h_sch_ep_info *sch_ep, bool used)
 {
-	u32 num_esit;
-	u32 base;
-	int i;
-	int j;
+	int i, j, idx;
 
-	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
-	for (i = 0; i < num_esit; i++) {
-		base = sch_ep->offset + i * sch_ep->esit;
+	for (i = 0; i < XHCI_MTK_MAX_ESIT; i += sch_ep->esit) {
 		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
+			idx = XHCI_MTK_BW_IDX(i + sch_ep->offset + j);
 			if (used)
-				sch_bw->bus_bw[base + j] +=
+				sch_bw->bus_bw[idx] +=
 					sch_ep->bw_budget_table[j];
 			else
-				sch_bw->bus_bw[base + j] -=
+				sch_bw->bus_bw[idx] -=
 					sch_ep->bw_budget_table[j];
 		}
 	}
@@ -456,22 +447,18 @@ static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
 static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
 {
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
-	u32 num_esit, tmp;
-	int base;
-	int i, j;
+	u32 bw;
+	int i, j, idx;
 	u8 uframes = DIV_ROUND_UP(sch_ep->maxpkt, FS_PAYLOAD_MAX);
 
-	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
-
 	if (sch_ep->ep_type == INT_IN_EP || sch_ep->ep_type == ISOC_IN_EP)
 		offset++;
 
-	for (i = 0; i < num_esit; i++) {
-		base = offset + i * sch_ep->esit;
-
+	for (i = 0; i < XHCI_MTK_MAX_ESIT; i += sch_ep->esit) {
 		for (j = 0; j < uframes; j++) {
-			tmp = tt->fs_bus_bw[base + j] + sch_ep->bw_cost_per_microframe;
-			if (tmp > FS_PAYLOAD_MAX)
+			idx = XHCI_MTK_BW_IDX(i + offset + j);
+			bw = tt->fs_bus_bw[idx] + sch_ep->bw_cost_per_microframe;
+			if (bw > FS_PAYLOAD_MAX)
 				return -ESCH_BW_OVERFLOW;
 		}
 	}
@@ -544,14 +531,11 @@ static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 {
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
-	u32 base, num_esit;
 	int bw_updated;
-	int i, j;
+	int i, j, idx;
 	int offset = sch_ep->offset;
 	u8 uframes = DIV_ROUND_UP(sch_ep->maxpkt, FS_PAYLOAD_MAX);
 
-	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
-
 	if (used)
 		bw_updated = sch_ep->bw_cost_per_microframe;
 	else
@@ -560,11 +544,11 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 	if (sch_ep->ep_type == INT_IN_EP || sch_ep->ep_type == ISOC_IN_EP)
 		offset++;
 
-	for (i = 0; i < num_esit; i++) {
-		base = offset + i * sch_ep->esit;
-
-		for (j = 0; j < uframes; j++)
-			tt->fs_bus_bw[base + j] += bw_updated;
+	for (i = 0; i < XHCI_MTK_MAX_ESIT; i += sch_ep->esit) {
+		for (j = 0; j < uframes; j++) {
+			idx = XHCI_MTK_BW_IDX(i + offset + j);
+			tt->fs_bus_bw[idx] += bw_updated;
+		}
 	}
 
 	if (used)
@@ -586,25 +570,9 @@ static int load_ep_bw(struct mu3h_sch_bw_info *sch_bw,
 	return 0;
 }
 
-static u32 get_esit_boundary(struct mu3h_sch_ep_info *sch_ep)
-{
-	u32 boundary = sch_ep->esit;
-
-	if (sch_ep->sch_tt) { /* LS/FS with TT */
-		/* tune for CS */
-		if (sch_ep->ep_type != ISOC_OUT_EP)
-			boundary++;
-		else if (boundary > 1) /* normally esit >= 8 for FS/LS */
-			boundary--;
-	}
-
-	return boundary;
-}
-
 static int check_sch_bw(struct mu3h_sch_ep_info *sch_ep)
 {
 	struct mu3h_sch_bw_info *sch_bw = sch_ep->bw_info;
-	const u32 esit_boundary = get_esit_boundary(sch_ep);
 	const u32 bw_boundary = get_bw_boundary(sch_ep->speed);
 	u32 offset;
 	u32 worst_bw;
@@ -621,9 +589,6 @@ static int check_sch_bw(struct mu3h_sch_ep_info *sch_ep)
 		if (ret)
 			continue;
 
-		if ((offset + sch_ep->num_budget_microframes) > esit_boundary)
-			break;
-
 		worst_bw = get_max_bw(sch_bw, sch_ep, offset);
 		if (worst_bw > bw_boundary)
 			continue;
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index ddcf25524f67..f627941c4860 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -23,6 +23,7 @@
  * bandwidth to it.
  */
 #define XHCI_MTK_MAX_ESIT	64
+#define XHCI_MTK_BW_IDX(idx)	((idx) & 63)
 
 /**
  * @fs_bus_bw: array to keep track of bandwidth already used for FS
-- 
2.32.0.605.g8dce9f2422-goog

