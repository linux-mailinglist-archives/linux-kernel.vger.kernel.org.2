Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DD037B38B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 03:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhELBcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:32:21 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:39710 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhELBcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:32:16 -0400
Received: by mail-ed1-f54.google.com with SMTP id g14so25127129edy.6;
        Tue, 11 May 2021 18:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fu9dr07tUrhZL/WE8RSa90SkTQUI7KqZiD+NnVvcBNI=;
        b=EaoJJAnVVq6mIBQd1C40I2iQRLzYXwwot0CkZmkrEv9Uofa+kR2t9FDKcrgg8l6XRj
         Rb1ItU5BV556NUlYJaaG/RTYrgx36A0jnym1rpAenKpdUEAy7A3nySyF1L/Tkbx1oNbb
         cZZRyMxSxI4b1VwzMK1OCHoAyNglePBjuw7TZTc8HPBiv5fO12/T1YxL6ZqRcF27nKrm
         WsiK53lJQZvOyTraU3OoOGkp02MvYkY/rqPQR+OO7nZsTHDbPX8klUbeBB2Bhx7uNtcA
         jJOAk/V7hWp/RZGHO+iTOeqVpEhWWIqjxhJhyantGSAzDQFmkN9Z/meZk3tZZsfkue/G
         Y97A==
X-Gm-Message-State: AOAM532rWdCmltBx3BopSbmQUYrSSCkx0OyyXFp7SXB0lsjyXxWnHa2D
        ajwzWXggDkxkdxOpsAdfwchojNU68Qhzy9VX
X-Google-Smtp-Source: ABdhPJzAdcv0Bb9731uLtmAWjJy47qC/e5oW2m31UeiNPkzIOCOa2RJXFmF94wgb+JQYfKm2KcK1BQ==
X-Received: by 2002:a05:6402:1807:: with SMTP id g7mr39398970edy.335.1620783067881;
        Tue, 11 May 2021 18:31:07 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id o3sm16416033edr.84.2021.05.11.18.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 18:31:07 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Subject: [PATCH v5 5/5] hwmon: (max31790) Update documentation
Date:   Wed, 12 May 2021 03:30:51 +0200
Message-Id: <20210512013052.903297-5-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512013052.903297-1-kubernat@cesnet.cz>
References: <20210512013052.903297-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
index 35afa5f0395a..e70aae9f71a2 100644
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
 pwm[1-6]_enable    RW  regulator mode, 0=no control, sets 0% PWM,
 				       1=manual (pwm) mode,
 				       2=rpm mode
-- 
2.31.1

