Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C533DBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbhCPR5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:57:43 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:32912 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbhCPR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:56:06 -0400
Received: by mail-ej1-f43.google.com with SMTP id jt13so73712640ejb.0;
        Tue, 16 Mar 2021 10:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vY2V+uyPZYUFi1y4IUX19nPs6rR9J3Tb7jFOivds7Lw=;
        b=S8qm0QlU42Y1FFD7itHAI8uJ8bW9BJIy0KtVm0hl6sgJWqMHLG6AimqOrBFKczYSIg
         jRzQqU7enGZqAdJKaEsqat6TToVR81ZbqYQ4bsT50UsMZDMPJx3Xwy+Su44RdXONNXjw
         mPyolGBenIXWcm8TnZ26yIAEY4uIqfRsnRHlvGIKOgXncfDiFZPQ/uc2jYs3ezP/veeC
         Qno6M/G5HFHcV7lOQr96KAIw/YZb/oiGV+lhctiA7AaqDTuvcpJJ12oxACnFtexsY+Dz
         zOZAne+SKT+z8TECJhNP1Q3q6W49BAIQwAAt+okm0q8/+5zUBaYKn1YwmUKK/FpKkPNr
         o0lQ==
X-Gm-Message-State: AOAM531FWDaFuWX/ppjI4oy6xbeW56qR0jecLf3A2qMO4ES7vbKgscrT
        IBWweVzO6zCarl2Ov+QFs2k=
X-Google-Smtp-Source: ABdhPJyqpgQnFPJPRAW/6JN4+pTj+vJtCDYYBR2exl1eEWr35NhcruFJGLCH7m31sRtC49vNjGGB+g==
X-Received: by 2002:a17:906:d71:: with SMTP id s17mr31847965ejh.126.1615917364950;
        Tue, 16 Mar 2021 10:56:04 -0700 (PDT)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id r19sm10912390edp.52.2021.03.16.10.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 10:56:04 -0700 (PDT)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] hwmon: (max31790) Update documentation
Date:   Tue, 16 Mar 2021 18:55:02 +0100
Message-Id: <20210316175503.1003051-5-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316175503.1003051-1-kubernat@cesnet.cz>
References: <20210316175503.1003051-1-kubernat@cesnet.cz>
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
2.30.2

