Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B606C375EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 04:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhEGCMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 22:12:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59263 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232420AbhEGCMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 22:12:36 -0400
X-UUID: 66ec45a462de4c40beea95eed277a073-20210507
X-UUID: 66ec45a462de4c40beea95eed277a073-20210507
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 425345166; Fri, 07 May 2021 10:11:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 7 May 2021 10:11:29 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 May 2021 10:11:29 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: [PATCH v3 1/4] usb: xhci-mtk: use bitfield instead of bool
Date:   Fri, 7 May 2021 10:11:24 +0800
Message-ID: <20210507021127.54717-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitfield instead of bool in struct

Refer to coding-style.rst 17) Using bool:
"If a structure has many true/false values, consider consolidating
them into a bitfield with 1 bit members, or using an appropriate
fixed width type, such as u8."

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: split @has_ippc out into anather patch suggested by Greg
v2: add more changelog suggested by Greg
---
 drivers/usb/host/xhci-mtk.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index cd3a37bb73e6..94a59b3d178f 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -138,17 +138,17 @@ struct xhci_hcd_mtk {
 	struct mu3h_sch_bw_info *sch_array;
 	struct list_head bw_ep_chk_list;
 	struct mu3c_ippc_regs __iomem *ippc_regs;
-	bool has_ippc;
 	int num_u2_ports;
 	int num_u3_ports;
 	int u3p_dis_msk;
 	struct regulator *vusb33;
 	struct regulator *vbus;
 	struct clk_bulk_data clks[BULK_CLKS_NUM];
-	bool lpm_support;
-	bool u2_lpm_disable;
+	unsigned int has_ippc:1;
+	unsigned int lpm_support:1;
+	unsigned int u2_lpm_disable:1;
 	/* usb remote wakeup */
-	bool uwk_en;
+	unsigned int uwk_en:1;
 	struct regmap *uwk;
 	u32 uwk_reg_base;
 	u32 uwk_vers;
-- 
2.18.0

