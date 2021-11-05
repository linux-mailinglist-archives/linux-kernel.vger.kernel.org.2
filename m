Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E52445DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhKEB6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:58:08 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:46030 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229685AbhKEB6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:58:07 -0400
Received: from localhost.localdomain (unknown [124.16.141.244])
        by APP-01 (Coremail) with SMTP id qwCowACnPyD6joRhBc2SBg--.22848S2;
        Fri, 05 Nov 2021 09:55:06 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: rzg2l_adc: Remove unnecessary print function dev_err()
Date:   Fri,  5 Nov 2021 01:55:04 +0000
Message-Id: <20211105015504.39226-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnPyD6joRhBc2SBg--.22848S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWrWF45KryUZFy7WrWfKrg_yoW3Jrc_Ka
        1xZanxArWIkwsYyw1Utw43Zr92yayqqw4DCr1qyFW3KFy7KFnrZFyUZFs0yr4xu3y8Wa47
        XF13WrySkr1fCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6w4l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
        IF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8go7tUUUUU==
X-Originating-IP: [124.16.141.244]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgkQA10TfuT6OgAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because
platform_get_irq() already prints an error.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/iio/adc/rzg2l_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 32fbf57c362f..9d5be52bd948 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -506,10 +506,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
 			       0, dev_name(dev), adc);
-- 
2.25.1

