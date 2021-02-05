Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39827310295
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 03:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhBECIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 21:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhBECIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:08:14 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCA5C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 18:07:34 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id o20so4069195qtx.22
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 18:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=iQ/nCwFfSw1diNU9jQjcFI842UmqsJk01X+x42o8ga4=;
        b=JCCyjc/F5QoFsS9JI44cJJjLF0fEJC7lZRFqgziM7Gp67DWuLC2hdcvanruOKKnXHN
         V5+0U1w3654IeZYO0SYldn1r9ybkWabNO19am2pCCm/Zp3TkXYCeUxhSdrH55nTuqRLk
         osyS5mREnvZ+aejw1QPhS18rD4ZDaQuZd8342AkqS68vMCaD+rdXhiBkVmQ2UhyeS97F
         aBtIVD6TJEETeahdZ7+LYHdum+sBJjZHwKXj1bfyIQyHrzhnQRI6HfIX16FZ9b/45m1L
         evpB72nvaV5eKgkUINl/xckmOQTy7oVIzuegwg25dOX+3Qgf3ofNr/wETZnKAOjGw5os
         iowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=iQ/nCwFfSw1diNU9jQjcFI842UmqsJk01X+x42o8ga4=;
        b=Tsdaaf5RZ0lrDtLjf2B5kVvRIkQTJao5Eo1qmcT2yZC24N2z40aw8iJHS9BHnwiykH
         mlMTUTdFhjxqWmXvMkYLT5RQXVFxyJWB9d6XLmiozvvmGRaUXGd9VF4hwH5yfJUKtNVN
         mA/jhFYXjMp7+rYkv5+VHvOp4bOxzm+p7tbKdWAdsi89oR4LLBOtyKj0/NisC72cZb7t
         HtjNBJ9UCZ8UwiSFStU+c+cEY4m3hRvoKpeZmNZYxTIhPufOlnAZlvx7A4w18zBzwt94
         TM2Gic66HB+JYZ8d4B0YvUk1iqBBJU1N1MBjHuArt+Ji4hvdy85TdprnEXtNrcjtS9Ka
         YQWg==
X-Gm-Message-State: AOAM531aioxMfrlJ4nUXTdTWn63d9Ir9m3jzONkvmqplgvfPjqQTXcGr
        eA7DfC/rOu9hk8Dl2KPdrq2s381XbInFPYc=
X-Google-Smtp-Source: ABdhPJznewafyO7i6RBVnDCbqZ+DfLi4t/WatAaX3qdbLjWm0vX2dqNeUvu1LaKVWSD4kp2eu15ykU96HB3JE6c=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8475:2f1d:e8b4:f65a])
 (user=saravanak job=sendgmr) by 2002:a0c:c688:: with SMTP id
 d8mr2553698qvj.8.1612490853635; Thu, 04 Feb 2021 18:07:33 -0800 (PST)
Date:   Thu,  4 Feb 2021 18:07:30 -0800
Message-Id: <20210205020730.1746354-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v1] gpiolib: Don't probe gpio_device if it's not the primary device
From:   Saravana Kannan <saravanak@google.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, kernel-team@android.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry reported[1] boot error messages caused by
commit 4731210c09f5 ("gpiolib: Bind gpio_device to a driver to enable fw_devlink=on by default").

gpio-1022 (cpu-pwr-req-hog): hogged as input
max77620-pinctrl max77620-pinctrl: pin gpio4 already requested by max77620-pinctrl; cannot claim for gpiochip1
max77620-pinctrl max77620-pinctrl: pin-4 (gpiochip1) status -22
max77620-pinctrl max77620-pinctrl: could not request pin 4 (gpio4) from group gpio4  on device max77620-pinctrl
gpio_stub_drv gpiochip1: Error applying setting, reverse things back
gpio_stub_drv: probe of gpiochip1 failed with error -22

This happens because when we try to probe a device, driver core calls
into pinctrl to set up the pins. However, if the GPIO DT node already
has a proper device created and probed, trying to probe the gpio_device
with a stub driver makes the pins be claimed twice. pinctrl doesn't like
this and throws an error.

So, this patch makes sure the gpio_stub_drv doesn't match with a
gpio_device if it's not the primary device for the fwnode.

[1] - https://lore.kernel.org/lkml/544ad0e4-0954-274c-8e77-866aaa5661a8@gmail.com/
Fixes: 4731210c09f5 ("gpiolib: Bind gpio_device to a driver to enable fw_devlink=on by default")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
---
Greg/Linus,

This will need to go into driver-core because the Fixes is in
driver-core too.

Thanks,
Saravana

 drivers/gpio/gpiolib.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8e0564c50840..8ad679a928b0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -56,8 +56,10 @@
 static DEFINE_IDA(gpio_ida);
 static dev_t gpio_devt;
 #define GPIO_DEV_MAX 256 /* 256 GPIO chip devices supported */
+static int gpio_bus_match(struct device *dev, struct device_driver *drv);
 static struct bus_type gpio_bus_type = {
 	.name = "gpio",
+	.match = gpio_bus_match,
 };
 
 /*
@@ -4199,6 +4201,18 @@ void gpiod_put_array(struct gpio_descs *descs)
 }
 EXPORT_SYMBOL_GPL(gpiod_put_array);
 
+
+static int gpio_bus_match(struct device *dev, struct device_driver *drv)
+{
+	/*
+	 * Only match if the fwnode doesn't already have a proper struct device
+	 * created for it.
+	 */
+	if (dev->fwnode && dev->fwnode->dev != dev)
+		return 0;
+	return 1;
+}
+
 static int gpio_stub_drv_probe(struct device *dev)
 {
 	/*
-- 
2.30.0.365.g02bc693789-goog

