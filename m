Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7AF38C6A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhEUMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:38:16 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:17855 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhEUMiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:38:08 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d78 with ME
        id 7Qcg2500H21Fzsu03Qchxh; Fri, 21 May 2021 14:36:44 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 May 2021 14:36:44 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        dianders@chromium.org, rmfrfs@gmail.com, cjb@laptop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mmc: mxs-mmc: Disable the 'reg_vmmc' regulator when needed
Date:   Fri, 21 May 2021 14:36:39 +0200
Message-Id: <d05074c11962a046ff9c2f457c240432ca8a7194.1621600443.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'reg_vmmc' regulator is never disabled. Neither in the error handling
of the probe, nor in the remove function.

Add a managed action to do the required clean-up before a 'regulator_put()'
call.

Fixes: 4dc5a79f1350 ("mmc: mxs-mmc: enable regulator for mmc slot")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/mxs-mmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 947581de7860..b043d53dd728 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -552,6 +552,13 @@ static const struct of_device_id mxs_mmc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mxs_mmc_dt_ids);
 
+static void regulator_disable_action(void *_data)
+{
+	struct regulator *regulator = _data;
+
+	regulator_disable(regulator);
+}
+
 static int mxs_mmc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -591,6 +598,10 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 				"Failed to enable vmmc regulator: %d\n", ret);
 			goto out_mmc_free;
 		}
+		ret = devm_add_action_or_reset(&pdev->dev,
+					regulator_disable_action, reg_vmmc);
+		if (ret)
+			goto out_mmc_free;
 	}
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.30.2

