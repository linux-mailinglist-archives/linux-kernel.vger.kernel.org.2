Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34C38E634
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhEXMHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhEXMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:07:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2393C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:05:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so4385157wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vupoXXFVGGxP68p+rVk16msOI4FEaKWl6TGrTzM+/sE=;
        b=Ag1pM4LStX8QGVFfznn4U8xkqj3W9vY0n9DY5CJuxtlFT2yt/cHYP9vzAhrE3co0zR
         x1Iwhz6CF8CSQbJeZpse2cm+ha+HEeQY1E31tovMcsmnZcIbhXRWHL4L6SO2qSP0uaGj
         xAsiH3GXZPz3MN1iDjjcPv6f3o1ffIPcmyXFFlyZgRSR9GGiKzBSZmHUcB8Tk//bCOzD
         A45Y5WLUUsYO67zsvmxgaiLRxXeAJO2jwR3E0uIK1zqPKh4GbJJWyi/a0QyytL0Q8VPL
         e37z956H4a4qwtRP6KsP87w6PG/qHhfdza9TlLUak8je5WZikdWuX7wn1ZW/pPQ4A0lf
         5jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vupoXXFVGGxP68p+rVk16msOI4FEaKWl6TGrTzM+/sE=;
        b=aNfpZh1laZn8tgmIskKEyRsA7SLgl/TcMLASi4yQYXkuglZ49+bhyZxFv5/DGdOemK
         5idIxPg8eVQ+wHDwSr8rcDNXAxd/qzMmziZCQVaxuMa9fBMhBSqA7O+zVKYZCkTUBgb9
         vOq2xqDjC2a0EhYmjTkT/xB/SWNhWzmJslBCkB1wpyyRx1FuNX+96Qg/Wyiq8c2qJ0pj
         x6+oSNg0zn5yiFodgzl1mo33vzmmvc/zrBEX+EcNjygy4qr9qoSaucFfCqZLo4IgnI6Q
         zHJV8EShXZFrV/CHFD+YG+UYgTq3OemtBi1Iy3BNanIvOc+qU6Uz/GeHqhDB4/39EER4
         TXgg==
X-Gm-Message-State: AOAM53352VjZpHyGsV6JL9PU0gbeY04w9Ly2nzAvW++xqILZ+Kxujx77
        6Z11L+Ei36q2GfkpWPGKxqxDhQ==
X-Google-Smtp-Source: ABdhPJy0FdiN1uxAQlj8gKVgakH2g+fVy09MLmYddnv3AT9gmfel4PWdCbeqJ6fp87avQbWglhPTdQ==
X-Received: by 2002:a1c:f303:: with SMTP id q3mr19903841wmq.9.1621857945250;
        Mon, 24 May 2021 05:05:45 -0700 (PDT)
Received: from localhost.localdomain ([188.252.220.224])
        by smtp.googlemail.com with ESMTPSA id b10sm14342856wrr.27.2021.05.24.05.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 05:05:44 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/4] mfd: simple-mfd-i2c: Add Delta TN48M CPLD support
Date:   Mon, 24 May 2021 14:05:36 +0200
Message-Id: <20210524120539.3267145-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
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
---
Changes in v2:
* Drop the custom MFD driver and header
* Use simple I2C MFD driver

 drivers/mfd/Kconfig          | 10 ++++++++++
 drivers/mfd/simple-mfd-i2c.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5c7f2b100191..1042424c5678 100644
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
+	  CPLD. It consists of MFD and GPIO drivers. CPLD provides GPIOS-s
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
2.31.1

