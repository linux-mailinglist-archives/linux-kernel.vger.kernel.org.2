Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6D3B07D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhFVOtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:49:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56338 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhFVOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:49:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lvhgZ-0007Qr-5Q; Tue, 22 Jun 2021 14:47:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] regulator: bd9576: Fix uninitializes variable may_have_irqs
Date:   Tue, 22 Jun 2021 15:47:30 +0100
Message-Id: <20210622144730.22821-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The boolean variable may_have_irqs is not ininitialized and is
only being set to true in the case where chip is ROHM_CHIP_TYPE_BD9576.
Fix this by ininitialized may_have_irqs to false.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: e7bf1fa58c46 ("regulator: bd9576: Support error reporting")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/bd9576-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
index 8b54d88827be..e16c3727db7a 100644
--- a/drivers/regulator/bd9576-regulator.c
+++ b/drivers/regulator/bd9576-regulator.c
@@ -897,7 +897,7 @@ static int bd957x_probe(struct platform_device *pdev)
 {
 	int i;
 	unsigned int num_reg_data;
-	bool vout_mode, ddr_sel, may_have_irqs;
+	bool vout_mode, ddr_sel, may_have_irqs = false;
 	struct regmap *regmap;
 	struct bd957x_data *ic_data;
 	struct regulator_config config = { 0 };
-- 
2.31.1

