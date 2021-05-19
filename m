Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1811A3887B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhESGlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:41:23 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:14362 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230154AbhESGlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:41:21 -0400
X-UUID: 2ec47a64f7ac406c99535156bf549207-20210519
X-UUID: 2ec47a64f7ac406c99535156bf549207-20210519
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 591877477; Wed, 19 May 2021 14:39:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 May 2021 14:39:54 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 May 2021 14:39:53 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/3] usb: common: usb-conn-gpio: use dev_err_probe() to print log
Date:   Wed, 19 May 2021 14:39:45 +0800
Message-ID: <1621406386-18838-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1621406386-18838-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1621406386-18838-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 730A46FE6FA82AE1E7BACAD98544DE91B3AC4C7E7FA83417CA21920A6BC81EF42000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() to print debug or error message depending on
whether the error value is -DPROBE_DEFER or not.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/common/usb-conn-gpio.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index c9545a4eff66..dfbbc4f51ed6 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -223,18 +223,14 @@ static int usb_conn_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ERR(info->vbus)) {
-		if (PTR_ERR(info->vbus) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get vbus: %ld\n", PTR_ERR(info->vbus));
-		return PTR_ERR(info->vbus);
+		ret = PTR_ERR(info->vbus);
+		return dev_err_probe(dev, ret, "failed to get vbus :%d\n", ret);
 	}
 
 	info->role_sw = usb_role_switch_get(dev);
-	if (IS_ERR(info->role_sw)) {
-		if (PTR_ERR(info->role_sw) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get role switch\n");
-
-		return PTR_ERR(info->role_sw);
-	}
+	if (IS_ERR(info->role_sw))
+		return dev_err_probe(dev, PTR_ERR(info->role_sw),
+				     "failed to get role switch\n");
 
 	ret = usb_conn_psy_register(info);
 	if (ret)
-- 
2.18.0

