Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB10C4212C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhJDPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:39:08 -0400
Received: from smtp1.axis.com ([195.60.68.17]:45241 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235677AbhJDPid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1633361805;
  x=1664897805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5fRSpChnXs0jk1pUSgAuePYOIFm55P/7nqa8whji5Bc=;
  b=cEPtAEGzTOUnH6DrttAVczOxVz4hbr4P1o8e3ZpD2LrrE4a+wzVEWL2S
   /zKG8ttbzggCCirlu/nQ+FcSRhcS8PW5iePSEShpQNb0dgqNsV8wAKoTd
   CmkWldctlnoVoLbbnjVcxzhvESYCr+0dr4nePHTIxpEhRxditSMpL+iWF
   NqDzLLOywtZt8OkUEsRyXUwEflKWLUhwyF22kmKD1/TaDRI4wV9xBbC4D
   dXv6uDcKTDYUJVPWvo7pvAHaVvEdqhf97/9F29nGQCgZ2QnzqZ8e/a1k/
   ZLu82JXVqkK2nyktkT+70xtqKuAGOtp5BESc3r0mW6PehjmPOB/QTkEIY
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <peda@axentia.se>, <devicetree@vger.kernel.org>
CC:     <kernel@axis.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 2/2] mux: gpio: Support settle-time-us property
Date:   Mon, 4 Oct 2021 17:36:40 +0200
Message-ID: <20211004153640.20650-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211004153640.20650-1-vincent.whitchurch@axis.com>
References: <20211004153640.20650-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the devicetree specifies that the hardware requires a settle time,
add an appropriate delay after the mux GPIOs are set.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mux/gpio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index cc5f2c1861d4..17d7e03e39f0 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
@@ -18,12 +19,14 @@
 
 struct mux_gpio {
 	struct gpio_descs *gpios;
+	u32 delay;
 };
 
 static int mux_gpio_set(struct mux_control *mux, int state)
 {
 	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
 	DECLARE_BITMAP(values, BITS_PER_TYPE(state));
+	u32 delay = mux_gpio->delay;
 	u32 value = state;
 
 	bitmap_from_arr32(values, &value, BITS_PER_TYPE(value));
@@ -32,6 +35,9 @@ static int mux_gpio_set(struct mux_control *mux, int state)
 				       mux_gpio->gpios->desc,
 				       mux_gpio->gpios->info, values);
 
+	if (delay)
+		fsleep(delay);
+
 	return 0;
 }
 
@@ -72,6 +78,9 @@ static int mux_gpio_probe(struct platform_device *pdev)
 	WARN_ON(pins != mux_gpio->gpios->ndescs);
 	mux_chip->mux->states = BIT(pins);
 
+	mux_gpio->delay = 0;
+	device_property_read_u32(dev, "settle-time-us", &mux_gpio->delay);
+
 	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);
 	if (ret >= 0 && idle_state != MUX_IDLE_AS_IS) {
 		if (idle_state < 0 || idle_state >= mux_chip->mux->states) {
-- 
2.28.0

