Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56114425BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 03:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhKBCwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 22:52:47 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:57876 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229526AbhKBCwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 22:52:46 -0400
X-UUID: cccddc9b5ee0443caa6187e8b3e11119-20211102
X-UUID: cccddc9b5ee0443caa6187e8b3e11119-20211102
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1182935511; Tue, 02 Nov 2021 10:50:08 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 2 Nov 2021 10:50:07 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Nov
 2021 10:50:06 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Nov 2021 10:50:06 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] usb: xhci-mtk: fix random remote wakeup
Date:   Tue, 2 Nov 2021 10:50:04 +0800
Message-ID: <20211102025004.29156-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211102025004.29156-1-chunfeng.yun@mediatek.com>
References: <20211102025004.29156-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms, e.g. 8183/8192, use low level latch way to keep
wakeup signal, it may latch a wrong signal if debounce more time,
and enable wakeup function earlier.
                   ____________________
ip_sleep      ____/                    \_____________
                           ___________________
wakeup_signal ____________/                   \______
                      _______________________________
wakeup_en     _______/
                      ^     ^
                      |(1)  |(2)
latch wakeup_signal mistakenly at (1), should latch it at (2);

Workaround: delay about 100us to enable wakeup, meanwhile decrease
debounce time.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index adc5debcde88..91a664e8810d 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -245,11 +245,12 @@ static int xhci_mtk_host_disable(struct xhci_hcd_mtk *mtk)
 	/* wait for host ip to sleep */
 	ret = readl_poll_timeout(&ippc->ip_pw_sts1, value,
 			  (value & STS1_IP_SLEEP_STS), 100, 100000);
-	if (ret) {
+	if (ret)
 		dev_err(mtk->dev, "ip sleep failed!!!\n");
-		return ret;
-	}
-	return 0;
+	else /* workaound for platforms using low level latch */
+		usleep_range(100, 200);
+
+	return ret;
 }
 
 static int xhci_mtk_ssusb_config(struct xhci_hcd_mtk *mtk)
@@ -300,7 +301,7 @@ static void usb_wakeup_ip_sleep_set(struct xhci_hcd_mtk *mtk, bool enable)
 	case SSUSB_UWK_V1_1:
 		reg = mtk->uwk_reg_base + PERI_WK_CTRL0;
 		msk = WC0_IS_EN | WC0_IS_C(0xf) | WC0_IS_P;
-		val = enable ? (WC0_IS_EN | WC0_IS_C(0x8)) : 0;
+		val = enable ? (WC0_IS_EN | WC0_IS_C(0x1)) : 0;
 		break;
 	case SSUSB_UWK_V1_2:
 		reg = mtk->uwk_reg_base + PERI_WK_CTRL0;
-- 
2.18.0

