Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143F33A9B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhFPNCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhFPNCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:02:14 -0400
X-Greylist: delayed 369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Jun 2021 06:00:08 PDT
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de [IPv6:2a01:4f8:c17:c88::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3467C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 06:00:08 -0700 (PDT)
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
        id A415485E61; Wed, 16 Jun 2021 14:53:54 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        magratgarlick.emantor.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.2
Received: from localhost (unknown [IPv6:2001:9e8:217c:d502:c0d3:dbff:fefe:ff70])
        by magratgarlick.emantor.de (Postfix) with ESMTPSA id E605E85E38;
        Wed, 16 Jun 2021 14:53:52 +0200 (CEST)
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel@pengutronix.de,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: fixed: use dev_err_probe for gpio
Date:   Wed, 16 Jun 2021 14:53:31 +0200
Message-Id: <20210616125331.153414-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of returning the the PTR_ERR directly, use dev_err_probe which
will also correctly set the deferred probe reason in
/sys/kernel/debug/deferred_devices, making it easier to debug missing
devices on the system.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 drivers/regulator/fixed.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 02ad83153e19..78f3a938b39b 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -271,7 +271,8 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	 */
 	cfg.ena_gpiod = gpiod_get_optional(&pdev->dev, NULL, gflags);
 	if (IS_ERR(cfg.ena_gpiod))
-		return PTR_ERR(cfg.ena_gpiod);
+		return dev_err_probe(&pdev->dev, PTR_ERR(cfg.ena_gpiod),
+				     "can't get GPIO\n");
 
 	cfg.dev = &pdev->dev;
 	cfg.init_data = config->init_data;
-- 
2.31.1

