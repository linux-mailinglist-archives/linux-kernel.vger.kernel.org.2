Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5F3445E74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 04:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhKEDNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 23:13:01 -0400
Received: from mx24.baidu.com ([111.206.215.185]:46664 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229647AbhKEDM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 23:12:57 -0400
Received: from BC-Mail-Ex12.internal.baidu.com (unknown [172.31.51.52])
        by Forcepoint Email with ESMTPS id 87323F51A477F15BA24F;
        Fri,  5 Nov 2021 11:10:06 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex12.internal.baidu.com (172.31.51.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 5 Nov 2021 11:10:06 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 5 Nov 2021 11:10:05 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver core: platform: Make use of the helper function dev_err_probe()
Date:   Fri, 5 Nov 2021 11:09:59 +0800
Message-ID: <20211105030959.730-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex10.internal.baidu.com (172.31.51.50) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When possible using dev_err_probe() helps to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
BTW rename 'dev' to 'pdev'.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/base/platform.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 598acf93a360..5befd3258677 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -253,13 +253,14 @@ EXPORT_SYMBOL_GPL(platform_get_irq_optional);
  *
  * Return: non-zero IRQ number on success, negative error number on failure.
  */
-int platform_get_irq(struct platform_device *dev, unsigned int num)
+int platform_get_irq(struct platform_device *pdev, unsigned int num)
 {
 	int ret;
 
-	ret = platform_get_irq_optional(dev, num);
-	if (ret < 0 && ret != -EPROBE_DEFER)
-		dev_err(&dev->dev, "IRQ index %u not found\n", num);
+	ret = platform_get_irq_optional(pdev, num);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "IRQ index %u not found\n", num);
 
 	return ret;
 }
-- 
2.25.1

