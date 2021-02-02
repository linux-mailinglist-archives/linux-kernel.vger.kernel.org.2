Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BB630B7C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 07:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhBBGY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 01:24:28 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:39298 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhBBGY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 01:24:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UNeTXzY_1612247014;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNeTXzY_1612247014)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 14:23:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     nm@ti.com
Cc:     t-kristo@ti.com, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] firmware: ti_sci: rm: remove unneeded semicolon
Date:   Tue,  2 Feb 2021 14:23:33 +0800
Message-Id: <1612247013-17381-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/firmware/ti_sci.c:1762:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/firmware/ti_sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 235c7e7..5ae2040 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1759,7 +1759,7 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
 		desc->num = resp->range_num;
 		desc->start_sec = resp->range_start_sec;
 		desc->num_sec = resp->range_num_sec;
-	};
+	}
 
 fail:
 	ti_sci_put_one_xfer(&info->minfo, xfer);
-- 
1.8.3.1

