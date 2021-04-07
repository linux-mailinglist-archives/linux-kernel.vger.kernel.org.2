Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC133562E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 07:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244411AbhDGFML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 01:12:11 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:31738 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229603AbhDGFMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 01:12:10 -0400
Received: from localhost.localdomain (unknown [10.192.24.118])
        by mail-app3 (Coremail) with SMTP id cC_KCgAXT9QWP21gRzDbAA--.64419S4;
        Wed, 07 Apr 2021 13:11:54 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Lee Jones <lee.jones@linaro.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: arizona: Fix rumtime PM imbalance on error
Date:   Wed,  7 Apr 2021 13:11:49 +0800
Message-Id: <20210407051149.31422-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgAXT9QWP21gRzDbAA--.64419S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW3Aw4rurW8GF1kAr48tFb_yoWfZFX_Cw
        s8ur17ur45Wr10qrW7WayrZ34Iva1UWFykua1SvanxJF4Yka9xXry8ZFyDCw4fZ3y8AFn0
        yrnIyrWfA3Z7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
        CI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoGBlZdtTQGhAAPsP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() will increase the rumtime PM counter
even it returns an error. Thus a pairing decrement is needed
to prevent refcount leak. Fix this by replacing this API with
pm_runtime_resume_and_get(), which will not change the runtime
PM counter on error.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/mfd/arizona-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-irq.c b/drivers/mfd/arizona-irq.c
index 077d9ab112b7..d919ae9691e2 100644
--- a/drivers/mfd/arizona-irq.c
+++ b/drivers/mfd/arizona-irq.c
@@ -100,7 +100,7 @@ static irqreturn_t arizona_irq_thread(int irq, void *data)
 	unsigned int val;
 	int ret;
 
-	ret = pm_runtime_get_sync(arizona->dev);
+	ret = pm_runtime_resume_and_get(arizona->dev);
 	if (ret < 0) {
 		dev_err(arizona->dev, "Failed to resume device: %d\n", ret);
 		return IRQ_NONE;
-- 
2.17.1

