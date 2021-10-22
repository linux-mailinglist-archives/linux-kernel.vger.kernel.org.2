Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05FC437A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhJVPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhJVPvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:51:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 158A860C4B;
        Fri, 22 Oct 2021 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634917746;
        bh=nCXsstYKgI+3xhqgniDO8VVojhjUGxDvkuWH892bwXc=;
        h=From:To:Cc:Subject:Date:From;
        b=opQpIyC30qNKCpg6A5Y5g9lqMfcqllm0W2pppRZgX7nJKl1UIs/4l/dPwE+SSChYQ
         qlOrAb4ASWODbEc2ChqWs6Z/bW7R/fsm9X1bGYUQ5M4pN2+eJ0LNUzRXP5XHjB2Jnp
         6Guu7LTNcPJvWSsrEOAqjzABH/TaEYh4fV1wtaswXoPkHPnXPAztGX61/O2M9ZQDk2
         2iVL6bengqmvIuxeGomtoWKu0fIYfu8z5/zUvDvL938oRp+/jrck7fgKtAUlaJdvbY
         p9+JINX8k/OGQZyhLZDafJymUCYbTyV9fb5opl41LmwHUlDHzdyLw3J4aY0++W4uSd
         5TBEZOKZV+dfA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Tim Crawford <tcrawford@system76.com>,
        Jeremy Soller <jeremy@system76.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH] platform/x86: system76_acpi: fix Kconfig dependencies
Date:   Fri, 22 Oct 2021 17:48:40 +0200
Message-Id: <20211022154901.904984-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_INPUT is disabled, this driver now fails to link:

ld.lld: error: undefined symbol: devm_input_allocate_device
>>> referenced by system76_acpi.c
>>>               platform/x86/system76_acpi.o:(system76_add) in archive drivers/built-in.a

ld.lld: error: undefined symbol: input_set_capability
>>> referenced by system76_acpi.c
>>>               platform/x86/system76_acpi.o:(system76_add) in archive drivers/built-in.a

ld.lld: error: undefined symbol: devm_hwmon_device_register_with_info
>>> referenced by system76_acpi.c
>>>               platform/x86/system76_acpi.o:(system76_add) in archive drivers/built-in.a

ld.lld: error: undefined symbol: battery_hook_unregister
>>> referenced by system76_acpi.c
>>>               platform/x86/system76_acpi.o:(system76_remove) in archive drivers/built-in.a

Add Kconfig dependencies for each of these three.

Fixes: 0de30fc684b3 ("platform/x86: system76_acpi: Replace Fn+F2 function for OLED models")
Fixes: 95563d45b5da ("platform/x86: system76_acpi: Report temperature and fan speed")
Fixes: 76f7eba3e0a2 ("platform/x86: system76_acpi: Add battery charging thresholds")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 56bcf80da60a..c422ee785c56 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -923,6 +923,9 @@ config SONYPI_COMPAT
 config SYSTEM76_ACPI
 	tristate "System76 ACPI Driver"
 	depends on ACPI
+	depends on ACPI_BATTERY
+	depends on HWMON
+	depends on INPUT
 	select NEW_LEDS
 	select LEDS_CLASS
 	select LEDS_TRIGGERS
-- 
2.29.2

