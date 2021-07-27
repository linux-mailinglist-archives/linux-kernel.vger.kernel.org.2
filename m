Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E63D73B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhG0Kuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:50:51 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:52686 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236293AbhG0Kuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:50 -0400
X-UUID: cbe704db5b144178a1a6b3101c4e9843-20210727
X-UUID: cbe704db5b144178a1a6b3101c4e9843-20210727
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1000917277; Tue, 27 Jul 2021 18:50:45 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 18:50:44 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Jul 2021 18:50:44 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     <linux-phy@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Ainge Hsu <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] phy: introduce phy mode PHY_MODE_UART and phy_get_mode_ext()
Date:   Tue, 27 Jul 2021 18:50:12 +0800
Message-ID: <1627383013-4535-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some embedded platform shared PINs between USB and UART.

For example, some phone will use special cable detection in boot loader
to switch USB port function into UART mode. Hence Kernel need to query
the hardware state from PHY registers to confirm the initialzation flow
for PHY and USB driver.

To support this kind of PIN switch, new PHY MODE and query API is
required. Here we introduce a new PHY mode: PHY_MODE_UART.

API phy_get_mode_ext() can be used to query the MODE from hardware
instead of reading it from phy attributes.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 drivers/phy/phy-core.c  |   17 +++++++++++++++++
 include/linux/phy/phy.h |    3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index ccb575b..b8f6539 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -373,6 +373,23 @@ int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
 }
 EXPORT_SYMBOL_GPL(phy_set_mode_ext);
 
+int phy_get_mode_ext(struct phy *phy)
+{
+	int ret;
+
+	if (!phy || !phy->ops->get_mode_ext)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->get_mode_ext(phy);
+	if (!ret)
+		ret = phy->attrs.mode;
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_get_mode_ext);
+
 int phy_set_media(struct phy *phy, enum phy_media media)
 {
 	int ret;
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 0ed434d..7d32c6b 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -34,6 +34,7 @@ enum phy_mode {
 	PHY_MODE_USB_DEVICE_HS,
 	PHY_MODE_USB_DEVICE_SS,
 	PHY_MODE_USB_OTG,
+	PHY_MODE_UART,
 	PHY_MODE_UFS_HS_A,
 	PHY_MODE_UFS_HS_B,
 	PHY_MODE_PCIE,
@@ -70,6 +71,7 @@ enum phy_media {
  * @power_on: powering on the phy
  * @power_off: powering off the phy
  * @set_mode: set the mode of the phy
+ * @get_mode_ext: get the extented mode of the phy
  * @set_media: set the media type of the phy (optional)
  * @set_speed: set the speed of the phy (optional)
  * @reset: resetting the phy
@@ -83,6 +85,7 @@ struct phy_ops {
 	int	(*power_on)(struct phy *phy);
 	int	(*power_off)(struct phy *phy);
 	int	(*set_mode)(struct phy *phy, enum phy_mode mode, int submode);
+	int	(*get_mode_ext)(struct phy *phy);
 	int	(*set_media)(struct phy *phy, enum phy_media media);
 	int	(*set_speed)(struct phy *phy, int speed);
 
-- 
1.7.9.5

