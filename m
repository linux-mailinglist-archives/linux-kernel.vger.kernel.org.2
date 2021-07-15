Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC03C9B23
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbhGOJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:11:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40026 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240869AbhGOJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:11:18 -0400
X-UUID: b751ffdfa3a84bf189cde9bd6b7c0597-20210715
X-UUID: b751ffdfa3a84bf189cde9bd6b7c0597-20210715
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1173810591; Thu, 15 Jul 2021 17:08:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:08:19 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:08:19 +0800
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
Subject: [PATCH v3 09/13] usb: mtu3: add new helpers for host suspend/resume
Date:   Thu, 15 Jul 2021 17:07:54 +0800
Message-ID: <1626340078-29111-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract two helpers for host suspend and resume, will make it easy
to support dual-role mode suspend/resume later.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~3: no changes
---
 drivers/usb/mtu3/mtu3_dr.h   |  8 ++--
 drivers/usb/mtu3/mtu3_host.c | 92 ++++++++++++++++++++++++++++++++----
 drivers/usb/mtu3/mtu3_plat.c |  4 +-
 3 files changed, 88 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_dr.h b/drivers/usb/mtu3/mtu3_dr.h
index 760fe7d69c6b..70dbf4706138 100644
--- a/drivers/usb/mtu3/mtu3_dr.h
+++ b/drivers/usb/mtu3/mtu3_dr.h
@@ -16,8 +16,8 @@ int ssusb_host_init(struct ssusb_mtk *ssusb, struct device_node *parent_dn);
 void ssusb_host_exit(struct ssusb_mtk *ssusb);
 int ssusb_wakeup_of_property_parse(struct ssusb_mtk *ssusb,
 				struct device_node *dn);
-int ssusb_host_enable(struct ssusb_mtk *ssusb);
-int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend);
+int ssusb_host_resume(struct ssusb_mtk *ssusb, bool p0_skipped);
+int ssusb_host_suspend(struct ssusb_mtk *ssusb);
 void ssusb_wakeup_set(struct ssusb_mtk *ssusb, bool enable);
 
 #else
@@ -38,12 +38,12 @@ static inline int ssusb_wakeup_of_property_parse(
 	return 0;
 }
 
-static inline int ssusb_host_enable(struct ssusb_mtk *ssusb)
+static inline int ssusb_host_resume(struct ssusb_mtk *ssusb, bool p0_skipped)
 {
 	return 0;
 }
 
-static inline int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
+static inline int ssusb_host_suspend(struct ssusb_mtk *ssusb)
 {
 	return 0;
 }
diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index 6185bac5fecf..a0a6a181b752 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -126,7 +126,7 @@ static void host_ports_num_get(struct ssusb_mtk *ssusb)
 }
 
 /* only configure ports will be used later */
-int ssusb_host_enable(struct ssusb_mtk *ssusb)
+static int ssusb_host_enable(struct ssusb_mtk *ssusb)
 {
 	void __iomem *ibase = ssusb->ippc_base;
 	int num_u3p = ssusb->u3_ports;
@@ -171,13 +171,12 @@ int ssusb_host_enable(struct ssusb_mtk *ssusb)
 	return ssusb_check_clocks(ssusb, check_clk);
 }
 
-int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
+static int ssusb_host_disable(struct ssusb_mtk *ssusb)
 {
 	void __iomem *ibase = ssusb->ippc_base;
 	int num_u3p = ssusb->u3_ports;
 	int num_u2p = ssusb->u2_ports;
 	u32 value;
-	int ret;
 	int i;
 
 	/* power down and disable u3 ports except skipped ones */
@@ -186,8 +185,7 @@ int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
 			continue;
 
 		value = mtu3_readl(ibase, SSUSB_U3_CTRL(i));
-		value |= SSUSB_U3_PORT_PDN;
-		value |= suspend ? 0 : SSUSB_U3_PORT_DIS;
+		value |= SSUSB_U3_PORT_PDN | SSUSB_U3_PORT_DIS;
 		mtu3_writel(ibase, SSUSB_U3_CTRL(i), value);
 	}
 
@@ -197,16 +195,90 @@ int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
 			continue;
 
 		value = mtu3_readl(ibase, SSUSB_U2_CTRL(i));
-		value |= SSUSB_U2_PORT_PDN;
-		value |= suspend ? 0 : SSUSB_U2_PORT_DIS;
+		value |= SSUSB_U2_PORT_PDN | SSUSB_U2_PORT_DIS;
 		mtu3_writel(ibase, SSUSB_U2_CTRL(i), value);
 	}
 
 	/* power down host ip */
 	mtu3_setbits(ibase, U3D_SSUSB_IP_PW_CTRL1, SSUSB_IP_HOST_PDN);
 
