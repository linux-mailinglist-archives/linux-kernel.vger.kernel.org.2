Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4F2331960
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCHVaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCHVaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:30:06 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B776C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 13:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6e4TxBJqPMTOigrSIxiWvu5Ej/RTQsuzC2ZiuBMKGrk=; b=QO+Dtv3jNG8u9OqfAmQW0u1j5l
        Xy5qyZ37ueaQB56IZjNXTilk7l0UCVJOxGdSx7qSqD7buS3QbS0GjwnZOgfgUL9rmWJgxSWRsbnDl
        PkLlzr5Y04oLFbcM4+yGEkxZX+zxCJOntJXU+nzjn5EUKGZ4bL9SU/L1ijiAzhQPEA88=;
Received: from p200300ccff0c53001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:5300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lJNRu-0002kk-BO; Mon, 08 Mar 2021 22:29:58 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lJNRt-0005Pr-3R; Mon, 08 Mar 2021 22:29:57 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     j.neuschaefer@gmx.net, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Date:   Mon,  8 Mar 2021 22:29:52 +0100
Message-Id: <20210308212952.20774-1-andreas@kemnade.info>
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
Changes in v2:
- more comments about stacking regmap construction
- fix accidential line removal
- better naming for subdevices

 drivers/mfd/ntxec.c       | 61 +++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/ntxec.h |  1 +
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
index 957de2b03529..0bbd2e34e89c 100644
--- a/drivers/mfd/ntxec.c
+++ b/drivers/mfd/ntxec.c
@@ -96,6 +96,38 @@ static struct notifier_block ntxec_restart_handler = {
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
+/*
+ * Some firmware versions do not ack written data, add a wrapper. It
+ * is used to stack another regmap on top.
+ */
+static const struct regmap_config regmap_config_noack = {
+	.name = "ntxec_noack",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.cache_type = REGCACHE_NONE,
+	.reg_write = regmap_ignore_write,
+	.reg_read = regmap_wrap_read
+};
+
 static const struct regmap_config regmap_config = {
 	.name = "ntxec",
 	.reg_bits = 8,
@@ -104,15 +136,20 @@ static const struct regmap_config regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 };
 
-static const struct mfd_cell ntxec_subdevices[] = {
+static const struct mfd_cell ntxec_subdev[] = {
 	{ .name = "ntxec-rtc" },
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
@@ -137,6 +174,16 @@ static int ntxec_probe(struct i2c_client *client)
 	/* Bail out if we encounter an unknown firmware version */
 	switch (version) {
 	case NTXEC_VERSION_KOBO_AURA:
+		has_rtc = true;
+		break;
+	case NTXEC_VERSION_TOLINO_SHINE2:
+		has_rtc = false;
+		/* Another regmap stacked on top of the other */
+		ec->regmap = devm_regmap_init(ec->dev, NULL,
+					      ec->regmap,
+					      &regmap_config_noack);
+		if (IS_ERR(ec->regmap))
+			return PTR_ERR(ec->regmap);
 		break;
 	default:
 		dev_err(ec->dev,
@@ -181,8 +228,16 @@ static int ntxec_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, ec);
 
-	res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE, ntxec_subdevices,
-				   ARRAY_SIZE(ntxec_subdevices), NULL, 0, NULL);
+	if (has_rtc)
+		res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
+					   ntxec_subdev,
+					   ARRAY_SIZE(ntxec_subdev),
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

