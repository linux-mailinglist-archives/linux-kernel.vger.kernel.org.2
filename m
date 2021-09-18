Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385EF410648
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbhIRMMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:12:34 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43569 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239663AbhIRMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:11:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id C5A3C580AA9;
        Sat, 18 Sep 2021 08:10:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 18 Sep 2021 08:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=y9rOI/pQW3cZW
        IrfzVD6SZvXz7mjEgJOkBwidzpAln8=; b=dAXg6zkFdhDPJgsSJJlhedcnXOtTh
        rJLRxNRcsDczpgbKh9k0gtEMttPLut962ZE8I4wHOTo5BNtzBlQ1NG+djj/y/aLF
        PzisQXS42CptOSO2v7JP1kCT9Av3ptKZ1QjTl+VpItHCYKGuv3PAlcAabngYXCq4
        4rLGKap5qyMOxwg3I7VDTgZs0d97JyAPz8+/kxOkMTiaNM8bJuWAF2p2VQ6CIGiQ
        jnZ5IrbtIe1MuOoJMLB8SKKhJc6DT8aDAPfncqVEIyLXk780mdB9pUiolTugQvc0
        F4/GzOsHUGQxq+StUJquSOxtXRraPcr7F3TaN3I6j8evJ01hkCcb0H40g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=y9rOI/pQW3cZWIrfzVD6SZvXz7mjEgJOkBwidzpAln8=; b=wEhpyerK
        tf73vMvPMmBzW2AWjccTGInw5JZNjnjagYr6sMUdsKxsSUtEjksa9FwY0zh2yQoU
        CgV2DRD69KVrbrljuLAVxUOZd7hte6ge/0K3TCJz8/1bvVhZikESkJabMInh3Ivl
        qUfdApBYjYqKM2smq7nQA3ehXc+vFo3EIHUy2ci4cda7zGdci6lSdN/fp7mtpBcw
        5ixw22vPD08gO3JaIHkzCupBw8CmZtQHbciNvHBE3v5YiQSL2uTBg4gL3APwwCPL
        as93/ERPiFX6xMJJCx9wU/1VRGtHCWb6fHC+YUS+YSAo9qkhllB2TJKkbcZefRIt
        YKm4PTHcnVTfGQ==
X-ME-Sender: <xms:HtdFYd1DbugMQcAnOnNbnnG4M53K9AkSNwNJvm4cHCBjRXthzxJ0kg>
    <xme:HtdFYUGPnYUo6fyxqZgt7GQT2uJ_8boTpwrAeJYQNzF8priTk5B3JKnf2djhi9dG7
    PA1POtlYd4CmosZMKU>
X-ME-Received: <xmr:HtdFYd68FtgXywVxXqnh7mwf0Gus1h8lF5BZvsHMI9PSI5NXKKyatSdae1vgrD7BpjD-IqnbOkdRjGTdP4UOAQE0L7KVCJt1Iu7_9XdA2lcZsy5A0_zFG5yGMIwy7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:HtdFYa1K6VQhu8BnZBR-ymEdaDKcsHcYJ-cB75oX5gxHVJ997OLnDA>
    <xmx:HtdFYQH-K9pvqv84nFyZw-My1OrE5OWiZLhL-qr89pG1PFKgXNxxaA>
    <xmx:HtdFYb-owvKVnp_ZXyj41tQmlZq_gL81wj7CC1FxyO8cex_5-8pskw>
    <xmx:HtdFYT9p4H3OgZWoTYFTKotqDjcfLRQUySsi106bDCgYL1KyXVAeIw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Sep 2021 08:10:04 -0400 (EDT)
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
Subject: [RFT PATCH 7/9] usb: typec: tipd: Add support for apple,cd321x
Date:   Sat, 18 Sep 2021 14:09:32 +0200
Message-Id: <20210918120934.28252-8-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210918120934.28252-1-sven@svenpeter.dev>
References: <20210918120934.28252-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After all the preparations in the previous commits we can now finally
add support for the Apple CD321x chip which is a variant of the TI TPS
6598x chip. The major differences are the changed interrupt numbers and
the concurrent connection to the SMC which we must not disturb.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c     | 10 ++++++++++
 drivers/usb/typec/tipd/tps6598x.h |  6 ++++++
 drivers/usb/typec/tipd/trace.h    | 27 +++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 2058e8cca631..e96b17fe6af6 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -788,8 +788,18 @@ static const struct tps6598x_hw ti_tps6598x_data = {
 	.irq_trace = trace_tps6598x_irq,
 };
 
