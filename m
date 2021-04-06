Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D56354B73
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 06:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhDFEAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:00:23 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50405 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhDFEAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:00:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UUevcY0_1617681606;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UUevcY0_1617681606)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Apr 2021 12:00:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, andrew@aj.id.au,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] usb: gadget: aspeed: Remove unnecessary version.h includes
Date:   Tue,  6 Apr 2021 11:59:58 +0800
Message-Id: <1617681598-28165-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make versioncheck" shows:

./drivers/usb/gadget/udc/aspeed-vhub/hub.c: 33 linux/version.h not
needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 5c7dea5..e5bbc0c 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -30,7 +30,6 @@
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 #include <linux/bcd.h>
-#include <linux/version.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 
-- 
1.8.3.1

