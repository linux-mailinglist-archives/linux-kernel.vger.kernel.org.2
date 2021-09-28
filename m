Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C8141B359
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbhI1P5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:57:08 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:45115 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241707AbhI1P5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:57:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 95EEF580C25;
        Tue, 28 Sep 2021 11:55:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 Sep 2021 11:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=7k99brYKXgcXO
        k4IW+ax4xDIyMEk6c+A5uHjFIDw/WY=; b=R6Og6MxoACYgoi1Dgevqz7tNurMFY
        PmWF4if7NR1vuffnn411k3qJCoty6BRBrKm0DB4sDATlQ0q0p6XNw4fu6+vusFNV
        6cXOkmwhtXSqDo88V7W3OULwn+6TozRswrgrJ94Ck4689j4TdzvLhRKH21xlTa6/
        5kJSXGdCxRk3ALfHyNfm00NaPdUDwCe30QW16nbU/J+hmyNQJb9wqhnhutX2hnwk
        cUgp5h3KNe5hvVh1VGZ9wQqtUre+O4lwbTBJiJQyvAW4A7C6LPiMTU+oWgofUqBW
        XcdMFrFu0/Igf1gJaaWPo1GxGvqKVa64umI8DwZLCjIdn3W/peg5cC20Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=7k99brYKXgcXOk4IW+ax4xDIyMEk6c+A5uHjFIDw/WY=; b=T3Se15m9
        TfjdsglZi38E+ki1N9RrKqPEr943fIj0ts1Tb7o7pkvwyg4IR3Y7T4pmA2qFUbEz
        leOdBXj6LrrjsQ4esmtAf1vgcCZAw+rGG7jHF5COz7AP2eVf2GAPjy4nCGpx+CRA
        ESDNN6Z0Sl2CmwPriCs2pJ0imsHUi++371FQPcCc4Ko5E2TGR2BSGcquq3gCgdHP
        ySvpPk0OiZ+F8JzuC1s9AYwNIGZPKM5S4+d7aWp5o+rak8AAO1sww+DKSOuSYyo+
        FOSg8wtKpnjFC31bCBRaISSPBPC1oxViNeRYMhZyFrxH/Wy+qi1Xd+NZ1suwDtEb
        3xm9MW+mx1p10g==
X-ME-Sender: <xms:6zpTYfn7s13PusPoy37Nub4vluVjV9ZKUKwmCw0wULMXnVuVJkcBZg>
    <xme:6zpTYS0bhhnWug4-awCTlLEP7zgawLhyVHpFMcest1vi0XARt2yqNZXB9V5nOtuTk
    yqTtXiE_DnaVcWNqu0>
X-ME-Received: <xmr:6zpTYVpYYGUnOV7BE8Tnv0tyhPVC4CHf_QoebsZsTwAZjk_hodyE3-d9fI3c6nkdgzTqtLmpb1Zkh17pLaLzeBfB9sgsYxciHySfeYDghM6Wz3zzIqkYIkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:6zpTYXnmQX06fssG4OT6t3A1IR79RK80ltjrLoXUpyv-6J5mfYf_XA>
    <xmx:6zpTYd2b7yuk8kr1Nh0EoDktKXUGDaylFSqrgxgClxIMva9SKN3I5A>
    <xmx:6zpTYWuHsNFQRml_43e5-vI3GHYhzjejJY7e8aTnJNQcpYDxE2_kVA>
    <xmx:6zpTYetK81lxA9sygNG4xvcNNn4zxdFu2Byh1oEGd5X41fdmzeUdxQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 11:55:21 -0400 (EDT)
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
Subject: [PATCH v3 2/6] usb: typec: tipd: Split interrupt handler
Date:   Tue, 28 Sep 2021 17:54:58 +0200
Message-Id: <20210928155502.71372-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210928155502.71372-1-sven@svenpeter.dev>
References: <20210928155502.71372-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the handlers for the individual interrupts into their own functions
to prepare for adding a second interrupt handler for the Apple CD321x
chips

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
no changes since v2

changes since v1:
  - new commit since Heikki suggested to add a separate irq handler
    for the cd321x variant

 drivers/usb/typec/tipd/core.c | 96 ++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 93e56291f0cf..172715c6c238 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -404,13 +404,69 @@ static const struct typec_operations tps6598x_ops = {
 	.pr_set = tps6598x_pr_set,
 };
 
+static bool tps6598x_read_status(struct tps6598x *tps, u32 *status)
+{
+	int ret;
+
+	ret = tps6598x_read32(tps, TPS_REG_STATUS, status);
+	if (ret) {
+		dev_err(tps->dev, "%s: failed to read status\n", __func__);
+		return false;
+	}
+	trace_tps6598x_status(*status);
+
+	return true;
+}
+
+static bool tps6598x_read_data_status(struct tps6598x *tps)
+{
+	u32 data_status;
+	int ret;
+
+	ret = tps6598x_read32(tps, TPS_REG_DATA_STATUS, &data_status);
+	if (ret < 0) {
+		dev_err(tps->dev, "failed to read data status: %d\n", ret);
+		return false;
+	}
+	trace_tps6598x_data_status(data_status);
+
+	return true;
+}
+
+static bool tps6598x_read_power_status(struct tps6598x *tps)
+{
+	u16 pwr_status;
+	int ret;
+
+	ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
+	if (ret < 0) {
+		dev_err(tps->dev, "failed to read power status: %d\n", ret);
+		return false;
+	}
+	trace_tps6598x_power_status(pwr_status);
+
+	return true;
+}
+
+static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
+{
+	int ret;
+
+	if (status & TPS_STATUS_PLUG_PRESENT) {
+		ret = tps6598x_connect(tps, status);
+		if (ret)
+			dev_err(tps->dev, "failed to register partner\n");
+	} else {
+		tps6598x_disconnect(tps, status);
+	}
+}
+
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
 	u64 event1;
 	u64 event2;
-	u32 status, data_status;
-	u16 pwr_status;
+	u32 status;
 	int ret;
 
 	mutex_lock(&tps->lock);
@@ -423,42 +479,20 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	}
 	trace_tps6598x_irq(event1, event2);
 
-	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
-	if (ret) {
-		dev_err(tps->dev, "%s: failed to read status\n", __func__);
+	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
-	}
-	trace_tps6598x_status(status);
 
-	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE) {
-		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
-		if (ret < 0) {
-			dev_err(tps->dev, "failed to read power status: %d\n", ret);
+	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
+		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
-		}
-		trace_tps6598x_power_status(pwr_status);
-	}
 
-	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE) {
-		ret = tps6598x_read32(tps, TPS_REG_DATA_STATUS, &data_status);
-		if (ret < 0) {
-			dev_err(tps->dev, "failed to read data status: %d\n", ret);
+	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
+		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
-		}
-		trace_tps6598x_data_status(data_status);
-	}
 
 	/* Handle plug insert or removal */
-	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT) {
-		if (status & TPS_STATUS_PLUG_PRESENT) {
-			ret = tps6598x_connect(tps, status);
-			if (ret)
-				dev_err(tps->dev,
-					"failed to register partner\n");
-		} else {
-			tps6598x_disconnect(tps, status);
-		}
-	}
+	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
+		tps6598x_handle_plug_event(tps, status);
 
 err_clear_ints:
 	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
-- 
2.25.1

