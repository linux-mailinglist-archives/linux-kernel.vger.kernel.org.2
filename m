Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C183A9182
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 07:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFPGAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:00:21 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:32919 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229483AbhFPGAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:00:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uca-rl9_1623823087;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uca-rl9_1623823087)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jun 2021 13:58:10 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clabbe@baylibre.com
Cc:     ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] crypto: sl3516 - Fix duplicate included linux/io.h
Date:   Wed, 16 Jun 2021 13:58:02 +0800
Message-Id: <1623823082-3880-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following includecheck warning:

./drivers/crypto/gemini/sl3516-ce-cipher.c: linux/io.h is included more
than once.

No functional change.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/crypto/gemini/sl3516-ce-cipher.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/gemini/sl3516-ce-cipher.c b/drivers/crypto/gemini/sl3516-ce-cipher.c
index 0b34a49..b41c2f5 100644
--- a/drivers/crypto/gemini/sl3516-ce-cipher.c
+++ b/drivers/crypto/gemini/sl3516-ce-cipher.c
@@ -12,7 +12,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/io.h>
 #include <linux/pm_runtime.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/internal/skcipher.h>
-- 
1.8.3.1

