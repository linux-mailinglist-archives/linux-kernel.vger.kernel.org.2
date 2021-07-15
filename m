Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC0D3C9B22
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbhGOJLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:11:34 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44556 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240858AbhGOJLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:11:17 -0400
X-UUID: 6865d9a4e51241f3b168169041879012-20210715
X-UUID: 6865d9a4e51241f3b168169041879012-20210715
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1772682842; Thu, 15 Jul 2021 17:08:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:08:16 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:08:15 +0800
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
Subject: [PATCH v3 05/13] usb: common: add helper to get role-switch-default-mode
Date:   Thu, 15 Jul 2021 17:07:50 +0800
Message-ID: <1626340078-29111-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper to get "role-switch-default-mode", and convert it
to the corresponding enum usb_dr_mode

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~3: no changes
---
 drivers/usb/common/common.c | 20 ++++++++++++++++++++
 include/linux/usb/otg.h     |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 347fb3d3894a..c9bdeb4ddcb5 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -200,6 +200,26 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_get_dr_mode);
 
+/**
+ * usb_get_role_switch_default_mode - Get default mode for given device
+ * @dev: Pointer to the given device
+ *
+ * The function gets string from property 'role-switch-default-mode',
+ * and returns the corresponding enum usb_dr_mode.
+ */
+enum usb_dr_mode usb_get_role_switch_default_mode(struct device *dev)
+{
+	const char *str;
+	int ret;
+
+	ret = device_property_read_string(dev, "role-switch-default-mode", &str);
+	if (ret < 0)
+		return USB_DR_MODE_UNKNOWN;
+
+	return usb_get_dr_mode_from_string(str);
+}
+EXPORT_SYMBOL_GPL(usb_get_role_switch_default_mode);
+
 /**
  * usb_decode_interval - Decode bInterval into the time expressed in 1us unit
  * @epd: The descriptor of the endpoint
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 7ceeecbb9e02..6475f880be37 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -128,5 +128,6 @@ enum usb_dr_mode {
  * and returns the corresponding enum usb_dr_mode
  */
 extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
+extern enum usb_dr_mode usb_get_role_switch_default_mode(struct device *dev);
 
 #endif /* __LINUX_USB_OTG_H */
-- 
2.18.0

