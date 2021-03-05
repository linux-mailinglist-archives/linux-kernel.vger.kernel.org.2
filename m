Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F91A32E438
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhCEJDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:03:44 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44181 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229729AbhCEJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:03:26 -0500
X-UUID: 52689e98675247a584cc3c2aa42fdaff-20210305
X-UUID: 52689e98675247a584cc3c2aa42fdaff-20210305
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1997415776; Fri, 05 Mar 2021 17:03:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Mar 2021 17:03:20 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Mar 2021 17:03:19 +0800
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
Subject: [PATCH 08/17] usb: xhci-mtk: remove unnecessary members of mu3h_sch_tt struct
Date:   Fri, 5 Mar 2021 17:02:46 +0800
Message-ID: <1614934975-15188-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8D3399C5504CE205CBB46020280DB6C89625C7887814FA2A5F39063DFFC6EC392000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The members @usb_tt and @tt_port in mu3h_sch_tt struct
are not used after initialization, so can be removed

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 7 +------
 drivers/usb/host/xhci-mtk.h     | 4 ----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index cb597357f134..1e8af5973a5e 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -104,7 +104,6 @@ static struct mu3h_sch_tt *find_tt(struct usb_device *udev)
 {
 	struct usb_tt *utt = udev->tt;
 	struct mu3h_sch_tt *tt, **tt_index, **ptt;
-	unsigned int port;
 	bool allocated_index = false;
 
 	if (!utt)
@@ -126,10 +125,8 @@ static struct mu3h_sch_tt *find_tt(struct usb_device *udev)
 			utt->hcpriv = tt_index;
 			allocated_index = true;
 		}
-		port = udev->ttport - 1;
-		ptt = &tt_index[port];
+		ptt = &tt_index[udev->ttport - 1];
 	} else {
-		port = 0;
 		ptt = (struct mu3h_sch_tt **) &utt->hcpriv;
 	}
 
@@ -144,8 +141,6 @@ static struct mu3h_sch_tt *find_tt(struct usb_device *udev)
 			return ERR_PTR(-ENOMEM);
 		}
 		INIT_LIST_HEAD(&tt->ep_list);
-		tt->usb_tt = utt;
-		tt->tt_port = port;
 		*ptt = tt;
 	}
 
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index f42769c69249..f61e53b02706 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -23,15 +23,11 @@
  * @ss_bit_map: used to avoid start split microframes overlay
  * @fs_bus_bw: array to keep track of bandwidth already used for FS
  * @ep_list: Endpoints using this TT
- * @usb_tt: usb TT related
- * @tt_port: TT port number
  */
 struct mu3h_sch_tt {
 	DECLARE_BITMAP(ss_bit_map, XHCI_MTK_MAX_ESIT);
 	u32 fs_bus_bw[XHCI_MTK_MAX_ESIT];
 	struct list_head ep_list;
-	struct usb_tt *usb_tt;
-	int tt_port;
 };
 
 /**
-- 
2.18.0

