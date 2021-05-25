Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C44738FD39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhEYIys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:54:48 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:17662 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230415AbhEYIyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:54:46 -0400
X-UUID: 96d7248d572949e88ed084d68da836ce-20210525
X-UUID: 96d7248d572949e88ed084d68da836ce-20210525
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1221224435; Tue, 25 May 2021 16:53:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 16:53:09 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 16:53:08 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] usb: roles: add helper usb_role_string()
Date:   Tue, 25 May 2021 16:53:05 +0800
Message-ID: <1621932786-9335-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9D3C1B779BF25D9D23F9965EFEF3D524173D86C78AC011EFF27669269D1E0E2E2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces usb_role_string() function, which returns a
human-readable name of provided usb role, it's useful to
make the log readable.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/roles/class.c | 9 +++++++++
 include/linux/usb/role.h  | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 33b637d0d8d9..dfaed7eee94f 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -214,6 +214,15 @@ static const char * const usb_roles[] = {
 	[USB_ROLE_DEVICE]	= "device",
 };
 
+const char *usb_role_string(enum usb_role role)
+{
+	if (role < 0 || role >= ARRAY_SIZE(usb_roles))
+		return "unknown";
+
+	return usb_roles[role];
+}
+EXPORT_SYMBOL_GPL(usb_role_string);
+
 static ssize_t
 role_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index 0164fed31b06..031f148ab373 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -65,6 +65,7 @@ void usb_role_switch_unregister(struct usb_role_switch *sw);
 
 void usb_role_switch_set_drvdata(struct usb_role_switch *sw, void *data);
 void *usb_role_switch_get_drvdata(struct usb_role_switch *sw);
+const char *usb_role_string(enum usb_role role);
 #else
 static inline int usb_role_switch_set_role(struct usb_role_switch *sw,
 		enum usb_role role)
@@ -109,6 +110,11 @@ static inline void *usb_role_switch_get_drvdata(struct usb_role_switch *sw)
 	return NULL;
 }
 
+static inline const char *usb_role_string(enum usb_role role)
+{
+	return "unknown";
+}
+
 #endif
 
 #endif /* __LINUX_USB_ROLE_H */
-- 
2.18.0

