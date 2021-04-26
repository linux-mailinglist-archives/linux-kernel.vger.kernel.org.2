Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E59A36B348
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhDZMkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:40:52 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38491 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbhDZMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:38:50 -0400
Received: by mail-wr1-f48.google.com with SMTP id k14so5802866wrv.5;
        Mon, 26 Apr 2021 05:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RA5vvjC6fYjBEhu3hg6HypYCy6fBqYfLd0XqaA1wLzE=;
        b=Uaj7JirNZVJ+PkG2hmgjXtTC4s1P7ICd7lV5woAPaTdpxwN0CihVSTygzk/qWKNmcv
         dUp6207I0qqWN8BzQhP6nRt72qUyDyyd+GdnCIUS2okOkG1SBNucDbqqvHOWuObhuK82
         i1H/NFhQKi2xSzjOnWImz5GfSC896qUvUiThWoFm/7g+E8NrEopafF15Oqa2fJ/m63g5
         nGJOc/D0G9KjAjGZgelyzus7ebyY0joPQP6pgDCCyFJakGKEUPn+x+4AKXibOcg5V8w9
         z5p4eGlya017dKNh2dl6VZ5MU3u27qVR7Rpi05nJfBZva7IZhZg4WUNKwoqDxk3Fb6I+
         xVGg==
X-Gm-Message-State: AOAM532DPmT9SFVcTFKUTqxaIOu+cXXMoydSOZnrzxZ01aOoM+fVK0sB
        H/iWLrxsThfVcv5wPjei+fM=
X-Google-Smtp-Source: ABdhPJzIZ2jBTNwv0QiR/NORErnXtfS2nKvuiQLNff3kRT50nKRfOgyjkThnJl9Zq0gxyDx7ba3jlw==
X-Received: by 2002:adf:ff89:: with SMTP id j9mr12702493wrr.416.1619440687704;
        Mon, 26 Apr 2021 05:38:07 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id u17sm18784168wmq.30.2021.04.26.05.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 05:38:07 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] hwmon: (max31790) Update documentation
Date:   Mon, 26 Apr 2021 14:37:49 +0200
Message-Id: <20210426123749.899654-5-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426123749.899654-1-kubernat@cesnet.cz>
References: <20210413025948.901867-1-kubernat@cesnet.cz>
 <20210426123749.899654-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conditions for fan fault and its connection to the PWM mode are now
documented.

The pwm_rate_of_change and fan_window are now mentioned. According to
our testing with Sunon PF36281BX-000U-S99, these values are crucial in
how RPM mode works and how long it takes for the RPM to stabilize. For
example, setting 5000 RPM (the fan goes up to 23000), the
pwm_rate_of_change needed to be changed to the lowest possible value,
otherwise the chip would just go from pwm 0 to pwm 60 back and forth and
never achieving 5000 RPM (and also signaling fan fault). Based on this
testing, we found out that the pwm_rate_of_change and fan_window values
need to be changed manually by the user, based on the user's exact fan
configuration.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 Documentation/hwmon/max31790.rst | 41 +++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index 2979addeac8f..6056b67c3a95 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -30,6 +30,44 @@ monitoring and control of fan RPM as well as detection of fan failure.
 Six pins are dedicated tachometer inputs. Any of the six PWM outputs can
 also be configured to serve as tachometer inputs.
 
+About pwm[1-6]_enable
+---------------------
+0 - full-speed
+    The chip doesn't have a specific way to set "full speed", so setting
+    pwm[1-6]_enable to 0 is just "set PWM mode with 255 duty cycle".
+1 - PWM mode
+    Fan speed is controlled by writing a value to pwm[1-6].
+2 - RPM mode
+    Fan speed is controlled by writing a value to fan[1-6]_target.
+
+About fan[1-6]_fault
+--------------------
+In PWM (or full-speed) mode, if the input RPM goes below what is set
+in fan[1-6]_target, fan[1-6]_fault gets set to 1. In other words,
+fan[1-6]_target works as the minimum input RPM before a fan fault goes off.
+
+In RPM mode, fan fault is set when the fan spins "too slowly" (exact
+conditions are in the datasheet). RPM mode depends on four variables:
+    target_speed:        This is set by fan[1-6]_target.
+    speed_range:         This is set automatically when setting target_speed
+                         or manually by fan[1-12]_div.
+    pwm_rate_of_change:  NOT set by the driver.
+    fan_window:          NOT set by the driver.
+
+The last two values are not set by the driver, because there's no generic way to
+compute them. You should set them manually through i2c (in the bootloader for
+example). Check the datasheet for details.
+
+The fan fault value latches, to reset it, set a value to pwm[1-6]
+or fan[1-6]_target.
+
+About fan[1-12]_div
+-------------------
+This value affects the measurable range of the chip. The driver sets this value
+automatically in RPM based on fan[1-6]_target. In PWM mode, you should set this
+value manually based on the details from the datasheet. Setting the speed range
+is disabled while in RPM mode to prevent overwriting the automatically
+calculated value.
 
 Sysfs entries
 -------------
@@ -39,7 +77,8 @@ fan[1-12]_enable   RW  enable fan speed monitoring
 fan[1-12]_input    RO  fan tachometer speed in RPM
 fan[1-12]_fault    RO  fan experienced fault
 fan[1-12]_div      RW  set the measurable speed range, not available in RPM mode
-fan[1-6]_target    RW  desired fan speed in RPM
+fan[1-6]_target    RW  RPM mode = desired fan speed
+                       PWM mode = minimum fan speed until fault
 pwm[1-6]_enable    RW  regulator mode, 0=full speed, 1=manual (pwm) mode, 2=rpm mode
                        setting rpm mode sets fan*_enable to 1
 pwm[1-6]           RW  fan target duty cycle (0-255)
-- 
2.31.1

