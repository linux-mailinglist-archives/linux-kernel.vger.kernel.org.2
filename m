Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9633C6AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhCOTSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhCOTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:18:37 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2B6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jZmOaTXneS/gkFmYB6NTqg1LICHCjyHhRmKndRI5egE=; b=ltrfEKbkUCSW2J+nr2wzIkvffY
        ftEZ3/26MDy8l4rlbJ1IIcJ6y4RBgEF3MlnPfixCICILaM4zy02D+8FMiyb1S/LF3iSYs9lHPSLTt
        nrxWXFfHNEzBeIoQeQ0J5AiElnzLmbLQ42eBTeQelZmKK9dCuuqX/51MkU3qBHLVEQZE=;
Received: from p200300ccff0cb7001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:b700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lLsjZ-0005TE-Jq; Mon, 15 Mar 2021 20:18:33 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lLsjZ-0004OR-8R; Mon, 15 Mar 2021 20:18:33 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     j.neuschaefer@gmx.net, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Date:   Mon, 15 Mar 2021 20:18:32 +0100
Message-Id: <20210315191832.16842-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
Changes in v4:
- rename subdevices back to v2 (suggested by Jonathan)
- initialize subdevs in switch

Changes in v3:
- remove have_rtc variable
- rename subdevices again

Changes in v2:
- more comments about stacking regmap construction
- fix accidential line removal
- better naming for subdevices

 drivers/mfd/ntxec.c       | 56 ++++++++++++++++++++++++++++++++++++---
 include/linux/mfd/ntxec.h |  1 +
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
index 957de2b03529..b711e73eedcb 100644
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
@@ -104,16 +136,22 @@ static const struct regmap_config regmap_config = {
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
 	int res;
+	const struct mfd_cell *subdevs;
+	size_t n_subdevs;
 
 	ec = devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
 	if (!ec)
@@ -137,6 +175,18 @@ static int ntxec_probe(struct i2c_client *client)
 	/* Bail out if we encounter an unknown firmware version */
 	switch (version) {
 	case NTXEC_VERSION_KOBO_AURA:
+		subdevs = ntxec_subdev;
+		n_subdevs = ARRAY_SIZE(ntxec_subdev);
+		break;
+	case NTXEC_VERSION_TOLINO_SHINE2:
+		subdevs = ntxec_subdev_pwm;
+		n_subdevs = ARRAY_SIZE(ntxec_subdev_pwm);
+		/* Another regmap stacked on top of the other */
+		ec->regmap = devm_regmap_init(ec->dev, NULL,
+					      ec->regmap,
+					      &regmap_config_noack);
+		if (IS_ERR(ec->regmap))
+			return PTR_ERR(ec->regmap);
 		break;
 	default:
 		dev_err(ec->dev,
@@ -181,8 +231,8 @@ static int ntxec_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, ec);
 
-	res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE, ntxec_subdevices,
-				   ARRAY_SIZE(ntxec_subdevices), NULL, 0, NULL);
+	res = devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
+				   subdevs, n_subdevs, NULL, 0, NULL);
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

