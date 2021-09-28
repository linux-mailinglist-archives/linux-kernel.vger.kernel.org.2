Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D0A41B35F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbhI1P5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:57:17 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:41283 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241752AbhI1P5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:57:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0E32D580C24;
        Tue, 28 Sep 2021 11:55:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 28 Sep 2021 11:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=el0Ghx2FjFtB4
        v+opko3bnJzQlzA9KABqsDUbou/TtY=; b=I7UAbzZ3uh71zZ7uUS0v7/Z69Ny9/
        huTi+jRTKuimbrf6Zqw2lcuOos+Ta7kCbGakC73cAhcMOhbWwbwkrwSdf7ucAX7I
        MbGAwywOTUVPrwjErFB/Umlgm1mWXvxB0/aqXX9SmwBSxNYHidtA9m9yMyxLvUep
        Zl7Ej14YoU6LYPYCfrZrPXc2gBDNCSHn7OtlyolZ2yQCxfcSdYB4KAPDrplGgi1r
        yh9wxdleMMFufoGHEfU0SBA6AjouGo0khdZqNbPdvvYc6EtF0xg/fPYGRaoWxr9i
        02P8ApbS59noGswzc8C1+fieJbGFCqeBabMu7ZHnxEjmqWB5yGeuIuX7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=el0Ghx2FjFtB4v+opko3bnJzQlzA9KABqsDUbou/TtY=; b=M6uFW5QP
        m8Hl7PSrrhy9khl60+ww6srTpdd1GDJtVDR2m092eud/XOi+IJaWGgM/K3ZSoEpg
        0TXFjeYPOV84U4veVqTCLX+btrTo/zaZk7uiqdl5sCyxuKRlCF97OxTC+N549ApN
        TkByzwNybAE+sLfVjVVH+MgkEVNNHhhQHRqCzCWom9umgEZIB/MVnG4riVRa0g3x
        yyxPOOJVLCZ8ey3637ddRWc4m0uew4JcngkaobWgm2ms1VZmjGmRfqnPw5Jn4VWW
        ark6WpNaphOeTxPRsJ9PQ4s8MjmBeGb5kt5D8pkCSP2N8rPNa7l8DSzKYYEVJgSj
        YxaTkq/xEWxpeQ==
X-ME-Sender: <xms:8TpTYRakJMR-7EwSKzzl4j77zJqaLb7IFQ5mbQLIHX3VacTRJG9mGA>
    <xme:8TpTYYa9Qw9eW8kKs5e9kcNjrOacoFVvl1rU_my6Ag9eajRpE-fhSg01n9Fsk0WGZ
    amYZAAzAnj1u2TAYhY>
X-ME-Received: <xmr:8TpTYT9uBj-Xx6UQh35LoQ3H5DCUTPkhGIsK_WDG0KqjfpRq-errBejIGw7vUwEjEGLY26OfSkZLG2By86KZQdakvR6sVexhgYrjDAB72r4l2FhVleo8IgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:8TpTYfr2wCVNv-V4Vf07dQMX6uE2A2p2nSOH6cQGUsvPzE1IZDCBYw>
    <xmx:8TpTYcqIySeGAPBeMnD-1mRlnC628q8IQFK1_FDlQTO2-BweO9F78Q>
    <xmx:8TpTYVRW08iKFs1tsqcTwQhAT9RFWLMF35F3q8A60qdaxxnuQsb0sA>
    <xmx:8jpTYRSm-4DSATIF8-PS0iriD4ynNKjZ3rwaxLdNB6n_c1hGhc9G-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 11:55:27 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH v3 5/6] usb: typec: tipd: Switch CD321X power state to S0
Date:   Tue, 28 Sep 2021 17:55:01 +0200
Message-Id: <20210928155502.71372-6-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210928155502.71372-1-sven@svenpeter.dev>
References: <20210928155502.71372-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Apple CD321x comes up in a low-power state after boot. Usually, the
bootloader will already power it up to S0 but let's do it here as well
in case that didn't happen.

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Suggested-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
no changes since v2

changes since v1:
  - dropped the supports_spss flag and only call this for the Apple chip
  - added Alyssa's r-b

 drivers/usb/typec/tipd/core.c     | 37 +++++++++++++++++++++++++++++++
 drivers/usb/typec/tipd/tps6598x.h |  6 +++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index cc4a154eabcb..c74fc9ae1686 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -30,6 +30,7 @@
 #define TPS_REG_INT_MASK2		0x17
 #define TPS_REG_INT_CLEAR1		0x18
 #define TPS_REG_INT_CLEAR2		0x19
+#define TPS_REG_SYSTEM_POWER_STATE	0x20
 #define TPS_REG_STATUS			0x1a
 #define TPS_REG_SYSTEM_CONF		0x28
 #define TPS_REG_CTRL_CONF		0x29
@@ -152,6 +153,11 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
 	return regmap_raw_write(tps->regmap, reg, data, len + 1);
 }
 
+static inline int tps6598x_read8(struct tps6598x *tps, u8 reg, u8 *val)
+{
+	return tps6598x_block_read(tps, reg, val, sizeof(u8));
+}
+
 static inline int tps6598x_read16(struct tps6598x *tps, u8 reg, u16 *val)
 {
 	return tps6598x_block_read(tps, reg, val, sizeof(u16));
@@ -635,6 +641,32 @@ static int tps6598x_psy_get_prop(struct power_supply *psy,
 	return ret;
 }
 
+static int cd321x_switch_power_state(struct tps6598x *tps, u8 target_state)
+{
+	u8 state;
+	int ret;
+
+	ret = tps6598x_read8(tps, TPS_REG_SYSTEM_POWER_STATE, &state);
+	if (ret)
+		return ret;
+
+	if (state == target_state)
+		return 0;
+
+	ret = tps6598x_exec_cmd(tps, "SPSS", sizeof(u8), &target_state, 0, NULL);
+	if (ret)
+		return ret;
+
+	ret = tps6598x_read8(tps, TPS_REG_SYSTEM_POWER_STATE, &state);
+	if (ret)
+		return ret;
+
+	if (state != target_state)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int devm_tps6598_psy_register(struct tps6598x *tps)
 {
 	struct power_supply_config psy_cfg = {};
@@ -707,6 +739,11 @@ static int tps6598x_probe(struct i2c_client *client)
 		return ret;
 
 	if (np && of_device_is_compatible(np, "apple,cd321x")) {
+		/* Switch CD321X chips to the correct system power state */
+		ret = cd321x_switch_power_state(tps, TPS_SYSTEM_POWER_STATE_S0);
+		if (ret)
+			return ret;
+
 		/* CD321X chips have all interrupts masked initially */
 		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
 					APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index e13b16419843..3dae84c524fb 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -135,6 +135,12 @@
 #define APPLE_CD_REG_INT_STATUS_UPDATE			BIT(8)
 #define APPLE_CD_REG_INT_PLUG_EVENT			BIT(1)
 
+/* TPS_REG_SYSTEM_POWER_STATE states */
+#define TPS_SYSTEM_POWER_STATE_S0	0x00
+#define TPS_SYSTEM_POWER_STATE_S3	0x03
+#define TPS_SYSTEM_POWER_STATE_S4	0x04
+#define TPS_SYSTEM_POWER_STATE_S5	0x05
+
 /* TPS_REG_POWER_STATUS bits */
 #define TPS_POWER_STATUS_CONNECTION(x)  TPS_FIELD_GET(BIT(0), (x))
 #define TPS_POWER_STATUS_SOURCESINK(x)	TPS_FIELD_GET(BIT(1), (x))
-- 
2.25.1

