Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE596453001
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhKPLP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhKPLPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:15:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE58C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:12:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mmwNh-0003cc-2u; Tue, 16 Nov 2021 12:12:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mmwNf-000JZr-RT; Tue, 16 Nov 2021 12:12:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mmwNe-0005jf-KF; Tue, 16 Nov 2021 12:12:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] regulator: da9121: Emit only one error message in .remove()
Date:   Tue, 16 Nov 2021 12:09:51 +0100
Message-Id: <20211116110951.1213566-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=3+6clOr0diYOpZJYKZyjIjkXEwRuf9y1157jEHFl440=; m=/RkPrYbYg2wisFkD5xGgLAEtfvjSWZsjAgOD//enhC8=; p=cW59XZAeB7qPlUiYDeVAU78d0ASJh+kM0Qg463Wu/Q8=; g=ac8063cb5526a473f03faafbac6b7bf088f74c31
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGTkXwACgkQwfwUeK3K7AlkPQf/YYT N1vWac9KdsPK2/3sbnI25u/ssxmHm3Aj2+EM9IOss8KoImfslXTFbPE3DIr8kIZT+pC9PGkBYq50A rDHZi9EhGaiylGK35eXO0jltqBbBevZC++okfhOBf5r8qK+olHZ/BsxE5yl69dIsETcD9F69io4Ly FpeOwYT60aU9Kn8AJ8PaoEySDbLXybV3JtkDTkfbPG7y8TNijQxCeQ0I2SOqQBZswRbCDIw5SI41c 9l7DIBAi1lLpwZHVTAU53TMupugia8g+4TRnFo8aUI3j9ZiDL1UT/TRGUKoOeUiQ54pewsa1Em2wQ xEKYVms0mkUAlj4qu4efu5CNif+IFZQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an i2c remove callback fails, the i2c core emits a generic error
message and still removes the device. Apart from the message there the
return value isn't further used.

So don't return an error code after having already emitted a driver
specific warning about the problem to prevent two messages about the
same issue.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/regulator/da9121-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index e66925090258..a5a83b772a85 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -1065,7 +1065,7 @@ static int da9121_i2c_remove(struct i2c_client *i2c)
 {
 	struct da9121 *chip = i2c_get_clientdata(i2c);
 	const int mask_all[4] = { 0xFF, 0xFF, 0xFF, 0xFF };
-	int ret = 0;
+	int ret;
 
 	free_irq(chip->chip_irq, chip);
 	cancel_delayed_work_sync(&chip->work);
@@ -1073,7 +1073,7 @@ static int da9121_i2c_remove(struct i2c_client *i2c)
 	ret = regmap_bulk_write(chip->regmap, DA9121_REG_SYS_MASK_0, mask_all, 4);
 	if (ret != 0)
 		dev_err(chip->dev, "Failed to set IRQ masks: %d\n", ret);
-	return ret;
+	return 0;
 }
 
 static const struct i2c_device_id da9121_i2c_id[] = {
-- 
2.30.2

