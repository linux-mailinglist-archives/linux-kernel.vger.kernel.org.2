Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3F41650B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbhIWSPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:15:47 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:39215 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242850AbhIWSPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:15:20 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8EBD6580C22;
        Thu, 23 Sep 2021 14:13:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Sep 2021 14:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=W2vt/ni/Vlnev
        gTBRJnpQCVB+O3xFToVGOylXkFQ9YU=; b=A0eP1zt6v/AyXyuq60Rltxuo1tOvK
        n+tTLXfoo9GfvTnFAxkqCyPMyJXiit0iImV55DPyEobsOsdkAh06ggC115uttXLx
        Yd0CB/QFrHYqSAE9EGDwNGL/VFtaCfqcE1zaCl3nsym5gt9k7Mt0IGNF41Pen/Cd
        Iu2Tu+jqrDRsqXqhDQS7zn+20PYvvqDS0YL+KqjEYNTs+Tco5VJoGg1cCzl93vCa
        GPAIfNxQfA4udVQRLF1AMzcUKrCx8BrAfWhiTQNdCoB/xgQNo21UMgQDe63u31RQ
        uZ3KoY4ORezz99DtDVDx0Cq4oj+JeTN+eT1MeGKXBjw3xB2q3rhR9GBqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=W2vt/ni/VlnevgTBRJnpQCVB+O3xFToVGOylXkFQ9YU=; b=Fz04b9bL
        FjI0rWHvm95gRFBW4xesij0SaOGHxEJvYXQ6Qogh5zUkLe+uAoBfwNy+H1YU49AC
        zN6rICMNfw+HfNB62f5NxnKzSu8ySPnu+1hxba7aubxjRlxyF3nFFK2JkdqhoAvN
        9Pcx6RfoR4UX1X7oEMyOHeScwwprW+KZIWsTj/9KSgOHZDdMKJu5qdNKqPMSKwgd
        AJhBWZhL25P1VNDI7G/rY3tzLhXuPRMg5EGeEDftZhfE2P9H0C6xZxMu09Z8jeqA
        Z+79gjBRfECqLX0imGFS9Fyv1HPZCRxxGcLflfbfTydQBL6HrFqZVleot5Cb8EsB
        eNTRfAF/mePF8Q==
X-ME-Sender: <xms:1sNMYRk1LxcUSpOzvmSuMM5WDe23XeiXs1xUiXpS9SHjyg88DZVniA>
    <xme:1sNMYc0t0DFjeCkWsnbOXh2J6QFsZpv-cj-813bGFAPFH2dSgWW1xkHLMS6gvP8yq
    bq0V6-vB-vuklN9A4U>
X-ME-Received: <xmr:1sNMYXoGJjWCpE8ysHWnUg1Yr_AihZXNJwkYkOkbfSGtWsTePw5jiDNngstFv-eM0vojAfCaznN2OPZA5vou-i9gd-hWb2kuwGcb3ar9gJ94wkDjA0BWlzI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeiledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
    jeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:1sNMYRnKXdTfgvhQB_6-tDCSmfwi7LU9RSXJiReUeVukwqxdaGm-rg>
    <xmx:1sNMYf1G0ej1Ag2a3DjHdEiXEksEXLw9JLzgO4ntjtdNuv_MW34HjQ>
    <xmx:1sNMYQskBX8CMO5q8jdAI0TUrw_CXPflP08eKz-TEncFY9PCroCi2A>
    <xmx:1sNMYYtPKP4hjLf6PGX2QuFecTSPTb6pyl8lNTKS01-Y9bNrxnECzg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Sep 2021 14:13:40 -0400 (EDT)
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
Subject: [PATCH v2 5/6] usb: typec: tipd: Switch CD321X power state to S0
Date:   Thu, 23 Sep 2021 20:13:20 +0200
Message-Id: <20210923181321.3044-6-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210923181321.3044-1-sven@svenpeter.dev>
References: <20210923181321.3044-1-sven@svenpeter.dev>
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
changes since v1:
  - dropped the supports_spss flag and only call this for the Apple chip
  - added Alyssa's r-b

 drivers/usb/typec/tipd/core.c     | 37 +++++++++++++++++++++++++++++++
 drivers/usb/typec/tipd/tps6598x.h |  6 +++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 6c9c8f19a1cf..20d9f89208ff 100644
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
@@ -159,6 +160,11 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
 	return regmap_raw_write(tps->regmap, reg, data, sizeof(data));
 }
 
+static inline int tps6598x_read8(struct tps6598x *tps, u8 reg, u8 *val)
+{
+	return tps6598x_block_read(tps, reg, val, sizeof(u8));
+}
+
 static inline int tps6598x_read16(struct tps6598x *tps, u8 reg, u16 *val)
 {
 	return tps6598x_block_read(tps, reg, val, sizeof(u16));
@@ -642,6 +648,32 @@ static int tps6598x_psy_get_prop(struct power_supply *psy,
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
@@ -727,6 +759,11 @@ static int tps6598x_probe(struct i2c_client *client)
 		return ret;
 
 	if (hw->type == HW_CD321X) {
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

