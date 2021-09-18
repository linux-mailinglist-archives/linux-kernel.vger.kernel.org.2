Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8A941063F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbhIRMLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:11:54 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:53365 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239751AbhIRMLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:11:21 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 383BD580A87;
        Sat, 18 Sep 2021 08:09:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 18 Sep 2021 08:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=iRhxHP0o3O6O0
        kpyjR8ydrO7q+v1pFew5P5vbcKQk4E=; b=tMs2+3hL8eoQadMa46O+VG1je91LI
        gHYkYY1NcrauMJ1hu5iVnF3aIecRUS1iYrJw2YYKqVWTqazDzM4TY92n6J3ck5u+
        3Qh2YDQ1hmyDmkmDsGooAGrWad1SnwvyPQIUsBDyZ5fHoJbPXsU2gUWrjUdELmHL
        CKQbPx1eI1wfPQQLOPhscClhc7adTqyvMRe0mGcjrZipfLHo2VU5sVW73Ui+WksF
        5uRxRYp951RcGN0yrVN4Ptjt/mposgcT15VpCc757sfW8zClyDysJTzaXQUUdU+q
        OJYFslIsGpAg0mvzOxlu0Q9qmkyN1HbL+uX66a4p6+ayuIwncnRsGc6Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=iRhxHP0o3O6O0kpyjR8ydrO7q+v1pFew5P5vbcKQk4E=; b=mnHGxbTA
        U5Rg5877t7PfnUof/f5TV6Sp0b0IQZeko6onuPRnklZLWYwFtcMCdxiQLg1g1WR6
        RiTRWKSvJwBzky8aA4umL1ICHIoQ17bsApDXXNkOzTekdEH/y7Yl+iRPBMecImpG
        9xoVpr/5rKKrxm6iPQpnWEPHEAODbOSl2aozc7s0/gcq2ZyBhpoPGA5NJrb8PRXg
        EFLYAmNVTNoOu1mF7VbyzWv7fMjV6Dr4ddQNEJb7mwuGtep/iD4JVoRFpAPlySvY
        VH6fYzTBmCHv4LK0+/zwQkeKlJneTQCc0mL49OzFVWCD1/KE9fGYdEoVmn39zAJx
        ta93YyMKVIHFSw==
X-ME-Sender: <xms:FtdFYb_DnDKerioLwStajijKSM4E1vyCZjr8W1Yt38netv_xg6WXGg>
    <xme:FtdFYXsOp8LXDXulGP4RKxgNXTV34t3k9-r8TCcyHl4i0Z4bAci6WfsHymoZg9kw3
    Ajo5QvfHp4DxBUK38o>
X-ME-Received: <xmr:FtdFYZAE6PJWQtZffCMuYXAIPe5G-uy_2R2Lg_QmSlNITmcgMMgIVYS0IX-4taR5RQh1YZnMRxU7uFZxqYLEFIkmCrU0oG_f3fED3TV164kdEYBfCUvDoxpxALGQKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:FtdFYXe9hjqIaHb43ye_COeubJD3ZP9K1nCnQmbxVvHwBPIsCcqWBw>
    <xmx:FtdFYQNajxHBUb9lap_JuIOqU8lPoSE3pgInxErr2G9gmzY65keX5A>
    <xmx:FtdFYZmhklqZyI99DZpRFapr8o8pwiQmoI3ESJmyPTIX6XvINhQyJA>
    <xmx:FtdFYZlMaPypuN8RFpaBN6qx48XrJ5u4kWKlZl7wzySbHX1Hvkxfuw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Sep 2021 08:09:56 -0400 (EDT)
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
Subject: [RFT PATCH 3/9] usb: typec: tipd: Allow irq controller selection
Date:   Sat, 18 Sep 2021 14:09:28 +0200
Message-Id: <20210918120934.28252-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210918120934.28252-1-sven@svenpeter.dev>
References: <20210918120934.28252-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI TPS6598x chips come with two separate i2c buses which each have an
independent interrupt controller. When only a single controller is
connected both can just be used.
On Apple M1 machines the secondary bus is however connected to the system
management controller and we must not modify its configuration. Prepare
for that by allowing to chose which interrupt controller(s) are used.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 656020e7f533..c2c399722c37 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -78,6 +78,8 @@ static const char *const modes[] = {
 #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
 
 struct tps6598x_hw {
+	bool use_int1;
+	bool use_int2;
 };
 static const struct tps6598x_hw ti_tps6598x_data;
 
@@ -411,22 +413,28 @@ static const struct typec_operations tps6598x_ops = {
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
-	u64 event1;
-	u64 event2;
+	u64 event1 = 0;
+	u64 event2 = 0;
+	u64 event = 0;
 	u32 status, data_status;
 	u16 pwr_status;
 	int ret;
 
 	mutex_lock(&tps->lock);
 
-	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
-	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
+	ret = 0;
+	if (tps->hw->use_int1)
+		ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
+	if (tps->hw->use_int2)
+		ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
 	if (ret) {
 		dev_err(tps->dev, "%s: failed to read events\n", __func__);
 		goto err_unlock;
 	}
 	trace_tps6598x_irq(event1, event2);
 
+	event = event1 | event2;
+
 	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
 	if (ret) {
 		dev_err(tps->dev, "%s: failed to read status\n", __func__);
@@ -434,7 +442,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	}
 	trace_tps6598x_status(status);
 
-	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE) {
+	if (event & TPS_REG_INT_POWER_STATUS_UPDATE) {
 		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
 		if (ret < 0) {
 			dev_err(tps->dev, "failed to read power status: %d\n", ret);
@@ -443,7 +451,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 		trace_tps6598x_power_status(pwr_status);
 	}
 
-	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE) {
+	if (event & TPS_REG_INT_DATA_STATUS_UPDATE) {
 		ret = tps6598x_read32(tps, TPS_REG_DATA_STATUS, &data_status);
 		if (ret < 0) {
 			dev_err(tps->dev, "failed to read data status: %d\n", ret);
@@ -453,7 +461,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	}
 
 	/* Handle plug insert or removal */
-	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT) {
+	if (event & TPS_REG_INT_PLUG_EVENT) {
 		if (status & TPS_STATUS_PLUG_PRESENT) {
 			ret = tps6598x_connect(tps, status);
 			if (ret)
@@ -465,8 +473,10 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	}
 
 err_clear_ints:
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
+	if (tps->hw->use_int1)
+		tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
+	if (tps->hw->use_int2)
+		tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
 
 err_unlock:
 	mutex_unlock(&tps->lock);
@@ -744,6 +754,8 @@ static int tps6598x_remove(struct i2c_client *client)
 }
 
 static const struct tps6598x_hw ti_tps6598x_data = {
+	.use_int1 = true,
+	.use_int2 = true,
 };
 
 static const struct of_device_id tps6598x_of_match[] = {
-- 
2.25.1

