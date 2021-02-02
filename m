Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAEF30B7E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 07:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhBBGis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 01:38:48 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47617 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231538AbhBBGir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 01:38:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UNeyF3-_1612247874;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNeyF3-_1612247874)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 14:37:55 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mark.rutland@arm.com
Cc:     lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] psci: remove unneeded semicolon
Date:   Tue,  2 Feb 2021 14:37:52 +0800
Message-Id: <1612247872-32603-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/firmware/psci/psci.c:141:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/firmware/psci/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f5fc429..35b355e 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -138,7 +138,7 @@ static int psci_to_linux_errno(int errno)
 		return -EINVAL;
 	case PSCI_RET_DENIED:
 		return -EPERM;
-	};
+	}
 
 	return -EINVAL;
 }
-- 
1.8.3.1

