Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442E344342A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhKBQ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbhKBQ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:59:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA34C061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:57:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g10so8379edj.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCu1OGKsqLNAMoqhoi0VbX309V/fJGalAsnrlUQrsDo=;
        b=jhu6aCoeAMLlRocldjYOcix0kXuZl4gF71djpFefPdNOQGs30if/nnpDdlta5lT1tK
         zA4ndWgiL7ifZJNHiMTU8lS3fqxHSZVeWUdYATfxTKNZMY7yJTyorp7FCYwkJAICszxB
         aBh3pZLPuD4FI4gO8tPbzWMkbcRo0Ao3EMD36Lt+G8wk9EmRpJ2MshD3T8c/9BcTBZzA
         WbrXYBvSWfIId4REndbN+/IWwa8P9+BhBB6kEnwzkmmmFjMiNaKTOKU5TCCzqi1oXkns
         YbMD7HmFic111lZjl8nMX0xSyj9Rloq2sIZfaWIGYWiHqPtvjz08pOJU1ModxmApv/dV
         oxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCu1OGKsqLNAMoqhoi0VbX309V/fJGalAsnrlUQrsDo=;
        b=NlwmvqeIBHKnozqNj/Kz1UL3yGogT9Y403uehi5tUUIKReYrehG74ExMS05WkLY+Hm
         Yt3s6pTM8gEhZB3CI225Krl8jNWgV/ZxfwFrLesTko7BBEmCtRIrBX/6GwTWNOrnOY3Z
         wFz9PiM0Gq8OUO45DouowBeaa1FBUMV00FcujvIL3WeKu65S8enymz89hPaJaHBOxfa7
         wDmv7JdX6SxpTvPpuWfmhnXbFEZFOfgkAL/63mCHKPIk/+QpgKGuV0+6/NGRJWWOXYGy
         zFvPPDxpzPH/shGsWTUoUO53v74ArhbA1DmN0cqVSiaR3js+uvBy9idnZG/Dh8pQbL0Z
         7H6A==
X-Gm-Message-State: AOAM532HsJ1rOgVwAgkOP+wzRSIc8B7u/M9xwaFF08oFq4Xcq7LbJPrP
        agap9fmkw/eHDnCtZK/M8aa5DA==
X-Google-Smtp-Source: ABdhPJzTosDjNnPa+McFAm74Eaoj7BA3wjXHP3B/EHUfYt66n/QukfZLd9zrH9DUO8kLXNhJ9WyyYA==
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr46861059ejc.555.1635872224732;
        Tue, 02 Nov 2021 09:57:04 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-144-183-cbl.xnet.hr. [94.253.144.183])
        by smtp.googlemail.com with ESMTPSA id i22sm10816297edu.93.2021.11.02.09.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:57:04 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        andy.shevchenko@gmail.com
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v7 1/6] mfd: simple-mfd-i2c: Add Delta TN48M CPLD support
Date:   Tue,  2 Nov 2021 17:56:52 +0100
Message-Id: <20211102165657.3428995-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delta TN48M switches have a Lattice CPLD that serves
multiple purposes including being a GPIO expander.

So, lets use the simple I2C MFD driver to provide the MFD core.

Also add a virtual symbol which pulls in the simple-mfd-i2c driver and
provide a common symbol on which the subdevice drivers can depend on.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v2:
* Drop the custom MFD driver and header
* Use simple I2C MFD driver
---
 drivers/mfd/Kconfig          | 10 ++++++++++
 drivers/mfd/simple-mfd-i2c.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ad15be6b86bc..3701657e831d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -297,6 +297,16 @@ config MFD_ASIC3
 	  This driver supports the ASIC3 multifunction chip found on many
 	  PDAs (mainly iPAQ and HTC based ones)
 
+config MFD_TN48M_CPLD
+	tristate "Delta Networks TN48M switch CPLD driver"
+	depends on I2C
+	select MFD_SIMPLE_MFD_I2C
+	help
+	  Select this option to enable support for Delta Networks TN48M switch
+	  CPLD. It consists of reset and GPIO drivers. CPLD provides GPIOS-s
+	  for the SFP slots as well as power supply related information.
+	  SFP support depends on the GPIO driver being selected.
+
 config PMIC_DA903X
 	bool "Dialog Semiconductor DA9030/DA9034 PMIC Support"
 	depends on I2C=y
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 87f684cff9a1..af8e91781417 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -39,6 +39,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
+	{ .compatible = "delta,tn48m-cpld" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
-- 
2.33.1

