Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886CD439647
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhJYM0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhJYM0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:26:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE33C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:24:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r12so10089167edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n1UvCQXDX7rgwI8PGUePzOMzJWSDc9bmHCOv1+MdQ3Y=;
        b=OHI1m6vKznaOm8uE1MZUnM3p7/VhykiWZ0fvDgNTIjsQfD/cMifP4jOnA04jMa1T4n
         +mrD9OV4YLttojVbsjpgJTF9gfQWy4GJx1YRzEB+jtEm8BmPh7rKSX9UT9apv4caEwOw
         c8VrqtVe4CZpv6Rrxv6gNLI/y/64fRVYBYJhHgxOiVp3l4mhuHKZ6mFhnmPpSIcUCXFm
         0q6mufeEEEcoarcZcBckU6+nnsz+fFUDc4+0c6Oe36XxJ+FEo2K1oveQMG7BzMzAUKKl
         YuvNgiEgieHbAR0nlXbxIzwi8os0IBpxY+CMSAaupV6AYjUAKRJGMstfm9jyb5udoQG3
         7stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n1UvCQXDX7rgwI8PGUePzOMzJWSDc9bmHCOv1+MdQ3Y=;
        b=8GOpoxtFGnrxhdxGo+B6kSSsIb6roqBB4nyJkswM5F1IXtHqy1larRW1bqxRvM+JKq
         eqJQnYrHneVZQpg3TFkYlXswbxSPBlRvkifHE0v9iyUGNGh32zI1lY5tYceyuxPPWjeo
         N4/lB/RdbEdQ0Qy8W8tUvFegxuvz4R6Ln95G1LduCtzh2eeff6UZTvZSs90dm1FO9QFx
         y9ClgZA6ygO+DD9FUOZt72CJUImb/v+iJ1lWf9mX8PI+13EKAwggLpRyD+BODOagKziV
         qtoNxmUgzUmXVoG5iFcUxmka+SYU/Gm9Rby+T6OmZbx2SNP6Tvg30Hj35S/Ldh8bNuZg
         X1QA==
X-Gm-Message-State: AOAM530/pKxUYGhOgC1ZgZPpk5ySt+QKVETdHTNFH81WY63uPl9LmP00
        +LbwweCwC0GyHNn379RjZT5CQIOA+DTixK5j
X-Google-Smtp-Source: ABdhPJwx3DMwWMuGxjGI8TiKxoRcBnM5NM2+gRz1ooD3RRZREaNssvHfEYLs0LacvYd5FmXjVbx5Bw==
X-Received: by 2002:a05:6402:35c5:: with SMTP id z5mr26392137edc.388.1635164655996;
        Mon, 25 Oct 2021 05:24:15 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id ga1sm699941ejc.100.2021.10.25.05.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:24:15 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
Cc:     Maarten Zanders <maarten.zanders@mind.be>, stable@vger.kernel.org,
        dmurphy@ti.com, milo.kim@ti.com,
        Arne Staessen <a.staessen@televic.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: lp5523: fix out-of-bounds bug in lp5523_selftest()
Date:   Mon, 25 Oct 2021 14:23:46 +0200
Message-Id: <20211025122346.28771-1-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When not all LED channels of the device are configured in OF, the
array size of pdata->led_config is smaller than the max number of
channels on the device. Subsequent accesses to pdata->led_config[i]
are going beyond the bounds of the allocated array. The check on
the configured led_current is also invalid, resulting in erroneous
test results for this function.

There is a potential for LED overcurrent conditions since the
test current will be set to values from these out-of-bound regions.
For the test, the PWM is set to 100%, although for a short amount
of time.

Instead of iterating over all the physical channels of the device,
loop over the available LED configurations and use led->chan_nr to
access the correct i2c registers. Keep the zero-check for the LED
current as existing configurations might depend on this to disable
a channel.

Cc: <stable@vger.kernel.org>
Cc: <dmurphy@ti.com>
Cc: <milo.kim@ti.com>
Reported-by: Arne Staessen <a.staessen@televic.com>
Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---
 drivers/leds/leds-lp5523.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index b1590cb4a188..f3782759c8d8 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -581,8 +581,8 @@ static ssize_t lp5523_selftest(struct device *dev,
 	struct lp55xx_led *led = i2c_get_clientdata(to_i2c_client(dev));
 	struct lp55xx_chip *chip = led->chip;
 	struct lp55xx_platform_data *pdata = chip->pdata;
-	int i, ret, pos = 0;
-	u8 status, adc, vdd;
+	int ret, pos = 0;
+	u8 status, adc, vdd, i;
 
 	mutex_lock(&chip->lock);
 
@@ -612,20 +612,20 @@ static ssize_t lp5523_selftest(struct device *dev,
 
 	vdd--;	/* There may be some fluctuation in measurement */
 
-	for (i = 0; i < LP5523_MAX_LEDS; i++) {
-		/* Skip non-existing channels */
+	for (i = 0; i < pdata->num_channels; i++) {
+		/* Skip disabled channels */
 		if (pdata->led_config[i].led_current == 0)
 			continue;
 
 		/* Set default current */
-		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + i,
+		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + led->chan_nr,
 			pdata->led_config[i].led_current);
 
-		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + i, 0xff);
+		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + led->chan_nr, 0xff);
 		/* let current stabilize 2 - 4ms before measurements start */
 		usleep_range(2000, 4000);
 		lp55xx_write(chip, LP5523_REG_LED_TEST_CTRL,
-			     LP5523_EN_LEDTEST | i);
+			     LP5523_EN_LEDTEST | led->chan_nr);
 		/* ADC conversion time is 2.7 ms typically */
 		usleep_range(3000, 6000);
 		ret = lp55xx_read(chip, LP5523_REG_STATUS, &status);
@@ -640,12 +640,12 @@ static ssize_t lp5523_selftest(struct device *dev,
 			goto fail;
 
 		if (adc >= vdd || adc < LP5523_ADC_SHORTCIRC_LIM)
-			pos += sprintf(buf + pos, "LED %d FAIL\n", i);
+			pos += sprintf(buf + pos, "LED %d FAIL\n", led->chan_nr);
 
-		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + i, 0x00);
+		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + led->chan_nr, 0x00);
 
 		/* Restore current */
-		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + i,
+		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + led->chan_nr,
 			led->led_current);
 		led++;
 	}
-- 
2.31.1

