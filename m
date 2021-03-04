Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADD532D16A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbhCDLBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:01:24 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33347 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbhCDLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:00:54 -0500
Received: by mail-wr1-f46.google.com with SMTP id 7so27146762wrz.0;
        Thu, 04 Mar 2021 03:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlACR9GlcEGYi0JxxJSxFKSxWtcSncE/VZbbXtmns9I=;
        b=jAbdWMq1IkDGwFYDcQSK5qKDbLNbrklgoblo0H0u0AyVUWea2ykOoDzOAMpNMFTPRf
         oUzQzDbUb3iFuZ7SOtKwoZUiw2d1L9ahsoLMuIO5Grm8uedO18OykXCW45De0ovfttq/
         cKctxA7YHAjBvJRpO3W6dgQjAzVufVLvnUME+EAkuW9OvMY2g/mK87Fv2DK5FiqRG+CB
         712gn7mwSUlELO3da7LAdOxo0wTwv6MZRCOustMtWhmMNA+tza4CKiI4MEq2pm1wQuK+
         PY5SuLqUwwPCAIzgfMX5z1ZfItRloH0Y98UsnRAx4VaTXCvbTx58us6it5iWDic0ItAR
         fu0g==
X-Gm-Message-State: AOAM531lU3VwJvDmMSagmeWG4IbsZxYIjLCorkzR2/TRxG6hWCEkkwRy
        vxPyfEI4aE5lshTL6/CD944=
X-Google-Smtp-Source: ABdhPJzIRAAXqglgIm52oOPM4/B5D5LtG5/Wv2XgZurXuQsCbL8a1JNhNXdvJX8XWZMmErAeMxj9mA==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr3364431wrn.394.1614855612414;
        Thu, 04 Mar 2021 03:00:12 -0800 (PST)
Received: from localhost ([2a02:8308:387:c900:a7b5:b859:9449:c07b])
        by smtp.gmail.com with ESMTPSA id x13sm35184151wrt.75.2021.03.04.03.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 03:00:12 -0800 (PST)
From:   =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>
Cc:     =?UTF-8?q?V=C3=A1clav=20Kubern=C3=A1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] hwmon: (max31790) Update documentation
Date:   Thu,  4 Mar 2021 11:58:30 +0100
Message-Id: <20210304105830.507176-7-kubernat@cesnet.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304105830.507176-1-kubernat@cesnet.cz>
References: <20210304105830.507176-1-kubernat@cesnet.cz>
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
testing, we found out that it the pwm_rate_of_change and fan_window
values need to be changed manually by the user, based on the user's
exact fan configuration.

Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
---
 Documentation/hwmon/max31790.rst | 48 +++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index 627816fa45fb..d5ab7caa491a 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -30,6 +30,51 @@ monitoring and control of fan RPM as well as detection of fan failure.
 Six pins are dedicated tachometer inputs. Any of the six PWM outputs can
 also be configured to serve as tachometer inputs.
 
+About pwm[1-6]_enable
+---------------------
+full-speed
+- The chip doesn't have a specific way to set "full speed", so setting pwm[1-6]_enable to 0 is just "set PWM mode with 255 duty cycle".
+
+PWM mode
+- Fan speed is controlled by writing a value to pwm[1-6].
+
+RPM mode
+- Fan speed is controlled by writing a value to fan[1-6]_target.
+
+About fan[1-6]_fault
+--------------------
+In PWM (or full-speed) mode, if the input RPM goes below what is set
+in fan[1-6]_target, fan[1-6]_fault gets set to 1. In other words,
+fan[1-6]_target works as the minimum input RPM before a fan fault goes off.
+
+In RPM mode, fan fault is set when the fan spins "too slowly" (exact
+conditions are in the datasheet). RPM mode depends on four variables:
+
+- target_speed:        This is set by fan[1-6]_target.
+- speed_range:         This is set automatically when setting target_speed or manually by fan[1-12]_div.
+- pwm_rate_of_change:  NOT set by the driver.
+- fan_window:          NOT set by the driver.
+
+The last two values are not set by the driver, because there's no generic way to
+compute them. You should set them manually through i2c (in the bootloader for
+example). Check the datasheet for details. The driver uses `regmap`, so it
+should be easy to read the values of the registers from userspace.
+
+The fan fault value latches. To reset it, set a value to pwm[1-6]
+or fan[1-6]_target.
+
+About fan[1-12]_pulses
+----------------------
+You should set this depending on the fan you use. It affects what values
+are in fan[1-12]_input and also what gets written to fan[1-6]_target.
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
@@ -40,7 +85,8 @@ fan[1-12]_pulses   RW  pulses per fan revolution (default: 2)
 fan[1-12]_input    RO  fan tachometer speed in RPM
 fan[1-12]_fault    RO  fan experienced fault
 fan[1-12]_div      RW  set the measurable speed range, not available in RPM mode
-fan[1-6]_target    RW  desired fan speed in RPM
+fan[1-6]_target    RW  RPM mode = desired fan speed,
+                       PWM mode = minimum fan speed until fault
 pwm[1-6]_enable    RW  regulator mode, 0=full speed, 1=manual (pwm) mode, 2=rpm mode
                        setting rpm mode sets fan*_enable to 1
 pwm[1-6]           RW  fan target duty cycle (0-255)
-- 
2.30.1

