Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F03AC782
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhFRJcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:32:20 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:57542 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233098AbhFRJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:32:02 -0400
X-UUID: 8ecd6afc4e0146fe8d374666bc46f9f2-20210618
X-UUID: 8ecd6afc4e0146fe8d374666bc46f9f2-20210618
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 442661741; Fri, 18 Jun 2021 17:29:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 17:29:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 17:29:34 +0800
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
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/13] usb: common: add helper to get role-switch-default-mode
Date:   Fri, 18 Jun 2021 17:29:10 +0800
Message-ID: <1624008558-16949-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7104CA8EF1F65A09B487D3784F8FBDBE70A6DEBC0820A162D1D28B3092C38A772000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper to get "role-switch-default-mode", and convert it
to the corresponding enum usb_dr_mode

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
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
index 69f1b6328532..1550b8e5f039 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -128,5 +128,6 @@ enum usb_dr_mode {
  * and returns the correspondig enum usb_dr_mode
  */
 extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
+extern enum usb_dr_mode usb_get_role_switch_default_mode(struct device *dev);
 
 #endif /* __LINUX_USB_OTG_H */
-- 
2.18.0

