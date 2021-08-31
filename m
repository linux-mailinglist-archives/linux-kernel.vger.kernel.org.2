Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732F23FC799
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhHaMxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:53:07 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:58584 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhHaMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:53:06 -0400
X-QQ-mid: bizesmtp50t1630414322to4ez3a3
Received: from localhost.localdomain (unknown [124.126.19.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 31 Aug 2021 20:52:01 +0800 (CST)
X-QQ-SSF: 0140000000200070D000B00C0000000
X-QQ-FEAT: W55xVYr4DdamfzGdMYazV9cLbeqQm5kZFgM1v+xUwuvNJIcAJAqwN2SZTHB0z
        xPN/S7M4t7S1MVxUzXmAvUNlRLroyu+JYocJPPxBUGEPbiTOCNApH6dPQC+MxwAIf/0XTbT
        Q0atRhIjciBk5i7ME/5YbcP+3JHfo9+3MS8NRvGqHaGTD7B9aXSA/BOFJIICxKiMrZWiqfR
        D9/HpavpP0WBeh5wyF/zHLqP2SRYwXp9UvKlO5tLnYtN1GXDffV2HvtlmxTWXKS5e6EppwS
        o8G942HpQ8xGCVZMSNAJAzvIMMxmAG7c38uRU34cc62+rvQJFLz4uHnn1WAth6Og8EKB8rN
        XQm0/96p4qeLWsh/tjQ2HhauCTbtE9gJFgNE0gr3M+AyO60yao=
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     thierry.reding@gmail.com, lee.jones@linaro.org, heiko@sntech.de
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] pwm: rockchip: Simplify using devm_pwmchip_add()
Date:   Tue, 31 Aug 2021 20:51:59 +0800
Message-Id: <20210831125159.29282-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With devm_pwmchip_add() we can drop pwmchip_remove() from the device
remove callback. The latter can then go away, too and as this is the
only user of platform_get_drvdata(), the respective call to
platform_set_drvdata() can go, too.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/pwm/pwm-rockchip.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index cbe900877724..c22856916e63 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -347,8 +347,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	platform_set_drvdata(pdev, pc);
-
 	pc->data = id->data;
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &rockchip_pwm_ops;
@@ -358,7 +356,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
 	enabled = (ctrl & enable_conf) == enable_conf;
 
-	ret = pwmchip_add(&pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		goto err_pclk;
@@ -380,37 +378,12 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rockchip_pwm_remove(struct platform_device *pdev)
-{
-	struct rockchip_pwm_chip *pc = platform_get_drvdata(pdev);
-
-	/*
-	 * Disable the PWM clk before unpreparing it if the PWM device is still
-	 * running. This should only happen when the last PWM user left it
-	 * enabled, or when nobody requested a PWM that was previously enabled
-	 * by the bootloader.
-	 *
-	 * FIXME: Maybe the core should disable all PWM devices in
-	 * pwmchip_remove(). In this case we'd only have to call
-	 * clk_unprepare() after pwmchip_remove().
-	 *
-	 */
-	if (pwm_is_enabled(pc->chip.pwms))
-		clk_disable(pc->clk);
-
-	clk_unprepare(pc->pclk);
-	clk_unprepare(pc->clk);
-
-	return pwmchip_remove(&pc->chip);
-}
-
 static struct platform_driver rockchip_pwm_driver = {
 	.driver = {
 		.name = "rockchip-pwm",
 		.of_match_table = rockchip_pwm_dt_ids,
 	},
 	.probe = rockchip_pwm_probe,
-	.remove = rockchip_pwm_remove,
 };
 module_platform_driver(rockchip_pwm_driver);
 
-- 
2.20.1



