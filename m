Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB523A2A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFJLfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:35:10 -0400
Received: from m12-12.163.com ([220.181.12.12]:41103 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhFJLfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kL2WU
        PVMI2sOqh5zzqVizmefy347lO0/xquMbLBsk5M=; b=hmauaEtm7uAd1OIC1DkNT
        6VH1AHrYkwTtbO6Y1itn6HhTzHfuLUKPy0DqgrdlIHO09bBu3it8C4uO0tGS9tdm
        O6IpadIC+Ch4iKPFHkfRymXtmxSFILaGTetKN8r5Bkdq0AN2S50mXLHfUtih6e/M
        hLup5lJyGQYZJhXs5onpcQ=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowAA3+BiO1MFgUGtTJA--.4833S2;
        Thu, 10 Jun 2021 16:59:59 +0800 (CST)
From:   =?UTF-8?q?=C2=A0Zhongjun=20Tan?= <hbut_tan@163.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org, Tan Zhongjun <tanzhongjun@yulong.com>
Subject: [PATCH] mailbox:platform-mhu:Remove superfluous error messages around platform_get_irq()
Date:   Thu, 10 Jun 2021 16:59:42 +0800
Message-Id: <20210610085942.1172-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAA3+BiO1MFgUGtTJA--.4833S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrykKFy7tryDZw1furWDtwb_yoWDuFg_G3
        4kWa1xWrW8A3Z7t34UKw13ArZIyr98Wr1SvFs3KasIq3s8Z3W8tw1UXFZ3CFyUZw4qyFyD
        Aa1UGw1fCr98JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnkbbtUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/xtbBqBetxl75dLHjvgACsp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Zhongjun <tanzhongjun@yulong.com>

The platform_get_irq() prints error message telling that interrupt is
missing, hence there is no need to duplicated that message in the
drivers.

Signed-off-by: Tan Zhongjun <tanzhongjun@yulong.com>
---
 drivers/mailbox/platform_mhu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/platform_mhu.c b/drivers/mailbox/platform_mhu.c
index b6e34952246b..c3bb07d66b53 100644
--- a/drivers/mailbox/platform_mhu.c
+++ b/drivers/mailbox/platform_mhu.c
@@ -137,10 +137,8 @@ static int platform_mhu_probe(struct platform_device *pdev)
 	for (i = 0; i < MHU_CHANS; i++) {
 		mhu->chan[i].con_priv = &mhu->mlink[i];
 		mhu->mlink[i].irq = platform_get_irq(pdev, i);
-		if (mhu->mlink[i].irq < 0) {
-			dev_err(dev, "failed to get irq%d\n", i);
+		if (mhu->mlink[i].irq < 0)
 			return mhu->mlink[i].irq;
-		}
 		mhu->mlink[i].rx_reg = mhu->base + platform_mhu_reg[i];
 		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
 	}
-- 
2.17.1