-	if (!suspend)
-		return 0;
+	return 0;
+}
+
+int ssusb_host_resume(struct ssusb_mtk *ssusb, bool p0_skipped)
+{
+	void __iomem *ibase = ssusb->ippc_base;
+	int u3p_skip_msk = ssusb->u3p_dis_msk;
+	int u2p_skip_msk = ssusb->u2p_dis_msk;
+	int num_u3p = ssusb->u3_ports;
+	int num_u2p = ssusb->u2_ports;
+	u32 value;
+	int i;
+
+	if (p0_skipped) {
+		u2p_skip_msk |= 0x1;
+		if (ssusb->otg_switch.is_u3_drd)
+			u3p_skip_msk |= 0x1;
+	}
+
+	/* power on host ip */
+	mtu3_clrbits(ibase, U3D_SSUSB_IP_PW_CTRL1, SSUSB_IP_HOST_PDN);
+
+	/* power on u3 ports except skipped ones */
+	for (i = 0; i < num_u3p; i++) {
+		if ((0x1 << i) & u3p_skip_msk)
+			continue;
+
+		value = mtu3_readl(ibase, SSUSB_U3_CTRL(i));
+		value &= ~SSUSB_U3_PORT_PDN;
+		mtu3_writel(ibase, SSUSB_U3_CTRL(i), value);
+	}
+
+	/* power on all u2 ports except skipped ones */
+	for (i = 0; i < num_u2p; i++) {
+		if ((0x1 << i) & u2p_skip_msk)
+			continue;
+
+		value = mtu3_readl(ibase, SSUSB_U2_CTRL(i));
+		value &= ~SSUSB_U2_PORT_PDN;
+		mtu3_writel(ibase, SSUSB_U2_CTRL(i), value);
+	}
+
+	return 0;
+}
+
+/* here not skip port0 due to PDN can be set repeatedly */
+int ssusb_host_suspend(struct ssusb_mtk *ssusb)
+{
+	void __iomem *ibase = ssusb->ippc_base;
+	int num_u3p = ssusb->u3_ports;
+	int num_u2p = ssusb->u2_ports;
+	u32 value;
+	int ret;
+	int i;
+
+	/* power down u3 ports except skipped ones */
+	for (i = 0; i < num_u3p; i++) {
+		if ((0x1 << i) & ssusb->u3p_dis_msk)
+			continue;
+
+		value = mtu3_readl(ibase, SSUSB_U3_CTRL(i));
+		value |= SSUSB_U3_PORT_PDN;
+		mtu3_writel(ibase, SSUSB_U3_CTRL(i), value);
+	}
+
+	/* power down u2 ports except skipped ones */
+	for (i = 0; i < num_u2p; i++) {
+		if ((0x1 << i) & ssusb->u2p_dis_msk)
+			continue;
+
+		value = mtu3_readl(ibase, SSUSB_U2_CTRL(i));
+		value |= SSUSB_U2_PORT_PDN;
+		mtu3_writel(ibase, SSUSB_U2_CTRL(i), value);
+	}
+
+	/* power down host ip */
+	mtu3_setbits(ibase, U3D_SSUSB_IP_PW_CTRL1, SSUSB_IP_HOST_PDN);
 
 	/* wait for host ip to sleep */
 	ret = readl_poll_timeout(ibase + U3D_SSUSB_IP_PW_STS1, value,
@@ -237,7 +309,7 @@ static void ssusb_host_cleanup(struct ssusb_mtk *ssusb)
 	if (ssusb->is_host)
 		ssusb_set_vbus(&ssusb->otg_switch, 0);
 
-	ssusb_host_disable(ssusb, false);
+	ssusb_host_disable(ssusb);
 }
 
 /*
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 5162b9988dde..a906b24723e6 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -411,7 +411,7 @@ static int __maybe_unused mtu3_suspend(struct device *dev)
 	if (!ssusb->is_host)
 		return 0;
 
-	ssusb_host_disable(ssusb, true);
+	ssusb_host_suspend(ssusb);
 	ssusb_phy_power_off(ssusb);
 	clk_bulk_disable_unprepare(BULK_CLKS_CNT, ssusb->clks);
 	ssusb_wakeup_set(ssusb, true);
@@ -438,7 +438,7 @@ static int __maybe_unused mtu3_resume(struct device *dev)
 	if (ret)
 		goto phy_err;
 
-	ssusb_host_enable(ssusb);
+	ssusb_host_resume(ssusb, false);
 
 	return 0;
 
-- 
2.18.0

