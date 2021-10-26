Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8897D43AE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhJZI6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:58:48 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30467 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhJZI6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635238584; x=1666774584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r2ndaKt5+ORqLluT9rI7+4mckCDoBTiYuZ1y7YGtxgk=;
  b=vAxDRp4QtJlWvwGvkt0y9+OMlD2ujOLm5tM3nCMHnoyZ8zyyN1x2CjxH
   i3WQKzEtOnS9Fbb2Oo1OkiUcfioiKrSCDZy3FmTovuuaWgC6x9YqDmhvU
   4/4nm/JiOGbI/yJ3hQx88WtytME+Uk5L4wX6WxiqSLAP8hQSDJheykYph
   mzav+7fwv9OYA3GePd4g1t/LS+bus25hoSFygVh42lCwMQAcUH/bI2F0O
   TDwmxW/OkIzmcUk3LAVFRfLG6Opw7VaGNl4DXTB9/hkk4KscCavBfqBjl
   qRX4mYVLDERGJJspE6FyypRo7D3QmHDLmPdh2gzvY7UGkCek8Ffj1L9l7
   g==;
IronPort-SDR: l+xCzogN1lLowpwQk84Mbgvp17OdrLaXaTYWxQ0HjA3PZpCyzb6CvZp/itpc3c0BkIXArgA6NM
 9NEkKjgYe8qfX9xxpg9orGnp3oIJjrY3HzyWgf3o0Mit776aROWsynkr0KGLoo4/LVL58ypCGw
 tJMehgHK6/FxzlwQn1IHw1Ay+Pn+NruLEih9TMlQ5Ysf/DP6vRSiDeBI8J0Cjlto+Q0RXpTKqb
 BAQ4DuFLQitKjd4oHjkrC69LiPYGNKNv1L/U0OdCbFKIwjSLTTjP0MRPKlznicGf5t8m7x+IGJ
 FTZkpRJq8E7smMTJ7jBd+xph
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="141082505"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2021 01:56:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 26 Oct 2021 01:56:23 -0700
Received: from chelti64410lx.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 26 Oct 2021 01:56:19 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        "Dan Sneddon" <dan.sneddon@microchip.com>
Subject: [PATCH] usb: gadget: at91_udc: Convert to GPIO descriptors
Date:   Tue, 26 Oct 2021 14:26:10 +0530
Message-ID: <20211026085610.25264-1-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the legacy GPIO APIs with gpio descriptor consumer
interface. Remove all gpio inversion(active low) flags as it is
already handled by the gpiod_set_value() and gpiod_get_value()
functions.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Reviewed-by: Dan Sneddon <dan.sneddon@microchip.com>
---
 drivers/usb/gadget/udc/at91_udc.c | 67 +++++++++++--------------------
 drivers/usb/gadget/udc/at91_udc.h |  8 ++--
 2 files changed, 27 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index eede5cedacb4..21365f185b94 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -25,7 +25,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_data/atmel.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
@@ -1510,7 +1510,6 @@ static irqreturn_t at91_udc_irq (int irq, void *_udc)
 
 static void at91_vbus_update(struct at91_udc *udc, unsigned value)
 {
-	value ^= udc->board.vbus_active_low;
 	if (value != udc->vbus)
 		at91_vbus_session(&udc->gadget, value);
 }
@@ -1521,7 +1520,7 @@ static irqreturn_t at91_vbus_irq(int irq, void *_udc)
 
 	/* vbus needs at least brief debouncing */
 	udelay(10);
-	at91_vbus_update(udc, gpio_get_value(udc->board.vbus_pin));
+	at91_vbus_update(udc, gpiod_get_value(udc->board.vbus_pin));
 
 	return IRQ_HANDLED;
 }
@@ -1531,7 +1530,7 @@ static void at91_vbus_timer_work(struct work_struct *work)
 	struct at91_udc *udc = container_of(work, struct at91_udc,
 					    vbus_timer_work);
 
-	at91_vbus_update(udc, gpio_get_value_cansleep(udc->board.vbus_pin));
+	at91_vbus_update(udc, gpiod_get_value_cansleep(udc->board.vbus_pin));
 
 	if (!timer_pending(&udc->vbus_timer))
 		mod_timer(&udc->vbus_timer, jiffies + VBUS_POLL_TIMEOUT);
@@ -1595,7 +1594,6 @@ static void at91udc_shutdown(struct platform_device *dev)
 static int at91rm9200_udc_init(struct at91_udc *udc)
 {
 	struct at91_ep *ep;
-	int ret;
 	int i;
 
 	for (i = 0; i < NUM_ENDPOINTS; i++) {
@@ -1615,32 +1613,23 @@ static int at91rm9200_udc_init(struct at91_udc *udc)
 		}
 	}
 
