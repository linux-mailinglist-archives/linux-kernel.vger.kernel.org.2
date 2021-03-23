Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7361345846
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhCWHEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:04:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52778 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230085AbhCWHDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:03:42 -0400
X-UUID: 01e84b5eadc24a42a9974ac69b4e7da1-20210323
X-UUID: 01e84b5eadc24a42a9974ac69b4e7da1-20210323
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1710061512; Tue, 23 Mar 2021 15:03:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Mar 2021 15:03:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 15:03:16 +0800
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
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2 10/13] usb: mtu3: support ip-sleep wakeup for MT8183
Date:   Tue, 23 Mar 2021 15:02:52 +0800
Message-ID: <1616482975-17841-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support ip-sleep wakeup for MT8183, it's similar to MT8173,
and it's also a specific one, but not following IPM rule.
Due to the index 2 already used by many DTS, it's better to keep
it unchanged for backward compatibility, treat specific ones without
following IPM rule as revision 1.x, meanwhile reserve 3~10 for later
revision that follows the IPM rule.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2:
   1. fix typo suggested by Sergei
   2. fix build warning - Woverflow
   3. modify revision format
---
 drivers/usb/mtu3/mtu3_host.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index c871b94f3e6f..398ce0014606 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -24,6 +24,12 @@
 #define WC1_IS_EN	BIT(25)
 #define WC1_IS_P	BIT(6)  /* polarity for ip sleep */
 
+/* mt8183 */
+#define PERI_WK_CTRL0	0x0
+#define WC0_IS_C(x)	((u32)(((x) & 0xf) << 28))  /* cycle debounce */
+#define WC0_IS_P	BIT(12)	/* polarity */
+#define WC0_IS_EN	BIT(6)
+
 /* mt2712 etc */
 #define PERI_SSUSB_SPM_CTRL	0x0
 #define SSC_IP_SLEEP_EN	BIT(4)
@@ -32,6 +38,7 @@
 enum ssusb_uwk_vers {
 	SSUSB_UWK_V1 = 1,
 	SSUSB_UWK_V2,
+	SSUSB_UWK_V1_1 = 101,	/* specific revision 1.01 */
 };
 
 /*
@@ -48,6 +55,11 @@ static void ssusb_wakeup_ip_sleep_set(struct ssusb_mtk *ssusb, bool enable)
 		msk = WC1_IS_EN | WC1_IS_C(0xf) | WC1_IS_P;
 		val = enable ? (WC1_IS_EN | WC1_IS_C(0x8)) : 0;
 		break;
+	case SSUSB_UWK_V1_1:
+		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0;
+		msk = WC0_IS_EN | WC0_IS_C(0xf) | WC0_IS_P;
+		val = enable ? (WC0_IS_EN | WC0_IS_C(0x8)) : 0;
+		break;
 	case SSUSB_UWK_V2:
 		reg = ssusb->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
 		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;
-- 
2.18.0

