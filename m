Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0237F416505
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbhIWSPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:15:32 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:54761 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242705AbhIWSPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:15:12 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 877C5580C19;
        Thu, 23 Sep 2021 14:13:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Sep 2021 14:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=betWkUrF3piRF
        RLP5KIB9PXDwU+D6YFUO05OU6dg0UQ=; b=FfrOl/Ep+XpP+aX18HJw7ObcnM7Ws
        uLoFlFQLvXqGbmE46kdK2hB1h78bKVZqayxgJorBPA3moMK33OACN8PENjRjVq7f
        63dDAaBrkpKMOfMpbCPS7yZU1lGoYpMzw2DVGV5xhGC0bFkOH3S+V0CWcJAwAqY4
        5nQOoKhuYfPLX6LjUG7DoxkxV9gi5ee+g4pe+4SU/ir6odhD+La8xL6MItrSxuyA
        pCJitlrNyDkd7wHKeZ+fjTgBFX8xnIMqnwHDiEgzfPKAOpLGFwa0845Gtz35DLIl
        wjW09E/nxEz16MwzqjDvvtzvmzeGieJnrWqsCrBYy5P6O/Y1pA4lN/N6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=betWkUrF3piRFRLP5KIB9PXDwU+D6YFUO05OU6dg0UQ=; b=Ha7A7YNz
        qiiGz9fiudFWwfm2LhKTgzNjOvI3FK6YAzFkUZojpPKwkhwlqaCmkw2tq2ko61C2
        EO0nL0kfYuShGDAXDb6gceSANlmyZOtyRNeULmHwCoe71EoI8vYcZBrSYglfHcIP
        E6W1k4a2wXmMS6eskEQUr5V4PAWy5SeEnOjVtWckgVHvXyZdNooQBY5gGttQChR5
        vYnHNQNzdboJbbyC/5hY2C4x91f6wSvf4I6HV4o4zZyIXE6Al7Et0jWLqgwmYEVb
        lGo9E69W6vel5uS34DyQapRwxN5c9DGV6eTsUuYqTzQzk3xjQ+atADqI36Kcfmcn
        DvaKOq9MW/1WHQ==
X-ME-Sender: <xms:1MNMYY_agnfFNrz1T9rMk53n49RJ-WwUmw5Bzi-1_knPqFlSLypQCg>
    <xme:1MNMYQul3TiqQkZIFMuw3jSYdW7ufpaWn8Mn762e2j-bg25MHaga13XTrWnAKDGuf
    Psu5WL8EDhQgU1pUuo>
X-ME-Received: <xmr:1MNMYeB_KwDKnpvTJiOGRFh3DeqO5BsdM0uyke0OdAEBj6JuX99wjXH3_mCxqAHz0MqUsr_thVmGmdPUJC44m04CPV6DBqEnqX0Q_utX7GkMnQanfiO25e4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeiledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:1MNMYYcezI4Pm7HoSjS72BrItfgJzjrB9-fMlKhGiI9i7rTvZ55fZg>
    <xmx:1MNMYdMNDqNyk-Nd7rhXv-tL6aT6phOJk5AbVF0uOk50kopcNhZ02A>
    <xmx:1MNMYSkR0kbVpPMhn2WQV7SCkfUK4w0KoRvnQQPi0XvH_zeCEC-gTw>
    <xmx:1MNMYSnAogQqmDu4zSUFXd9-syjTp8D7uLPorj22XiL2g7uC7wPOhA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Sep 2021 14:13:38 -0400 (EDT)
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
Subject: [PATCH v2 4/6] usb: typec: tipd: Add support for Apple CD321X
Date:   Thu, 23 Sep 2021 20:13:19 +0200
Message-Id: <20210923181321.3044-5-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210923181321.3044-1-sven@svenpeter.dev>
References: <20210923181321.3044-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple CD321x chips are a variant of the TI TPS 6598x chips.
The major differences are the changed interrupt numbers and
the concurrent connection to the SMC which we must not disturb.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
changes since v1:
  - new commit since Heikki suggested to just add a separate irq handler

 drivers/usb/typec/tipd/core.c     | 86 ++++++++++++++++++++++++++++++-
 drivers/usb/typec/tipd/tps6598x.h |  6 +++
 drivers/usb/typec/tipd/trace.h    | 23 +++++++++
 3 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index cd1e37eb8a0c..6c9c8f19a1cf 100644
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
@@ -76,6 +77,16 @@ static const char *const modes[] = {
 /* Unrecognized commands will be replaced with "!CMD" */
 #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
 
+enum tipd_hw_type {
+	HW_TPS6598X,
+	HW_CD321X
+};
+
+struct tipd_hw {
+	enum tipd_hw_type type;
+	irq_handler_t irq_handler;
+};
+
 struct tps6598x {
 	struct device *dev;
 	struct regmap *regmap;
@@ -458,6 +469,51 @@ static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
 	}
 }
 
