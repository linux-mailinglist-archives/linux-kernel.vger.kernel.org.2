Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6833044600E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhKEHSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:18:07 -0400
Received: from mx22.baidu.com ([220.181.50.185]:40298 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230073AbhKEHSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:18:05 -0400
Received: from BC-Mail-Ex03.internal.baidu.com (unknown [172.31.51.43])
        by Forcepoint Email with ESMTPS id BF7C92CAB7A78CB7F91C;
        Fri,  5 Nov 2021 15:15:16 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex03.internal.baidu.com (172.31.51.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 5 Nov 2021 15:15:16 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 5 Nov 2021 15:15:16 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] driver core: platform: Make use of the helper function dev_err_probe()
Date:   Fri, 5 Nov 2021 15:15:09 +0800
Message-ID: <20211105071509.969-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When possible using dev_err_probe() helps to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: *Revert the change of variable name 'dev'.

 drivers/base/platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 598acf93a360..7109351366c8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -258,8 +258,9 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	int ret;
 
 	ret = platform_get_irq_optional(dev, num);
-	if (ret < 0 && ret != -EPROBE_DEFER)
-		dev_err(&dev->dev, "IRQ index %u not found\n", num);
+	if (ret < 0)
+		return dev_err_probe(&dev->dev, ret,
+				     "IRQ index %u not found\n", num);
 
 	return ret;
 }
-- 
2.25.1

