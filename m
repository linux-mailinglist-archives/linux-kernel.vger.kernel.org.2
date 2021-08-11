Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DB3E9060
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbhHKMTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:19:48 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:61116 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbhHKMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:19:35 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36113c031b13-64a31; Wed, 11 Aug 2021 20:18:57 +0800 (CST)
X-RM-TRANSID: 2ee36113c031b13-64a31
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36113c02cae4-3f770;
        Wed, 11 Aug 2021 20:18:57 +0800 (CST)
X-RM-TRANSID: 2ee36113c02cae4-3f770
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] mfd: ti_am335x_tscadc: Delete superfluous error message
Date:   Wed, 11 Aug 2021 20:19:34 +0800
Message-Id: <20210811121934.23548-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function ti_tscadc_probe(), when get irq failed,
platform_get_irq() logs an error message, so remove
redundant message here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 0e6e25308..55adc379f 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -175,10 +175,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	tscadc->dev = &pdev->dev;
 
 	err = platform_get_irq(pdev, 0);
-	if (err < 0) {
-		dev_err(&pdev->dev, "no irq ID is specified.\n");
+	if (err < 0)
 		goto ret;
-	} else
+	else
 		tscadc->irq = err;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.20.1.windows.1



