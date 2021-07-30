Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80053DB54C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbhG3IvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:51:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36136 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238133AbhG3Iux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:50:53 -0400
X-UUID: b2f110478bec4adbba7b798366eb34e5-20210730
X-UUID: b2f110478bec4adbba7b798366eb34e5-20210730
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1464105308; Fri, 30 Jul 2021 16:50:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Jul 2021 16:50:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Jul 2021 16:50:43 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 09/11] usb: xhci-mtk: check boundary before check tt
Date:   Fri, 30 Jul 2021 16:50:00 +0800
Message-ID: <1627635002-24521-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_sch_tt() will access fs_bus_bw[] array, check boundary
firstly to avoid out-of-bounds issue.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 10c0f0f6461f..c2f13d69c607 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -600,13 +600,14 @@ static int check_sch_bw(struct mu3h_sch_bw_info *sch_bw,
 	 * and find a microframe where its worst bandwidth is minimum.
 	 */
 	for (offset = 0; offset < sch_ep->esit; offset++) {
-		ret = check_sch_tt(sch_ep, offset);
-		if (ret)
-			continue;
 
 		if ((offset + sch_ep->num_budget_microframes) > esit_boundary)
 			break;
 
+		ret = check_sch_tt(sch_ep, offset);
+		if (ret)
+			continue;
+
 		worst_bw = get_max_bw(sch_bw, sch_ep, offset);
 		if (worst_bw > bw_boundary)
 			continue;
-- 
2.18.0

