Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391F4330612
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhCHCwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:52:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36471 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232398AbhCHCwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:22 -0500
X-UUID: eca5401253544e3ab7146f80fadb5836-20210308
X-UUID: eca5401253544e3ab7146f80fadb5836-20210308
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1550231701; Mon, 08 Mar 2021 10:52:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:52:17 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:52:16 +0800
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
Subject: [PATCH v2 04/18] usb: xhci-mtk: add only one extra CS for FS/LS INTR
Date:   Mon, 8 Mar 2021 10:51:53 +0800
Message-ID: <5b9ff09f53d23cf9e5c5437db4ffc18b798bf60c.1615170625.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
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
v2: no changes
---
 drivers/usb/host/xhci-mtk-sch.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 450fa22b7dc7..59ba25ca018d 100644
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