+static const struct tps6598x_hw apple_cd321x_data = {
+	.use_int1 = true,
+	.use_int2 = false,
+	.irq_power_status_update = APPLE_TPS_REG_INT_POWER_STATUS_UPDATE,
+	.irq_data_status_update = APPLE_TPS_REG_INT_DATA_STATUS_UPDATE,
+	.irq_plug_event = APPLE_TPS_REG_INT_PLUG_EVENT,
+	.irq_trace = trace_cd321x_irq,
+};
+
 static const struct of_device_id tps6598x_of_match[] = {
 	{ .compatible = "ti,tps6598x", .data = &ti_tps6598x_data },
+	{ .compatible = "apple,cd321x", .data = &apple_cd321x_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tps6598x_of_match);
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 003a577be216..36b482733297 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -129,6 +129,12 @@
 #define TPS_REG_INT_HARD_RESET				BIT(1)
 #define TPS_REG_INT_PD_SOFT_RESET			BIT(0)
 
+/* Apple-specific TPS_REG_INT_* bits */
+#define APPLE_TPS_REG_INT_DATA_STATUS_UPDATE		BIT(10)
+#define APPLE_TPS_REG_INT_POWER_STATUS_UPDATE		BIT(9)
+#define APPLE_TPS_REG_INT_STATUS_UPDATE			BIT(8)
+#define APPLE_TPS_REG_INT_PLUG_EVENT			BIT(1)
+
 /* TPS_REG_POWER_STATUS bits */
 #define TPS_POWER_STATUS_CONNECTION(x)  TPS_FIELD_GET(BIT(0), (x))
 #define TPS_POWER_STATUS_SOURCESINK(x)	TPS_FIELD_GET(BIT(1), (x))
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index 5d09d6f78930..090633a1ae1d 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -67,6 +67,13 @@
 		{ TPS_REG_INT_USER_VID_ALT_MODE_ATTN_VDM,	"USER_VID_ALT_MODE_ATTN_VDM" }, \
 		{ TPS_REG_INT_USER_VID_ALT_MODE_OTHER_VDM,	"USER_VID_ALT_MODE_OTHER_VDM" })
 
+#define show_cd321x_irq_flags(flags) \
+	__print_flags_u64(flags, "|", \
+		{ APPLE_TPS_REG_INT_PLUG_EVENT,			"PLUG_EVENT" }, \
+		{ APPLE_TPS_REG_INT_POWER_STATUS_UPDATE,	"POWER_STATUS_UPDATE" }, \
+		{ APPLE_TPS_REG_INT_STATUS_UPDATE,		"DATA_STATUS_UPDATE" }, \
+		{ APPLE_TPS_REG_INT_PLUG_EVENT,			"STATUS_UPDATE" })
+
 #define TPS6598X_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
 						      TPS_STATUS_PP_5V0_SWITCH_MASK | \
 						      TPS_STATUS_PP_HV_SWITCH_MASK | \
@@ -207,6 +214,26 @@ TRACE_EVENT(tps6598x_irq,
 		      show_irq_flags(__entry->event2))
 );
 
+TRACE_EVENT(cd321x_irq,
+	    TP_PROTO(u64 event1,
+		     u64 event2),
+	    TP_ARGS(event1, event2),
+
+	    TP_STRUCT__entry(
+			     __field(u64, event1)
+			     __field(u64, event2)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->event1 = event1;
+			   __entry->event2 = event2;
+			   ),
+
+	    TP_printk("event1=%s, event2=%s",
+		      show_cd321x_irq_flags(__entry->event1),
+		      show_cd321x_irq_flags(__entry->event2))
+);
+
 TRACE_EVENT(tps6598x_status,
 	    TP_PROTO(u32 status),
 	    TP_ARGS(status),
-- 
2.25.1

