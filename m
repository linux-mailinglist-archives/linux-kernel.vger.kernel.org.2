Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94432E42F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhCEJDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:03:37 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59067 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229716AbhCEJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:03:24 -0500
X-UUID: 17ce6c68fb2b4bbcb050cd1b10e9d665-20210305
X-UUID: 17ce6c68fb2b4bbcb050cd1b10e9d665-20210305
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 996313782; Fri, 05 Mar 2021 17:03:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Mar 2021 17:03:17 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Mar 2021 17:03:16 +0800
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
Subject: [PATCH 04/17] usb: xhci-mtk: add only one extra CS for FS/LS INTR
Date:   Fri, 5 Mar 2021 17:02:42 +0800
Message-ID: <1614934975-15188-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In USB2 Spec:
"11.18.5 TT Response Generation
In general, there will be two (or more) complete-split
transactions scheduled for a periodic endpoint.
However, for interrupt endpoints, the maximum size of
the full-/low-speed transaction guarantees that it can
never require more than two complete-split transactions.
Two complete-split transactions are only required
when the transaction spans a microframe boundary."

Due to the maxp is 64, and less then 188 (at most in one
microframe), seems never span boundary, so use only one CS
for FS/LS interrupt transfer, this will save some bandwidth.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index e3b18dfca874..817ef2815e67 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -408,13 +408,11 @@ static int check_sch_tt(struct usb_device *udev,
 {
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 extra_cs_count;
-	u32 fs_budget_start;
 	u32 start_ss, last_ss;
 	u32 start_cs, last_cs;
 	int i;
 
 	start_ss = offset % 8;
-	fs_budget_start = (start_ss + 1) % 8;
 
 	if (sch_ep->ep_type == ISOC_OUT_EP) {
 		last_ss = start_ss + sch_ep->cs_count - 1;
@@ -450,16 +448,14 @@ static int check_sch_tt(struct usb_device *udev,
 		if (sch_ep->ep_type == ISOC_IN_EP)
 			extra_cs_count = (last_cs == 7) ? 1 : 2;
 		else /*  ep_type : INTR IN / INTR OUT */
-			extra_cs_count = (fs_budget_start == 6) ? 1 : 2;
+			extra_cs_count = 1;
 
 		cs_count += extra_cs_count;
 		if (cs_count > 7)
 			cs_count = 7; /* HW limit */
 
-		for (i = 0; i < cs_count + 2; i++) {
-			if (test_bit(offset + i, tt->ss_bit_map))
-				return -ERANGE;
-		}
+		if (test_bit(offset, tt->ss_bit_map))
+			return -ERANGE;
 
 		sch_ep->cs_count = cs_count;
 		/* one for ss, the other for idle */
-- 
2.18.0