-	if (!gpio_is_valid(udc->board.pullup_pin)) {
+	if (!udc->board.pullup_pin) {
 		DBG("no D+ pullup?\n");
 		return -ENODEV;
 	}
 
-	ret = devm_gpio_request(&udc->pdev->dev, udc->board.pullup_pin,
-				"udc_pullup");
-	if (ret) {
-		DBG("D+ pullup is busy\n");
-		return ret;
-	}
-
-	gpio_direction_output(udc->board.pullup_pin,
-			      udc->board.pullup_active_low);
+	gpiod_direction_output(udc->board.pullup_pin,
+			       gpiod_is_active_low(udc->board.pullup_pin));
 
 	return 0;
 }
 
 static void at91rm9200_udc_pullup(struct at91_udc *udc, int is_on)
 {
-	int active = !udc->board.pullup_active_low;
-
 	if (is_on)
-		gpio_set_value(udc->board.pullup_pin, active);
+		gpiod_set_value(udc->board.pullup_pin, 1);
 	else
-		gpio_set_value(udc->board.pullup_pin, !active);
+		gpiod_set_value(udc->board.pullup_pin, 0);
 }
 
 static const struct at91_udc_caps at91rm9200_udc_caps = {
@@ -1783,20 +1772,20 @@ static void at91udc_of_init(struct at91_udc *udc, struct device_node *np)
 {
 	struct at91_udc_data *board = &udc->board;
 	const struct of_device_id *match;
-	enum of_gpio_flags flags;
 	u32 val;
 
 	if (of_property_read_u32(np, "atmel,vbus-polled", &val) == 0)
 		board->vbus_polled = 1;
 
-	board->vbus_pin = of_get_named_gpio_flags(np, "atmel,vbus-gpio", 0,
-						  &flags);
-	board->vbus_active_low = (flags & OF_GPIO_ACTIVE_LOW) ? 1 : 0;
+	board->vbus_pin = gpiod_get_from_of_node(np, "atmel,vbus-gpio", 0,
+						 GPIOD_IN, "udc_vbus");
+	if (IS_ERR(board->vbus_pin))
+		board->vbus_pin = NULL;
 
-	board->pullup_pin = of_get_named_gpio_flags(np, "atmel,pullup-gpio", 0,
-						  &flags);
-
-	board->pullup_active_low = (flags & OF_GPIO_ACTIVE_LOW) ? 1 : 0;
+	board->pullup_pin = gpiod_get_from_of_node(np, "atmel,pullup-gpio", 0,
+						   GPIOD_ASIS, "udc_pullup");
+	if (IS_ERR(board->pullup_pin))
+		board->pullup_pin = NULL;
 
 	match = of_match_node(at91_udc_dt_ids, np);
 	if (match)
@@ -1884,22 +1873,14 @@ static int at91udc_probe(struct platform_device *pdev)
 		goto err_unprepare_iclk;
 	}
 
-	if (gpio_is_valid(udc->board.vbus_pin)) {
-		retval = devm_gpio_request(dev, udc->board.vbus_pin,
-					   "udc_vbus");
-		if (retval) {
-			DBG("request vbus pin failed\n");
-			goto err_unprepare_iclk;
-		}
-
-		gpio_direction_input(udc->board.vbus_pin);
+	if (udc->board.vbus_pin) {
+		gpiod_direction_input(udc->board.vbus_pin);
 
 		/*
 		 * Get the initial state of VBUS - we cannot expect
 		 * a pending interrupt.
 		 */
-		udc->vbus = gpio_get_value_cansleep(udc->board.vbus_pin) ^
-			udc->board.vbus_active_low;
+		udc->vbus = gpiod_get_value_cansleep(udc->board.vbus_pin);
 
 		if (udc->board.vbus_polled) {
 			INIT_WORK(&udc->vbus_timer_work, at91_vbus_timer_work);
@@ -1908,7 +1889,7 @@ static int at91udc_probe(struct platform_device *pdev)
 				  jiffies + VBUS_POLL_TIMEOUT);
 		} else {
 			retval = devm_request_irq(dev,
-					gpio_to_irq(udc->board.vbus_pin),
+					gpiod_to_irq(udc->board.vbus_pin),
 					at91_vbus_irq, 0, driver_name, udc);
 			if (retval) {
 				DBG("request vbus irq %d failed\n",
@@ -1986,8 +1967,8 @@ static int at91udc_suspend(struct platform_device *pdev, pm_message_t mesg)
 		enable_irq_wake(udc->udp_irq);
 
 	udc->active_suspend = wake;
-	if (gpio_is_valid(udc->board.vbus_pin) && !udc->board.vbus_polled && wake)
-		enable_irq_wake(udc->board.vbus_pin);
+	if (udc->board.vbus_pin && !udc->board.vbus_polled && wake)
+		enable_irq_wake(gpiod_to_irq(udc->board.vbus_pin));
 	return 0;
 }
 
@@ -1996,9 +1977,9 @@ static int at91udc_resume(struct platform_device *pdev)
 	struct at91_udc *udc = platform_get_drvdata(pdev);
 	unsigned long	flags;
 
-	if (gpio_is_valid(udc->board.vbus_pin) && !udc->board.vbus_polled &&
+	if (udc->board.vbus_pin && !udc->board.vbus_polled &&
 	    udc->active_suspend)
-		disable_irq_wake(udc->board.vbus_pin);
+		disable_irq_wake(gpiod_to_irq(udc->board.vbus_pin));
 
 	/* maybe reconnect to host; if so, clocks on */
 	if (udc->active_suspend)
diff --git a/drivers/usb/gadget/udc/at91_udc.h b/drivers/usb/gadget/udc/at91_udc.h
index fd58c5b81826..28c1042f8623 100644
--- a/drivers/usb/gadget/udc/at91_udc.h
+++ b/drivers/usb/gadget/udc/at91_udc.h
@@ -109,11 +109,9 @@ struct at91_udc_caps {
 };
 
 struct at91_udc_data {
-	int	vbus_pin;		/* high == host powering us */
-	u8	vbus_active_low;	/* vbus polarity */
-	u8	vbus_polled;		/* Use polling, not interrupt */
-	int	pullup_pin;		/* active == D+ pulled up */
-	u8	pullup_active_low;	/* true == pullup_pin is active low */
+	struct gpio_desc  *vbus_pin;		/* high == host powering us */
+	u8	          vbus_polled;		/* Use polling, not interrupt */
+	struct gpio_desc  *pullup_pin;		/* active == D+ pulled up */
 };
 
 /*
-- 
2.25.1

