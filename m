Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E77C30D114
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 02:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhBCBwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 20:52:09 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:39400 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231419AbhBCBv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 20:51:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UNieciu_1612317065;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNieciu_1612317065)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 09:51:05 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     leoyang.li@nxp.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] soc: fsl: guts: remove unneeded semicolon
Date:   Wed,  3 Feb 2021 09:51:03 +0800
Message-Id: <1612317063-72424-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/soc/fsl/guts.c:120:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/soc/fsl/guts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 34810f9..d5e9a5f 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -117,7 +117,7 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
 		if (matches->svr == (svr & matches->mask))
 			return matches;
 		matches++;
-	};
+	}
 	return NULL;
 }
 
-- 
1.8.3.1

