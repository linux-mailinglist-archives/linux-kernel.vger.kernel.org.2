Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE7345841
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCWHD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:03:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52761 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230062AbhCWHDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:03:38 -0400
X-UUID: 3273c2e502344ae8a90d2c9c366cdc60-20210323
X-UUID: 3273c2e502344ae8a90d2c9c366cdc60-20210323
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1262951997; Tue, 23 Mar 2021 15:03:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Mar 2021 15:03:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 15:03:17 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>
Subject: [PATCH v2 11/13] usb: mtu3: add support ip-sleep wakeup for MT8192
Date:   Tue, 23 Mar 2021 15:02:53 +0800
Message-ID: <1616482975-17841-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 02F9C87FB8E8A7A7065AB363ECCD9788151B206C18A17FA37E66208E14F3C6CD2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add add support ip-sleep wakeup for MT8192, it's a specific
revision, not following IPM rule.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2:
   1. fix typo suggested by Sergei
   2. modify revision format
---
 drivers/usb/mtu3/mtu3_host.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index 398ce0014606..e3c923e6529f 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -30,6 +30,10 @@
 #define WC0_IS_P	BIT(12)	/* polarity */
 #define WC0_IS_EN	BIT(6)
 
+/* mt8192 */
+#define WC0_SSUSB0_CDEN		BIT(6)
+#define WC0_IS_SPM_EN		BIT(1)
+
 /* mt2712 etc */
 #define PERI_SSUSB_SPM_CTRL	0x0
 #define SSC_IP_SLEEP_EN	BIT(4)
@@ -39,6 +43,7 @@ enum ssusb_uwk_vers {
 	SSUSB_UWK_V1 = 1,
 	SSUSB_UWK_V2,
 	SSUSB_UWK_V1_1 = 101,	/* specific revision 1.01 */
+	SSUSB_UWK_V1_2,		/* specific revision 1.02 */
 };
 
 /*
@@ -60,6 +65,11 @@ static void ssusb_wakeup_ip_sleep_set(struct ssusb_mtk *ssusb, bool enable)
 		msk = WC0_IS_EN | WC0_IS_C(0xf) | WC0_IS_P;
 		val = enable ? (WC0_IS_EN | WC0_IS_C(0x8)) : 0;
 		break;
+	case SSUSB_UWK_V1_2:
+		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0;
+		msk = WC0_SSUSB0_CDEN | WC0_IS_SPM_EN;
+		val = enable ? msk : 0;
+		break;
 	case SSUSB_UWK_V2:
 		reg = ssusb->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
 		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;
-- 
2.18.0

