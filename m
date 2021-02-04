Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EDB30F224
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhBDL2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235816AbhBDL07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612437932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiI6Yed6LrxwQZJPGd2BX2KpQLU3m22xh0incNm/MUc=;
        b=ULjBjko2jjt2zyif+RueRGJ9cFXyN9zDNXncat2uOdtszZWiZFjjyUjbqG+M5VNViQWthy
        SeNly3VE4UpMTw5O/RlrHZjl/2S067PAPULK8MIN10ePe2Q4h2aNsKT3Qc/XyH467awxKZ
        RfVoQPIiEeVSUOBfVh+jh6NuoH/GH68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-F20GtKySPhKWxiaFfBkDyA-1; Thu, 04 Feb 2021 06:25:30 -0500
X-MC-Unique: F20GtKySPhKWxiaFfBkDyA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9C3B1020C25;
        Thu,  4 Feb 2021 11:25:28 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-112.ams2.redhat.com [10.36.112.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65F375B695;
        Thu,  4 Feb 2021 11:25:26 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 resend 06/13] ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c
Date:   Thu,  4 Feb 2021 12:24:55 +0100
Message-Id: <20210204112502.88362-7-hdegoede@redhat.com>
In-Reply-To: <20210204112502.88362-1-hdegoede@redhat.com>
References: <20210204112502.88362-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jack handling for arizona codecs is being refactored so that it is
done directly by the codec drivers, instead of having an extcon-driver
bind to a separate "arizona-extcon" child-device for this.

drivers/mfd/arizona-core.c has already been updated to no longer
instantiate an "arizona-extcon" child-device for the arizona codecs.

This means that the "arizona-extcon" driver is no longer useful
(there are no longer any devices for it to bind to).

This commit drops the extcon Kconfig / Makefile bits and moves
drivers/extcon/extcon-arizona.c to sound/soc/codecs/arizona-jack.c .

This is a preparation patch for converting the arizona extcon-driver into
a helper library for letting the arizona codec-drivers directly report jack
state through the standard sound/soc/soc-jack.c functions.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
- Add sound/soc/codecs/arizona-jack.c to the WOLFSON MICROELECTRONICS DRIVERS
  MAINTAINERS section

Changes in v3:
- Fold the 2 separate patches to add a copy of extcon-arizona.c as
  sound/soc/codecs/arizona-jack.c and the follow up patch to remove the
  extcon driver into 1 patch simply moving the extcon driver code.
---
 MAINTAINERS                                               | 3 +--
 drivers/extcon/Kconfig                                    | 8 --------
 drivers/extcon/Makefile                                   | 1 -
 .../extcon-arizona.c => sound/soc/codecs/arizona-jack.c   | 0
 4 files changed, 1 insertion(+), 11 deletions(-)
 rename drivers/extcon/extcon-arizona.c => sound/soc/codecs/arizona-jack.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c2416aa254e..5cd8cc63e6b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19258,7 +19258,6 @@ F:	Documentation/devicetree/bindings/sound/wlf,arizona.yaml
 F:	Documentation/hwmon/wm83??.rst
 F:	arch/arm/mach-s3c/mach-crag6410*
 F:	drivers/clk/clk-wm83*.c
-F:	drivers/extcon/extcon-arizona.c
 F:	drivers/gpio/gpio-*wm*.c
 F:	drivers/gpio/gpio-arizona.c
 F:	drivers/hwmon/wm83??-hwmon.c
@@ -19282,7 +19281,7 @@ F:	include/linux/mfd/wm8400*
 F:	include/linux/regulator/arizona*
 F:	include/linux/wm97xx.h
 F:	include/sound/wm????.h
-F:	sound/soc/codecs/arizona.?
+F:	sound/soc/codecs/arizona*
 F:	sound/soc/codecs/cs47l24*
 F:	sound/soc/codecs/wm*
 
diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index af58ebca2bf6..e3db936becfd 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -21,14 +21,6 @@ config EXTCON_ADC_JACK
 	help
 	  Say Y here to enable extcon device driver based on ADC values.
 
-config EXTCON_ARIZONA
-	tristate "Wolfson Arizona EXTCON support"
-	depends on MFD_ARIZONA && INPUT && SND_SOC
-	help
-	  Say Y here to enable support for external accessory detection
-	  with Wolfson Arizona devices. These are audio CODECs with
-	  advanced audio accessory detection support.
-
 config EXTCON_AXP288
 	tristate "X-Power AXP288 EXTCON support"
 	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index fe10a1b7d18b..1b390d934ca9 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -6,7 +6,6 @@
 obj-$(CONFIG_EXTCON)		+= extcon-core.o
 extcon-core-objs		+= extcon.o devres.o
 obj-$(CONFIG_EXTCON_ADC_JACK)	+= extcon-adc-jack.o
-obj-$(CONFIG_EXTCON_ARIZONA)	+= extcon-arizona.o
 obj-$(CONFIG_EXTCON_AXP288)	+= extcon-axp288.o
 obj-$(CONFIG_EXTCON_FSA9480)	+= extcon-fsa9480.o
 obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
diff --git a/drivers/extcon/extcon-arizona.c b/sound/soc/codecs/arizona-jack.c
similarity index 100%
rename from drivers/extcon/extcon-arizona.c
rename to sound/soc/codecs/arizona-jack.c
-- 
2.29.2

