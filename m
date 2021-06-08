Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387B239F031
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhFHIAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:00:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53395 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230468AbhFHIAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:00:01 -0400
X-UUID: 1a6c6aec8d56468b925f5e9622be2249-20210608
X-UUID: 1a6c6aec8d56468b925f5e9622be2249-20210608
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 933752272; Tue, 08 Jun 2021 15:58:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Jun 2021 15:58:02 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 15:58:01 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yuwen Ng <yuwen.ng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 06/23] usb: mtu3: power down port when power down device IP
Date:   Tue, 8 Jun 2021 15:57:32 +0800
Message-ID: <1623139069-8173-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When power down device IP, we can also power down device port,
then power on the port again when power on device ip, it's helpful
to make device ip enter ip sleep mode.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index e306b93c007d..562f4357831e 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -334,6 +334,10 @@ void mtu3_start(struct mtu3 *mtu)
 		mtu3_readl(mbase, U3D_DEVICE_CONTROL));
 
 	mtu3_clrbits(mtu->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
+	if (mtu->is_u3_ip)
+		mtu3_clrbits(mtu->ippc_base, SSUSB_U3_CTRL(0), SSUSB_U3_PORT_PDN);
+
+	mtu3_clrbits(mtu->ippc_base, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_PDN);
 
 	mtu3_csr_init(mtu);
 	mtu3_set_speed(mtu, mtu->speed);
@@ -356,6 +360,11 @@ void mtu3_stop(struct mtu3 *mtu)
 		mtu3_dev_on_off(mtu, 0);
 
 	mtu->is_active = 0;
+
+	if (mtu->is_u3_ip)
+		mtu3_setbits(mtu->ippc_base, SSUSB_U3_CTRL(0), SSUSB_U3_PORT_PDN);
+
+	mtu3_setbits(mtu->ippc_base, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_PDN);
 	mtu3_setbits(mtu->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
 }
 
-- 
2.18.0

