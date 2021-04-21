Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D081A36698E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbhDUK6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:58:23 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41345 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237381AbhDUK6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:58:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UWI2xU2_1619002657;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UWI2xU2_1619002657)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Apr 2021 18:57:48 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     qiang.zhao@nxp.com
Cc:     leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] soc: fsl: qe: Remove unused function
Date:   Wed, 21 Apr 2021 18:56:53 +0800
Message-Id: <1619002613-18216-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last callers of this function were removed by commit d7c2878cfcfa
("soc: fsl: qe: remove unused qe_ic_set_* functions"):
https://github.com/torvalds/linux/commit/d7c2878cfcfa

Fix the following clang warning:

drivers/soc/fsl/qe/qe_ic.c:234:29: warning: unused function
'qe_ic_from_irq' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  - Modified submission information.

 drivers/soc/fsl/qe/qe_ic.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 0390af9..b573712 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -231,11 +231,6 @@ static inline void qe_ic_write(__be32  __iomem *base, unsigned int reg,
 	qe_iowrite32be(value, base + (reg >> 2));
 }
 
-static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
-{
-	return irq_get_chip_data(virq);
-}
-
 static inline struct qe_ic *qe_ic_from_irq_data(struct irq_data *d)
 {
 	return irq_data_get_irq_chip_data(d);
-- 
1.8.3.1

