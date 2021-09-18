Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81162410649
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbhIRMMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:12:38 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34667 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236620AbhIRMLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:11:46 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id BBCC8580A8B;
        Sat, 18 Sep 2021 08:10:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 18 Sep 2021 08:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=aMQfqmJ3dKPGx
        spm3ASGg7int5qQFUsrLE46xAC0S2k=; b=L61ikF//r9bmQ0GNivc+4qcq+m6zA
        HJ7MtvS1ncS5FWMaSPSYHje7Qqy87fMn4uPuv4wgGsnTg9D3SVeFzpYcDva2z8/P
        xzg6gEBfyYyTOCIuJ2F/brtYAmKwugnQ5S1ihnCzUhieBBJclGfzZVCNfvMfJ3ZJ
        eJjVZ/219IC+v1oZ24I2OVIMp2OAzz7O87PkmAKe2nK20uP6FsqAeTUGsRTqGs2v
        OVVrtA9+v+ZM5DMwGcByFv5MgPvszkVWpPRKq/VSHBpInrvOkgHN/XHgZrU4zfXk
        xIt510mFNCy49inGrlPkcEeiyAe2IOWheoOpjXSwflfkWnTuk9ZX5SmIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=aMQfqmJ3dKPGxspm3ASGg7int5qQFUsrLE46xAC0S2k=; b=lnYzo8od
        vQRfUpxvNiXFaR5s96VlzC6oHdQTlhAJWLeud0wMp4Ywih4i0l0fw2QEKON1TlVv
        drqFBRJQewi4BuzcZmS8mfUv91Xx6pza0NarW0KtLeduaGGIMmaU+LTFK2e9oaEd
        Z6HXmK/xs1DJON5eAVI+2XV1pti2f0mFkIzKWcVlGs2TgnApJF8eT4pyPCBcUSum
        U5LVBZCcXfPhb7eXX6/FmgfHCVowxL0a+mRNd5YoqRPGrGfkZ4EPqjAw09s9Slqk
        lq5+QkcHUnxgB0i1Ny8r9glhB+2FjPgXC0f1VQqOsjZZuhAegENyE19o1u7L2Fj3
        coJv3SO5SwwQFw==
X-ME-Sender: <xms:GtdFYX9Q6AOhwh80KiDE8eo6EoGc3dr3SoFWEIxmUfbaarV6XwZySA>
    <xme:GtdFYTt8RgHc1rrZpLwX98JvYlPgQDYwj-71wSD9Ju7MWXsUcK6EroEv2QGkYo9y4
    f9R81DqT5lPmeYKd1U>
X-ME-Received: <xmr:GtdFYVA_ZIYeulL3vY-9xjtJPA3-Ro9WpUJMoyIr0eteILywOetiLcHlHtvAKftfhQoqWg42hMjfzqNmpqEoKKu9k7xE2dxHtMmLuJnJVdauHASRwQbCD3ZNrofFcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:GtdFYTdBNEwJoiX8KZOuN_wNH0hdwngNYjxXQ84R2RYYwfGkku4tcA>
    <xmx:GtdFYcPyznFmQV7pRbOW_OJ6NRjwnY4tZb8BQwo5eo82UmxYbO0dtg>
    <xmx:GtdFYVkr48kC2lPG2lKKR2YX5rAANFdTV9iMkfTTNRYeuluACbViYA>
    <xmx:GtdFYVnG7ks71s3fh9Uxfw4q1v1hVuO3ko_bfuDS1SL9gERwDWuDrA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Sep 2021 08:10:00 -0400 (EDT)
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
Subject: [RFT PATCH 5/9] usb: typec: tipd: Allow to configure irq bits
Date:   Sat, 18 Sep 2021 14:09:30 +0200
Message-Id: <20210918120934.28252-6-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210918120934.28252-1-sven@svenpeter.dev>
References: <20210918120934.28252-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Apple variant of the TI TPS6598x chip uses different interrupt
numbers. Prepare for that by allowing those to be configured depending
on the compatible.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 4a6d66250fef..d191e7435018 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -80,6 +80,10 @@ static const char *const modes[] = {
 struct tps6598x_hw {
 	bool use_int1;
 	bool use_int2;
+	unsigned int irq_power_status_update;
+	unsigned int irq_data_status_update;
+	unsigned int irq_plug_event;
+	void (*irq_trace)(u64 event1, u64 event2);
 };
 static const struct tps6598x_hw ti_tps6598x_data;
 
@@ -431,7 +435,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 		dev_err(tps->dev, "%s: failed to read events\n", __func__);
 		goto err_unlock;
 	}
-	trace_tps6598x_irq(event1, event2);
+	tps->hw->irq_trace(event1, event2);
 
 	event = event1 | event2;
 	if (!event)
@@ -444,7 +448,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	}
 	trace_tps6598x_status(status);
 
-	if (event & TPS_REG_INT_POWER_STATUS_UPDATE) {
+	if (event & tps->hw->irq_power_status_update) {
 		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
 		if (ret < 0) {
 			dev_err(tps->dev, "failed to read power status: %d\n", ret);
@@ -453,7 +457,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 		trace_tps6598x_power_status(pwr_status);
 	}
 
-	if (event & TPS_REG_INT_DATA_STATUS_UPDATE) {
+	if (event & tps->hw->irq_data_status_update) {
 		ret = tps6598x_read32(tps, TPS_REG_DATA_STATUS, &data_status);
 		if (ret < 0) {
 			dev_err(tps->dev, "failed to read data status: %d\n", ret);
@@ -463,7 +467,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	}
 
 	/* Handle plug insert or removal */
-	if (event & TPS_REG_INT_PLUG_EVENT) {
+	if (event & tps->hw->irq_plug_event) {
 		if (status & TPS_STATUS_PLUG_PRESENT) {
 			ret = tps6598x_connect(tps, status);
 			if (ret)
@@ -760,6 +764,10 @@ static int tps6598x_remove(struct i2c_client *client)
 static const struct tps6598x_hw ti_tps6598x_data = {
 	.use_int1 = true,
 	.use_int2 = true,
+	.irq_power_status_update = TPS_REG_INT_POWER_STATUS_UPDATE,
+	.irq_data_status_update = TPS_REG_INT_DATA_STATUS_UPDATE,
+	.irq_plug_event = TPS_REG_INT_PLUG_EVENT,
+	.irq_trace = trace_tps6598x_irq,
 };
 
 static const struct of_device_id tps6598x_of_match[] = {
-- 
2.25.1

