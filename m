Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3936E2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 03:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhD2B1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 21:27:39 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35453 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231161AbhD2B1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 21:27:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UX7837P_1619659609;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UX7837P_1619659609)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Apr 2021 09:26:51 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     lorenzo.pieralisi@arm.com
Cc:     mark.rutland@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, soc@kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v2] psci: Remove unneeded semicolon
Date:   Thu, 29 Apr 2021 09:26:29 +0800
Message-Id: <1619659589-4775-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/firmware/psci/psci.c:141:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---

Change in v2:
--subject should read "psci: Remove unneeded semicolon"

 drivers/firmware/psci/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 64344e8..6e7bac6 100644
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

