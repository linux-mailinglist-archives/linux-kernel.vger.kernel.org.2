Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1F241063D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbhIRMLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:11:52 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48365 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239714AbhIRMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:11:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 45E89580A72;
        Sat, 18 Sep 2021 08:09:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 18 Sep 2021 08:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Zl0M3noJyP6W0
        KWYI2clzOswdVoMc4ztCazBkMGp5No=; b=FqDnVrrOY94i3k7empvp2H8Zh+a7R
        eKm1SUBH3IHi5L9q7fg++nNC8r1lCfvJoSyJUUV0gVf8nLBERaBdIq7Ng8Zm7GrE
        ixzjevx14T/7m4EuqkzJoN8eRsHI4RSvemDcOz1psXGXR8vJSKKodPoZyOZdfAv4
        3XLiPYok/d8YWx3t7PAPHhZ5K/YHS1YS+WZ8GtZErzLDF5WUaoFh6XX9VEp0bR9d
        LQzq3P6g4W/7MKQTLweKDz+iSolPm2QO0LsdpcvOPaCftgo+47DZMahyIUP98BeK
        3YffI0Uv9X50fTG20d3OMgap5rp6AKVy61O2TgDRiF6FytS4+hasmjCnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Zl0M3noJyP6W0KWYI2clzOswdVoMc4ztCazBkMGp5No=; b=Cod01H4i
        XEezzDI0TfylfE+iJvRnxiGeOKSuNGhSbn7AudHQhhVwVEypGMGwlefNQgUXWPdc
        eFgNYNGcRHJ9qxTVee81JKtdjTyVRYNQSnW+A7igCskXvaJrLMVa3QkEB202CfF+
        hKiM2l3miLiRjkQgDyBEVLayYlEoLITrK1g7HVEkrNB6CnPVx6TwoSRp/baUi1aA
        DjBeGscJuM3A2nGy6FNFUOC7SRmue4gkZJq+VYIHFa9ClwmCcxic5A5q3S1AB+3i
        lrDZd5f+ZPwAxvO6djq8ha8WavnSAj6LT0xfT65+A5AHuuWJ/isGk4dOG6JxXSiO
        4gyP+le49fbniQ==
X-ME-Sender: <xms:FNdFYfxfpJQyYuVP6LdTeUj5fHWi73AgOMWAPR_mYkWOPH8q0OerxQ>
    <xme:FNdFYXRif0Tloj0fuORmm-NHB8hgzuOM9APmJomCEPRwZVfLHzemKWozFk3DLjhcv
    lKDVf4CcIP6r_OoeDo>
X-ME-Received: <xmr:FNdFYZV7Ae_ITSMF3AesWTiOmAk8sw0bSTM9cNyyj3ByBdwjJRx-0IlIJ2f7UmQ40WbIZqHIPYRPaM2nlqFgsWZ8bAyqfQ9zlU2DyJlZygaXOkrUU_AYwfP5Ugak5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:FNdFYZjo6IADpRHk6xplNKlc_HV06WN6f23hJR1ovbFU2bVJ5DIPKg>
    <xmx:FNdFYRBdh5zbAN3iY7bRxH9oPBdxD5RfHEGeSBjj-8uQQkUWWHrr8w>
    <xmx:FNdFYSKc5W5MQv7nlyN_54VJtbtAMl0CPq1OaA816JITJCQcUv8OiA>
    <xmx:FNdFYWL7grFBWnhL8bsRRZZpXvUNlapDqanA_CRlfqyG-xyrRYnbBA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Sep 2021 08:09:54 -0400 (EDT)
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
Subject: [RFT PATCH 2/9] usb: typec: tipd: Prepare supporting different variants
Date:   Sat, 18 Sep 2021 14:09:27 +0200
Message-Id: <20210918120934.28252-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210918120934.28252-1-sven@svenpeter.dev>
References: <20210918120934.28252-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple M1 machines come with a variant of the TI TPS6598x and will need
some changes to the current logic. Let's prepare for that by setting up
the infrastructure required to support different variants of this chip
identified by the DT compatible.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 21b3ae25c76d..656020e7f533 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -9,6 +9,7 @@
 #include <linux/i2c.h>
 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/interrupt.h>
@@ -76,6 +77,10 @@ static const char *const modes[] = {
 /* Unrecognized commands will be replaced with "!CMD" */
 #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
 
+struct tps6598x_hw {
+};
+static const struct tps6598x_hw ti_tps6598x_data;
+
 struct tps6598x {
 	struct device *dev;
 	struct regmap *regmap;
@@ -91,6 +96,8 @@ struct tps6598x {
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	enum power_supply_usb_type usb_type;
+
+	const struct tps6598x_hw *hw;
 };
 
 static enum power_supply_property tps6598x_psy_props[] = {
@@ -590,6 +597,13 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (!tps)
 		return -ENOMEM;
 
+	if (client->dev.of_node)
+		tps->hw = of_device_get_match_data(&client->dev);
+	else
+		tps->hw = &ti_tps6598x_data;
+	if (!tps->hw)
+		return -EINVAL;
+
 	mutex_init(&tps->lock);
 	tps->dev = &client->dev;
 
@@ -729,8 +743,11 @@ static int tps6598x_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct tps6598x_hw ti_tps6598x_data = {
+};
+
 static const struct of_device_id tps6598x_of_match[] = {
-	{ .compatible = "ti,tps6598x", },
+	{ .compatible = "ti,tps6598x", .data = &ti_tps6598x_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6598x_of_match);
-- 
2.25.1

