Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096043EE8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbhHQIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:37:39 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53262 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239087AbhHQIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:37:31 -0400
X-UUID: 906d536dbdfd41dab732019c70efa8a7-20210817
X-UUID: 906d536dbdfd41dab732019c70efa8a7-20210817
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 793689389; Tue, 17 Aug 2021 16:36:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 Aug 2021 16:36:49 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Aug 2021 16:36:49 +0800
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
Subject: [PATCH RESEND 7/9] usb: xhci-mtk: check boundary before check tt
Date:   Tue, 17 Aug 2021 16:36:27 +0800
Message-ID: <1629189389-18779-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1629189389-18779-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1629189389-18779-1-git-send-email-chunfeng.yun@mediatek.com>
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

