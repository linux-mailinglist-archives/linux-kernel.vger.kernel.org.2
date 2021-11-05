Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0091D4462E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 12:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhKELly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 07:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhKELlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 07:41:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC2C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 04:39:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b15so12722475edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCu1OGKsqLNAMoqhoi0VbX309V/fJGalAsnrlUQrsDo=;
        b=nK18Z/dgdQrBhKmeyKlig3x9L7vPl7ZLDAeHI0zJyTScTLby+dsjBb+2YQd2MvtC0Q
         RIi1T8e/DcSqNZ+5JIXTD44SUFqaV9cBOPyoqxQlFI3p2r2gjKJ5DEhLLsUBBwvvTUge
         hkw/WOXU32wsjuaSQtB3dUdNp84iYs0WqQwIRZ+/Tgx5nRZHQNgFQwqc4vOAR96doCKa
         U0KgnKP9qD5+T3ol/GipXpqhIG/yNbnjS1DZvQbUI28IIize6NwC8QSLrkReAdJxT3Re
         FOmBRVEYcFpmWsEZGUOVqK3Tz6ObQmrqSL6Jvx+xqEn8N9trke6eArwoN6BppdWdsgdP
         Uhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCu1OGKsqLNAMoqhoi0VbX309V/fJGalAsnrlUQrsDo=;
        b=qK+OdvX422kZHKB8MNudCvjTB1YkT84LJ5OB6UlVyl4xxWDUpRaTe36MpNIQKwomzw
         OrUnAjZeLTTTHhdcQxtbWn09cbOzVKfxK07UhaexYlXlW2Y9nBb2GaLthHf3yNwrmyYE
         TVmKCYQZ2SCqGu1Gxj0JEWgwF62vamRjYPk6NxEutJWERpuXlQZ19zXJjhAlGVQY/a0v
         VydJNJAJn3MgpNfD72+PnwCSgoCEZKj6NQxMEqYEUgrnxJpyExdCb2Fv9WSdhoyAhYl0
         MKkoKR0dI1KMGy9vgjb7FcLzuBBTagddaIzUXjIBFsrl1u+C2DQ4r/ItIY0J0sBl3mDE
         2rlA==
X-Gm-Message-State: AOAM530EMe5AUPeu692N9UE+jtMStD8qtJlW0VtRv7PTRixbb/FohIl1
        wJFXnJpyODAckzZD8PrWs+Nuww==
X-Google-Smtp-Source: ABdhPJxL10/R+V0yjw2CxsThdHO1q9kKcZIZEGVamhRdxhx74TYuQkgMtFl508VxRQ+ZXXwZE4WSnQ==
X-Received: by 2002:a17:906:5006:: with SMTP id s6mr6425049ejj.258.1636112345662;
        Fri, 05 Nov 2021 04:39:05 -0700 (PDT)
Received: from fedora.. (dh207-99-83.xnet.hr. [88.207.99.83])
        by smtp.googlemail.com with ESMTPSA id bn20sm4011325ejb.5.2021.11.05.04.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 04:39:05 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        michael@walle.cc
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 1/6] mfd: simple-mfd-i2c: Add Delta TN48M CPLD support
Date:   Fri,  5 Nov 2021 12:38:54 +0100
Message-Id: <20211105113859.101868-1-robert.marko@sartura.hr>
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

