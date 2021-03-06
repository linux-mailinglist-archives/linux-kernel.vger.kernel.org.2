Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6CD32FC70
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 19:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhCFSNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 13:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhCFSNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 13:13:30 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E811BC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jwU+rXHx1pGkAvbGS3LaYzI6HRfz/v5lPgPPGLjWqg8=; b=S1Pk+zTjjGA6852H8PwAZnbou4
        08PITlJ2OvcbOv/36GEUv/NxBo4lOOyVqBskYQughCuhYAyKVRApBY1i4DLsiNGfDfIpSAcXNEy8d
        mHcL5oTPgKSfYcw8JHT1Hkvs3dmu74X3sHwekGdpBzYCsT9k9bD3AgwNJBMjHUu3LzD0=;
Received: from p200300ccff3790001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:9000:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lIbQb-0004AT-F1; Sat, 06 Mar 2021 19:13:25 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lIbQb-0003JD-50; Sat, 06 Mar 2021 19:13:25 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     j.neuschaefer@gmx.net, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH -next] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Date:   Sat,  6 Mar 2021 19:13:14 +0100
Message-Id: <20210306181314.12673-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the version of the EC in the Tolino Shine 2 HD
to the supported versions. It seems not to have an RTC
and does not ack data written to it.
The vendor kernel happily ignores write errors, using
I2C via userspace i2c-set also shows the error.
So add a quirk to ignore that error.

PWM can be successfully configured despite of that error.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/ntxec.c       | 57 ++++++++++++++++++++++++++++++++++++---
 include/linux/mfd/ntxec.h |  1 +
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
index 957de2b03529..e7fe570127af 100644
--- a/drivers/mfd/ntxec.c
+++ b/drivers/mfd/ntxec.c
@@ -96,6 +96,36 @@ static struct notifier_block ntxec_restart_handler = {
 	.priority = 128,
 };
 
+static int regmap_ignore_write(void *context,
+			       unsigned int reg, unsigned int val)
+
+{
+	struct regmap *regmap = context;
+
+	regmap_write(regmap, reg, val);
+
+	return 0;
+}
+
+static int regmap_wrap_read(void *context, unsigned int reg,
+			    unsigned int *val)
+{
+	struct regmap *regmap = context;
+
+	return regmap_read(regmap, reg, val);
+}
+
+/* some firmware versions do not ack written data, add a wrapper */
+static const struct regmap_config regmap_config_noack = {
+	.name = "ntxec_noack",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.cache_type = REGCACHE_NONE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.reg_write = regmap_ignore_write,
+	.reg_read = regmap_wrap_read
+};
+
 static const struct regmap_config regmap_config = {
 	.name = "ntxec",
 	.reg_bits = 8,
@@ -109,10 +139,15 @@ static const struct mfd_cell ntxec_subdevices[] = {
 	{ .name = "ntxec-pwm" },
 };
 
+static const struct mfd_cell ntxec_subdev_pwm[] = {
+	{ .name = "ntxec-pwm" },
+};
+
 static int ntxec_probe(struct i2c_client *client)
 {
 	struct ntxec *ec;
 	unsigned int version;
+	bool has_rtc;
 	int res;
 
 	ec = devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
@@ -137,6 +172,15 @@ static int ntxec_probe(struct i2c_client *client)
 	/* Bail out if we encounter an unknown firmware version */
 	switch (version) {
 	case NTXEC_VERSION_KOBO_AURA:
+		has_rtc = true;
+		break;
+	case NTXEC_VERSION_TOLINO_SHINE2:
+		has_rtc = false;
+		ec->regmap = devm_regmap_init(ec->dev, NULL,
+					      ec->regmap,
+					      &regmap_config_noack);
+		if (IS_ERR(ec->regmap))
+			return PTR_ERR(ec->regmap);
 		break;
 	default:
 		dev_err(ec->dev,
@@ -155,7 +199,6 @@ static int ntxec_probe(struct i2c_client *client)
 		 */
 		res = regmap_write(ec->regmap, NTXEC_REG_POWERKEEP,
 				   NTXEC_POWERKEEP_VALUE);
-		if (res < 0)
 			return res;
 
 		if (poweroff_restart_client)
@@ -181,8 +224,16 @@ static int ntxec_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, ec);
 
-	res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE, ntxec_subdevices,
-				   ARRAY_SIZE(ntxec_subdevices), NULL, 0, NULL);
+	if (has_rtc)
+		res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
+					   ntxec_subdevices,
+					   ARRAY_SIZE(ntxec_subdevices),
+					   NULL, 0, NULL);
+	else
+		res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
+					   ntxec_subdev_pwm,
+					   ARRAY_SIZE(ntxec_subdev_pwm),
+					   NULL, 0, NULL);
 	if (res)
 		dev_err(ec->dev, "Failed to add subdevices: %d\n", res);
 
diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
index 361204d125f1..26ab3b8eb612 100644
--- a/include/linux/mfd/ntxec.h
+++ b/include/linux/mfd/ntxec.h
@@ -33,5 +33,6 @@ static inline __be16 ntxec_reg8(u8 value)
 
 /* Known firmware versions */
 #define NTXEC_VERSION_KOBO_AURA	0xd726	/* found in Kobo Aura */
+#define NTXEC_VERSION_TOLINO_SHINE2 0xf110 /* found in Tolino Shine 2 HD */
 
 #endif
-- 
2.29.2

