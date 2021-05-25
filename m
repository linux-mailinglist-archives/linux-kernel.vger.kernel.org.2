Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABBD38FD4E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhEYJBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:01:12 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:22024 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232251AbhEYJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:01:08 -0400
X-UUID: 12e204deaa60458a880660ae7dbcd3de-20210525
X-UUID: 12e204deaa60458a880660ae7dbcd3de-20210525
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1574218279; Tue, 25 May 2021 16:59:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 16:59:29 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 16:59:28 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/3] usb: common: add helper to get role-switch-default-mode
Date:   Tue, 25 May 2021 16:59:24 +0800
Message-ID: <1621933165-9661-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1621933165-9661-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1621933165-9661-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8C0FE68DFA6589FCA3D9D34402D9CDF0EA656AD0BA301A1EC48A81BDD66D13B32000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper to get "role-switch-default-mode", and convert it
to the corresponding enum usb_dr_mode

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/common/common.c | 20 ++++++++++++++++++++
 include/linux/usb/otg.h     |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index fff318597337..78a625a4e526 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -207,6 +207,26 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
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
index a86ee6aad51b..bde313c97fb6 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -121,5 +121,6 @@ enum usb_dr_mode {
 };
 
 extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
+extern enum usb_dr_mode usb_get_role_switch_default_mode(struct device *dev);
 
 #endif /* __LINUX_USB_OTG_H */
-- 
2.18.0

