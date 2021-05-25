Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B768838FD3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhEYIyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:54:51 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:40199 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232226AbhEYIyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:54:49 -0400
X-UUID: d129fe9da30d4b9c9e983349599130a7-20210525
X-UUID: d129fe9da30d4b9c9e983349599130a7-20210525
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1911523834; Tue, 25 May 2021 16:53:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 16:53:10 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 16:53:09 +0800
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
Subject: [PATCH 2/2] usb: common: usb-conn-gpio: use usb_role_string() to print role status
Date:   Tue, 25 May 2021 16:53:06 +0800
Message-ID: <1621932786-9335-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1621932786-9335-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1621932786-9335-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 775A0B1362276C37A09733E3CEDA3FC8205CFB046EBCE31B5DB8EB0AD349CA1F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use usb_role_string() to print role status, make the log readable.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/common/usb-conn-gpio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 65d89140cd19..7dbe8baed029 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -83,11 +83,11 @@ static void usb_conn_detect_cable(struct work_struct *work)
 	else
 		role = USB_ROLE_NONE;
 
-	dev_dbg(info->dev, "role %d/%d, gpios: id %d, vbus %d\n",
-		info->last_role, role, id, vbus);
+	dev_dbg(info->dev, "role %s -> %s, gpios: id %d, vbus %d\n",
+		usb_role_string(info->last_role), usb_role_string(role), id, vbus);
 
 	if (info->last_role == role) {
-		dev_warn(info->dev, "repeated role: %d\n", role);
+		dev_warn(info->dev, "repeated role: %s\n", usb_role_string(role));
 		return;
 	}
 
-- 
2.18.0

