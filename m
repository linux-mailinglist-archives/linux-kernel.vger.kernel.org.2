Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED97375EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 04:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhEGCMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 22:12:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40264 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233728AbhEGCMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 22:12:34 -0400
X-UUID: 6a980f108d9b4e22b1ca27b4896adfda-20210507
X-UUID: 6a980f108d9b4e22b1ca27b4896adfda-20210507
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2097861120; Fri, 07 May 2021 10:11:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v3 2/4] usb: xhci-mtk: remove unnecessary setting of has_ippc
Date:   Fri, 7 May 2021 10:11:25 +0800
Message-ID: <20210507021127.54717-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210507021127.54717-1-chunfeng.yun@mediatek.com>
References: <20210507021127.54717-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EDB69650B5819A47EFB3C763348CDA24389B7BFCA6749B257CB08F83C37B88772000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to @has_ippc's default value is 0, no need set it again if fail
to get ippc base address

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: new patch suggested by Greg
    fix typo suggested by Sergei
---
 drivers/usb/host/xhci-mtk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index b2058b3bc834..2548976bcf05 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -495,8 +495,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 			goto put_usb2_hcd;
 		}
 		mtk->has_ippc = true;
-	} else {
-		mtk->has_ippc = false;
 	}
 
 	device_init_wakeup(dev, true);
-- 
2.18.0

