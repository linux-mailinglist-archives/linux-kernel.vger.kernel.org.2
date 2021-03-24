Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5A2347916
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhCXM4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbhCXM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:56:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C19C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:56:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a7so32674642ejs.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xslj2HthXDrqOB8fzPzGxoP+4g8oF5kFhH9tLbOpuwk=;
        b=EA/iiRLzhPyouBzEGqEEvNayjzGltHlqtlmPvlamFkf9kwv39A8FvLmv37bHb4Ce4P
         BmDt+qmivDvxZEKbSlPitksLF3DqE4iX4QXgkJtMo14lpGJBiVzlWMDiZlfS62p6922P
         4J7CbykQTUMs2xQnVspOJTy5D2sX6PymEpgCVL/RGIf9ONuHHmPBaglU5kmmINmKgfMi
         FrVfMouBnq1rDRaUCBRbzgG4lCW+k2KEqXWmOqmo0Sepc+xKR/V+sdEe+OtFGkKu0xgT
         UBeySBlvXwSoa7meSHqZrtZ6f1mTAyGtTK4krut44NH4dUWZMG3lWhqiAlD+lrHH0BXs
         3vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xslj2HthXDrqOB8fzPzGxoP+4g8oF5kFhH9tLbOpuwk=;
        b=kMDOmWNmcKrvpDKOAnLULqNemK//CVz8pblfThuF5y7O4ZppK/rPrjlV7hc+Efyp8k
         uHMsiZP1gADWdIozndacXIefW+JBM1DQPV4y/d4yL8r0n0r9FTUi/x+eVlOHvt649EUi
         RGJfMrBBwJv3vMj2gcEXzssdHRDrj6DB/u0kf2PNA7HX8eznxtES7/QLqij22eXMYEYF
         s9VCrBoz5mVDdKa4XznkUgzAUMi2IvKsaIeuRf4mvqLmnBcIoTgbsnSf+chbkUdmClFg
         Q1x6bfpdGYeNsu3fzMD5gYkmog4KZtaqzQCzooIxW/qfBzqFEKsGtNmStamiEvK7TfVQ
         1lKg==
X-Gm-Message-State: AOAM5319zPYxdKZ0KgCmw9javYrdyagjrARIQvQlEoxBnCmRFMXE7ZB3
        O8N40lGJmrkhjlXW8PMsbg8ljE/1NSrptP29
X-Google-Smtp-Source: ABdhPJx2EOP9+eIwQbX5mIZcz9HFnp6uZundPHwJXDNQuVzbLvxvvM5eF6ZIv3J5LAFVfjhQ9AR/ZA==
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr3556682eje.104.1616590566405;
        Wed, 24 Mar 2021 05:56:06 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id fi11sm880282ejb.73.2021.03.24.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:56:06 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     coproscefalo@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com, jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 06/10] platform/x86: toshiba_acpi: use devm_led_classdev_register() for LEDs
Date:   Wed, 24 Mar 2021 14:55:44 +0200
Message-Id: <20210324125548.45983-7-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324125548.45983-1-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this change the deregistration of the LED objects is made symmetrical
(and in reverse) with the registration. We also can get rid of the calls
to led_classdev_unregister(), because the LED objects will be cleaned up
when the reference to the parent device object goes to zero.

This change also unifies the reference to the parent object from
'&acpi_dev->dev' and '&dev->acpi_dev->dev' to 'parent', since it's the same
reference, and makes the code-lines a bit shorter.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/platform/x86/toshiba_acpi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index ada2a2d8c913..e787c140eec2 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3001,10 +3001,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
 				   &toshiba_attr_group);
 
-	led_classdev_unregister(&dev->led_dev);
-	led_classdev_unregister(&dev->kbd_led);
-	led_classdev_unregister(&dev->eco_led);
-
 	if (dev->wwan_rfk) {
 		rfkill_unregister(dev->wwan_rfk);
 		rfkill_destroy(dev->wwan_rfk);
@@ -3114,7 +3110,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		dev->led_dev.max_brightness = 1;
 		dev->led_dev.brightness_set = toshiba_illumination_set;
 		dev->led_dev.brightness_get = toshiba_illumination_get;
-		led_classdev_register(&acpi_dev->dev, &dev->led_dev);
+		ret = devm_led_classdev_register(parent, &dev->led_dev);
+		if (ret)
+			return ret;
 	}
 
 	toshiba_eco_mode_available(dev);
@@ -3123,7 +3121,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		dev->eco_led.max_brightness = 1;
 		dev->eco_led.brightness_set = toshiba_eco_mode_set_status;
 		dev->eco_led.brightness_get = toshiba_eco_mode_get_status;
-		led_classdev_register(&dev->acpi_dev->dev, &dev->eco_led);
+		ret = devm_led_classdev_register(parent, &dev->eco_led);
+		if (ret)
+			return ret;
 	}
 
 	toshiba_kbd_illum_available(dev);
@@ -3139,7 +3139,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		dev->kbd_led.max_brightness = 1;
 		dev->kbd_led.brightness_set = toshiba_kbd_backlight_set;
 		dev->kbd_led.brightness_get = toshiba_kbd_backlight_get;
-		led_classdev_register(&dev->acpi_dev->dev, &dev->kbd_led);
+		ret = devm_led_classdev_register(parent, &dev->kbd_led);
+		if (ret)
+			return ret;
 	}
 
 	ret = toshiba_touchpad_get(dev, &dummy);
-- 
2.30.2