+static irqreturn_t cd321x_interrupt(int irq, void *data)
+{
+	struct tps6598x *tps = data;
+	u64 event = 0;
+	u32 status;
+	int ret;
+
+	mutex_lock(&tps->lock);
+
+	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event);
+	if (ret) {
+		dev_err(tps->dev, "%s: failed to read events\n", __func__);
+		goto err_unlock;
+	}
+	trace_cd321x_irq(event);
+
+	if (!event)
+		goto err_unlock;
+
+	if (!tps6598x_read_status(tps, &status))
+		goto err_clear_ints;
+
+	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE)
+		if (!tps6598x_read_power_status(tps))
+			goto err_clear_ints;
+
+	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
+		if (!tps6598x_read_data_status(tps))
+			goto err_clear_ints;
+
+	/* Handle plug insert or removal */
+	if (event & APPLE_CD_REG_INT_PLUG_EVENT)
+		tps6598x_handle_plug_event(tps, status);
+
+err_clear_ints:
+	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event);
+
+err_unlock:
+	mutex_unlock(&tps->lock);
+
+	if (event)
+		return IRQ_HANDLED;
+	return IRQ_NONE;
+}
+
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
@@ -615,8 +671,19 @@ static int devm_tps6598_psy_register(struct tps6598x *tps)
 	return PTR_ERR_OR_ZERO(tps->psy);
 }
 
+static const struct tipd_hw ti_tps6598x_data = {
+	.type = HW_TPS6598X,
+	.irq_handler = tps6598x_interrupt,
+};
+
+static const struct tipd_hw apple_cd321x_data = {
+	.type = HW_CD321X,
+	.irq_handler = cd321x_interrupt,
+};
+
 static int tps6598x_probe(struct i2c_client *client)
 {
+	const struct tipd_hw *hw;
 	struct typec_capability typec_cap = { };
 	struct tps6598x *tps;
 	struct fwnode_handle *fwnode;
@@ -629,6 +696,10 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (!tps)
 		return -ENOMEM;
 
+	hw = of_device_get_match_data(&client->dev);
+	if (!hw)
+		hw = &ti_tps6598x_data;
+
 	mutex_init(&tps->lock);
 	tps->dev = &client->dev;
 
@@ -655,6 +726,16 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	if (hw->type == HW_CD321X) {
+		/* CD321X chips have all interrupts masked initially */
+		ret = tps6598x_write64(tps, TPS_REG_INT_MASK1,
+					APPLE_CD_REG_INT_POWER_STATUS_UPDATE |
+					APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
+					APPLE_CD_REG_INT_PLUG_EVENT);
+		if (ret)
+			return ret;
+	}
+
 	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
 	if (ret < 0)
 		return ret;
@@ -736,7 +817,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	}
 
 	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-					tps6598x_interrupt,
+					hw->irq_handler,
 					IRQF_SHARED | IRQF_ONESHOT,
 					dev_name(&client->dev), tps);
 	if (ret) {
@@ -769,7 +850,8 @@ static int tps6598x_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id tps6598x_of_match[] = {
-	{ .compatible = "ti,tps6598x", },
+	{ .compatible = "ti,tps6598x", .data = &ti_tps6598x_data },
+	{ .compatible = "apple,cd321x", .data = &apple_cd321x_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6598x_of_match);
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 003a577be216..e13b16419843 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -129,6 +129,12 @@
 #define TPS_REG_INT_HARD_RESET				BIT(1)
 #define TPS_REG_INT_PD_SOFT_RESET			BIT(0)
 
+/* Apple-specific TPS_REG_INT_* bits */
+#define APPLE_CD_REG_INT_DATA_STATUS_UPDATE		BIT(10)
+#define APPLE_CD_REG_INT_POWER_STATUS_UPDATE		BIT(9)
+#define APPLE_CD_REG_INT_STATUS_UPDATE			BIT(8)
+#define APPLE_CD_REG_INT_PLUG_EVENT			BIT(1)
+
 /* TPS_REG_POWER_STATUS bits */
 #define TPS_POWER_STATUS_CONNECTION(x)  TPS_FIELD_GET(BIT(0), (x))
 #define TPS_POWER_STATUS_SOURCESINK(x)	TPS_FIELD_GET(BIT(1), (x))
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index 5d09d6f78930..12cad1bde7cc 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -67,6 +67,13 @@
 		{ TPS_REG_INT_USER_VID_ALT_MODE_ATTN_VDM,	"USER_VID_ALT_MODE_ATTN_VDM" }, \
 		{ TPS_REG_INT_USER_VID_ALT_MODE_OTHER_VDM,	"USER_VID_ALT_MODE_OTHER_VDM" })
 
+#define show_cd321x_irq_flags(flags) \
+	__print_flags_u64(flags, "|", \
+		{ APPLE_CD_REG_INT_PLUG_EVENT,			"PLUG_EVENT" }, \
+		{ APPLE_CD_REG_INT_POWER_STATUS_UPDATE,		"POWER_STATUS_UPDATE" }, \
+		{ APPLE_CD_REG_INT_DATA_STATUS_UPDATE,		"DATA_STATUS_UPDATE" }, \
+		{ APPLE_CD_REG_INT_STATUS_UPDATE,		"STATUS_UPDATE" })
+
 #define TPS6598X_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
 						      TPS_STATUS_PP_5V0_SWITCH_MASK | \
 						      TPS_STATUS_PP_HV_SWITCH_MASK | \
@@ -207,6 +214,22 @@ TRACE_EVENT(tps6598x_irq,
 		      show_irq_flags(__entry->event2))
 );
 
+TRACE_EVENT(cd321x_irq,
+	    TP_PROTO(u64 event),
+	    TP_ARGS(event),
+
+	    TP_STRUCT__entry(
+			     __field(u64, event)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->event = event;
+			   ),
+
+	    TP_printk("event=%s",
+		      show_cd321x_irq_flags(__entry->event))
+);
+
 TRACE_EVENT(tps6598x_status,
 	    TP_PROTO(u32 status),
 	    TP_ARGS(status),
-- 
2.25.1

