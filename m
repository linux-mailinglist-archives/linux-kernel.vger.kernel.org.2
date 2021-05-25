Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F56C38FF88
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhEYKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:52:09 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:41108 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231364AbhEYKwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:52:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ua4PLBH_1621939834;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Ua4PLBH_1621939834)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 May 2021 18:50:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     kishon@ti.com
Cc:     vkoul@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] phy: ti: Fix an error code in wiz_probe()
Date:   Tue, 25 May 2021 18:50:32 +0800
Message-Id: <1621939832-65535-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the code execute this if statement, the value of ret is 0. 
However, we can see from the dev_err() log that the value of 
ret should be -EINVAL.

Clean up smatch warning:

drivers/phy/ti/phy-j721e-wiz.c:1216 wiz_probe() warn: missing error code
'ret'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 'commit c9f9eba06629 ("phy: ti: j721e-wiz: Manage
typec-gpio-dir")'
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 9eb6d37..126f5b8 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1212,6 +1212,7 @@ static int wiz_probe(struct platform_device *pdev)
 
 		if (wiz->typec_dir_delay < WIZ_TYPEC_DIR_DEBOUNCE_MIN ||
 		    wiz->typec_dir_delay > WIZ_TYPEC_DIR_DEBOUNCE_MAX) {
+			ret = -EINVAL;
 			dev_err(dev, "Invalid typec-dir-debounce property\n");
 			goto err_addr_to_resource;
 		}
-- 
1.8.3.1

